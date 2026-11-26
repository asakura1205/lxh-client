zbBaseEffect = class("zbBaseEffect", CCNodeExtend)
zbBaseEffect.__index = zbBaseEffect

function zbBaseEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbBaseEffect)

	return arg_1_0
end

local function var_0_0(arg_2_0)
	return 180 / (3.1416 / math.atan(arg_2_0))
end

function zbBaseEffect.getDegree(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.x - arg_3_1.x
	local var_3_1 = arg_3_2.y - arg_3_1.y
	local var_3_2 = 0

	if var_3_0 > 0 and var_3_1 > 0 then
		var_3_2 = var_0_0(var_3_1 / var_3_0)
	elseif var_3_0 < 0 and var_3_1 > 0 then
		var_3_2 = 180 + var_0_0(var_3_1 / var_3_0)
	elseif var_3_0 < 0 and var_3_1 < 0 then
		var_3_2 = 180 + var_0_0(var_3_1 / var_3_0)
	elseif var_3_0 > 0 and var_3_1 < 0 then
		var_3_2 = 360 + var_0_0(var_3_1 / var_3_0)
	end

	if arg_3_2.x > arg_3_1.x then
		return -var_3_2
	else
		return -var_3_2 + 180
	end
end
