require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGuideWnd", zbBaseWnd)

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

function createGuideWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.bShowCutLayer = true
		arg_3_0.lastR = 400
		arg_3_0.frameCount = 0
		arg_3_0.watchWnd = nil
		arg_3_0.watchWndAccumTime = 0
		arg_3_0.potisionX = 0
		arg_3_0.potisionY = 0
		arg_3_0.touchFunction = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/guide.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_1:getChildByTag(2), "CCNode")

		arg_3_0.node = var_5_1
		arg_3_0.layer = var_5_2
		arg_3_0.layerFinger = var_5_3
		arg_3_0.btnFunc = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")
		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(0), "CCControlButton")
		arg_3_0.layerShadow = tolua.cast(var_5_1:getChildByTag(15), "CCLayerColor")
		arg_3_0.layerBlack = tolua.cast(var_5_1:getChildByTag(16), "CCLayerColor")

		arg_3_0.layerShadow:setVisible(false)
		arg_3_0.layerBlack:setVisible(false)

		if arg_3_0.bShowCutLayer then
			arg_3_0.layerShadow:setCutoutLayer(arg_3_0.bShowCutLayer)
		end

		arg_3_0.btnTouchTest:setSoundTag(SOUNDTAG_NOSOUND)
		arg_3_0.btnFunc:addHandleOfControlEvent(function()
			arg_3_0:onTouchFunc()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.uiEffect = createUIAnimation()

		arg_3_0.uiEffect:refresh("effect/spine/ui_yindaodianji/ui_yindaodianji.json", "effect/spine/ui_yindaodianji/ui_yindaodianji.atlas")
		arg_3_0.uiEffect:setAnimation("animation", true)
		var_5_3:addChild(arg_3_0.uiEffect)

		arg_3_0.effectLayer = tolua.cast(var_5_1:getChildByTag(3), "CCNode")

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.setFingerPosition(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.watchNode = arg_10_1
	arg_10_0.watchWnd = arg_10_2
	arg_10_0.watchWndAccumTime = 0

	if arg_10_0.watchWnd ~= nil then
		arg_10_0:setPosition(10000, 10000)
	else
		arg_10_0:setPosition(0, 0)
	end

	arg_10_0:setTouchPosition()
end

function var_0_0.setHeroMove(arg_11_0)
	if arg_11_0.editingAnimation == nil then
		arg_11_0.editingAnimation = createUIAnimation()

		arg_11_0.editingAnimation:setScale(1)
		arg_11_0.editingAnimation:setRotationY(180)
		arg_11_0.effectLayer:addChild(arg_11_0.editingAnimation)
	end
end

function var_0_0.adapterFlip(arg_12_0, arg_12_1)
	arg_12_1:setPositionX(arg_12_1:getPositionX() / arg_12_0.node:getScaleX() - arg_12_0.node:getPositionX())
	arg_12_1:setPositionY(arg_12_1:getPositionY() / arg_12_0.node:getScaleY() - arg_12_0.node:getPositionY())

	if g_Layout:isWHRatio4_3() then
		local var_12_0 = CCEGLView:sharedOpenGLView():getFrameSize()

		arg_12_1:setPositionY(arg_12_1:getPositionY() + var_12_0.height / 768 * 90 - 100)
	end
end

function var_0_0.setTouchFunction(arg_13_0, arg_13_1)
	arg_13_0.touchFunction = arg_13_1
end

function var_0_0.onTouchDown(arg_14_0)
	if arg_14_0:getPositionX() > 0 then
		return
	end

	arg_14_0.layerShadow:setVisible(true)

	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()
end

function var_0_0.onTouchMove(arg_15_0)
	return
end

function var_0_0.onTouchEnd(arg_16_0)
	return
end

function var_0_0.onTouchFunc(arg_17_0)
	if arg_17_0.touchFunction ~= nil then
		arg_17_0.touchFunction()
	end
end

function var_0_0.onWndFadeOver(arg_18_0)
	if g_Guide:isGuiding() == false then
		return
	end

	if arg_18_0.watchWnd ~= nil then
		arg_18_0:setPosition(0, 0)
		arg_18_0:setTouchPosition()
	end
end

function var_0_0.setTouchPosition(arg_19_0)
	local var_19_0 = zbUtil:getGuidePos(arg_19_0.watchNode)

	arg_19_0.potisionX = var_19_0.x
	arg_19_0.potisionY = var_19_0.y

	arg_19_0.layerFinger:setPosition(arg_19_0.potisionX, arg_19_0.potisionY)
	arg_19_0:adapterFlip(arg_19_0.layerFinger)
end

function var_0_0.onFrameUpdate(arg_20_0, arg_20_1)
	if arg_20_0.layerShadow:isVisible() and arg_20_0.bShowCutLayer then
		arg_20_0.lastR = arg_20_0.lastR - 30

		if arg_20_0.lastR <= 30 then
			arg_20_0.frameCount = arg_20_0.frameCount + 1

			if arg_20_0.frameCount > 10 then
				arg_20_0.layerShadow:setVisible(false)
			end

			return
		end

		arg_20_0.layerShadow:setCenterRadius(arg_20_0.potisionX, arg_20_0.potisionY, arg_20_0.lastR / 1)
	else
		arg_20_0.lastR = 400
		arg_20_0.frameCount = 0
	end
end
