local var_0_0 = {}
local var_0_1 = CCDirector:sharedDirector()

require(__FRAMEWORK_PACKAGE_NAME__ .. ".CCNodeExtend")
require(__FRAMEWORK_PACKAGE_NAME__ .. ".CCSpriteExtend")
require(__FRAMEWORK_PACKAGE_NAME__ .. ".CCLayerExtend")
require(__FRAMEWORK_PACKAGE_NAME__ .. ".CCSceneExtend")
require(__FRAMEWORK_PACKAGE_NAME__ .. ".CCShapeNodeExtend")

var_0_0.SCENE_TRANSITIONS = {
	CROSSFADE = {
		CCTransitionCrossFade,
		2
	},
	FADE = {
		CCTransitionFade,
		3,
		ccc3(0, 0, 0)
	},
	FADEBL = {
		CCTransitionFadeBL,
		2
	},
	FADEDOWN = {
		CCTransitionFadeDown,
		2
	},
	FADETR = {
		CCTransitionFadeTR,
		2
	},
	FADEUP = {
		CCTransitionFadeUp,
		2
	},
	FLIPANGULAR = {
		CCTransitionFlipAngular,
		3,
		kCCTransitionOrientationLeftOver
	},
	FLIPX = {
		CCTransitionFlipX,
		3,
		kCCTransitionOrientationLeftOver
	},
	FLIPY = {
		CCTransitionFlipY,
		3,
		kCCTransitionOrientationUpOver
	},
	JUMPZOOM = {
		CCTransitionJumpZoom,
		2
	},
	MOVEINB = {
		CCTransitionMoveInB,
		2
	},
	MOVEINL = {
		CCTransitionMoveInL,
		2
	},
	MOVEINR = {
		CCTransitionMoveInR,
		2
	},
	MOVEINT = {
		CCTransitionMoveInT,
		2
	},
	PAGETURN = {
		CCTransitionPageTurn,
		3,
		false
	},
	ROTOZOOM = {
		CCTransitionRotoZoom,
		2
	},
	SHRINKGROW = {
		CCTransitionShrinkGrow,
		2
	},
	SLIDEINB = {
		CCTransitionSlideInB,
		2
	},
	SLIDEINL = {
		CCTransitionSlideInL,
		2
	},
	SLIDEINR = {
		CCTransitionSlideInR,
		2
	},
	SLIDEINT = {
		CCTransitionSlideInT,
		2
	},
	SPLITCOLS = {
		CCTransitionSplitCols,
		2
	},
	SPLITROWS = {
		CCTransitionSplitRows,
		2
	},
	TURNOFFTILES = {
		CCTransitionTurnOffTiles,
		2
	},
	ZOOMFLIPANGULAR = {
		CCTransitionZoomFlipAngular,
		2
	},
	ZOOMFLIPX = {
		CCTransitionZoomFlipX,
		3,
		kCCTransitionOrientationLeftOver
	},
	ZOOMFLIPY = {
		CCTransitionZoomFlipY,
		3,
		kCCTransitionOrientationUpOver
	}
}
var_0_0.TEXTURES_PIXEL_FORMAT = {}
var_0_0.COLOR_WHITE = ccc3(255, 255, 255)
var_0_0.COLOR_BLACK = ccc3(0, 0, 0)
var_0_0.COLOR_RED = ccc3(255, 0, 0)
var_0_0.COLOR_GREEN = ccc3(0, 255, 0)
var_0_0.COLOR_COMMON = ccc3(255, 245, 160)

function var_0_0.newNode()
	return CCNodeExtend.extend(CCNodeRGBA:create())
end

function var_0_0.newLayer()
	return CCLayerExtend.extend(CCLayer:create())
end

function var_0_0.newScene(arg_3_0)
	local var_3_0 = CCSceneExtend.extend(CCScene:create())

	var_3_0.name = arg_3_0 or "<unknown-scene>"

	return var_3_0
end

function var_0_0.wrapSceneWithTransition(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = string.upper(tostring(arg_4_1))

	if string.sub(var_4_0, 1, 12) == "CCTRANSITION" then
		var_4_0 = string.sub(var_4_0, 13)
	end

	if var_4_0 == "RANDOM" then
		local var_4_1 = table.keys(var_0_0.SCENE_TRANSITIONS)

		var_4_0 = var_4_1[math.random(1, #var_4_1)]
	end

	if var_0_0.SCENE_TRANSITIONS[var_4_0] then
		local var_4_2, var_4_3, var_4_4 = unpack(var_0_0.SCENE_TRANSITIONS[var_4_0])

		arg_4_2 = arg_4_2 or 0.2

		if var_4_3 == 3 then
			arg_4_0 = var_4_2:create(arg_4_2, arg_4_0, arg_4_3 or var_4_4)
		else
			arg_4_0 = var_4_2:create(arg_4_2, arg_4_0)
		end
	else
		echoError("display.wrapSceneWithTransition() - invalid transitionType %s", tostring(arg_4_1))
	end

	return arg_4_0
end

function var_0_0.replaceScene(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if var_0_1:getRunningScene() then
		if arg_5_1 then
			arg_5_0 = var_0_0.wrapSceneWithTransition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		end

		var_0_1:replaceScene(arg_5_0)
	else
		var_0_1:runWithScene(arg_5_0)
	end
end

function var_0_0.getRunningScene()
	return var_0_1:getRunningScene()
end

function var_0_0.newSprite(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if not arg_7_0 then
		var_7_0 = CCSprite:create()
	elseif string.byte(arg_7_0) == 35 then
		local var_7_1 = var_0_0.newSpriteFrame(string.sub(arg_7_0, 2))

		if var_7_1 then
			var_7_0 = CCSprite:createWithSpriteFrame(var_7_1)
		end
	elseif var_0_0.TEXTURES_PIXEL_FORMAT[arg_7_0] then
		CCTexture2D:setDefaultAlphaPixelFormat(var_0_0.TEXTURES_PIXEL_FORMAT[arg_7_0])

		var_7_0 = CCSprite:create(arg_7_0)

		CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
	else
		var_7_0 = CCSprite:create(arg_7_0)
	end

	if var_7_0 then
		CCSpriteExtend.extend(var_7_0)

		if arg_7_1 and arg_7_2 then
			var_7_0:setPosition(arg_7_1, arg_7_2)
		end
	else
		echoError("display.newSprite() - create sprite failure, filename %s", tostring(arg_7_0))
	end

	return var_7_0
end

function var_0_0.newSpriteFromFile(arg_8_0)
	local var_8_0 = CCSprite:create(arg_8_0)

	CCSpriteExtend.extend(var_8_0)

	return var_8_0
end

function var_0_0.newSpriteY()
	local var_9_0 = CCSprite:create()

	CCSpriteExtend.extend(var_9_0)

	return var_9_0
end

function var_0_0.newSprite(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = type(arg_10_0)

	if var_10_0 == LUA_TUSERDATA then
		var_10_0 = tolua.type(arg_10_0)
	end

	local var_10_1

	if not arg_10_0 then
		var_10_1 = CCSprite:create()
	elseif var_10_0 == LUA_TSTRING then
		if string.byte(arg_10_0) == 35 then
			local var_10_2 = var_0_0.newSpriteFrame(string.sub(arg_10_0, 2))

			if var_10_2 then
				var_10_1 = CCSprite:createWithSpriteFrame(var_10_2)
			end
		elseif var_0_0.TEXTURES_PIXEL_FORMAT[arg_10_0] then
			CCTexture2D:setDefaultAlphaPixelFormat(var_0_0.TEXTURES_PIXEL_FORMAT[arg_10_0])

			var_10_1 = CCSprite:create(arg_10_0)

			CCTexture2D:setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
		else
			var_10_1 = CCSprite:create(arg_10_0)
		end
	elseif var_10_0 == "CCSpriteFrame" then
		var_10_1 = CCSprite:createWithSpriteFrame(arg_10_0)
	else
		echoError("display.newSprite() - invalid filename value type")

		return
	end

	if var_10_1 then
		CCSpriteExtend.extend(var_10_1)

		if arg_10_1 and arg_10_2 then
			var_10_1:setPosition(arg_10_1, arg_10_2)
		end
	else
		echoError("display.newSprite() - create sprite failure, filename %s", tostring(arg_10_0))
	end

	return var_10_1
end

function var_0_0.newBackgroundSprite(arg_11_0)
	return var_0_0.newSprite(arg_11_0, var_0_0.cx, var_0_0.cy)
end

return var_0_0
