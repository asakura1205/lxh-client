local var_0_0 = class("zbFriendHandler")

var_0_0.__index = var_0_0

local var_0_1 = {
	"intimacy1.png",
	"intimacy2.png",
	"intimacy3.png",
	"intimacy4.png",
	"intimacy5.png",
	"intimacy6.png"
}

function createFriendHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.frienddata = nil
	arg_2_0.bfriendinfoReq = false
	arg_2_0.bfriendBaseFormationInfoReq = false
	arg_2_0.bfriendNotify = false
	arg_2_0.bossList = {}
	arg_2_0.curBossInfo = nil
	arg_2_0.newBossInfo = nil
	arg_2_0.hitStat = 0
	arg_2_0.haveNewFriendBoss = false
	arg_2_0.firstInJhUI = false
end

function var_0_0.openFriend(arg_3_0)
	arg_3_0.bfriendNotify = false

	if arg_3_0.frienddata == nil then
		arg_3_0.bfriendinfoReq = true

		g_WsMsgHandler:WS_Friends_GetData_Req()

		return
	end

	g_MainScene:showFriendWnd()
end

function var_0_0.haveNewBoss(arg_4_0)
	if arg_4_0.haveNewFriendBoss == true and arg_4_0.newBossInfo and arg_4_0.newBossInfo.BossRoleId == g_Self:getPlayerId() then
		arg_4_0.haveNewFriendBoss = false

		g_MainScene:showFriendBossWnd(arg_4_0.newBossInfo)

		return true
	end

	return false
end

function var_0_0.updateFriendinfo(arg_5_0, arg_5_1)
	arg_5_0.frienddata = arg_5_1

	if arg_5_1 == nil then
		return
	end

	local var_5_0 = true

	if arg_5_0.frienddata == nil then
		var_5_0 = false
	end

	if var_5_0 and arg_5_0.bfriendinfoReq then
		g_MainScene:showFriendWnd()

		arg_5_0.bfriendinfoReq = false

		return
	end
end

function var_0_0.updateFriendBossinfo(arg_6_0, arg_6_1)
	arg_6_0.bossList = arg_6_1.BossInfo.BossList
end

function var_0_0.addFriendBossinfo(arg_7_0, arg_7_1)
	table.insert(arg_7_0.bossList, arg_7_1.BossInfo)
end

function var_0_0.getFriendJhList(arg_8_0)
	local var_8_0 = {}

	if arg_8_0.frienddata then
		var_8_0 = arg_8_0.frienddata.FriendsList
	end

	local function var_8_1(arg_9_0, arg_9_1)
		if arg_9_0.FriendsBaseData.ActionCount == arg_9_1.FriendsBaseData.ActionCount then
			return arg_9_0.FriendsBaseData.Level > arg_9_1.FriendsBaseData.Level
		else
			return arg_9_0.FriendsBaseData.ActionCount < arg_9_1.FriendsBaseData.ActionCount
		end
	end

	table.sort(var_8_0, var_8_1)

	return var_8_0
end

function var_0_0.clearFriendsApplyList(arg_10_0)
	if arg_10_0.frienddata then
		arg_10_0.frienddata.FriendsApplyList = {}
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendApplyAck)
end

function var_0_0.delFriendsApplyListById(arg_11_0, arg_11_1)
	if arg_11_0.frienddata then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.frienddata.FriendsApplyList) do
			if iter_11_1.PlayerBaseInfo.PlayerId == arg_11_1 then
				table.remove(arg_11_0.frienddata.FriendsApplyList, iter_11_0)
				g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendApplyAck)

				return
			end
		end
	end
end

function var_0_0.delFriendsById(arg_12_0, arg_12_1)
	if arg_12_0.frienddata then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.frienddata.FriendsList) do
			if iter_12_1.PlayerBaseInfo.PlayerId == arg_12_1 then
				table.remove(arg_12_0.frienddata.FriendsList, iter_12_0)
				g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)

				return
			end
		end
	end
end

function var_0_0.passFriendApply(arg_13_0, arg_13_1)
	if arg_13_0.frienddata and arg_13_1 then
		table.insert(arg_13_0.frienddata.FriendsList, arg_13_1.FriendsDetail)
	end

	local var_13_0 = arg_13_1.FriendsDetail.PlayerBaseInfo.PlayerId

	arg_13_0:delFriendsApplyListById(var_13_0)
end

function var_0_0.updateFriendsData(arg_14_0, arg_14_1)
	if arg_14_0.frienddata then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.frienddata.FriendsList) do
			if iter_14_1.PlayerBaseInfo.PlayerId == arg_14_1.PlayerBaseInfo.PlayerId then
				arg_14_0.frienddata.FriendsList[iter_14_0] = arg_14_1

				return
			end
		end
	end
end

function var_0_0.updateFriendsBaseInfo(arg_15_0, arg_15_1)
	if arg_15_0.frienddata then
		arg_15_0.frienddata.FriendsBaseInfo = arg_15_1
	end
end

function var_0_0.updateFriendList(arg_16_0, arg_16_1)
	if arg_16_0.frienddata and zbUtil:isValidTable(arg_16_1) then
		arg_16_0.frienddata.FriendsList = arg_16_1
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)
end

function var_0_0.getFriendInfoById(arg_17_0, arg_17_1)
	if arg_17_0.frienddata then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.frienddata.FriendsList) do
			if iter_17_1.PlayerBaseInfo.PlayerId == arg_17_1 then
				return iter_17_1
			end
		end
	end

	return nil
end

function var_0_0.getFriendlyByLv(arg_18_0, arg_18_1)
	local var_18_0 = 0

	if zbUtil:isValidTable(g_DataConfig.m_kCommonCfg.friendsConfig.friendsLevel) then
		for iter_18_0, iter_18_1 in pairs(g_DataConfig.m_kCommonCfg.friendsConfig.friendsLevel) do
			if iter_18_1.level == arg_18_1 then
				var_18_0 = iter_18_1.friendly

				return var_18_0
			end
		end
	end

	return var_18_0
end

function var_0_0.getActionInfo(arg_19_0, arg_19_1)
	if zbUtil:isValidTable(g_DataConfig.m_kCommonCfg.friendsConfig.friendsAction) then
		for iter_19_0, iter_19_1 in pairs(g_DataConfig.m_kCommonCfg.friendsConfig.friendsAction) do
			if iter_19_1.actionType == arg_19_1 then
				return iter_19_1
			end
		end
	end

	return nil
end

function var_0_0.hasFriendsApply(arg_20_0)
	if arg_20_0.frienddata then
		local var_20_0 = zbVipTable:getRecord(g_Self:getVipLevel())
		local var_20_1 = 20

		if var_20_0 then
			var_20_1 = var_20_0.friendsNum
		end

		local var_20_2 = false

		if var_20_1 <= table.getn(arg_20_0.frienddata.FriendsList) then
			var_20_2 = true
		end

		if table.getn(arg_20_0.frienddata.FriendsApplyList) > 0 and not var_20_2 then
			return true
		end
	end

	return false
end

function var_0_0.hasFriendsTiliNotify(arg_21_0)
	if arg_21_0.frienddata then
		if arg_21_0.frienddata.FriendsBaseInfo.TiliCount >= g_DataConfig.m_kCommonCfg.friendsConfig.tiliMax then
			return false
		end

		for iter_21_0, iter_21_1 in pairs(arg_21_0.frienddata.FriendsList) do
			if iter_21_1.FriendsBaseData.GiveTili == 0 or iter_21_1.FriendsBaseData.GetTili == 0 and g_GameData.Wealth.Tili < g_GameData.CapacityInfo.Tili then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasFriendsJhNotify(arg_22_0)
	if arg_22_0.frienddata and zbUtil:isValidTable(arg_22_0.frienddata.FriendsList) then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.frienddata.FriendsList) do
			if iter_22_1.FriendsBaseData and iter_22_1.FriendsBaseData.ActionCount <= 0 and g_Self.kFriendHandler.firstInJhUI == false then
				return true
			end
		end
	end

	return false
end

function var_0_0.setIntimacyIcon(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_23_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/friend.plist")

	if var_0_1[arg_23_2] then
		local var_23_0 = arg_23_0.spriteframeCache:spriteFrameByName(var_0_1[arg_23_2])

		if var_23_0 then
			arg_23_1:initWithSpriteFrame(var_23_0)
		end
	end
end
