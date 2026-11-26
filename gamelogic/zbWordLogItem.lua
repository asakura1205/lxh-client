local var_0_0 = class("zbWordLogItem")

var_0_0.__index = var_0_0

local var_0_1 = {
	[EWorldLogType.ResNodeAttacked] = "ui/image/world/logbg1.png",
	[EWorldLogType.TaskComplete] = "ui/image/world/logbg2.png",
	[EWorldLogType.ResNodeOccupy] = "ui/image/world/logbg1.png"
}

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createWordLogItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.parent = arg_3_1
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_2:getChildByTag(1), "CCNode")

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)

		arg_3_0.bgSp = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbl = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_2)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	if arg_7_1 then
		local var_7_0 = ""

		if arg_7_1.LogType == EWorldLogType.ResNodeAttacked then
			var_7_0 = a2u(arg_7_1.LogData) .. a2u("\xB9\xA5\xBB\xF7\xC1\xCB\xC4\xE3\xB5\xC4\xD7\xCAԴ\xB5\xE3")
		elseif arg_7_1.LogType == EWorldLogType.ResNodeOccupy then
			var_7_0 = a2u(arg_7_1.LogData) .. a2u("ռ\xC1\xEC\xC1\xCB\xC4\xE3\xB5\xC4\xD7\xCAԴ\xB5\xE3")
		elseif arg_7_1.LogType == EWorldLogType.TaskComplete then
			var_7_0 = a2u("\xD3\xD0\xC8\xCE\xCE\xF1\xCD\xEA\xB3\xC9\xC1\xCB")
		end

		local var_7_1 = var_0_1[arg_7_1.LogType]

		if var_7_1 then
			arg_7_0.bgSp:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
		end

		arg_7_0.lbl:setString(var_7_0)
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.data then
		if arg_8_0.parent then
			arg_8_0.parent:setShow(false)
		end

		local var_8_0 = arg_8_0.data.NodeId

		if g_MainScene.wndWorld then
			g_MainScene.wndWorld:foucsNode(var_8_0)
		end
	end
end
