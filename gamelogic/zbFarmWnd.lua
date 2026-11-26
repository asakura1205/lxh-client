require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbFarmWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createFarmWnd()
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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/farm.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.nodeNormal = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.spriteDesc = tolua.cast(arg_3_0.nodeNormal:getChildByTag(2), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteDesc:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc1 = tolua.cast(arg_3_0.spriteDesc:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbDesc2 = tolua.cast(arg_3_0.spriteDesc:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		arg_3_0.cutDownNode = tolua.cast(arg_3_0.nodeNormal:getChildByTag(3), "CCNode")
		arg_3_0.nn_lbCountdown = tolua.cast(arg_3_0.cutDownNode:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteOutputIcon = tolua.cast(arg_3_0.nodeNormal:getChildByTag(4), "CCSprite")
		arg_3_0.nl_lbOutputPerHour = tolua.cast(arg_3_0.spriteOutputIcon:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nl_lbOutputAdd = tolua.cast(arg_3_0.spriteOutputIcon:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spriteCapacityIcon = tolua.cast(arg_3_0.nodeNormal:getChildByTag(5), "CCSprite")
		arg_3_0.nn_lbCapacity = tolua.cast(arg_3_0.spriteCapacityIcon:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nl_lbCapacityAdd = tolua.cast(arg_3_0.spriteCapacityIcon:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.miLevelUp = tolua.cast(arg_3_0.nodeNormal:getChildByTag(11), "CCControlButton")
		arg_3_0.miSpeed = tolua.cast(arg_3_0.nodeNormal:getChildByTag(12), "CCControlButton")
		arg_3_0.miLevySilver = tolua.cast(arg_3_0.nodeNormal:getChildByTag(13), "CCControlButton")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeNormal:getChildByTag(14), "CCSprite")
		arg_3_0.lbMoney = tolua.cast(arg_3_0.nodeNormal:getChildByTag(15), "CCLabelTTF")

		arg_3_0.miLevelUp:addHandleOfControlEvent(function()
			arg_3_0:onLevelUp()
		end, CCControlEventTouchUpInside)
		arg_3_0.miSpeed:addHandleOfControlEvent(function()
			arg_3_0:onMenuSpeed()
		end, CCControlEventTouchUpInside)
		arg_3_0.miLevySilver:addHandleOfControlEvent(function()
			arg_3_0:onMenuLevySilver()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onLevelUpAck()
	end, zbGameEvent.Event_FarmUpgrade_Ack)
end

function var_0_0.refresh(arg_12_0)
	arg_12_0.level = g_Self.kFarmHandler:getLevel()

	arg_12_0.lbLevel:setString(arg_12_0.level)

	local var_12_0, var_12_1, var_12_2 = zbBuildingUpgradeTable:getIncome(arg_12_0.level)
	local var_12_3 = g_Self.kFarmHandler:getCurLevyTime() / 60
	local var_12_4 = var_12_0 * 24

	arg_12_0.nl_lbOutputPerHour:setString(a2u("\xB2\xFA\xC1\xBF:") .. var_12_4 .. a2u("/\xCC\xEC"))

	local var_12_5, var_12_6, var_12_7 = zbBuildingUpgradeTable:getIncome(arg_12_0.level + 1)
	local var_12_8 = (var_12_5 - var_12_0) * 24
	local var_12_9 = var_12_5 * 24

	arg_12_0.nl_lbOutputAdd:setString(a2u("(\xCF\xC2һ\xB5ȼ\xB6:") .. var_12_9 .. a2u(")"))

	local var_12_10 = var_12_6 - var_12_1
	local var_12_11 = var_12_6

	arg_12_0.nl_lbCapacityAdd:setString(a2u("(\xCF\xC2һ\xB5ȼ\xB6:") .. var_12_11 .. a2u(")"))

	local var_12_12 = math.round(var_12_0 / 60 * var_12_3)

	arg_12_0.nn_lbCapacity:setString(a2u("\xD7\xEE\xB4\xF3\xC8\xDD\xC1\xBF:") .. var_12_12 .. " /" .. var_12_1)

	if g_Self.kFarmHandler:isUpgrading() then
		local var_12_13 = g_Self.kFarmHandler:getImmCompleteGold()

		if var_12_13 < 10 then
			var_12_13 = 10
		end

		arg_12_0.lbMoney:setString(var_12_13)
		arg_12_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_diamond.png"))
	else
		local var_12_14 = g_Self.kFarmHandler:getUpgradeCost()

		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_12_14) == true then
			arg_12_0.lbMoney:setColor(ccc3(255, 245, 160))
		else
			arg_12_0.lbMoney:setColor(ccc3(255, 0, 0))
		end

		arg_12_0.lbMoney:setString(var_12_14)
		arg_12_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_gold.png"))
	end

	arg_12_0:onFrameUpdate(0)
end

function var_0_0.onFrameUpdate(arg_13_0, arg_13_1)
	local var_13_0 = g_Self.kFarmHandler:isUpgrading()

	arg_13_0.spriteDesc:setVisible(var_13_0 == false)
	arg_13_0.miLevelUp:setVisible(var_13_0 == false)
	arg_13_0.cutDownNode:setVisible(var_13_0)
	arg_13_0.miSpeed:setVisible(var_13_0)

	if var_13_0 and (arg_13_1 == 0 or g_GameStateMachine:isOneSecondPassed()) then
		arg_13_0.nn_lbCountdown:setString(zbUtil:SprintfHHMMSSNo24(g_Self.kFarmHandler:getNeedTime()))
	end
end

function var_0_0.onLevelUp(arg_14_0)
	if arg_14_0.level >= g_Self:getLevel() then
		g_Bubble:bubbleInfo(a2u("\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xCD\xE6\xBCҵĵȼ\xB6"))

		return
	end

	g_WsMsgHandler:WS_Building_Upgrade_Req()
end

function var_0_0.onLevelUpAck(arg_15_0)
	arg_15_0:hide()
end

function var_0_0.onMenuSpeed(arg_16_0)
	local var_16_0 = g_Self.kFarmHandler:getImmCompleteGold()

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_16_0) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_Building_ImmComplete_Req()
end

function var_0_0.onMenuLevySilver(arg_17_0)
	if g_Self.kFarmHandler:getCurLevyTime() > 10 then
		g_WsMsgHandler:WS_Building_Income_Req()
	else
		g_Bubble:bubbleInfo(a2u("\xB9\xA4\xC8\xCB\xC3\xC7\xD5\xFD\xD4\xDAŬ\xC1\xA6\xB5ĸ\xFB\xD4\xC5\xD6У\xAC\xC7\xEB\xC9Ժ\xF3\xCA\xD5ȡ"))
	end
end

function var_0_0.getOutputPerHour(arg_18_0, arg_18_1)
	local var_18_0 = zbTechTable:getRecord(arg_18_1)
	local var_18_1 = g_Self.kTechHandler:getStudyedTech(arg_18_1)

	if var_18_1 then
		return (var_18_1.Level * var_18_0.attrGrowth1 + var_18_0.attrBase1) * 60 * 24
	end

	return 0
end

function var_0_0.onTouchTest(arg_19_0)
	local var_19_0 = arg_19_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_19_0.layer, var_19_0.x, var_19_0.y) == false and zbUtil:PointInCtrl(arg_19_0.btnClose, var_19_0.x, var_19_0.y) == false then
		arg_19_0:hide()
	end
end
