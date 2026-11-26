local var_0_0 = class("zbChatHandler")

var_0_0.__index = var_0_0

function createChatHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.worldChats = {}
	arg_2_0.hornChats = {}
	arg_2_0.cityChats = {}
	arg_2_0.systemChats = {}
	arg_2_0.chatobjList = {}
	arg_2_0.bChatBaseFormationInfoReq = false
	arg_2_0.cdInfo = nil
	arg_2_0.chatNtf = nil
	arg_2_0.notifyChat = false
	arg_2_0.notifyChat_legion = false
	arg_2_0.notifyChat_private = {}
	arg_2_0.lastTime = os_timenow()
	arg_2_0.curPrivateChatPlayerInfo = nil
	arg_2_0.isPrivateChatFace = false
	arg_2_0.isHornChatFace = false
end

function var_0_0.update(arg_3_0, arg_3_1)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_3_0.notifyChat = false

	if arg_3_0.notifyChat == false then
		arg_3_0.notifyChat = arg_3_0.notifyChat_legion
	end

	if arg_3_0.notifyChat == false and table.getn(arg_3_0.notifyChat_private) > 0 then
		arg_3_0.notifyChat = true
	end

	g_Self.kRedPointHandler:refreshChat()
end

function var_0_0.setCdInfo(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.cdInfo = arg_4_1
	end
end

function var_0_0.isCdEnd(arg_5_0, arg_5_1)
	if arg_5_0.cdInfo == nil then
		return true
	end

	local var_5_0 = g_Self.kTimeHandler:getServerTime()

	if arg_5_1 == EChatType.EWorld then
		if g_DataConfig.m_kCommonCfg.chat.worldCD < var_5_0 - arg_5_0.cdInfo.ChatWorldCD then
			return true
		end
	elseif arg_5_1 == EChatType.ELegion then
		if g_DataConfig.m_kCommonCfg.chat.legionCD < var_5_0 - arg_5_0.cdInfo.ChatLegionCD then
			return true
		end
	elseif arg_5_1 == EChatType.EPrivate and g_DataConfig.m_kCommonCfg.chat.privateCD < var_5_0 - arg_5_0.cdInfo.ChatPrivateCD then
		return true
	end

	return false
end

function var_0_0.newPrivateChat(arg_6_0, arg_6_1)
	local var_6_0 = ""

	if arg_6_1.SenderId == g_GameData.BaseInfo.PlayerId then
		if zbUtil:isValidTable(arg_6_1.RecordList) and table.getn(arg_6_1.RecordList) > 0 then
			var_6_0 = arg_6_1.RecordList[1].TargetId
		end
	else
		var_6_0 = arg_6_1.SenderId
	end

	echo(".........fileName..............", var_6_0)

	local var_6_1 = zbChatHelp:getPlayerChatInfo(var_6_0)

	if var_6_1 == nil then
		var_6_1 = arg_6_1.RecordList
	elseif zbUtil:isValidTable(var_6_1) and zbUtil:isValidTable(arg_6_1) then
		for iter_6_0, iter_6_1 in pairs(arg_6_1.RecordList) do
			if table.getn(var_6_1) > CHAT_MAX_LINE then
				table.remove(var_6_1, 1)
			end

			table.insert(var_6_1, iter_6_1)
		end
	end

	if zbUtil:isValidTable(var_6_1) ~= nil and var_6_0 ~= "" then
		zbChatHelp:saveChatInfoTofile(var_6_1, var_6_0)
	end
end

function var_0_0.getPrivateChatData(arg_7_0, arg_7_1)
	return (zbChatHelp:getPlayerChatInfo(arg_7_1))
end

function var_0_0.loadChatObjList(arg_8_0)
	arg_8_0.chatobjList = {}

	local var_8_0 = zbChatHelp:getChatPlayerList()

	if zbUtil:isValidTable(var_8_0) then
		for iter_8_0 = 1, table.getn(var_8_0) do
			table.insert(arg_8_0.chatobjList, var_8_0[iter_8_0])
		end
	end
end

function var_0_0.addChatObjList(arg_9_0, arg_9_1)
	if arg_9_1.playerId == g_GameData.BaseInfo.PlayerId then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.chatobjList) do
		if iter_9_1.playerId == arg_9_1.playerId then
			table.remove(arg_9_0.chatobjList, iter_9_0)

			break
		end
	end

	if table.getn(arg_9_0.chatobjList) >= CHAT_MAX_OBJECT then
		table.remove(arg_9_0.chatobjList, 1)
	end

	table.insert(arg_9_0.chatobjList, 1, arg_9_1)
	zbChatHelp:saveChatPlayerList(arg_9_0.chatobjList)
end

function var_0_0.delChatObjList(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.chatobjList) do
		if iter_10_1.playerId == arg_10_1 then
			table.remove(arg_10_0.chatobjList, iter_10_0)

			break
		end
	end

	zbChatHelp:saveChatPlayerList(arg_10_0.chatobjList)
end

function var_0_0.isInObjectList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.chatobjList) do
		if iter_11_1.playerId == arg_11_1.SenderId then
			iter_11_1.Level = arg_11_1.SenderLevel
			iter_11_1.VipLevel = arg_11_1.SenderVipLevel
			iter_11_1.RoleName = arg_11_1.SenderName
			iter_11_1.HeadId = arg_11_1.SenderHeadId

			return true
		end
	end

	return false
end

function var_0_0.onLoginChatNtf(arg_12_0, arg_12_1)
	local function var_12_0(arg_13_0)
		local var_13_0 = {}

		if type(arg_13_0) == "table" then
			for iter_13_0, iter_13_1 in pairs(arg_13_0) do
				table.insert(var_13_0, 1, iter_13_1)
			end
		end

		return var_13_0
	end

	if zbUtil:isValidTable(arg_12_1.ChatWorldRecord) then
		local var_12_1 = var_12_0(arg_12_1.ChatWorldRecord)

		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			arg_12_0:insert2WorldChat(iter_12_1)
		end
	end

	if zbUtil:isValidTable(arg_12_1.ChatLegionRecord) then
		local var_12_2 = var_12_0(arg_12_1.ChatLegionRecord)

		for iter_12_2, iter_12_3 in pairs(var_12_2) do
			iter_12_3.scroll = 0

			arg_12_0:insert2CityChat(iter_12_3)
		end
	end

	if zbUtil:isValidTable(arg_12_1.ChatSystemRecord) then
		local var_12_3 = var_12_0(arg_12_1.ChatSystemRecord)

		for iter_12_4, iter_12_5 in pairs(var_12_3) do
			iter_12_5.scroll = 0

			arg_12_0:insert2SysChat(iter_12_5)
		end
	end

	arg_12_0:loadChatObjList()

	if zbUtil:isValidTable(arg_12_1.ChatPrivateRecord) then
		for iter_12_6, iter_12_7 in pairs(arg_12_1.ChatPrivateRecord) do
			if zbUtil:isValidTable(iter_12_7.RecordList) then
				iter_12_7.RecordList = var_12_0(iter_12_7.RecordList)
			end

			arg_12_0:newPrivateChat(iter_12_7)

			if not arg_12_0:isInPrivateRecord(iter_12_7.SenderId) then
				table.insert(arg_12_0.notifyChat_private, iter_12_7.SenderId)
			end

			if not arg_12_0:isInObjectList(iter_12_7) then
				local var_12_4 = {
					Level = iter_12_7.SenderLevel,
					VipLevel = iter_12_7.SenderVipLevel,
					RoleName = iter_12_7.SenderName,
					HeadId = iter_12_7.SenderHeadId,
					playerId = iter_12_7.SenderId
				}

				arg_12_0:addChatObjList(var_12_4)
			end
		end
	end
end

function var_0_0.onNewChatNtf(arg_14_0, arg_14_1)
	arg_14_0.notifyChat = false
	arg_14_0.chatNtf = arg_14_1

	if arg_14_0.chatNtf then
		if arg_14_0.chatNtf.ChatType == EChatType.EWorld then
			if arg_14_0.chatNtf.IsHorn == 1 then
				table.insert(arg_14_0.hornChats, arg_14_0.chatNtf)
				g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_Horn)

				local var_14_0 = {
					ScrollType = EScrollNotifyType.LegionHongbao
				}

				var_14_0.Priority = 1
				var_14_0.Repeat = 1
				var_14_0.Interval = 0
				var_14_0.SysChat = 0
				var_14_0.Content = a2u("[color=0xFF0000]С\xC0\xAE\xB0\xC8 [/color][color=0x61E23E]") .. arg_14_0.chatNtf.SenderName .. a2u(":[/color]") .. arg_14_0.chatNtf.ChatMsg
				var_14_0.Tm = arg_14_0.chatNtf.ChatTm

				g_Broadcast:refresh(var_14_0)
			end

			arg_14_0:insert2WorldChat(arg_14_0.chatNtf)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_Ntf)
		elseif arg_14_0.chatNtf.ChatType == EChatType.ESystem then
			arg_14_0:insert2SysChat(arg_14_0.chatNtf)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_Ntf)
		elseif arg_14_0.chatNtf.ChatType == EChatType.ELegion then
			arg_14_0:insert2CityChat(arg_14_0.chatNtf)

			arg_14_0.notifyChat_legion = true

			g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_Ntf)
		elseif arg_14_0.chatNtf.ChatType == EChatType.EPrivate then
			local var_14_1 = {
				SenderId = arg_14_1.SenderId,
				SenderName = arg_14_1.SenderName,
				SenderLevel = arg_14_1.SenderLevel,
				SenderVipLevel = arg_14_1.SenderVipLevel,
				SenderHeadId = arg_14_1.SenderHeadId,
				RecordList = {}
			}

			table.insert(var_14_1.RecordList, arg_14_1)
			arg_14_0:newPrivateChat(var_14_1)

			if not arg_14_0:isInObjectList(arg_14_1) and g_GameData.BaseInfo.PlayerId ~= arg_14_1.SenderId then
				local var_14_2 = {
					Level = arg_14_1.SenderLevel,
					VipLevel = arg_14_1.SenderVipLevel,
					RoleName = arg_14_1.SenderName,
					HeadId = arg_14_1.SenderHeadId,
					playerId = arg_14_1.SenderId
				}

				arg_14_0:addChatObjList(var_14_2)
				g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_NewPrivateMsg)
			else
				g_GameEventMgr:sendEvent(zbGameEvent.Event_Chat_Ntf)
			end

			if g_GameData.BaseInfo.PlayerId ~= arg_14_1.SenderId and not arg_14_0:isInPrivateRecord(arg_14_1.SenderId) then
				table.insert(arg_14_0.notifyChat_private, arg_14_1.SenderId)
			end
		end
	end
end

function var_0_0.delPrivateRecord(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.notifyChat_private) do
		if iter_15_1 == arg_15_1 then
			table.remove(arg_15_0.notifyChat_private, iter_15_0)

			break
		end
	end
end

function var_0_0.isInPrivateRecord(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.notifyChat_private) do
		if iter_16_1 == arg_16_1 then
			return true
		end
	end

	return false
end

function var_0_0.insert2WorldChat(arg_17_0, arg_17_1)
	if table.getn(arg_17_0.worldChats) >= CHAT_MAX_LINE then
		table.remove(arg_17_0.worldChats, 1)
	end

	table.insert(arg_17_0.worldChats, arg_17_1)
end

function var_0_0.insert2CityChat(arg_18_0, arg_18_1)
	if table.getn(arg_18_0.cityChats) >= CHAT_MAX_LINE then
		table.remove(arg_18_0.cityChats, 1)
	end

	table.insert(arg_18_0.cityChats, arg_18_1)
end

function var_0_0.insert2SysChat(arg_19_0, arg_19_1)
	if table.getn(arg_19_0.systemChats) >= CHAT_MAX_LINE then
		table.remove(arg_19_0.systemChats, 1)
	end

	table.insert(arg_19_0.systemChats, arg_19_1)
end

function var_0_0.getChatDatasByType(arg_20_0, arg_20_1)
	if arg_20_1 == EChatType.EWorld then
		return arg_20_0.worldChats
	elseif arg_20_1 == EChatType.ELegion then
		return arg_20_0.cityChats
	elseif arg_20_1 == EChatType.ESystem then
		return arg_20_0.systemChats
	end

	return nil
end

function var_0_0.getChatObjectList(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.chatobjList) do
		if iter_21_1.playerId == g_GameData.BaseInfo.PlayerId then
			table.remove(arg_21_0.chatobjList, iter_21_0)
		end
	end

	return arg_21_0.chatobjList
end
