local var_0_0 = class("zbAcUpwnd")

var_0_0.__index = var_0_0

function createAcUpWnd(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_2
		arg_2_0.btnNotnow = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCControlButton")

		arg_2_0.btnNotnow:addHandleOfControlEvent(function()
			arg_2_0:onNotNow()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnBindNow = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnBindNow:addHandleOfControlEvent(function()
			arg_2_0:onBindNow()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onNotNow(arg_7_0)
	if arg_7_0.parentWnd then
		arg_7_0.parentWnd:hide()
	end
end

function var_0_0.onBindNow(arg_8_0)
	if arg_8_0.parentWnd then
		arg_8_0.parentWnd:showAcUpNormal()
	end
end
