require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_bangqiu_3 = class("zbLuoxiaohei_bangqiu_3", zbBaseSkill)
zbLuoxiaohei_bangqiu_3.__index = zbLuoxiaohei_bangqiu_3

function zbLuoxiaohei_bangqiu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_bangqiu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_bangqiu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.7
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.lxhbqSkill3 = arg_2_0
end

function zbLuoxiaohei_bangqiu_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		if arg_3_0.hero:getHpPercent() > 50 then
			local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
			local var_5_1 = 0.2
			local var_5_2 = arg_3_0:getDamageAbs()
			local var_5_3 = 1

			g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3)
		else
			local var_5_4 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC
			local var_5_5 = 0.2
			local var_5_6 = arg_3_0:getDamageAbs()
			local var_5_7 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_4, var_5_5, var_5_6, var_5_7)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
