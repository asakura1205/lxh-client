require("gamelogic.zbLoginWnd")
require("gamelogic.zbAccountWnd")
require("gamelogic.zbServerNoticeWnd")
require("gamelogic.zbServerListWnd")
require("gamelogic.zbAdviceWnd")
require("gamelogic.zbTencentLoginWnd")

local var_0_0 = class("zbLoginScene", function()
	return display.newScene("zbLoginScene")
end)

var_0_0.__index = var_0_0

function var_0_0.init(arg_2_0)
	arg_2_0.wndLogin = nil
	arg_2_0.wndAccount = nil
	arg_2_0.wndServerList = nil
	arg_2_0.wndServerNotice = nil
	arg_2_0.wndAdvice = nil
	arg_2_0.wndServerList = nil
	arg_2_0.wndTencent = nil

	arg_2_0:addUpDownBorder()
end

function var_0_0.onEnter(arg_3_0)
	g_LoginScene:showLogin()
end

function var_0_0.update(arg_4_0, arg_4_1)
	if arg_4_0.wndLoading then
		arg_4_0.wndLoading:onFrameUpdate()
	end

	if arg_4_0.wndServerNotice then
		arg_4_0.wndServerNotice:onFrameUpdate()
	end

	if arg_4_0.wndAccount then
		arg_4_0.wndAccount:onFrameUpdate()
	end

	if arg_4_0.wndLogin then
		arg_4_0.wndLogin:onFrameUpdate()
	end

	if arg_4_0.wndAdvice and arg_4_0.wndAdvice.isShow and zbGlobalUtil:getLoginState() == false then
		arg_4_0.wndAdvice:hide()
	end
end

function var_0_0.free(arg_5_0)
	zbUtil:freeWnd(arg_5_0.wndLogin)
	zbUtil:freeWnd(arg_5_0.wndAccount)
	zbUtil:freeWnd(arg_5_0.wndServerList)
	zbUtil:freeWnd(arg_5_0.wndServerNotice)
	zbUtil:freeWnd(arg_5_0.wndAdvice)
	zbUtil:freeWnd(arg_5_0.wndTencent)

	arg_5_0.wndLogin = nil
	arg_5_0.wndAccount = nil
	arg_5_0.wndServerList = nil
	arg_5_0.wndServerNotice = nil
	arg_5_0.wndAdvice = nil
	arg_5_0.wndServerList = nil
	arg_5_0.wndTencent = nil
	arg_5_0.wndBuoy = nil

	arg_5_0:removeAllChildrenWithCleanup(true)
	arg_5_0:release()
end

function var_0_0.showLogin(arg_6_0)
	if arg_6_0.wndLogin == nil then
		arg_6_0.wndLogin = createLoginWnd()

		arg_6_0.wndLogin:retain()
	end

	arg_6_0.wndLogin:show(arg_6_0)
end

function var_0_0.showAccount(arg_7_0)
	if arg_7_0.wndAccount == nil then
		arg_7_0.wndAccount = createAccountWnd()

		arg_7_0.wndAccount:retain()
	end

	arg_7_0.wndAccount:setModel(true)
	arg_7_0.wndAccount:show(arg_7_0)
end

function var_0_0.showTencentWnd(arg_8_0)
	if arg_8_0.wndTencent == nil then
		arg_8_0.wndTencent = createTencentLoginWnd()

		arg_8_0.wndTencent:retain()
	end

	arg_8_0.wndTencent:setModel(true)
	arg_8_0.wndTencent:show(arg_8_0)
end

function var_0_0.showServerNotice(arg_9_0)
	if arg_9_0.wndServerNotice == nil then
		arg_9_0.wndServerNotice = createServerNoticeWnd()

		arg_9_0.wndServerNotice:retain()
	end

	arg_9_0.wndServerNotice:setModel(true)
	arg_9_0.wndServerNotice:show(arg_9_0)
	arg_9_0.wndServerNotice:refresh()
end

function var_0_0.showAdvice(arg_10_0)
	if arg_10_0.wndAdvice == nil then
		arg_10_0.wndAdvice = createAdviceWnd()

		arg_10_0.wndAdvice:retain()
	end

	arg_10_0.wndAdvice:setModel(true)
	arg_10_0.wndAdvice:show(arg_10_0)
	arg_10_0.wndAdvice:refresh()
end

function var_0_0.showServerList(arg_11_0)
	if arg_11_0.wndServerList == nil then
		arg_11_0.wndServerList = createServerListWnd()

		arg_11_0.wndServerList:retain()
	end

	arg_11_0.wndServerList:setModel(true)
	arg_11_0.wndServerList:show(arg_11_0)
	arg_11_0.wndServerList:refresh()
end

function var_0_0.hideServerList(arg_12_0)
	arg_12_0.wndServerList:hide()
end

function createLoginScene()
	local var_13_0 = var_0_0.new()

	var_13_0:retain()
	var_13_0:init()

	return var_13_0
end
