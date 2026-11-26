require("gamelogic.zbMainWnd_Building")

local var_0_0 = class("zbMainWnd_Scene")

var_0_0.__index = var_0_0

local var_0_1 = 600
local var_0_2 = -664
local var_0_3 = 0.05
local var_0_4 = 0.4

function createMainWndScene(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.parentWnd = arg_2_1
	arg_2_0.parent = arg_2_2
	arg_2_0.curRotate = 0
	arg_2_0.touchMoveBegan = false
	arg_2_0.soundItms = {}

	arg_2_0:initCCB()
	arg_2_0:initTouch()

	arg_2_0.buildingHandler = createMainWndBuilding(arg_2_1, arg_2_0.container)
end

function var_0_0.initCCB(arg_3_0)
	local var_3_0 = CCBProxy:create()
	local var_3_1 = CCBReaderLoad("ccbi/main_scene.ccbi", var_3_0, true, "HelloCocosBuilderLayerOwner", true)

	arg_3_0.container = tolua.cast(var_3_1:getChildByTag(0), "CCLayer")

	arg_3_0.container:setAnchorPoint(ccp(0, 0))

	arg_3_0.earthLayer = tolua.cast(arg_3_0.container:getChildByTag(100), "CCNode")
	arg_3_0.mountainLayer = tolua.cast(arg_3_0.container:getChildByTag(200), "CCNode")
	arg_3_0.earthSprite = tolua.cast(arg_3_0.earthLayer:getChildByTag(1), "CCNode")
	arg_3_0.earthAnimation = createUIAnimation()

	arg_3_0.earthAnimation:refresh("effect/spine/scene_zhucheng_layer01/scene_zhucheng_layer01.json", "effect/spine/scene_zhucheng_layer01/scene_zhucheng_layer01.atlas")
	arg_3_0.earthAnimation:setPosition(1200, 320)
	arg_3_0.earthAnimation:setAnimation("animation", true)
	arg_3_0.earthSprite:addChild(arg_3_0.earthAnimation)

	arg_3_0.earthAnimation2 = createUIAnimation()

	arg_3_0.earthAnimation2:refresh("effect/spine/scene_zhucheng_layer03/scene_zhucheng_layer03.json", "effect/spine/scene_zhucheng_layer03/scene_zhucheng_layer03.atlas")
	arg_3_0.earthAnimation2:setPosition(1200, 320)
	arg_3_0.earthAnimation2:setAnimation("animation", true)
	arg_3_0.earthSprite:addChild(arg_3_0.earthAnimation2)

	arg_3_0.startRotate = arg_3_0.earthLayer:getPositionX()
	arg_3_0.startPositionY = arg_3_0.earthLayer:getPositionY()
	arg_3_0.startmountainPositionY = arg_3_0.mountainLayer:getPositionY()
	arg_3_0.buildingLayer = tolua.cast(arg_3_0.earthLayer:getChildByTag(100), "CCNode")
	arg_3_0.touchSound = tolua.cast(arg_3_0.earthLayer:getChildByTag(2), "CCNode")

	for iter_3_0 = 1, 7 do
		arg_3_0.soundItms[iter_3_0] = tolua.cast(arg_3_0.touchSound:getChildByTag(iter_3_0), "CCControlButton")

		arg_3_0.soundItms[iter_3_0]:addHandleOfControlEvent(function()
			arg_3_0:onSoundItms(iter_3_0)
		end, CCControlEventTouchUpInside)
	end

	arg_3_0.container:removeFromParentAndCleanup(false)
	arg_3_0.parent:addChild(arg_3_0.container)
end

function var_0_0.initTouch(arg_5_0)
	local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == TOUCH_EVENT_TYPE_BEGAN then
			return arg_5_0:touchBegan(arg_6_1, arg_6_2)
		elseif arg_6_0 == TOUCH_EVENT_TYPE_MOVED then
			return arg_5_0:touchMoved(arg_6_1, arg_6_2)
		elseif arg_6_0 == TOUCH_EVENT_TYPE_ENDED then
			return arg_5_0:touchEnded(arg_6_1, arg_6_2)
		end
	end

	arg_5_0.container:setTouchEnabled(true)
	arg_5_0.container:registerScriptTouchHandler(var_5_0)
end

function var_0_0.onFrameUpdate(arg_7_0, arg_7_1)
	arg_7_0.buildingHandler:onFrameUpdate(arg_7_1)
end

function var_0_0.touchBegan(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.touchMoveBegan = false

	if arg_8_0.parentWnd:isTouchOnUI(arg_8_1, arg_8_2) then
		return false
	end

	arg_8_0.touchMoveBegan = true
	arg_8_0.startPos = ccp(arg_8_1, arg_8_2)
	arg_8_0.startRotate = arg_8_0.earthLayer:getPositionX()
	arg_8_0.curRotate = arg_8_0.startRotate
	arg_8_0.startTime = os_timenow()

	arg_8_0.buildingHandler:touchBegan(arg_8_1, arg_8_2)

	return true
end

function var_0_0.touchMoved(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.touchMoveBegan then
		return
	end

	local var_9_0 = arg_9_1 - arg_9_0.startPos.x
	local var_9_1 = arg_9_0.startRotate + var_9_0 / 1.2

	if var_9_1 > var_0_1 then
		var_9_1 = var_0_1
	elseif var_9_1 < var_0_2 then
		var_9_1 = var_0_2
	end

	arg_9_0:rotateScene(var_9_1, false)
	arg_9_0.buildingHandler:touchMoved(arg_9_1, arg_9_2)
end

function var_0_0.touchEnded(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.touchMoveBegan then
		return
	end

	arg_10_0.buildingHandler:touchEnded(arg_10_1, arg_10_2)

	local var_10_0 = os_timenow() - arg_10_0.startTime
	local var_10_1 = arg_10_1 - arg_10_0.startPos.x

	if var_10_0 < 1 then
		var_10_0 = 1
	end

	local var_10_2 = var_10_1 / var_10_0
	local var_10_3 = arg_10_0.earthLayer:getPositionX() + var_10_2 / 20

	if var_10_3 > var_0_1 then
		var_10_3 = var_0_1
	elseif var_10_3 < var_0_2 then
		var_10_3 = var_0_2
	end

	arg_10_0:rotateScene(var_10_3, true)

	return true
end

function var_0_0.foucsBuild(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.buildingHandler:getBuldPos(arg_11_1)

	if var_11_0 then
		local var_11_1 = 568 - (arg_11_0.earthLayer:getPositionX() - arg_11_0.earthLayer:getContentSize().width * arg_11_0.earthLayer:getAnchorPoint().x) - var_11_0.x

		arg_11_0:rotateScene(var_11_1, arg_11_2, arg_11_3)
	end
end

function var_0_0.rotateScene(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 then
		local var_12_0 = var_0_3

		if arg_12_3 ~= nil then
			var_12_0 = arg_12_3
		end

		if arg_12_1 > var_0_1 then
			arg_12_1 = var_0_1
		elseif arg_12_1 < var_0_2 then
			arg_12_1 = var_0_2
		end

		arg_12_0.mountainLayer:runAction(CCMoveTo:create(var_12_0, ccp(arg_12_1 * var_0_4, arg_12_0.startmountainPositionY)))
		arg_12_0.earthLayer:runAction(CCMoveTo:create(var_12_0, ccp(arg_12_1, arg_12_0.startPositionY)))
	else
		if arg_12_1 > var_0_1 then
			arg_12_1 = var_0_1
		elseif arg_12_1 < var_0_2 then
			arg_12_1 = var_0_2
		end

		arg_12_0.mountainLayer:setPositionX(arg_12_1 * var_0_4)
		arg_12_0.earthLayer:setPositionX(arg_12_1)
	end

	arg_12_0.curRotate = arg_12_1
end

function var_0_0.onSoundItms(arg_13_0, arg_13_1)
	if arg_13_1 == 1 then
		g_Audio:playSound(zbIconHelper:getHeroSoundPath(1101))
	end

	if arg_13_1 >= 2 and arg_13_1 <= 4 then
		if zbUtil:random(1, 2) == 1 then
			g_Audio:playSound(zbIconHelper:getHeroSoundPath(1071))
		else
			g_Audio:playSound(zbIconHelper:getHeroSoundPath(1083))
		end
	end

	if arg_13_1 == 5 then
		if zbUtil:random(1, 2) == 1 then
			g_Audio:playSound(zbIconHelper:getHeroSoundPath(1022))
		else
			g_Audio:playSound(zbIconHelper:getHeroSoundPath(1025))
		end
	end

	if arg_13_1 == 6 then
		g_Audio:playSound(zbIconHelper:getHeroSoundPath("niaojiao"))
	end

	if arg_13_1 == 7 then
		g_Audio:playSound(zbIconHelper:getHeroSoundPath(1021))
	end
end
