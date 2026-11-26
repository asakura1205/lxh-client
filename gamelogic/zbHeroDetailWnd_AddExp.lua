require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbHeroDetailWnd_AddExp", zbBaseWnd)

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

function createHeroDetailAddExpWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.count = {}
		arg_3_0.touchFlag = false
		arg_3_0.selItemCount = 0
		arg_3_0.curlevel = 1
		arg_3_0.curExp = 0
		arg_3_0.leftExp = 0
		arg_3_0.touchIndex = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/herolvup.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

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

		local function var_5_6(arg_8_0, arg_8_1)
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

		arg_3_0.spriteBar = var_5_6(arg_3_0.spriteBarBg, "image/common/progress.png")

		local var_5_7 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.lblexpAdd = {}
		arg_3_0.btnFrame = {}
		arg_3_0.items = {}

		for iter_5_0 = 1, 5 do
			arg_3_0.lblexpAdd[iter_5_0] = tolua.cast(var_5_7:getChildByTag(iter_5_0 + 9), "CCLabelTTF")
			arg_3_0.btnFrame[iter_5_0] = tolua.cast(var_5_7:getChildByTag(iter_5_0 + 99), "CCControlButton")

			local var_5_8 = tolua.cast(var_5_7:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_9 = createItem()
			local var_5_10 = ccp(var_5_8:getPosition())

			var_5_9:setPosition(var_5_10.x + 10, var_5_10.y + 20)
			var_5_9:setAnchorPoint(ccp(0.5, 0.5))
			var_5_9.btnFrame:setEnabled(false)
			var_5_7:addChild(var_5_9)

			arg_3_0.items[iter_5_0] = var_5_9

			arg_3_0.items[iter_5_0]:setScale(0.8)
			var_5_8:removeFromParentAndCleanup(true)
			arg_3_0.btnFrame[iter_5_0]:setTouchPriority(arg_3_0.btnClose:getTouchPriority())
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_0)
			end, CCControlEventTouchEnd)
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpInside)
			arg_3_0.btnFrame[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpOutside)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshAgain()
	end, zbGameEvent.Event_Update_Hero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshAgain()
	end, zbGameEvent.Event_Update_BagItem)
end

function var_0_0.refresh(arg_15_0, arg_15_1)
	arg_15_0.hero = arg_15_1

	arg_15_0:refreshAct()
end

function var_0_0.refreshAgain(arg_16_0)
	if arg_16_0.hero == nil then
		return
	end

	arg_16_0.hero = g_Self.kHeroHandler:getHeroByTemplateId(arg_16_0.hero.HeroBaseInfo.TemplateId)

	arg_16_0:refreshAct()
end

function var_0_0.refreshAct(arg_17_0)
	if arg_17_0.hero == nil then
		return
	end

	arg_17_0.baseInfo = arg_17_0.hero.HeroBaseInfo

	arg_17_0.curLvRep:setString(arg_17_0.baseInfo.Level)

	arg_17_0.curlevel = arg_17_0.baseInfo.Level
	nextLv = arg_17_0.baseInfo.Level + 1

	arg_17_0.nextLvRep:setString(nextLv)

	local var_17_0 = zbHeroUpgradeTable:getHeroUpgradeNeedExp(arg_17_0.curlevel)
	local var_17_1 = arg_17_0.baseInfo.Exp

	arg_17_0.leftExp = var_17_1

	arg_17_0.lblexp:setString(var_17_1 .. "/" .. var_17_0)

	local var_17_2 = math.min(math.ceil(100 * (var_17_1 / var_17_0)), 100)

	arg_17_0.spriteBar:setPercentage(var_17_2)
	arg_17_0:refreshCostItemInfo()
end

function var_0_0.refreshCostItemInfo(arg_18_0)
	arg_18_0.costItem = zbItemTable:getHeroLevelUpItems()

	local var_18_0 = 1

	arg_18_0.itemcount = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.costItem) do
		if var_18_0 <= 5 then
			arg_18_0.lblexpAdd[var_18_0]:setString(iter_18_1.virtual)

			arg_18_0.count[var_18_0] = g_Self.kBagItemHandler:getItemCountByTemplateId(iter_18_1.id)

			arg_18_0.items[var_18_0]:refreshAward(ECommonAwardType.Item, iter_18_1.id, arg_18_0.count[var_18_0])
			arg_18_0.items[var_18_0]:setGray(arg_18_0.count[var_18_0] == 0)
			arg_18_0.items[var_18_0]:setNeedTip(false)

			arg_18_0.itemcount[var_18_0] = arg_18_0.count[var_18_0]
		end

		var_18_0 = var_18_0 + 1
	end
end

function var_0_0.onLevelUp(arg_19_0, arg_19_1)
	if arg_19_0.selItemCount > 0 then
		local var_19_0 = arg_19_0.costItem[arg_19_1].id

		g_WsMsgHandler:WS_Hero_Upgrade_Req(arg_19_0.hero.HeroBaseInfo.TemplateId, var_19_0, arg_19_0.selItemCount)
	end
end

function var_0_0.onTouchDown(arg_20_0, arg_20_1)
	if arg_20_0.count[arg_20_1] <= 0 then
		arg_20_0.touchFlag = true

		return
	end

	if arg_20_0.hero.HeroBaseInfo.Level >= g_Self:getLevel() then
		arg_20_0.touchFlag = true

		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB5ȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xCD\xE6\xBCҵȼ\xB6"))

		return
	end

	arg_20_0.selItemCount = 1
	arg_20_0.currLevel = arg_20_0.hero.HeroBaseInfo.Level
	arg_20_0.currExp = arg_20_0.hero.HeroBaseInfo.Exp

	local var_20_0 = zbItemTable:getRecord(arg_20_0.costItem[arg_20_1].id)

	if var_20_0 == nil then
		return
	end

	local var_20_1 = CCArray:create()

	var_20_1:addObject(CCDelayTime:create(0.3))
	var_20_1:addObject(CCCallFuncN:create(function()
		arg_20_0:onAddExp(arg_20_1, var_20_0)
	end))

	local var_20_2 = CCSequence:create(var_20_1)

	arg_20_0:stopAllActions()
	arg_20_0:runAction(var_20_2)
end

function var_0_0.onAddExp(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = 0
	local var_22_1 = 0

	local function var_22_2()
		if arg_22_0.currLevel >= g_Self:getLevel() then
			g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB5ȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xCD\xE6\xBCҵȼ\xB6"))
			arg_22_0.items[arg_22_1]:stopAllActions()

			return
		end

		var_22_0 = var_22_0 + 1

		if arg_22_0.count[arg_22_1] < var_22_0 then
			g_Bubble:bubbleInfo(a2u("\xB4˾\xAD\xD1\xE9ҩ\xD2\xD1\xD3\xC3\xCD\xEA"))
			arg_22_0.items[arg_22_1]:stopAllActions()

			return
		end

		arg_22_0.selItemCount = var_22_0

		arg_22_0.items[arg_22_1]:setItemNumber(arg_22_0.count[arg_22_1] - var_22_0)

		if g_MainScene.wndHeroDetail then
			arg_22_0.currLevel, arg_22_0.currExp, var_22_1 = zbHeroUpgradeTable:getLevelExpAfterAddExp(arg_22_0.currLevel, arg_22_0.currExp, arg_22_2.virtual, g_Self:getLevel())

			local var_23_0 = math.min(math.ceil(100 * (arg_22_0.currExp / var_22_1)), 100)

			g_MainScene.wndHeroDetail.layerBase.progressExp:runAction(CCProgressTo:create(0, var_23_0))
			g_MainScene.wndHeroDetail.layerAvatar.bmLevel:setString(arg_22_0.currLevel)
			arg_22_0.curLvRep:setString(arg_22_0.currLevel)
			arg_22_0.nextLvRep:setString(arg_22_0.currLevel + 1)
			arg_22_0.spriteBar:setPercentage(var_23_0)
		end
	end

	local var_22_3 = CCArray:create()

	var_22_3:addObject(CCCallFuncN:create(function()
		var_22_2()
	end))
	var_22_3:addObject(CCDelayTime:create(0.005))

	local var_22_4 = CCSequence:create(var_22_3)

	arg_22_0.items[arg_22_1]:stopAllActions()
	arg_22_0.items[arg_22_1]:runAction(CCRepeatForever:create(var_22_4))
end

function var_0_0.onTouchEnd(arg_25_0, arg_25_1)
	arg_25_0.touchFlag = false

	arg_25_0.items[arg_25_1]:stopAllActions()
	arg_25_0.items[arg_25_1]:setScale(0.8)
	arg_25_0:stopAllActions()
end

function var_0_0.onTouch(arg_26_0, arg_26_1)
	if arg_26_0.touchFlag == false then
		arg_26_0:onLevelUp(arg_26_1)
	elseif arg_26_0.count[arg_26_1] <= 0 then
		return
	end
end

function var_0_0.onTouchTest(arg_27_0)
	local var_27_0 = arg_27_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_27_0.testLayer, var_27_0.x, var_27_0.y) == false and zbUtil:PointInCtrl(arg_27_0.btnClose, var_27_0.x, var_27_0.y) == false then
		arg_27_0:hide()
	end
end
