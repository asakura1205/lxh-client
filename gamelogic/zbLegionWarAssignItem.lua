zbLegionWarAssignItem = class("zbLegionWarAssignItem", CCNodeExtend)
zbLegionWarAssignItem.__index = zbLegionWarAssignItem

local var_0_0 = 400

function zbLegionWarAssignItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionWarAssignItem)

	return arg_1_0
end

function createLegionWarAssignItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbLegionWarAssignItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function zbLegionWarAssignItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.wndParent = arg_3_3
		arg_3_0.myIndex = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteAdd = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.btnAddHead = tolua.cast(var_5_0:getChildByTag(2), "CCControlButton")
		arg_3_0.lbHeadName = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		arg_3_0.btnAddHead:addHandleOfControlEvent(function()
			arg_3_0:onAddHero()
		end, CCControlEventTouchUpInside)

		if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) == ELegionOffice.Leader then
			arg_3_0.btnAddHead:addHandleOfControlEvent(function()
				arg_3_0:onAddHeroDown()
			end, CCControlEventTouchDown)
			arg_3_0.btnAddHead:addHandleOfControlEvent(function()
				arg_3_0:onAddHeroMove()
			end, CCControlEventTouchMove)
			arg_3_0.btnAddHead:addHandleOfControlEvent(function()
				arg_3_0:onAddHeroEnd()
			end, CCControlEventTouchEnd)
		end

		arg_3_0:setPosition(0, 0)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setContentSize(arg_3_1:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbLegionWarAssignItem.refresh(arg_10_0, arg_10_1)
	arg_10_0.baseData = arg_10_1

	if arg_10_0.baseData == nil then
		arg_10_0.spriteHead:setVisible(false)
		arg_10_0.lbHeadName:setVisible(false)

		return
	end

	arg_10_0.lbHeadName:setVisible(true)
	arg_10_0.spriteHead:setVisible(true)

	local var_10_0 = zbIconHelper:getPlayerHeadIconPath(arg_10_1.PlayerBaseInfo.HeadId)

	arg_10_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_0))
	arg_10_0.lbHeadName:setString(arg_10_1.PlayerBaseInfo.RoleName)
end

function zbLegionWarAssignItem.onAddHero(arg_11_0)
	if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) ~= ELegionOffice.Leader then
		g_Bubble:bubbleInfo(a2u("\xB7ǻ\xE1\xB9ݳ\xA4\xBD\xF6\xBFɲ鿴"))

		return
	end

	if arg_11_0.baseData == nil then
		g_MainScene:showLegionWarHeroWnd(ELgionWarHero.E_NodeAdd, arg_11_0.myIndex):setPrevWnd(arg_11_0.wndParent)

		return
	end

	if arg_11_0.touchFlag == false then
		arg_11_0.wndParent.heroList[arg_11_0.myIndex] = 0

		arg_11_0.wndParent:freshHeroList()
	end
end

function zbLegionWarAssignItem.onAddHeroDown(arg_12_0)
	arg_12_0.animationDraging = false
	arg_12_0.touchFlag = false
	arg_12_0.lastDownTouch = arg_12_0.btnAddHead:getTouch():getLocation()
end

function zbLegionWarAssignItem.onAddHeroMove(arg_13_0)
	if arg_13_0.baseData == nil then
		return
	end

	arg_13_0.lastMoveTouch = arg_13_0.btnAddHead:getTouch():getLocation()

	if arg_13_0.animationDraging == false and ccpDistanceSQ(arg_13_0.lastMoveTouch, arg_13_0.lastDownTouch) > var_0_0 then
		local var_13_0 = zbIconHelper:getPlayerHeadIconPath(arg_13_0.baseData.PlayerBaseInfo.HeadId)

		arg_13_0.wndParent.moveHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_0))
		arg_13_0.wndParent.moveHead:setVisible(true)

		arg_13_0.animationDraging = true

		arg_13_0.spriteHead:setVisible(false)

		arg_13_0.touchFlag = true
	end

	if arg_13_0.animationDraging then
		local var_13_1 = arg_13_0.wndParent.layer:convertToNodeSpace(arg_13_0.lastMoveTouch)

		arg_13_0.wndParent.moveHead:setPosition(var_13_1)
		arg_13_0.wndParent.moveHead:setVisible(true)

		local var_13_2 = arg_13_0.wndParent.heroItems

		for iter_13_0, iter_13_1 in pairs(var_13_2) do
			iter_13_1.spriteAdd:setScale(1)

			if zbUtil:PointInCtrl(iter_13_1.spriteHead, arg_13_0.lastMoveTouch.x, arg_13_0.lastMoveTouch.y) and iter_13_1.myIndex ~= arg_13_0.myIndex then
				iter_13_1.spriteAdd:setScale(1.1)
			end
		end
	end
end

function zbLegionWarAssignItem.onAddHeroEnd(arg_14_0)
	if arg_14_0.baseData == nil then
		return
	end

	arg_14_0.wndParent.moveHead:setVisible(false)

	local var_14_0 = arg_14_0.btnAddHead:getTouch():getLocation()
	local var_14_1 = arg_14_0.wndParent.heroItems

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		iter_14_1.spriteAdd:setScale(1)

		if zbUtil:PointInCtrl(iter_14_1.spriteHead, var_14_0.x, var_14_0.y) then
			if iter_14_1.myIndex == arg_14_0.myIndex then
				arg_14_0.spriteHead:setVisible(true)

				break
			end

			if iter_14_1.baseData == nil then
				arg_14_0.wndParent.heroList[iter_14_1.myIndex] = arg_14_0.baseData.PlayerBaseInfo.PlayerId
				arg_14_0.wndParent.heroList[arg_14_0.myIndex] = 0

				break
			end

			local var_14_2 = iter_14_1.baseData.PlayerBaseInfo.PlayerId

			arg_14_0.wndParent.heroList[iter_14_1.myIndex] = arg_14_0.baseData.PlayerBaseInfo.PlayerId
			arg_14_0.wndParent.heroList[arg_14_0.myIndex] = var_14_2

			break
		end
	end

	arg_14_0.wndParent:freshHeroList()
end
