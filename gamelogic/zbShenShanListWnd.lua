require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShenShanListWnd", zbBaseWnd)

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

function createShenShanListWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	(function()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setPosition(130, 150)
			var_5_0:setVisible(false)
			arg_5_0:addChild(var_5_0)
			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		local var_4_1 = CCBProxy:create()
		local var_4_2 = CCBReaderLoad("ccbi/shenShan.ccbi", var_4_1, true, "HelloCocosBuilderLayerOwner")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCNode")

		arg_3_0.btn_pata = tolua.cast(var_4_3:getChildByTag(1), "CCControlButton")
		arg_3_0.btn_yuanzheng = tolua.cast(var_4_3:getChildByTag(2), "CCControlButton")
		arg_3_0.bgPataDouble = tolua.cast(var_4_3:getChildByTag(11), "CCSprite")
		arg_3_0.bgBgzDouble = tolua.cast(var_4_3:getChildByTag(12), "CCSprite")
		arg_3_0.btntouch = tolua.cast(var_4_2:getChildByTag(100), "CCControlButton")

		arg_3_0.btntouch:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btn_pata:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onPata), CCControlEventTouchUpInside)
		arg_3_0.btn_yuanzheng:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onYuanzheng), CCControlEventTouchUpInside)

		arg_3_0.pataNotify = var_4_0(arg_3_0.btn_pata)
		arg_3_0.yuanzhengNotify = var_4_0(arg_3_0.btn_yuanzheng)

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_4_2)
	end)()
end

function var_0_0.onPata(arg_7_0)
	arg_7_0:hide()
	g_Self.kPataHandler:openPata()
end

function var_0_0.onYuanzheng(arg_8_0)
	arg_8_0:hide()
	g_Self.kYuanzhengHandler:openYuanzheng()
end

function var_0_0.updateNotify(arg_9_0)
	if g_GameData.PataInfo ~= nil then
		arg_9_0.pataNotify:setVisible(zbFunHelper:isLockNoTip(EFuncType.Pata) == false and (g_GameData.PataInfo.BaseInfo.Layer == 1 or g_Self.kPataHandler:getLayerType(g_GameData.PataInfo.BaseInfo.Layer) == EPataLayerType.Award or g_Self.kPataHandler:getJiFenNotify()))
	end

	arg_9_0.yuanzhengNotify:setVisible(zbFunHelper:isLockNoTip(EFuncType.Bgz) == false and g_GameData.BgzInfo.CurLevel < 9 and (g_GameData.BgzInfo.CurLevel == 1 or g_GameData.BgzInfo.State == 1 or g_Self.kYuanzhengHandler:getJiFenNotify()))
end

function var_0_0.refresh(arg_10_0)
	arg_10_0:updateNotify()
	arg_10_0.btn_pata:setGray(zbFunHelper:isLockNoTip(EFuncType.Pata))
	arg_10_0.btn_yuanzheng:setGray(zbFunHelper:isLockNoTip(EFuncType.Bgz))
	arg_10_0.bgBgzDouble:setVisible(g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.Bgz) ~= nil)
	arg_10_0.bgPataDouble:setVisible(g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.Pata) ~= nil)
end

function var_0_0.onTouchTest(arg_11_0, arg_11_1, arg_11_2)
	if zbUtil:PointInCtrl(arg_11_0.btn_pata, arg_11_1, arg_11_2) or zbUtil:PointInCtrl(arg_11_0.btn_yuanzheng, arg_11_1, arg_11_2) then
		return true
	end

	return false
end
