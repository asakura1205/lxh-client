local var_0_0 = class("zbEquipDetail_CuilianSlot", CCNodeExtend)

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

function createEquipCuilianSlot(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.touchDown = false
		arg_3_0.showTipsWnd = false
		arg_3_0.lastTouchTime = 0
		arg_3_0.data = nil
	end

	local function var_3_1()
		translateAndStrokeHelper(arg_3_1)

		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbl_level = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		arg_3_0.lbl_level:setVisible(false)

		arg_3_0.lbl_num = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0.data = arg_10_1

	if arg_10_1.equip ~= nil then
		arg_10_0.lbl_level:setVisible(not arg_10_1.isFrag and arg_10_1.equip.Level > 0)
		arg_10_0.lbl_num:setString(arg_10_1.count)

		local var_10_0 = zbItemTable:getRecord(arg_10_1.equip.TemplateId)

		if var_10_0 ~= nil then
			local var_10_1 = zbColor:getEquipFrameTex(var_10_0.quality)

			if arg_10_1.isFrag then
				var_10_1 = zbColor:getEquipFragFrameTex(var_10_0.quality)
			end

			ui:setButtonPic(arg_10_0.btnFrame, var_10_1, var_10_1, var_10_1)

			local var_10_2 = zbIconHelper:getItemIconPath(arg_10_1.equip.TemplateId)

			arg_10_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_2))
		end

		if not arg_10_1.isFrag and arg_10_1.equip.Level > 0 then
			arg_10_0.lbl_level:setString(arg_10_1.equip.Level)
		end
	end
end

function var_0_0.onTouch(arg_11_0)
	if arg_11_0.showTipsWnd == false and g_MainScene.wndEquipDetail then
		g_MainScene.wndEquipDetail.module[EEquipForgeTab.Cuilian]:removeItem(arg_11_0.data, arg_11_0.index)
	end
end

function var_0_0.onTouchDown(arg_12_0)
	if os_timenow() - arg_12_0.lastTouchTime < 0.5 then
		-- block empty
	else
		arg_12_0.lastTouchTime = os_timenow()
	end

	arg_12_0.touchDown = true
	arg_12_0.showTipsWnd = false
	arg_12_0.lastDownTouch = arg_12_0.btnFrame:getTouch():getLocation()

	local var_12_0 = CCArray:create()

	var_12_0:addObject(CCDelayTime:create(0.3))
	var_12_0:addObject(CCCallFuncN:create(function()
		arg_12_0:onShowTips()
	end))

	local var_12_1 = CCSequence:create(var_12_0)

	arg_12_0:stopAllActions()
	arg_12_0:runAction(var_12_1)
end

function var_0_0.onShowTips(arg_14_0)
	return
end

function var_0_0.onTouchMove(arg_15_0)
	arg_15_0.lastMoveTouch = arg_15_0.btnFrame:getTouch():getLocation()
end

function var_0_0.onTouchEnd(arg_16_0)
	arg_16_0.lastTouchTime = os_timenow()
	arg_16_0.touchDown = false

	arg_16_0:stopAllActions()

	if g_MainScene.wndCommomTip ~= nil then
		g_MainScene.wndCommomTip:hideTips()
	end
end
