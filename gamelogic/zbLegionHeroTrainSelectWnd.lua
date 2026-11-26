require("gamelogic.zbTabWnd")
require("gamelogic.zbLegionHeroTrainListSelect")

local var_0_0 = class("zbLegionHeroTrainSelectWnd", zbTabWnd)

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

function createLegionHeroTrainSelectWnd(arg_2_0)
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.refreshTag = true
		arg_3_0.spriteSelOk = {}
		arg_3_0.curTemplateId = 0
		arg_3_0.btnTouch = {}
		arg_3_0.trainType = arg_3_1
		arg_3_0.currTrainMode = ELegionTrainMode.Mode1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionHerotrainSelect.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.layerTrain = tolua.cast(var_5_3:getChildByTag(50), "CCNode")
		arg_3_0.lbHint = {}

		for iter_5_0 = 1, 3 do
			local var_5_4 = tolua.cast(arg_3_0.layerTrain:getChildByTag(2 + iter_5_0), "CCSprite")
			local var_5_5 = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")

			arg_3_0.spriteSelOk[iter_5_0] = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
			arg_3_0.btnTouch[iter_5_0] = tolua.cast(var_5_4:getChildByTag(0), "CCControlButton")
			arg_3_0.lbHint[iter_5_0] = tolua.cast(var_5_4:getChildByTag(2), "CCLabelTTF")

			arg_3_0.spriteSelOk[iter_5_0]:setVisible(false)
			arg_3_0.btnTouch[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		local var_5_6 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		}
		local var_5_7 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_3:getChildByTag(11), "CCLayer"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_3:getChildByTag(12), "CCLayer"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_3:getChildByTag(13), "CCLayer")
		}
		local var_5_8 = {
			[EHeroTabType.Battle] = "image/tab/tab_herotab_battle.png",
			[EHeroTabType.Entourage] = "image/tab/tab_herotab_entourage.png",
			[EHeroTabType.UnUse] = "image/tab/tab_herotab_unUse.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EHeroTabType.Battle] = createHeroTrainListSelect(var_5_7[EHeroTabType.Battle], var_5_6[EHeroTabType.Battle], EHeroTabType.Battle)
		arg_3_0.module[EHeroTabType.Entourage] = createHeroTrainListSelect(var_5_7[EHeroTabType.Entourage], var_5_6[EHeroTabType.Entourage], EHeroTabType.Entourage)
		arg_3_0.module[EHeroTabType.UnUse] = createHeroTrainListSelect(var_5_7[EHeroTabType.UnUse], var_5_6[EHeroTabType.UnUse], EHeroTabType.UnUse)
		arg_3_0.SpriteCost = tolua.cast(arg_3_0.layerTrain:getChildByTag(21), "CCSprite")
		arg_3_0.lbCostDummy = tolua.cast(arg_3_0.layerTrain:getChildByTag(22), "CCLabelTTF")
		arg_3_0.btnConfirm = tolua.cast(arg_3_0.layerTrain:getChildByTag(23), "CCControlButton")
		arg_3_0.lbCost = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCostDummy, arg_3_0.lbCost)
		arg_3_0.lbCost:setScale(0.48)
		arg_3_0:initTab(var_5_6, var_5_7, var_5_8)
		arg_3_0.btnConfirm:addHandleOfControlEvent(function()
			arg_3_0:onAddHeroTrain()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
		arg_3_0:selectCard(0)
	end, zbGameEvent.Event_LegionTrainStart_Ack)
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0.index = arg_10_1

	if arg_10_0.isShow == false then
		arg_10_0.refreshTag = true

		return
	end

	local var_10_0 = g_DataConfig.m_kLegionBaseCfg.train.trainMode

	if var_10_0 then
		for iter_10_0 = 1, 3 do
			arg_10_0.lbHint[iter_10_0]:setString(var_10_0[iter_10_0].needHour .. a2u("Сʱ") .. var_10_0[iter_10_0].point .. a2u("\xBC\xBC\xC4ܵ\xE3"))
		end
	end

	if arg_10_0.module[arg_10_0.currTab] then
		arg_10_0.module[arg_10_0.currTab]:refresh()
	end

	arg_10_0:onTouch(arg_10_0.currTrainMode)
end

function var_0_0.doSelectTab(arg_11_0)
	if arg_11_0.module[arg_11_0.currTab] then
		arg_11_0.module[arg_11_0.currTab]:refresh()
	end

	for iter_11_0 = 1, table.getn(arg_11_0.tabButtons) do
		if iter_11_0 == arg_11_0.currTab then
			arg_11_0.tabButtons[iter_11_0]:setZOrder(ZORDER_TOP)
		else
			arg_11_0.tabButtons[iter_11_0]:setZOrder(ZORDER_BOTTOM)
		end
	end

	arg_11_0:selectCard(arg_11_0.curTemplateId)
end

function var_0_0.selectCard(arg_12_0, arg_12_1)
	arg_12_0.curTemplateId = arg_12_1

	arg_12_0.layerTrain:setVisible(arg_12_1 > 0)

	if arg_12_0.module[arg_12_0.currTab] then
		arg_12_0.module[arg_12_0.currTab]:setSelectCard(arg_12_1)
	end
end

function var_0_0.onTouch(arg_13_0, arg_13_1)
	arg_13_0.currTrainMode = arg_13_1

	for iter_13_0 = 1, 3 do
		arg_13_0.spriteSelOk[iter_13_0]:setVisible(iter_13_0 == arg_13_1)
	end

	local var_13_0 = g_DataConfig.m_kLegionBaseCfg.train.trainMode[arg_13_0.currTrainMode]
	local var_13_1 = zbIconHelper:getMoneyPanelIconPath(var_13_0.needMoneyType)

	arg_13_0.SpriteCost:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_1))
	arg_13_0.lbCost:setString(var_13_0.needMoney)
end

function var_0_0.onAddHeroTrain(arg_14_0)
	local var_14_0 = g_DataConfig.m_kLegionBaseCfg.train.trainMode[arg_14_0.currTrainMode]

	if g_Self.kWealthHandler:hasEnoughMoney(var_14_0.needMoneyType, var_14_0.needMoney) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0Ǯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_LegionGame_TrainStart_Req(arg_14_0.index, arg_14_0.curTemplateId, arg_14_0.currTrainMode)
end
