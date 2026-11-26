require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_niuzai_1 = class("zbLuoxiaohei_niuzai_1", zbBaseSkill)
zbLuoxiaohei_niuzai_1.__index = zbLuoxiaohei_niuzai_1

function zbLuoxiaohei_niuzai_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_niuzai_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_niuzai_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.3333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.curCount = 0
end

function zbLuoxiaohei_niuzai_1.action(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_6_1, arg_3_0)
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0

	if arg_3_1 ~= nil and arg_3_1 == true then
		arg_3_0.curCount = 2
	else
		arg_3_0.curCount = 1
	end

	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_5)
	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbLuoxiaohei_niuzai_1.update(arg_9_0, arg_9_1)
	arg_9_0.accumTime = arg_9_0.accumTime + arg_9_1

	if arg_9_0.accumTime > 5 then
		arg_9_0.actioning = false
	end
end

function zbLuoxiaohei_niuzai_1.hited(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 and arg_10_0.curCount == 1 then
		arg_10_0:action(true)

		return
	end

	arg_10_0.actioning = false

	arg_10_0.hero.energy:clearCount()
end

function zbLuoxiaohei_niuzai_1.getDamageRatio(arg_11_0, arg_11_1)
	return 2 + 0.1 * arg_11_0.hero.energy:getCount()
end

function zbLuoxiaohei_niuzai_1.getDamageAbs(arg_12_0, arg_12_1)
	return arg_12_0:getDamageAbsBase() * (1 + 0.1 * arg_12_0.hero.energy:getCount())
end
