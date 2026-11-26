require("gamelogic.zbBaseWnd")
require("gamelogic.zbEquipDecomposeItem")

local var_0_0 = class("zbEquipDecomposeWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 5
local var_0_2 = ccp(0, 30)
local var_0_3 = 0.8

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createEquipDecomposeWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.materialNode = {}
		arg_3_0.materialNodePos = {}
		arg_3_0.selectedList = {}
		arg_3_0.effectList = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equip_decompose.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.matLayer = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		for iter_5_0 = 1, var_0_1 do
			arg_3_0.materialNode[iter_5_0] = createEquipDecomposeItem(tolua.cast(arg_3_0.matLayer:getChildByTag(iter_5_0), "CCNode"), iter_5_0)
			arg_3_0.materialNodePos[iter_5_0] = ccp(arg_3_0.materialNode[iter_5_0].ccNode:getPosition())
		end

		arg_3_0.node_rule = tolua.cast(var_5_1:getChildByTag(102), "CCNode")
		arg_3_0.btnRule = tolua.cast(arg_3_0.node_rule:getChildByTag(1), "CCControlButton")
		arg_3_0.btnShop = tolua.cast(arg_3_0.node_rule:getChildByTag(2), "CCControlButton")
		arg_3_0.btnSet = tolua.cast(arg_3_0.node_rule:getChildByTag(3), "CCControlButton")
		arg_3_0.btnAutoAddMat = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")
		arg_3_0.btnDecompose = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")
		arg_3_0.btnCleanMat = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")
		arg_3_0.effectRoot = tolua.cast(arg_3_0.matLayer:getChildByTag(11), "CCNode")

		arg_3_0.btnRule:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnRuleCallback), CCControlEventTouchUpInside)
		arg_3_0.btnShop:addHandleOfControlEvent(function()
			arg_3_0:btnShopCallback()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSet:addHandleOfControlEvent(function()
			arg_3_0:onSet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAutoAddMat:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnAutoAddMatCallback), CCControlEventTouchUpInside)
		arg_3_0.btnDecompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnDecomposeCallback), CCControlEventTouchUpInside)
		arg_3_0.btnCleanMat:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.reset), CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.EquipSoul
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:playerEffect()
	end, zbGameEvent.Event_EquipDecomposeSuccess)
end

function var_0_0.doShow(arg_10_0)
	arg_10_0:reset()
end

function var_0_0.reset(arg_11_0)
	local var_11_0 = {}

	arg_11_0:refreshCanExchangeItemList(var_11_0)
end

function var_0_0.doHide(arg_12_0)
	return
end

function var_0_0.decomposeSuccess(arg_13_0)
	local var_13_0 = {}

	arg_13_0:refreshCanExchangeItemList(var_13_0)

	for iter_13_0 = 1, var_0_1 do
		arg_13_0.materialNode[iter_13_0].ccNode:stopAllActions()
		arg_13_0.materialNode[iter_13_0].ccNode:setScale(1)
		arg_13_0.materialNode[iter_13_0].ccNode:setPosition(arg_13_0.materialNodePos[iter_13_0])
	end
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnDrag:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layerTouchTest, var_14_0.x, var_14_0.y) == false and zbUtil:PointInCtrl(arg_14_0.btnClose, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end

function var_0_0.btnRuleCallback(arg_15_0)
	g_MainScene:showRuleWnd(RuleType_EquipDecompose)
end

function var_0_0.btnShopCallback(arg_16_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Shop) then
		return
	end

	g_MainScene:showShopWnd(EShopTab.Mystery)
	g_MainScene.wndShop:setPrevWnd(arg_16_0)
end

function var_0_0.btnAutoAddMatCallback(arg_17_0)
	if table.getn(g_GameData.BagEquipList) == 0 then
		g_Bubble:bubbleInfo(a2u("Ŀǰû\xD3п\xC9\xC8\xDB\xC1\xB6װ\xB1\xB8"))

		return
	end

	local var_17_0 = g_Self.kBagItemHandler:getEquipDecomposeList()

	if table.getn(var_17_0) == 0 then
		g_Bubble:bubbleInfo(a2u("\xB1\xB3\xB0\xFC\xD6е\xC4װ\xB1\xB8\xD2ѱ\xBB\xC9\xE8\xD6\xC3\xC8\xDB\xC1\xB6\xB1\xA3\xBB\xA4,\xC7\xEB\xD4\xDA\xC8\xDB\xC1\xB6\xC9\xE8\xD6\xC3\xD6д\xA6\xC0\xED"))

		return
	end

	arg_17_0.selectedList = {}

	for iter_17_0 = 1, table.getn(var_17_0) do
		arg_17_0:autoAddEquip(var_17_0[iter_17_0])
	end

	arg_17_0:refreshCanExchangeItemList(arg_17_0.selectedList)
end

function var_0_0.autoAddEquip(arg_18_0, arg_18_1)
	for iter_18_0 = 1, var_0_1 do
		if arg_18_0.selectedList[iter_18_0] == nil then
			local var_18_0 = {}

			var_18_0.isFrag = false
			var_18_0.count = 1
			var_18_0.equip = arg_18_1
			arg_18_0.selectedList[iter_18_0] = var_18_0

			return
		end
	end
end

function var_0_0.btnDecomposeCallback(arg_19_0)
	local var_19_0 = 0

	if table.getn(arg_19_0.selectedList) <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEBѡ\xD4\xF1\xC8\xDB\xC1\xB6\xB2\xC4\xC1\xCF"))

		return
	end

	local var_19_1 = arg_19_0.selectedList

	g_WsMsgHandler:WS_Equip_Decompose_Req(var_19_1)
end

function var_0_0.refreshCanExchangeItemList(arg_20_0, arg_20_1)
	arg_20_0.selectedList = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		arg_20_0.selectedList[iter_20_0] = iter_20_1
	end

	for iter_20_2 = 1, var_0_1 do
		arg_20_0.materialNode[iter_20_2]:refresh(nil, iter_20_2)
		arg_20_0.materialNode[iter_20_2]:refresh(arg_20_0.selectedList[iter_20_2], iter_20_2)
	end

	if table.getn(arg_20_0.selectedList) > 0 then
		arg_20_0.btnCleanMat:setGray(false)
		arg_20_0.btnCleanMat:setEnabled(true)
	else
		arg_20_0.btnCleanMat:setGray(true)
		arg_20_0.btnCleanMat:setEnabled(false)
	end
end

function var_0_0.isSelect(arg_21_0, arg_21_1)
	if table.getn(arg_21_0.selectedList) == 0 then
		return false
	end

	if arg_21_1.isFrag == true then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.selectedList) do
			if iter_21_1.isFrag and iter_21_1.equip.TemplateId == arg_21_1.equip.TemplateId then
				return true
			end
		end
	else
		for iter_21_2, iter_21_3 in pairs(arg_21_0.selectedList) do
			if iter_21_3.equip.EquipId == arg_21_1.equip.EquipId then
				return true
			end
		end
	end

	return false
end

function var_0_0.removeItem(arg_22_0, arg_22_1, arg_22_2)
	if table.getn(arg_22_0.selectedList) <= 0 or arg_22_1 == nil then
		return
	end

	if arg_22_1.isFrag == true then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.selectedList) do
			if iter_22_1.equip.TemplateId == arg_22_1.equip.TemplateId then
				table.remove(arg_22_0.selectedList, iter_22_0)

				break
			end
		end
	else
		for iter_22_2, iter_22_3 in pairs(arg_22_0.selectedList) do
			if iter_22_3.equip.EquipId == arg_22_1.equip.EquipId then
				table.remove(arg_22_0.selectedList, iter_22_2)

				break
			end
		end
	end

	if arg_22_0.materialNode[arg_22_2] then
		arg_22_0.materialNode[arg_22_2]:refresh(nil, arg_22_2)
	end

	if table.getn(arg_22_0.selectedList) <= 0 then
		arg_22_0.btnCleanMat:setGray(true)
		arg_22_0.btnCleanMat:setEnabled(false)
	end
end

function var_0_0.playerEffect(arg_23_0)
	local var_23_0 = 1
	local var_23_1 = table.getn(arg_23_0.selectedList)

	arg_23_0.selectedList = {}

	for iter_23_0 = 1, var_0_1 do
		if arg_23_0.materialNode[iter_23_0].data ~= nil then
			if var_23_0 == var_23_1 then
				var_23_0 = 1

				arg_23_0.materialNode[iter_23_0].ccNode:setScale(1)

				local function var_23_2()
					g_Audio:playSound(AudioDefine.UI_HERO_DECOMPOSE_SUCCESS)
				end

				local function var_23_3()
					arg_23_0:decomposeSuccess()
				end

				local var_23_4 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))
				local var_23_5 = CCCallFuncN:create(var_23_2)
				local var_23_6 = CCDelayTime:create(0.8)
				local var_23_7 = CCCallFuncN:create(var_23_3)
				local var_23_8 = CCArray:create()

				var_23_8:addObject(var_23_4)
				var_23_8:addObject(var_23_5)
				var_23_8:addObject(var_23_6)
				var_23_8:addObject(var_23_7)
				arg_23_0.materialNode[iter_23_0].ccNode:stopAllActions()
				arg_23_0.materialNode[iter_23_0].ccNode:runAction(CCSequence:create(var_23_8))
			else
				var_23_0 = var_23_0 + 1

				local var_23_9 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))

				arg_23_0.materialNode[iter_23_0].ccNode:stopAllActions()
				arg_23_0.materialNode[iter_23_0].ccNode:runAction(var_23_9)
			end
		end
	end
end

function var_0_0.onSet(arg_26_0)
	g_MainScene:showEquipDecomposeSet()
end

function var_0_0.onFrameUpdate(arg_27_0)
	arg_27_0:updateBackEffect()
end
