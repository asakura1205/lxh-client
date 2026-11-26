require("gamelogic.zbTabWnd")
require("gamelogic.zbEquipDecomposeList")
require("gamelogic.zbEquipDecomposeSlot")

local var_0_0 = class("zbEquipDecomposeSelectWnd", zbTabWnd)

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

function createEquipDecomposeSelWnd()
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

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

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
		arg_3_0.module[EDecomposeBagTab.EquipFrag] = createDecomposeList(var_5_5[EDecomposeBagTab.EquipFrag], EDecomposeBagTab.EquipFrag)
		arg_3_0.module[EDecomposeBagTab.Equip] = createDecomposeList(var_5_5[EDecomposeBagTab.Equip], EDecomposeBagTab.Equip)

		arg_3_0:initTab(var_5_4, var_5_5, var_5_6)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.bottomLayer = tolua.cast(var_5_3:getChildByTag(100), "CCNode")
		arg_3_0.selectNum = tolua.cast(arg_3_0.bottomLayer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnOk = tolua.cast(arg_3_0.bottomLayer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnOk:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onConfirm), CCControlEventTouchUpInside)

		arg_3_0.selEquips = {}

		for iter_5_0 = 1, 5 do
			local var_5_7 = zbTableViewHelper:create()

			var_5_7:loadCCBFile("ccbi/tb_decomposeitem.ccbi")

			local var_5_8 = tolua.cast(arg_3_0.bottomLayer:getChildByTag(iter_5_0 * 10), "CCNode")

			var_5_8:setVisible(false)

			arg_3_0.selEquips[iter_5_0] = createEquipDecomposeSlot(translateAndStrokeHelper(var_5_7:readCCBNode()))

			arg_3_0.selEquips[iter_5_0]:setContentSize(CCSizeMake(110, 110))
			arg_3_0.selEquips[iter_5_0]:setScale(0.7)

			local var_5_9 = ccp(var_5_8:getPosition())

			arg_3_0.selEquips[iter_5_0]:setPosition(var_5_9.x, var_5_9.y)
			arg_3_0.bottomLayer:addChild(arg_3_0.selEquips[iter_5_0])
			var_5_7:releaseSelf()
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function(arg_8_0)
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_9_0)
	arg_9_0:selectTab(2)
end

function var_0_0.doDestroy(arg_10_0)
	if arg_10_0.module[EDecomposeBagTab.EquipFrag] then
		arg_10_0.module[EDecomposeBagTab.EquipFrag]:free()
	end

	if arg_10_0.module[EDecomposeBagTab.Equip] then
		arg_10_0.module[EDecomposeBagTab.Equip]:free()
	end
end

function var_0_0.onFrameUpdate(arg_11_0, arg_11_1)
	if arg_11_0.module[arg_11_0.currTab] then
		arg_11_0.module[arg_11_0.currTab]:frame()
	end
end

function var_0_0.updateSelectEquip(arg_12_0)
	if g_MainScene.wndEquipDecompose then
		g_MainScene.wndEquipDecompose.selectedList = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.selectIdList) do
			g_MainScene.wndEquipDecompose.selectedList[iter_12_0] = iter_12_1
		end
	end

	local var_12_0 = arg_12_0:getEquipListNum()

	arg_12_0.selectNum:setString(a2u("(") .. var_12_0 .. "/" .. var_0_1 .. a2u(")"))

	for iter_12_2 = 1, 5 do
		arg_12_0.selEquips[iter_12_2]:setVisible(false)
	end

	local var_12_1 = 1

	for iter_12_3, iter_12_4 in pairs(arg_12_0.selectIdList) do
		if var_12_1 <= 5 then
			arg_12_0.selEquips[var_12_1]:setVisible(true)
			arg_12_0.selEquips[var_12_1]:refresh(iter_12_4)

			var_12_1 = var_12_1 + 1
		end
	end
end

function var_0_0.addEquipSelected(arg_13_0, arg_13_1)
	if arg_13_0:getEquipListNum() >= var_0_1 then
		return
	end

	table.insert(arg_13_0.selectIdList, arg_13_1)
	arg_13_0:updateSelectEquip()
end

function var_0_0.removeEquipSelected(arg_14_0, arg_14_1)
	if arg_14_0:getEquipListNum() == 0 then
		return
	end

	if arg_14_1.isFrag == true then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.selectIdList) do
			if iter_14_1.equip.TemplateId == arg_14_1.equip.TemplateId then
				table.remove(arg_14_0.selectIdList, iter_14_0)

				break
			end
		end
	else
		for iter_14_2, iter_14_3 in pairs(arg_14_0.selectIdList) do
			if iter_14_3.equip.EquipId == arg_14_1.equip.EquipId then
				table.remove(arg_14_0.selectIdList, iter_14_2)

				break
			end
		end
	end

	arg_14_0:updateSelectEquip()
end

function var_0_0.getEquipListNum(arg_15_0)
	return table.getn(arg_15_0.selectIdList)
end

function var_0_0.isSelect(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return false
	end

	if arg_16_1.isFrag == true then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.selectIdList) do
			if iter_16_1.equip.TemplateId == arg_16_1.equip.TemplateId then
				return true
			end
		end
	else
		for iter_16_2, iter_16_3 in pairs(arg_16_0.selectIdList) do
			if iter_16_3.equip.EquipId == arg_16_1.equip.EquipId then
				return true
			end
		end
	end

	return false
end

function var_0_0.onConfirm(arg_17_0)
	if g_MainScene.wndEquipDecompose then
		arg_17_0:hide()
		g_MainScene.wndEquipDecompose:refreshCanExchangeItemList(arg_17_0.selectIdList)
	end
end

function var_0_0.setSelectdList(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.selectIdList = {}
	arg_18_0.startIndex = arg_18_2

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		arg_18_0.selectIdList[iter_18_0] = iter_18_1
	end

	arg_18_0:updateSelectEquip()
	arg_18_0.module[EDecomposeBagTab.EquipFrag]:refresh()
	arg_18_0.module[EDecomposeBagTab.Equip]:refresh()
end

function var_0_0.doSelectTab(arg_19_0)
	arg_19_0.module[arg_19_0.currTab]:refresh()
end

function var_0_0.onTouchTest(arg_20_0)
	local var_20_0 = arg_20_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_20_0.layerTouchTest, var_20_0.x, var_20_0.y) == false and zbUtil:PointInCtrl(arg_20_0.btnClose, var_20_0.x, var_20_0.y) == false then
		arg_20_0:hide()
	end
end
