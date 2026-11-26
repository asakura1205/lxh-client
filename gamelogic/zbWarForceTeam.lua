require("gamelogic.zbWarLevelTag")
require("gamelogic.zbWarTreaSureTag")

local var_0_0 = class("zbWarForceTeam", CCNodeExtend)

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

function createWarForceTeam(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.parent = arg_3_2
		arg_3_0.awardItems = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteHero = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.spriteStars = {}
		arg_3_0.spriteStars[1] = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteStars[2] = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteStars[3] = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.centerPositionX = arg_3_0.spriteStars[2]:getPositionX()

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")

		arg_3_0.lbLevelName = tolua.cast(var_5_1:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc1 = tolua.cast(var_5_0:getChildByTag(5), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(6), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.85)
			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)

			arg_3_0.awardItems[iter_5_0] = var_5_4
		end

		arg_3_0.lbRoleExp = tolua.cast(var_5_2:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbHeroExp = tolua.cast(var_5_2:getChildByTag(12), "CCLabelTTF")
		arg_3_0.lbSkillPoint = tolua.cast(var_5_2:getChildByTag(13), "CCLabelTTF")
		arg_3_0.iconTili = tolua.cast(var_5_0:getChildByTag(101), "CCSprite")
		arg_3_0.lbTiliNeed = tolua.cast(var_5_0:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbFightCount = tolua.cast(var_5_0:getChildByTag(8), "CCLabelTTF")
		arg_3_0.btnAttack = tolua.cast(var_5_0:getChildByTag(9), "CCControlButton")
		arg_3_0.btnResetBuy = tolua.cast(var_5_0:getChildByTag(11), "CCControlButton")
		arg_3_0.lbResetCount = tolua.cast(var_5_0:getChildByTag(10), "CCLabelTTF")

		local var_5_5 = arg_3_0.parent.btnLeft:getTouchPriority()

		arg_3_0.btnResetBuy:setTouchPriority(var_5_5 - 1)
		arg_3_0.btnAttack:setTouchPriority(var_5_5 - 1)
		arg_3_0.btnAttack:addHandleOfControlEvent(function()
			arg_3_0:onAttack()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnResetBuy:addHandleOfControlEvent(function()
			arg_3_0:onResetEliteLevel()
		end, CCControlEventTouchUpInside)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.forceId = arg_8_1

	if math.fmod(arg_8_1, 2) == 1 then
		arg_8_0.levelId = tonumber(string.format("%d%.4d", arg_8_1, 6))
	else
		arg_8_0.levelId = tonumber(string.format("%d%.4d", arg_8_1, 9))
	end

	local var_8_0 = zbForceSetTable:getRecord(arg_8_0.levelId)

	if var_8_0 == nil then
		return
	end

	arg_8_0.lbLevelName:setString(var_8_0.name)
	arg_8_0.lbDesc1:setString(var_8_0.desc1)

	local var_8_1 = zbForceSetTable:getLevelHeroList(arg_8_0.levelId, ELevelType.Nightmare)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if iter_8_1.boss == 1 then
			local var_8_2 = zbIconHelper:getHeroCardIconPath(iter_8_1.templateId)

			arg_8_0.spriteHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_2))

			break
		end
	end

	local var_8_3 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Nightmare, arg_8_0.forceId, arg_8_0.levelId)

	for iter_8_2 = 1, 3 do
		arg_8_0.spriteStars[iter_8_2]:setVisible(iter_8_2 <= var_8_3)
	end

	zbUIEffect:centerStar(arg_8_0.spriteStars, arg_8_0.centerPositionX)
	arg_8_0.lbTiliNeed:setString(arg_8_0:getNeedTili())

	for iter_8_3, iter_8_4 in pairs(arg_8_0.awardItems) do
		iter_8_4:setVisible(false)
	end

	local var_8_4 = g_Self.kGmActivityHandler:getGmActivityDoubleDrop(ELevelType.Nightmare)
	local var_8_5 = 1
	local var_8_6, var_8_7, var_8_8 = zbForceSetTable:getLevelAwardItems(arg_8_0.levelId, ELevelType.Nightmare)

	for iter_8_5 = 1, #var_8_6 do
		local var_8_9 = var_8_6[iter_8_5]
		local var_8_10 = arg_8_0.awardItems[iter_8_5]

		if var_8_10 ~= nil then
			var_8_10:refreshAward(var_8_9.awardType, var_8_9.awardId, var_8_9.awardCount, false)
			var_8_10:setVisible(true)
		end

		local var_8_11 = iter_8_5
	end

	arg_8_0.lbRoleExp:setString("+" .. var_8_0.roleExpware)
	arg_8_0.lbHeroExp:setString("+" .. var_8_0.awardGoldware)
	arg_8_0.lbSkillPoint:setString("+" .. var_8_0.heroSPware)
	arg_8_0.btnResetBuy:setVisible(false)
	arg_8_0.lbResetCount:setVisible(false)
	arg_8_0.btnAttack:setVisible(true)
	arg_8_0.lbFightCount:setVisible(true)

	local var_8_12 = g_Self.kWarPathHandler:getLevelInfo(ELevelType.Nightmare, arg_8_0.forceId, arg_8_0.levelId)
	local var_8_13 = zbForceTable:getRecord(arg_8_0.forceId)

	if var_8_12 ~= nil then
		arg_8_0.lbFightCount:setString(a2u(string.format("\xBF\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:%d/%d", var_8_13.nightmareMaxFight - var_8_12.FightCount, var_8_13.nightmareMaxFight)))
		arg_8_0.btnAttack:setVisible(var_8_12.FightCount < var_8_13.nightmareMaxFight)
		arg_8_0.lbFightCount:setVisible(var_8_12.FightCount < var_8_13.nightmareMaxFight)
		arg_8_0.lbResetCount:setVisible(var_8_12.FightCount >= var_8_13.nightmareMaxFight)
		arg_8_0.btnResetBuy:setVisible(var_8_12.FightCount >= var_8_13.nightmareMaxFight)

		local var_8_14 = zbVipTable:getRecord(g_Self:getVipLevel())

		if var_8_14 ~= nil then
			arg_8_0.lbResetCount:setString(a2u(string.format("(\xBF\xC9\xD6\xD8\xD6\xC3%d\xB4\xCE)", var_8_14.nightmareLevelResetNum - var_8_12.RefreshCount)))
		end
	else
		arg_8_0.lbFightCount:setString(a2u("\xBF\xC9\xCC\xF4ս\xB4\xCE\xCA\xFD:1/1"))
	end
end

function var_0_0.getNeedTili(arg_9_0)
	local var_9_0, var_9_1 = zbForceSetTable:getLoginAndWinTili(arg_9_0.levelId, ELevelType.Nightmare)

	return var_9_0 + var_9_1
end

function var_0_0.onAttack(arg_10_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_10_0:getNeedTili()) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
		g_Bubble:bubbleInfo("\xD3\xE3\xB8ɲ\xBB\xD7\xE3")

		return
	end

	local var_10_0 = g_Self.kWarPathHandler:getLevelInfo(ELevelType.Nightmare, arg_10_0.forceId, arg_10_0.levelId)
	local var_10_1 = zbForceTable:getRecord(arg_10_0.forceId)

	if var_10_0 ~= nil and arg_10_0.levelType == ELevelType.Nightmare and var_10_1.nightmareMaxFight - var_10_0.FightCount <= 0 then
		g_Bubble:bubbleInfo("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3")

		return
	else
		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(ELevelType.Nightmare, arg_10_0.forceId, arg_10_0.levelId)
	end
end

function var_0_0.onResetEliteLevel(arg_11_0)
	local function var_11_0()
		g_WsMsgHandler:WS_GameLevel_Reset_Req(arg_11_0.forceId, arg_11_0.levelId, ELevelType.Nightmare)
	end

	local var_11_1 = g_Self.kWarPathHandler:getLevelInfo(ELevelType.Nightmare, arg_11_0.forceId, arg_11_0.levelId)
	local var_11_2 = zbVipTable:getRecord(g_Self:getVipLevel())
	local var_11_3 = 0

	if var_11_2 and var_11_2.nightmareLevelResetNum <= var_11_1.RefreshCount then
		g_Bubble:bubbleInfo("\xD6\xD8\xD6ô\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA")

		return
	end

	local var_11_4 = g_DataConfig.kForceBaseTable.resetDiamond[1]
	local var_11_5 = table.getn(g_DataConfig.kForceBaseTable.resetDiamond)

	if var_11_5 >= var_11_1.RefreshCount + 1 then
		var_11_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_11_1.RefreshCount + 1]
	else
		var_11_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_11_5]
	end

	local var_11_6 = a2u(string.format("\xD6\xD8\xD6ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD0\xE8Ҫ\xBB\xA8\xB7\xD1%d\xD7\xEAʯ\xA3\xAC\xCAǷ\xF1\xBC\xCC\xD0\xF8\xA3\xBF(\xBD\xF1\xC8\xD5\xD2\xD1\xD6\xD8\xD6\xC3%d\xB4\xCE)", var_11_4, var_11_1.RefreshCount))

	g_MessageBox:showYesNo(var_11_6, var_11_0)
end
