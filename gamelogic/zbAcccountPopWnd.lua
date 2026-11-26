require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbAcccountPopWnd", zbBaseWnd)

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

function var_0_0.init(arg_2_0)
	local function var_2_0()
		return
	end

	local function var_2_1()
		local var_4_0 = CCBProxy:create()
		local var_4_1 = CCBReaderLoad("ccbi/accountpop.ccbi", var_4_0, true, "HelloCocosBuilderLayerOwner")
		local var_4_2 = tolua.cast(var_4_1, "CCLayer")

		arg_2_0.layeraccount = tolua.cast(var_4_2:getChildByTag(1), "CCLayer")
		arg_2_0.btnAccountInfo = tolua.cast(arg_2_0.layeraccount:getChildByTag(3), "CCControlButton")
		arg_2_0.btnAccountChange = tolua.cast(arg_2_0.layeraccount:getChildByTag(2), "CCControlButton")

		arg_2_0.btnAccountInfo:addHandleOfControlEvent(function()
			arg_2_0:onAccountMgr()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnAccountChange:addHandleOfControlEvent(function()
			arg_2_0:onAccountChange()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnTouchTest = tolua.cast(var_4_2:getChildByTag(100), "CCControlButton")

		arg_2_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_2_0:onTouchtest()
		end, CCControlEventTouchUpInside)
		arg_2_0:setWinType(EWinType.Pop_OnlyDark)
		arg_2_0:addChild(var_4_1)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onTouchtest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layeraccount, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()
	end
end

function var_0_0.onAccountMgr(arg_9_0)
	if zbGlobalUtil:getLoginState() == false then
		return
	end

	arg_9_0:hide()

	if g_Login.bind_name ~= "" and g_Login.bind_phone ~= "" then
		g_Bubble:bubbleInfo(a2u("\xD5˺\xC5\xD2Ѱ\xF3\xB6\xA8"))

		return
	elseif g_Login.bind_name == "" and g_Login.bind_phone == "" then
		g_MainScene:showAccount()
		g_MainScene.wndAccount:showAcUp()
	elseif g_Login.bind_name ~= "" and g_Login.bind_phone == "" then
		g_MainScene:showAccount()

		g_Login.accountCheckType = E_AccountCheckType.E_MOBILE_UP
		g_Login.accountUp_type = E_AccountUpPhone.E_NAME

		g_MainScene.wndAccount:showFindbackPwd()
	end
end

function var_0_0.onAccountChange(arg_10_0)
	arg_10_0.bSendLoginServer = false

	zbGlobalUtil:setLoginState(false)
	g_WsMsgHandler:WS_Login_Out_Req()
end

function createAccountPopWnd()
	local var_11_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_11_0:initBase()
	var_11_0:init()

	return var_11_0
end
