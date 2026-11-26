zbFormationItem = class("zbFormationItem", CCNodeExtend)
zbFormationItem.__index = zbFormationItem

local var_0_0 = 100
local var_0_1 = 100

function zbFormationItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFormationItem)

	return arg_1_0
end

function zbFormationItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbFormationItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbFormationItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.wndParent = arg_3_2
		arg_3_0.techRecord = nil
		arg_3_0.slots = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteFormation = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(3), "CCControlButton")
		arg_3_0.spriteFont = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.4)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomScaleInner(true)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomChildNode(var_5_0)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(CCSizeMake(var_0_0, var_0_1))
	end

	var_3_0()
	var_3_1()
end

function zbFormationItem.refresh(arg_9_0, arg_9_1)
	arg_9_0.techRecord = arg_9_1

	local var_9_0 = g_Self.kTechHandler:isVisible(arg_9_0.techRecord.TechId)

	arg_9_0:setVisible(var_9_0)

	if var_9_0 == false then
		return
	end

	local var_9_1 = string.format("image/icon/formation/small_formation_%d.png", arg_9_0.techRecord.TechId)
	local var_9_2 = string.format("image/icon/formation/text_%d.png", arg_9_0.techRecord.TechId)

	arg_9_0.spriteFormation:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_1))
	arg_9_0.spriteFont:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_2))
	arg_9_0.lbLevel:setString(arg_9_0.techRecord.Level)
end

function zbFormationItem.onTouch(arg_10_0)
	return
end

function zbFormationItem.onTouchDown(arg_11_0)
	local var_11_0 = zbTechTable:getRecord(arg_11_0.techRecord.TechId)

	g_MainScene:showFormationTip(var_11_0)
	arg_11_0.wndParent.panelFormationSlots:showSlotFormationTip(arg_11_0.techRecord.TechId)
end

function zbFormationItem.onTouchEnd(arg_12_0)
	g_MainScene:hideFormationTip()
	arg_12_0.wndParent.panelFormationSlots:hideSlotFormationTip()
end
