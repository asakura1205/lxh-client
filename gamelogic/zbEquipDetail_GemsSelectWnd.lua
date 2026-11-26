require("gamelogic.zbEquipDetail_GemsSelectList")
require("gamelogic.zbTabWnd")

zbEquipDetail_GemsSelectWnd = class("zbEquipDetail_GemsSelectWnd", zbTabWnd)
zbEquipDetail_GemsSelectWnd.__index = zbEquipDetail_GemsSelectWnd

function createGemsSelectWnd()
	local var_1_0 = zbEquipDetail_GemsSelectWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbEquipDetail_GemsSelectWnd.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbEquipDetail_GemsSelectWnd)

	return arg_2_0
end

function zbEquipDetail_GemsSelectWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.selectIdList = {}
		arg_3_0.startIndex = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gems_insert_wnd.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.tabButtons = {}
		arg_3_0.tabButtons[EGemShape.Gold] = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")
		arg_3_0.tabButtons[EGemShape.Water] = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.tabButtons[EGemShape.Wood] = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.tabButtons[EGemShape.Fire] = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.tabButtons[EGemShape.Soli] = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.tabLayers = {}
		arg_3_0.tabLayers[EGemShape.Gold] = tolua.cast(var_5_2:getChildByTag(11), "CCLayer")
		arg_3_0.tabLayers[EGemShape.Water] = tolua.cast(var_5_2:getChildByTag(12), "CCLayer")
		arg_3_0.tabLayers[EGemShape.Wood] = tolua.cast(var_5_2:getChildByTag(13), "CCLayer")
		arg_3_0.tabLayers[EGemShape.Fire] = tolua.cast(var_5_2:getChildByTag(14), "CCLayer")
		arg_3_0.tabLayers[EGemShape.Soli] = tolua.cast(var_5_2:getChildByTag(15), "CCLayer")

		local var_5_3 = {
			[EGemShape.Gold] = "image/tab/tab_gemshape_gold.png",
			[EGemShape.Water] = "image/tab/tab_gemshape_water.png",
			[EGemShape.Wood] = "image/tab/tab_gemshape_wood.png",
			[EGemShape.Fire] = "image/tab/tab_gemshape_fire.png",
			[EGemShape.Soli] = "image/tab/tab_gemshape_soli.png"
		}

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.modules = {}
		arg_3_0.modules[EGemShape.Gold] = createGemsSelectList(arg_3_0.tabLayers[EGemShape.Gold], EGemShape.Gold, arg_3_0.btnClose, arg_3_0)
		arg_3_0.modules[EGemShape.Water] = createGemsSelectList(arg_3_0.tabLayers[EGemShape.Water], EGemShape.Water, arg_3_0.btnClose, arg_3_0)
		arg_3_0.modules[EGemShape.Wood] = createGemsSelectList(arg_3_0.tabLayers[EGemShape.Wood], EGemShape.Wood, arg_3_0.btnClose, arg_3_0)
		arg_3_0.modules[EGemShape.Fire] = createGemsSelectList(arg_3_0.tabLayers[EGemShape.Fire], EGemShape.Fire, arg_3_0.btnClose, arg_3_0)
		arg_3_0.modules[EGemShape.Soli] = createGemsSelectList(arg_3_0.tabLayers[EGemShape.Soli], EGemShape.Soli, arg_3_0.btnClose, arg_3_0)

		arg_3_0:initTab(arg_3_0.tabButtons, arg_3_0.tabLayers, var_5_3, function(arg_6_0)
			return arg_3_0:switchTabCheck(arg_6_0)
		end)

		arg_3_0.layerTishi = tolua.cast(var_5_2:getChildByTag(30), "CCLayer")

		for iter_5_0 = 1, 5 do
			arg_3_0.tabButtons[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			arg_3_0.tabButtons[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDragEnter)
			arg_3_0.tabButtons[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd()
			end, CCControlEventTouchDragExit)
		end

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbEquipDetail_GemsSelectWnd.refresh(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.gemSlotDetail = arg_11_1

	arg_11_0:selectTab(arg_11_1.GemShape)

	arg_11_0.optEquip = arg_11_3
	arg_11_0.heroTemplateId = arg_11_2
	arg_11_0.holeIndex = arg_11_4

	arg_11_0.modules[arg_11_1.GemShape]:refresh()
end

function zbEquipDetail_GemsSelectWnd.switchTabCheck(arg_12_0, arg_12_1)
	arg_12_0.modules[arg_12_1]:refresh(arg_12_1)

	for iter_12_0 = 1, table.getn(arg_12_0.tabButtons) do
		if iter_12_0 == arg_12_1 then
			arg_12_0.tabButtons[iter_12_0]:setZOrder(ZORDER_TOP)
		else
			arg_12_0.tabButtons[iter_12_0]:setZOrder(ZORDER_BOTTOM)
		end
	end

	return true
end

function zbEquipDetail_GemsSelectWnd.onTouchDown(arg_13_0, arg_13_1)
	for iter_13_0 = 1, table.getn(arg_13_0.tabButtons) do
		if iter_13_0 == arg_13_1 then
			arg_13_0.tabButtons[iter_13_0]:setZOrder(ZORDER_TOP)
		end
	end
end

function zbEquipDetail_GemsSelectWnd.onTouchEnd(arg_14_0)
	for iter_14_0 = 1, table.getn(arg_14_0.tabButtons) do
		if iter_14_0 == arg_14_0.currTab then
			arg_14_0.tabButtons[iter_14_0]:setZOrder(ZORDER_TOP)
		else
			arg_14_0.tabButtons[iter_14_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end
