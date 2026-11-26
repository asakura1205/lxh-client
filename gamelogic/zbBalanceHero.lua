local var_0_0 = class("zbBalanceHero", CCNodeExtend)

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

function createBalanceHero(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.heroTemplateId = -1
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(2), "CCNode")
		local var_5_3 = tolua.cast(var_5_0:getChildByTag(3), "CCNode")

		arg_3_0.spriteDieTip = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.spriteLevelupTip = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.spriteFrame = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteHead = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(var_5_1:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.qualityRoot = tolua.cast(var_5_1:getChildByTag(4), "CCNode")
		arg_3_0.spriteDieDark = tolua.cast(var_5_1:getChildByTag(5), "CCSprite")
		arg_3_0.lbSkillExpNumDummy = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spriteHeroExpProgressBg = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.lbHeroExpNumDummy = tolua.cast(var_5_3:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spriteHeroExpFullTip = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbSkillExpNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbSkillExpNumDummy, arg_3_0.lbSkillExpNum)
		arg_3_0.lbSkillExpNum:setScale(0.5)

		arg_3_0.lbHeroExpNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbHeroExpNumDummy, arg_3_0.lbHeroExpNum)
		arg_3_0.lbHeroExpNum:setScale(0.5)

		arg_3_0.spriteStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.spriteStars[iter_5_0] = tolua.cast(arg_3_0.qualityRoot:getChildByTag(iter_5_0), "CCSprite")
		end

		arg_3_0.levelupInitPos = ccp(arg_3_0.spriteLevelupTip:getPosition())
		arg_3_0.progressHeroExp = zbUtil:createProgressTimer(arg_3_0.spriteHeroExpProgressBg, "image/balance/balance_progress_red.png")

		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.heroTemplateId = arg_6_1

	arg_6_0:setVisible(false)

	local var_6_0 = zbHeroTable:getRecord(arg_6_1)
	local var_6_1 = g_Self.kHeroHandler:getHeroByTemplateId(arg_6_1)

	if var_6_0 == nil or var_6_1 == nil then
		return
	end

	arg_6_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getHeroFrameTex(var_6_1.HeroBaseInfo.Quality)))
	arg_6_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroIconPath(arg_6_1)))
	arg_6_0.lbLevel:setString(var_6_1.HeroBaseInfo.Level)
	zbUIEffect:centerHeroStar(arg_6_0.spriteStars, var_6_1.HeroBaseInfo.Star)
	arg_6_0.lbSkillExpNum:setString("+" .. 0)

	local var_6_2 = arg_6_0:calcExpAdd()

	arg_6_0.lbHeroExpNum:setString("+" .. var_6_2)
	arg_6_0.progressHeroExp:setPercentage(0)

	local var_6_3 = arg_6_0:combatHeroIsDie(arg_6_1)

	arg_6_0.spriteDieDark:setVisible(var_6_3)
	arg_6_0.spriteDieTip:setVisible(var_6_3)
	arg_6_0.spriteLevelupTip:setVisible(false)
	arg_6_0.spriteHeroExpFullTip:setVisible(false)
	arg_6_0.lbHeroExpNum:setVisible(false)
	arg_6_0.lbSkillExpNum:setVisible(false)
	arg_6_0:setVisible(true)
end

function var_0_0.calcExpAdd(arg_7_0)
	local var_7_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_7_0.heroTemplateId)

	if var_7_0 == nil then
		return 0
	end

	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = g_CombatSystem:getHeros(g_CombatSystem:getMyForceType())

	for iter_7_0, iter_7_1 in pairs(var_7_3) do
		if arg_7_0.heroTemplateId == iter_7_1:getTemplateId() then
			local var_7_4 = var_7_0.HeroBaseInfo.Level - iter_7_1:getLevel()

			for iter_7_2 = 0, var_7_4 - 1 do
				var_7_1 = var_7_1 + zbHeroUpgradeTable:getHeroUpgradeNeedExp(iter_7_1:getLevel() + iter_7_2)
			end

			var_7_1 = var_7_1 + var_7_0.HeroBaseInfo.Exp - iter_7_1:getBackupExp()

			break
		end
	end

	return var_7_1
end

function var_0_0.animHeroExpUp(arg_8_0)
	local var_8_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_8_0.heroTemplateId)

	if var_8_0 == nil then
		return
	end

	local var_8_1 = 0
	local var_8_2 = g_CombatSystem:getHeros(g_CombatSystem:getMyForceType())

	for iter_8_0, iter_8_1 in pairs(var_8_2) do
		if arg_8_0.heroTemplateId == iter_8_1:getTemplateId() and var_8_0.HeroBaseInfo.Level > iter_8_1:getLevel() then
			arg_8_0.spriteLevelupTip:setVisible(true)

			var_8_1 = var_8_0.HeroBaseInfo.Level - iter_8_1:getLevel()

			break
		end
	end

	local function var_8_3()
		arg_8_0.progressHeroExp:setPercentage(0)
	end

	local var_8_4 = CCArray:create()

	for iter_8_2 = 1, var_8_1 do
		var_8_4:addObject(CCProgressTo:create(1, 100))
		var_8_4:addObject(CCCallFuncN:create(var_8_3))
	end

	local var_8_5 = zbHeroUpgradeTable:getHeroUpgradeNeedExp(var_8_0.HeroBaseInfo.Level)
	local var_8_6 = math.min(math.ceil(100 * (var_8_0.HeroBaseInfo.Exp / var_8_5)), 100)

	var_8_4:addObject(CCProgressTo:create(1, var_8_6))

	local var_8_7 = CCSequence:create(var_8_4)

	arg_8_0.progressHeroExp:setPercentage(0)
	arg_8_0.progressHeroExp:stopAllActions()
	arg_8_0.progressHeroExp:runAction(var_8_7)

	if var_8_1 > 0 then
		arg_8_0.spriteLevelupTip:setVisible(true)
		arg_8_0.spriteLevelupTip:setPosition(arg_8_0.levelupInitPos.x, arg_8_0.levelupInitPos.y - 25)
		arg_8_0.spriteLevelupTip:stopAllActions()
		arg_8_0.spriteLevelupTip:runAction(CCMoveTo:create(0.3, arg_8_0.levelupInitPos))
	end

	if var_8_0.HeroBaseInfo.Level == g_Self:getLevel() and var_8_6 >= 100 then
		arg_8_0.spriteHeroExpFullTip:setVisible(true)
	end

	arg_8_0.lbHeroExpNum:setVisible(arg_8_0.spriteHeroExpFullTip:isVisible() == false)
end

function var_0_0.animSkillExpUp(arg_10_0)
	local var_10_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_10_0.heroTemplateId)

	if var_10_0 == nil then
		return
	end

	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = g_CombatSystem:getHeros(g_CombatSystem:getMyForceType())

	for iter_10_0, iter_10_1 in pairs(var_10_3) do
		if arg_10_0.heroTemplateId == iter_10_1:getTemplateId() then
			local var_10_4 = iter_10_1:getBackupSkillPoint()

			var_10_2 = var_10_0.HeroSubInfo.SkillPoint - iter_10_1:getBackupSkillPoint()

			break
		end
	end

	arg_10_0.lbSkillExpNum:setVisible(true)
	arg_10_0.lbSkillExpNum:setString("+" .. var_10_2)
end

function var_0_0.combatHeroIsDie(arg_11_0, arg_11_1)
	local var_11_0 = ForceType.Left

	if g_CombatSystem.combatType == COMBAT_TYPE_ARENARECORD and g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].PlayerId == g_Self:getPlayerId() then
		var_11_0 = ForceType.Right
	end

	local var_11_1 = g_CombatSystem:getHeros(var_11_0)

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		if iter_11_1:getTemplateId() == arg_11_1 and iter_11_1:isDie() then
			return true
		end
	end

	return false
end
