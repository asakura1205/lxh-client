local var_0_0 = class("zbRedPointHandler")

var_0_0.__index = var_0_0

function createRedPointHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.wawajiState = g_GameData.Wealth.DollsMoney > 0
	arg_2_0.stateList = {}

	for iter_2_0 = 1, ERedPointType.E_MAX do
		arg_2_0.stateList[iter_2_0] = REDPOINT_STATE_CLOSE
	end
end

function var_0_0.update(arg_3_0, arg_3_1)
	if g_GameStateMachine:isOneSecondPassed() then
		g_Self.kRedPointHandler:refreshGod()
		g_Self.kRedPointHandler:refreshPub()
		g_Self.kRedPointHandler:refreshFriend()
	end
end

function var_0_0.setStateValue(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.stateList[arg_4_1] = arg_4_2
end

function var_0_0.getStateValue(arg_5_0, arg_5_1)
	return arg_5_0.stateList[arg_5_1]
end

function var_0_0.hasRedPoint(arg_6_0, arg_6_1)
	return arg_6_0.stateList[arg_6_1] == REDPOINT_STATE_OPEN
end

function var_0_0.refreshAll(arg_7_0)
	arg_7_0:refreshHero()
	arg_7_0:refreshBag()
	arg_7_0:refreshEquip()
	arg_7_0:refreshFriend()
	arg_7_0:refreshLegion()
	arg_7_0:refreshMail()
	arg_7_0:refreshTask()
	arg_7_0:refreshArena()
	arg_7_0:refreshChat()
	arg_7_0:refreshTech()
	arg_7_0:refreshHeroTrial()
	arg_7_0:refreshBgz()
	arg_7_0:refreshWorld()
	arg_7_0:refreshGameLevel()
	arg_7_0:refreshPub()
	arg_7_0:refreshFormation()
	arg_7_0:refreshGod()
end

function var_0_0.refreshHero(arg_8_0)
	local var_8_0 = REDPOINT_STATE_CLOSE

	if g_Self.kHeroHandler:getAllHeroNotify() == true then
		var_8_0 = REDPOINT_STATE_OPEN
	end

	arg_8_0:setStateValue(ERedPointType.Hero, var_8_0)
end

function var_0_0.refreshBag(arg_9_0)
	local var_9_0 = REDPOINT_STATE_CLOSE

	if g_Self.kBagItemHandler:hasBox() then
		var_9_0 = REDPOINT_STATE_OPEN
	end

	arg_9_0:setStateValue(ERedPointType.Bag, var_9_0)
end

function var_0_0.refreshEquip(arg_10_0)
	local var_10_0 = REDPOINT_STATE_CLOSE

	for iter_10_0 = EEquipBagTab.Weapon, EEquipBagTab.Magic do
		if g_Self.kEquipFragHandler:hasFragNotify(iter_10_0) == true or g_Self.kBagEquipHandler:getCanEnchant(iter_10_0) then
			var_10_0 = REDPOINT_STATE_OPEN

			break
		end
	end

	arg_10_0:setStateValue(ERedPointType.Equip, var_10_0)
end

function var_0_0.refreshFriend(arg_11_0)
	if zbFunHelper:isLockNoTip(EFuncType.Friends) == false and (g_Self.kFriendHandler:hasFriendsApply() or g_Self.kFriendHandler:hasFriendsTiliNotify() or g_Self.kFriendHandler:hasFriendsJhNotify()) then
		arg_11_0:setStateValue(ERedPointType.Friend, REDPOINT_STATE_OPEN)
	else
		arg_11_0:setStateValue(ERedPointType.Friend, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshLegion(arg_12_0)
	if g_Self.kLegionHandler.hasNotify then
		arg_12_0:setStateValue(ERedPointType.Legion, REDPOINT_STATE_OPEN)
	else
		arg_12_0:setStateValue(ERedPointType.Legion, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshMail(arg_13_0)
	local var_13_0 = REDPOINT_STATE_CLOSE

	if g_Self.kMailHandler:hasAward() then
		var_13_0 = REDPOINT_STATE_OPEN
	end

	arg_13_0:setStateValue(ERedPointType.Mail, var_13_0)
end

function var_0_0.refreshTask(arg_14_0)
	if g_Self.kTaskHandler:hasFinishTask() or g_Self.kDailyHandler:hasFinishDaily() then
		arg_14_0:setStateValue(ERedPointType.Task, REDPOINT_STATE_OPEN)
	else
		arg_14_0:setStateValue(ERedPointType.Task, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshArena(arg_15_0)
	if g_Self.kArenaHandler:hasArenaCanFight() and zbFunHelper:isBuildingLockNoTip(EBuildingType.Arena) == false then
		arg_15_0:setStateValue(ERedPointType.Arena, REDPOINT_STATE_OPEN)
	else
		arg_15_0:setStateValue(ERedPointType.Arena, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshChat(arg_16_0)
	if g_Self.kChatHandler.notifyChat and zbFunHelper:isLockNoTip(EFuncType.Chat) == false then
		arg_16_0:setStateValue(ERedPointType.Chat, REDPOINT_STATE_OPEN)
	else
		arg_16_0:setStateValue(ERedPointType.Chat, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshTech(arg_17_0)
	if g_Self.kTechHandler:hasTechCanUpgrade() and zbFunHelper:isBuildingLockNoTip(EBuildingType.Tech) == false then
		arg_17_0:setStateValue(ERedPointType.Tech, REDPOINT_STATE_OPEN)
	else
		arg_17_0:setStateValue(ERedPointType.Tech, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshHeroTrial(arg_18_0)
	local var_18_0 = REDPOINT_STATE_CLOSE

	for iter_18_0, iter_18_1 in pairs(zbHeroTrialBaseTable.records) do
		if g_Self.kHeroTrialHandler:hasChallengeNotify(iter_18_1.trialId) and zbFunHelper:isBuildingLockNoTip(EBuildingType.Trial) == false then
			var_18_0 = REDPOINT_STATE_OPEN

			break
		end
	end

	var_18_0 = var_18_0 or arg_18_0.wawajiState

	arg_18_0:setStateValue(ERedPointType.HeroTrial, var_18_0)
end

function var_0_0.refreshBgz(arg_19_0)
	local var_19_0 = zbFunHelper:isLockNoTip(EFuncType.Pata) == false and (g_GameData.PataInfo.BaseInfo.Layer == 1 or g_Self.kPataHandler:getLayerType(g_GameData.PataInfo.BaseInfo.Layer) == EPataLayerType.Award or g_Self.kPataHandler:getJiFenNotify())

	if var_19_0 == false then
		var_19_0 = zbFunHelper:isLockNoTip(EFuncType.Bgz) == false and g_GameData.BgzInfo.CurLevel < 9 and (g_GameData.BgzInfo.CurLevel == 1 or g_GameData.BgzInfo.State == 1 or g_Self.kYuanzhengHandler:getJiFenNotify())
	end

	if var_19_0 then
		arg_19_0:setStateValue(ERedPointType.Bgz, REDPOINT_STATE_OPEN)
	else
		arg_19_0:setStateValue(ERedPointType.Bgz, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshWorld(arg_20_0)
	if g_Self.kWorldHandler.worldhasNotify then
		arg_20_0:setStateValue(ERedPointType.World, REDPOINT_STATE_OPEN)
	else
		arg_20_0:setStateValue(ERedPointType.World, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshGameLevel(arg_21_0)
	if g_Self.kWarPathHandler:hasAvailableAward() then
		arg_21_0:setStateValue(ERedPointType.GameLevel, REDPOINT_STATE_OPEN)
	else
		arg_21_0:setStateValue(ERedPointType.GameLevel, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshPub(arg_22_0)
	if g_Self.kPubHandler:isCanFreeBarDraw() then
		arg_22_0:setStateValue(ERedPointType.Pub, REDPOINT_STATE_OPEN)
	else
		arg_22_0:setStateValue(ERedPointType.Pub, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshGod(arg_23_0)
	if g_Self.kGodHandler:isGodCanLevelUp() then
		arg_23_0:setStateValue(ERedPointType.GodLevelUp, REDPOINT_STATE_OPEN)
	else
		arg_23_0:setStateValue(ERedPointType.GodLevelUp, REDPOINT_STATE_CLOSE)
	end

	if g_Self.kGodHandler:isGodCanStarUp() then
		arg_23_0:setStateValue(ERedPointType.GodStarUp, REDPOINT_STATE_OPEN)
	else
		arg_23_0:setStateValue(ERedPointType.GodStarUp, REDPOINT_STATE_CLOSE)
	end

	if g_Self.kGodHandler:haveGodSkillCanUp() then
		arg_23_0:setStateValue(ERedPointType.GodSkillUp, REDPOINT_STATE_OPEN)
	else
		arg_23_0:setStateValue(ERedPointType.GodSkillUp, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.refreshFormation(arg_24_0)
	local var_24_0 = g_Self.kFormation:getWorkingHeroCount()
	local var_24_1 = g_Self.kHeroHandler:getHeroCount()
	local var_24_2 = false

	if var_24_0 < var_24_1 and var_24_0 < 5 then
		var_24_2 = true
	elseif g_Self.kFormation:hasEmptyParter() and table.getn(g_Self.kHeroHandler:getNoUseHeros()) > 0 then
		var_24_2 = true
	end

	if var_24_2 then
		arg_24_0:setStateValue(ERedPointType.Formation, REDPOINT_STATE_OPEN)
	else
		arg_24_0:setStateValue(ERedPointType.Formation, REDPOINT_STATE_CLOSE)
	end
end

function var_0_0.hasBagItemGiftTip(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(g_GameData.BagItemList) do
		local var_25_0 = zbItemTable:getRecord(EquipBaseData.TemplateId)

		if var_25_0 ~= nil and var_25_0.class == EItemType.EItemType_Gift and var_25_0.subClass ~= 2 then
			return true
		end
	end

	return false
end
