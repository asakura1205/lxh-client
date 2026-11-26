require("gamecore.zbTargetHandler")

zbBaseSkill = class("zbBaseSkill")
zbBaseSkill.__index = zbBaseSkill

function zbBaseSkill.initBase(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hero = arg_1_1
	arg_1_0.skillId = arg_1_2
	arg_1_0.skillRecord = zbHeroSkillTable:getRecord(arg_1_2)

	if arg_1_0.skillRecord.id == -1 then
		echo("invalid skill: attacker=" .. arg_1_1.heroRecord.name .. ", skillId=" .. arg_1_2)
	end

	arg_1_0.skillSeqIndex = arg_1_0.skillId - math.floor(arg_1_0.skillId / 10) * 10

	if arg_1_0.skillSeqIndex == 0 then
		arg_1_0.sequenceName = ANIMATION_SEQUENCE_PHYATTACK
	elseif arg_1_0.skillSeqIndex == 1 then
		arg_1_0.sequenceName = ANIMATION_SEQUENCE_SKILL1
	elseif arg_1_0.skillSeqIndex == 2 then
		arg_1_0.sequenceName = ANIMATION_SEQUENCE_SKILL2
	elseif arg_1_0.skillSeqIndex == 3 then
		arg_1_0.sequenceName = ANIMATION_SEQUENCE_SKILL3
	elseif arg_1_0.skillSeqIndex == 4 then
		arg_1_0.sequenceName = ANIMATION_SEQUENCE_SKILL4
	else
		echo("22222222222222f6666666666666666666666666: " .. arg_1_0.skillSeqIndex)

		arg_1_0.sequenceName = ""
	end

	arg_1_0.sideType = -1
	arg_1_0.targetType = -1
	arg_1_0.subTargetType = -1
	arg_1_0.hitedTargetList = {}
	arg_1_0.actioning = false
	arg_1_0.hitBubbleCount = 1
	arg_1_0.hitBubbleInterval = 0.125
	arg_1_0.damageSectionCount = 1
	arg_1_0.thisRoundHitCount = 0
	arg_1_0.isPassiveSkill = arg_1_0.skillSeqIndex == 3 or arg_1_0.skillSeqIndex == 4
	arg_1_0.isPassiveOnlyOnce = true
	arg_1_0.passiveTriggerType = EPassiveTriggerType.Unknown
	arg_1_0.isBigSkill = false
	arg_1_0.hitFrame = 0
	arg_1_0.skillDurationTime = 0
	arg_1_0.missilePathType = EPathType.Line
	arg_1_0.accumTime = 0
	arg_1_0.lastBeginTime = -1
	arg_1_0.hitTargeted = false
	arg_1_0.needShake = arg_1_0.skillSeqIndex == 1
	arg_1_0.isQteRedo = false
end

function zbBaseSkill.getLevel(arg_2_0)
	return arg_2_0.hero:getSkillLevel(arg_2_0.skillId)
end

function zbBaseSkill.getDamagePercent(arg_3_0, arg_3_1)
	return arg_3_0:getDamageRatio(arg_3_1)
end

function zbBaseSkill.getDamageRatio(arg_4_0, arg_4_1)
	return 1
end

function zbBaseSkill.getDamageAbs(arg_5_0, arg_5_1)
	return arg_5_0:getDamageAbsBase()
end

function zbBaseSkill.getDamageAbsBase(arg_6_0)
	return (arg_6_0.skillRecord.skillBase + arg_6_0.skillRecord.skillGrowth * arg_6_0:getLevel()) * math.floor(0.2 * arg_6_0:getLevel() + 1.8) * 0.5
end

function zbBaseSkill.getReduceHitCount(arg_7_0)
	return arg_7_0.damageSectionCount
end

function zbBaseSkill.getSideType(arg_8_0)
	if arg_8_0.hero:isMeihuo() then
		if arg_8_0.sideType == ESideType.Self and arg_8_0.targetType == ETargetType.Self then
			return arg_8_0.sideType
		elseif arg_8_0.sideType == ESideType.Self then
			return ESideType.Enemy
		elseif arg_8_0.sideType == ESideType.Enemy then
			return ESideType.Self
		end
	end

	return arg_8_0.sideType
end

function zbBaseSkill.getTargetType(arg_9_0)
	return arg_9_0.targetType
end

function zbBaseSkill.getSubTargetType(arg_10_0)
	return arg_10_0.subTargetType
end

function zbBaseSkill.isDamageSkill(arg_11_0)
	return arg_11_0.sideType == ESideType.Enemy
end

function zbBaseSkill.isActioning(arg_12_0)
	if arg_12_0.actioning then
		if arg_12_0.lastBeginTime == -1 then
			arg_12_0.lastBeginTime = os_timenow()
		end

		if os_timenow() - arg_12_0.lastBeginTime >= 5 then
			arg_12_0.actioning = false
		end
	end

	return arg_12_0.actioning
end

function zbBaseSkill.immediatelyEnd(arg_13_0)
	arg_13_0.hero:setMovingFlag(false)

	arg_13_0.actioning = false
end

function zbBaseSkill.execSkill(arg_14_0, arg_14_1)
	if arg_14_1 ~= nil and arg_14_1 == true then
		arg_14_0.isQteRedo = true
	else
		arg_14_0.isQteRedo = false
	end

	arg_14_0.lastBeginTime = os_timenow()
	arg_14_0.hitTargeted = false
	arg_14_0.hitedTargetList = {}
	arg_14_0.thisRoundHitCount = 0

	arg_14_0:action()
end

function zbBaseSkill.isQteRedoing(arg_15_0)
	return arg_15_0.isQteRedo
end

function zbBaseSkill.popupSkillBubble(arg_16_0, arg_16_1)
	if arg_16_0.skillSeqIndex == 2 or arg_16_0.skillSeqIndex == 3 or arg_16_0.skillSeqIndex == 4 then
		arg_16_0.hero:popupPassiveSkillBubble(arg_16_0, arg_16_1)
	end
end

function zbBaseSkill.enterIdle(arg_17_0)
	arg_17_0.hero.anim:setAnimation(arg_17_0.hero:getIdleWeakSequence(), true)
	arg_17_0.hero:setMovingFlag(false)
	arg_17_0:checkHitedTargetPassiveSkill()
end

function zbBaseSkill.checkHitedTargetPassiveSkill(arg_18_0)
	if arg_18_0:isQteRedoing() then
		return
	end

	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return
	end

	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_0.hitedTargetList) do
		if iter_18_1:isDie() == false then
			iter_18_1:execPassiveSkill(EPassiveTriggerType.Beattacked)

			if iter_18_1:isQinyin() then
				iter_18_1:addHp(iter_18_1.qinyinCureValue, false, 1)
				g_EffectSystem:createInstantEffect(iter_18_1, 2001)
				g_EffectSystem:createInstantEffect(iter_18_1, 2002)
				iter_18_1:setQinyin(false, 0)
				g_BuffSystem:removeHeroBuffById(iter_18_1, BUFF_TYPE_MISC_QINYIN)
			end
		else
			iter_18_1:execPassiveSkill(EPassiveTriggerType.DeathAttack)
		end

		var_18_0 = true
	end

	if var_18_0 then
		arg_18_0.hitedTargetList = {}
	end
end

function zbBaseSkill.addHitedTarget(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.hitedTargetList) do
		if iter_19_1:isSame(arg_19_1) then
			return
		end
	end

	table.insert(arg_19_0.hitedTargetList, arg_19_1)
end

function zbBaseSkill.update(arg_20_0, arg_20_1)
	return
end

function zbBaseSkill.isNeedShake(arg_21_0)
	return arg_21_0.needShake
end

function zbBaseSkill.playBigSkillScreenAnim(arg_22_0, arg_22_1)
	if arg_22_0.hero.forceType == ForceType.Left or g_CombatSystem:isPvPCombatType() or g_FirstCombat:isActive() then
		arg_22_1:addObject(CCCallFuncN:create(function()
			arg_22_0:playScreenAnim()
		end))
		arg_22_1:addObject(CCDelayTime:create(FX_DAZHAO_SCREEN_DURATION))
	else
		arg_22_1:addObject(CCCallFuncN:create(function()
			arg_22_0:playDarkAnim()
		end))
	end
end

function zbBaseSkill.playScreenAnim(arg_25_0)
	g_DarkNode:showDarkNode(arg_25_0.hero)
	g_CombatSystem:pauseExclude(arg_25_0.hero)
	g_EffectSystem:createDazhaoScreenEffect(arg_25_0.hero)
	arg_25_0.hero.anim:stopAllActions()

	local var_25_0 = zbAvatarTable:getAvatarSoundPath(arg_25_0.hero.avatarRecord.parentAvatarId, ESoundType.E_BIGSKILL)

	if var_25_0 ~= nil and var_25_0 ~= "" then
		g_Audio:playSound(var_25_0)
	end
end

function zbBaseSkill.playDarkAnim(arg_26_0)
	g_DarkNode:showDarkNode(arg_26_0.hero)
	g_CombatSystem:pauseExclude(arg_26_0.hero)
end
