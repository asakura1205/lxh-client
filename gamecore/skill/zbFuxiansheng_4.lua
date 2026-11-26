require("gamecore.skill.zbBaseSkill")

zbFuxiansheng_4 = class("zbFuxiansheng_4", zbBaseSkill)
zbFuxiansheng_4.__index = zbFuxiansheng_4

function zbFuxiansheng_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFuxiansheng_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFuxiansheng_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbFuxiansheng_4.action(arg_3_0)
	arg_3_0.hero.fanTanRate = 0.2
	arg_3_0.hero.fanTanPercent = 0.5
	arg_3_0.hero.fanTanAbs = arg_3_0:getDamageAbs()
	arg_3_0.hero.fanTanControlBuffId = BUFF_TYPE_CONTROL_ZHONGSHANG

	arg_3_0:popupSkillBubble()
end
