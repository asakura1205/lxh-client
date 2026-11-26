require("gamelogic.zbTabWnd")
require("gamelogic.zbLegionRedWnd_Send")
require("gamelogic.zbLegionRedWnd_Gain")

local var_0_0 = class("zbLegionRedWnd", zbTabWnd)

var_0_0.__index = var_0_0

local var_0_1 = {
	"\xC4\xDC\xD3ú\xEC\xB0\xFC\xBD\xE2\xBE\xF6\xB5\xC4\xCA\xC2\xC7飬\xBE\xF8\xB2\xBB\xB6\xE0˵\xBB\xB0\xA3\xA1",
	"\xD7\xF7Ϊ\xBA\xEC\xB0\xFC\xB4\xEF\xC8ˣ\xACһ\xB8\xF6\xB6\xBC\xB2\xBB\xC4ܷŹ\xFD\xA3\xA1"
}

function createLegionRedWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 25, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/legion_red.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		local var_5_5 = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")

		arg_3_0.spriteTalk = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.lbTalk = tolua.cast(arg_3_0.spriteTalk:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnAvatar = tolua.cast(var_5_5:getChildByTag(2), "CCControlButton")

		arg_3_0.btnAvatar:addHandleOfControlEvent(function()
			arg_3_0:onAvatar()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbCount = tolua.cast(var_5_5:getChildByTag(3), "CCLabelTTF")
		arg_3_0.node = var_5_2
		arg_3_0.layer = var_5_3
		arg_3_0.layerTab = var_5_4

		local var_5_6 = {
			[ELegionRedTab.Send] = tolua.cast(var_5_4:getChildByTag(1), "CCControlButton"),
			[ELegionRedTab.Gain] = tolua.cast(var_5_4:getChildByTag(2), "CCControlButton")
		}

		arg_3_0.notifyGain = var_5_0(var_5_6[ELegionRedTab.Gain])

		local var_5_7 = {
			[ELegionRedTab.Send] = "image/tab/tab_legionRed_send.png",
			[ELegionRedTab.Gain] = "image/tab/tab_legionRed_rob.png"
		}
		local var_5_8 = {
			[ELegionRedTab.Send] = tolua.cast(var_5_3:getChildByTag(1), "CCLayer"),
			[ELegionRedTab.Gain] = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		}

		arg_3_0.module = {}
		arg_3_0.module[ELegionRedTab.Send] = createLegionRedSend(var_5_8[ELegionRedTab.Send], var_5_6[ELegionRedTab.Send], arg_3_0)
		arg_3_0.module[ELegionRedTab.Gain] = createLegionRedGain(var_5_8[ELegionRedTab.Gain], var_5_6[ELegionRedTab.Gain], arg_3_0)

		arg_3_0:initTab(var_5_6, var_5_8, var_5_7)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onLegionHongbaoAck()
	end, zbGameEvent.Event_LegionHongbao_Ack)
end

function var_0_0.refresh(arg_11_0)
	arg_11_0.notifyGain:setVisible(g_Self.kLegionHandler:hasNotifyHongbao())
end

function var_0_0.onShowCallback(arg_12_0)
	arg_12_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_13_0)
	if arg_13_0.module[arg_13_0.currTab] then
		if arg_13_0.currTab == ELegionRedTab.Send then
			arg_13_0.module[arg_13_0.currTab]:refresh()
			arg_13_0.lbCount:setString(a2u("\xB7\xA2\xBA\xEC\xB0\xFCʣ\xD3\xE0\xB4\xCE\xCA\xFD\xA3\xBA") .. g_GameData.LegionInfo.Hongbao.SendMax - g_GameData.LegionInfo.Hongbao.SendCount .. "/" .. g_GameData.LegionInfo.Hongbao.SendMax)
		else
			g_WsMsgHandler:WS_LegionGame_GetHongbao_Req()
			arg_13_0.lbCount:setString(a2u("\xC7\xC0\xBA\xEC\xB0\xFCʣ\xD3\xE0\xB4\xCE\xCA\xFD\xA3\xBA") .. g_GameData.LegionInfo.Hongbao.GainMax - g_GameData.LegionInfo.Hongbao.GainCount .. "/" .. g_GameData.LegionInfo.Hongbao.GainMax)
		end

		arg_13_0:performAnimationSay(var_0_1[arg_13_0.currTab])
	end
end

function var_0_0.onLegionHongbaoAck(arg_14_0)
	if arg_14_0.module[arg_14_0.currTab] then
		arg_14_0.module[arg_14_0.currTab]:refresh()

		if arg_14_0.currTab == ELegionRedTab.Send then
			arg_14_0.lbCount:setString(a2u("\xB7\xA2\xBA\xEC\xB0\xFCʣ\xD3\xE0\xB4\xCE\xCA\xFD\xA3\xBA") .. g_GameData.LegionInfo.Hongbao.SendMax - g_GameData.LegionInfo.Hongbao.SendCount .. "/" .. g_GameData.LegionInfo.Hongbao.SendMax)
		else
			arg_14_0.lbCount:setString(a2u("\xC7\xC0\xBA\xEC\xB0\xFCʣ\xD3\xE0\xB4\xCE\xCA\xFD\xA3\xBA") .. g_GameData.LegionInfo.Hongbao.GainMax - g_GameData.LegionInfo.Hongbao.GainCount .. "/" .. g_GameData.LegionInfo.Hongbao.GainMax)
		end
	end

	arg_14_0.notifyGain:setVisible(g_Self.kLegionHandler:hasNotifyHongbao())
end

function var_0_0.onFrameUpdate(arg_15_0)
	arg_15_0:updateBackEffect()

	if arg_15_0.currTab == ELegionRedTab.Gain then
		arg_15_0.module[arg_15_0.currTab]:onFrame()
	end
end

function var_0_0.onAvatar(arg_16_0)
	arg_16_0:performAnimationSay(var_0_1[arg_16_0.currTab])
end

function var_0_0.performAnimationSay(arg_17_0, arg_17_1)
	local var_17_0 = CCArray:create()

	var_17_0:addObject(CCCallFuncN:create(function()
		arg_17_0.spriteTalk:setVisible(true)
		arg_17_0.lbTalk:setString(a2u(arg_17_1))
		arg_17_0.btnAvatar:setEnabled(false)
	end))
	var_17_0:addObject(CCDelayTime:create(3))
	var_17_0:addObject(CCCallFuncN:create(function()
		arg_17_0.spriteTalk:setVisible(false)
		arg_17_0.btnAvatar:setEnabled(true)
	end))

	local var_17_1 = CCSequence:create(var_17_0)

	arg_17_0.btnAvatar:stopAllActions()
	arg_17_0.btnAvatar:runAction(var_17_1)
end
