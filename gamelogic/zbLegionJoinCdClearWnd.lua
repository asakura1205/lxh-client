require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionJoinCdClearWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionJoinCdClearWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		local var_5_1 = CCBReaderLoad("ccbi/legionjoincdclear.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.time = tolua.cast(var_5_3:getChildByTag(4), "CCLabelTTF")
		arg_3_0.cost = tolua.cast(var_5_3:getChildByTag(7), "CCLabelTTF")
		arg_3_0.btnClearCD = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

		arg_3_0.btnClearCD:addHandleOfControlEvent(function()
			arg_3_0:onClearCD()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	local var_9_0 = zbUtil:SprintfHHMM(arg_9_1)

	arg_9_0.time:setString(var_9_0)
	arg_9_0.cost:setString(g_DataConfig.m_kLegionBaseCfg.clearCDDiamond)
end

function var_0_0.onClearCD(arg_10_0)
	arg_10_0:hide()
	g_WsMsgHandler:WS_Legion_ClearJoinCD_Req()
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
