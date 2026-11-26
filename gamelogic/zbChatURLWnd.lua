require("gamelogic.zbTabWnd")
require("gamelogic.zbChatURLList")

local var_0_0 = class("zbChatURLWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createChatURLWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		arg_3_0.itemRecord = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/chat_url.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.titleBg = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbTitle = tolua.cast(arg_3_0.titleBg:getChildByTag(1), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")
		local var_5_4 = {
			[EChatURLTab.Equip] = tolua.cast(var_5_3:getChildByTag(11), "CCControlButton"),
			[EChatURLTab.Hero] = tolua.cast(var_5_3:getChildByTag(12), "CCControlButton")
		}
		local var_5_5 = {
			[EChatURLTab.Equip] = tolua.cast(var_5_3:getChildByTag(1), "CCLayer"),
			[EChatURLTab.Hero] = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		}

		arg_3_0.module = {}
		arg_3_0.module[EChatURLTab.Equip] = createChatURLList(var_5_5[EChatURLTab.Equip], EChatURLTab.Equip, var_5_4[EChatURLTab.Equip])
		arg_3_0.module[EChatURLTab.Hero] = createChatURLList(var_5_5[EChatURLTab.Hero], EChatURLTab.Hero, var_5_4[EChatURLTab.Hero])

		arg_3_0:initTab(var_5_4, var_5_5, nil, function(arg_7_0)
			return arg_3_0:switchTabCheck(arg_7_0)
		end)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.refresh(arg_11_0)
	return
end

function var_0_0.switchTabCheck(arg_12_0, arg_12_1)
	arg_12_0.module[arg_12_1]:refresh()

	for iter_12_0 = 1, table.getn(arg_12_0.tabButtons) do
		if iter_12_0 == arg_12_1 then
			arg_12_0.tabButtons[iter_12_0]:setZOrder(ZORDER_TOP)
		else
			arg_12_0.tabButtons[iter_12_0]:setZOrder(ZORDER_BOTTOM)
		end
	end

	return true
end

function var_0_0.onShowCallback(arg_13_0)
	arg_13_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_14_0)
	if arg_14_0.module[arg_14_0.currTab] then
		arg_14_0.module[arg_14_0.currTab]:refresh()
	end
end

function var_0_0.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layerTouchTest, var_15_0.x, var_15_0.y) == false and zbUtil:PointInCtrl(arg_15_0.btnClose, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end
