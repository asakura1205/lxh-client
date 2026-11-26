local var_0_0 = class("zbBagItem", CCNodeExtend)

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

function createBagItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNodeRGBA:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.bagItemDetail = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteFrame = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteSelect = tolua.cast(var_5_0:getChildByTag(20), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(101), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbNum = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0:setVisible(arg_7_1 ~= nil)
	arg_7_0.spriteSelect:setVisible(false)

	if arg_7_1 == nil then
		return
	end

	arg_7_0.bagItemDetail = arg_7_1

	local var_7_0 = zbItemTable:getRecord(arg_7_1.TemplateId)
	local var_7_1 = zbIconHelper:getItemIconPath(arg_7_1.TemplateId)

	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
	arg_7_0.lbName:setString(var_7_0.name)
	arg_7_0.lbNum:setString(arg_7_1.Count)

	local var_7_2 = zbColor:getItemColor(var_7_0.quality)
	local var_7_3 = zbColor:getEquipFrameTex(var_7_0.quality)

	arg_7_0.lbName:setColor(var_7_2)
	arg_7_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_3))
end

function var_0_0.refreshSelectItem(arg_8_0, arg_8_1)
	arg_8_0.spriteSelect:setVisible(arg_8_0.bagItemDetail ~= nil and arg_8_0.bagItemDetail.TemplateId == arg_8_1)
end

function var_0_0.onTouch(arg_9_0)
	if arg_9_0.bagItemDetail then
		g_MainScene.wndBag.panelDetail:refreshByEquipId(arg_9_0.bagItemDetail)
		g_MainScene.wndBag:refreshSelectItem(arg_9_0.bagItemDetail.TemplateId)
	end
end
