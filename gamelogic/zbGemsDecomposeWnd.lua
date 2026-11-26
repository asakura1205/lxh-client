require("gamelogic.zbBaseWnd")
require("gamelogic.zbGemsDecomposeItem")
require("gamelogic.zbItem")

local var_0_0 = class("zbGemsDecomposeWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 5
local var_0_2 = ccp(0, 50)
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

function createGemsDecomposeWnd()
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
		arg_3_0.awardType = ECommonAwardType.EAwardType_Item
		arg_3_0.awardId = -1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gems_decompose.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.root = var_5_1

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_2:addChild(var_5_4)

		arg_3_0.equipItemDummy = var_5_4

		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.mayAwardNode = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.mayGet = {}

		for iter_5_0 = 1, 5 do
			local var_5_5 = tolua.cast(arg_3_0.mayAwardNode:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_6 = createItem()

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_6:setScale(0.5)
			var_5_6:setVisible(false)
			arg_3_0.mayAwardNode:addChild(var_5_6)

			arg_3_0.mayGet[iter_5_0] = var_5_6

			var_5_5:removeFromParentAndCleanup(true)
		end

		arg_3_0.mayAwardBg = tolua.cast(arg_3_0.mayAwardNode:getChildByTag(10), "CCScale9Sprite")
		arg_3_0.matLayer = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.effectRoot = tolua.cast(arg_3_0.matLayer:getChildByTag(10), "CCNode")

		for iter_5_1 = 1, var_0_1 do
			arg_3_0.materialNode[iter_5_1] = createGemsDecomposeItem(tolua.cast(arg_3_0.matLayer:getChildByTag(iter_5_1), "CCNode"), iter_5_1)
			arg_3_0.materialNodePos[iter_5_1] = ccp(arg_3_0.materialNode[iter_5_1].ccNode:getPosition())
		end

		arg_3_0.node_rule = tolua.cast(var_5_1:getChildByTag(102), "CCNode")
		arg_3_0.btnShop = tolua.cast(arg_3_0.node_rule:getChildByTag(3), "CCControlButton")
		arg_3_0.btnAutoAddMat = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnDecompose = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.btnCleanMat = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		arg_3_0.btnShop:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnShopCallback), CCControlEventTouchUpInside)
		arg_3_0.btnAutoAddMat:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnAutoAddMatCallback), CCControlEventTouchUpInside)
		arg_3_0.btnDecompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnDecomposeCallback), CCControlEventTouchUpInside)
		arg_3_0.btnCleanMat:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.cleanGems), CCControlEventTouchUpInside)

		arg_3_0.lbldesc = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")

		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0.mayAwardNode:setVisible(false)
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:playerEffect()
	end, zbGameEvent.Event_GemsDecomposeSuccess)
end

function var_0_0.doShow(arg_8_0)
	local var_8_0 = {}

	arg_8_0:refreshCanExchangeItemList(var_8_0)
end

function var_0_0.doHide(arg_9_0)
	return
end

function var_0_0.decomposeSuccess(arg_10_0)
	local var_10_0 = {}

	arg_10_0:refreshCanExchangeItemList(var_10_0)

	for iter_10_0 = 1, var_0_1 do
		arg_10_0.materialNode[iter_10_0].ccNode:stopAllActions()
		arg_10_0.materialNode[iter_10_0].ccNode:setScale(1)
		arg_10_0.materialNode[iter_10_0].ccNode:setPosition(arg_10_0.materialNodePos[iter_10_0])
	end

	local var_10_1 = g_Self.kDataChange.awardList

	if zbUtil:isValidTable(var_10_1) and table.getn(var_10_1) > 0 then
		local var_10_2 = var_10_1[1]

		arg_10_0.equipItemDummy:refreshAward(var_10_2.awardType, var_10_2.awardId, var_10_2.awardCount)
		arg_10_0.equipItemDummy:setVisible(true)
	end
end

function var_0_0.btnRuleCallback(arg_11_0)
	g_MainScene:showRuleWnd(RuleType_GemsDecompose)
end

function var_0_0.btnShopCallback(arg_12_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Shop) then
		return
	end

	g_MainScene:showShopWnd(EShopTab.Mystery)
	g_MainScene.wndShop:setPrevWnd(arg_12_0)
end

function var_0_0.btnAutoAddMatCallback(arg_13_0)
	if table.getn(arg_13_0.selectedList) == var_0_1 then
		return
	end

	local var_13_0 = g_Self.kBagItemHandler:getComposeGems()

	if table.getn(var_13_0) == 0 then
		g_Bubble:bubbleInfo(a2u("û\xD3\xD0\xC1\xE9\xD6\xCA,\xB2\xBB\xC4\xDC\xD7Զ\xAF\xCC\xED\xBC\xD3"))

		return
	end

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.selectedList) do
		var_13_1[iter_13_0] = iter_13_1
	end

	if table.getn(arg_13_0.selectedList) > 0 then
		local var_13_2 = -1

		for iter_13_2, iter_13_3 in pairs(arg_13_0.selectedList) do
			if iter_13_3 ~= nil then
				var_13_2 = iter_13_3.TemplateId

				break
			end
		end

		if arg_13_0:addGemsByTemplateId(var_13_0, var_13_2) == false then
			local var_13_3 = -1

			for iter_13_4, iter_13_5 in pairs(arg_13_0.selectedList) do
				if iter_13_5 ~= nil then
					local var_13_4 = zbItemTable:getRecord(iter_13_5.TemplateId)

					if var_13_4 then
						var_13_3 = var_13_4.subType
					end

					break
				end
			end

			if arg_13_0:addGemsBysubType(var_13_0, var_13_3) == false then
				g_Bubble:bubbleInfo(a2u("û\xD3\xD0\xC1\xE9\xD6ʿ\xC9\xD7Զ\xAF\xCC\xED\xBC\xD3"))
			else
				arg_13_0:refreshCanExchangeItemList(arg_13_0.selectedList)

				return
			end
		else
			arg_13_0:refreshCanExchangeItemList(arg_13_0.selectedList)

			return
		end
	else
		local function var_13_5(arg_14_0)
			if arg_13_0:addGemsBysubType(var_13_0, arg_14_0) == false then
				arg_13_0.selectedList = {}

				if arg_14_0 <= EGemType.MaxNum then
					arg_14_0 = arg_14_0 + 1

					var_13_5(arg_14_0)
				end
			end
		end

		local var_13_6 = EGemType.Level1

		var_13_5(var_13_6)

		if table.getn(arg_13_0.selectedList) == var_0_1 then
			arg_13_0:refreshCanExchangeItemList(arg_13_0.selectedList)

			return
		else
			g_Bubble:bubbleInfo(a2u("û\xD3\xD0\xC1\xE9\xD6ʿ\xC9\xD7Զ\xAF\xCC\xED\xBC\xD3"))
		end
	end

	arg_13_0.selectedList = var_13_1
end

function var_0_0.addGemsByTemplateId(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		if iter_15_1.TemplateId == arg_15_2 and iter_15_1.Count >= var_0_1 then
			for iter_15_2 = 1, var_0_1 do
				if table.getn(arg_15_0.selectedList) < var_0_1 then
					table.insert(arg_15_0.selectedList, iter_15_1)

					if table.getn(arg_15_0.selectedList) == var_0_1 then
						return true
					end
				end
			end

			return true
		end
	end

	return false
end

function var_0_0.addGemsBysubType(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if zbItemTable:getRecord(iter_16_1.TemplateId).subType == arg_16_2 then
			local var_16_0 = arg_16_0:getSelgemsCountByTemplateId(iter_16_1.TemplateId)

			for iter_16_2 = 1, iter_16_1.Count - var_16_0 do
				if table.getn(arg_16_0.selectedList) < var_0_1 then
					table.insert(arg_16_0.selectedList, iter_16_1)

					if table.getn(arg_16_0.selectedList) == var_0_1 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.getSelgemsCountByTemplateId(arg_17_0, arg_17_1)
	if table.getn(arg_17_0.selectedList) == 0 then
		return 0
	end

	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_0.selectedList) do
		if iter_17_1.TemplateId == arg_17_1 then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_0.cleanGems(arg_18_0)
	local var_18_0 = {}

	arg_18_0:refreshCanExchangeItemList(var_18_0)
end

function var_0_0.btnDecomposeCallback(arg_19_0)
	local var_19_0 = 0

	if table.getn(arg_19_0.selectedList) < var_0_1 then
		g_Bubble:bubbleInfo(a2u("\xBAϳ\xC9\xC1\xE9\xD6\xCA\xCA\xFD\xC1\xBF\xB2\xBB\xD7\xE3"))

		return
	end

	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.selectedList) do
		table.insert(var_19_1, iter_19_1.TemplateId)
	end

	g_WsMsgHandler:WS_Bag_GemCompose_Req(var_19_1)
end

function var_0_0.refreshCanExchangeItemList(arg_20_0, arg_20_1)
	arg_20_0.equipItemDummy:setVisible(false)

	arg_20_0.selectedList = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		arg_20_0.selectedList[iter_20_0] = iter_20_1
	end

	for iter_20_2 = 1, var_0_1 do
		arg_20_0.materialNode[iter_20_2]:refresh(nil, iter_20_2)
		arg_20_0.materialNode[iter_20_2]:refresh(arg_20_0.selectedList[iter_20_2], iter_20_2)
	end

	if table.getn(arg_20_0.selectedList) > 0 then
		arg_20_0.btnCleanMat:setEnabled(true)
		arg_20_0.btnCleanMat:setGray(false)
	else
		arg_20_0.btnCleanMat:setEnabled(false)
		arg_20_0.btnCleanMat:setGray(true)
	end

	arg_20_0:refreshMayGetGems()
end

function var_0_0.refreshMayGetGems(arg_21_0)
	arg_21_0.mayAwardNode:setVisible(table.getn(arg_21_0.selectedList) >= 5)

	if table.getn(arg_21_0.selectedList) <= 0 then
		return
	end

	for iter_21_0 = 1, 5 do
		arg_21_0.mayGet[iter_21_0]:setVisible(false)
	end

	local var_21_0 = {}

	local function var_21_1(arg_22_0)
		for iter_22_0, iter_22_1 in pairs(var_21_0) do
			if iter_22_1 == arg_22_0 then
				return false
			end
		end

		return true
	end

	for iter_21_1, iter_21_2 in pairs(arg_21_0.selectedList) do
		local var_21_2 = zbItemTable:getRecord(iter_21_2.TemplateId)

		if var_21_2 and var_21_1(var_21_2.gemShape) then
			table.insert(var_21_0, var_21_2.gemShape)
		end
	end

	local var_21_3 = arg_21_0.selectedList[1]
	local var_21_4 = zbItemTable:getRecord(var_21_3.TemplateId)
	local var_21_5 = 1

	if var_21_4 then
		var_21_5 = var_21_4.subType
	end

	local var_21_6 = math.min(EGemType.MaxNum - 1, var_21_5)
	local var_21_7 = zbGemsComposeTable:getRecordBylevel(var_21_6)
	local var_21_8 = {}

	for iter_21_3, iter_21_4 in pairs(var_21_7) do
		local var_21_9 = zbItemTable:getRecord(iter_21_4.templateId)

		if var_21_9 and not var_21_1(var_21_9.gemShape) and var_21_9.fv > 0 then
			table.insert(var_21_8, var_21_9)
		end
	end

	local var_21_10 = 1

	for iter_21_5, iter_21_6 in pairs(var_21_8) do
		if var_21_10 <= 5 then
			arg_21_0.mayGet[var_21_10]:setVisible(true)
			arg_21_0.mayGet[var_21_10]:refreshAward(ECommonAwardType.Item, iter_21_6.id, 1, false)

			var_21_10 = var_21_10 + 1
		end
	end

	arg_21_0.mayAwardBg:setPreferredSize(CCSizeMake(250 + table.getn(var_21_8) * 50, 62))
end

function var_0_0.isSelect(arg_23_0, arg_23_1)
	if table.getn(arg_23_0.selectedList) == 0 then
		return false
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0.selectedList) do
		if iter_23_1.TemplateId == arg_23_1.TemplateId then
			return true
		end
	end

	return false
end

function var_0_0.getselectedListCount(arg_24_0)
	return table.getn(arg_24_0.selectedList)
end

function var_0_0.removeItem(arg_25_0, arg_25_1, arg_25_2)
	if table.getn(arg_25_0.selectedList) <= 0 or arg_25_1 == nil then
		return
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.selectedList) do
		if iter_25_1.TemplateId == arg_25_1.TemplateId then
			table.remove(arg_25_0.selectedList, iter_25_0)

			break
		end
	end

	if table.getn(arg_25_0.selectedList) > 0 then
		arg_25_0.btnCleanMat:setEnabled(true)
		arg_25_0.btnCleanMat:setGray(false)
	else
		arg_25_0.btnCleanMat:setEnabled(false)
		arg_25_0.btnCleanMat:setGray(true)
	end

	local var_25_0 = arg_25_0.materialNode[arg_25_2]

	if var_25_0 then
		var_25_0:refresh(nil, arg_25_2)
	end

	arg_25_0:refreshMayGetGems()
end

function var_0_0.playerEffect(arg_26_0)
	local var_26_0 = 1
	local var_26_1 = table.getn(arg_26_0.selectedList)

	for iter_26_0 = 1, var_0_1 do
		if arg_26_0.materialNode[iter_26_0].data ~= nil then
			if var_26_0 == var_26_1 then
				var_26_0 = 1

				arg_26_0.materialNode[iter_26_0].ccNode:setScale(1)

				local function var_26_2()
					arg_26_0.selectedList = {}

					g_Audio:playSound(AudioDefine.UI_HERO_DECOMPOSE_SUCCESS)
				end

				local function var_26_3()
					arg_26_0:decomposeSuccess()
				end

				local var_26_4 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))
				local var_26_5 = CCCallFuncN:create(var_26_2)
				local var_26_6 = CCDelayTime:create(0.8)
				local var_26_7 = CCCallFuncN:create(var_26_3)
				local var_26_8 = CCArray:create()

				var_26_8:addObject(var_26_4)
				var_26_8:addObject(var_26_5)
				var_26_8:addObject(var_26_6)
				var_26_8:addObject(var_26_7)
				arg_26_0.materialNode[iter_26_0].ccNode:stopAllActions()
				arg_26_0.materialNode[iter_26_0].ccNode:runAction(CCSequence:create(var_26_8))
			else
				var_26_0 = var_26_0 + 1

				local var_26_9 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))

				arg_26_0.materialNode[iter_26_0].ccNode:stopAllActions()
				arg_26_0.materialNode[iter_26_0].ccNode:runAction(var_26_9)
			end
		end
	end
end

function var_0_0.onFrameUpdate(arg_29_0)
	arg_29_0:updateBackEffect()
end
