require("gamecore.skill.zbBaseSkill")

zbGuagua_2 = class("zbGuagua_2", zbBaseSkill)
zbGuagua_2.__index = zbGuagua_2

function zbGuagua_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGuagua_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGuagua_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbGuagua_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.targetEffectId)

		local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
		local var_4_1 = 3
		local var_4_2 = arg_3_0:getDamageAbs()
		local var_4_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_4_0, var_4_1, var_4_2, var_4_3, 0.4)
	end

	local function var_3_1()
		arg_3_0:enterIdle()
	end

	local function var_3_2()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true

	local var_3_3 = CCArray:create()

	if arg_3_0.hero.guaguaSkill4 ~= nil then
		arg_3_0.hero.guaguaSkill4:actionEx(var_3_3)
	end

	var_3_3:addObject(CCCallFuncN:create(var_3_0))
	var_3_3:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime, 0.1)))
	var_3_3:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_3:addObject(CCCallFuncN:create(var_3_1))
	var_3_3:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_3:addObject(CCCallFuncN:create(var_3_2))

	local var_3_4 = CCSequence:create(var_3_3)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_4)
end
