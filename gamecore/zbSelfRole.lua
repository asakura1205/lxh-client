require("gamecore.zbTimeHandler")
require("gamecore.zbWealthHandler")
require("gamecore.zbHeroHandler")
require("gamecore.zbBagItemHandler")
require("gamecore.zbBagEquipHandler")
require("gamecore.zbHeroFragHandler")
require("gamecore.zbEquipFragHandler")
require("gamecore.zbTaskHandler")
require("gamecore.zbDailyHandler")
require("gamecore.zbRedPointHandler")
require("gamecore.zbChatHandler")
require("gamecore.zbMailHandler")
require("gamecore.zbRankHandler")
require("gamecore.zbGetWayHandler")
require("gamecore.zbShopHandler")
require("gamecore.zbGiftHandler")
require("gamecore.zbSevenHandler")
require("gamecore.zbGmActivityHandler")
require("gamecore.zbFarmHandler")
require("gamecore.zbTechHandler")
require("gamecore.zbWarPathHandler")
require("gamecore.zbActivityHandler")
require("gamecore.zbGodHandler")
require("gamecore.zbArenaHandler")
require("gamecore.zbPubHandler")
require("gamecore.zbFriendHandler")
require("gamecore.zbPataHandler")
require("gamecore.zbHeroTrialHandler")
require("gamecore.zbLegionHandler")
require("gamecore.zbDataChange")
require("gamecore.zbFormation")
require("gamecore.zbYuanzhengHandler")
require("gamecore.zbWorldHandler")
require("gamecore.zbVipHandler")
require("gamecore.zbTreaSureHandler")
require("gamecore.zbHeroSoulHallHandler")
require("gamecore.zbSetHandler")

local var_0_0 = class("zbSelfRole")

var_0_0.__index = var_0_0

function createSelfRole()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.initFightPower = 0
	arg_2_0.kDataChange = createDataChange()
	arg_2_0.kSetHandler = createSetHandler()
	arg_2_0.kTimeHandler = createTimeHandler()
	arg_2_0.kWealthHandler = createWealthHandler()
	arg_2_0.kHeroHandler = createHeroHandler()
	arg_2_0.kBagItemHandler = createBagItemHandler()
	arg_2_0.kBagEquipHandler = createBagEquipHandler()
	arg_2_0.kHeroFragHandler = createHeroFragHandler()
	arg_2_0.kEquipFragHandler = createEquipFragHandler()
	arg_2_0.kTaskHandler = createTaskHandler()
	arg_2_0.kDailyHandler = createDailyHandler()
	arg_2_0.kRedPointHandler = createRedPointHandler()
	arg_2_0.kChatHandler = createChatHandler()
	arg_2_0.kMailHandler = createMailHandler()
	arg_2_0.kRankHandler = createRankHandler()
	arg_2_0.kGetWayHandler = createGetWayHandler()
	arg_2_0.kShopHandler = createShopHandler()
	arg_2_0.kGiftHandler = createGiftHandler()
	arg_2_0.kSevenHandler = createSevenHandler()
	arg_2_0.kGmActivityHandler = createGmActivityHandler()
	arg_2_0.kFarmHandler = createFarmHandler()
	arg_2_0.kTechHandler = createTechHandler()
	arg_2_0.kWarPathHandler = createWarPathHandler()
	arg_2_0.kActivityHandler = createActivityHandler()
	arg_2_0.kGodHandler = createGodHandler()
	arg_2_0.kArenaHandler = createArenaHandler()
	arg_2_0.kPubHandler = createPubHandler()
	arg_2_0.kFriendHandler = createFriendHandler()
	arg_2_0.kPataHandler = createPataHandler()
	arg_2_0.kYuanzhengHandler = createYuanzhengHandler()
	arg_2_0.kLegionHandler = createLegionHandler()
	arg_2_0.kHeroTrialHandler = createHeroTrialHandler()
	arg_2_0.kWorldHandler = createWorldHandler()
	arg_2_0.kVipHandler = createVipHandler()
	arg_2_0.kTreaSureHandler = createTreaSureHandler()
	arg_2_0.kHeroSoulHallHandler = createHeroSoulHallHandler()
	arg_2_0.initFightPower = arg_2_0:getFightValue()
	arg_2_0.kFormation = createFormation()
	arg_2_0.needShowLevelUp = false
	arg_2_0.firstPassForce = false
end

function var_0_0.free(arg_3_0)
	arg_3_0.kWealthHandler = nil
	arg_3_0.kHeroHandler = nil
	arg_3_0.kBagItemHandler = nil
	arg_3_0.kBagEquipHandler = nil
	arg_3_0.kHeroFragHandler = nil
	arg_3_0.kEquipFragHandler = nil
	arg_3_0.kTaskHandler = nil
	arg_3_0.kRedPointHandler = nil
	arg_3_0.kTimeHandler = nil
	arg_3_0.kSetHandler = nil
	arg_3_0.kChatHandler = nil
	arg_3_0.kCityHandler = nil
	arg_3_0.kMailHandler = nil
	arg_3_0.kRankHandler = nil
	arg_3_0.kGetWayHandler = nil
	arg_3_0.kShopHandler = nil
	arg_3_0.kGiftHandler = nil
	arg_3_0.kSevenHandler = nil
	arg_3_0.kGmActivityHandler = nil
	arg_3_0.kFarmHandler = nil
	arg_3_0.kTechHandler = nil
	arg_3_0.kWarPathHandler = nil
	arg_3_0.kActivityHandler = nil
	arg_3_0.kGodHandler = nil
	arg_3_0.kArenaHandler = nil
	arg_3_0.kPubHandler = nil
	arg_3_0.kFriendHandler = nil
	arg_3_0.kPataHandler = nil
	arg_3_0.kHeroTrialHandler = nil
	arg_3_0.kYuanzhengHandler = nil
	arg_3_0.kLegionHandler = nil
	arg_3_0.kWorldHandler = nil
	arg_3_0.kVipHandler = nil
	arg_3_0.kTreaSureHandler = nil
	arg_3_0.kHeroSoulHallHandler = nil
end

function var_0_0.onAfterEnterGame(arg_4_0)
	arg_4_0.kFormation:updateServerFormation(g_GameData.Formation, g_GameData.GodInfo)
	arg_4_0.kRedPointHandler:refreshAll()
	arg_4_0.kGmActivityHandler:refreshTime()
	arg_4_0:refreshEveryDay()
end

function var_0_0.refreshEveryDay(arg_5_0)
	local var_5_0 = zbUtil:SprintfYYYYMMDD(g_Self.kTimeHandler:getServerTime())
	local var_5_1 = zbGameCore:Instance():getConfigValue("currTime")

	if var_5_1 == "" or var_5_1 ~= var_5_0 then
		zbGameCore:Instance():setConfigValue("DiamondSingleTime", 0)
		zbGameCore:Instance():setConfigValue("DiamondTenTime", 0)
	end

	zbGameCore:Instance():setConfigValue("currTime", var_5_0)
end

function var_0_0.update(arg_6_0, arg_6_1)
	arg_6_0.kWealthHandler:update(arg_6_1)
	arg_6_0.kRedPointHandler:update(arg_6_1)
	arg_6_0.kChatHandler:update(arg_6_1)
	arg_6_0.kGmActivityHandler:update(arg_6_1)
	arg_6_0.kFarmHandler:update(arg_6_1)
	arg_6_0.kLegionHandler:update(arg_6_1)
	arg_6_0.kWorldHandler:update(arg_6_1)
	arg_6_0.kSevenHandler:update(arg_6_1)
end

function var_0_0.updateBaseInfo(arg_7_0, arg_7_1)
	if zbUtil:isValidTable(arg_7_1) == false then
		return
	end

	local var_7_0 = g_GameData.BaseInfo.Level
	local var_7_1 = g_GameData.BaseInfo.VipLevel

	g_GameData.BaseInfo = arg_7_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BaseInfo)

	if var_7_0 < g_GameData.BaseInfo.Level then
		arg_7_0.needShowLevelUp = true

		g_Self.kRedPointHandler:refreshTech()
	end

	if var_7_1 < g_GameData.BaseInfo.VipLevel and g_MainScene then
		g_MainScene:showVipLevelUpWnd()
	end
end

function var_0_0.updateCapacityInfo(arg_8_0, arg_8_1)
	if zbUtil:isValidTable(arg_8_1) == false then
		return
	end

	g_GameData.CapacityInfo = arg_8_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_CapacityInfo)
end

function var_0_0.isNeedShowLevelUp(arg_9_0)
	return arg_9_0.needShowLevelUp
end

function var_0_0.setNeedShowLevelUp(arg_10_0, arg_10_1)
	arg_10_0.needShowLevelUp = arg_10_1
end

function var_0_0.isFirstPassForce(arg_11_0)
	return arg_11_0.firstPassForce
end

function var_0_0.setFirstPassForce(arg_12_0, arg_12_1)
	arg_12_0.firstPassForce = arg_12_1
end

function var_0_0.updateGameEnvInfo(arg_13_0, arg_13_1)
	g_GameData.GameEnvInfo = arg_13_1

	arg_13_0.kTimeHandler:setServerTime(g_GameData.GameEnvInfo.ServTime)
end

function var_0_0.getName(arg_14_0)
	return g_GameData.BaseInfo.RoleName
end

function var_0_0.getPlayerId(arg_15_0)
	return g_GameData.BaseInfo.PlayerId
end

function var_0_0.getLevel(arg_16_0)
	return g_GameData.BaseInfo.Level
end

function var_0_0.getVipLevel(arg_17_0)
	return g_GameData.BaseInfo.VipLevel
end

function var_0_0.getFightValue(arg_18_0)
	return g_GameData.Formation.FV
end

function var_0_0.getAvatarId(arg_19_0)
	return g_GameData.BaseInfo.AvatarId
end
