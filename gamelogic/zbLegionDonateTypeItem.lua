local var_0_0 = class("zbLegionDonateTypeItem")

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

function createLegionDonateTypeItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
		arg_3_0.bopen = false
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(2), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)

		arg_3_0.sptexture = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbldesc = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spArrow = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.spArrow)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	arg_7_0:setVisible(arg_7_1 ~= nil)

	if arg_7_1 then
		zbLegionHelp:setLegionDonateTypeTexture(arg_7_0.sptexture, arg_7_0.lbldesc, arg_7_1.id)

		local var_7_0 = g_Self.kLegionHandler.legionDetail.LegionBaseInfo.Level

		arg_7_0.layerContent:setGray(var_7_0 < arg_7_1.unlock)
		arg_7_0.spArrow:setVisible(var_7_0 >= arg_7_1.unlock)

		arg_7_0.bopen = var_7_0 >= arg_7_1.unlock
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.data then
		if arg_8_0.bopen == false then
			g_Bubble:bubbleInfo(a2u("δ\xBD\xE2\xCB\xF8"))

			return
		end

		if arg_8_0.data.id == ELegionTechType.Legion then
			g_MainScene:showLegionDonateOpe()
		else
			g_MainScene:showLegionDonateOther(arg_8_0.data)
		end
	end
end
