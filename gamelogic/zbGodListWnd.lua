require("gamelogic.zbBaseWnd")
require("gamelogic.zbGodList")

local var_0_0 = class("zbGodListWnd", zbBaseWnd)

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

function createGodListWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/godequip_change.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(401), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerlist = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.godList = createGodList(arg_3_0.layerlist, arg_3_0.btnClose)

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
	var_3_0()
	var_3_1()
end

function var_0_0.doShow(arg_9_0)
	return
end

function var_0_0.refresh(arg_10_0)
	arg_10_0.godList:refresh()
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.testLayer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
