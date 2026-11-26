require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroExtraAttrItem")
require("gamelogic.zbItem")

zbHeroExtraAttrWnd = class("zbHeroExtraAttrWnd", zbBaseWnd)
zbHeroExtraAttrWnd.__index = zbHeroExtraAttrWnd

function zbHeroExtraAttrWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroExtraAttrWnd)

	return arg_1_0
end

function createHeroExtraAttrWnd()
	local var_2_0 = zbHeroExtraAttrWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroExtraAttrWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroExtraAttr.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		var_5_3:setVisible(false)

		arg_3_0.useItem = createItem()

		local var_5_4 = ccp(var_5_3:getPosition())

		arg_3_0.useItem:setPosition(var_5_3:getPosition())
		arg_3_0.useItem:setNeedTip(true)
		arg_3_0.useItem:setScale(0.4)
		var_5_2:addChild(arg_3_0.useItem)

		arg_3_0.lbNumDummy = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(3), "CCLayer")
		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumDummy, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.55)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_Hero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_FragHero)
end

function zbHeroExtraAttrWnd.refresh(arg_10_0, arg_10_1)
	arg_10_0.useItem:refreshAward(ECommonAwardType.HeroFrag, arg_10_1.HeroBaseInfo.TemplateId, 0, false)

	local var_10_0 = g_Self.kHeroFragHandler:getHeroFragCount(arg_10_1.HeroBaseInfo.TemplateId)

	arg_10_0.lbNum:setString(var_10_0)

	arg_10_0.heroDetail = arg_10_1

	if arg_10_0.tableView == nil then
		local var_10_1 = arg_10_0.layerContent:getContentSize()

		arg_10_0.tableViewHelper = zbTableViewHelper:create()
		arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_1, var_10_1, 1, arg_10_0.tableViewHelper)

		arg_10_0.tableView:setPosition(0, 0)
		arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_10_0.layerContent:addChild(arg_10_0.tableView)
	else
		arg_10_0.tableViewHelper:removeAllCells()
	end

	arg_10_0.record = zbHeroTable:getRecord(arg_10_1.HeroBaseInfo.TemplateId)

	if arg_10_0.record == nil then
		return
	end

	arg_10_0.extraAttrRecord = zbHeroExtraAttrUpgradeTable:getRecord(arg_10_0.record.extraAttrUpId)

	if arg_10_0.extraAttrRecord == nil then
		return
	end

	local var_10_2 = table.getn(arg_10_1.CastList)
	local var_10_3 = table.getn(arg_10_0.items)

	for iter_10_0 = 1, var_10_3 do
		if iter_10_0 <= var_10_2 then
			local var_10_4 = arg_10_0.items[iter_10_0]

			arg_10_0.tableViewHelper:addCell(var_10_4)
		end
	end

	if var_10_2 - var_10_3 > 0 then
		for iter_10_1 = 1, var_10_2 - var_10_3 do
			local var_10_5 = zbTableViewHelper:create()

			var_10_5:loadCCBFile("ccbi/tb_ExtraAttr.ccbi")

			local var_10_6 = zbHeroExtraAttrItem:create(translateAndStrokeHelper(var_10_5:readCCBNode()), arg_10_0)

			var_10_6:retain()

			arg_10_0.items[var_10_3 + iter_10_1] = var_10_6

			arg_10_0.tableViewHelper:addCell(var_10_6)
			var_10_5:releaseSelf()
		end
	end

	local var_10_7 = 1

	for iter_10_2, iter_10_3 in pairs(arg_10_1.CastList) do
		arg_10_0.items[var_10_7]:refresh(iter_10_3, arg_10_0.extraAttrRecord, arg_10_1.HeroBaseInfo.TemplateId)

		var_10_7 = var_10_7 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function zbHeroExtraAttrWnd.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end

function zbHeroExtraAttrWnd.refreshUpdate(arg_12_0)
	if arg_12_0.isShow == false then
		return
	end

	if arg_12_0.heroDetail ~= nil then
		arg_12_0.heroDetail = g_Self.kHeroHandler:getHeroByTemplateId(arg_12_0.heroDetail.HeroBaseInfo.TemplateId)

		if arg_12_0.heroDetail == nil then
			arg_12_0:hide()

			return
		end

		arg_12_0:refresh(arg_12_0.heroDetail)
	else
		arg_12_0:hide()
	end
end
