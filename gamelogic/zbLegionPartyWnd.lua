require("gamelogic.zbBaseWnd")
require("gamelogic.zbTimeLabel")

zbLegionPartyWnd = class("zbLegionPartyWnd", zbBaseWnd)
zbLegionPartyWnd.__index = zbLegionPartyWnd

function zbLegionPartyWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionPartyWnd)

	return arg_1_0
end

function createLegionPartyWnd()
	local var_2_0 = zbLegionPartyWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbLegionPartyWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.spriteMoney = {}
		arg_3_0.lbGetCount = {}
		arg_3_0.stopParty = 1
		arg_3_0.freshTime = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_party.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.spriteState = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.btnPartyOpen = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		arg_3_0.rootUnopenLayer = var_5_3

		arg_3_0.btnPartyOpen:addHandleOfControlEvent(function()
			arg_3_0:onPartyOpen()
		end, CCControlEventTouchUpInside)

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")

		arg_3_0.rootOpenLayer = var_5_4

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1), "CCLayer")

		arg_3_0.btnPartyGetNormal = tolua.cast(var_5_5:getChildByTag(1), "CCControlButton")
		arg_3_0.lbGetCount[1] = tolua.cast(var_5_5:getChildByTag(3), "CCLabelTTF")

		arg_3_0.btnPartyGetNormal:addHandleOfControlEvent(function()
			arg_3_0:onPartyGetNormal()
		end, CCControlEventTouchUpInside)

		arg_3_0.normalBtnLayer = var_5_5

		local var_5_6 = tolua.cast(var_5_4:getChildByTag(2), "CCLayer")

		arg_3_0.btnPartyGetLuxury = tolua.cast(var_5_6:getChildByTag(1), "CCControlButton")
		arg_3_0.lbGetCount[2] = tolua.cast(var_5_6:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbMoneyCount = tolua.cast(var_5_6:getChildByTag(5), "CCLabelTTF")

		arg_3_0.btnPartyGetLuxury:addHandleOfControlEvent(function()
			arg_3_0:onPartyGetLuxury()
		end, CCControlEventTouchUpInside)

		arg_3_0.luxuryBtnLayer = var_5_6

		local var_5_7 = tolua.cast(var_5_4:getChildByTag(3), "CCLayer")

		arg_3_0.lbUnJoinTotal = tolua.cast(var_5_7:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbUnJoinPlus = tolua.cast(var_5_7:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteOpenIng = tolua.cast(var_5_4:getChildByTag(4), "CCSprite")
		arg_3_0.spriteGetted = tolua.cast(var_5_4:getChildByTag(5), "CCSprite")
		arg_3_0.btnPartyRule = tolua.cast(var_5_2:getChildByTag(30), "CCControlButton")

		arg_3_0.btnPartyRule:addHandleOfControlEvent(function()
			arg_3_0:onPartyRule()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnPartyLog = tolua.cast(var_5_2:getChildByTag(40), "CCControlButton")

		arg_3_0.btnPartyLog:addHandleOfControlEvent(function()
			arg_3_0:onPartyLog()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Tili
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionGetDinner_Ack)
end

function zbLegionPartyWnd.refresh(arg_13_0)
	arg_13_0.LegionDinnerState = g_Self.kLegionHandler.legionDetail.LegionDinner

	if arg_13_0.LegionDinnerState == nil then
		arg_13_0:hide()

		return
	end

	arg_13_0.dinnerType = g_DataConfig.m_kLegionBaseCfg.dinner

	if arg_13_0.LegionDinnerState.OpenState == 0 then
		if g_Self.kLegionHandler:getOfficeById(g_GameData.BaseInfo.PlayerId) ~= ELegionOffice.Member then
			arg_13_0.btnPartyOpen:setVisible(true)
		else
			arg_13_0.btnPartyOpen:setVisible(false)
		end

		arg_13_0.spriteState:setGray(true)
		arg_13_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/partry/partry_unopen.png"))
		arg_13_0.rootUnopenLayer:setVisible(true)
		arg_13_0.rootOpenLayer:setVisible(false)
	elseif arg_13_0.LegionDinnerState.OpenState == 1 then
		arg_13_0.rootUnopenLayer:setVisible(false)
		arg_13_0.rootOpenLayer:setVisible(true)
		arg_13_0.spriteState:setGray(false)
		arg_13_0.btnPartyGetNormal:setGray(false)
		arg_13_0.btnPartyGetLuxury:setGray(false)
		arg_13_0.lbUnJoinPlus:setString(arg_13_0.LegionDinnerState.LeftTili)
		arg_13_0.lbMoneyCount:setString(arg_13_0.LegionDinnerState.DiamondCost)

		local var_13_0 = zbLegionTechTable:getRecord(ELegionTechType.DinnerGain)

		if var_13_0 then
			local var_13_1 = zbLegionTechUpgradeTable:getlimitByIdAndLv(var_13_0.upgradeId, g_Self.kLegionHandler:getTechLevel(ELegionTechType.DinnerGain))

			arg_13_0.lbGetCount[1]:setString(var_13_1)
			arg_13_0.lbGetCount[2]:setString(var_13_1 * 2)
		end

		local var_13_2 = zbLegionTechTable:getRecord(ELegionTechType.DinnerOpen)

		if var_13_2 then
			local var_13_3 = zbLegionTechUpgradeTable:getlimitByIdAndLv(var_13_2.upgradeId, g_Self.kLegionHandler:getTechLevel(ELegionTechType.DinnerOpen))

			arg_13_0.lbUnJoinTotal:setString(var_13_3)
		end

		if arg_13_0.LegionDinnerState.SelfState == 0 then
			arg_13_0.spriteOpenIng:setVisible(true)
			arg_13_0.spriteGetted:setVisible(false)
			arg_13_0.luxuryBtnLayer:setVisible(true)
			arg_13_0.normalBtnLayer:setVisible(true)
		else
			arg_13_0.spriteOpenIng:setVisible(false)
			arg_13_0.spriteGetted:setVisible(true)
			arg_13_0.luxuryBtnLayer:setVisible(false)
			arg_13_0.normalBtnLayer:setVisible(false)
		end
	else
		arg_13_0.rootUnopenLayer:setVisible(true)
		arg_13_0.rootOpenLayer:setVisible(false)
		arg_13_0.btnPartyOpen:setVisible(false)
		arg_13_0.spriteState:setGray(true)
		arg_13_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/partry/partry_end.png"))
	end
end

function zbLegionPartyWnd.onPartyGetNormal(arg_14_0)
	g_WsMsgHandler:WS_LegionGame_DinnerGain_Req(0)
end

function zbLegionPartyWnd.onPartyGetLuxury(arg_15_0)
	g_WsMsgHandler:WS_LegionGame_DinnerGain_Req(2)
end

function zbLegionPartyWnd.onPartyOpen(arg_16_0)
	g_WsMsgHandler:WS_LegionGame_DinnerOpen_Req()
end

function zbLegionPartyWnd.onPartyRule(arg_17_0)
	g_MainScene:showRuleWnd(RuleType_LegionParty)
end

function zbLegionPartyWnd.onPartyLog(arg_18_0)
	g_WsMsgHandler:WS_LegionGame_GetDinnerLog_Req()
end
