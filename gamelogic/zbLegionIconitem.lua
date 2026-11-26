local var_0_0 = class("zbLegionIconitem", CCNodeExtend)

var_0_0.__index = var_0_0

function createLegionIconItem(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

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

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.id = 1011
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(2), "CCControlButton")

		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)

		arg_3_0.facesp = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

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
	arg_7_0.id = arg_7_1

	local var_7_0 = zbIconHelper:getLegionIconPath(arg_7_1)

	arg_7_0.facesp:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
end

function var_0_0.onTouch(arg_8_0)
	g_Self.kLegionHandler.selIconId = arg_8_0.id

	echo("........self.id........", arg_8_0.id)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionIconSelBack)
	g_MainScene.wndLegionIconSel:hide()
end
