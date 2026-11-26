require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWaitMomentWnd", zbBaseWnd)

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

function createWaitMomentWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/waitMoment.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCLayer")

		arg_3_0.layer = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.lbBubble = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCLabelTTF")

		local var_5_3 = CCArray:create()

		var_5_3:addObject(CCCallFuncN:create(function()
			arg_3_0.lbBubble:setString(".")
		end))
		var_5_3:addObject(CCDelayTime:create(0.3))
		var_5_3:addObject(CCCallFuncN:create(function()
			arg_3_0.lbBubble:setString("..")
		end))
		var_5_3:addObject(CCDelayTime:create(0.3))
		var_5_3:addObject(CCCallFuncN:create(function()
			arg_3_0.lbBubble:setString("...")
		end))
		var_5_3:addObject(CCDelayTime:create(0.3))
		var_5_3:addObject(CCCallFuncN:create(function()
			arg_3_0.lbBubble:setString("....")
		end))
		var_5_3:addObject(CCDelayTime:create(0.3))
		var_5_3:addObject(CCCallFuncN:create(function()
			arg_3_0.lbBubble:setString(".....")
		end))
		var_5_3:addObject(CCDelayTime:create(0.3))

		local var_5_4 = CCSequence:create(var_5_3)

		arg_3_0.lbBubble:stopAllActions()
		arg_3_0.lbBubble:runAction(CCRepeatForever:create(var_5_4))
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.onFrameUpdate(arg_11_0)
	if arg_11_0.isShow then
		local var_11_0 = zbGlobalUtil:getPayOrderState()

		if tonumber(var_11_0) == 0 then
			arg_11_0:hide()
		end
	end
end
