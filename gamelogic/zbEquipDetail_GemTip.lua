zbEquipDetail_GemTip = class("zbEquipDetail_GemTip", zbBaseWnd)
zbEquipDetail_GemTip.__index = zbEquipDetail_GemTip

function createEquipGemTipWnd()
	local var_1_0 = zbEquipDetail_GemTip.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbEquipDetail_GemTip.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbEquipDetail_GemTip)

	return arg_2_0
end

function zbEquipDetail_GemTip.init(arg_3_0)
	local function var_3_0()
		arg_3_0.hero = nil
		arg_3_0.equip = nil
		arg_3_0.equipRecord = nil
		arg_3_0.index = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equip_gemtip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.lbName = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbDes = tolua.cast(arg_3_0.layerContent:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbAttr = tolua.cast(arg_3_0.layerContent:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnTi = tolua.cast(arg_3_0.layerContent:getChildByTag(11), "CCControlButton")
		arg_3_0.btnXie = tolua.cast(arg_3_0.layerContent:getChildByTag(12), "CCControlButton")

		local var_5_3 = zbTableViewHelper:create()

		var_5_3:loadCCBFile("ccbi/tb_equip_gem.ccbi")

		local var_5_4 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCNode")

		arg_3_0.item = zbEquipDetail_Enchant_Item:create(translateAndStrokeHelper(var_5_3:readCCBNode()), 100)

		var_5_3:releaseSelf()

		local var_5_5 = ccp(var_5_4:getPosition())

		arg_3_0.item:setPosition(var_5_5.x - 10, var_5_5.y)
		arg_3_0.item:setScale(0.8)
		arg_3_0.layerContent:addChild(arg_3_0.item)
		var_5_4:removeFromParentAndCleanup(true)
		arg_3_0.btnTi:addHandleOfControlEvent(function()
			arg_3_0:btnTiHuan()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTi:setZoomOnTouchDown(false)
		arg_3_0.btnXie:addHandleOfControlEvent(function()
			arg_3_0:btnXieXia()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnXie:setZoomOnTouchDown(false)

		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.rootSizeHeight = var_5_2:getContentSize().height
		arg_3_0.rootSizeWidth = var_5_2:getContentSize().width

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbEquipDetail_GemTip.refresh(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.heroTemplateId = arg_9_2
	arg_9_0.equip = arg_9_3
	arg_9_0.index = arg_9_4
	arg_9_0.gemSlotDetail = arg_9_1

	local var_9_0 = zbItemTable:getRecord(arg_9_1.TemplateId)

	arg_9_0.lbName:setString(var_9_0.name)
	arg_9_0.lbDes:setString(var_9_0.description)

	local var_9_1 = ""

	for iter_9_0, iter_9_1 in pairs(var_9_0.mainAttrList) do
		if iter_9_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_9_1 = var_9_1 .. " " .. a2u(getItemPropStr(iter_9_1.AttrType)) .. "+" .. iter_9_1.AttrValue
		else
			var_9_1 = var_9_1 .. " " .. a2u(getItemPropStr(iter_9_1.AttrType)) .. "+" .. iter_9_1.AttrValue * 100 .. "%"
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0.subAttrList) do
		local var_9_2 = a2u(getItemPropStr(iter_9_3.AttrType))

		if iter_9_3.AttrAdditionType == EAttrAdditionType.Fixed then
			var_9_1 = var_9_1 .. " " .. var_9_2 .. "+" .. iter_9_3.AttrValue
		else
			var_9_1 = var_9_1 .. " " .. var_9_2 .. "+" .. iter_9_3.AttrValue * 100 .. "%"
		end
	end

	arg_9_0.lbAttr:setString(var_9_1)
	arg_9_0.item:refreshTip(arg_9_1)
end

function zbEquipDetail_GemTip.btnTiHuan(arg_10_0)
	g_MainScene:showGemsSelect(arg_10_0.gemSlotDetail, arg_10_0.heroTemplateId, arg_10_0.equip, arg_10_0.index)
	arg_10_0:hide()
end

function zbEquipDetail_GemTip.btnXieXia(arg_11_0)
	local var_11_0 = {}

	if arg_11_0.heroTemplateId > 0 then
		var_11_0 = {
			SlotType = EEquipSlotType.Hero,
			HeroTid = arg_11_0.heroTemplateId,
			EquipId = arg_11_0.equip.EquipId
		}
	else
		var_11_0 = {
			SlotType = EEquipSlotType.Bag
		}
		var_11_0.HeroTid = 0
		var_11_0.EquipId = arg_11_0.equip.EquipId
	end

	g_WsMsgHandler:WS_Equip_GemRemove_Req(var_11_0, arg_11_0.index)
	arg_11_0:hide()
end

function zbEquipDetail_GemTip.refreshPos(arg_12_0, arg_12_1)
	local var_12_0 = zbUtil:getScreenSize().height
	local var_12_1 = zbUtil:getScreenSize().width
	local var_12_2 = arg_12_0.rootSizeHeight / zbUtil:getScreenSize().height
	local var_12_3 = arg_12_0.rootSizeWidth / zbUtil:getScreenSize().width

	arg_12_1.x = arg_12_1.x * var_12_3
	arg_12_1.y = arg_12_1.y * var_12_2

	arg_12_0.layerContent:setPosition(arg_12_1.x - 150, arg_12_1.y - 200)
end

function zbEquipDetail_GemTip.onTouchTest(arg_13_0)
	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layerContent, var_13_0.x, var_13_0.y) == false then
		arg_13_0:hide()
	end
end
