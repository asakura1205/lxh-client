zbLinkHelper = {}

function zbLinkHelper.execLink(arg_1_0, arg_1_1)
	if arg_1_1 == "activity" then
		arg_1_0:openActivity()
	elseif arg_1_1 == "daily" then
		arg_1_0:openDaily()
	elseif arg_1_1 == "arena" then
		arg_1_0:opArena()
	elseif arg_1_1 == "trial" then
		arg_1_0:openTrial()
	elseif arg_1_1 == "tech" then
		arg_1_0:openTech()
	elseif arg_1_1 == "world" then
		arg_1_0:openWorld()
	elseif arg_1_1 == "bgz" then
		arg_1_0:openBgz()
	elseif arg_1_1 == "pata" then
		arg_1_0:openPata()
	elseif arg_1_1 == "normalLevel" then
		arg_1_0:openNormalLevel()
	elseif arg_1_1 == "eliteLevel" then
		arg_1_0:openEliteLevel()
	elseif arg_1_1 == "nightmareLevel" then
		arg_1_0:openNightmareLevel()
	elseif arg_1_1 == "farm" then
		arg_1_0:openFarm()
	elseif arg_1_1 == "shop" then
		arg_1_0:openShop()
	elseif arg_1_1 == "pub" then
		arg_1_0:openPub()
	elseif arg_1_1 == "exchangeGold" then
		arg_1_0:openExchangeGold()
	elseif arg_1_1 == "exchangeFood" then
		arg_1_0:openExchangeFood()
	elseif arg_1_1 == "equip" or arg_1_1 == "fuling" or arg_1_1 == "cuilian" or arg_1_1 == "upstars" then
		arg_1_0:openEquip()
	elseif arg_1_1 == "friend" then
		arg_1_0:openFriend()
	elseif arg_1_1 == "hero" or arg_1_1 == "xilian" or arg_1_1 == "fate" or arg_1_1 == "suicong" then
		arg_1_0:openHero()
	elseif arg_1_1 == "legion" then
		arg_1_0:openLegion()
	elseif arg_1_1 == "equipDecompose" or arg_1_1 == "bagualu" then
		arg_1_0:openEquipDecompose()
	elseif arg_1_1 == "huilu" then
		g_MainScene:showHeroReset()
	elseif arg_1_1 == "friendboss" then
		arg_1_0:openFriendBoss()
	elseif arg_1_1 == "yaollingge" then
		arg_1_0:openHeroSoul()
	elseif arg_1_1 == "magic" then
		arg_1_0:openGod()
	end
end

function zbLinkHelper.openActivity(arg_2_0)
	return
end

function zbLinkHelper.openDaily(arg_3_0)
	if zbFunHelper:isLockAndTip(EFuncType.DailyTask) then
		return
	end

	g_MainScene:showTaskWnd(ETaskType.Daily)
end

function zbLinkHelper.opArena(arg_4_0)
	if zbFunHelper:isLockAndTip(EFuncType.Arena) then
		return
	end

	g_MainScene:showArenaWnd()
end

function zbLinkHelper.openTrial(arg_5_0)
	if zbFunHelper:isLockAndTip(EFuncType.Trial) then
		return
	end

	g_Self.kHeroTrialHandler:openHeroTrial()
end

function zbLinkHelper.openTech(arg_6_0)
	if zbFunHelper:isLockAndTip(EFuncType.Tech) then
		return
	end

	g_MainScene:showTechWnd()
end

function zbLinkHelper.openHeroSoul(arg_7_0)
	if zbFunHelper:isLockAndTip(EFuncType.HeroSoul) then
		return
	end

	g_MainScene:showHeroSoulHall()
end

function zbLinkHelper.openGod(arg_8_0)
	if zbFunHelper:isLockAndTip(EFuncType.God) then
		return
	end

	g_MainScene:showGodWnd()
end

function zbLinkHelper.openWorld(arg_9_0)
	if zbFunHelper:isLockAndTip(EFuncType.World) then
		return
	end

	g_MainScene:showWorld()
end

function zbLinkHelper.openBgz(arg_10_0)
	if zbFunHelper:isLockAndTip(EFuncType.Bgz) then
		return
	end

	g_Self.kYuanzhengHandler:openYuanzheng()
end

function zbLinkHelper.openPata(arg_11_0)
	if zbFunHelper:isLockAndTip(EFuncType.Pata) then
		return
	end

	g_Self.kPataHandler:openPata()
end

function zbLinkHelper.openNormalLevel(arg_12_0)
	g_MainScene:showWarPath(ELevelType.Normal)
end

function zbLinkHelper.openEliteLevel(arg_13_0)
	if zbFunHelper:isLockAndTip(EFuncType.EliteLevel) then
		return
	end

	g_MainScene:showWarPath(ELevelType.Elite)
end

function zbLinkHelper.openNightmareLevel(arg_14_0)
	if zbFunHelper:isLockAndTip(EFuncType.NightmareLevel) then
		return
	end

	g_MainScene:showWarPath(ELevelType.Nightmare)
end

function zbLinkHelper.openFarm(arg_15_0)
	g_MainScene:showFarmWnd()
end

function zbLinkHelper.openShop(arg_16_0)
	if zbFunHelper:isLockAndTip(EFuncType.Shop) then
		return
	end

	g_MainScene:showShopWnd()
end

function zbLinkHelper.openPub(arg_17_0)
	g_MainScene:showPubWnd()
end

function zbLinkHelper.openExchangeGold(arg_18_0)
	g_MainScene:showGoldenTouch(EExchangeType.Gold)

	return true
end

function zbLinkHelper.openExchangeFood(arg_19_0)
	g_MainScene:showGoldenTouch(EExchangeType.Food)

	return true
end

function zbLinkHelper.openEquip(arg_20_0)
	g_MainScene:showEquipListWnd()

	return true
end

function zbLinkHelper.openFriend(arg_21_0)
	if zbFunHelper:isLockAndTip(EFuncType.Friends) then
		return
	end

	g_Self.kFriendHandler:openFriend()
end

function zbLinkHelper.openFriendBoss(arg_22_0)
	if zbFunHelper:isLockAndTip(EFuncType.FriendsBoss) then
		return
	end

	g_WsMsgHandler:WS_FriendsBoss_GetInfo_Req(true)
end

function zbLinkHelper.openHero(arg_23_0)
	g_MainScene:showHeroListWnd()
end

function zbLinkHelper.openLegion(arg_24_0)
	if zbFunHelper:isLockAndTip(EFuncType.Legion) then
		return
	end

	if g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
		g_MainScene:showLegionSceneWnd()
	else
		g_MainScene:showLegionNoWnd()
	end
end

function zbLinkHelper.openEquipDecompose(arg_25_0)
	if zbFunHelper:isLockAndTip(EFuncType.Smelt) then
		return
	end

	g_MainScene:showEquipDecompose()
end
