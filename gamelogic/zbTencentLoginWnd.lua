require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbTencentLoginWnd", zbBaseWnd)

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

function createTencentLoginWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/account_tencent.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(100), "CCLayer")

		arg_3_0.btnWeixin = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")

		arg_3_0.btnWeixin:addHandleOfControlEvent(function()
			arg_3_0:onLogin(1)
		end, CCControlEventTouchUpInside)

		arg_3_0.btnQQ = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")

		arg_3_0.btnQQ:addHandleOfControlEvent(function()
			arg_3_0:onLogin(2)
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:doHide()
	end)
end

function var_0_0.doShow(arg_10_0)
	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(false)
	end
end

function var_0_0.doHide(arg_11_0)
	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(true)
	end
end

function var_0_0.onLogin(arg_12_0, arg_12_1)
	g_Login.bSendLoginServer = false

	zbGlobalUtil:loginGame(arg_12_1)
end
