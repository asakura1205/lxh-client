require("gamecore.skill.zbBaseSkill")

zbWuxian_3 = class("zbWuxian_3", zbBaseSkill)
zbWuxian_3.__index = zbWuxian_3

function zbWuxian_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWuxian_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWuxian_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.4666666666666667
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.wuxianSkill3 = arg_2_0
end

function zbWuxian_3.action(arg_3_0)
	return
end

function zbWuxian_3.actionKillTarget(arg_4_0)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
	end

	local function var_4_1()
		g_CombatFormulaCure:calcCure(arg_4_0.hero, arg_4_0.hero, arg_4_0)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, 2001)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, 2002)
	end

	local function var_4_2()
		arg_4_0:enterIdle()
	end

	local function var_4_3()
		arg_4_0.hero.wuxianSkill0.actioning = false
		arg_4_0.hero.wuxianSkill1.actioning = false
		arg_4_0.hero.wuxianSkill2.actioning = false
	end

	local var_4_4 = CCArray:create()

	var_4_4:addObject(CCCallFuncN:create(var_4_0))
	var_4_4:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	var_4_4:addObject(CCCallFuncN:create(var_4_1))
	var_4_4:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame, 0.1)))
	var_4_4:addObject(CCCallFuncN:create(var_4_2))
	var_4_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_4_4:addObject(CCCallFuncN:create(var_4_3))

	local var_4_5 = CCSequence:create(var_4_4)

	arg_4_0.hero:stopAllActions()
	arg_4_0.hero:runAction(var_4_5)
end

function zbWuxian_3.getDamageRatio(arg_9_0, arg_9_1)
	return 0.4
end
