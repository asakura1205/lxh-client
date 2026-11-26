require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbChatHornWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createChatHornWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/hornwnd.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.hornNum = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCLayer")
		local var_5_4 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_3, "", MAX_CHAT_LEN, "image/common/button_transparent.png", 22, var_5_4)

		local var_5_5 = var_5_3:getContentSize()

		arg_3_0.inputBox:setpLabelDimensions(CCSizeMake(var_5_5.width - 10, var_5_5.height - 10))
		var_5_3:addChild(arg_3_0.inputBox)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(401), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnSend = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")

		arg_3_0.btnSend:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnFace = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		arg_3_0.btnFace:addHandleOfControlEvent(function()
			arg_3_0:onFace()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
end

function var_0_0.doShow(arg_11_0)
	arg_11_0.inputBox:setPlaceHolder(a2u(""))
	arg_11_0.hornNum:setString(g_GameData.Wealth.Horn)
end

function var_0_0.onSend(arg_12_0)
	if g_GameData.Wealth.Horn <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC0\xAE\xB0\xC8\xCA\xFD\xC1\xBF\xB2\xBB\xD7\xE3"))

		return
	end

	local var_12_0 = arg_12_0.inputBox:getText()

	if var_12_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC0\xAE\xB0\xC8\xC4\xDA\xC8\xDD"))

		return
	end

	local var_12_1 = zbUtil:repValidText(var_12_0)
	local var_12_2 = {
		ChatType = EChatType.EWorld,
		ChatMsg = a2u(var_12_1),
		SenderId = g_GameData.BaseInfo.PlayerId,
		SenderName = a2u(g_Self:getName()),
		SenderLevel = g_Self:getLevel(),
		SenderHeadId = g_GameData.BaseInfo.HeadId,
		ChatTm = g_Self.kTimeHandler:getServerTime()
	}

	var_12_2.IsHorn = 1
	var_12_2.TargetId = 0
	var_12_2.LinkList = {}

	g_Self.kChatHandler:onNewChatNtf(var_12_2)
	g_WsMsgHandler:WS_Chat_SendReq(var_12_2)
	arg_12_0:hide()
end

function var_0_0.setInputBoxStr(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.inputBox:getText() .. arg_13_1

	arg_13_0.inputBox:setText(a2u(var_13_0))
end

function var_0_0.onFace(arg_14_0)
	g_Self.kChatHandler.isHornChatFace = true

	g_MainScene:showChatFaceWnd()
end

function var_0_0.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layer, var_15_0.x, var_15_0.y) == false and zbUtil:PointInCtrl(arg_15_0.btnClose, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end
