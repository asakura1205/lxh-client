require("gamecore.skill.zbBaseMissileAttack")

zbXiaobaishu_0 = class("zbXiaobaishu_0", zbBaseMissileAttack)
zbXiaobaishu_0.__index = zbXiaobaishu_0

function zbXiaobaishu_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaishu_0.new()

	var_1_0:init(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaishu_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5666666666666667

	arg_2_0:setHitExtraAction(function(arg_3_0)
		arg_2_0:onExtraAction(arg_3_0)
	end)
end

function zbXiaobaishu_0.onExtraAction(arg_4_0, arg_4_1)
	if arg_4_1 ~= nil and arg_4_0:isQteRedoing() == false then
		g_BuffSystem:createControlBuff(arg_4_0.hero, arg_4_1, BUFF_TYPE_CONTROL_CHAOFENG)
	end
end

function zbXiaobaishu_0.getDamageRatio(arg_5_0, arg_5_1)
	return 1
end
