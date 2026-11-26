require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbGodSkillUpWnd", zbBaseWnd)

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

function createGodSkillUpWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.limitCostItem = false
		arg_3_0.limitGold = false
		arg_3_0.getWayId = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/godskillup.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

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

		arg_3_0.title = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.curlv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.curlv)
		arg_3_0.curlv:setScale(0.7)

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.nextlv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.nextlv)
		arg_3_0.nextlv:setScale(0.7)

		arg_3_0.curdesc = tolua.cast(var_5_3:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.nextdesc = tolua.cast(var_5_3:getChildByTag(1004), "CCLabelTTF")

		local var_5_6 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.lblbless = tolua.cast(var_5_6:getChildByTag(2), "CCLabelTTF")

		local var_5_7 = tolua.cast(var_5_6:getChildByTag(3), "CCLabelTTF")

		arg_3_0.sucrate = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.sucrate)
		arg_3_0.sucrate:setScale(0.7)

		arg_3_0.spriteBarBg = tolua.cast(var_5_6:getChildByTag(1), "CCSprite")

		local function var_5_8(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(100)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBar = var_5_8(arg_3_0.spriteBarBg, "image/godequip/progresspre.png")

		local var_5_9 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnSkillUp = tolua.cast(var_5_9:getChildByTag(1), "CCControlButton")

		arg_3_0.btnSkillUp:addHandleOfControlEvent(function()
			arg_3_0:onSkillUp()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeCost = var_5_9
		arg_3_0.items = {}
		arg_3_0.itemsNum = {}

		for iter_5_0 = 1, 2 do
			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0 + 1), "CCLayerColor")
			local var_5_11 = createItem()
			local var_5_12 = ccp(var_5_10:getPosition())

			var_5_11:setPosition(var_5_12.x + 20, var_5_12.y + 20)
			var_5_11:setScale(0.7)
			var_5_9:addChild(var_5_11)

			arg_3_0.items[iter_5_0] = var_5_11

			var_5_10:removeFromParentAndCleanup(true)

			arg_3_0.itemsNum[iter_5_0] = tolua.cast(var_5_9:getChildByTag(iter_5_0 + 3), "CCLabelTTF")
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onSkillUpAc()
	end, zbGameEvent.Event_Update_GodInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshCostItemInfo()
	end, zbGameEvent.Event_Update_BagItem)
end

function var_0_0.doShow(arg_12_0)
	return
end

function var_0_0.onSkillUpAc(arg_13_0)
	if g_GameData.GodInfo == nil then
		return
	end

	for iter_13_0, iter_13_1 in pairs(g_GameData.GodInfo.SkillList) do
		if iter_13_1.Index == arg_13_0.skilldata.Index then
			arg_13_0:refresh(iter_13_1)
		end
	end
end

function var_0_0.refresh(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return
	end

	arg_14_0.skilldata = arg_14_1

	local var_14_0 = g_Self.kGodHandler:getGodMaxSkillLevel()

	arg_14_0.curlv:setString(arg_14_1.Level .. a2u("\xBC\xB6"))

	local var_14_1 = arg_14_1.Level + 1

	if var_14_0 < var_14_1 then
		var_14_1 = var_14_0
	end

	arg_14_0.nextlv:setString(var_14_1 .. a2u("\xBC\xB6"))

	local var_14_2 = g_Self.kGodHandler:getGodSkillDesc(arg_14_1.SkillId, arg_14_1.Level)
	local var_14_3 = g_Self.kGodHandler:getGodSkillDesc(arg_14_1.SkillId, var_14_1)
	local var_14_4 = zbGodSkillTable:getRecord(arg_14_1.SkillId)

	if var_14_4 then
		arg_14_0.curdesc:setString(a2u("\xB5\xB1ǰ\xB5ȼ\xB6:") .. a2u(var_14_2))
		arg_14_0.nextdesc:setString(a2u("\xCF\xC2һ\xB5ȼ\xB6:") .. a2u(var_14_3))
		arg_14_0.title:setString(var_14_4.name)
	end

	arg_14_0.lblbless:setString(arg_14_1.Bless .. "/100")

	if arg_14_1.Bless >= 100 then
		arg_14_0.sucrate:setString("100;")
	else
		local var_14_5 = g_Self.kGodHandler:getGodSkillUpSucRate(arg_14_1.Level)

		arg_14_0.sucrate:setString(var_14_5 * 100 .. ";")
	end

	local var_14_6 = math.min(math.ceil(100 * (arg_14_1.Bless / 100)), 100)

	arg_14_0.spriteBar:setPercentage(var_14_6)
	arg_14_0:refreshCostItemInfo()
end

function var_0_0.refreshCostItemInfo(arg_15_0)
	if arg_15_0.isShow == false or arg_15_0.skilldata == nil then
		return
	end

	local var_15_0 = zbGodSkillUpgradeTable:getRecord(arg_15_0.skilldata.Level)
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = 0
	local var_15_4 = zbItemTable:getGodSkillUpItems()

	if var_15_0 then
		var_15_1 = var_15_0.costitemCount
		var_15_3 = var_15_0.costgold
	end

	local var_15_5 = 0

	if zbUtil:isValidTable(var_15_4) then
		var_15_5 = var_15_4[1].id
	end

	local var_15_6 = g_Self.kBagItemHandler:getItemCountByTemplateId(var_15_5)

	arg_15_0.items[1]:refreshAward(ECommonAwardType.Item, var_15_5, haveCount, false, false)
	arg_15_0.items[2]:refreshAward(ECommonAwardType.Gold, nil, g_GameData.Wealth.Gold, false, false)

	local var_15_7 = FONT_COLOR_RED
	local var_15_8 = ccc3(0, 255, 0)
	local var_15_9 = var_15_8
	local var_15_10 = ""
	local var_15_11 = ""

	arg_15_0.limitCostItem = false

	if var_15_6 < var_15_1 then
		var_15_9 = var_15_7
		arg_15_0.limitCostItem = true
		arg_15_0.getWayId = var_15_5
	end

	arg_15_0.itemsNum[1]:setString(var_15_6 .. "/" .. var_15_1)
	arg_15_0.itemsNum[1]:setFontFillColor(var_15_9)

	local var_15_12 = var_15_8

	arg_15_0.limitGold = false

	if var_15_3 > g_GameData.Wealth.Gold then
		var_15_12 = var_15_7
		arg_15_0.limitGold = true
	end

	arg_15_0.itemsNum[2]:setString(var_15_3)
	arg_15_0.itemsNum[2]:setFontFillColor(var_15_12)
end

function var_0_0.onSkillUp(arg_16_0)
	if arg_16_0.limitCostItem then
		g_MainScene:showGetWayWnd(arg_16_0.getWayId, ECommonAwardType.Item)

		return
	end

	if arg_16_0.limitGold then
		g_Bubble:bubbleInfo("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3")

		return
	end

	g_WsMsgHandler:WS_God_UpgradeSkill_Req(arg_16_0.skilldata.Index)
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.testLayer, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end
