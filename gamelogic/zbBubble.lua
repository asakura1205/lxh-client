require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbBubble", zbBaseWnd)

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

function createBubbleInfo()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.layerInfo = nil
		arg_3_0.spriteBg = nil
		arg_3_0.spriteIcon = nil
		arg_3_0.lbContent = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/bubble.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layerInfo = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layerInfo:getChildByTag(1), "CCSprite")
		arg_3_0.lbContent = tolua.cast(arg_3_0.layerInfo:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeNotice = {}
		arg_3_0.layerNotice = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.nodeNotice[1] = tolua.cast(arg_3_0.layerNotice:getChildByTag(1), "CCSprite")
		arg_3_0.nodeNotice[2] = tolua.cast(arg_3_0.layerNotice:getChildByTag(2), "CCSprite")
		arg_3_0.spriteNoticeBg = {}
		arg_3_0.spriteNoticeBg[1] = tolua.cast(arg_3_0.nodeNotice[1]:getChildByTag(1), "CCSprite")
		arg_3_0.spriteNoticeBg[2] = tolua.cast(arg_3_0.nodeNotice[2]:getChildByTag(1), "CCSprite")
		arg_3_0.lbNotice = {}
		arg_3_0.lbNotice[1] = tolua.cast(arg_3_0.nodeNotice[1]:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbNotice[2] = tolua.cast(arg_3_0.nodeNotice[2]:getChildByTag(2), "CCLabelTTF")

		arg_3_0.layerInfo:setCascadeOpacityEnabled(true)
		arg_3_0.layerInfo:setVisible(false)
		arg_3_0.layerNotice:setCascadeOpacityEnabled(true)
		arg_3_0.layerNotice:setVisible(false)
		arg_3_0.nodeNotice[1]:setVisible(false)
		arg_3_0.nodeNotice[2]:setVisible(false)
		arg_3_0:addChild(var_5_1)
		arg_3_0:retain()
	end

	var_3_0()
	var_3_1()
	arg_3_0:setZOrder(ZORDER_TOP)
end

function var_0_0.bubbleInfo(arg_6_0, arg_6_1)
	arg_6_0:bubbleMsg(arg_6_1)
end

function var_0_0.bubbleMsg(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = a2u(arg_7_1)

	arg_7_0.lbContent:setString(arg_7_1)

	local var_7_0 = 80
	local var_7_1 = var_7_0 + arg_7_0.lbContent:getContentSize().width + var_7_0

	arg_7_0.spriteBg:setContentSize(CCSizeMake(var_7_1, arg_7_0.spriteBg:getContentSize().height))
	arg_7_0.spriteBg:setPositionX(-var_7_1 / 2)
	arg_7_0.lbContent:setPositionX(arg_7_0.spriteBg:getPositionX() + var_7_0)

	local function var_7_2()
		arg_7_0.layerInfo:setVisible(false)
	end

	local var_7_3 = CCFadeIn:create(0.2)
	local var_7_4 = CCDelayTime:create(1.5)
	local var_7_5 = CCFadeOut:create(0.3)
	local var_7_6 = CCCallFuncN:create(var_7_2)
	local var_7_7 = CCArray:create()

	var_7_7:addObject(var_7_3)
	var_7_7:addObject(var_7_4)
	var_7_7:addObject(var_7_5)
	var_7_7:addObject(var_7_6)

	local var_7_8 = CCSequence:create(var_7_7)

	arg_7_0.layerInfo:setVisible(true)
	arg_7_0.layerInfo:stopAllActions()
	arg_7_0.layerInfo:runAction(var_7_8)
	arg_7_0:removeFromParentAndCleanup(false)
	CCDirector:sharedDirector():getRunningScene():addChild(arg_7_0)
end
