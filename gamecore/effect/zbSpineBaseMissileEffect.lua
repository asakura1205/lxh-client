require("gamecore.effect.zbBaseEffect")

zbSpineBaseMissileEffect = class("zbSpineBaseMissileEffect", zbBaseEffect)
zbSpineBaseMissileEffect.__index = zbSpineBaseMissileEffect

local var_0_0 = 300
local var_0_1 = 9.8

function zbSpineBaseMissileEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineBaseMissileEffect)

	return arg_1_0
end

function zbSpineBaseMissileEffect.isEnd(arg_2_0)
	return arg_2_0.hited
end

function zbSpineBaseMissileEffect.updateBezier(arg_3_0, arg_3_1)
	if arg_3_0.missilePathType == EPathType.Bezier then
		arg_3_0.missleAccumTime = arg_3_0.missleAccumTime + arg_3_1

		local var_3_0 = arg_3_0.vx0 * arg_3_0.missleAccumTime
		local var_3_1 = arg_3_0.vy0 * arg_3_0.missleAccumTime - 0.5 * var_0_1 * arg_3_0.missleAccumTime * arg_3_0.missleAccumTime

		arg_3_0:setPositionX(arg_3_0.initPosition.x + var_3_0 * var_0_0)
		arg_3_0:setPositionY(arg_3_0.initPosition.y + var_3_1 * var_0_0)

		local var_3_2 = ccp(arg_3_0:getPosition())
		local var_3_3 = arg_3_0:getDegree(arg_3_0.lastPos, var_3_2)

		arg_3_0:setRotation(var_3_3)

		arg_3_0.lastPos = var_3_2
	end
end

function zbSpineBaseMissileEffect.setCustomHitAction(arg_4_0, arg_4_1)
	arg_4_0.customHitAction = arg_4_1
end

function zbSpineBaseMissileEffect.getSpeedAndDuration(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2.x - arg_5_1.x
	local var_5_1 = arg_5_2.y - arg_5_1.y
	local var_5_2 = var_5_0 / var_0_0
	local var_5_3 = var_5_1 / var_0_0
	local var_5_4 = arg_5_3 * 3.14 / 180

	if var_5_2 < 0 then
		var_5_4 = -var_5_4
	end

	local var_5_5 = var_5_2 * math.sqrt(var_0_1 / 2 / (var_5_2 * math.tan(var_5_4) - var_5_3))
	local var_5_6 = var_5_5 * math.tan(var_5_4)
	local var_5_7 = var_5_2 / var_5_5 - 0.003

	return var_5_5, var_5_6, var_5_7
end
