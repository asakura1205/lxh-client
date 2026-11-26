require("gamecore.skill.zbBaseSkill")

zbShanxin_4 = class("zbShanxin_4", zbBaseSkill)
zbShanxin_4.__index = zbShanxin_4

function zbShanxin_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbShanxin_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbShanxin_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.shanxin4Skill = arg_2_0
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.hitFrame = 0.16666666666666666
	arg_2_0.skillDurationTime = 0.8333333333333334
end

function zbShanxin_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
		local var_4_1 = 0.2
		local var_4_2 = arg_3_0:getDamageAbs()
		local var_4_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_4_0, var_4_1, var_4_2, var_4_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
