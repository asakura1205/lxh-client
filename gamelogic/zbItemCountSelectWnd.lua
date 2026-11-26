require("gamelogic.zbBaseWnd")
require("gamelogic.zbBagDetailItem")
require("gamelogic.zbItem")

local var_0_0 = class("zbItemCountSelectWnd", zbBaseWnd)

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

function createItemCountSelWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.numSel = 1
		arg_3_0.numAll = 1
		arg_3_0.sellPrice = 1
		arg_3_0.touchDecDown = false
		arg_3_0.touchAddDown = false
		arg_3_0.itemRecod = nil
		arg_3_0.option = EBagItemOption.E_SALE
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/itemcountselect.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_4:setSwallowsTouches(false)
		var_5_2:addChild(var_5_4)

		arg_3_0.equipItemDummy = var_5_4

		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.btnMin = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")
		arg_3_0.btnMax = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")
		arg_3_0.btnDec = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnAdd = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.spriteBarBg = tolua.cast(var_5_2:getChildByTag(13), "CCSprite")
		arg_3_0.lbSelNum = tolua.cast(var_5_2:getChildByTag(14), "CCLabelTTF")
		arg_3_0.btnSure = tolua.cast(var_5_2:getChildByTag(15), "CCControlButton")
		arg_3_0.nodeMoney = tolua.cast(var_5_2:getChildByTag(20), "CCNode")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.nodeAllMoney = tolua.cast(var_5_2:getChildByTag(21), "CCNode")
		arg_3_0.spriteAllMoney = tolua.cast(arg_3_0.nodeAllMoney:getChildByTag(1), "CCSprite")

		local var_5_7 = tolua.cast(arg_3_0.nodeAllMoney:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.lbOwnNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbOwnNum)
		arg_3_0.lbOwnNum:setScale(0.55)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.55)

		arg_3_0.lbAllMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbAllMoney)
		arg_3_0.lbAllMoney:setScale(0.55)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSure:addHandleOfControlEvent(function()
			arg_3_0:onConfirm()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

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

		arg_3_0.spriteBar = var_5_8(arg_3_0.spriteBarBg, "image/common/progress.png")
		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMin:addHandleOfControlEvent(function()
			arg_3_0:onMin()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onDec()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMax:addHandleOfControlEvent(function()
			arg_3_0:onMax()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onAdd()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchDownDec()
		end, CCControlEventTouchDown)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchMoveDec()
		end, CCControlEventTouchMove)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchDownAdd()
		end, CCControlEventTouchDown)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchMoveAdd()
		end, CCControlEventTouchMove)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:hide()
end

function var_0_0.onConfirm(arg_21_0)
	if arg_21_0.option == EBagItemOption.E_SALE then
		local var_21_0 = {}
		local var_21_1 = {
			arg_21_0.data.TemplateId,
			arg_21_0.numSel
		}

		table.insert(var_21_0, var_21_1)

		local function var_21_2()
			g_WsMsgHandler:WS_Bag_SaleItem_Req(var_21_0)
		end

		local var_21_3 = ""

		if arg_21_0.itemRecod then
			var_21_3 = arg_21_0.itemRecod.name
		end

		local var_21_4 = a2u("ȷ\xB6\xA8\xB3\xF6\xCA\xDB") .. a2u(var_21_3) .. a2u("\xC2\xF0\xA3\xBF")

		g_MessageBox:showYesNo(var_21_4, var_21_2)
	elseif arg_21_0.option == EBagItemOption.E_OPEN and arg_21_0.itemRecod then
		local var_21_5 = 0
		local var_21_6 = 0

		if arg_21_0.itemRecod.key ~= 0 and arg_21_0.numSel > g_Self.kBagItemHandler:getItemCountByTemplateId(arg_21_0.itemRecod.key) then
			g_Bubble:bubbleInfo(a2u("û\xD3\xD0\xD7㹻Կ\xB3\xD7"))

			return
		end

		g_WsMsgHandler:WS_Bag_OpenBox_Req(arg_21_0.data.TemplateId, arg_21_0.numSel)
	end
end

function var_0_0.refresh(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 then
		arg_23_0.option = arg_23_2
	end

	arg_23_0.data = arg_23_1
	arg_23_0.numSel = 1
	arg_23_0.numAll = 1
	arg_23_0.touchDecDown = false
	arg_23_0.touchAddDown = false

	local var_23_0 = zbItemTable:getRecord(arg_23_1.TemplateId)

	arg_23_0.itemRecod = var_23_0

	if var_23_0 == nil then
		arg_23_0:hide()

		return
	end

	arg_23_0.numSel = 1
	arg_23_0.sellPrice = var_23_0.sellPrice

	arg_23_0.lbName:setString(var_23_0.name)

	local var_23_1 = zbColor:getItemColor(var_23_0.quality)

	arg_23_0.lbName:setColor(var_23_1)
	arg_23_0.lbMoney:setString(arg_23_0.sellPrice)
	arg_23_0.equipItemDummy:refreshAward(ECommonAwardType.Item, arg_23_1.TemplateId, arg_23_1.Count, false)

	local var_23_2 = arg_23_1.Count

	if var_23_2 == 0 then
		arg_23_0:hide()

		return
	end

	arg_23_0.numAll = var_23_2

	if arg_23_0.option == EBagItemOption.E_OPEN then
		local var_23_3 = 0

		if arg_23_0.itemRecod.key ~= 0 then
			arg_23_0.numAll = g_Self.kBagItemHandler:getItemCountByTemplateId(arg_23_0.itemRecod.key)
		end
	end

	arg_23_0.lbOwnNum:setString(var_23_2)
	arg_23_0.nodeMoney:setVisible(arg_23_0.option == EBagItemOption.E_SALE)
	arg_23_0.nodeAllMoney:setVisible(arg_23_0.option == EBagItemOption.E_SALE)
	arg_23_0:refreshNum()
end

function var_0_0.refreshNum(arg_24_0)
	arg_24_0.lbSelNum:setString(arg_24_0.numSel .. "/" .. arg_24_0.numAll)
	arg_24_0.lbAllMoney:setString(arg_24_0.sellPrice * arg_24_0.numSel)

	local var_24_0 = math.min(math.ceil(100 * (arg_24_0.numSel / arg_24_0.numAll)), 100)

	arg_24_0.spriteBar:setPercentage(var_24_0)
end

function var_0_0.onTouchDownDec(arg_25_0)
	arg_25_0.touchAddDown = false

	local var_25_0 = CCArray:create()

	var_25_0:addObject(CCDelayTime:create(0.3))
	var_25_0:addObject(CCCallFuncN:create(function()
		arg_25_0.touchDecDown = true
	end))

	local var_25_1 = CCSequence:create(var_25_0)

	arg_25_0:stopAllActions()
	arg_25_0:runAction(var_25_1)
end

function var_0_0.onTouchDownAdd(arg_27_0)
	arg_27_0.touchDecDown = false

	local var_27_0 = CCArray:create()

	var_27_0:addObject(CCDelayTime:create(0.3))
	var_27_0:addObject(CCCallFuncN:create(function()
		arg_27_0.touchAddDown = true
	end))

	local var_27_1 = CCSequence:create(var_27_0)

	arg_27_0:stopAllActions()
	arg_27_0:runAction(var_27_1)
end

function var_0_0.onTouchMoveDec(arg_29_0)
	local var_29_0 = arg_29_0.btnDec:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_29_0.btnDec, var_29_0.x, var_29_0.y) == false then
		arg_29_0:stopAllActions()

		arg_29_0.touchDecDown = false
	end
end

function var_0_0.onTouchMoveAdd(arg_30_0)
	local var_30_0 = arg_30_0.btnAdd:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_30_0.btnAdd, var_30_0.x, var_30_0.y) == false then
		arg_30_0:stopAllActions()

		arg_30_0.touchAddDown = false
	end
end

function var_0_0.onTouchEnd(arg_31_0)
	arg_31_0:stopAllActions()

	arg_31_0.touchDecDown = false
	arg_31_0.touchAddDown = false
end

function var_0_0.onMin(arg_32_0)
	if arg_32_0.numSel > 1 then
		arg_32_0.numSel = 1

		arg_32_0:refreshNum()
	end
end

function var_0_0.onDec(arg_33_0)
	if arg_33_0.numSel > 1 then
		arg_33_0.numSel = arg_33_0.numSel - 1

		arg_33_0:refreshNum()
	end
end

function var_0_0.onMax(arg_34_0)
	if arg_34_0.numSel ~= arg_34_0.numAll then
		arg_34_0.numSel = arg_34_0.numAll

		arg_34_0:refreshNum()
	end
end

function var_0_0.onAdd(arg_35_0)
	if arg_35_0.numSel < arg_35_0.numAll then
		arg_35_0.numSel = arg_35_0.numSel + 1

		arg_35_0:refreshNum()
	end
end

function var_0_0.onTouchTest(arg_36_0)
	local var_36_0 = arg_36_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_36_0.layerTouchTest, var_36_0.x, var_36_0.y) == false and zbUtil:PointInCtrl(arg_36_0.btnClose, var_36_0.x, var_36_0.y) == false then
		arg_36_0:hide()
	end
end

local var_0_1 = os_timenow()

function var_0_0.onFrameUpdate(arg_37_0, arg_37_1)
	if arg_37_0.isShow == false then
		return false
	end

	if os_timenow() - var_0_1 < 0.02 then
		return
	end

	var_0_1 = os_timenow()

	if arg_37_0.touchDecDown then
		arg_37_0:onDec()
	end

	if arg_37_0.touchAddDown then
		arg_37_0:onAdd()
	end
end
