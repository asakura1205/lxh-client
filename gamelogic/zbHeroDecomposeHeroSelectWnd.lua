require("gamelogic.zbHeroDesc")
require("gamelogic.zbHeroDecomposeHeroCard")
require("gamelogic.zbHeroDecomposeSelHero")

local var_0_0 = class("zbHeroDecomposeHeroSelectWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = CCSizeMake(620, 140)
local var_0_2 = 5
local var_0_3 = 5

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroDecomposeHeroSelectWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.selectCallback = nil
		arg_3_0.selectHeroDescList = {}
		arg_3_0.heroCardList = {}
		arg_3_0.heroDescList = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/hero_decompose_mat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerFrag = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.bottomLayer = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.selectNum = tolua.cast(arg_3_0.bottomLayer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnOk = tolua.cast(arg_3_0.bottomLayer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnOk:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.selHero = {}

		for iter_5_0 = 1, 5 do
			local var_5_3 = zbTableViewHelper:create()

			var_5_3:loadCCBFile("ccbi/tb_decomposeitem.ccbi")

			local var_5_4 = tolua.cast(arg_3_0.bottomLayer:getChildByTag(iter_5_0 * 10), "CCNode")

			var_5_4:setVisible(false)

			arg_3_0.selHero[iter_5_0] = createHeroDecomposeSelWnd(translateAndStrokeHelper(var_5_3:readCCBNode()))

			arg_3_0.selHero[iter_5_0]:setContentSize(CCSizeMake(110, 110))
			arg_3_0.selHero[iter_5_0]:setScale(0.7)

			local var_5_5 = ccp(var_5_4:getPosition())

			arg_3_0.selHero[iter_5_0]:setPosition(var_5_5.x, var_5_5.y)
			arg_3_0.bottomLayer:addChild(arg_3_0.selHero[iter_5_0])
			var_5_3:releaseSelf()
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	local function var_3_2()
		local var_9_0 = arg_3_0.layerFrag:getContentSize()
		local var_9_1 = zbTableViewHelper:create()
		local var_9_2 = zbTableViewHelper:createTableView(var_9_0, var_9_0, 1, var_9_1)

		var_9_2:setAnchorPoint(ccp(0, 0))
		var_9_1:createListView("ccbi/hero_decompose_hero_card.ccbi")
		arg_3_0.layerFrag:addChild(var_9_2)

		arg_3_0.listViewHelper = var_9_1
		arg_3_0.listView = var_9_2

		var_9_1:clear()
		var_9_1:refreshTabelView()
	end

	var_3_0()
	var_3_1()
	var_3_2()
	arg_3_0:reBuild()
end

function var_0_0.setCallback(arg_10_0, arg_10_1)
	arg_10_0.selectCallback = arg_10_1
end

function var_0_0.refresh(arg_11_0)
	arg_11_0:refreshHeroCards()
	arg_11_0:updateSelectHero()
	arg_11_0:rebuildHeroCards()
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:hide()

	if arg_12_0.selectCallback then
		arg_12_0.selectCallback(arg_12_0.selectHeroDescList)
	end
end

function var_0_0.reBuild(arg_13_0)
	arg_13_0:rebuildHeroCards()

	arg_13_0.selectHeroDescList = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroCardList) do
		iter_13_1:onSelect(false)
	end
end

function var_0_0.rebuildHeroCards(arg_14_0)
	arg_14_0.heroDescList = (function()
		local var_15_0 = {}
		local var_15_1 = {}
		local var_15_2 = g_GameData.HeroFragList

		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			local var_15_3 = createHerodesc()

			var_15_3.heroTemplateId = iter_15_1.TemplateId
			var_15_3.isSpeartor = false
			var_15_3.isFrag = true
			var_15_3.fragCount = iter_15_1.Count

			table.insert(var_15_0, var_15_3)
		end

		local function var_15_4(arg_16_0, arg_16_1)
			local var_16_0 = zbHeroTable:getRecord(arg_16_0.heroTemplateId)
			local var_16_1 = zbHeroTable:getRecord(arg_16_1.heroTemplateId)

			if var_16_0 and var_16_1 then
				return var_16_0.quality < var_16_1.quality
			else
				return false
			end
		end

		table.sort(var_15_0, var_15_4)

		return var_15_0
	end)()

	local var_14_0 = math.ceil(table.getn(arg_14_0.heroCardList) / var_0_2)
	local var_14_1 = math.ceil(table.getn(arg_14_0.heroDescList) / var_0_2)
	local var_14_2 = var_14_1 - var_14_0

	if math.abs(var_14_2) < 1 then
		return
	end

	if var_14_2 > 0 then
		for iter_14_0 = 1, var_14_1 - var_14_0 do
			local var_14_3 = arg_14_0.listViewHelper:addListItem()

			var_14_3:setContentSize(var_0_1)

			local var_14_4 = var_14_3:getChildByTag(1)

			translateAndStrokeHelper(var_14_4)

			local var_14_5 = tolua.cast(var_14_4:getChildByTag(1), "CCLayerColor")
			local var_14_6 = tolua.cast(var_14_4:getChildByTag(2), "CCLayerColor")
			local var_14_7 = tolua.cast(var_14_4:getChildByTag(3), "CCLayerColor")
			local var_14_8 = tolua.cast(var_14_4:getChildByTag(4), "CCLayerColor")
			local var_14_9 = tolua.cast(var_14_4:getChildByTag(5), "CCLayerColor")

			arg_14_0.heroCardList[table.getn(arg_14_0.heroCardList) + 1] = createHeroDecomposeHeroCard(var_14_5)
			arg_14_0.heroCardList[table.getn(arg_14_0.heroCardList) + 1] = createHeroDecomposeHeroCard(var_14_6)
			arg_14_0.heroCardList[table.getn(arg_14_0.heroCardList) + 1] = createHeroDecomposeHeroCard(var_14_7)
			arg_14_0.heroCardList[table.getn(arg_14_0.heroCardList) + 1] = createHeroDecomposeHeroCard(var_14_8)
			arg_14_0.heroCardList[table.getn(arg_14_0.heroCardList) + 1] = createHeroDecomposeHeroCard(var_14_9)
		end
	else
		local var_14_10 = {}
		local var_14_11 = {}

		for iter_14_1 = 1, var_14_0 - var_14_1 do
			table.insert(var_14_11, (iter_14_1 - 1) * var_0_2 + 1)
			table.insert(var_14_11, (iter_14_1 - 1) * var_0_2 + 2)
			table.insert(var_14_11, (iter_14_1 - 1) * var_0_2 + 3)
			table.insert(var_14_11, (iter_14_1 - 1) * var_0_2 + 4)
			table.insert(var_14_11, (iter_14_1 - 1) * var_0_2 + 5)
			table.insert(var_14_10, iter_14_1 - 1)
		end

		for iter_14_2 = #var_14_10, 1, -1 do
			arg_14_0.listViewHelper:removeCellAtIndex(var_14_10[iter_14_2], true)
		end

		for iter_14_3 = #var_14_11, 1, -1 do
			table.remove(arg_14_0.heroCardList, var_14_11[iter_14_3])
		end
	end

	arg_14_0.listViewHelper:refreshTabelView()
	arg_14_0.listViewHelper:setTouchPriority(arg_14_0.btnClose:getTouchPriority())
end

function var_0_0.refreshHeroCards(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.heroCardList) do
		iter_17_1:setVisible(false)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.heroDescList) do
		arg_17_0.heroCardList[iter_17_2]:setVisible(true)
		arg_17_0.heroCardList[iter_17_2]:refresh(iter_17_3)
		arg_17_0.heroCardList[iter_17_2]:setSelectCallback(arg_17_0.selectCallback)
	end
end

function var_0_0.selectHero(arg_18_0, arg_18_1)
	if table.getn(arg_18_0.selectHeroDescList) >= var_0_3 then
		return
	end

	table.insert(arg_18_0.selectHeroDescList, arg_18_1)
	arg_18_0:updateSelectHero()
end

function var_0_0.unSelectHero(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.selectHeroDescList) do
		if arg_19_1.heroDesc.heroTemplateId == iter_19_1.heroDesc.heroTemplateId and iter_19_1.heroDesc.isFrag == arg_19_1.heroDesc.isFrag then
			table.remove(arg_19_0.selectHeroDescList, iter_19_0)

			break
		end
	end

	arg_19_0:updateSelectHero()
end

function var_0_0.isSelect(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.selectHeroDescList) do
		if arg_20_1.heroDesc.heroTemplateId == iter_20_1.heroDesc.heroTemplateId and iter_20_1.heroDesc.isFrag == arg_20_1.heroDesc.isFrag then
			return true
		end
	end

	return false
end

function var_0_0.updateSelectHero(arg_21_0)
	local var_21_0 = table.getn(arg_21_0.selectHeroDescList)

	arg_21_0.selectNum:setString(a2u("(" .. var_21_0 .. "/" .. var_0_3) .. a2u(")"))

	for iter_21_0 = 1, 5 do
		arg_21_0.selHero[iter_21_0]:setVisible(false)
	end

	local var_21_1 = 1

	for iter_21_1, iter_21_2 in pairs(arg_21_0.selectHeroDescList) do
		local var_21_2 = {
			awardType = ECommonAwardType.HeroFrag,
			awardId = iter_21_2.heroDesc.heroTemplateId,
			awardCount = iter_21_2.count
		}

		arg_21_0.selHero[var_21_1]:refresh(var_21_2)
		arg_21_0.selHero[var_21_1]:setVisible(true)

		var_21_1 = var_21_1 + 1
	end
end

function var_0_0.setSelectdList(arg_22_0, arg_22_1)
	arg_22_0.selectHeroDescList = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		arg_22_0.selectHeroDescList[iter_22_0] = iter_22_1
	end

	arg_22_0:updateSelectHero()
	arg_22_0:refresh()
end

function var_0_0.onTouchTest(arg_23_0)
	local var_23_0 = arg_23_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_23_0.layerTouchTest, var_23_0.x, var_23_0.y) == false and zbUtil:PointInCtrl(arg_23_0.btnClose, var_23_0.x, var_23_0.y) == false then
		arg_23_0:hide()
	end
end
