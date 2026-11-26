require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGuideWorldVideoWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createGuideWorldVideoWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/guide_video.ccbi", var_5_0, true, "")

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.onShow(arg_8_0)
	zbGlobalUtil:GameCallSDKFunction("playvideo", "video/world", "1")
end

function var_0_0.onHide(arg_9_0)
	return
end

function var_0_0.onFrameUpdate(arg_10_0, arg_10_1)
	local var_10_0 = zbGlobalUtil:getStringValueByKey("playvideo") == "end"

	if zbGlobalUtil:getTargetPlatform() == "win32" then
		var_10_0 = true
	end

	if var_10_0 then
		arg_10_0:hide()
		g_Guide:stopCurGuideStep()
		g_MainScene:showMain()
		g_Guide:execGuide(GUIDE_STEP_FRISTIN)
	end
end
