CCLayerExtend = class("CCLayerExtend", CCNodeExtend)
CCLayerExtend.__index = CCLayerExtend

function CCLayerExtend.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCLayerExtend)

	local function var_1_1(arg_2_0)
		if arg_2_0 == "enter" then
			echoInfo("Scene \"%s:onEnter()\"", arg_1_0.name or arg_1_0.className or "unknown")
			arg_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			echoInfo("Scene \"%s:onEnter()\"", arg_1_0.name or arg_1_0.className or "unknown")
			arg_1_0:onExit()
		end
	end

	arg_1_0:registerNodeEvent(var_1_1)

	return arg_1_0
end

function CCLayerExtend.addTouchEventListener(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if type(arg_3_2) ~= "boolean" then
		arg_3_2 = false
	end

	if type(arg_3_3) ~= "number" then
		arg_3_3 = 0
	end

	if type(arg_3_4) ~= "boolean" then
		arg_3_4 = false
	end

	arg_3_0:registerScriptTouchHandler(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function CCLayerExtend.removeTouchEventListener(arg_4_0)
	arg_4_0:unregisterScriptTouchHandler()
end

function CCLayerExtend.addKeypadEventListener(arg_5_0, arg_5_1)
	arg_5_0:registerScriptKeypadHandler(arg_5_1)
end

function CCLayerExtend.removeKeypadEventListener(arg_6_0)
	arg_6_0:unregisterScriptKeypadHandler()
end

function CCLayerExtend.addScriptAccelerateHandler(arg_7_0, arg_7_1)
	arg_7_0:registerScriptAccelerateHandler(arg_7_1)
end

function CCLayerExtend.removeScriptAccelerateHandler(arg_8_0)
	arg_8_0:unregisterScriptAccelerateHandler()
end
