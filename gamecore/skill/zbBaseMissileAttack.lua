require("gamecore.skill.zbBaseSkill")

zbBaseMissileAttack = class("zbBaseMissileAttack", zbBaseSkill)
zbBaseMissileAttack.__index = zbBaseMissileAttack

function zbBaseMissileAttack.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:initBase(arg_1_1, arg_1_2)

	arg_1_0.sideType = ESideType.Enemy
	arg_1_0.targetType = ETargetType.Default
	arg_1_0.subTargetType = ESubTargetType.All
	arg_1_0.hitFrame = 0.18
	arg_1_0.skillDurationTime = arg_1_0.hero.anim:getAnimDuration(arg_1_0.sequenceName)
	arg_1_0.hitExtraAction = nil
	arg_1_0.accumTime = 0
end

function zbBaseMissileAttack.action(arg_2_0)
	local function var_2_0()
		arg_2_0:popupSkillBubble()
		arg_2_0.hero.anim:setAnimation(arg_2_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_2_0.hero, arg_2_0.skillRecord.riseEffectId)
	end

	local function var_2_1()
		for iter_4_0, iter_4_1 in pairs(arg_2_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_2_0.hero, iter_4_1, arg_2_0)
		end
	end

	local function var_2_2()
		arg_2_0:enterIdle()
	end

	local function var_2_3()
		return
	end

	arg_2_0.actioning = true
	arg_2_0.accumTime = 0
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.targetList = zbTargetHandler:selectTarget(arg_2_0.hero, arg_2_0, arg_2_0:getSideType(), arg_2_0:getTargetType(), arg_2_0:getSubTargetType())

	if table.getn(arg_2_0.targetList) == 0 then
		arg_2_0.actioning = false

		return
	end

	local var_2_4 = CCArray:create()

	var_2_4:addObject(CCCallFuncN:create(var_2_0))
	var_2_4:addObject(CCDelayTime:create(arg_2_0.hitFrame))
	var_2_4:addObject(CCCallFuncN:create(var_2_1))
	var_2_4:addObject(CCDelayTime:create(math.max(arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName) - arg_2_0.hitFrame, 0.1)))
	var_2_4:addObject(CCCallFuncN:create(var_2_2))
	var_2_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_2_4:addObject(CCCallFuncN:create(var_2_3))

	local var_2_5 = CCSequence:create(var_2_4)

	arg_2_0.hero:stopAllActions()
	arg_2_0.hero:runAction(var_2_5)
end

function zbBaseMissileAttack.update(arg_7_0, arg_7_1)
	arg_7_0.accumTime = arg_7_0.accumTime + arg_7_1

	if arg_7_0.accumTime > 3 then
		arg_7_0.actioning = false
	end
end

function zbBaseMissileAttack.hited(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.actioning then
		arg_8_0.actioning = false
	end

	if arg_8_0.hitExtraAction ~= nil then
		arg_8_0.hitExtraAction(arg_8_1, arg_8_2, arg_8_3)
	end
end

function zbBaseMissileAttack.setHitExtraAction(arg_9_0, arg_9_1)
	arg_9_0.hitExtraAction = arg_9_1
end
