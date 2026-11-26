require("gamelogic.zbTabWnd")
require("gamelogic.zbWorldHeroSelectList")

local var_0_0 = class("zbWorldHeroSelectWnd", zbTabWnd)

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

function createWorldHeroSelectWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.cannotSelList = {}
		arg_3_0.callback = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_heroselect.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = {
			[EHeroTab.All] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton"),
			[EHeroTab.Force] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton"),
			[EHeroTab.Intelligence] = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton"),
			[EHeroTab.Tili] = tolua.cast(var_5_3:getChildByTag(4), "CCControlButton")
		}
		local var_5_5 = {
			[EHeroTab.All] = tolua.cast(var_5_3:getChildByTag(11), "CCLayer"),
			[EHeroTab.Force] = tolua.cast(var_5_3:getChildByTag(12), "CCLayer"),
			[EHeroTab.Intelligence] = tolua.cast(var_5_3:getChildByTag(13), "CCLayer"),
			[EHeroTab.Tili] = tolua.cast(var_5_3:getChildByTag(14), "CCLayer")
		}
		local var_5_6 = {
			[EHeroTab.All] = "image/tab/tab_herosel_all.png",
			[EHeroTab.Force] = "image/tab/tab_herosel_force.png",
			[EHeroTab.Intelligence] = "image/tab/tab_herosel_intelligence.png",
			[EHeroTab.Tili] = "image/tab/tab_herosel_tili.png"
		}

		arg_3_0.tabButtons = var_5_4
		arg_3_0.module = {}
		arg_3_0.module[EHeroTab.All] = createWorldHeroSelectPanel(var_5_5[EHeroTab.All], EHeroTab.All, var_5_4[EHeroTab.All], arg_3_0)
		arg_3_0.module[EHeroTab.Force] = createWorldHeroSelectPanel(var_5_5[EHeroTab.Force], EHeroTab.Force, var_5_4[EHeroTab.Force], arg_3_0)
		arg_3_0.module[EHeroTab.Intelligence] = createWorldHeroSelectPanel(var_5_5[EHeroTab.Intelligence], EHeroTab.Intelligence, var_5_4[EHeroTab.Intelligence], arg_3_0)
		arg_3_0.module[EHeroTab.Tili] = createWorldHeroSelectPanel(var_5_5[EHeroTab.Tili], EHeroTab.Tili, var_5_4[EHeroTab.Tili], arg_3_0)

		arg_3_0:initTab(var_5_4, var_5_5, var_5_6)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	return
end

function var_0_0.refreshHeroSelCallback(arg_9_0, arg_9_1)
	arg_9_0.callback = arg_9_1

	arg_9_0:selectTab(1)
end

function var_0_0.setCannotSelList(arg_10_0, arg_10_1)
	arg_10_0.cannotSelList = arg_10_1
end

function var_0_0.doSelectTab(arg_11_0)
	if arg_11_0.module[arg_11_0.currTab] then
		arg_11_0.module[arg_11_0.currTab]:refresh()
	end

	for iter_11_0 = 1, table.getn(arg_11_0.tabButtons) do
		if iter_11_0 == arg_11_0.currTab then
			arg_11_0.tabButtons[iter_11_0]:setZOrder(ZORDER_TOP)
		else
			arg_11_0.tabButtons[iter_11_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end

function var_0_0.onHide(arg_12_0)
	arg_12_0:hide()
end

function var_0_0.onTouchTest(arg_13_0)
	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layerTouchTest, var_13_0.x, var_13_0.y) == false and zbUtil:PointInCtrl(arg_13_0.btnClose, var_13_0.x, var_13_0.y) == false then
		arg_13_0:hide()
	end
end
