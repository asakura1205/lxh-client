require("gamelogic.zbTabWnd")
require("gamelogic.zbEquipDetail_CuilianList")
require("gamelogic.zbEquipDetail_CuilianSlot")

local var_0_0 = class("zbEquipDetail_CuilianSelectWnd", zbTabWnd)

var_0_0.__index = var_0_0

local var_0_1 = 4

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createEquipCuilianSelectWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.selectIdList = {}
		arg_3_0.startIndex = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equip_decompose_mat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(100), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = {
			[EDecomposeBagTab.EquipFrag] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton"),
			[EDecomposeBagTab.Equip] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")
		}
		local var_5_5 = {
			[EDecomposeBagTab.EquipFrag] = tolua.cast(var_5_3:getChildByTag(11), "CCLayer"),
			[EDecomposeBagTab.Equip] = tolua.cast(var_5_3:getChildByTag(12), "CCLayer")
		}
		local var_5_6 = {
			[EDecomposeBagTab.EquipFrag] = "image/tab/tab_decompose_equipFrag.png",
			[EDecomposeBagTab.Equip] = "image/tab/tab_decompose_equip.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EDecomposeBagTab.EquipFrag] = createEquipCuilianList(var_5_5[EDecomposeBagTab.EquipFrag], EDecomposeBagTab.EquipFrag)
		arg_3_0.module[EDecomposeBagTab.Equip] = createEquipCuilianList(var_5_5[EDecomposeBagTab.Equip], EDecomposeBagTab.Equip)

		arg_3_0:initTab(var_5_4, var_5_5, var_5_6, function(arg_6_0)
			return arg_3_0:switchTabCheck(arg_6_0)
		end)

		for iter_5_0 = 1, 2 do
			var_5_4[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			var_5_4[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDragEnter)
			var_5_4[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd()
			end, CCControlEventTouchDragExit)
		end

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.bottomLayer = tolua.cast(var_5_3:getChildByTag(100), "CCNode")
		arg_3_0.selectNum = tolua.cast(arg_3_0.bottomLayer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnOk = tolua.cast(arg_3_0.bottomLayer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnOk:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onConfirm), CCControlEventTouchUpInside)

		arg_3_0.selEquips = {}

		for iter_5_1 = 1, 5 do
			local var_5_7 = zbTableViewHelper:create()

			var_5_7:loadCCBFile("ccbi/tb_decomposeitem.ccbi")

			local var_5_8 = tolua.cast(arg_3_0.bottomLayer:getChildByTag(iter_5_1 * 10), "CCNode")

			var_5_8:setVisible(false)

			arg_3_0.selEquips[iter_5_1] = createEquipCuilianSlot(translateAndStrokeHelper(var_5_7:readCCBNode()))

			arg_3_0.selEquips[iter_5_1]:setContentSize(CCSizeMake(110, 110))
			arg_3_0.selEquips[iter_5_1]:setScale(0.7)

			local var_5_9 = ccp(var_5_8:getPosition())

			arg_3_0.selEquips[iter_5_1]:setPosition(var_5_9.x, var_5_9.y)
			arg_3_0.bottomLayer:addChild(arg_3_0.selEquips[iter_5_1])
			var_5_7:releaseSelf()
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function(arg_11_0)
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_12_0)
	arg_12_0:selectTab(2)
end

function var_0_0.doDestroy(arg_13_0)
	if arg_13_0.module[EDecomposeBagTab.EquipFrag] then
		arg_13_0.module[EDecomposeBagTab.EquipFrag]:free()
	end

	if arg_13_0.module[EDecomposeBagTab.Equip] then
		arg_13_0.module[EDecomposeBagTab.Equip]:free()
	end
end

function var_0_0.onFrameUpdate(arg_14_0, arg_14_1)
	if arg_14_0.module[arg_14_0.currTab] then
		arg_14_0.module[arg_14_0.currTab]:frame()
	end
end

function var_0_0.switchTabCheck(arg_15_0, arg_15_1)
	arg_15_0.module[arg_15_1]:refresh()

	for iter_15_0 = 1, table.getn(arg_15_0.tabButtons) do
		if iter_15_0 == arg_15_1 then
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_TOP)
		else
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_BOTTOM)
		end
	end

	return true
end

function var_0_0.updateSelectEquip(arg_16_0)
	local var_16_0 = arg_16_0:getEquipListNum()

	arg_16_0.selectNum:setString(a2u("(") .. var_16_0 .. "/" .. var_0_1 .. a2u(")"))

	for iter_16_0 = 1, 5 do
		arg_16_0.selEquips[iter_16_0]:setVisible(false)
	end

	local var_16_1 = 1

	for iter_16_1, iter_16_2 in pairs(arg_16_0.selectIdList) do
		if var_16_1 <= 5 then
			arg_16_0.selEquips[var_16_1]:setVisible(true)
			arg_16_0.selEquips[var_16_1]:refresh(iter_16_2)

			var_16_1 = var_16_1 + 1
		end
	end
end

function var_0_0.addEquipSelected(arg_17_0, arg_17_1)
	if arg_17_0:getEquipListNum() >= var_0_1 then
		return
	end

	table.insert(arg_17_0.selectIdList, arg_17_1)
	arg_17_0:updateSelectEquip()
end

function var_0_0.removeEquipSelected(arg_18_0, arg_18_1)
	if arg_18_0:getEquipListNum() == 0 then
		return
	end

	if arg_18_1.isFrag == true then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.selectIdList) do
			if iter_18_1.equip.TemplateId == arg_18_1.equip.TemplateId then
				table.remove(arg_18_0.selectIdList, iter_18_0)

				break
			end
		end
	else
		for iter_18_2, iter_18_3 in pairs(arg_18_0.selectIdList) do
			if iter_18_3.equip.EquipId == arg_18_1.equip.EquipId then
				table.remove(arg_18_0.selectIdList, iter_18_2)

				break
			end
		end
	end

	arg_18_0:updateSelectEquip()
end

function var_0_0.getEquipListNum(arg_19_0)
	return table.getn(arg_19_0.selectIdList)
end

function var_0_0.isSelect(arg_20_0, arg_20_1)
	if arg_20_1 == nil then
		return false
	end

	if arg_20_1.isFrag == true then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.selectIdList) do
			if iter_20_1.equip.TemplateId == arg_20_1.equip.TemplateId then
				return true
			end
		end
	else
		for iter_20_2, iter_20_3 in pairs(arg_20_0.selectIdList) do
			if iter_20_3.equip.EquipId == arg_20_1.equip.EquipId then
				return true
			end
		end
	end

	return false
end

function var_0_0.onConfirm(arg_21_0)
	if g_MainScene.wndEquipDetail then
		arg_21_0:hide()
		g_MainScene.wndEquipDetail.module[EEquipForgeTab.Cuilian]:refreshCanExchangeItemList(arg_21_0.selectIdList)
	end
end

function var_0_0.setSelectdList(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.selectIdList = {}
	arg_22_0.startIndex = arg_22_2

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		arg_22_0.selectIdList[iter_22_0] = iter_22_1
	end

	arg_22_0:updateSelectEquip()
	arg_22_0.module[EDecomposeBagTab.EquipFrag]:refresh()
	arg_22_0.module[EDecomposeBagTab.Equip]:refresh()
end

function var_0_0.doSelectTab(arg_23_0)
	arg_23_0.module[arg_23_0.currTab]:refresh()
end

function var_0_0.onTouchDown(arg_24_0, arg_24_1)
	for iter_24_0 = 1, table.getn(arg_24_0.tabButtons) do
		if iter_24_0 == arg_24_1 then
			arg_24_0.tabButtons[iter_24_0]:setZOrder(ZORDER_TOP)
		end
	end
end

function var_0_0.onTouchEnd(arg_25_0)
	for iter_25_0 = 1, table.getn(arg_25_0.tabButtons) do
		if iter_25_0 == arg_25_0.currTab then
			arg_25_0.tabButtons[iter_25_0]:setZOrder(ZORDER_TOP)
		else
			arg_25_0.tabButtons[iter_25_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end
