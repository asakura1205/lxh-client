zbChannelUtil_Login = {}

local var_0_0 = ""

function zbChannelUtil_Login.onSdkLogin(arg_1_0)
	g_Login.bSendLoginServer = false

	if zbChannelUtil:isZBChannel(g_Login.channel) then
		if g_Login:isLocalLogin() == false then
			g_LoginScene:showAccount()
		end
	elseif g_Login.channel == EChannelType.qq then
		if zbGlobalUtil:getLoginState() == false then
			g_LoginScene:showTencentWnd()
		end
	else
		zbGlobalUtil:loginGame("")
	end
end

function zbChannelUtil_Login.onLoginReqByChanelType(arg_2_0)
	local var_2_0 = ""

	if zbChannelUtil:isZBChannel(g_Login.channel) then
		local var_2_1 = zbGlobalUtil:getUserToken()
		local var_2_2 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_2 .. ";" .. var_2_1
	elseif zbChannelUtil:isYijieSdkChannel(g_Login.channel) then
		local var_2_3 = zbGlobalUtil:getUserId() .. ";" .. zbGlobalUtil:getUserToken() .. ";" .. zbGlobalUtil:getUserIdEx()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_3
	elseif g_Login.channel == EChannelType.bilibili then
		local var_2_4 = zbGlobalUtil:getUserToken()
		local var_2_5 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_5 .. ";" .. var_2_4
	elseif g_Login.channel == EChannelType.xiaomi then
		local var_2_6 = zbGlobalUtil:getUserToken()
		local var_2_7 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_7 .. ";" .. var_2_6
	elseif g_Login.channel == EChannelType.kuaikan then
		local var_2_8 = zbGlobalUtil:getUserToken()
		local var_2_9 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_9 .. ";" .. var_2_8
	elseif g_Login.channel == EChannelType.uc then
		local var_2_10 = zbGlobalUtil:getUserToken()
		local var_2_11 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_11 .. ";" .. var_2_10
	elseif g_Login.channel == EChannelType.qihoo then
		local var_2_12 = zbGlobalUtil:getUserToken()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_12
	elseif g_Login.channel == EChannelType.meizu then
		local var_2_13 = zbGlobalUtil:getUserToken()
		local var_2_14 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_14 .. ";" .. var_2_13
	elseif g_Login.channel == EChannelType.kaopu then
		local var_2_15 = zbGlobalUtil:getUserToken()
		local var_2_16 = string.urlencode(var_2_15)
		local var_2_17 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_17 .. ";" .. var_2_16
	elseif g_Login.channel == EChannelType.kpsuper then
		local var_2_18 = zbGlobalUtil:getUserToken()
		local var_2_19 = string.urlencode(var_2_18)
		local var_2_20 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_20 .. ";" .. var_2_19
	elseif g_Login.channel == EChannelType.m4399 then
		local var_2_21 = zbGlobalUtil:getUserToken()
		local var_2_22 = zbGlobalUtil:getUserId()

		var_2_0 = g_Login.loginServerUrl .. "ChannelId=" .. g_Login.channel .. "&Token=" .. var_2_22 .. ";" .. var_2_21
	end

	g_HttpMsgHandler:LS_LoginReq(var_2_0)
end

function zbChannelUtil_Login.initSdkLoginState(arg_3_0)
	var_0_0 = zbGlobalUtil:getUserId()

	if zbGlobalUtil:getLoginState() == false then
		var_0_0 = ""
	end

	if zbChannelUtil:isZBChannel(g_Login.channel) then
		if g_LoginScene.wndLogin then
			g_LoginScene.wndLogin:showBuoyWelcome(g_Login.accountId)
		end
	elseif g_Login.channel == EChannelType.qq and g_LoginScene.wndTencent then
		g_LoginScene.wndTencent:hide()
	end
end

function zbChannelUtil_Login.checkSdkLoginStateChange(arg_4_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if zbGlobalUtil:getLoginState() == false and g_GameStateMachine:getCurrState() ~= GameState_Login then
		g_WsMsgHandler:WS_Login_Out_Req()
		g_GameStateMachine:setStateImmediate(GameState_Login)
	end

	if var_0_0 == "" then
		return
	end

	if var_0_0 ~= zbGlobalUtil:getUserId() then
		g_WsMsgHandler:WS_Login_Out_Req()

		var_0_0 = ""

		if g_GameStateMachine:getCurrState() ~= GameState_Login then
			g_GameStateMachine:setStateImmediate(GameState_Login)
		end
	end
end

function zbChannelUtil_Login.onLoginGameSdkReq(arg_5_0)
	if zbGlobalUtil:getLoginState() == false then
		if zbChannelUtil:isZBChannel(g_Login.channel) then
			g_LoginScene:showAccount()
		elseif g_Login.channel == EChannelType.qq then
			g_LoginScene:showTencentWnd()
		else
			zbGlobalUtil:loginGame("")
		end

		return
	end

	if zbGlobalUtil:getLoginState() then
		local var_5_0 = g_Login:getServerById(g_Login.selectServerId)

		if var_5_0 and var_5_0.ServerStatus == 0 then
			g_Bubble:bubbleInfo("\xB7\xFE\xCE\xF1\xC6\xF7\xB9ر\xD5ά\xBB\xA4\xD6\xD0")

			return
		end

		if var_0_0 == "" or var_0_0 == zbGlobalUtil:getUserId() then
			zbChannelUtil_Login:onEnterGameReqByChanelType()
		else
			zbChannelUtil_Login:onLoginReqByChanelType()
		end
	else
		zbChannelUtil_Login:onLoginReqByChanelType()
	end
end

function zbChannelUtil_Login.onEnterGameReqByChanelType(arg_6_0)
	g_Login:loginGame()
end

function zbChannelUtil_Login.onLoginTokenValidByChanelType(arg_7_0)
	if zbGlobalUtil:getTargetPlatform() == "android" and zbGlobalUtil:getChannelType() ~= "" then
		zbChannelUtil_Login:onSdkLogin()
	end
end
