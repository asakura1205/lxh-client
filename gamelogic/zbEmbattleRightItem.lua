zbEmbattleRightItem = class("zbEmbattleRightItem", CCNodeExtend)
zbEmbattleRightItem.__index = zbEmbattleRightItem

function zbEmbattleRightItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEmbattleRightItem)

	return arg_1_0
end

function createEmbattleRightItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbEmbattleRightItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function zbEmbattleRightItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.heroTemplateId = -1
		arg_3_0.slotIndex = arg_3_2
		arg_3_0.wndParent = arg_3_3
	end

	local function var_3_1()
		arg_3_0.layerSize = tolua.cast(arg_3_1:getChildByTag(0), "CCLayerColor")
		arg_3_0.spriteEmpty = tolua.cast(arg_3_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteHeroOn = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")
		arg_3_0.spriteFormatinTip = tolua.cast(arg_3_1:getChildByTag(3), "CCSprite")
		arg_3_0.btnStageTouch = tolua.cast(arg_3_1:getChildByTag(4), "CCControlButton")
		arg_3_0.btnHeroTouch = tolua.cast(arg_3_1:getChildByTag(5), "CCControlButton")

		arg_3_0.btnStageTouch:addHandleOfControlEvent(function()
			arg_3_0:onStageTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnStageTouch:addHandleOfControlEvent(function()
			arg_3_0:onStageTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.ccNode = arg_3_1

		arg_3_0:setPosition(0, 0)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setContentSize(arg_3_0.layerSize:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbEmbattleRightItem.refresh(arg_10_0, arg_10_1)
	arg_10_0.heroTemplateId = arg_10_1

	if zbHeroTable:getRecord(arg_10_1) == nil then
		arg_10_0.spriteEmpty:setVisible(true)
		arg_10_0.spriteHeroOn:setVisible(false)

		if arg_10_0.animation then
			arg_10_0.animation:setVisible(false)
		end

		arg_10_0.btnHeroTouch:setVisible(false)
		arg_10_0.spriteFormatinTip:setVisible(false)

		return
	end

	arg_10_0:onCreate()
	arg_10_0.animation:refreshHeroTemplateId(arg_10_1)
	arg_10_0.animation:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	arg_10_0.spriteEmpty:setVisible(false)
	arg_10_0.spriteHeroOn:setVisible(true)
	arg_10_0.animation:setVisible(true)
	arg_10_0.btnHeroTouch:setVisible(true)
	arg_10_0.spriteFormatinTip:setVisible(false)
end

function zbEmbattleRightItem.refreshSlot(arg_11_0)
	return
end

function zbEmbattleRightItem.onStageTouchDown(arg_12_0)
	arg_12_0:onTouchDown(arg_12_0.btnStageTouch)
end

function zbEmbattleRightItem.onStageTouchEnd(arg_13_0)
	arg_13_0:onTouchEnd(arg_13_0.btnStageTouch)
end

function zbEmbattleRightItem.onHeroTouchDown(arg_14_0)
	arg_14_0:onTouchDown(arg_14_0.btnHeroTouch)
end

function zbEmbattleRightItem.onHeroTouchEnd(arg_15_0)
	arg_15_0:onTouchEnd(arg_15_0.btnHeroTouch)
end

function zbEmbattleRightItem.onTouchDown(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getTouch():getLocation()
	local var_16_1 = arg_16_0.wndParent.layerAnimation:convertToNodeSpace(var_16_0)
end

function zbEmbattleRightItem.onTouchEnd(arg_17_0, arg_17_1)
	return
end

function zbEmbattleRightItem.free(arg_18_0)
	if arg_18_0.animation ~= nil then
		arg_18_0.animation:free()
	end
end

function zbEmbattleRightItem.onCreate(arg_19_0)
	if arg_19_0.animation == nil then
		arg_19_0.animation = createUIPoolAnimation()

		arg_19_0.animation:setPosition(arg_19_0.spriteHeroOn:getContentSize().width * arg_19_0.spriteHeroOn:getScaleX() / 2, arg_19_0.spriteHeroOn:getPositionY() + arg_19_0.spriteHeroOn:getContentSize().height * arg_19_0.spriteHeroOn:getScaleY() / 2)
		arg_19_0.animation:setScale(0.85)
		arg_19_0.animation:setRotationY(HeroRotateY[ForceType.Right])
		arg_19_0.ccNode:addChild(arg_19_0.animation)
	end
end
