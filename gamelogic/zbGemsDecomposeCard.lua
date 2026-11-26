local var_0_0 = class("zbGemsDecomposeCard")

var_0_0.__index = var_0_0

local var_0_1 = 5

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createGemsDecomposeCard(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.selectCallback = nil
	arg_3_0.root = arg_3_1

	local var_3_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

	arg_3_0.btnTouch = tolua.cast(var_3_0:getChildByTag(0), "CCControlButton")
	arg_3_0.headRoot = tolua.cast(var_3_0:getChildByTag(1), "CCLayerColor")
	arg_3_0.spriteFrame = tolua.cast(arg_3_0.headRoot:getChildByTag(1), "CCSprite")
	arg_3_0.spriteHead = tolua.cast(arg_3_0.headRoot:getChildByTag(2), "CCSprite")
	arg_3_0.num = tolua.cast(arg_3_0.headRoot:getChildByTag(4), "CCLabelTTF")
	arg_3_0.nameRoot = tolua.cast(arg_3_0.headRoot:getChildByTag(5), "CCSprite")
	arg_3_0.lbName = tolua.cast(arg_3_0.headRoot:getChildByTag(6), "CCLabelTTF")

	arg_3_0.btnTouch:addHandleOfControlEvent(function()
		arg_3_0:btnTouchCallback()
	end, CCControlEventTouchUpInside)
	arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
	arg_3_0.btnTouch:setSwallowsTouches(false)
	arg_3_0.btnTouch:setZoomScaleInner(false)
	arg_3_0.btnTouch:setZoomOnTouchDown(false)
	arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
	arg_3_0:setContentSize(var_3_0:getContentSize())
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setPosition(0, 0)
	arg_3_0:addChild(arg_3_1)
end

function var_0_0.refresh(arg_5_0, arg_5_1)
	arg_5_0:setVisible(arg_5_1 ~= nil)

	if arg_5_1 == nil then
		return
	end

	arg_5_0.equip = arg_5_1
	arg_5_0.selectCallback = nil

	local var_5_0 = zbItemTable:getRecord(arg_5_1.TemplateId)

	if var_5_0 == nil then
		return
	end

	local var_5_1 = zbColor:getEquipFrameTex(var_5_0.quality)

	arg_5_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_1))

	local var_5_2 = zbIconHelper:getItemIconPath(arg_5_1.TemplateId)

	arg_5_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_2))
	arg_5_0.lbName:setString(var_5_0.name)

	local var_5_3 = g_MainScene.wndGemsDecomposeSelect:getSelGemsCount(arg_5_0.equip)

	arg_5_0.num:setString(arg_5_1.Count - var_5_3)
	arg_5_0:setGrayAndEnabled(false)

	local var_5_4 = arg_5_0:bCanSelsubClass()

	if var_5_4 ~= -1 and zbItemTable:getRecord(arg_5_1.TemplateId).subType ~= var_5_4 then
		arg_5_0:setGrayAndEnabled(true)
	end
end

function var_0_0.setGrayAndEnabled(arg_6_0, arg_6_1)
	arg_6_0.headRoot:setGray(arg_6_1)
	arg_6_0.headRoot:setGray(arg_6_1)
	arg_6_0.btnTouch:setEnabled(not arg_6_1)
end

function var_0_0.btnTouchCallback(arg_7_0)
	g_MainScene.wndGemsDecomposeSelect:addEquipSelected(arg_7_0.equip)
end

function var_0_0.bCanSelsubClass(arg_8_0)
	local var_8_0 = g_MainScene.wndGemsDecomposeSelect.selectIdList

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		return zbItemTable:getRecord(iter_8_1.TemplateId).subType
	end

	return -1
end
