local var_0_0 = class("zbServerListItem", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = {
	"ui/image/common/btn190_green.png",
	"ui/image/common/btn190_yellow.png"
}

function createServerListItem(arg_1_0, arg_1_1)
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
		arg_3_0.index = arg_3_2
	end

	local function var_3_1()
		arg_3_0.bgSprite = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.lbTitle = tolua.cast(arg_3_0.bgSprite:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbTitle:setString((arg_3_2 - 1) * 10 + 1 .. "--" .. arg_3_2 * 10 .. a2u("\xC7\xF8"))

		arg_3_0.btnTouch = tolua.cast(arg_3_0.bgSprite:getChildByTag(4), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0:addChild(arg_3_1)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:setContentSize(arg_3_0.bgSprite:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.setItemSelected(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1[2]

	if arg_7_1 then
		var_7_0 = var_0_1[1]
	end

	ui:setButtonPic(arg_7_0.btnTouch, var_7_0, var_7_0, var_7_0)
end

function var_0_0.setAreaTitle(arg_8_0, arg_8_1)
	arg_8_0.lbTitle:setString((arg_8_0.index - 1) * 10 + 1 .. "--" .. (arg_8_0.index - 1) * 10 + arg_8_1 .. a2u("\xC7\xF8"))
end

function var_0_0.onTouchDown(arg_9_0)
	if g_LoginScene and g_LoginScene.wndServerList then
		g_LoginScene.wndServerList:onSelAllServerList(arg_9_0.index)
	end
end
