require("gamecore.skill.zbBaseSkill")

zbXiaobaima_4 = class("zbXiaobaima_4", zbBaseSkill)
zbXiaobaima_4.__index = zbXiaobaima_4

function zbXiaobaima_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaima_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaima_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.skillDurationTime = 0.25
end

function zbXiaobaima_4.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()

		local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
		local var_4_1 = -0.2
		local var_4_2 = -arg_3_0:getDamageAbs()
		local var_4_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero.lastAttacker, var_4_0, var_4_1, var_4_2, var_4_3)
	end

	local function var_3_1()
		arg_3_0.actioning = false
	end

	if arg_3_0.hero.lastAttacker == nil then
		return
	end

	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0

	local var_3_2 = CCArray:create()

	var_3_2:addObject(CCCallFuncN:create(var_3_0))
	var_3_2:addObject(CCDelayTime:create(arg_3_0.skillDurationTime))
	var_3_2:addObject(CCCallFuncN:create(var_3_1))

	local var_3_3 = CCSequence:create(var_3_2)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_3)
end

function zbXiaobaima_4.update(arg_6_0, arg_6_1)
	arg_6_0.accumTime = arg_6_0.accumTime + arg_6_1

	if arg_6_0.accumTime > arg_6_0.skillDurationTime then
		arg_6_0.actioning = false
	end
end
