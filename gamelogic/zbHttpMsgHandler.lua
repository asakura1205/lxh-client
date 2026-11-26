require("gamelogic.proto")
require("gamecore.errorcode")
require("gamelogic.zbNetTipConnecting")
require("gamelogic.zbWaitMomentWnd")

zbHttpMsgHandler = class(zbHttpMsgHandler)
zbHttpMsgHandler.__index = zbHttpMsgHandler

require("gamelogic.msg_LoginServer")
require("gamelogic.msg_AreaServer")

zbHttpMsgHandler.m_handlerMap = {
	[MSG_ID.LS_ErrorCode_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.LS_ErrorCode_Ack),
	[MSG_ID.LS_Login_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.LS_LoginAck),
	[MSG_ID.AS_ErrorCode_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_ErrorCode_Ack),
	[MSG_ID.AS_AreaList_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_AreaList_Ack),
	[MSG_ID.AS_RoleInfo_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_RoleInfoAck),
	[MSG_ID.AS_NoticeList_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_NoticeList_Ack),
	[MSG_ID.AS_AccountActivate_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_AccountActivate_Ack),
	[MSG_ID.AS_AccountCheck_Ack] = handler(zbHttpMsgHandler, zbHttpMsgHandler.AS_AccountCheck_Ack)
}

function createHttpMsgHandler()
	local var_1_0 = zbHttpMsgHandler.new()

	var_1_0:init()

	return var_1_0
end

function zbHttpMsgHandler.init(arg_2_0)
	local function var_2_0(arg_3_0)
		echoInfo("recv msg: " .. tostring(arg_3_0))
		arg_2_0:handlerMsg(arg_3_0)
	end

	local function var_2_1(arg_4_0)
		echoInfo("post recv msg: " .. tostring(arg_4_0))
		arg_2_0:handlerPostMsg(arg_4_0)
	end

	zbNetUtil:Instance():SetLuaHandler(var_2_0)
	zbNetUtil:Instance():SetLuaHandlerPost(var_2_1)

	arg_2_0.wndCircle = createNetTipConnecting()
	arg_2_0.lastSendMsgTime = os_timenow()
	arg_2_0.lastPostMsgType = 0
end

function zbHttpMsgHandler.reset(arg_5_0)
	zbNetUtil:Instance():Init()
end

function zbHttpMsgHandler.free(arg_6_0)
	arg_6_0.wndCircle:free()
end

function mapMsg(arg_7_0)
	if arg_7_0.Header ~= nil then
		return arg_7_0
	end

	local var_7_0

	local function var_7_1(arg_8_0)
		if type(arg_8_0) ~= "table" then
			return arg_8_0
		end

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_0) do
			local var_8_1 = TypeNameMap[iter_8_0]

			if var_8_1 == nil then
				var_8_1 = iter_8_0
			end

			if type(iter_8_1) == "table" then
				var_8_0[var_8_1] = var_7_1(iter_8_1)
			else
				var_8_0[var_8_1] = iter_8_1
			end
		end

		return var_8_0
	end

	return var_7_1(arg_7_0)
end

function zbHttpMsgHandler.handlerMsg(arg_9_0, arg_9_1)
	arg_9_0.wndCircle:setResponsed(true)
	arg_9_0.wndCircle:hide()

	if arg_9_1 == "login failed! 1" then
		echoInfo(arg_9_1)

		return
	end

	if arg_9_1 == "response failed" then
		if arg_9_0:onFailReq() == false then
			g_Bubble:bubbleInfo("服务器连接失败，稍后重试")
		end

		return
	end

	local var_9_0 = require("cjson")

	echoInfo("strMsg: " .. arg_9_1)

	local var_9_1 = var_9_0.decode(arg_9_1)

	if type(var_9_1) ~= "table" then
		echoInfo("faild return value")

		return
	end

	local var_9_2 = mapMsg(var_9_1)

	echoInfo("nodeMsg:" .. var_9_0.encode(var_9_2))

	local var_9_3 = var_9_2.Header

	if var_9_3 == nil then
		g_Bubble:bubbleInfo("请退出重启游戏，更新客户端")

		return
	end

	if var_9_3 ~= nil and var_9_3.ProtoVersion ~= nil and var_9_3.ProtoVersion ~= PROTO_VERSION and var_9_3.ProtoVersion ~= -1 then
		-- block empty
	end

	arg_9_0:processMsg(var_9_3.MsgID, var_9_2.Msg)
end

function zbHttpMsgHandler.onFailReq(arg_10_0)
	return false
end

function zbHttpMsgHandler.popupNetResponseWait(arg_11_0)
	if arg_11_0.wndTipNetResponseWait == nil then
		arg_11_0.wndTipNetResponseWait = zbWaitMomentWnd:create()

		arg_11_0.wndTipNetResponseWait:retain()
	end

	if arg_11_0.wndTipNetResponseWait and arg_11_0.wndTipNetResponseWait.isShow == false then
		arg_11_0.wndTipNetResponseWait:setModel(true)
		arg_11_0.wndTipNetResponseWait:show(CCDirector:sharedDirector():getRunningScene())
	end
end

function zbHttpMsgHandler.popupNetResponseWaitHide(arg_12_0)
	if arg_12_0.wndTipNetResponseWait ~= nil and arg_12_0.wndTipNetResponseWait.isShow then
		arg_12_0.wndTipNetResponseWait:hide()
	end
end

function zbHttpMsgHandler.handlerPostMsg(arg_13_0, arg_13_1)
	arg_13_0.wndCircle:setResponsed(true)
	arg_13_0.wndCircle:hide()

	if zbHttpMsgHandler.lastPostMsgType == 0 then
		return
	end

	if arg_13_1 == "response failed" then
		g_Bubble:bubbleInfo("服务器连接失败，稍后重试")

		return
	end

	local var_13_0 = require("cjson")

	echoInfo("strMsg: " .. arg_13_1)

	local var_13_1 = var_13_0.decode(arg_13_1)

	if type(var_13_1) ~= "table" then
		echoInfo("faild return value")

		return
	end

	if var_13_1.status == nil then
		return
	end

	if var_13_1.status == 0 then
		print("nodeMsg.state == " .. var_13_1.status .. "zbHttpMsgHandler.lastPostMsgType = " .. zbHttpMsgHandler.lastPostMsgType)

		if zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_REG then
			g_Bubble:bubbleInfo(a2u("注册成功"))

			local var_13_2 = var_13_1.data.token
			local var_13_3 = var_13_1.data.userid

			zbGlobalUtil:setLoginUserData(var_13_2, var_13_3, "")
			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_Register)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_LOGIN then
			g_Bubble:bubbleInfo(a2u("登录成功"))

			local var_13_4 = var_13_1.data.token
			local var_13_5 = var_13_1.data.userid

			zbGlobalUtil:setLoginUserData(var_13_4, var_13_5, "")

			g_Login.expire = var_13_1.data.expire
			g_Login.account_type = var_13_1.data.account_type

			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_Login)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_VISITOR then
			g_Bubble:bubbleInfo(a2u("快速登录成功"))

			local var_13_6 = var_13_1.data.token
			local var_13_7 = var_13_1.data.userid

			zbGlobalUtil:setLoginUserData(var_13_6, var_13_7, "")

			g_Login.expire = var_13_1.data.expire
			g_Login.account_type = var_13_1.data.account_type

			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_Login)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_AC_CHECK then
			g_Bubble:bubbleInfo(a2u("账号唯一性验证成功"))
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_Check)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_VERIFY then
			g_Bubble:bubbleInfo(a2u("验证码验证成功"))
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_CheckCode)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_BINDPHONE then
			g_Bubble:bubbleInfo(a2u("绑定成功"))
			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_BindPhone)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_FINDBACKPWD then
			g_Login:login()
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_REFRESH_TOKEN then
			local var_13_8 = var_13_1.data.token
			local var_13_9 = var_13_1.data.userid

			zbGlobalUtil:setLoginUserData(var_13_8, var_13_9, "")

			g_Login.expire = var_13_1.data.expire
			g_Login.tokenRefresh_ret = 1

			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_RefreshToken)
		elseif zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_AC_UP then
			g_Bubble:bubbleInfo(a2u("绑定成功"))
			g_Login:setBindInfo(var_13_1.data)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_Up)
		end
	elseif var_13_1.message then
		if zbHttpMsgHandler.lastPostMsgType == E_ZB_MSG_REFRESH_TOKEN then
			g_Login.tokenRefresh_ret = 0

			g_GameEventMgr:sendEvent(zbGameEvent.Event_Account_RefreshToken)
		end

		g_Bubble:bubbleInfo(a2u(var_13_1.message))
	end
end

function zbHttpMsgHandler.update(arg_14_0)
	arg_14_0.wndCircle:update()
end

function zbHttpMsgHandler.processMsg(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.m_handlerMap[arg_15_1] ~= nil then
		local var_15_0 = os_timenow()

		arg_15_0.m_handlerMap[arg_15_1](arg_15_2)

		local var_15_1 = os_timenow() - var_15_0

		if var_15_1 > 1 then
			echo(string.format("zbHttpMsgHandler:ProcessMsg msgId=%d, time=%d", arg_15_1, var_15_1))
		end
	end
end

function zbHttpMsgHandler.sendMsg(arg_16_0, arg_16_1)
	zbNetUtil:Instance():Send(arg_16_1)
	arg_16_0.wndCircle:show()

	arg_16_0.lastSendMsgTime = os_timenow()
end

function zbHttpMsgHandler.sendPostMsg(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	zbHttpMsgHandler.lastPostMsgType = arg_17_3

	echo(".........sendPostMsg.......", arg_17_2)
	zbNetUtil:Instance():SendPost(arg_17_1, arg_17_2)
	arg_17_0.wndCircle:show()

	arg_17_0.lastSendMsgTime = os_timenow()
end

function zbHttpMsgHandler.packMsg(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 == nil or arg_18_3 == "" then
		echo("warning: invalid http url")

		return
	end

	local var_18_0 = PacketHeader

	var_18_0.MsgID = arg_18_2

	local var_18_1 = ProtoMsg

	var_18_1.Header = var_18_0
	var_18_1.Msg = arg_18_1

	local var_18_2 = require("cjson").encode(var_18_1)
	local var_18_3 = arg_18_3 .. var_18_2

	arg_18_0:sendMsg(var_18_3)
end
