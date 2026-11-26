zbWarPathItem = class("zbWarPathItem", CCNodeExtend)
zbWarPathItem.__index = zbWarPathItem

local var_0_0 = 258
local var_0_1 = 460

function zbWarPathItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWarPathItem)

	return arg_1_0
end

function createWarPathItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbWarPathItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function zbWarPathItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.parentWnd = arg_3_1
		arg_3_0.levelType = -1
		arg_3_0.forceId = arg_3_3
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_2:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteFrame = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteForce = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.spritePerfect = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.spriteLock = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.lbComeLevel = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		arg_3_0.spriteRedPoint = tolua.cast(var_5_0:getChildByTag(8), "CCSprite")
		arg_3_0.spriteStars = {}
		arg_3_0.spriteStars[1] = tolua.cast(var_5_0:getChildByTag(11), "CCSprite")
		arg_3_0.spriteStars[2] = tolua.cast(var_5_0:getChildByTag(12), "CCSprite")
		arg_3_0.spriteStars[3] = tolua.cast(var_5_0:getChildByTag(13), "CCSprite")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomChildNode(var_5_0)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomScaleOuterFactor(1.03)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_2)
		arg_3_0:setContentSize(CCSizeMake(var_0_0, var_0_1))

		local var_5_1 = string.format("image/warpath/forcelist/fl_forcetag_%d.png", arg_3_0.forceId)

		arg_3_0.spriteForce:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_1))
	end

	var_3_0()
	var_3_1()
end

function zbWarPathItem.releaseBg(arg_7_0)
	arg_7_0.spriteForce:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcelist/fl_forcetag_1.png"))
end

function zbWarPathItem.refreshBg(arg_8_0)
	local var_8_0 = string.format("image/warpath/forcelist/fl_forcetag_%d.png", arg_8_0.forceId)

	arg_8_0.spriteForce:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
end

function zbWarPathItem.refresh(arg_9_0, arg_9_1)
	arg_9_0.layer:setScale(1)

	arg_9_0.levelType = arg_9_1

	local var_9_0 = g_Self.kWarPathHandler:isVisibleForce(arg_9_0.levelType, arg_9_0.forceId)

	arg_9_0.spriteLock:setVisible(var_9_0 == false)
	arg_9_0:setGray(var_9_0 == false)

	if var_9_0 == true then
		if arg_9_0.levelType == ELevelType.Normal then
			arg_9_0.spriteFrame:setColor(FONT_COLOR_WHITE)
		elseif arg_9_0.levelType == ELevelType.Elite then
			arg_9_0.spriteFrame:setColor(FORCE_COLOR_ELITE)
		elseif arg_9_0.levelType == ELevelType.Nightmare then
			arg_9_0.spriteFrame:setColor(FORCE_COLOR_NIGHTMARE)
		end
	else
		arg_9_0.spriteFrame:setColor(FONT_COLOR_WHITE)
	end

	local var_9_1 = g_Self.kWarPathHandler:hasAvailableForceAward(arg_9_0.levelType, arg_9_0.forceId)

	if var_9_1 == false and arg_9_0.levelType == ELevelType.Normal then
		var_9_1 = g_Self.kTreaSureHandler:hasRedPoint(arg_9_0.forceId)
	end

	arg_9_0.spriteRedPoint:setVisible(var_9_1)

	local var_9_2 = zbForceTable:getRecord(arg_9_0.forceId)

	if var_9_2 ~= nil then
		arg_9_0.lbComeLevel:setVisible(g_Self:getLevel() < var_9_2.loginLevel)
		arg_9_0.lbComeLevel:setString(a2u("(") .. var_9_2.loginLevel .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4\xA3\xA9"))
	else
		local var_9_3 = math.min(arg_9_0.forceId * 10, 90)

		arg_9_0.lbComeLevel:setVisible(true)
		arg_9_0.lbComeLevel:setString(a2u("(") .. var_9_3 .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4\xA3\xA9"))
	end

	local var_9_4, var_9_5 = g_Self.kWarPathHandler:getForceStarCount(arg_9_0.levelType, arg_9_0.forceId)

	arg_9_0.spriteStars[1]:setVisible(var_9_0)
	arg_9_0.spriteStars[2]:setVisible(var_9_0)
	arg_9_0.spriteStars[3]:setVisible(var_9_0)
	arg_9_0.spriteStars[1]:setGray(var_9_4 < var_9_5 / 3)
	arg_9_0.spriteStars[2]:setGray(var_9_4 < var_9_5 / 3 * 2)
	arg_9_0.spriteStars[3]:setGray(var_9_4 < var_9_5)
	arg_9_0.spritePerfect:setVisible(var_9_5 <= var_9_4)

	local var_9_6 = string.format("image/warpath/forcelist/fl_forcetag_%d.png", arg_9_0.forceId)

	arg_9_0.spriteForce:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_6))
end

function zbWarPathItem.onTouch(arg_10_0)
	if arg_10_0.levelType == ELevelType.Elite or arg_10_0.levelType == ELevelType.Nightmare then
		local var_10_0 = zbForceSetTable:getLastLevelId(arg_10_0.forceId)

		if g_Self.kWarPathHandler:getLevelStar(arg_10_0.levelType - 1, arg_10_0.forceId, var_10_0) <= 0 then
			if arg_10_0.levelType == ELevelType.Elite then
				g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ͨ\xB9ظ\xC3\xD5½\xDA\xC6\xD5ͨģʽ"))
			elseif arg_10_0.levelType == ELevelType.Nightmare then
				g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ͨ\xB9ظ\xC3\xD5½ھ\xABӢģʽ"))
			end

			return
		end
	end

	if g_Self.kWarPathHandler:isVisibleForce(arg_10_0.levelType, arg_10_0.forceId) == false then
		g_Bubble:bubbleInfo("ǰ\xD6\xC3\xD5½\xDAͨ\xB9غ\xF3\xBD\xE2\xCB\xF8")

		return
	end

	local var_10_1 = zbForceTable:getRecord(arg_10_0.forceId)

	if var_10_1.sound ~= "" then
		g_Audio:playSound(var_10_1.sound)
	end

	arg_10_0.parentWnd:hide(false)
	g_MainScene:showWarForce(arg_10_0.levelType, arg_10_0.forceId, EForceEnterWay.Normal)
end
