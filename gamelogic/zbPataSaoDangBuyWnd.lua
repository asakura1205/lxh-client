require("gamelogic.zbBaseWnd")
require("gamelogic.zbPataWnd_BuffItem")
require("gamelogic.zbItem")
require("gamelogic.zbPataWnd_AwardItem")
require("gamelogic.zbPataBuffTxt")

local var_0_0 = class("zbPataSaoDangBuyWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPataSaoDangBuyWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.buffItems = {}
		arg_3_0.boxItems = {}
		arg_3_0.boxShowItems = {}
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pata_saodang_buy.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.buffLayer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.buffLayer:getChildByTag(0), "CCSprite")
		arg_3_0.lbFloor = tolua.cast(arg_3_0.spriteTitle:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbHintBuff = tolua.cast(arg_3_0.buffLayer:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnBuffNext = tolua.cast(arg_3_0.buffLayer:getChildByTag(5), "CCControlButton")

		local var_5_2 = tolua.cast(arg_3_0.buffLayer:getChildByTag(9), "CCNode")

		arg_3_0.layerBuff = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.btnBuffList = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.spritebuffBg = tolua.cast(var_5_2:getChildByTag(99), "CCSprite")
		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.layerBuff:getChildByTag(0), "CCControlButton")

		local var_5_3 = zbTableViewHelper:create()

		var_5_3:loadCCBFile("ccbi/tb_patabuff.ccbi")

		for iter_5_0 = 1, 3 do
			local var_5_4 = tolua.cast(arg_3_0.buffLayer:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_5 = zbPataWnd_BuffItem:create(translateAndStrokeHelper(var_5_3:readCCBNode()), EPataStateType.SaoDang)

			var_5_5:setPosition(var_5_4:getPosition())
			arg_3_0.buffLayer:addChild(var_5_5)

			arg_3_0.buffItems[iter_5_0] = var_5_5

			var_5_4:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBuffList:addHandleOfControlEvent(function()
			arg_3_0:onBuffList()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBuffNext:addHandleOfControlEvent(function()
			arg_3_0:onBuffNext()
		end, CCControlEventTouchUpInside)

		arg_3_0.awardLayer = tolua.cast(var_5_1:getChildByTag(2), "CCLayer")
		arg_3_0.lbHintAward = tolua.cast(arg_3_0.awardLayer:getChildByTag(1007), "CCLabelTTF")
		arg_3_0.btnAwardNext = tolua.cast(arg_3_0.awardLayer:getChildByTag(6), "CCControlButton")

		for iter_5_1 = 1, 3 do
			local var_5_6 = zbTableViewHelper:create()

			var_5_6:loadCCBFile("ccbi/tb_patabox.ccbi")

			local var_5_7 = tolua.cast(arg_3_0.awardLayer:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_8 = zbPataWnd_AwardItem:create(translateAndStrokeHelper(var_5_6:readCCBNode()), iter_5_1, EPataStateType.SaoDang)
			local var_5_9 = ccp(var_5_7:getPosition())

			var_5_8:setPosition(var_5_9.x, var_5_9.y - 15)
			arg_3_0.awardLayer:addChild(var_5_8)

			arg_3_0.boxItems[iter_5_1] = var_5_8

			var_5_7:removeFromParentAndCleanup(true)
			var_5_6:releaseSelf()
		end

		local var_5_10 = tolua.cast(arg_3_0.awardLayer:getChildByTag(5), "CCLayer")

		for iter_5_2 = 1, 3 do
			local var_5_11 = tolua.cast(var_5_10:getChildByTag(10 + iter_5_2), "CCLayerColor")
			local var_5_12 = createItem()

			var_5_12:setPosition(var_5_11:getPosition())
			var_5_12:setScale(0.8)
			var_5_10:addChild(var_5_12)

			arg_3_0.boxShowItems[iter_5_2] = var_5_12

			var_5_11:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnAwardNext:addHandleOfControlEvent(function()
			arg_3_0:onAwardNext()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.onTouchTest(arg_10_0)
	local var_10_0 = arg_10_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_10_0.layerBuff, var_10_0.x, var_10_0.y) == false then
		arg_10_0.layerBuff:setVisible(false)
		arg_10_0.spritebuffBg:setVisible(false)
	end
end

function var_0_0.refresh(arg_11_0, arg_11_1)
	arg_11_0.SaoDangInfo = arg_11_1

	if arg_11_0.SaoDangInfo.Index == EPataSaoDangStateType.Brand then
		arg_11_0.buffLayer:setVisible(false)
		arg_11_0.awardLayer:setVisible(true)
		arg_11_0:refreshBrand()
	else
		arg_11_0.buffLayer:setVisible(true)
		arg_11_0.awardLayer:setVisible(false)
		arg_11_0:refreshBuyBuff()
	end
end

function var_0_0.refreshBrand(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.boxItems) do
		iter_12_1:refresh(arg_12_0.SaoDangInfo.TurnBrandInfo.BrandList, arg_12_0.SaoDangInfo.TurnBrandInfo.Layer)
	end

	local var_12_0 = 1

	for iter_12_2, iter_12_3 in pairs(arg_12_0.SaoDangInfo.TurnBrandInfo.AwardList) do
		local var_12_1 = arg_12_0.boxShowItems[var_12_0]

		if var_12_1 ~= nil then
			var_12_1:refreshAward(iter_12_3.Type, iter_12_3.Id, iter_12_3.Count, false)

			var_12_0 = var_12_0 + 1
		end
	end

	arg_12_0.brandNum = 0

	for iter_12_4, iter_12_5 in pairs(zbPataLayerBaseTable.records) do
		if iter_12_5.layer <= g_GameData.PataInfo.BaseInfo.TodaySaoDangLayer and iter_12_5.layer > arg_12_0.SaoDangInfo.TurnBrandInfo.Layer and iter_12_5.layerType == EPataLayerType.Award then
			arg_12_0.brandNum = arg_12_0.brandNum + 1
		end
	end

	arg_12_0.lbHintAward:setString(a2u("\xBB\xB9\xD3\xD0") .. arg_12_0.brandNum .. a2u("\xB2㽱\xC0\xF8\xBFɼ\xA4\xBB\xEE"))
end

function var_0_0.refreshBuyBuff(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.SaoDangInfo.BuffLayerInfo.BuyList) do
		arg_13_0.buffItems[iter_13_1.SkillIndex]:refresh(iter_13_1)
	end

	arg_13_0.buffNum = 0

	for iter_13_2, iter_13_3 in pairs(zbPataLayerBaseTable.records) do
		if iter_13_3.layer <= g_GameData.PataInfo.BaseInfo.TodaySaoDangLayer and iter_13_3.layer > arg_13_0.SaoDangInfo.BuffLayerInfo.Layer and iter_13_3.layerType == EPataLayerType.Buff then
			arg_13_0.buffNum = arg_13_0.buffNum + 1
		end
	end

	arg_13_0.lbFloor:setString(a2u("\xB5\xDA ") .. arg_13_0.SaoDangInfo.BuffLayerInfo.Layer .. a2u(" \xB2\xE3"))
	arg_13_0.lbHintBuff:setString(a2u("\xBB\xB9\xD3\xD0") .. arg_13_0.buffNum .. a2u("\xB2\xE3\xD4\xF6\xD2\xE6Ч\xB9\xFB\xBFɼ\xA4\xBB\xEE"))
	arg_13_0.layerBuff:setVisible(false)
	arg_13_0.spritebuffBg:setVisible(false)
	arg_13_0:refreshBuffList()
end

function var_0_0.refreshBuffList(arg_14_0)
	if arg_14_0.tableView == nil then
		local var_14_0 = arg_14_0.layerBuff:getContentSize()

		arg_14_0.tableViewHelper = zbTableViewHelper:create()
		arg_14_0.tableView = zbTableViewHelper:createTableView(var_14_0, var_14_0, 1, arg_14_0.tableViewHelper)

		arg_14_0.tableView:setPosition(0, 0)
		arg_14_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_14_0.layerBuff:addChild(arg_14_0.tableView)
	else
		arg_14_0.tableViewHelper:removeAllCells()
	end

	local var_14_1 = table.getn(g_GameData.PataInfo.BaseInfo.BuffList)
	local var_14_2 = table.getn(arg_14_0.items)

	for iter_14_0 = 1, var_14_2 do
		if iter_14_0 <= var_14_1 then
			local var_14_3 = arg_14_0.items[iter_14_0]

			arg_14_0.tableViewHelper:addCell(var_14_3)
		end
	end

	if var_14_1 - var_14_2 > 0 then
		local var_14_4 = zbTableViewHelper:create()

		var_14_4:loadCCBFile("ccbi/tb_patabuff_txt.ccbi")

		for iter_14_1 = 1, var_14_1 - var_14_2 do
			local var_14_5 = zbPataBuffTxt:create(translateAndStrokeHelper(var_14_4:readCCBNode()), var_14_2 + iter_14_1)

			var_14_5:retain()

			arg_14_0.items[var_14_2 + iter_14_1] = var_14_5

			arg_14_0.tableViewHelper:addCell(var_14_5)
		end
	end

	local var_14_6 = 1

	for iter_14_2, iter_14_3 in pairs(g_GameData.PataInfo.BaseInfo.BuffList) do
		arg_14_0.items[var_14_6]:refresh(iter_14_3)

		var_14_6 = var_14_6 + 1
	end

	arg_14_0.tableViewHelper:refreshTabelView()
	arg_14_0.tableViewHelper:setTouchPriority(arg_14_0.btnBuffList:getTouchPriority())
end

function var_0_0.onBuffNext(arg_15_0)
	if arg_15_0.buffNum > 0 then
		g_WsMsgHandler:WS_Pata_SaoDangBuyBuffNext_Req()
	else
		g_WsMsgHandler:WS_Pata_SaoDangNext_Req()
	end
end

function var_0_0.onAwardNext(arg_16_0)
	if arg_16_0.brandNum > 0 then
		g_WsMsgHandler:WS_Pata_SaoDangTurnBrandNext_Req()
	else
		g_WsMsgHandler:WS_Pata_SaoDangNext_Req()
	end
end

function var_0_0.onBuffList(arg_17_0)
	arg_17_0.layerBuff:setVisible(true)
	arg_17_0.spritebuffBg:setVisible(true)
end
