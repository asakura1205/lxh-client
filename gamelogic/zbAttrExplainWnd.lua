require("gamelogic.zbBaseWnd")

zbAttrExplainWnd = class("zbAttrExplainWnd", zbBaseWnd)
zbAttrExplainWnd.__index = zbAttrExplainWnd

function zbAttrExplainWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbAttrExplainWnd)

	return arg_1_0
end

function zbAttrExplainWnd.create(arg_2_0)
	local var_2_0 = zbAttrExplainWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbAttrExplainWnd.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/attr_explain_wnd.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.sv = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCScrollView")
		arg_3_0.detailLayer = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(arg_3_0.layer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbtitle = tolua.cast(arg_3_0.layer:getChildByTag(10), "CCLabelTTF")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbAttrExplainWnd.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layer, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()
	end
end
