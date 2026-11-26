require("gamecore.skill.zbBaseSkill")

zbFenmo_4 = class("zbFenmo_4", zbBaseSkill)
zbFenmo_4.__index = zbFenmo_4

function zbFenmo_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFenmo_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFenmo_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.fenmoSkill4 = arg_2_0
end

function zbFenmo_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_BuffSystem:removeHeroAllDebuff(iter_5_1)
			g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_5_1, arg_3_0)
			g_EffectSystem:createInstantEffect(iter_5_1, 2001)
			g_EffectSystem:createInstantEffect(iter_5_1, 2002)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end

function zbFenmo_4.getDamageRatio(arg_6_0, arg_6_1)
	return 0.1
end
