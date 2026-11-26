require("gamecore.skill.zbBaseSkill")

zbDiting_3 = class("zbDiting_3", zbBaseSkill)
zbDiting_3.__index = zbDiting_3

function zbDiting_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbDiting_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbDiting_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All

	if g_FirstCombat:isActive() then
		return
	end

	arg_2_0.hitFrame = 0.5
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.dtSkill3 = arg_2_0
end

function zbDiting_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		local var_5_0 = 1
		local var_5_1 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			if g_BuffSystem:heroHasDebuffThisRound(iter_5_1) then
				var_5_0 = var_5_0 + 1
			end
		end

		local var_5_2 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
		local var_5_3 = 0.2 * var_5_0
		local var_5_4 = arg_3_0:getDamageAbs() * var_5_0
		local var_5_5 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_2, var_5_3, var_5_4, var_5_5)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
