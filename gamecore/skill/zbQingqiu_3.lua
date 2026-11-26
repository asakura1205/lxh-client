require("gamecore.skill.zbBaseSkill")

zbQingqiu_3 = class("zbQingqiu_3", zbBaseSkill)
zbQingqiu_3.__index = zbQingqiu_3

function zbQingqiu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQingqiu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQingqiu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.qingqiuSkill3 = arg_2_0
end

function zbQingqiu_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = table.getn(g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true))

		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_1 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
			local var_5_2 = var_5_0 * 0.07
			local var_5_3 = var_5_0 * arg_3_0:getDamageAbs()
			local var_5_4 = 1

			g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_1, var_5_2, var_5_3, var_5_4)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
