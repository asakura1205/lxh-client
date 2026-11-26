require("gamelogic.zbBaseWnd")
require("gamecore.zbCombatScene")

local var_0_0 = class("zbLoginWnd", zbBaseWnd)

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

function createLoginWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.curserver = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/login.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCLayer")

		arg_3_0.spriteBg = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")
		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchtest()
		end, CCControlEventTouchUpInside)

		arg_3_0.version = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnLogin = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")

		arg_3_0.btnLogin:setSoundTag(SOUNDTAG_ENTERGAME)
		arg_3_0.btnLogin:addHandleOfControlEvent(function()
			arg_3_0:onLoginGame()
		end, CCControlEventTouchUpInside)

		arg_3_0.serverRoot = tolua.cast(var_5_2:getChildByTag(100), "CCLayerColor")
		arg_3_0.serverIndex = tolua.cast(arg_3_0.serverRoot:getChildByTag(2), "CCLabelTTF")
		arg_3_0.serverName = tolua.cast(arg_3_0.serverRoot:getChildByTag(3), "CCLabelTTF")
		arg_3_0.serverBtn = tolua.cast(arg_3_0.serverRoot:getChildByTag(5), "CCControlButton")

		arg_3_0.serverBtn:addHandleOfControlEvent(function()
			arg_3_0:onServerListReq()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		arg_3_0.adviceBtn = tolua.cast(var_5_3:getChildByTag(4), "CCControlButton")

		arg_3_0.adviceBtn:addHandleOfControlEvent(function()
			arg_3_0:onAdvice()
		end, CCControlEventTouchUpInside)

		arg_3_0.noticeBtn = tolua.cast(var_5_3:getChildByTag(5), "CCControlButton")

		arg_3_0.noticeBtn:addHandleOfControlEvent(function()
			arg_3_0:onNotice()
		end, CCControlEventTouchUpInside)

		arg_3_0.accountBtn = tolua.cast(var_5_3:getChildByTag(6), "CCControlButton")

		arg_3_0.accountBtn:addHandleOfControlEvent(function()
			arg_3_0:onAccountInfo()
		end, CCControlEventTouchUpInside)

		arg_3_0.spXuanfu = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")

		arg_3_0.spXuanfu:setVisible(false)

		arg_3_0.btnaccountMgr = tolua.cast(arg_3_0.spXuanfu:getChildByTag(1), "CCControlButton")

		arg_3_0.btnaccountMgr:addHandleOfControlEvent(function()
			arg_3_0:onAccountMgr()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnaccountChange = tolua.cast(arg_3_0.spXuanfu:getChildByTag(2), "CCControlButton")

		arg_3_0.btnaccountChange:addHandleOfControlEvent(function()
			arg_3_0:onAccountChange()
		end, CCControlEventTouchUpInside)

		arg_3_0.welcomeLayer = tolua.cast(var_5_2:getChildByTag(5), "CCLayer")

		arg_3_0.welcomeLayer:setVisible(false)

		arg_3_0.lblaccount = tolua.cast(arg_3_0.welcomeLayer:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.welOriposY = arg_3_0.welcomeLayer:getPositionY()

		arg_3_0.spriteBg:setVisible(false)

		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0.layerScene:load(COMBAT_SCENE_LOGIN)
		arg_3_0:addChild(arg_3_0.layerScene)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshServerList()
	end, zbGameEvent.Event_Refresh_ServerList)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onSelectServer()
	end, zbGameEvent.Event_Select_Server)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshToken()
	end, zbGameEvent.Event_Account_RefreshToken)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onAccountCheckAck()
	end, zbGameEvent.Event_AccountAc_Check)
end

function var_0_0.doDestroy(arg_19_0)
	arg_19_0.layerScene:free()
end

function var_0_0.accountBtnSet(arg_20_0)
	if not zbChannelUtil:isZBChannel(g_Login.channel) then
		arg_20_0.accountBtn:setVisible(false)
		arg_20_0.adviceBtn:setPosition(arg_20_0.noticeBtn:getPosition())
		arg_20_0.noticeBtn:setPosition(arg_20_0.accountBtn:getPosition())
	end
end

function var_0_0.doShow(arg_21_0)
	zbChannelUtil:onSetChannelTypeByChanelType(zbGlobalUtil:getChannelType())

	if zbGlobalUtil:getLoginState() and g_Login.bSendLoginServer then
		arg_21_0:onSelectServer()
		arg_21_0:accountBtnSet()
		arg_21_0:setresVersion()

		return
	end

	arg_21_0:platformInit()
	arg_21_0:accountBtnSet()
	zbChannelUtil_Login:onSdkLogin()
end

function var_0_0.showBuoyWelcome(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.welOriposY + arg_22_0.welcomeLayer:getContentSize().height * 2

	arg_22_0.welcomeLayer:setPositionY(var_22_0)

	local var_22_1 = arg_22_0.welcomeLayer:getPositionX()

	arg_22_0.welcomeLayer:setVisible(true)
	arg_22_0.lblaccount:setString(a2u("\xBB\xB6ӭ\xBB\xD8\xC0\xB4,") .. arg_22_1)

	local var_22_2 = CCArray:create()

	var_22_2:addObject(CCMoveTo:create(0.5, ccp(var_22_1, arg_22_0.welOriposY)))
	var_22_2:addObject(CCDelayTime:create(1))
	var_22_2:addObject(CCMoveTo:create(0.5, ccp(var_22_1, var_22_0)))

	local var_22_3 = CCSequence:create(var_22_2)

	arg_22_0.welcomeLayer:stopAllActions()
	arg_22_0.welcomeLayer:runAction(var_22_3)
end

function var_0_0.onTouchtest(arg_23_0)
	local var_23_0 = arg_23_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_23_0.spXuanfu, var_23_0.x, var_23_0.y) == false then
		arg_23_0.spXuanfu:setVisible(false)
	end
end

function var_0_0.onRefreshToken(arg_24_0)
	if g_Login.tokenRefresh_ret == 1 then
		g_Login:saveAccountInfo()
		zbGlobalUtil:setLoginState(true)
	else
		g_LoginScene:showAccount()
	end
end

function var_0_0.setresVersion(arg_25_0)
	local var_25_0 = zbGameCore:Instance():getConfigValue("current-version-code")

	g_Login.resVersion = var_25_0 or "1.1"

	if string.len(var_25_0) >= 50 then
		g_Login.resVersion = "1.1"
		var_25_0 = "1.1"
	end

	local var_25_1 = a2u("\xB0汾\xBAţ\xBA" .. var_25_0)

	arg_25_0.version:setString(var_25_1)
end

function var_0_0.platformInit(arg_26_0)
	arg_26_0:setresVersion()
	arg_26_0.serverName:setString("")
	arg_26_0.serverIndex:setString("")

	g_Login.platform = g_playformType

	zbChannelUtil_Report:reportGameData(2)
end

function var_0_0.setNodeVisible(arg_27_0, arg_27_1)
	arg_27_0.btnLogin:setVisible(arg_27_1)
	arg_27_0.serverRoot:setVisible(arg_27_1)
	arg_27_0.noticeBtn:setVisible(arg_27_1)
	arg_27_0.accountBtn:setVisible(arg_27_1 and zbChannelUtil:isZBChannel(g_Login.channel))
	arg_27_0.adviceBtn:setVisible(arg_27_1)
	arg_27_0.spXuanfu:setVisible(false)
end

function var_0_0.onAccountInfo(arg_28_0)
	if arg_28_0.spXuanfu:isVisible() then
		local var_28_0 = CCScaleTo:create(0.1, 1, 0.1)

		local function var_28_1()
			arg_28_0.spXuanfu:setVisible(false)
		end

		local var_28_2 = CCCallFuncN:create(var_28_1)
		local var_28_3 = CCSequence:createWithTwoActions(var_28_0, var_28_2)

		arg_28_0.spXuanfu:runAction(var_28_3)
	else
		arg_28_0.spXuanfu:setScaleY(0.1)
		arg_28_0.spXuanfu:setVisible(true)

		local var_28_4 = CCScaleTo:create(0.1, 1, 1)

		arg_28_0.spXuanfu:runAction(var_28_4)
	end
end

function var_0_0.onAccountMgr(arg_30_0)
	arg_30_0.spXuanfu:setVisible(false)

	if zbGlobalUtil:getLoginState() == false then
		return
	end

	if g_Login.bind_name ~= "" and g_Login.bind_phone ~= "" then
		g_Bubble:bubbleInfo(a2u("\xD5˺\xC5\xD2Ѱ\xF3\xB6\xA8"))

		return
	elseif g_Login.bind_name == "" and g_Login.bind_phone == "" then
		g_LoginScene:showAccount()
		g_LoginScene.wndAccount:showAcUp()
	elseif g_Login.bind_name ~= "" and g_Login.bind_phone == "" then
		g_LoginScene:showAccount()

		g_Login.accountCheckType = E_AccountCheckType.E_MOBILE_UP
		g_Login.accountUp_type = E_AccountUpPhone.E_NAME

		g_LoginScene.wndAccount:showFindbackPwd()
	end
end

function var_0_0.onAccountChange(arg_31_0)
	arg_31_0.spXuanfu:setVisible(false)

	g_Login.bSendLoginServer = false

	zbGlobalUtil:setLoginState(false)
	g_LoginScene:showAccount()
	g_LoginScene.wndAccount:showNormalLogin()
end

function var_0_0.onVideo(arg_32_0)
	return
end

function var_0_0.onAdvice(arg_33_0)
	g_LoginScene:showAdvice()
end

function var_0_0.onNotice(arg_34_0)
	arg_34_0.spXuanfu:setVisible(false)
	g_HttpMsgHandler:AS_NoticeList_Req(g_Login.selectServerId)
end

function var_0_0.onLogin(arg_35_0)
	arg_35_0.spXuanfu:setVisible(false)

	if g_Login.areaInfo and zbUtil:isValidTable(g_Login.areaInfo.ServerList) and table.getn(g_Login.areaInfo.ServerList) == 0 then
		g_Login:reqAreaList()
	end

	zbChannelUtil_Login:onLoginGameSdkReq()
end

function var_0_0.onLoginGame(arg_36_0)
	if g_Login.ticket == "" then
		zbGlobalUtil:setLoginState(false)

		g_Login.bSendLoginServer = false

		zbChannelUtil_Login:onSdkLogin()

		return
	end

	if zbGlobalUtil:getLoginState() == false then
		g_Login.bSendLoginServer = false

		zbChannelUtil_Login:onSdkLogin()

		return
	end

	if arg_36_0.curserver then
		g_WsMsgHandler.wsUrl = "ws://" .. arg_36_0.curserver.WSIP .. ":" .. arg_36_0.curserver.WSPort
	else
		g_Bubble:bubbleInfo("\xC7\xEBѡ\xD4\xF1\xC7\xF8\xB7\xFE")

		return
	end

	g_HttpMsgHandler:AS_AccountCheck_Req()
end

function var_0_0.onAccountCheckAck(arg_37_0)
	if g_Login.account_active == 0 then
		g_LoginScene:showAccount()
		g_LoginScene.wndAccount:showInputAccode()
	else
		arg_37_0:onLogin()
	end
end

function var_0_0.onServerListReq(arg_38_0)
	arg_38_0.spXuanfu:setVisible(false)
	g_LoginScene:showServerList()
end

function var_0_0.onRefreshServerList(arg_39_0)
	arg_39_0:onSelectServer()
end

function var_0_0.onSelectServer(arg_40_0)
	local var_40_0 = g_Login:getServerById(g_Login.selectServerId)

	if var_40_0 == nil then
		var_40_0 = g_Login:getServerById(g_Login.lastServerId)
		g_Login.selectServerId = g_Login.lastServerId
	end

	if var_40_0 == nil and g_Login.areaInfo then
		var_40_0 = g_Login:getServerById(g_Login.areaInfo.DefaultSid)
		g_Login.selectServerId = g_Login.areaInfo.DefaultSid
	end

	if var_40_0 then
		local var_40_1 = ccc3(255, 255, 255)

		if var_40_0.ServerStatus == 0 then
			-- block empty
		else
			var_40_1 = EServerStateColor[var_40_0.ServerStatus]
		end

		arg_40_0.serverIndex:setString(a2u(var_40_0.SortId .. "\xC7\xF8"))
		arg_40_0.serverIndex:setFontFillColor(var_40_1, true)
		arg_40_0.serverName:setString(a2u(var_40_0.ServerName))
		arg_40_0.serverName:setFontFillColor(var_40_1, true)
		arg_40_0.serverIndex:setGray(var_40_0.ServerStatus == 0)
		arg_40_0.serverName:setGray(var_40_0.ServerStatus == 0)

		g_WsMsgHandler.wsUrl = "ws://" .. var_40_0.WSIP .. ":" .. var_40_0.WSPort
		g_Login.lastServerId = g_Login.selectServerId
	end

	arg_40_0.curserver = var_40_0
end

function var_0_0.onFrameUpdate(arg_41_0)
	if g_Login.bSendLoginServer then
		if zbGlobalUtil:getLoginState() == false then
			g_Login.bSendLoginServer = false
		end

		return
	end

	if zbGlobalUtil:getLoginState() then
		g_Login.bSendLoginServer = true

		zbChannelUtil_Login:onLoginReqByChanelType(zbGlobalUtil:getChannelType())
	end
end
