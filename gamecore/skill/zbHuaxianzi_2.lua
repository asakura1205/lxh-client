require("gamecore.skill.zbBaseSkill")

zbHuaxianzi_2 = class("zbHuaxianzi_2", zbBaseSkill)
zbHuaxianzi_2.__index = zbHuaxianzi_2

function zbHuaxianzi_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuaxianzi_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuaxianzi_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0.3333333333333333
	arg_2_0.hitFrame = 1.1666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbHuaxianzi_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_UseHuaxianziShield = true

			local var_6_0 = BUFF_TYPE_SHIELD_ROUNDREDUCE
			local var_6_1 = 0.19
			local var_6_2 = arg_3_0:getDamageAbs()
			local var_6_3 = 1

			g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_0, var_6_1, var_6_2, var_6_3)

			g_UseHuaxianziShield = false
		end
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

	if arg_3_0.hero.huaxianziSkill3 ~= nil then
		arg_3_0.hero.huaxianziSkill3:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.targetFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))

	if arg_3_0.hero.huaxianziSkill4 ~= nil then
		arg_3_0.hero.huaxianziSkill4:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbHuaxianzi_2.getDamageRatio(arg_9_0, arg_9_1)
	return 1
end
