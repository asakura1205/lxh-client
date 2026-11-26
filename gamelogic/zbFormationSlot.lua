require("gamecore.zbUIAnimation")

zbFormationSlot = class("zbFormationSlot", CCNodeExtend)
zbFormationSlot.__index = zbFormationSlot

local var_0_0 = 400

function zbFormationSlot.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFormationSlot)

	return arg_1_0
end

function zbFormationSlot.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = zbFormationSlot.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function zbFormationSlot.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local function var_3_0()
		arg_3_0.wndParent = arg_3_4
		arg_3_0.slotIndex = arg_3_2
		arg_3_0.lastDownTouch = ccp(0, 0)
		arg_3_0.lastMoveTouch = ccp(0, 0)
		arg_3_0.animationDraging = false
		arg_3_0.layerGarbages = arg_3_3
		arg_3_0.isPartSlot = arg_3_2 > 9
	end

	local function var_3_1()
		arg_3_0.spriteEmpty = tolua.cast(arg_3_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteHeroOn = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")
		arg_3_0.spriteFormatinTip = tolua.cast(arg_3_1:getChildByTag(3), "CCSprite")
		arg_3_0.spritePartLock = tolua.cast(arg_3_1:getChildByTag(4), "CCSprite")
		arg_3_0.lbPartLockTip = tolua.cast(arg_3_1:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnStageTouch = tolua.cast(arg_3_1:getChildByTag(6), "CCControlButton")
		arg_3_0.btnHeroTouch = tolua.cast(arg_3_1:getChildByTag(7), "CCControlButton")
		arg_3_0.spritePartTip = tolua.cast(arg_3_1:getChildByTag(8), "CCSprite")

		arg_3_0.spriteFormatinTip:setVisible(false)
		arg_3_0.btnStageTouch:addHandleOfControlEvent(function()
			arg_3_0:onStageTouch()
		end, CCControlEventTouchUpInside)
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
			arg_3_0:onHeroTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnHeroTouch:addHandleOfControlEvent(function()
			arg_3_0:onHeroTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.animation = createUIPoolAnimation()

		arg_3_0.animation:setPosition(arg_3_0.spriteHeroOn:getContentSize().width * arg_3_0.spriteHeroOn:getScaleX() / 2 + 13, arg_3_0.spriteHeroOn:getPositionY() + arg_3_0.spriteHeroOn:getContentSize().height * arg_3_0.spriteHeroOn:getScaleY() / 2 + 7)
		arg_3_0.animation:setScale(1)
		arg_3_0.animation:setRotationY(180)
		arg_3_1:addChild(arg_3_0.animation)
		arg_3_0:setPosition(0, 0)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setContentSize(arg_3_1:getContentSize())
		arg_3_0:addChild(arg_3_1)

		if arg_3_0.isPartSlot then
			arg_3_0.spriteHeroOn:setTexture(CCTextureCache:sharedTextureCache():addImage("image/formation/formation_part.png"))
			arg_3_0.spritePartTip:setTexture(CCTextureCache:sharedTextureCache():addImage("image/formation/formation_supp_" .. arg_3_2 - 9 .. ".png"))
		end
	end

	var_3_0()
	var_3_1()
end

function zbFormationSlot.free(arg_14_0)
	if arg_14_0.animation ~= nil then
		arg_14_0.animation:free()
	end
end

function zbFormationSlot.clear(arg_15_0)
	arg_15_0.spriteEmpty:setVisible(true)
	arg_15_0.spriteHeroOn:setVisible(false)
	arg_15_0.spriteFormatinTip:setVisible(false)
	arg_15_0.animation:setVisible(false)
	arg_15_0.btnHeroTouch:setVisible(false)

	if arg_15_0.animation:isVisible() == false then
		arg_15_0.animation:free()
	end
end

function zbFormationSlot.refresh(arg_16_0)
	arg_16_0.spritePartLock:setVisible(arg_16_0:isLock())
	arg_16_0.lbPartLockTip:setVisible(arg_16_0:isLock())
	arg_16_0.lbPartLockTip:setString(a2u("(\xCD\xE6\xBC\xD2" .. g_Self.kTechHandler:getParterTechOpenLevel(arg_16_0.slotIndex - 9) .. "\xBC\xB6)"))
	arg_16_0.spritePartTip:setVisible(arg_16_0.isPartSlot and g_Self.kTechHandler:parterEnableByPos(arg_16_0.slotIndex - 9) == true)

	local var_16_0 = g_Self.kFormation.slots[arg_16_0.slotIndex]

	if var_16_0 == nil then
		return
	end

	if zbHeroTable:getRecord(var_16_0) == nil then
		arg_16_0.spriteEmpty:setVisible(true)
		arg_16_0.spriteHeroOn:setVisible(false)
		arg_16_0.spriteFormatinTip:setVisible(false)
		arg_16_0.btnHeroTouch:setVisible(false)
		arg_16_0.animation:setVisible(false)
		arg_16_0.animation:free()

		return
	end

	arg_16_0.animation:free()

	if arg_16_0.animation:refreshHeroTemplateId(var_16_0) then
		arg_16_0.animation:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	end

	arg_16_0.spriteEmpty:setVisible(false)
	arg_16_0.spriteHeroOn:setVisible(true)
	arg_16_0.spriteFormatinTip:setVisible(false)
	arg_16_0.animation:setVisible(true)
	arg_16_0.btnHeroTouch:setVisible(true)
end

function zbFormationSlot.isLock(arg_17_0)
	return arg_17_0.isPartSlot and g_Self.kTechHandler:parterEnableByPos(arg_17_0.slotIndex - 9) == false
end

function zbFormationSlot.showSlotFormationTip(arg_18_0, arg_18_1)
	if arg_18_0.isPartSlot then
		return
	end

	local var_18_0 = FormationSlots[arg_18_1]

	if var_18_0 == nil then
		return
	end

	if var_18_0[arg_18_0.slotIndex] ~= 0 then
		arg_18_0.spriteEmpty:setVisible(false)
		arg_18_0.spriteHeroOn:setVisible(false)
		arg_18_0.spriteFormatinTip:setVisible(true)
	else
		arg_18_0.spriteEmpty:setVisible(true)
		arg_18_0.spriteHeroOn:setVisible(false)
		arg_18_0.spriteFormatinTip:setVisible(false)
	end
end

function zbFormationSlot.hideSlotFormationTip(arg_19_0)
	arg_19_0:refresh()
end

function zbFormationSlot.onStageTouch(arg_20_0)
	arg_20_0:onTouch(arg_20_0.btnStageTouch)
end

function zbFormationSlot.onStageTouchDown(arg_21_0)
	arg_21_0:onTouchDown(arg_21_0.btnStageTouch)
end

function zbFormationSlot.onStageTouchMove(arg_22_0)
	arg_22_0:onTouchMove(arg_22_0.btnStageTouch)
end

function zbFormationSlot.onStageTouchEnd(arg_23_0)
	arg_23_0:onTouchEnd(arg_23_0.btnStageTouch)
end

function zbFormationSlot.onHeroTouch(arg_24_0)
	arg_24_0:onTouch(arg_24_0.btnHeroTouch)
end

function zbFormationSlot.onHeroTouchDown(arg_25_0)
	arg_25_0:onTouchDown(arg_25_0.btnHeroTouch)
end

function zbFormationSlot.onHeroTouchMove(arg_26_0)
	arg_26_0:onTouchMove(arg_26_0.btnHeroTouch)
end

function zbFormationSlot.onHeroTouchEnd(arg_27_0)
	arg_27_0:onTouchEnd(arg_27_0.btnHeroTouch)
end

function zbFormationSlot.onTouch(arg_28_0)
	if arg_28_0:isEmpty() then
		return
	end

	if arg_28_0.touchFlag == false then
		local var_28_0 = g_Self.kFormation.slots[arg_28_0.slotIndex]
		local var_28_1 = g_Self.kHeroHandler:getHeroByTemplateId(var_28_0)

		g_MainScene:showRankTipSingleWnd(var_28_1)
	end
end

function zbFormationSlot.onTouchDown(arg_29_0, arg_29_1)
	if arg_29_0:isLock() then
		local var_29_0 = g_Self.kTechHandler:getParterTechOpenLevel(arg_29_0.slotIndex - 9)

		if arg_29_0.slotIndex - 9 == 1 then
			g_Bubble:bubbleInfo(string.format("\xCD\xE6\xBC\xD2%d\xBC\xB6\xBF\xAA\xC6\xF4\xA1\xBE\xBE\xFD\xB8\xF3Ԯ\xBE\xFC\xBFƼ\xBC\xA1\xBFԮ\xBE\xFC\xB9\xA5\xBB\xF7λ", var_29_0))
		elseif arg_29_0.slotIndex - 9 == 2 then
			g_Bubble:bubbleInfo(string.format("\xCD\xE6\xBC\xD2%d\xBC\xB6\xBF\xAA\xC6\xF4\xA1\xBE\xBE\xFD\xB8\xF3Ԯ\xBE\xFC\xBFƼ\xBC\xA1\xBFԮ\xBE\xFC\xB7\xC0\xD3\xF9λ", var_29_0))
		elseif arg_29_0.slotIndex - 9 == 3 then
			g_Bubble:bubbleInfo(string.format("\xCD\xE6\xBC\xD2%d\xBC\xB6\xBF\xAA\xC6\xF4\xA1\xBE\xBE\xFD\xB8\xF3Ԯ\xBE\xFC\xBFƼ\xBC\xA1\xBFԮ\xBE\xFC\xC9\xFA\xB4\xE6λ", var_29_0))
		end

		return
	end

	arg_29_0.animationDraging = false
	arg_29_0.touchFlag = false
	arg_29_0.lastDownTouch = arg_29_1:getTouch():getLocation()
end

function zbFormationSlot.onTouchMove(arg_30_0, arg_30_1)
	if arg_30_0:isEmpty() then
		return
	end

	arg_30_0.lastMoveTouch = arg_30_1:getTouch():getLocation()

	if arg_30_0.animationDraging == false and ccpDistanceSQ(arg_30_0.lastMoveTouch, arg_30_0.lastDownTouch) > var_0_0 then
		local var_30_0 = g_Self.kFormation.slots[arg_30_0.slotIndex]

		arg_30_0.wndParent.editingAnimation:refreshHeroTemplateId(var_30_0)
		arg_30_0.wndParent.editingAnimation:setAnimation(ANIMATION_SEQUENCE_PICKUP, true)
		arg_30_0.wndParent.editingAnimation:setVisible(true)

		arg_30_0.animationDraging = true

		arg_30_0.animation:setVisible(false)

		arg_30_0.touchFlag = true
	end

	if arg_30_0.animationDraging then
		local var_30_1 = arg_30_0.wndParent.layerAnimation:convertToNodeSpace(arg_30_0.lastMoveTouch)

		arg_30_0.wndParent.editingAnimation:setPosition(var_30_1)
		arg_30_0.wndParent.editingAnimation:setVisible(true)

		local var_30_2 = arg_30_0.wndParent:getFormationSlots()

		for iter_30_0, iter_30_1 in pairs(var_30_2) do
			iter_30_1.spriteFormatinTip:setVisible(false)

			if zbUtil:PointInCtrl(iter_30_1, arg_30_0.lastMoveTouch.x, arg_30_0.lastMoveTouch.y) and iter_30_1.slotIndex ~= arg_30_0.slotIndex and iter_30_1:isLock() == false then
				iter_30_1.spriteFormatinTip:setVisible(true)
			end
		end
	end
end

function zbFormationSlot.onTouchEnd(arg_31_0, arg_31_1)
	if arg_31_0:isEmpty() then
		return
	end

	arg_31_0.wndParent.editingAnimation:setVisible(false)

	arg_31_0.animationDraging = false

	local var_31_0 = false
	local var_31_1 = false
	local var_31_2 = arg_31_1:getTouch():getLocation()
	local var_31_3 = arg_31_0.wndParent:getFormationSlots()

	for iter_31_0, iter_31_1 in pairs(var_31_3) do
		iter_31_1.spriteFormatinTip:setVisible(false)

		if zbUtil:PointInCtrl(iter_31_1, var_31_2.x, var_31_2.y) and iter_31_1:isLock() == false then
			if iter_31_1.slotIndex == arg_31_0.slotIndex then
				arg_31_0.animation:setVisible(true)
			else
				if arg_31_0.isPartSlot == true and iter_31_1.slotIndex <= 9 and g_Self.kFormation.slots[iter_31_1.slotIndex] == 0 and g_Self.kFormation:getWorkingHeroCount() >= 5 then
					g_Bubble:bubbleInfo("\xBF\xC9\xC9\xCF\xD5\xF3ս\xB6\xB7\xBB\xEF\xB0\xE9\xD2\xD1\xC2\xFA")

					break
				end

				if arg_31_0.isPartSlot == false and iter_31_1.slotIndex > 9 and g_Self.kFormation:getWorkingHeroCount() <= 1 then
					g_Bubble:bubbleInfo("\xD6\xC1\xC9\xD9Ҫ\xC9\xCF\xD5\xF3һλ\xBB\xEF\xB0\xE9")

					break
				end

				local var_31_4 = g_Self.kFormation.slots[arg_31_0.slotIndex]

				g_Self.kFormation:exchange(arg_31_0.slotIndex, iter_31_1.slotIndex, var_31_4)
				g_Self.kFormation:save()

				var_31_1 = true
			end

			var_31_0 = true

			break
		end
	end

	if var_31_0 == false then
		arg_31_0.animation:setVisible(true)
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.layerGarbages) do
		if zbUtil:PointInCtrl(iter_31_3, var_31_2.x, var_31_2.y) then
			if arg_31_0.isPartSlot == false and g_Self.kFormation:getWorkingHeroCount() <= 1 then
				g_Bubble:bubbleInfo("\xD6\xC1\xC9\xD9Ҫ\xC9\xCF\xD5\xF3һλ\xBB\xEF\xB0\xE9")

				return
			end

			g_Self.kFormation:remove(arg_31_0.slotIndex)
			g_Self.kFormation:save()
			arg_31_0.animation:setVisible(false)

			var_31_1 = true

			break
		end
	end

	if arg_31_0.animation:isVisible() == false then
		arg_31_0.animation:free()
	end

	if var_31_1 then
		g_MainScene.wndFormation:onFormationChanged()
	end
end

function zbFormationSlot.isEmpty(arg_32_0)
	return g_Self.kFormation.slots[arg_32_0.slotIndex] == 0
end
