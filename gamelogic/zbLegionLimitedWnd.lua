require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionLimitedWnd", zbBaseWnd)

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

function createLegionLimitedWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.selHeadId = 0
		arg_3_0.levelLimited = 20
		arg_3_0.typeindex = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionlimitset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.touchLayer = var_5_2
		arg_3_0.lbNeedAck = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbNeedLevel = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbTitle1 = tolua.cast(var_5_2:getChildByTag(101), "CCLabelTTF")
		arg_3_0.lbTitle2 = tolua.cast(var_5_2:getChildByTag(102), "CCLabelTTF")
		arg_3_0.lbTitle3 = tolua.cast(var_5_2:getChildByTag(103), "CCLabelTTF")
		arg_3_0.btnPreType = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")
		arg_3_0.btnNextType = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.btnPreLevel = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnNextLevel = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.btnConfirm = tolua.cast(var_5_2:getChildByTag(14), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnPreType:addHandleOfControlEvent(function()
			arg_3_0:doPreType()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnNextType:addHandleOfControlEvent(function()
			arg_3_0:doNextType()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnPreLevel:addHandleOfControlEvent(function()
			arg_3_0:doPreLevel()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnNextLevel:addHandleOfControlEvent(function()
			arg_3_0:doNextLevel()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnConfirm:addHandleOfControlEvent(function()
			arg_3_0:doConfirmLimited()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.touchLayer, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end

function var_0_0.doPreType(arg_15_0)
	arg_15_0.typeindex = arg_15_0.typeindex - 1

	arg_15_0:setType(arg_15_0.typeindex)
end

function var_0_0.doNextType(arg_16_0)
	arg_16_0.typeindex = arg_16_0.typeindex + 1

	arg_16_0:setType(arg_16_0.typeindex)
end

function var_0_0.setType(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = zbLegionHelp:getLimitedType(arg_17_1)

	arg_17_0.typeindex = var_17_1

	arg_17_0.lbNeedAck:setString(var_17_0)
end

function var_0_0.setLevel(arg_18_0, arg_18_1)
	local var_18_0 = ""
	local var_18_1, var_18_2 = zbLegionHelp:getLimitedLevel(arg_18_1)

	arg_18_0.levelLimited = var_18_2

	arg_18_0.lbNeedLevel:setString(var_18_1)
end

function var_0_0.doPreLevel(arg_19_0)
	arg_19_0.levelLimited = arg_19_0.levelLimited - 1

	arg_19_0:setLevel(arg_19_0.levelLimited)
end

function var_0_0.doNextLevel(arg_20_0)
	arg_20_0.levelLimited = arg_20_0.levelLimited + 1

	arg_20_0:setLevel(arg_20_0.levelLimited)
end

function var_0_0.doConfirmLimited(arg_21_0)
	local var_21_0 = arg_21_0.levelLimited

	g_WsMsgHandler:WS_LegionManage_JoinSet_Req(var_21_0, arg_21_0.typeindex - 1)
end

function var_0_0.refresh(arg_22_0)
	if g_Self.kLegionHandler.legionDetail == nil then
		return
	end

	local var_22_0 = g_Self.kLegionHandler.legionDetail.LegionBaseInfo

	arg_22_0:setType(var_22_0.Confirm + 1)
	arg_22_0:setLevel(var_22_0.LimitLvl)
end
