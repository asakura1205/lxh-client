require("gamecore.skill.zbBaseNormalAttack")

zbYuanyue_3 = class("zbYuanyue_3", zbBaseSkill)
zbYuanyue_3.__index = zbYuanyue_3

function zbYuanyue_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYuanyue_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYuanyue_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.roleCount = 0
	arg_2_0.hero.yuanyueSkill3 = arg_2_0
end

function zbYuanyue_3.actionEx(arg_3_0, arg_3_1)
	arg_3_0.roleCount = 0

	local var_3_0 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if iter_3_1:getHpPercent() < 30 then
			arg_3_0.roleCount = arg_3_0.roleCount + 1
		end
	end

	if arg_3_0.roleCount <= 0 then
		return
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_2()
		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
		local var_5_1 = 0.1 * arg_3_0.roleCount
		local var_5_2 = arg_3_0:getDamageAbs() * arg_3_0.roleCount
		local var_5_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_2))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
