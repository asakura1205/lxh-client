require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbGodLevelUpWnd", zbBaseWnd)

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

function createGodLevelUpWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.curGodInfo = nil
		arg_3_0.touchdown = false
		arg_3_0.selCount = 0
		arg_3_0.curlevel = 1
		arg_3_0.curExp = 0
		arg_3_0.leftExp = 0
		arg_3_0.touchIndex = 1
		arg_3_0.consumeStep = 0.2
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/godlvup.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

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
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")

		arg_3_0.curLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.curLvRep)
		arg_3_0.curLvRep:setScale(0.65)

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")

		arg_3_0.nextLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.nextLvRep)
		arg_3_0.nextLvRep:setScale(0.65)

		arg_3_0.lblexp = tolua.cast(var_5_3:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteBarBg = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")

		local var_5_6 = tolua.cast(var_5_3:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.curpower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.curpower)
		arg_3_0.curpower:setScale(0.8)

		local var_5_7 = tolua.cast(var_5_3:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.nextpower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.nextpower)
		arg_3_0.nextpower:setScale(0.8)

		local function var_5_8(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(0)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBar = var_5_8(arg_3_0.spriteBarBg, "image/common/progress.png")

		local var_5_9 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.lblexpAdd = {}
		arg_3_0.btnFrame = {}
		arg_3_0.items = {}

		for iter_5_0 = 1, 4 do
			arg_3_0.lblexpAdd[iter_5_0] = tolua.cast(var_5_9:getChildByTag(iter_5_0 + 9), "CCLabelTTF")
			arg_3_0.btnFrame[iter_5_0] = tolua.cast(var_5_9:getChildByTag(iter_5_0 + 99), "CCControlButton")

			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_11 = createItem()

			var_5_11:setSupportTouchDownTip(false)
			var_5_11:setSwallowsTouches(false)

			local var_5_12 = ccp(var_5_10:getPosition())

			var_5_11:setPosition(var_5_12.x + 10, var_5_12.y + 20)
			var_5_9:addChild(var_5_11)

			arg_3_0.items[iter_5_0] = var_5_11

			var_5_10:removeFromParentAndCleanup(true)
			arg_3_0.btnFrame[iter_5_0]:setTouchPriority(arg_3_0.btnClose:getTouchPriority())
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_0)
			end, CCControlEventTouchEnd)
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
end

function var_0_0.doShow(arg_12_0)
	arg_12_0.touchdown = false
	arg_12_0.selCount = 0
	arg_12_0.lastTime = os_timenow()
	arg_12_0.consumeStep = 0.2
end

function var_0_0.refresh(arg_13_0)
	if g_GameData.GodInfo == nil then
		return
	end

	arg_13_0.curGodInfo = g_GameData.GodInfo

	arg_13_0.curLvRep:setString(arg_13_0.curGodInfo.Level)

	arg_13_0.curlevel = arg_13_0.curGodInfo.Level

	local var_13_0 = g_Self.kGodHandler:getGodMaxLevel(false)
	local var_13_1 = arg_13_0.curlevel + 1

	if var_13_0 <= var_13_1 then
		var_13_1 = var_13_0
	end

	arg_13_0.nextLvRep:setString(var_13_1)
	arg_13_0.curpower:setString(arg_13_0.curGodInfo.Power)

	local var_13_2 = g_Self.kGodHandler:getGodPower(var_13_1, arg_13_0.curGodInfo.Star)

	arg_13_0.nextpower:setString(math.ceil(var_13_2))

	local var_13_3 = g_Self.kGodHandler:getCurLevelMaxExp(arg_13_0.curlevel)
	local var_13_4 = arg_13_0.curGodInfo.Exp

	arg_13_0.leftExp = var_13_4
	arg_13_0.curExp = var_13_4 + g_Self.kGodHandler:getCurLevelAllExp(arg_13_0.curlevel)

	arg_13_0.lblexp:setString(var_13_4 .. "/" .. var_13_3)

	local var_13_5 = math.min(math.ceil(100 * (var_13_4 / var_13_3)), 100)

	arg_13_0.spriteBar:setPercentage(var_13_5)
	arg_13_0:refreshCostItemInfo()
end

function var_0_0.refreshCostItemInfo(arg_14_0)
	arg_14_0.costItem = zbItemTable:getGodLevelUpItems()

	local var_14_0 = 1

	arg_14_0.itemcount = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.costItem) do
		if var_14_0 <= 4 then
			arg_14_0.lblexpAdd[var_14_0]:setString(a2u("\xBE\xAD\xD1\xE9ֵ+") .. iter_14_1.virtual)

			local var_14_1 = g_Self.kBagItemHandler:getItemCountByTemplateId(iter_14_1.id)

			arg_14_0.items[var_14_0]:refreshAward(ECommonAwardType.Item, iter_14_1.id, var_14_1)
			arg_14_0.items[var_14_0]:setGray(var_14_1 == 0)

			arg_14_0.itemcount[var_14_0] = var_14_1
		end

		var_14_0 = var_14_0 + 1
	end
end

function var_0_0.onLevelUp(arg_15_0, arg_15_1)
	if arg_15_0.selCount > 0 then
		local var_15_0 = arg_15_0.costItem[arg_15_1].id

		g_WsMsgHandler:WS_God_Upgrade_Req(var_15_0, arg_15_0.selCount)
	end
end

function var_0_0.setItemNum(arg_16_0, arg_16_1)
	if arg_16_0.items[arg_16_1] then
		local var_16_0 = arg_16_0.costItem[arg_16_1].name
		local var_16_1 = arg_16_0.itemcount[arg_16_1] - arg_16_0.selCount

		if var_16_1 <= 0 then
			var_16_1 = 0
		end

		arg_16_0.items[arg_16_1]:setItemNumber(var_16_1)
	end
end

function var_0_0.onAddExp(arg_17_0, arg_17_1)
	local var_17_0 = g_Self.kGodHandler:getGodMaxLevel()
	local var_17_1 = 1

	if var_17_0 <= arg_17_0.curlevel then
		var_17_1 = var_17_0
		arg_17_0.touchdown = false

		local var_17_2 = g_Self.kGodHandler:getCurLevelMaxExp(arg_17_0.curlevel)

		arg_17_0.lblexp:setString(arg_17_0.leftExp .. "/" .. var_17_2)
		arg_17_0.curLvRep:setString(var_17_0)
		arg_17_0.nextLvRep:setString(var_17_0)
		g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xD7\xEE\xB4\xF3\xB5ȼ\xB6"))

		return
	else
		var_17_1 = arg_17_0.curlevel + 1
	end

	arg_17_0.curLvRep:setString(arg_17_0.curlevel)
	arg_17_0.nextLvRep:setString(var_17_1)

	arg_17_0.selCount = arg_17_0.selCount + 1

	arg_17_0:setItemNum(arg_17_1)

	local var_17_3 = arg_17_0.costItem[arg_17_1].virtual

	arg_17_0.curExp = arg_17_0.curExp + var_17_3
	arg_17_0.leftExp = arg_17_0.leftExp + var_17_3

	local var_17_4 = g_Self.kGodHandler:getLevelByexp(arg_17_0.curExp)

	if var_17_4 > arg_17_0.curlevel then
		arg_17_0.curlevel = var_17_4

		arg_17_0.curpower:setString(arg_17_0.curGodInfo.Power)

		local var_17_5 = g_Self.kGodHandler:getGodPower(arg_17_0.curlevel, arg_17_0.curGodInfo.Star)

		arg_17_0.nextpower:setString(math.ceil(var_17_5))

		local var_17_6 = g_Self.kGodHandler:getCurLevelAllExp(arg_17_0.curlevel)

		arg_17_0.leftExp = math.max(0, arg_17_0.curExp - var_17_6)
	end

	local var_17_7 = g_Self.kGodHandler:getCurLevelMaxExp(arg_17_0.curlevel)

	arg_17_0.lblexp:setString(arg_17_0.leftExp .. "/" .. var_17_7)

	local var_17_8 = math.min(math.ceil(100 * (arg_17_0.leftExp / var_17_7)), 100)

	arg_17_0.spriteBar:setPercentage(var_17_8)
end

function var_0_0.onTouchDown(arg_18_0, arg_18_1)
	if g_Self.kGodHandler:getGodMaxLevel() <= arg_18_0.curGodInfo.Level then
		g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xD7\xEE\xB4\xF3\xB5ȼ\xB6"))

		return
	end

	if arg_18_0.itemcount[arg_18_1] <= 0 then
		g_MainScene:showGetWayWnd(arg_18_0.costItem[arg_18_1].id, ECommonAwardType.Item):setPrevWnd(arg_18_0)

		return
	end

	arg_18_0.touchdown = true
	arg_18_0.touchIndex = arg_18_1
end

function var_0_0.onTouchEnd(arg_19_0, arg_19_1)
	arg_19_0.touchdown = false

	if arg_19_0.selCount <= 0 then
		return
	end

	local var_19_0 = g_Self.kGodHandler:getCurLevelMaxExp(arg_19_0.curlevel)

	if var_19_0 <= arg_19_0.leftExp then
		arg_19_0.leftExp = var_19_0
	end

	arg_19_0.lblexp:setString(arg_19_0.leftExp .. "/" .. var_19_0)
	arg_19_0:onLevelUp(arg_19_0.touchIndex)

	arg_19_0.selCount = 0
	arg_19_0.consumeStep = 0.2
end

function var_0_0.onFrameUpdate(arg_20_0, arg_20_1)
	if arg_20_0.isShow == false then
		return false
	end

	if os_timenow() - arg_20_0.lastTime < arg_20_0.consumeStep then
		return
	end

	if arg_20_0.consumeStep <= 0.02 then
		arg_20_0.consumeStep = 0.02
	else
		arg_20_0.consumeStep = arg_20_0.consumeStep - 0.01
	end

	arg_20_0.lastTime = os_timenow()

	if arg_20_0.touchdown then
		if arg_20_0.itemcount[arg_20_0.touchIndex] - arg_20_0.selCount <= 0 then
			arg_20_0.touchdown = false
		end

		arg_20_0:onAddExp(arg_20_0.touchIndex)
	end
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.testLayer, var_21_0.x, var_21_0.y) == false and zbUtil:PointInCtrl(arg_21_0.btnClose, var_21_0.x, var_21_0.y) == false then
		arg_21_0:hide()
	end
end
