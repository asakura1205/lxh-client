require("gamecore.skill.zbBaseSkill")

zbKali_4 = class("zbKali_4", zbBaseSkill)
zbKali_4.__index = zbKali_4

function zbKali_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbKali_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbKali_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.kaliSkill4 = arg_2_0
	arg_2_0.enemyDebuffCount = 0
end

function zbKali_4.actionEx(arg_3_0, arg_3_1)
	arg_3_0.enemyDebuffCount = 1

	local var_3_0 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if g_BuffSystem:heroHasDebuffThisRound(iter_3_1) then
			arg_3_0.enemyDebuffCount = arg_3_0.enemyDebuffCount + 1
		end
	end

	local function var_3_1()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
		local var_4_1 = 0.1 * arg_3_0.enemyDebuffCount
		local var_4_2 = arg_3_0:getDamageAbs() * arg_3_0.enemyDebuffCount
		local var_4_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_4_0, var_4_1, var_4_2, var_4_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(0.3333333333333333))
end
