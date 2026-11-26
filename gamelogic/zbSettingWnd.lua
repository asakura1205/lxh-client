require("gamelogic.zbTabWnd")
require("gamelogic.zbSettingWnd_Self")
require("gamelogic.zbSettingWnd_Select")
require("gamelogic.zbSettingWnd_Social")
require("gamelogic.zbSettingWnd_Advice")

local var_0_0 = class("zbSettingWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createSettingWnd()
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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/setting.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = {
			[ESettingTab.Self] = tolua.cast(arg_3_0.layer:getChildByTag(11), "CCLayer"),
			[ESettingTab.Select] = tolua.cast(arg_3_0.layer:getChildByTag(12), "CCLayer"),
			[ESettingTab.Advice] = tolua.cast(arg_3_0.layer:getChildByTag(13), "CCLayer"),
			[ESettingTab.Social] = tolua.cast(arg_3_0.layer:getChildByTag(14), "CCLayer")
		}
		local var_5_3 = {
			[ESettingTab.Self] = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCControlButton"),
			[ESettingTab.Select] = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCControlButton"),
			[ESettingTab.Advice] = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCControlButton"),
			[ESettingTab.Social] = tolua.cast(arg_3_0.layer:getChildByTag(4), "CCControlButton")
		}

		var_5_3[ESettingTab.Self]:setZoomOnTouchDown(true)
		var_5_3[ESettingTab.Select]:setZoomOnTouchDown(true)
		var_5_3[ESettingTab.Advice]:setZoomOnTouchDown(true)
		var_5_3[ESettingTab.Social]:setZoomOnTouchDown(true)

		local var_5_4 = {
			[ESettingTab.Self] = "image/tab/tab_set_self.png",
			[ESettingTab.Select] = "image/tab/tab_set_select.png",
			[ESettingTab.Advice] = "image/tab/tab_set_advice.png",
			[ESettingTab.Social] = "image/tab/tab_set_social.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ESettingTab.Self] = createSettingSelfPanel(arg_3_0, var_5_2[ESettingTab.Self], "CCNode")
		arg_3_0.module[ESettingTab.Select] = createSettingSelectPanel(arg_3_0, var_5_2[ESettingTab.Select], "CCNode")
		arg_3_0.module[ESettingTab.Advice] = createSettingAdvicePanel(arg_3_0, var_5_2[ESettingTab.Advice], "CCNode")
		arg_3_0.module[ESettingTab.Social] = createSettingSocialPanel(arg_3_0, var_5_2[ESettingTab.Social], "CCNode")

		arg_3_0:initTab(var_5_3, var_5_2, var_5_4, function(arg_7_0)
			return arg_3_0:switchTabCheck(arg_7_0)
		end)

		for iter_5_0 = 1, 4 do
			var_5_3[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			var_5_3[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDragEnter)
			var_5_3[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd()
			end, CCControlEventTouchDragExit)
		end

		arg_3_0.btnClose = tolua.cast(arg_3_0.layer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		var_5_3[ESettingTab.Social]:setVisible(false)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshSelf()
	end, zbGameEvent.Event_Update_BaseInfo)
end

function var_0_0.refresh(arg_13_0)
	arg_13_0:selectTab(1)
end

function var_0_0.refreshSelf(arg_14_0)
	arg_14_0.module[ESettingTab.Self]:refresh()
end

function var_0_0.switchTabCheck(arg_15_0, arg_15_1)
	arg_15_0.module[arg_15_1]:refresh()

	for iter_15_0 = 1, table.getn(arg_15_0.tabButtons) do
		if iter_15_0 == arg_15_1 then
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_TOP)
		else
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_BOTTOM)
		end
	end

	return true
end

function var_0_0.onFrameUpdate(arg_16_0, arg_16_1)
	if arg_16_0.currTab == ESettingTab.Self then
		arg_16_0.module[arg_16_0.currTab]:update()
	end
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.layer, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end

function var_0_0.onTouchDown(arg_18_0, arg_18_1)
	for iter_18_0 = 1, table.getn(arg_18_0.tabButtons) do
		if iter_18_0 == arg_18_1 then
			arg_18_0.tabButtons[iter_18_0]:setZOrder(ZORDER_TOP)
		end
	end
end

function var_0_0.onTouchEnd(arg_19_0)
	for iter_19_0 = 1, table.getn(arg_19_0.tabButtons) do
		if iter_19_0 == arg_19_0.currTab then
			arg_19_0.tabButtons[iter_19_0]:setZOrder(ZORDER_TOP)
		else
			arg_19_0.tabButtons[iter_19_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end
