local var_0_0 = class("zbWarForceStarItem", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createWarForceStarItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.boxStatus = var_0_1
		arg_3_0.boxIndex = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteEffect = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteBox = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbStarCountDummy = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbStarCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbStarCountDummy, arg_3_0.lbStarCount)
		arg_3_0.lbStarCount:setScale(0.6)

		local var_5_1 = CCRotateBy:create(5, 360)

		arg_3_0.spriteEffect:runAction(CCRepeatForever:create(var_5_1))
		arg_3_0:addChild(arg_3_1)
		arg_3_0.btnTouch:setZoomChildNode(arg_3_0.spriteBox)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomScaleOuterFactor(1.1)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchBox()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.levelType = arg_7_1
	arg_7_0.forceId = arg_7_2
	arg_7_0.starCount = arg_7_3

	local var_7_0, var_7_1 = g_Self.kWarPathHandler:getForceStarCount(arg_7_0.levelType, arg_7_0.forceId)
	local var_7_2 = g_Self.kWarPathHandler:isGetForceAward(arg_7_0.levelType, arg_7_0.forceId, arg_7_3)

	arg_7_0.lbStarCount:setString(arg_7_3)

	if var_7_2 then
		arg_7_0.boxStatus = var_0_3
	elseif var_7_0 < arg_7_3 then
		arg_7_0.boxStatus = var_0_1
	else
		arg_7_0.boxStatus = var_0_2
	end

	local var_7_3 = string.format("image/warpath/forcedetail/giftbox%d%d.png", arg_7_0.boxIndex, arg_7_0.boxStatus)

	arg_7_0.spriteBox:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_3))
	arg_7_0.spriteEffect:setVisible(arg_7_0.boxStatus == var_0_2)
end

function var_0_0.onTouchBox(arg_8_0)
	if arg_8_0.boxStatus == var_0_3 then
		g_Bubble:bubbleInfo("\xD2\xD1\xC1\xECȡ\xBD\xB1\xC0\xF8")

		return
	end

	g_MainScene:showForceAward(arg_8_0.levelType, arg_8_0.forceId, arg_8_0.starCount)
end
