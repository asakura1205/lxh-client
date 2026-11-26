require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_moli_3 = class("zbLuoxiaohei_moli_3", zbBaseSkill)
zbLuoxiaohei_moli_3.__index = zbLuoxiaohei_moli_3

function zbLuoxiaohei_moli_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_moli_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_moli_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.lxhMoliSkill3 = arg_2_0
end

function zbLuoxiaohei_moli_3.action(arg_3_0)
	return
end

function zbLuoxiaohei_moli_3.actionEx(arg_4_0, arg_4_1)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_1()
		for iter_6_0, iter_6_1 in pairs(arg_4_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_6_1, arg_4_0.skillRecord.targetEffectId)

			local var_6_0 = BUFF_TYPE_MISC_QINYIN
			local var_6_1 = arg_4_0.hero.magicAttack * 0.1 + arg_4_0:getDamageAbs(iter_6_1)
			local var_6_2 = 0
			local var_6_3 = 3

			g_BuffSystem:createBuff(arg_4_0.hero, iter_6_1, var_6_0, var_6_1, var_6_2, var_6_3)
		end
	end

	local function var_4_2()
		arg_4_0:enterIdle()
	end

	local function var_4_3()
		arg_4_0.actioning = false
	end

	arg_4_0.actioning = true
	arg_4_0.targetList = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

	if table.getn(arg_4_0.targetList) == 0 then
		arg_4_0.actioning = false

		return
	end

	arg_4_1:addObject(CCCallFuncN:create(var_4_0))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame, 0.1)))
end
