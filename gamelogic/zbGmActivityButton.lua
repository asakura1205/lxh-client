local var_0_0 = class("zbGmActivityButton", CCNodeExtend)

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

function createGmActivityButton(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local function var_3_0()
		return
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.btnFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteActTime = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCSprite")

		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)

		if arg_3_2 == 0 then
			zbUtil:setButtonTitle(arg_3_0.btnFrame, a2u(arg_3_3))
		end

		arg_3_0.spriteActTime:setZOrder(ZORDER_TOP + 100)
		arg_3_0.spriteActTime:setVisible(arg_3_4 == true)
		arg_3_0:setContentSize(arg_3_0.layerContent:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end
