require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_niuzai_3 = class("zbLuoxiaohei_niuzai_3", zbBaseSkill)
zbLuoxiaohei_niuzai_3.__index = zbLuoxiaohei_niuzai_3

function zbLuoxiaohei_niuzai_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_niuzai_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_niuzai_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL3
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.luoxiaoheiniuzaiSkill3 = arg_2_0
end

function zbLuoxiaohei_niuzai_3.action(arg_3_0)
	if zbCombatFormula:isSucceedRate(250) then
		arg_3_0.hero.energy:addCount()
	end
end

function zbLuoxiaohei_niuzai_3.actionEx(arg_4_0, arg_4_1)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
	end

	local function var_4_1()
		local var_6_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
		local var_6_1 = 0.05 * arg_4_0.hero.energy:getCount()
		local var_6_2 = arg_4_0:getDamageAbs() * arg_4_0.hero.energy:getCount()
		local var_6_3 = 1

		g_BuffSystem:createBuff(arg_4_0.hero, arg_4_0.hero, var_6_0, var_6_1, var_6_2, var_6_3)
	end

	if arg_4_0.hero.energy:getCount() < 1 then
		return
	end

	arg_4_1:addObject(CCCallFuncN:create(var_4_0))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.skillDurationTime - arg_4_0.hitFrame))
end
