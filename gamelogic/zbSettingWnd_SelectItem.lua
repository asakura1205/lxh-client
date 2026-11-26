local var_0_0 = class("zbSettingWnd_SelectItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createSettingSelectItem(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0, arg_1_1)

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

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.pushData = g_PushCenter:getPushMessage(arg_3_2)
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.lbDesc = tolua.cast(var_5_1:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnSwitch = tolua.cast(var_5_1:getChildByTag(2), "CCControlButton")
		arg_3_0.spriteYes = tolua.cast(var_5_1:getChildByTag(3), "CCSprite")

		arg_3_0.btnSwitch:addHandleOfControlEvent(function()
			arg_3_0:onSwitch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0.lbDesc:setString(a2u(E_TITLE[arg_3_0.pushData.type]))
end

function var_0_0.refresh(arg_7_0)
	arg_7_0.spriteYes:setVisible(arg_7_0.pushData.set_state .. "" == "1")
end

function var_0_0.onSwitch(arg_8_0)
	arg_8_0.spriteYes:setVisible(not arg_8_0.spriteYes:isVisible())

	if arg_8_0.spriteYes:isVisible() then
		g_PushCenter:setSettingPushOn(arg_8_0.pushData.type)
	else
		g_PushCenter:setSettingPushOff(arg_8_0.pushData.type)
	end

	if arg_8_0.pushData.type == EPushType.E_TILI_GET1 then
		for iter_8_0 = EPushType.E_TILI_GET2, EPushType.E_TILI_GET3 do
			if arg_8_0.spriteYes:isVisible() then
				g_PushCenter:setSettingPushOn(iter_8_0)
			else
				g_PushCenter:setSettingPushOff(iter_8_0)
			end
		end
	end
end
