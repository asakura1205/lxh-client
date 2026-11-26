require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbSettingHeadWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createSettingHeadWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/sethead.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.btnAlbum = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCControlButton")
		arg_3_0.btnPhoto = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCControlButton")
		arg_3_0.btnSystem = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnAlbum:addHandleOfControlEvent(function()
			arg_3_0:onAlbum()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnPhoto:addHandleOfControlEvent(function()
			arg_3_0:onPhoto()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSystem:addHandleOfControlEvent(function()
			arg_3_0:onSystem()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	return
end

function var_0_0.onAlbum(arg_11_0)
	zbGlobalUtil:openPhoto()
end

function var_0_0.onPhoto(arg_12_0)
	zbGlobalUtil:openCamera()
end

function var_0_0.onSystem(arg_13_0)
	return
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layer, var_14_0.x, var_14_0.y) == false and zbUtil:PointInCtrl(arg_14_0.btnClose, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
