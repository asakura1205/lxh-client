require("gamelogic.zbItem")

zbFormationHeroListCard = class("zbFormationHeroListCard", CCNodeExtend)
zbFormationHeroListCard.__index = zbFormationHeroListCard

local var_0_0 = 110
local var_0_1 = 100
local var_0_2 = 400

function zbFormationHeroListCard.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFormationHeroListCard)

	return arg_1_0
end

function zbFormationHeroListCard.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbFormationHeroListCard.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbFormationHeroListCard.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.headItem = nil
		arg_3_0.wndParent = arg_3_3
		arg_3_0.scrollPanel = arg_3_2
		arg_3_0.tableViewHelper = nil
		arg_3_0.hero = nil
		arg_3_0.lastDownTouch = ccp(0, 0)
		arg_3_0.lastMoveTouch = ccp(0, 0)
		arg_3_0.animationDraging = false
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.spriteSelect = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCSprite")

		local var_5_0 = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCLayerColor")
		local var_5_1 = createItem()

		var_5_1:setPosition(var_5_0:getPosition())
		var_5_1:setSwallowsTouches(false)
		var_5_1:setNeedTip(false)
		arg_3_0.layerContent:addChild(var_5_1)

		arg_3_0.headItem = var_5_1

		var_5_0:removeFromParentAndCleanup(true)
		arg_3_0.headItem:setZOrder(ZORDER_BOTTOM)

		arg_3_0.btnTouch = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCControlButton")
		arg_3_0.spriteWorking = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCSprite")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomScaleInner(true)
		arg_3_0.btnTouch:setZoomOnTouchDown(false)
		arg_3_0.btnTouch:setZoomChildNode(arg_3_0.layerContent)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(CCSizeMake(var_0_0, var_0_1))
	end

	var_3_0()
	var_3_1()
end

function zbFormationHeroListCard.refresh(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.hero = arg_10_1
	arg_10_0.tableViewHelper = arg_10_2

	arg_10_0.spriteSelect:setVisible(false)

	if arg_10_1 == nil then
		return
	end

	arg_10_0.headItem:refreshHero(arg_10_1.HeroBaseInfo)
	arg_10_0.spriteWorking:setVisible(arg_10_0:isWorking() or arg_10_0:isPartner())

	if arg_10_0:isWorking() then
		arg_10_0.spriteWorking:setTexture(CCTextureCache:sharedTextureCache():addImage("image/formation/formation_work.png"))
	elseif arg_10_0:isPartner() then
		arg_10_0.spriteWorking:setTexture(CCTextureCache:sharedTextureCache():addImage("image/formation/formation_zhiyuan.png"))
	end
end

function zbFormationHeroListCard.onTouch(arg_11_0)
	if arg_11_0.touchFlag == false then
		local var_11_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_11_0.hero.HeroBaseInfo.TemplateId)

		g_MainScene:showRankTipSingleWnd(var_11_0)
	end
end

function zbFormationHeroListCard.onTouchDown(arg_12_0)
	arg_12_0.animationDraging = false
	arg_12_0.touchFlag = false
	arg_12_0.lastDownTouch = arg_12_0.btnTouch:getTouch():getLocation()
end

function zbFormationHeroListCard.onTouchMove(arg_13_0)
	arg_13_0.lastMoveTouch = arg_13_0.btnTouch:getTouch():getLocation()

	if arg_13_0:isWorking() then
		return
	end

	if arg_13_0.animationDraging == false and zbUtil:PointInCtrl(arg_13_0.scrollPanel, arg_13_0.lastMoveTouch.x, arg_13_0.lastMoveTouch.y) == false and ccpDistanceSQ(arg_13_0.lastMoveTouch, arg_13_0.lastDownTouch) > var_0_2 then
		arg_13_0.wndParent.editingAnimation:refreshHeroTemplateId(arg_13_0.hero.HeroBaseInfo.TemplateId)
		arg_13_0.wndParent.editingAnimation:setAnimation(ANIMATION_SEQUENCE_PICKUP, true)
		arg_13_0.wndParent.editingAnimation:setVisible(true)

		arg_13_0.animationDraging = true

		arg_13_0.tableViewHelper:setCanMove(false)

		arg_13_0.touchFlag = true
	end

	if arg_13_0.animationDraging then
		local var_13_0 = arg_13_0.wndParent.layerAnimation:convertToNodeSpace(arg_13_0.lastMoveTouch)

		arg_13_0.wndParent.editingAnimation:setPosition(var_13_0)
		arg_13_0.wndParent.editingAnimation:setVisible(true)

		local var_13_1 = arg_13_0.wndParent:getFormationSlots()

		for iter_13_0, iter_13_1 in pairs(var_13_1) do
			iter_13_1.spriteFormatinTip:setVisible(false)

			if zbUtil:PointInCtrl(iter_13_1, arg_13_0.lastMoveTouch.x, arg_13_0.lastMoveTouch.y) and iter_13_1:isLock() == false and iter_13_1.slotIndex ~= arg_13_0.slotIndex then
				iter_13_1.spriteFormatinTip:setVisible(true)

				arg_13_0.spriteFormatinTip = iter_13_1.spriteFormatinTip
			end
		end
	end
end

function zbFormationHeroListCard.onTouchEnd(arg_14_0)
	arg_14_0.wndParent.editingAnimation:setVisible(false)

	arg_14_0.animationDraging = false

	arg_14_0.tableViewHelper:setCanMove(true)
	arg_14_0.spriteSelect:setVisible(false)

	local var_14_0 = false

	if arg_14_0:isWorking() == false then
		local var_14_1 = arg_14_0.btnTouch:getTouch():getLocation()
		local var_14_2 = arg_14_0.wndParent:getFormationSlots()

		for iter_14_0, iter_14_1 in pairs(var_14_2) do
			if zbUtil:PointInCtrl(iter_14_1, var_14_1.x, var_14_1.y) and iter_14_1:isLock() == false then
				if g_Self.kFormation.slots[iter_14_1.slotIndex] == 0 then
					local var_14_3 = g_Self.kFormation:getWorkingHeroCount()
					local var_14_4 = g_Self:getLevel()

					if var_14_3 >= 5 and iter_14_1.isPartSlot == false then
						g_Bubble:bubbleInfo("\xBF\xC9\xC9\xCF\xD5\xF3ս\xB6\xB7\xBB\xEF\xB0\xE9\xD2\xD1\xC2\xFA")

						if arg_14_0.spriteFormatinTip then
							arg_14_0.spriteFormatinTip:setVisible(false)
						end

						return
					end
				end

				g_Self.kFormation:replace(iter_14_1.slotIndex, arg_14_0.hero.HeroBaseInfo.TemplateId)
				g_Self.kFormation:save()

				var_14_0 = true

				break
			end
		end
	end

	if var_14_0 then
		g_MainScene.wndFormation:onFormationChanged()
	end
end

function zbFormationHeroListCard.isWorking(arg_15_0)
	if arg_15_0.hero == nil then
		return false
	end

	return g_Self.kFormation:isWorking(arg_15_0.hero.HeroBaseInfo.TemplateId)
end

function zbFormationHeroListCard.isPartner(arg_16_0)
	if arg_16_0.hero == nil then
		return false
	end

	return g_Self.kFormation:isPartner(arg_16_0.hero.HeroBaseInfo.TemplateId)
end
