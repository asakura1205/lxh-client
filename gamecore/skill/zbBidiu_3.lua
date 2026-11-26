require("gamecore.skill.zbBaseSkill")

zbBidiu_3 = class("zbBidiu_3", zbBaseSkill)
zbBidiu_3.__index = zbBidiu_3

function zbBidiu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBidiu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBidiu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_PICKUP
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)

	arg_2_0.hero:addPMReduceRate(0.3)
	arg_2_0.hero:addPMReduce(arg_2_0:getDamageAbs())

	arg_2_0.hero.pmReduceSkill = arg_2_0
end

function zbBidiu_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		local var_5_0 = g_CombatSystem:getHeros(arg_3_0.hero.forceType, true)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			iter_5_1:addMp(10)
			g_CombatBubble:showBubble(iter_5_1, ECombatBubble.MpUp, 0, 0, 1)
		end
	end

	local function var_3_2()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true

	local var_3_3 = CCArray:create()

	var_3_3:addObject(CCCallFuncN:create(var_3_0))
	var_3_3:addObject(CCDelayTime:create(arg_3_0.skillDurationTime / 2))
	var_3_3:addObject(CCCallFuncN:create(var_3_1))
	var_3_3:addObject(CCDelayTime:create(arg_3_0.skillDurationTime / 2))
	var_3_3:addObject(CCCallFuncN:create(var_3_2))

	local var_3_4 = CCSequence:create(var_3_3)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_4)
end
