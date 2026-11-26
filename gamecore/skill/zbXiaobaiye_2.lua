require("gamecore.skill.zbBaseSkill")

zbXiaobaiye_2 = class("zbXiaobaiye_2", zbBaseSkill)
zbXiaobaiye_2.__index = zbXiaobaiye_2

function zbXiaobaiye_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiye_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiye_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.accumTime = 0
	arg_2_0.hitFrame = 1
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbXiaobaiye_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = getFlipForceType(arg_3_0.hero.forceType)
		local var_5_1 = getFormationRowCenterPos(var_5_0, 5)
		local var_5_2 = ccp(arg_3_0.hero:getPosition())
		local var_5_3 = ccp(var_5_1.x, var_5_1.y)
		local var_5_4, var_5_5 = zbEffectTable:getEffectPosOffset(arg_3_0.skillRecord.targetEffectId, var_5_0)

		var_5_2.x = var_5_2.x + var_5_4
		var_5_2.y = var_5_2.y + var_5_5

		g_EffectSystem:createMissileEffectPos(arg_3_0.hero, arg_3_0, EPathType.Bezier, var_5_2, var_5_1, var_5_3, arg_3_0.skillRecord.flyEffectId, arg_3_0.skillRecord.targetEffectId)
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

	if arg_3_0.hero.xiaobaiyeSkill3 ~= nil then
		arg_3_0.hero.xiaobaiyeSkill3:actionEx(var_3_4)
	end

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end

function zbXiaobaiye_2.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbXiaobaiye_2.hitTarget(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.targetList) do
		local var_9_0, var_9_1, var_9_2 = g_CombatFormula:calcDamage(arg_9_0.hero, iter_9_1, arg_9_0)

		if var_9_1 > 0 then
			iter_9_1:playBehitAnimation(arg_9_0.skillRecord.hitEffectId, arg_9_0)
		end
	end
end

function zbXiaobaiye_2.hitEnd(arg_10_0)
	arg_10_0.actioning = false
end

function zbXiaobaiye_2.getDamageRatio(arg_11_0, arg_11_1)
	return 0.7
end
