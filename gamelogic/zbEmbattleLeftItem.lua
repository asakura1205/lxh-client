local var_0_0 = 400

zbEmbattleLeftItem = class("zbEmbattleLeftItem", CCNodeExtend)
zbEmbattleLeftItem.__index = zbEmbattleLeftItem

function zbEmbattleLeftItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEmbattleLeftItem)

	return arg_1_0
end

function createEmbattleLeftItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = zbEmbattleLeftItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_4, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function zbEmbattleLeftItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local function var_3_0()
		arg_3_0.slotIndex = arg_3_5
		arg_3_0.heroTemplateId = -1
		arg_3_0.slotIndex = arg_3_5
		arg_3_0.lastDownTouch = ccp(0, 0)
		arg_3_0.lastMoveTouch = ccp(0, 0)
		arg_3_0.animationDraging = false
		arg_3_0.layerGarbages = arg_3_3
		arg_3_0.wndParent = arg_3_4
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
			arg_3_0:onStageTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnStageTouch:addHandleOfControlEvent(function()
			arg_3_0:onStageTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchMove()
		end, CCControlEventTouchMove)
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

function zbEmbattleLeftItem.refresh(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.heroTemplateId = g_Self.kFormation.slots[arg_12_0.slotIndex]

	if zbHeroTable:getRecord(arg_12_0.heroTemplateId) == nil then
		arg_12_0.spriteEmpty:setVisible(true)
		arg_12_0.spriteHeroOn:setVisible(false)

		if arg_12_0.animation then
			arg_12_0.animation:setVisible(false)
			arg_12_0.animation:free()
		end

		arg_12_0.btnHeroTouch:setVisible(false)
		arg_12_0.spriteFormatinTip:setVisible(false)

		return
	end

	arg_12_0:onCreate()

	if arg_12_0.animation:refreshHeroTemplateId(arg_12_0.heroTemplateId) then
		arg_12_0.animation:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	end

	arg_12_0.spriteEmpty:setVisible(false)
	arg_12_0.spriteHeroOn:setVisible(true)
	arg_12_0.spriteFormatinTip:setVisible(false)
	arg_12_0.animation:setVisible(true)
	arg_12_0.btnHeroTouch:setVisible(true)
end

function zbEmbattleLeftItem.refreshSlot(arg_13_0)
	local var_13_0 = g_Self.kFormation.slots[arg_13_0.slotIndex]

	arg_13_0:refresh(g_Self.kFormation, var_13_0)
end

function zbEmbattleLeftItem.onStageTouchDown(arg_14_0)
	arg_14_0:onTouchDown(arg_14_0.btnStageTouch)
end

function zbEmbattleLeftItem.onStageTouchMove(arg_15_0)
	arg_15_0:onTouchMove(arg_15_0.btnStageTouch)
end

function zbEmbattleLeftItem.onStageTouchEnd(arg_16_0)
	arg_16_0:onTouchEnd(arg_16_0.btnStageTouch)
end

function zbEmbattleLeftItem.onHeroTouchDown(arg_17_0)
	arg_17_0:onTouchDown(arg_17_0.btnHeroTouch)
end

function zbEmbattleLeftItem.onHeroTouchMove(arg_18_0)
	arg_18_0:onTouchMove(arg_18_0.btnHeroTouch)
end

function zbEmbattleLeftItem.onHeroTouchEnd(arg_19_0)
	arg_19_0:onTouchEnd(arg_19_0.btnHeroTouch)
end

function zbEmbattleLeftItem.onTouchDown(arg_20_0, arg_20_1)
	if arg_20_0:isEmpty() then
		return
	end

	arg_20_0.animationDraging = false
	arg_20_0.lastDownTouch = arg_20_1:getTouch():getLocation()
end

function zbEmbattleLeftItem.onTouchMove(arg_21_0, arg_21_1)
	if arg_21_0:isEmpty() then
		return
	end

	arg_21_0.lastMoveTouch = arg_21_1:getTouch():getLocation()

	if arg_21_0.animationDraging == false and ccpDistanceSQ(arg_21_0.lastMoveTouch, arg_21_0.lastDownTouch) > var_0_0 then
		local var_21_0 = g_Self.kFormation.slots[arg_21_0.slotIndex]

		arg_21_0.wndParent.editingAnimation:refreshHeroTemplateId(var_21_0)
		arg_21_0.wndParent.editingAnimation:setAnimation(ANIMATION_SEQUENCE_PICKUP, true)
		arg_21_0.wndParent.editingAnimation:setVisible(true)

		arg_21_0.animationDraging = true

		if arg_21_0.animation then
			arg_21_0.animation:setVisible(false)
		end
	end

	if arg_21_0.animationDraging then
		local var_21_1 = arg_21_0.wndParent.layerAnimation:convertToNodeSpace(arg_21_0.lastMoveTouch)

		arg_21_0.wndParent.editingAnimation:setPosition(var_21_1)

		local var_21_2 = arg_21_0.wndParent:getFormationSlots()

		for iter_21_0, iter_21_1 in pairs(var_21_2) do
			iter_21_1.spriteFormatinTip:setVisible(false)

			if zbUtil:PointInCtrl(iter_21_1, arg_21_0.lastMoveTouch.x, arg_21_0.lastMoveTouch.y) and iter_21_1.slotIndex ~= arg_21_0.slotIndex then
				iter_21_1.spriteFormatinTip:setVisible(true)
			end
		end
	end
end

function zbEmbattleLeftItem.onTouchEnd(arg_22_0, arg_22_1)
	if arg_22_0:isEmpty() then
		return
	end

	arg_22_0.wndParent.editingAnimation:setVisible(false)

	arg_22_0.animationDraging = false

	local var_22_0 = false
	local var_22_1 = false
	local var_22_2 = arg_22_1:getTouch():getLocation()
	local var_22_3 = arg_22_0.wndParent:getFormationSlots()

	for iter_22_0, iter_22_1 in pairs(var_22_3) do
		if zbUtil:PointInCtrl(iter_22_1, var_22_2.x, var_22_2.y) then
			if iter_22_1.slotIndex == arg_22_0.slotIndex then
				if arg_22_0.animation then
					arg_22_0.animation:setVisible(true)
				end
			else
				local var_22_4 = g_Self.kFormation.slots[arg_22_0.slotIndex]

				g_Self.kFormation:exchange(arg_22_0.slotIndex, iter_22_1.slotIndex, var_22_4)
				g_Self.kFormation:save()

				var_22_1 = true
			end

			var_22_0 = true

			break
		end
	end

	if var_22_0 == false and arg_22_0.animation then
		arg_22_0.animation:setVisible(true)
	end

	if arg_22_0.animation and arg_22_0.animation:isVisible() == false then
		arg_22_0.animation:free()
	end

	if var_22_1 then
		arg_22_0.wndParent:refreshLeft()
	end
end

function zbEmbattleLeftItem.isEmpty(arg_23_0)
	return g_Self.kFormation.slots[arg_23_0.slotIndex] == 0
end

function zbEmbattleLeftItem.free(arg_24_0)
	if arg_24_0.animation ~= nil then
		arg_24_0.animation:free()
	end
end

function zbEmbattleLeftItem.onCreate(arg_25_0)
	if arg_25_0.animation == nil then
		arg_25_0.animation = createUIPoolAnimation()

		arg_25_0.animation:setPosition(arg_25_0.spriteHeroOn:getContentSize().width * arg_25_0.spriteHeroOn:getScaleX() / 2, arg_25_0.spriteHeroOn:getPositionY() + arg_25_0.spriteHeroOn:getContentSize().height * arg_25_0.spriteHeroOn:getScaleY() / 2)
		arg_25_0.animation:setScale(0.85)
		arg_25_0.animation:setRotationY(HeroRotateY[ForceType.Left])
		arg_25_0.ccNode:addChild(arg_25_0.animation)
	end
end
