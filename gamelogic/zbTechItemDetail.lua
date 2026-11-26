require("gamecore.zbAwardHelper")

local var_0_0 = class("zbTechItemDetail")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.id = -1
		arg_1_0.canUp = false
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.spriteIcon = tolua.cast(arg_1_1:getChildByTag(1), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbUnLock = tolua.cast(arg_1_1:getChildByTag(13), "CCLabelTTF")
		arg_1_0.spriteLevel = tolua.cast(arg_1_1:getChildByTag(3), "CCSprite")
		arg_1_0.lbLevelDummy = tolua.cast(arg_1_0.spriteLevel:getChildByTag(1003), "CCLabelTTF")
		arg_1_0.lbTotalGain = tolua.cast(arg_1_1:getChildByTag(4), "CCLabelTTF")
		arg_1_0.lbInfoDes = tolua.cast(arg_1_1:getChildByTag(1005), "CCLabelTTF")
		arg_1_0.lbOneLevelGain = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.lbPrice = tolua.cast(arg_1_1:getChildByTag(7), "CCLabelTTF")
		arg_1_0.btnUp = tolua.cast(arg_1_1:getChildByTag(8), "CCControlButton")
		arg_1_0.lbLevelLimit = tolua.cast(arg_1_1:getChildByTag(9), "CCLabelTTF")
		arg_1_0.btnFastUp = tolua.cast(arg_1_1:getChildByTag(10), "CCControlButton")
		arg_1_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbLevelDummy, arg_1_0.lbLevel)
		arg_1_0.lbLevel:setScale(0.5)
		arg_1_0.btnUp:addHandleOfControlEvent(function()
			arg_1_0:onLevelUp()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnFastUp:addHandleOfControlEvent(function()
			arg_1_0:onFastLevelUp()
		end, CCControlEventTouchUpInside)
		arg_1_0:refresh(1001)
	end

	var_1_0()
	var_1_1()
end

function var_0_0.forceRefresh(arg_6_0)
	arg_6_0:refresh(arg_6_0.id)
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1

	local var_7_0 = zbTechTable:getRecord(arg_7_1)
	local var_7_1 = g_Self:getLevel()

	arg_7_0.lbLevelLimit:setVisible(true)
	arg_7_0.lbPrice:setVisible(true)
	arg_7_0.btnUp:setVisible(true)
	arg_7_0.lbName:setString(var_7_0.name)

	local var_7_2 = zbIconHelper:getTechIconPath(arg_7_1)

	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_2))
	arg_7_0.lbOneLevelGain:setString(var_7_0.description)
	arg_7_0.lbInfoDes:setString(var_7_0.history)
	arg_7_0.lbUnLock:setVisible(true)
	arg_7_0.spriteLevel:setVisible(false)

	local var_7_3 = g_Self.kTechHandler:getStudyedTech(arg_7_1)

	if var_7_3 then
		local var_7_4 = 1

		if var_7_1 >= var_7_0.unlockLvl and var_7_3.Level < var_7_0.maxLvl then
			if var_7_0.upInterval > 1 then
				var_7_4 = var_7_3.Level * var_7_0.upInterval + var_7_0.unlockLvl
			else
				var_7_4 = var_7_3.Level + 1
			end
		else
			var_7_4 = var_7_0.unlockLvl
		end

		arg_7_0.lbLevelLimit:setString(a2u("需要: 角色" .. var_7_4 .. "级"))
		arg_7_0.lbLevel:setString(var_7_3.Level)
		arg_7_0.lbUnLock:setVisible(false)
		arg_7_0.spriteLevel:setVisible(true)

		if var_7_1 < var_7_4 then
			arg_7_0.lbLevelLimit:setColor(display.COLOR_RED)
			arg_7_0.lbLevelLimit:setVisible(true)
		else
			arg_7_0.lbLevelLimit:setVisible(false)
		end

		if var_7_3.Level >= var_7_0.maxLvl then
			arg_7_0.lbLevelLimit:setVisible(false)
			arg_7_0.lbPrice:setVisible(false)
			arg_7_0.btnUp:setVisible(false)
		end

		if var_7_0.attrType1 ~= 0 then
			local var_7_5 = var_7_3.Level * var_7_0.attrGrowth1 + var_7_0.attrBase1
			local var_7_6 = getItemPropStr(var_7_0.attrType1)

			if var_7_0.type ~= ETechType.Func then
				var_7_6 = var_7_6 .. " +" .. var_7_5

				if arg_7_1 == 4001 then
					var_7_6 = "提供自身战斗力的" .. " +" .. var_7_5 * 100 .. "%" .. "作为攻击加成"
				elseif arg_7_1 == 4002 then
					var_7_6 = "提供自身战斗力的" .. " +" .. var_7_5 * 100 .. "%" .. "作为防御加成"
				elseif arg_7_1 == 4003 then
					var_7_6 = "提供自身战斗力的" .. " +" .. var_7_5 * 100 .. "%" .. "作为血量加成"
				end
			else
				var_7_6 = "粮食产量 +" .. var_7_5 .. "/分钟"
			end

			if var_7_0.attrType2 ~= 0 then
				local var_7_7 = var_7_3.Level * var_7_0.attrGrowth2 + var_7_0.attrBase2
				local var_7_8 = getItemPropStr(var_7_0.attrType2)

				if var_7_0.type ~= ETechType.Func then
					var_7_6 = var_7_6 .. " " .. var_7_8 .. " +" .. var_7_7
				else
					var_7_6 = var_7_6 .. " 粮食产量 +" .. var_7_5 .. "/分钟"
				end
			end

			arg_7_0.lbTotalGain:setString(a2u(var_7_6))
			arg_7_0.lbTotalGain:setVisible(true)
		else
			arg_7_0.lbTotalGain:setVisible(false)
		end
	else
		arg_7_0.lbTotalGain:setVisible(false)

		local var_7_9 = var_7_0.unlockLvl

		arg_7_0.lbLevelLimit:setString(a2u("需要: 角色" .. var_7_9 .. "级"))
		arg_7_0.lbLevelLimit:setColor(display.COLOR_RED)
		arg_7_0.lbLevelLimit:setVisible(true)
	end

	local var_7_10 = 0

	if var_7_3 then
		var_7_10 = zbTechUpgradeTable:getTechUpgradeCost(var_7_0.id, var_7_3.Level)
	end

	arg_7_0.techLevel = var_7_3

	arg_7_0.lbPrice:setString(var_7_10)
	arg_7_0.lbPrice:setColor(var_7_10 <= g_GameData.Wealth.Food and display.COLOR_WHITE or display.COLOR_RED)

	arg_7_0.canUp = g_Self.kTechHandler:canUpgrade(arg_7_1)

	arg_7_0.btnUp:setEnabled(arg_7_0.canUp == true)
	arg_7_0.btnUp:setGray(arg_7_0.canUp == false)
	arg_7_0.btnFastUp:setEnabled(arg_7_0.btnUp:isEnabled())
	arg_7_0.btnFastUp:setGray(arg_7_0.btnUp:isGray())
	arg_7_0.btnFastUp:setVisible(arg_7_0.btnUp:isVisible())
end

function var_0_0.freshColor(arg_8_0)
	if arg_8_0.techLevel then
		local var_8_0 = zbTechTable:getRecord(arg_8_0.id)
		local var_8_1 = zbTechUpgradeTable:getTechUpgradeCost(var_8_0.id, arg_8_0.techLevel.Level)
		local var_8_2 = 0

		arg_8_0.lbPrice:setColor(var_8_2 <= g_GameData.Wealth.Food and display.COLOR_WHITE or display.COLOR_RED)
	end
end

function var_0_0.onLevelUp(arg_9_0)
	local var_9_0 = zbTechTable:getRecord(arg_9_0.id)

	if var_9_0 == nil then
		g_Bubble:bubbleInfo(a2u("君阁数据配置异常"))

		return
	end

	if arg_9_0.canUp == false then
		g_Bubble:bubbleInfo(a2u("角色等級不足"))

		return
	end

	local var_9_1 = g_Self.kTechHandler:getStudyedTechLevel(arg_9_0.id)
	local var_9_2 = zbTechUpgradeTable:getTechUpgradeCost(var_9_0.id, var_9_1)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, var_9_2) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Food)

		return
	end

	if arg_9_0.id == 3001 then
		g_Self.kWorldHandler.needRefreshOpenDlg = true
	end

	g_WsMsgHandler:WS_Tech_Upgrade_Req(arg_9_0.id)
end

function var_0_0.onFastLevelUp(arg_10_0)
	local var_10_0 = zbTechTable:getRecord(arg_10_0.id)

	if var_10_0 == nil then
		g_Bubble:bubbleInfo("君阁数据配置异常")

		return
	end

	if arg_10_0.canUp == false then
		g_Bubble:bubbleInfo("玩家等級不足")

		return
	end

	local var_10_1 = g_Self.kTechHandler:getStudyedTechLevel(arg_10_0.id)
	local var_10_2, var_10_3 = zbTechUpgradeTable:getTechMaxUpgradeCost(var_10_0.id, var_10_1)

	if var_10_0.upInterval > 1 then
		var_10_3 = var_10_3 + 1
	end

	local var_10_4 = zbTechUpgradeTable:getTechUpgradeCost(var_10_0.id, var_10_1)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, var_10_4) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Food)

		return
	end

	local function var_10_5()
		if arg_10_0.id == 3001 then
			g_Self.kWorldHandler.needRefreshOpenDlg = true
		end

		g_WsMsgHandler:WS_Tech_FastUpgrade_Req(arg_10_0.id)
	end

	local var_10_6 = a2u(string.format("确定花费%d猫饭升级到%d级吗？", var_10_2, var_10_3))

	g_MessageBox:showYesNo(var_10_6, var_10_5)
end

function createTechItemDetail(arg_12_0)
	local var_12_0 = var_0_0.new()

	var_12_0:init(arg_12_0)

	return var_12_0
end
