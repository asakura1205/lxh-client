require("gamecore.skill.zbBaseSkill")

zbBaoxiannan_2 = class("zbBaoxiannan_2", zbBaseSkill)
zbBaoxiannan_2.__index = zbBaoxiannan_2

function zbBaoxiannan_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaoxiannan_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaoxiannan_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.missilePathType = EPathType.Bezier
	arg_2_0.hitFrame = 0.5
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.skill4Enable = false
end

function zbBaoxiannan_2.action(arg_3_0)
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

	arg_3_0.skill4Enable = false

	if arg_3_0.hero.bxnHero4 ~= nil and zbCombatFormula:isSucceedRate(300) then
		arg_3_0.skill4Enable = true
	end
end

function zbBaoxiannan_2.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbBaoxiannan_2.hited(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0.skill4Enable and arg_9_3 > 0 then
		arg_9_0.hero.bxnHero4:popupSkillBubble()
		arg_9_1:addMp(-20)
		g_CombatBubble:showBubble(arg_9_1, ECombatBubble.MpDown, 0, 0, 1)
	end

	if arg_9_0.actioning then
		arg_9_0.actioning = false
	end
end

function zbBaoxiannan_2.getDamageRatio(arg_10_0, arg_10_1)
	local var_10_0 = 1.5

	if arg_10_0.skill4Enable then
		var_10_0 = var_10_0 + arg_10_0.hero.bxnHero4:getDamageRatio(arg_10_1)
	end

	return var_10_0
end

function zbBaoxiannan_2.getDamageAbs(arg_11_0)
	local var_11_0 = arg_11_0:getDamageAbsBase()

	if arg_11_0.skill4Enable then
		var_11_0 = var_11_0 + arg_11_0.hero.bxnHero4:getDamageAbs()
	end

	return var_11_0
end
