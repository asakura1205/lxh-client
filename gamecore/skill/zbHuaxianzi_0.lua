require("gamecore.skill.zbBaseSkill")

zbHuaxianzi_0 = class("zbHuaxianzi_0", zbBaseSkill)
zbHuaxianzi_0.__index = zbHuaxianzi_0

function zbHuaxianzi_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuaxianzi_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuaxianzi_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.8
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
end

function zbHuaxianzi_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
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

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.huaxianziSkill3 ~= nil then
		arg_3_0.hero.huaxianziSkill3:actionEx(var_3_4)
	end

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.huaxianziSkill4 ~= nil then
		arg_3_0.hero.huaxianziSkill4:actionEx(var_3_4)
	end

	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end

function zbHuaxianzi_0.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbHuaxianzi_0.hited(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 > 0 and zbCombatFormula:isSucceedRate(300) then
		local var_9_0 = BUFF_TYPE_PROPERTY_HP_ZHONGDU
		local var_9_1 = -arg_9_0.hero.physicAttack * 0.25
		local var_9_2 = 0
		local var_9_3 = 2

		g_BuffSystem:createBuff(arg_9_0.hero, arg_9_1, var_9_0, var_9_1, var_9_2, var_9_3)
	end

	if arg_9_0.actioning then
		arg_9_0.actioning = false
	end
end

function zbHuaxianzi_0.getDamageRatio(arg_10_0, arg_10_1)
	return 1
end
