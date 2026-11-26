require("gamecore.skill.zbBaseSkill")

zbMaozha_2 = class("zbMaozha_2", zbBaseSkill)
zbMaozha_2.__index = zbMaozha_2

function zbMaozha_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMaozha_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMaozha_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.8
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbMaozha_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC
			local var_5_1 = 0.5
			local var_5_2 = arg_3_0:getDamageAbs()
			local var_5_3 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_0, var_5_1, var_5_2, var_5_3, 0.25)
			g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.hitEffectId)
			g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = CCArray:create()

	if arg_3_0.hero.maozha4Skill ~= nil then
		arg_3_0.hero.maozha4Skill:actionEx(var_3_4)
	end

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end
