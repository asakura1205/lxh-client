require("gamelogic.zbTabWnd")
require("gamelogic.zbBagList")
require("gamelogic.zbBagDetail")

local var_0_0 = class("zbBagWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createBagWnd()
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
		arg_3_0.ItemId = 0
		arg_3_0.closeFunc = nil
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 25, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/bag.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		local var_5_5 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		local var_5_6 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")
		local var_5_7 = {
			[EBagTab.Consumables] = tolua.cast(var_5_4:getChildByTag(1), "CCControlButton"),
			[EBagTab.Gemstone] = tolua.cast(var_5_4:getChildByTag(2), "CCControlButton"),
			[EBagTab.GiftBag] = tolua.cast(var_5_4:getChildByTag(4), "CCControlButton")
		}
		local var_5_8 = {
			[EBagTab.Consumables] = tolua.cast(var_5_5:getChildByTag(11), "CCLayer"),
			[EBagTab.Gemstone] = tolua.cast(var_5_5:getChildByTag(12), "CCLayer"),
			[EBagTab.GiftBag] = tolua.cast(var_5_5:getChildByTag(14), "CCLayer")
		}
		local var_5_9 = {
			[EBagTab.Consumables] = "image/tab/tab_bag_consumables.png",
			[EBagTab.Gemstone] = "image/tab/tab_bag_gemstone.png",
			[EBagTab.GiftBag] = "image/tab/tab_bag_giftBag.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EBagTab.Consumables] = createBagList(var_5_8[EBagTab.Consumables], EBagTab.Consumables, var_5_7[1])
		arg_3_0.module[EBagTab.Gemstone] = createBagList(var_5_8[EBagTab.Gemstone], EBagTab.Gemstone, var_5_7[1])
		arg_3_0.module[EBagTab.GiftBag] = createBagList(var_5_8[EBagTab.GiftBag], EBagTab.GiftBag, var_5_7[1])
		arg_3_0.notifyGiftBag = var_5_0(var_5_7[EBagTab.GiftBag])
		arg_3_0.panelDetail = createBagDetail(var_5_6)

		arg_3_0:initTab(var_5_7, var_5_8, var_5_9)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
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
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_BagItem)
end

function var_0_0.refresh(arg_10_0)
	return
end

function var_0_0.onShowCallback(arg_11_0)
	arg_11_0:selectTab(1)
	arg_11_0.notifyGiftBag:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Bag))
end

function var_0_0.doSelectTab(arg_12_0)
	arg_12_0.module[arg_12_0.currTab]:refresh()
	arg_12_0.panelDetail:refreshByEquipId(arg_12_0.module[arg_12_0.currTab].itemdata)
end

function var_0_0.onDataUpdateAck(arg_13_0)
	arg_13_0.notifyGiftBag:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Bag))

	for iter_13_0, iter_13_1 in pairs(arg_13_0.module) do
		iter_13_1:refreshDirtyFlag()
	end

	if g_MainScene.wndItemCountSelect then
		g_MainScene.wndItemCountSelect:hide()
	end

	if arg_13_0.isShow then
		arg_13_0.module[arg_13_0.currTab]:refresh()
		arg_13_0.panelDetail:refreshByEquipId(arg_13_0.module[arg_13_0.currTab].itemdata)
	end
end

function var_0_0.refreshSelectItem(arg_14_0, arg_14_1)
	arg_14_0.module[arg_14_0.currTab]:refreshSelectItem(arg_14_1)
end

function var_0_0.onFrameUpdate(arg_15_0)
	arg_15_0:updateBackEffect()
end
