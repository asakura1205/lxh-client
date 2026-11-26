CCShapeNodeExtend = class("CCShapeNodeExtend", CCNodeExtend)
CCShapeNodeExtend.__index = CCShapeNodeExtend

function CCShapeNodeExtend.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCShapeNodeExtend)

	return arg_1_0
end

function CCShapeNodeExtend.setColor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	CCShapeNode.setColor(arg_2_0, ccc4f(arg_2_1 / 255, arg_2_2 / 255, arg_2_3 / 255, (arg_2_4 or 255) / 255))
end
