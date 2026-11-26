local var_0_0 = class("zbEquipDetail_GemsSelectCard")

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

function createGemsSelectCard(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.selectCallback = nil
	arg_3_0.root = arg_3_1
	arg_3_0.parent = arg_3_2

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
	arg_3_0:setContentSize(CCSizeMake(140, 120))
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setPosition(0, 0)
	arg_3_0:addChild(arg_3_1)
end

function var_0_0.refresh(arg_5_0, arg_5_1)
	arg_5_0:setVisible(arg_5_1 ~= nil)

	if arg_5_1 == nil then
		return
	end

	arg_5_0.gemStone = arg_5_1
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
	arg_5_0.num:setString(arg_5_1.Count)
	arg_5_0:setGrayAndEnabled(false)

	if arg_5_0.parent and arg_5_0.parent.gemSlotDetail and arg_5_0.gemStone.TemplateId == arg_5_0.parent.gemSlotDetail.TemplateId then
		arg_5_0:setGrayAndEnabled(true)
	end
end

function var_0_0.setGrayAndEnabled(arg_6_0, arg_6_1)
	arg_6_0.headRoot:setGray(arg_6_1)
	arg_6_0.headRoot:setGray(arg_6_1)
	arg_6_0.btnTouch:setEnabled(not arg_6_1)
end

function var_0_0.btnTouchCallback(arg_7_0)
	local var_7_0 = arg_7_0.parent.heroTemplateId
	local var_7_1 = arg_7_0.parent.optEquip
	local var_7_2 = arg_7_0.parent.holeIndex

	if zbItemTable:getRecord(arg_7_0.gemStone.TemplateId).gemShape == arg_7_0.parent.gemSlotDetail.GemShape then
		local var_7_3

		if var_7_0 > 0 then
			var_7_3 = {
				SlotType = EEquipSlotType.Hero,
				HeroTid = var_7_0,
				EquipId = var_7_1.EquipId
			}
		else
			var_7_3 = {
				SlotType = EEquipSlotType.Bag
			}
			var_7_3.HeroTid = 0
			var_7_3.EquipId = var_7_1.EquipId
		end

		local var_7_4 = arg_7_0.gemStone.TemplateId

		g_WsMsgHandler:WS_Equip_GemSet_Req(var_7_3, var_7_2, var_7_4)
		arg_7_0.parent:hide()
	end
end

function var_0_0.bCanSelsubClass(arg_8_0)
	return -1
end
