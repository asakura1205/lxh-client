require("gamelogic.zbItem")

local var_0_0 = class("zbLevelWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLevelWnd()
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
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.isGeneral = false
		arg_3_0.awardItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/level.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteType = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")
		arg_3_0.spriteStars = {}
		arg_3_0.spriteStars[1] = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.spriteStars[2] = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.spriteStars[3] = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.centerPositionX = arg_3_0.spriteStars[2]:getPositionX()

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_4 = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setScale(0.85)
			var_5_3:addChild(var_5_5)
			var_5_4:removeFromParentAndCleanup(true)

			arg_3_0.awardItems[iter_5_0] = var_5_5
		end

		arg_3_0.lbRoleExp = tolua.cast(var_5_3:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbHeroExp = tolua.cast(var_5_3:getChildByTag(12), "CCLabelTTF")
		arg_3_0.lbSkillPoint = tolua.cast(var_5_3:getChildByTag(13), "CCLabelTTF")
		arg_3_0.lbLevelName = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbDesc1 = tolua.cast(var_5_2:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.lbDesc2 = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.iconTili = tolua.cast(var_5_2:getChildByTag(101), "CCSprite")
		arg_3_0.lbTiliNeed = tolua.cast(var_5_2:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lbFightCount = tolua.cast(var_5_2:getChildByTag(1009), "CCLabelTTF")
		arg_3_0.btnAttack = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnSweep = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.btnBatchSweep = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.btnResetBuy = tolua.cast(var_5_2:getChildByTag(14), "CCControlButton")
		arg_3_0.lbVipTip = tolua.cast(var_5_2:getChildByTag(15), "CCLabelTTF")
		arg_3_0.lbResetCount = tolua.cast(var_5_2:getChildByTag(1016), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnAttack:addHandleOfControlEvent(function()
			arg_3_0:onAttack()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSweep:addHandleOfControlEvent(function()
			arg_3_0:onSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBatchSweep:addHandleOfControlEvent(function()
			arg_3_0:onBatchSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnResetBuy:addHandleOfControlEvent(function()
			arg_3_0:onResetEliteLevel()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

		arg_3_0.pointAttack = ccp(arg_3_0.btnAttack:getPosition())
		arg_3_0.pointSweep = ccp(arg_3_0.btnBatchSweep:getPosition())
		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onResetEliteLevelAck()
	end, zbGameEvent.Event_ResetEliteLevel_Ack)
end

function var_0_0.refresh(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local function var_13_0()
		local var_14_0 = tonumber(string.format("%d%.4d", arg_13_2, 0))

		return (arg_13_3 - var_14_0) % 3 == 0
	end

	arg_13_0.levelType = arg_13_1
	arg_13_0.forceId = arg_13_2
	arg_13_0.levelId = arg_13_3
	arg_13_0.isGeneral = var_13_0()

	arg_13_0.spriteType:setVisible(true)

	local var_13_1 = arg_13_3 - tonumber(string.format("%d%.4d", arg_13_2, 0))
	local var_13_2, var_13_3, var_13_4 = zbForceSetTable:getNeedStarCount(arg_13_1, arg_13_2)

	if arg_13_0.isGeneral == false then
		arg_13_0.spriteType:setVisible(false)
	elseif var_13_1 == var_13_4 then
		arg_13_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/level/level_enemyType2.png"))
	else
		arg_13_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/level/level_enemyType1.png"))
	end

	local var_13_5 = zbForceSetTable:getRecord(arg_13_0.levelId)

	arg_13_0.lbLevelName:setString(var_13_5.name)
	arg_13_0.lbDesc1:setString(var_13_5.desc1)
	arg_13_0.lbDesc2:setString(var_13_5.desc2)

	local var_13_6 = g_Self.kWarPathHandler:getLevelStar(arg_13_0.levelType, arg_13_0.forceId, arg_13_0.levelId)

	for iter_13_0 = 1, 3 do
		arg_13_0.spriteStars[iter_13_0]:setVisible(iter_13_0 <= var_13_6)
	end

	zbUIEffect:centerStar(arg_13_0.spriteStars, arg_13_0.centerPositionX)
	arg_13_0.lbTiliNeed:setString(arg_13_0:getNeedTili())
	arg_13_0.btnAttack:setPosition(arg_13_0.pointSweep)
	arg_13_0:updateSweep()

	for iter_13_1, iter_13_2 in pairs(arg_13_0.awardItems) do
		iter_13_2:setVisible(false)
	end

	local var_13_7 = g_Self.kGmActivityHandler:getGmActivityDoubleDrop(arg_13_1)
	local var_13_8 = 1
	local var_13_9, var_13_10, var_13_11 = zbForceSetTable:getLevelAwardItems(arg_13_0.levelId, arg_13_0.levelType)

	for iter_13_3 = 1, #var_13_9 do
		local var_13_12 = var_13_9[iter_13_3]
		local var_13_13 = arg_13_0.awardItems[iter_13_3]

		if var_13_13 ~= nil then
			var_13_13:refreshAward(var_13_12.awardType, var_13_12.awardId, var_13_12.awardCount)
			var_13_13:setVisible(true)
		end

		var_13_8 = iter_13_3
	end

	if var_13_8 < 6 then
		var_13_8 = var_13_8 + 1
	end

	if var_13_8 < 6 then
		local var_13_14 = var_13_8 + 1
	end

	if arg_13_0.levelType == ELevelType.Normal then
		arg_13_0.lbRoleExp:setString("+" .. var_13_5.roleExpNormal)
		arg_13_0.lbHeroExp:setString("+" .. var_13_5.awardGoldNormal)
		arg_13_0.lbSkillPoint:setString("+" .. var_13_5.heroSPNormal)
	elseif arg_13_0.levelType == ELevelType.Elite then
		arg_13_0.lbRoleExp:setString("+" .. var_13_5.roleExpElite)
		arg_13_0.lbHeroExp:setString("+" .. var_13_5.awardGoldElite)
		arg_13_0.lbSkillPoint:setString("+" .. var_13_5.heroSPElite)
	elseif arg_13_0.levelType == ELevelType.Nightmare then
		arg_13_0.lbRoleExp:setString("+" .. var_13_5.roleExpware)
		arg_13_0.lbHeroExp:setString("+" .. var_13_5.awardGoldware)
		arg_13_0.lbSkillPoint:setString("+" .. var_13_5.heroSPware)
	end
end

function var_0_0.updateSweep(arg_15_0)
	arg_15_0.btnSweep:setVisible(false)
	arg_15_0.btnBatchSweep:setVisible(false)
	arg_15_0.lbVipTip:setVisible(false)
	arg_15_0.btnResetBuy:setVisible(false)
	arg_15_0.lbResetCount:setVisible(false)
	arg_15_0.btnAttack:setVisible(true)
	arg_15_0.lbFightCount:setVisible(arg_15_0.levelType ~= ELevelType.Normal)

	if arg_15_0.isGeneral == false then
		return
	end

	local var_15_0 = g_Self.kWarPathHandler:getLevelInfo(arg_15_0.levelType, arg_15_0.forceId, arg_15_0.levelId)

	if var_15_0 == nil or var_15_0.StarCount < 3 then
		local var_15_1 = zbForceTable:getRecord(arg_15_0.forceId)

		if arg_15_0.levelType == ELevelType.Elite then
			if var_15_0 ~= nil then
				arg_15_0.lbFightCount:setString(a2u(string.format("\xBD\xF1\xC8տ\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:%d/%d", var_15_1.eliteMaxFight - var_15_0.FightCount, var_15_1.eliteMaxFight)))
				arg_15_0.btnAttack:setVisible(var_15_0.FightCount < var_15_1.eliteMaxFight)
				arg_15_0.btnResetBuy:setVisible(var_15_0.FightCount >= var_15_1.eliteMaxFight)
			else
				arg_15_0.lbFightCount:setString(a2u("\xBD\xF1\xC8տ\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:3/3"))
			end
		end

		if arg_15_0.levelType == ELevelType.Nightmare then
			if var_15_0 ~= nil then
				arg_15_0.lbFightCount:setString(a2u(string.format("\xBD\xF1\xC8տ\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:%d/%d", var_15_1.nightmareMaxFight - var_15_0.FightCount, var_15_1.nightmareMaxFight)))
				arg_15_0.btnAttack:setVisible(var_15_0.FightCount < var_15_1.nightmareMaxFight)
				arg_15_0.btnResetBuy:setVisible(var_15_0.FightCount >= var_15_1.nightmareMaxFight)
			else
				arg_15_0.lbFightCount:setString(a2u("\xBD\xF1\xC8տ\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:1/1"))
			end
		end

		return
	end

	arg_15_0.lbVipTip:setVisible(g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, 2) == false or g_Self:getVipLevel() < zbVipTable.minlevelSweepOpenlv)

	if g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, 2) == true and g_Self:getVipLevel() >= zbVipTable.minlevelSweepOpenlv then
		arg_15_0.btnBatchSweep:setGray(false)
		arg_15_0.btnBatchSweep:setEnabled(true)
	else
		arg_15_0.btnBatchSweep:setGray(true)
		arg_15_0.btnBatchSweep:setEnabled(false)

		if g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, 2) == true then
			arg_15_0.lbVipTip:setString(a2u("\xA1\xBEVip") .. zbVipTable.minlevelSweepOpenlv .. a2u("\xBD\xE2\xCB\xF8ɨ\xB5\xB410\xB4Ρ\xBF"))
		else
			arg_15_0.lbVipTip:setString(a2u("\xA1\xBEͨ\xB9\xFD\xB5ڶ\xFE\xD5½\xE2\xCB\xF8ɨ\xB5\xB410\xB4Ρ\xBF"))
		end
	end

	if g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, 2) == true or g_Self:getVipLevel() >= zbVipTable.minlevelSweepOpenlv then
		arg_15_0.btnSweep:setGray(false)
		arg_15_0.btnSweep:setEnabled(true)
	else
		arg_15_0.btnSweep:setGray(true)
		arg_15_0.btnSweep:setEnabled(false)
		arg_15_0.lbVipTip:setString(a2u("\xA1\xBE\xCD\xE6\xBC\xD2ͨ\xB9\xFD\xB5ڶ\xFE\xD5»\xF2Vip") .. zbVipTable.minlevelSweepOpenlv .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8ɨ\xB5\xB4\xA1\xBF"))
	end

	arg_15_0.btnAttack:setPosition(arg_15_0.pointAttack)

	if arg_15_0.levelType == ELevelType.Normal then
		arg_15_0.btnSweep:setVisible(true)
		arg_15_0.btnBatchSweep:setVisible(true)
		arg_15_0.lbFightCount:setVisible(false)
		zbUtil:setButtonTitle(arg_15_0.btnBatchSweep, a2u("ɨ\xB5\xB410\xB4\xCE"))
	else
		local var_15_2 = 0
		local var_15_3 = zbForceTable:getRecord(arg_15_0.forceId)

		if arg_15_0.levelType == ELevelType.Elite then
			var_15_2 = var_15_3.eliteMaxFight
		else
			var_15_2 = var_15_3.nightmareMaxFight
		end

		if g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, 2) == false or g_Self:getVipLevel() < zbVipTable.minlevelSweepOpenlv then
			arg_15_0.lbVipTip:setVisible(var_15_2 > var_15_0.FightCount)
			arg_15_0.lbVipTip:setString(a2u("\xA1\xBE\xCD\xE6\xBC\xD2ͨ\xB9\xFD\xB5ڶ\xFE\xD5»\xF2Vip") .. zbVipTable.minlevelSweepOpenlv .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8ɨ\xB5\xB4\xA1\xBF"))
		end

		arg_15_0.btnSweep:setVisible(var_15_2 > var_15_0.FightCount)

		if arg_15_0.levelType == ELevelType.Nightmare then
			arg_15_0.btnBatchSweep:setVisible(false)
			arg_15_0.btnSweep:setVisible(false)
			arg_15_0.lbVipTip:setVisible(false)
			arg_15_0.btnAttack:setPosition(arg_15_0.pointSweep)
		else
			arg_15_0.btnBatchSweep:setVisible(var_15_2 > var_15_0.FightCount)
		end

		arg_15_0.btnAttack:setVisible(var_15_2 > var_15_0.FightCount)
		arg_15_0.lbFightCount:setVisible(true)
		arg_15_0.btnResetBuy:setVisible(var_15_2 <= var_15_0.FightCount)
		arg_15_0.lbFightCount:setString(a2u(string.format("\xBD\xF1\xC8տ\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:%d/%d", var_15_2 - var_15_0.FightCount, var_15_2)))
		zbUtil:setButtonTitle(arg_15_0.btnBatchSweep, a2u(string.format("ɨ\xB5\xB4%d\xB4\xCE", var_15_2)))

		local var_15_4 = zbVipTable:getRecord(g_Self:getVipLevel())

		if var_15_4 ~= nil then
			arg_15_0.lbResetCount:setString(a2u(string.format("(\xBD\xF1\xC8տ\xC9\xD6\xD8\xD6\xC3%d\xB4\xCE)", var_15_4.eliteLevelResetNum - var_15_0.RefreshCount)))
			arg_15_0.lbResetCount:setVisible(var_15_2 <= var_15_0.FightCount)
		end

		if var_15_0 ~= nil then
			if var_15_2 - var_15_0.FightCount > 0 then
				zbUtil:setButtonTitle(arg_15_0.btnBatchSweep, a2u("ɨ\xB5\xB4") .. var_15_2 - var_15_0.FightCount .. a2u("\xB4\xCE"))
			else
				zbUtil:setButtonTitle(arg_15_0.btnBatchSweep, a2u("\xCE޷\xA8ɨ\xB5\xB4"))
			end
		end
	end
end

function var_0_0.getNeedTili(arg_16_0)
	local var_16_0, var_16_1 = zbForceSetTable:getLoginAndWinTili(arg_16_0.levelId, arg_16_0.levelType)

	return var_16_0 + var_16_1
end

function var_0_0.onAttack(arg_17_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_17_0:getNeedTili()) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
		g_Bubble:bubbleInfo("\xD3\xE3\xB8ɲ\xBB\xD7\xE3")

		return
	end

	local var_17_0 = g_Self.kWarPathHandler:getLevelInfo(arg_17_0.levelType, arg_17_0.forceId, arg_17_0.levelId)
	local var_17_1 = zbForceTable:getRecord(arg_17_0.forceId)

	if var_17_0 ~= nil and (arg_17_0.levelType == ELevelType.Elite and var_17_1.eliteMaxFight - var_17_0.FightCount <= 0 or arg_17_0.levelType == ELevelType.Nightmare and var_17_1.nightmareMaxFight - var_17_0.FightCount <= 0) then
		g_Bubble:bubbleInfo("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3")

		return
	else
		arg_17_0:hide()

		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(arg_17_0.levelType, arg_17_0.forceId, arg_17_0.levelId)
	end
end

function var_0_0.onSweep(arg_18_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_18_0:getNeedTili()) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
		g_Bubble:bubbleInfo("\xD3\xE3\xB8ɲ\xBB\xD7\xE3")

		return
	end

	local var_18_0 = 0
	local var_18_1 = zbForceTable:getRecord(arg_18_0.forceId)

	if arg_18_0.levelType == ELevelType.Elite then
		local var_18_2 = var_18_1.eliteMaxFight
		local var_18_3 = g_Self.kWarPathHandler:getLevelInfo(arg_18_0.levelType, arg_18_0.forceId, arg_18_0.levelId)

		if var_18_3 ~= nil and var_18_2 - var_18_3.FightCount <= 0 then
			g_Bubble:bubbleInfo("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3")

			return
		end
	elseif arg_18_0.levelType == ELevelType.Nightmare then
		local var_18_4 = var_18_1.nightmareMaxFight
		local var_18_5 = g_Self.kWarPathHandler:getLevelInfo(arg_18_0.levelType, arg_18_0.forceId, arg_18_0.levelId)

		if var_18_5 ~= nil and var_18_4 - var_18_5.FightCount <= 0 then
			g_Bubble:bubbleInfo("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3")

			return
		end
	end

	arg_18_0:hide()
	g_WsMsgHandler:WS_GameLevel_SaoDang_Req(arg_18_0.forceId, arg_18_0.levelId, arg_18_0.levelType, 1)
end

function var_0_0.onBatchSweep(arg_19_0)
	local var_19_0 = zbForceTable:getRecord(arg_19_0.forceId)
	local var_19_1 = 0

	if arg_19_0.levelType == ELevelType.Normal then
		var_19_1 = 10
	elseif arg_19_0.levelType == ELevelType.Elite then
		local var_19_2 = g_Self.kWarPathHandler:getLevelInfo(arg_19_0.levelType, arg_19_0.forceId, arg_19_0.levelId)

		if var_19_2 ~= nil then
			var_19_1 = var_19_0.eliteMaxFight - var_19_2.FightCount
		end
	else
		local var_19_3 = g_Self.kWarPathHandler:getLevelInfo(arg_19_0.levelType, arg_19_0.forceId, arg_19_0.levelId)

		if var_19_3 ~= nil then
			var_19_1 = var_19_0.nightmareMaxFight - var_19_3.FightCount
		end
	end

	if var_19_1 > 0 then
		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_19_0:getNeedTili() * var_19_1) == false then
			g_MainScene:showGoldenTouch(EExchangeType.Tili)
			g_Bubble:bubbleInfo("\xD3\xE3\xB8ɲ\xBB\xD7\xE3")

			return
		end

		arg_19_0:hide()
		g_WsMsgHandler:WS_GameLevel_SaoDang_Req(arg_19_0.forceId, arg_19_0.levelId, arg_19_0.levelType, var_19_1)
	else
		g_Bubble:bubbleInfo("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3")

		return
	end
end

function var_0_0.onResetEliteLevel(arg_20_0)
	local function var_20_0()
		g_WsMsgHandler:WS_GameLevel_Reset_Req(arg_20_0.forceId, arg_20_0.levelId, arg_20_0.levelType)
	end

	local var_20_1 = g_Self.kWarPathHandler:getLevelInfo(arg_20_0.levelType, arg_20_0.forceId, arg_20_0.levelId)
	local var_20_2 = zbVipTable:getRecord(g_Self:getVipLevel())
	local var_20_3 = 0

	if var_20_2 then
		if arg_20_0.levelType == ELevelType.Elite then
			var_20_3 = var_20_2.eliteLevelResetNum
		else
			var_20_3 = var_20_2.nightmareLevelResetNum
		end

		if var_20_3 <= var_20_1.RefreshCount then
			g_Bubble:bubbleInfo("\xD6\xD8\xD6ô\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA")

			return
		end
	end

	local var_20_4 = g_DataConfig.kForceBaseTable.resetDiamond[1]
	local var_20_5 = table.getn(g_DataConfig.kForceBaseTable.resetDiamond)

	if var_20_5 >= var_20_1.RefreshCount + 1 then
		var_20_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_20_1.RefreshCount + 1]
	else
		var_20_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_20_5]
	end

	local var_20_6 = a2u(string.format("\xD6\xD8\xD6ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD0\xE8Ҫ\xBB\xA8\xB7\xD1%d\xD7\xEAʯ\xA3\xAC\xCAǷ\xF1\xBC\xCC\xD0\xF8\xA3\xBF(\xBD\xF1\xC8\xD5\xD2\xD1\xD6\xD8\xD6\xC3%d\xB4\xCE)", var_20_4, var_20_1.RefreshCount))

	g_MessageBox:showYesNo(var_20_6, var_20_0)
end

function var_0_0.onResetEliteLevelAck(arg_22_0)
	arg_22_0:updateSweep()
end

function var_0_0.onTouchTest(arg_23_0)
	local var_23_0 = arg_23_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_23_0.layerTouchTest, var_23_0.x, var_23_0.y) == false and zbUtil:PointInCtrl(arg_23_0.btnClose, var_23_0.x, var_23_0.y) == false then
		arg_23_0:hide()
	end
end
