require("gamelogic.zbTabWnd")
require("gamelogic.zbEquipDetail_Upgrade")
require("gamelogic.zbEquipDetail_Enchant")
require("gamelogic.zbEquipDetail_Cuilian")
require("gamelogic.zbEquipDetail_Detail")
require("gamelogic.zbEquipDetail_StarUp")

zbEquipDetailWnd = class("zbEquipDetailWnd", zbTabWnd)
zbEquipDetailWnd.__index = zbEquipDetailWnd

function createEquipDetailWnd()
	local var_1_0 = zbEquipDetailWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbEquipDetailWnd.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbEquipDetailWnd)

	return arg_2_0
end

function zbEquipDetailWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.itemId = 0
		arg_3_0.heroTemplateId = 0
		arg_3_0.equipType = 1
		arg_3_0.dirty = false
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(130, 60)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local function var_5_1(arg_7_0)
			local var_7_0 = CCSprite:create("image/hero/hero_new.png")

			var_7_0:setAnchorPoint(ccp(0.5, 0.5))
			var_7_0:setPosition(arg_7_0:getContentSize().width - 20, arg_7_0:getContentSize().height / 2 + 20)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		local var_5_2 = CCBProxy:create()
		local var_5_3 = CCBReaderLoad("ccbi/equipDetail.ccbi", var_5_2, true, "HelloCocosBuilderLayerOwner")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLayer")
		local var_5_5 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")
		local var_5_6 = tolua.cast(var_5_4:getChildByTag(200), "CCLayer")
		local var_5_7 = {
			[EEquipForgeTab.Upgrade] = tolua.cast(var_5_5:getChildByTag(1), "CCControlButton"),
			[EEquipForgeTab.Emchant] = tolua.cast(var_5_5:getChildByTag(2), "CCControlButton"),
			[EEquipForgeTab.Cuilian] = tolua.cast(var_5_5:getChildByTag(3), "CCControlButton"),
			[EEquipForgeTab.StarUp] = tolua.cast(var_5_5:getChildByTag(4), "CCControlButton")
		}
		local var_5_8 = {
			[EEquipForgeTab.Upgrade] = tolua.cast(var_5_6:getChildByTag(4), "CCLayer"),
			[EEquipForgeTab.Emchant] = tolua.cast(var_5_6:getChildByTag(3), "CCLayer"),
			[EEquipForgeTab.Cuilian] = tolua.cast(var_5_6:getChildByTag(5), "CCLayer"),
			[EEquipForgeTab.StarUp] = tolua.cast(var_5_6:getChildByTag(6), "CCLayer")
		}
		local var_5_9 = {
			[EEquipForgeTab.Upgrade] = "image/tab/tab_equipforge_upgrade.png",
			[EEquipForgeTab.Emchant] = "image/tab/tab_equipforge_emchant.png",
			[EEquipForgeTab.Cuilian] = "image/tab/tab_equipforge_cuilian.png",
			[EEquipForgeTab.StarUp] = "image/tab/tab_equipforge_starup.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EEquipForgeTab.Upgrade] = createEquipDetail_Upgrade(var_5_8[EEquipForgeTab.Upgrade], arg_3_0)
		arg_3_0.module[EEquipForgeTab.Emchant] = createEquipDetail_Enchant(var_5_8[EEquipForgeTab.Emchant], arg_3_0)
		arg_3_0.module[EEquipForgeTab.Cuilian] = createEquipDetail_Cuilian(var_5_8[EEquipForgeTab.Cuilian], arg_3_0)
		arg_3_0.module[EEquipForgeTab.StarUp] = createEquipDetail_StarUp(var_5_8[EEquipForgeTab.StarUp], arg_3_0)
		arg_3_0.tabButtons = var_5_7

		arg_3_0:initTab(var_5_7, var_5_8, var_5_9)

		arg_3_0.detailPanel = createEquipDetail(tolua.cast(var_5_4:getChildByTag(4), "CCLayer"))
		arg_3_0.btnEmchant_Tag = var_5_0(var_5_7[EEquipForgeTab.Emchant])
		arg_3_0.btnCuilian_Tag = var_5_0(var_5_7[EEquipForgeTab.Cuilian])
		arg_3_0.strEmchantGuide = "EquipGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. EEquipForgeTab.Emchant

		if zbGameCore:Instance():getConfigValue(arg_3_0.strEmchantGuide) ~= 1 then
			arg_3_0.newEmchantOpen = var_5_1(var_5_7[EEquipForgeTab.Emchant])
		end

		arg_3_0.strCuilianGuide = "EquipGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. EEquipForgeTab.Cuilian

		if zbGameCore:Instance():getConfigValue(arg_3_0.strCuilianGuide) ~= 1 then
			arg_3_0.newCuilianOpen = var_5_1(var_5_7[EEquipForgeTab.Cuilian])
		end

		arg_3_0.strStarGuide = "EquipGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. EEquipForgeTab.StarUp

		if zbGameCore:Instance():getConfigValue(arg_3_0.strStarGuide) ~= 1 then
			arg_3_0.newStarOpen = var_5_1(var_5_7[EEquipForgeTab.StarUp])
		end

		arg_3_0:addChild(var_5_3)
		arg_3_0:createMoneyPanel(var_5_3, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.GemOpen
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshCurEquip()
	end, zbGameEvent.Event_Update_BagEquip)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshCurEquip()
	end, zbGameEvent.Event_Update_Hero)
end

function zbEquipDetailWnd.onShowCallback(arg_12_0)
	arg_12_0:selectTab(1)
end

function zbEquipDetailWnd.visibleNotify(arg_13_0)
	if arg_13_0.equipBaseData.Quality >= EItemQuality.Purple then
		zbUIEffect:centerHeroDetailBtn(arg_13_0.tabButtons, EEquipForgeTab.StarUp, false, 4)
	elseif arg_13_0.equipBaseData.Quality >= EItemQuality.Blue then
		zbUIEffect:centerHeroDetailBtn(arg_13_0.tabButtons, EEquipForgeTab.StarUp - 2, false, 4)
	else
		zbUIEffect:centerHeroDetailBtn(arg_13_0.tabButtons, EEquipForgeTab.StarUp - 3, false, 4)
	end

	arg_13_0.tabButtons[EEquipForgeTab.Emchant]:setGray(zbFunHelper:isLockNoTip(EFuncType.GemSet) or arg_13_0.equipBaseData.Quality < EItemQuality.Blue)
	arg_13_0.tabButtons[EEquipForgeTab.Cuilian]:setGray(zbFunHelper:isLockNoTip(EFuncType.Cuilian) or arg_13_0.equipBaseData.Quality < EItemQuality.Purple)
	arg_13_0.tabButtons[EEquipForgeTab.StarUp]:setGray(zbFunHelper:isLockNoTip(EFuncType.EquipUpStar) or arg_13_0.equipBaseData.Quality < EItemQuality.Purple)
	arg_13_0.btnEmchant_Tag:setVisible(g_Self.kBagEquipHandler:getEquipCanEnchant(arg_13_0.equipBaseData))
	arg_13_0.btnCuilian_Tag:setVisible(false)

	if arg_13_0.newEmchantOpen then
		local var_13_0 = zbGameCore:Instance():getConfigValue(arg_13_0.strEmchantGuide)

		arg_13_0.newEmchantOpen:setVisible(not zbFunHelper:isLockNoTip(EFuncType.GemSet) and var_13_0 ~= "1" and arg_13_0.equipBaseData.Quality >= EItemQuality.Blue)
	end

	if arg_13_0.newCuilianOpen then
		local var_13_1 = zbGameCore:Instance():getConfigValue(arg_13_0.strCuilianGuide)

		arg_13_0.newCuilianOpen:setVisible(not zbFunHelper:isLockNoTip(EFuncType.Cuilian) and var_13_1 ~= "1" and arg_13_0.equipBaseData.Quality >= EItemQuality.Purple)
	end

	if arg_13_0.newStarOpen then
		local var_13_2 = zbGameCore:Instance():getConfigValue(arg_13_0.strStarGuide)

		arg_13_0.newStarOpen:setVisible(not zbFunHelper:isLockNoTip(EFuncType.EquipUpStar) and var_13_2 ~= "1" and arg_13_0.equipBaseData.Quality >= EItemQuality.Purple)
	end
end

function zbEquipDetailWnd.doSelectTab(arg_14_0)
	if arg_14_0.module then
		arg_14_0.module[arg_14_0.currTab]:refresh(arg_14_0.heroTemplateId, arg_14_0.equipBaseData)
	end

	if arg_14_0.newEmchantOpen and arg_14_0.currTab == EEquipForgeTab.Emchant then
		arg_14_0.newEmchantOpen:setVisible(false)
		zbGameCore:Instance():setConfigValue(arg_14_0.strEmchantGuide, 1)
	end

	if arg_14_0.newCuilianOpen and arg_14_0.currTab == EEquipForgeTab.Cuilian then
		arg_14_0.newCuilianOpen:setVisible(false)
		zbGameCore:Instance():setConfigValue(arg_14_0.strCuilianGuide, 1)
	end

	if arg_14_0.newStarOpen and arg_14_0.currTab == EEquipForgeTab.StarUp then
		arg_14_0.newStarOpen:setVisible(false)
		zbGameCore:Instance():setConfigValue(arg_14_0.strStarGuide, 1)
	end
end

function zbEquipDetailWnd.refresh(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.equipBaseData = arg_15_1
	arg_15_0.heroTemplateId = arg_15_2

	arg_15_0:visibleNotify()

	if arg_15_3 == nil then
		arg_15_0:selectTab(EEquipForgeTab.Upgrade)
	end

	arg_15_0.detailPanel:refresh(arg_15_1, arg_15_2)
end

function zbEquipDetailWnd.refreshNotify(arg_16_0)
	local var_16_0 = g_Self.kBagHandler:hasInlay(arg_16_0.equip)

	arg_16_0.notifyGem:setVisible(var_16_0)

	return var_16_0
end

function zbEquipDetailWnd.playerOptSucEffect(arg_17_0, arg_17_1, arg_17_2)
	g_Self.kEffectUIHandler:playUIEffect(arg_17_1, arg_17_2)
end

function zbEquipDetailWnd.onLeft(arg_18_0)
	arg_18_0:gotoSelectEquip(true)
end

function zbEquipDetailWnd.onRight(arg_19_0)
	arg_19_0:gotoSelectEquip(false)
end

function zbEquipDetailWnd.refreshCurEquip(arg_20_0)
	if arg_20_0.isShow == false then
		return
	end

	arg_20_0.equipBaseData = g_Self.kBagEquipHandler:getItemFromHeroBagByItemId(arg_20_0.equipBaseData.EquipId)

	if arg_20_0.equipBaseData then
		arg_20_0.detailPanel:refresh(arg_20_0.equipBaseData, arg_20_0.heroTemplateId)
		arg_20_0:visibleNotify()
	end

	arg_20_0:selectTab(arg_20_0.currTab)

	if arg_20_0.module[arg_20_0.currTab] then
		arg_20_0.module[arg_20_0.currTab]:refresh(arg_20_0.heroTemplateId, arg_20_0.equipBaseData)
	end
end

function zbEquipDetailWnd.onFrameUpdate(arg_21_0)
	arg_21_0:updateBackEffect()
end

function zbEquipDetailWnd.bopen(arg_22_0, arg_22_1)
	if arg_22_1 == EEquipForgeTab.Emchant then
		if zbFunHelper:isLockAndTip(EFuncType.GemSet) then
			return false
		end

		if arg_22_0.equipBaseData.Quality < EItemQuality.Blue then
			g_Bubble:bubbleInfo("\xC0\xB6ɫ\xD2\xD4\xC9\xCFƷ\xD6ʿ\xC9\xD2\xD4װ\xB1\xB8\xB8\xBD\xC1\xE9")

			return false
		end
	elseif arg_22_1 == EEquipForgeTab.Cuilian then
		if zbFunHelper:isLockAndTip(EFuncType.Cuilian) then
			return false
		end

		if arg_22_0.equipBaseData.Quality < EItemQuality.Purple then
			g_Bubble:bubbleInfo("\xD7\xCFɫ\xD2\xD4\xC9\xCFƷ\xD6ʿ\xC9\xD2\xD4װ\xB1\xB8\xB4\xE3\xC1\xB6")

			return false
		end
	elseif arg_22_1 == EEquipForgeTab.StarUp then
		if zbFunHelper:isLockAndTip(EFuncType.EquipUpStar) then
			return false
		end

		if arg_22_0.equipBaseData.Quality < EItemQuality.Purple then
			g_Bubble:bubbleInfo("\xD7\xCFɫ\xD2\xD4\xC9\xCFƷ\xD6ʿ\xC9\xD2\xD4װ\xB1\xB8\xC9\xFD\xD0\xC7")

			return false
		end
	end

	return true
end
