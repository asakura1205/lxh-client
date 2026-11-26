require("gamecore.skill.zbBaseSkill")

zbLaojun_2 = class("zbLaojun_2", zbBaseSkill)
zbLaojun_2.__index = zbLaojun_2

function zbLaojun_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojun_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojun_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.7
	arg_2_0.attackHitDelayTime = 1
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLaojun_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = arg_3_0.targetList[1].forceType
		local var_5_1 = getCombatHeroPos(var_5_0, 5)

		if g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_0, var_5_1, arg_3_0.skillRecord.targetEffectId, 0) ~= nil then
			-- block empty
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_6_1, arg_3_0)

			local var_6_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
			local var_6_1 = 0.1
			local var_6_2 = 0
			local var_6_3 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_0, var_6_1, var_6_2, var_6_3)
		end

		g_Audio:playSound("audio/sound/cure.mp3")
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	if arg_3_0.hero.laojunSkill4 ~= nil then
		arg_3_0.hero.laojunSkill4:actionEx(var_3_5)
	end

	if arg_3_0.hero.laojunSkill3 ~= nil then
		arg_3_0.hero.laojunSkill3:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.attackHitDelayTime))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.attackHitDelayTime, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbLaojun_2.getDamageRatio(arg_9_0, arg_9_1)
	return 0.7
end
