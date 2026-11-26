require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_bangqiu_1 = class("zbLuoxiaohei_bangqiu_1", zbBaseSkill)
zbLuoxiaohei_bangqiu_1.__index = zbLuoxiaohei_bangqiu_1

function zbLuoxiaohei_bangqiu_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_bangqiu_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_bangqiu_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.soundFrame = 0.9333333333333333
	arg_2_0.hitFrame = 1.9333333333333333
	arg_2_0.skillDurationTime = 2.2
end

function zbLuoxiaohei_bangqiu_1.action(arg_3_0)
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
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_6_1, 1203012)
			g_EffectSystem:createInstantEffect(iter_6_1, 1203013)
		end
	end

	local function var_3_3()
		g_Audio:playSound("audio/sound/rise_normal.mp3")
	end

	local function var_3_4()
		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			iter_8_1:resume()
			g_EffectSystem:createInstantEffect(iter_8_1, arg_3_0.skillRecord.targetEffectId)

			g_UseBangqiuShield = true

			local var_8_0 = BUFF_TYPE_SHIELD_PHYSICMAGIC
			local var_8_1 = (arg_3_0.hero.maxHp * 0.1 + arg_3_0:getDamageAbs()) * (1 + arg_3_0.hero.energy:getCount() * 0.1)
			local var_8_2 = 0
			local var_8_3 = 10000

			g_BuffSystem:createBuff(arg_3_0.hero, iter_8_1, var_8_0, var_8_1, var_8_2, var_8_3)

			g_UseBangqiuShield = false
		end

		g_Audio:playSound("audio/sound/cure.mp3")
	end

	local function var_3_5()
		arg_3_0:enterIdle()
	end

	local function var_3_6()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_7 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_7)
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.soundFrame))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.soundFrame))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_5))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_6))

	local var_3_8 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end
