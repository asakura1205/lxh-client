require("gamelogic.zbBaseWnd")
require("gamelogic.zbWarPathItem")

local var_0_0 = class("zbWarPathWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createWarPathWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.items = {}
		arg_3_0.bgDouble = {}
	end

	local function var_3_1(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_5_0:getContentSize()
		local var_5_1 = zbTableViewHelper:create()
		local var_5_2 = zbTableViewHelper:createTableView(var_5_0, var_5_0, kCCScrollViewDirectionHorizontal, var_5_1)

		var_5_2:setPosition(0, 0)
		var_5_2:setAnchorPoint(ccp(0, 0))
		arg_5_0:addChild(var_5_2)
		var_5_1:clear()
		var_5_1:setMaskPanel(arg_5_2, arg_5_3, nil, nil)
		zbUIEffect:runFadeToAction(arg_5_2)
		zbUIEffect:runFadeToAction(arg_5_3)

		arg_3_0.count = table.getn(zbForceTable.records)

		for iter_5_0, iter_5_1 in pairs(zbForceTable.records) do
			local var_5_3 = zbTableViewHelper:create()

			var_5_3:loadCCBFile("ccbi/tb_warpathitem.ccbi")

			local var_5_4 = createWarPathItem(arg_3_0, translateAndStrokeHelper(var_5_3:readCCBNode()), iter_5_1.id)

			var_5_1:addCell(var_5_4)
			table.insert(arg_3_0.items, var_5_4)
			var_5_3:releaseSelf()
		end

		var_5_1:refreshTabelView()

		arg_3_0.tableviewHelper = var_5_1
	end

	local function var_3_2()
		local function var_6_0(arg_7_0, arg_7_1)
			zbUtil:setButtonTitle(arg_7_0, "")

			local var_7_0 = CCSprite:create(arg_7_1)

			var_7_0:setAnchorPoint(ccp(0.5, 0.5))
			var_7_0:setPosition(arg_7_0:getContentSize().width / 2, arg_7_0:getContentSize().height / 2)
			arg_7_0:addChild(var_7_0)

			return var_7_0
		end

		local var_6_1 = CCBProxy:create()
		local var_6_2 = CCBReaderLoad("ccbi/warpath.ccbi", var_6_1, true, "HelloCocosBuilderLayerOwner")
		local var_6_3 = tolua.cast(var_6_2:getChildByTag(1), "CCNode")
		local var_6_4 = tolua.cast(var_6_3:getChildByTag(1), "CCNode")
		local var_6_5 = tolua.cast(var_6_3:getChildByTag(2), "CCNode")
		local var_6_6 = tolua.cast(var_6_3:getChildByTag(3), "CCNode")

		var_3_1(var_6_4, var_6_3, var_6_5, var_6_6)

		local var_6_7 = tolua.cast(var_6_2:getChildByTag(2), "CCNode")

		arg_3_0.layerLevelMode = var_6_7
		arg_3_0.btnNormal = tolua.cast(var_6_7:getChildByTag(1), "CCControlButton")
		arg_3_0.btnElite = tolua.cast(var_6_7:getChildByTag(2), "CCControlButton")
		arg_3_0.btnHard = tolua.cast(var_6_7:getChildByTag(4), "CCControlButton")
		arg_3_0.spriteLock = tolua.cast(var_6_7:getChildByTag(3), "CCSprite")
		arg_3_0.spriteHardLock = tolua.cast(var_6_7:getChildByTag(5), "CCSprite")

		local var_6_8 = {
			[ELevelType.Normal] = "image/tab/tab_level_normal.png",
			[ELevelType.Elite] = "image/tab/tab_level_elite.png",
			[ELevelType.Nightmare] = "image/tab/tab_level_nightmare.png"
		}

		arg_3_0.tabImagePaths = var_6_8

		local var_6_9 = {
			[ELevelType.Normal] = var_6_0(arg_3_0.btnNormal, var_6_8[ELevelType.Normal]),
			[ELevelType.Elite] = var_6_0(arg_3_0.btnElite, var_6_8[ELevelType.Elite]),
			[ELevelType.Nightmare] = var_6_0(arg_3_0.btnHard, var_6_8[ELevelType.Nightmare])
		}

		arg_3_0.tabSprites = var_6_9
		arg_3_0.bgDouble[ELevelType.Normal] = tolua.cast(var_6_7:getChildByTag(6), "CCSprite")
		arg_3_0.bgDouble[ELevelType.Elite] = tolua.cast(var_6_7:getChildByTag(7), "CCSprite")
		arg_3_0.bgDouble[ELevelType.Nightmare] = tolua.cast(var_6_7:getChildByTag(8), "CCSprite")

		arg_3_0.btnNormal:addHandleOfControlEvent(function()
			arg_3_0:onNormal()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnElite:addHandleOfControlEvent(function()
			arg_3_0:onElite()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnHard:addHandleOfControlEvent(function()
			arg_3_0:onHard()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_6_2)
		arg_3_0:addBtnChat(var_6_2)
		arg_3_0:createMoneyPanel(var_6_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Tili
		}, function()
			arg_3_0:hide()
		end)
	end

	local function var_3_3()
		local function var_12_0(arg_13_0)
			local var_13_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_13_0:setAnchorPoint(ccp(0.5, 0.5))
			var_13_0:setPosition(arg_13_0:getContentSize().width - 25, arg_13_0:getContentSize().height / 2 + 20)
			var_13_0:setVisible(false)
			arg_13_0:addChild(var_13_0)
			zbUIEffect:createNotifyTagScaleAction(var_13_0)

			return var_13_0
		end

		arg_3_0.spriteNormalNotifyTag = var_12_0(arg_3_0.btnNormal)
		arg_3_0.spriteEliteNotifyTag = var_12_0(arg_3_0.btnElite)
		arg_3_0.spriteHardNotifyTag = var_12_0(arg_3_0.btnHard)

		arg_3_0.spriteEliteNotifyTag:retain()
	end

	var_3_0()
	var_3_2()
	var_3_3()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.doDestroy(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
		iter_15_1:releaseBg()
	end
end

function var_0_0.onHide(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.items) do
		iter_16_1:releaseBg()
	end
end

function var_0_0.refresh(arg_17_0, arg_17_1)
	arg_17_0.levelType = -1

	local var_17_0 = zbFunctionUnlockTable:getRecord(EFuncType.EliteLevel)

	if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, var_17_0.requireForce, zbForceSetTable:getLastLevelId(var_17_0.requireForce)) <= 0 then
		arg_17_0.btnElite:setGray(true)
		arg_17_0.spriteLock:setVisible(true)
	else
		arg_17_0.btnElite:setGray(false)
		arg_17_0.spriteLock:setVisible(false)
	end

	local var_17_1 = zbFunctionUnlockTable:getRecord(EFuncType.NightmareLevel)

	if g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, var_17_1.requireForce, zbForceSetTable:getLastLevelId(var_17_1.requireForce)) <= 0 then
		arg_17_0.btnHard:setGray(true)
		arg_17_0.spriteHardLock:setVisible(true)
	else
		arg_17_0.btnHard:setGray(false)
		arg_17_0.spriteHardLock:setVisible(false)
	end

	if arg_17_1 ~= nil then
		arg_17_0:setMode(arg_17_1)
	else
		arg_17_0:setMode(ELevelType.Normal)
	end

	arg_17_0.bgDouble[ELevelType.Normal]:setVisible(g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.ForceNormal) ~= nil)
	arg_17_0.bgDouble[ELevelType.Elite]:setVisible(g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.ForceElite) ~= nil)
	arg_17_0.bgDouble[ELevelType.Nightmare]:setVisible(g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.ForceNightmare) ~= nil)
end

function var_0_0.onNormal(arg_18_0)
	arg_18_0:setMode(ELevelType.Normal)
end

function var_0_0.onElite(arg_19_0)
	arg_19_0:setMode(ELevelType.Elite)
end

function var_0_0.onHard(arg_20_0)
	arg_20_0:setMode(ELevelType.Nightmare)
end

function var_0_0.setMode(arg_21_0, arg_21_1)
	if arg_21_0.levelType == arg_21_1 then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.items) do
			iter_21_1:refreshBg()
		end

		return
	end

	if arg_21_1 == ELevelType.Elite then
		local var_21_0 = zbFunctionUnlockTable:getRecord(EFuncType.EliteLevel)

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, var_21_0.requireForce, zbForceSetTable:getLastLevelId(var_21_0.requireForce)) <= 0 then
			g_MainScene:showLockTipWnd(EFuncType.EliteLevel)

			arg_21_1 = ELevelType.Normal
		end
	end

	if arg_21_1 == ELevelType.Nightmare then
		local var_21_1 = zbFunctionUnlockTable:getRecord(EFuncType.NightmareLevel)

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, var_21_1.requireForce, zbForceSetTable:getLastLevelId(var_21_1.requireForce)) <= 0 then
			g_MainScene:showLockTipWnd(EFuncType.NightmareLevel)

			arg_21_1 = arg_21_0.levelType
		end
	end

	arg_21_0.levelType = arg_21_1

	arg_21_0.btnNormal:setEnabled(arg_21_0.levelType ~= ELevelType.Normal)
	arg_21_0.btnElite:setEnabled(arg_21_0.levelType ~= ELevelType.Elite)
	arg_21_0.btnHard:setEnabled(arg_21_0.levelType ~= ELevelType.Nightmare)

	for iter_21_2, iter_21_3 in pairs(arg_21_0.items) do
		iter_21_3:refresh(arg_21_0.levelType)
	end

	arg_21_0:refreshRedPointTag()

	local var_21_2 = 0
	local var_21_3 = zbForceTable:getMaxForceId()

	for iter_21_4 = 1, var_21_3 do
		if g_Self.kWarPathHandler:isVisibleForce(arg_21_0.levelType, iter_21_4) == false then
			break
		end

		var_21_2 = var_21_2 + 1
	end

	arg_21_0.tableviewHelper:refreshTabelView()

	if var_21_2 > 4 then
		zbUtil:setTableViewOffset(arg_21_0.tableviewHelper, kCCScrollViewDirectionHorizontal, kCCTableViewFillBottomUp, 1, arg_21_0.count, 258, var_21_2 - 4)
	end

	for iter_21_5 = ELevelType.Normal, ELevelType.Nightmare do
		if arg_21_1 == iter_21_5 then
			arg_21_0.tabSprites[iter_21_5]:setGray(false)
		else
			arg_21_0.tabSprites[iter_21_5]:setGray(true)
		end
	end
end

function var_0_0.refreshRedPointTag(arg_22_0)
	local function var_22_0(arg_23_0)
		if arg_23_0 ~= ELevelType.Normal and arg_22_0.spriteLock:isVisible() or arg_23_0 == ELevelType.Nightmare and arg_22_0.spriteHardLock:isVisible() then
			return false
		end

		for iter_23_0, iter_23_1 in pairs(arg_22_0.items) do
			if g_Self.kWarPathHandler:hasAvailableForceAward(arg_23_0, iter_23_1.forceId) then
				return true
			end

			if arg_23_0 == ELevelType.Normal and g_Self.kTreaSureHandler:hasRedPoint(iter_23_1.forceId) then
				return true
			end
		end

		return false
	end

	arg_22_0.spriteNormalNotifyTag:setVisible(var_22_0(ELevelType.Normal))
	arg_22_0.spriteEliteNotifyTag:setVisible(var_22_0(ELevelType.Elite))
	arg_22_0.spriteHardNotifyTag:setVisible(var_22_0(ELevelType.Nightmare))
end

function var_0_0.onFrameUpdate(arg_24_0, arg_24_1)
	arg_24_0:updateBackEffect()
end
