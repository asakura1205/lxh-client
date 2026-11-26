require("gamelogic.zbTabWnd")
require("gamelogic.zbChatPanel")
require("gamelogic.zbChatPrivatePanel")
require("gamelogic.zbChatHornItem")
require("gamelogic.zbChatContent")

local var_0_0 = class("zbChatWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createChatWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("ui/image/plist/face.plist")

		arg_3_0.replaceT = {}
		arg_3_0.linkDetail = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/chat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.tabButtons = {}
		arg_3_0.tabButtons[EChatType.EWorld] = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.tabButtons[EChatType.ELegion] = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.tabButtons[EChatType.EPrivate] = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.tabButtons[EChatType.ESystem] = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")

		local function var_5_3(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(120, 70)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		arg_3_0.notifyLegion = var_5_3(arg_3_0.tabButtons[EChatType.ELegion])
		arg_3_0.notifyPrivate = var_5_3(arg_3_0.tabButtons[EChatType.EPrivate])

		local var_5_4 = {
			[EChatType.EWorld] = tolua.cast(var_5_2:getChildByTag(100), "CCLayer"),
			[EChatType.ELegion] = tolua.cast(var_5_2:getChildByTag(200), "CCLayer"),
			[EChatType.EPrivate] = tolua.cast(var_5_2:getChildByTag(300), "CCLayer"),
			[EChatType.ESystem] = tolua.cast(var_5_2:getChildByTag(400), "CCLayer")
		}
		local var_5_5 = {
			[EChatType.EWorld] = "image/tab/tab_chat_eWorld.png",
			[EChatType.ELegion] = "image/tab/tab_chat_eLegion.png",
			[EChatType.EPrivate] = "image/tab/tab_chat_ePrivate.png",
			[EChatType.ESystem] = "image/tab/tab_chat_eSystem.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EChatType.EWorld] = createChatPanel(var_5_4[EChatType.EWorld], EChatType.EWorld)
		arg_3_0.module[EChatType.ELegion] = createChatPanel(var_5_4[EChatType.ELegion], EChatType.ELegion)
		arg_3_0.module[EChatType.EPrivate] = createChatPrivatePanel(var_5_4[EChatType.EPrivate], EChatType.EPrivate)
		arg_3_0.module[EChatType.ESystem] = createChatPanel(var_5_4[EChatType.ESystem], EChatType.ESystem)
		arg_3_0.nodebottom = tolua.cast(var_5_2:getChildByTag(600), "CCNode")

		local var_5_6 = tolua.cast(arg_3_0.nodebottom:getChildByTag(9), "CCLayer")
		local var_5_7 = tolua.cast(arg_3_0.nodebottom:getChildByTag(10), "CCScrollView")
		local var_5_8 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_6, "", MAX_CHAT_LEN, "image/common/button_transparent.png", 22, var_5_8)

		var_5_7:addChild(arg_3_0.inputBox)
		var_5_7:setCanMove(false)

		local var_5_9 = tolua.cast(var_5_2:getChildByTag(401), "CCNode")

		arg_3_0.btnClose = tolua.cast(var_5_9:getChildByTag(1), "CCControlButton")

		arg_3_0.btnClose:setVisible(false)

		local var_5_10 = tolua.cast(var_5_2:getChildByTag(500), "CCNode")

		arg_3_0.hornPnl = createChatHorn(var_5_10)
		arg_3_0.btnURL = tolua.cast(arg_3_0.nodebottom:getChildByTag(5), "CCControlButton")
		arg_3_0.btnFace = tolua.cast(arg_3_0.nodebottom:getChildByTag(6), "CCControlButton")
		arg_3_0.btnHorn = tolua.cast(arg_3_0.nodebottom:getChildByTag(7), "CCControlButton")
		arg_3_0.btnSend = tolua.cast(arg_3_0.nodebottom:getChildByTag(8), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnURL:addHandleOfControlEvent(function()
			arg_3_0:onURL()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnHorn:addHandleOfControlEvent(function()
			arg_3_0:onHorn()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSend:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFace:addHandleOfControlEvent(function()
			arg_3_0:onFace()
		end, CCControlEventTouchUpInside)
		arg_3_0:initTab(arg_3_0.tabButtons, var_5_4, var_5_5, function(arg_12_0)
			return arg_3_0:switchTabCheck(arg_12_0)
		end)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Horn
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:OnChatNtf()
	end, zbGameEvent.Event_Chat_Ntf)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:OnHornNtf()
	end, zbGameEvent.Event_Chat_Horn)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:OnNewPrivateNtf()
	end, zbGameEvent.Event_Chat_NewPrivateMsg)
end

function var_0_0.onShow(arg_18_0)
	arg_18_0.inputBox:setPlaceHolder(a2u("\xD4ڴ\xCB\xCA\xE4\xC8\xEB\xC1\xC4\xCC\xEC\xC4\xDA\xC8ݣ\xAC\xD7\xEE\xB6\xE0\xCA\xE4\xC8\xEB30\xB8\xF6\xD7\xD6"))

	local var_18_0 = arg_18_0.layer:getContentSize().height

	arg_18_0.layer:setPosition(0, -var_18_0)

	local var_18_1 = CCMoveTo:create(0.2, ccp(0, 0))

	arg_18_0.layer:stopAllActions()
	arg_18_0.layer:runAction(var_18_1)
	g_Self.kRedPointHandler:setStateValue(ERedPointType.Chat, REDPOINT_STATE_CLOSE)
end

function var_0_0.switchTabCheck(arg_19_0, arg_19_1)
	return true
end

function var_0_0.showChatPrivate(arg_20_0, arg_20_1)
	if arg_20_1 then
		g_Self.kChatHandler:addChatObjList(arg_20_1)

		g_Self.kChatHandler.curPrivateChatPlayerInfo = arg_20_1

		arg_20_0:selectTab(EChatType.EPrivate)
	end
end

function var_0_0.privateChatSel(arg_21_0)
	if arg_21_0.module[EChatType.EPrivate] then
		arg_21_0.module[EChatType.EPrivate]:privateChatSel()
	end
end

function var_0_0.doSelectTab(arg_22_0)
	arg_22_0.nodebottom:setVisible(arg_22_0.currTab ~= EChatType.ESystem and arg_22_0.currTab ~= EChatType.EPrivate)

	if arg_22_0.currTab == EChatType.EPrivate then
		if g_Self.kChatHandler.curPrivateChatPlayerInfo == nil then
			local var_22_0 = g_Self.kChatHandler.chatobjList

			if zbUtil:isValidTable(var_22_0) and table.getn(var_22_0) > 0 then
				local var_22_1 = var_22_0[1]

				g_Self.kChatHandler.curPrivateChatPlayerInfo = var_22_1
			end
		end

		arg_22_0:privateChatSel()
	end
end

function var_0_0.chatContentFilt(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.replaceT) do
		if iter_23_1.type == EChatURLTab.Hero then
			arg_23_1 = string.gsub(arg_23_1, iter_23_1.desc, "[h]" .. iter_23_1.id .. "[/h]")
		else
			arg_23_1 = string.gsub(arg_23_1, iter_23_1.desc, "[e]" .. iter_23_1.id .. "[/e]")
		end
	end

	arg_23_0.replaceT = {}

	return arg_23_1
end

function var_0_0.onSend(arg_24_0)
	local var_24_0 = arg_24_0.inputBox:getText()

	if g_Self.kChatHandler:isCdEnd(arg_24_0.currTab) == false then
		g_Bubble:bubbleInfo(a2u("\xB7\xA2\xD1\xD4Ƶ\xB7\xB1"))

		return
	end

	if var_24_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC1\xC4\xCC\xEC\xC4\xDA\xC8\xDD"))

		return
	end

	local var_24_1 = zbUtil:repValidText(var_24_0)

	arg_24_0.inputBox:setText("")
	arg_24_0.inputBox:setPlaceHolder(a2u("\xC7\xEB\xCA\xE4\xC8\xEB..."))

	local var_24_2 = {
		ChatType = arg_24_0.currTab,
		ChatMsg = a2u(var_24_1),
		SenderId = g_GameData.BaseInfo.PlayerId,
		SenderName = a2u(g_Self:getName())
	}

	var_24_2.IsHorn = 0
	var_24_2.SenderHeadId = g_GameData.BaseInfo.HeadId
	var_24_2.SenderLevel = g_Self:getLevel()
	var_24_2.TargetId = 0
	var_24_2.ChatTm = g_Self.kTimeHandler:getServerTime()
	var_24_2.LinkList = {}

	g_Self.kChatHandler:onNewChatNtf(var_24_2)
	g_WsMsgHandler:WS_Chat_SendReq(var_24_2)
end

function var_0_0.setInputBoxStr(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.inputBox:getText()

	if arg_25_2 == EChatURLTab.Hero then
		local var_25_1 = {
			id = arg_25_1
		}

		var_25_1.desc = ""
		var_25_1.type = arg_25_2

		local var_25_2 = zbHeroTable:getRecord(tonumber(arg_25_1))

		if var_25_2 then
			var_25_1.desc = var_25_2.name
		end

		table.insert(arg_25_0.replaceT, var_25_1)

		var_25_0 = var_25_0 .. var_25_1.desc
	elseif arg_25_2 == EChatURLTab.Equip then
		-- block empty
	else
		var_25_0 = var_25_0 .. arg_25_1
	end

	arg_25_0.inputBox:setText(a2u(var_25_0))
end

function var_0_0.refresh(arg_26_0)
	return
end

function var_0_0.onFrameUpdate(arg_27_0, arg_27_1)
	if arg_27_0.module[EChatType.EPrivate] then
		arg_27_0.module[EChatType.EPrivate]:update()
	end

	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_27_0.currTab == EChatType.ELegion and arg_27_0.isShow then
		g_Self.kChatHandler.notifyChat_legion = false
	elseif arg_27_0.currTab == EChatType.EPrivate and arg_27_0.isShow and g_Self.kChatHandler.curPrivateChatPlayerInfo then
		g_Self.kChatHandler:delPrivateRecord(g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId)
	end

	arg_27_0.notifyLegion:setVisible(g_Self.kChatHandler.notifyChat_legion)
	arg_27_0.notifyPrivate:setVisible(table.getn(g_Self.kChatHandler.notifyChat_private) > 0)
end

function var_0_0.OnChatNtf(arg_28_0)
	local var_28_0 = g_Self.kChatHandler.chatNtf

	if var_28_0 then
		if var_28_0.ChatType == EChatType.EWorld then
			arg_28_0.module[EChatType.EWorld]:addNewChatItem(var_28_0)
		elseif var_28_0.ChatType == EChatType.ELegion then
			arg_28_0.module[EChatType.ELegion]:addNewChatItem(var_28_0)
		elseif var_28_0.ChatType == EChatType.ESystem then
			arg_28_0.module[EChatType.ESystem]:addNewChatItem(var_28_0)
		elseif var_28_0.ChatType == EChatType.EPrivate and arg_28_0.currTab == EChatType.EPrivate and arg_28_0.isShow then
			arg_28_0.module[EChatType.EPrivate]:addNewChatItem(var_28_0)
		end
	end
end

function var_0_0.OnNewPrivateNtf(arg_29_0)
	if arg_29_0.currTab == EChatType.EPrivate and arg_29_0.isShow then
		if zbUtil:isValidTable(g_Self.kChatHandler.chatobjList) and table.getn(g_Self.kChatHandler.chatobjList) == 1 then
			local var_29_0 = g_Self.kChatHandler.chatobjList[1]

			g_Self.kChatHandler.curPrivateChatPlayerInfo = var_29_0

			arg_29_0:privateChatSel()
		else
			arg_29_0.module[EChatType.EPrivate]:refreshObjPnl()
		end
	end
end

function var_0_0.setPriaveInputBoxStr(arg_30_0, arg_30_1)
	arg_30_0.module[EChatType.EPrivate]:setInputBoxStr(arg_30_1)
end

function var_0_0.OnHornNtf(arg_31_0)
	arg_31_0.hornPnl:refresh()
end

function var_0_0.onURL(arg_32_0)
	g_MainScene:showChatURLWnd()
end

function var_0_0.onHorn(arg_33_0)
	if g_GameData.Wealth.Horn <= 0 then
		g_MainScene:showHornBuyWnd()

		return
	end

	g_MainScene:showChatHornWnd()
end

function var_0_0.onFace(arg_34_0)
	g_MainScene:showChatFaceWnd()
end
