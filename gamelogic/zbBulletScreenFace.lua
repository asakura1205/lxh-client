local var_0_0 = class("zbBulletScreenFace", CCNodeExtend)

var_0_0.__index = var_0_0

function createBulletScreenFace(arg_1_0, arg_1_1)
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
		arg_3_0.parent = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")

		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)

		arg_3_0.facesp = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")

		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_1 = string.format("%02d", arg_7_1)
	arg_7_0.data = arg_7_1

	local var_7_0 = arg_7_1 .. ".png"

	arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/face.plist")

	local var_7_1 = arg_7_0.spriteframeCache:spriteFrameByName(var_7_0)

	if var_7_1 then
		arg_7_0.facesp:initWithSpriteFrame(var_7_1)
	end
end

function var_0_0.onTouch(arg_8_0)
	local var_8_0 = "[" .. arg_8_0.data .. "]"

	arg_8_0.parent:setInputBoxStr(a2u(var_8_0))
end
