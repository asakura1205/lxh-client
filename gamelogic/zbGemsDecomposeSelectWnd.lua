require("gamelogic.zbGemsDecomposeList")

local var_0_0 = class("zbGemsDecomposeSelectWnd", zbBaseWnd)

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

function createGemsDecomposeSelWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		local var_5_1 = CCBReaderLoad("ccbi/gems_decompose_mat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerFrag = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.layerGems = createGemsList(arg_3_0.layerFrag)

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_9_0)
	arg_9_0.layerGems:refresh()
end

function var_0_0.addEquipSelected(arg_10_0, arg_10_1)
	if arg_10_0:getEquipListNum() >= var_0_1 then
		return
	end

	table.insert(arg_10_0.selectIdList, arg_10_1)
	arg_10_0:onConfirm()
end

function var_0_0.getSelGemsCount(arg_11_0, arg_11_1)
	local var_11_0 = 0

	if arg_11_0:getEquipListNum() == 0 then
		var_11_0 = 0
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.selectIdList) do
		if iter_11_1.TemplateId == arg_11_1.TemplateId then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.getEquipListNum(arg_12_0)
	return table.getn(arg_12_0.selectIdList)
end

function var_0_0.onConfirm(arg_13_0)
	if g_MainScene.wndGemsDecompose then
		arg_13_0:hide()
		g_MainScene.wndGemsDecompose:refreshCanExchangeItemList(arg_13_0.selectIdList)
	end
end

function var_0_0.setSelectdList(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.selectIdList = {}
	arg_14_0.startIndex = arg_14_2

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		arg_14_0.selectIdList[iter_14_0] = iter_14_1
	end

	arg_14_0.layerGems:refresh()
end

function var_0_0.doDestroy(arg_15_0)
	if arg_15_0.layerGems then
		arg_15_0.layerGems:free()
	end
end

function var_0_0.onFrameUpdate(arg_16_0, arg_16_1)
	if arg_16_0.layerGems then
		arg_16_0.layerGems:frame()
	end
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.layerTouchTest, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end
