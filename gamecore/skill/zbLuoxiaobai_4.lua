require("gamecore.skill.zbBaseSkill")

zbLuoxiaobai_4 = class("zbLuoxiaobai_4", zbBaseSkill)
zbLuoxiaobai_4.__index = zbLuoxiaobai_4

function zbLuoxiaobai_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaobai_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaobai_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.EnemyDied
	arg_2_0.hitFrame = 0.5333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaobai_4.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()

		if arg_3_0.hero:numberOfRunningActions() == 0 then
			arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		end
	end

	local function var_3_1()
		arg_3_0.hero:addMp(10)
		g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.MpUp, 0, 0, 1)

		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
		local var_5_1 = 0.5
		local var_5_2 = arg_3_0:getDamageAbs()
		local var_5_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3, 1)
	end

	var_3_0()
	var_3_1()
end
