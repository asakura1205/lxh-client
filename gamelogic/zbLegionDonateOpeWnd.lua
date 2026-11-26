require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionDonateOpeWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionDonateOpeWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.legionDetail = nil
		arg_3_0.lefttimes = 0
		arg_3_0.goldLimit = false
		arg_3_0.dimondLimit = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legiondonate_one.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.touchLayer = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.legionIcon = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.legionName = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")
		arg_3_0.legionlv = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
		arg_3_0.spriteBarBg = tolua.cast(var_5_3:getChildByTag(4), "CCSprite")

		local function var_5_4(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(0)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBar = var_5_4(arg_3_0.spriteBarBg, "image/legion/donate/progress_green2.png")
		arg_3_0.lblexp = tolua.cast(var_5_3:getChildByTag(5), "CCLabelTTF")
		arg_3_0.donatetimes = tolua.cast(var_5_3:getChildByTag(6), "CCLabelTTF")
		arg_3_0.expadd1 = tolua.cast(var_5_3:getChildByTag(7), "CCLabelTTF")
		arg_3_0.expadd2 = tolua.cast(var_5_3:getChildByTag(9), "CCLabelTTF")
		arg_3_0.cost1 = tolua.cast(var_5_3:getChildByTag(8), "CCLabelTTF")
		arg_3_0.cost2 = tolua.cast(var_5_3:getChildByTag(10), "CCLabelTTF")
		arg_3_0.lbLegion1 = tolua.cast(var_5_3:getChildByTag(13), "CCLabelTTF")
		arg_3_0.lbLegion2 = tolua.cast(var_5_3:getChildByTag(14), "CCLabelTTF")
		arg_3_0.btnDonateGold = tolua.cast(var_5_3:getChildByTag(11), "CCControlButton")

		arg_3_0.btnDonateGold:addHandleOfControlEvent(function()
			arg_3_0:onDonate(1)
		end, CCControlEventTouchDown)

		arg_3_0.btnDonateDiamond = tolua.cast(var_5_3:getChildByTag(12), "CCControlButton")

		arg_3_0.btnDonateDiamond:addHandleOfControlEvent(function()
			arg_3_0:onDonate(2)
		end, CCControlEventTouchDown)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.refresh(arg_13_0)
	arg_13_0.legionDetail = g_Self.kLegionHandler.legionDetail

	if arg_13_0.legionDetail then
		local var_13_0 = zbIconHelper:getLegionIconPath(arg_13_0.legionDetail.LegionBaseInfo.IconId)

		arg_13_0.legionIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_0))
		arg_13_0.legionName:setString(a2u(arg_13_0.legionDetail.LegionBaseInfo.LegionName))
		zbLegionHelp:setLegionLvTexture(arg_13_0.legionlv, arg_13_0.legionDetail.LegionBaseInfo.Level)

		local var_13_1 = zbLegionHelp:getLegionMaxExp(arg_13_0.legionDetail.LegionBaseInfo.Level)
		local var_13_2 = g_Self.kLegionHandler:getTechExp(ELegionTechType.Legion)
		local var_13_3 = math.min(math.ceil(100 * (var_13_2 / var_13_1)), 100)

		arg_13_0.spriteBar:setPercentage(var_13_3)
		arg_13_0.lblexp:setString(var_13_2 .. "/" .. var_13_1)

		arg_13_0.lefttimes = math.max(g_GameData.LegionInfo.MaxDonate - g_GameData.LegionInfo.DailyDonate, 0)

		arg_13_0.donatetimes:setString(a2u("\xBD\xF1\xC8տ\xC9Ͷ\xD7ʴ\xCE\xCA\xFD:") .. arg_13_0.lefttimes .. "/" .. g_GameData.LegionInfo.MaxDonate)

		local var_13_4 = g_DataConfig.m_kLegionBaseCfg

		arg_13_0.expadd1:setString("+" .. var_13_4.donate.gold.exp)
		arg_13_0.expadd2:setString("+" .. var_13_4.donate.diamond.exp)
		arg_13_0.cost1:setString(var_13_4.donate.gold.cost)
		arg_13_0.cost2:setString(var_13_4.donate.diamond.cost)
		arg_13_0.lbLegion1:setString(var_13_4.donate.gold.legionMoney)
		arg_13_0.lbLegion2:setString(var_13_4.donate.diamond.legionMoney)

		arg_13_0.goldLimit = var_13_4.donate.gold.cost > g_GameData.Wealth.Gold
		arg_13_0.dimondLimit = var_13_4.donate.diamond.cost > g_GameData.Wealth.Diamond
	end
end

function var_0_0.onDonate(arg_14_0, arg_14_1)
	if arg_14_0.lefttimes <= 0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5Ͷ\xD7ʴ\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	if arg_14_0.goldLimit and arg_14_1 == 1 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	if arg_14_0.dimondLimit and arg_14_1 == 2 then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	if arg_14_0.legionDetail.DonateBaseInfo.MaxDonate <= arg_14_0.legionDetail.DonateBaseInfo.DailyDonate then
		local function var_14_0()
			g_WsMsgHandler:WS_Legion_Donate_Req(ELegionTechType.Legion, arg_14_1)
		end

		local var_14_1 = a2u("\xBB\xE1\xB9ݽ\xF1\xC8վ\xE8\xCF\xD7\xD2Ѿ\xAD\xB4ﵽ\xC9\xCF\xCF\xDE,\xBC\xCC\xD0\xF8\xBE\xE8\xCF\xD7ֻ\xC4ܻ\xF1\xB5û\xE1\xB9ݹ\xB1\xCF\xD7,\xB2\xBB\xBB\xF1\xB5\xC3\xC8κξ\xAD\xD1\xE9ֵ,ȷ\xB6\xA8Ҫ\xBE\xE8\xCF\xD7\xC2\xF0\xA3\xBF")

		g_MessageBox:showYesNo(var_14_1, var_14_0)
	else
		g_WsMsgHandler:WS_Legion_Donate_Req(ELegionTechType.Legion, arg_14_1)
	end
end

function var_0_0.onTouchTest(arg_16_0)
	local var_16_0 = arg_16_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_16_0.touchLayer, var_16_0.x, var_16_0.y) == false then
		arg_16_0:hide()
	end
end
