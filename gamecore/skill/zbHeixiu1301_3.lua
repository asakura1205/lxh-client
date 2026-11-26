require("gamecore.skill.zbBaseSkill")

zbHeixiu1301_3 = class("zbHeixiu1301_3", zbBaseSkill)
zbHeixiu1301_3.__index = zbHeixiu1301_3

function zbHeixiu1301_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeixiu1301_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHeixiu1301_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.2
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbHeixiu1301_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()

		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
		local var_5_1 = 0.2
		local var_5_2 = arg_3_0:getDamageAbs()
		local var_5_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3, 0.5)
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	if zbCombatFormula:isSucceedRate(300) and arg_3_0.hero:numberOfRunningActions() > 0 then
		var_3_1()

		arg_3_0.actioning = false

		return
	end

	arg_3_0.actioning = true

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end
