require("gamecore.skill.zbBaseSkill")

zbXiaobaiye_1 = class("zbXiaobaiye_1", zbBaseSkill)
zbXiaobaiye_1.__index = zbXiaobaiye_1

function zbXiaobaiye_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiye_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiye_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.0666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbXiaobaiye_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.hero.forceType
		local var_6_1 = getFormationRowCenterPos(var_6_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_6_0, var_6_1, arg_3_0.skillRecord.targetEffectId, 0)
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			iter_7_1:resume()
			g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_7_1, arg_3_0)
			g_EffectSystem:createInstantEffect(iter_7_1, arg_3_0.skillRecord.hitEffectId)
		end
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))

	local var_3_7 = 0
	local var_3_8 = 0.8333333333333334

	var_3_6:addObject(CCDelayTime:create(var_3_8))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))

	local var_3_9 = var_3_7 + var_3_8
	local var_3_10 = math.max(arg_3_0.hitFrame - var_3_9, 0.01)

	var_3_6:addObject(CCDelayTime:create(var_3_10))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))

	local var_3_11 = var_3_9 + var_3_10

	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - var_3_11 + 0.85, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_12 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_12)
end

function zbXiaobaiye_1.getDamageRatio(arg_10_0, arg_10_1)
	return 0.5
end
