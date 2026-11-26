require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_niuzai_2 = class("zbLuoxiaohei_niuzai_2", zbBaseSkill)
zbLuoxiaohei_niuzai_2.__index = zbLuoxiaohei_niuzai_2

function zbLuoxiaohei_niuzai_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_niuzai_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_niuzai_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitDelayFrame = 0.23333333333333334
	arg_2_0.hitFrame = 0.7
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.totalCount = 0
	arg_2_0.curCount = 0
end

function zbLuoxiaohei_niuzai_2.action(arg_3_0)
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
		local var_6_0 = arg_3_0.skillRecord.hitEffectId

		arg_3_0.skillRecord.hitEffectId = 1001

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_6_1, arg_3_0)
		end

		arg_3_0.skillRecord.hitEffectId = var_6_0
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.totalCount = 1
	arg_3_0.curCount = 0
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.luoxiaoheiniuzaiSkill3 ~= nil then
		arg_3_0.hero.luoxiaoheiniuzaiSkill3:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))

	for iter_3_0 = 1, arg_3_0.hero.energy:getCount() do
		var_3_5:addObject(CCDelayTime:create(arg_3_0.hitDelayFrame))
		var_3_5:addObject(CCCallFuncN:create(var_3_2))

		arg_3_0.totalCount = arg_3_0.totalCount + 1
	end

	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.hitDelayFrame * arg_3_0.hero.energy:getCount(), 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbLuoxiaohei_niuzai_2.update(arg_9_0, arg_9_1)
	arg_9_0.accumTime = arg_9_0.accumTime + arg_9_1

	if arg_9_0.accumTime > 5 then
		arg_9_0.actioning = false
	end
end

function zbLuoxiaohei_niuzai_2.hited(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.curCount = arg_10_0.curCount + 1

	if arg_10_0.curCount >= arg_10_0.totalCount then
		arg_10_0.actioning = false
	end
end

function zbLuoxiaohei_niuzai_2.getDamageRatio(arg_11_0, arg_11_1)
	return 0.5
end
