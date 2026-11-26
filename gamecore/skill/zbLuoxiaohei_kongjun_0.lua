require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_kongjun_0 = class("zbLuoxiaohei_kongjun_0", zbBaseSkill)
zbLuoxiaohei_kongjun_0.__index = zbLuoxiaohei_kongjun_0

function zbLuoxiaohei_kongjun_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_kongjun_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_kongjun_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.0333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
end

function zbLuoxiaohei_kongjun_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_5_1, arg_3_0)
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = CCArray:create()

	if arg_3_0:isQteRedoing() == false then
		if arg_3_0.hero.lxhkjSkill3 ~= nil then
			arg_3_0.hero.lxhkjSkill3:actionEx(var_3_4)
		end

		if arg_3_0.hero.lxhkjSkill4 ~= nil then
			arg_3_0.hero.lxhkjSkill4:actionEx(var_3_4)
		end
	end

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end

function zbLuoxiaohei_kongjun_0.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbLuoxiaohei_kongjun_0.hited(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 > 0 and arg_9_0:isQteRedoing() == false then
		if zbCombatFormula:isSucceedRate(200) then
			g_BuffSystem:createControlBuff(arg_9_0.hero, arg_9_1, BUFF_TYPE_CONTROL_HUNMI)
		end

		arg_9_0.hero.energy:addCount()
	end

	if arg_9_0.actioning then
		arg_9_0.actioning = false
	end
end

function zbLuoxiaohei_kongjun_0.getDamageRatio(arg_10_0, arg_10_1)
	return 0.8
end
