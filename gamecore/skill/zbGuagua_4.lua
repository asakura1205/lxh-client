require("gamecore.skill.zbBaseSkill")

zbGuagua_4 = class("zbGuagua_4", zbBaseSkill)
zbGuagua_4.__index = zbGuagua_4

function zbGuagua_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGuagua_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGuagua_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.guaguaSkill4 = arg_2_0
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbGuagua_4.actionEx(arg_3_0, arg_3_1)
	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = BUFF_TYPE_PROPERTY_DODGE
		local var_4_1 = arg_3_0.hero.baseDodge * 0.4 + arg_3_0:getDamageAbs()
		local var_4_2 = 0
		local var_4_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_4_0, var_4_1, var_4_2, var_4_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.skillDurationTime - arg_3_0.hitFrame))
end
