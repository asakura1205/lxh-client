require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbGodStarUpWnd", zbBaseWnd)

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

function createGodStarUpWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.curGodInfo = nil
		arg_3_0.limitCostItem = false
		arg_3_0.getWayId = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/godstarup.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.curstar = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.nextstar = tolua.cast(var_5_3:getChildByTag(2), "CCSprite")
		arg_3_0.openskillDesc = tolua.cast(var_5_3:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.openskillName = tolua.cast(var_5_3:getChildByTag(10), "CCLabelTTF")

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.curpower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.curpower)
		arg_3_0.curpower:setScale(0.7)

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.nextpower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.nextpower)
		arg_3_0.nextpower:setScale(0.7)

		local var_5_6 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnStarUp = tolua.cast(var_5_6:getChildByTag(1), "CCControlButton")

		arg_3_0.btnStarUp:addHandleOfControlEvent(function()
			arg_3_0:onStarUp()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeCost = var_5_6
		arg_3_0.items = {}
		arg_3_0.itemsNum = {}

		for iter_5_0 = 1, 2 do
			local var_5_7 = tolua.cast(var_5_6:getChildByTag(iter_5_0 + 1), "CCLayerColor")
			local var_5_8 = createItem()
			local var_5_9 = ccp(var_5_7:getPosition())

			var_5_8:setScale(0.8)
			var_5_8:setPosition(var_5_9.x + 10, var_5_9.y + 20)
			var_5_6:addChild(var_5_8)

			arg_3_0.items[iter_5_0] = var_5_8

			var_5_7:removeFromParentAndCleanup(true)

			arg_3_0.itemsNum[iter_5_0] = tolua.cast(var_5_6:getChildByTag(iter_5_0 + 3), "CCLabelTTF")
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_GodInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_GoldTouch_Ack)
end

function var_0_0.doShow(arg_11_0)
	arg_11_0.lastTime = os_timenow()
end

function var_0_0.refresh(arg_12_0)
	if g_GameData.GodInfo == nil then
		return
	end

	arg_12_0.curGodInfo = g_GameData.GodInfo

	local var_12_0 = arg_12_0.curGodInfo.Star

	g_Self.kGodHandler:setGodStarTexture(arg_12_0.curstar, var_12_0)

	local var_12_1 = g_Self.kGodHandler:getGodMaxStar()
	local var_12_2 = var_12_0 + 1

	if var_12_1 < var_12_2 then
		var_12_2 = var_12_1
	end

	g_Self.kGodHandler:setGodStarTexture(arg_12_0.nextstar, var_12_2)
	arg_12_0.curpower:setString(arg_12_0.curGodInfo.Power)

	local var_12_3 = g_Self.kGodHandler:getGodPower(arg_12_0.curGodInfo.Level, var_12_2)

	arg_12_0.nextpower:setString(math.ceil(var_12_3))

	local var_12_4 = zbGodStarTable:getRecord(var_12_0)
	local var_12_5 = zbItemTable:getGodStarUpItems()
	local var_12_6 = 0
	local var_12_7 = 0

	if var_12_4 then
		var_12_6 = var_12_4.costitemCount
		var_12_7 = var_12_4.costgold
	end

	local var_12_8 = 0

	if zbUtil:isValidTable(var_12_5) then
		var_12_8 = var_12_5[1].id
	end

	local var_12_9 = g_Self.kBagItemHandler:getItemCountByTemplateId(var_12_8)

	arg_12_0.items[1]:refreshAward(ECommonAwardType.Item, var_12_8, haveCount, false, false)
	arg_12_0.items[2]:refreshAward(ECommonAwardType.Gold, nil, g_GameData.Wealth.Gold, false, false)

	local var_12_10 = FONT_COLOR_RED
	local var_12_11 = ccc3(0, 255, 0)
	local var_12_12 = var_12_11
	local var_12_13 = ""
	local var_12_14 = ""

	arg_12_0.limitCostItem = false

	if var_12_7 > g_GameData.Wealth.Gold then
		var_12_12 = var_12_10
		arg_12_0.limitCostItem = true
		arg_12_0.getWayId = -1
	end

	arg_12_0.itemsNum[2]:setString(var_12_7)
	arg_12_0.itemsNum[2]:setFontFillColor(var_12_12)

	local var_12_15 = var_12_11

	if var_12_9 < var_12_6 then
		var_12_15 = var_12_10
		arg_12_0.limitCostItem = true
		arg_12_0.getWayId = var_12_8
	end

	arg_12_0.itemsNum[1]:setString(var_12_9 .. "/" .. var_12_6)
	arg_12_0.itemsNum[1]:setFontFillColor(var_12_15)

	local var_12_16 = -1

	for iter_12_0, iter_12_1 in pairs(g_GameData.GodInfo.SkillList) do
		if iter_12_1.Index == var_12_2 then
			var_12_16 = iter_12_1.SkillId
		end
	end

	local var_12_17 = g_Self.kGodHandler:getGodSkillDesc(var_12_16, 1)

	arg_12_0.openskillDesc:setString(a2u(var_12_17))

	local var_12_18 = zbGodSkillTable:getRecord(var_12_16)

	if var_12_18 then
		arg_12_0.openskillName:setString(a2u(var_12_18.name))
	else
		arg_12_0.openskillName:setString("")
	end
end

function var_0_0.onStarUp(arg_13_0)
	if arg_13_0.limitCostItem then
		if arg_13_0.getWayId == -1 then
			g_MainScene:showGoldenTouch(EExchangeType.Gold):setPrevWnd(arg_13_0)

			return
		else
			g_MainScene:showGetWayWnd(arg_13_0.getWayId, ECommonAwardType.Item):setPrevWnd(arg_13_0)

			return
		end
	end

	g_WsMsgHandler:WS_God_UpgradeStar_Req()
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.testLayer, var_14_0.x, var_14_0.y) == false and zbUtil:PointInCtrl(arg_14_0.btnClose, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
