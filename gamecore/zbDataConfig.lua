require("gamebase.zbLoadCSV")
require("gamecore.zbBuildingUpgradeTable")
require("gamecore.zbEquipHoleTable")
require("gamecore.zbEquipCuilianUpgradeTable")
require("gamecore.zbEquipUpStarTable")
require("gamecore.zbEquipQualityTable")
require("gamecore.zbEquipUpgradeTable")
require("gamecore.zbFateTable")
require("gamecore.zbForceLevelAwardTable")
require("gamecore.zbForceHeroTable")
require("gamecore.zbForceSetTable")
require("gamecore.zbForceStarAwardTable")
require("gamecore.zbForceTable")
require("gamecore.zbHeroExtraAttrUpgradeTable")
require("gamecore.zbHeroMainAttrUpgradeTable")
require("gamecore.zbHeroQualityUpgradeTable")
require("gamecore.zbHeroQualityTable")
require("gamecore.zbHeroServantTable")
require("gamecore.zbHeroSkillTable")
require("gamecore.zbHeroSkillUpgradeTable")
require("gamecore.zbHeroStarUpgradeTable")
require("gamecore.zbHeroTable")
require("gamecore.zbAvatarTable")
require("gamecore.zbAvatarSoundTable")
require("gamecore.zbHeroUpgradeTable")
require("gamecore.zbItemTable")
require("gamecore.zbItemQualityTable")
require("gamecore.zbTechTable")
require("gamecore.zbTechUpgradeTable")
require("gamecore.zbVipTable")
require("gamecore.zbPlayerUpgradeTable")
require("gamecore.zbGodBaseTable")
require("gamecore.zbGodSkillTable")
require("gamecore.zbEffectTable")
require("gamecore.zbBuffTable")
require("gamecore.zbGodUpgradeTable")
require("gamecore.zbGodStarTable")
require("gamecore.zbGodSkillUpgradeTable")
require("gamecore.zbArenaBestRankAwardTable")
require("gamecore.zbArenaDailyAwardTable")
require("gamecore.zbItemBoxTable")
require("gamecore.zbMainTaskTable")
require("gamecore.zbDailyTaskTable")
require("gamecore.zbFunctionUnlockTable")
require("gamecore.zbActivenessRewardTable")
require("gamecore.zbShopTable")
require("gamecore.zbPataLayerBaseTable")
require("gamecore.zbPataMatchBossTable")
require("gamecore.zbPataScoreAwardTable")
require("gamecore.zbBgzScoreAwardTable")
require("gamecore.zbHeroTrialBaseTable")
require("gamecore.zbHeroTrialBossTable")
require("gamecore.zbHeroTrialDegreeTable")
require("gamecore.zbLegionTechTable")
require("gamecore.zbLegionTechUpgradeTable")
require("gamecore.zbLegionDailyAwardTable")
require("gamecore.zbLegionHongbaoTable")
require("gamecore.zbWorldNodeTable")
require("gamecore.zbWorldGridTable")
require("gamecore.zbWorldTaskTable")
require("gamecore.zbWorldNpcTable")
require("gamecore.zbWorldBossRankAwardTable")
require("gamecore.zbBarRewardTable")
require("gamecore.zbActCrazyUpgradeTable")
require("gamecore.zbBulletScreenTable")
require("gamecore.zbHeroFragTable")
require("gamecore.zbFvAttrTable")
require("gamecore.zbFriendBossTable")
require("gamecore.zbLegionBossTable")
require("gamecore.zbTreaSureTable")
require("gamecore.zbHeroSoulHallTable")
require("gamecore.zbHeroSoulTable")
require("gamecore.zbWarNpcTable")
require("gamecore.zbWarNodeTable")
require("gamecore.zbVipShopTable")
require("gamecore.zbGemsComposeTable")

local var_0_0 = class("zbDataConfig")

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

function var_0_0.init(arg_2_0)
	arg_2_0.m_kCommonCfg = require("config/gameCommon")
	arg_2_0.kSceneTable = require("config.scene")
	arg_2_0.kForceBaseTable = require("config.force.forceBase")
	arg_2_0.kArenaBaseTable = require("config.arenaBase")
	arg_2_0.kBgzCommonTable = require("config.bgzCommon")
	arg_2_0.kPataCommonTable = require("config.pata.pataCommon")
	arg_2_0.kWorldBaseTable = require("config.world.worldBase")
	arg_2_0.m_kWorldBossCfg = require("config.worldBoss.worldBossCommon")
	arg_2_0.m_kWarBaseCfg = require("config/legionWar/warBase")

	zbFvAttrTable:load("config/fvAttr")
	zbBulletScreenTable:load("config/bulletscreen")
	zbBuildingUpgradeTable:load("config/buildingUpgrade")
	zbEquipHoleTable:load("config/equipHole")
	zbEquipCuilianUpgradeTable:load("config/equipCuilianUpgrade")
	zbEquipQualityTable:load("config/equipQuality")
	zbEquipUpgradeTable:load("config/equipUpgrade")
	zbEquipUpStarTable:load("config/equipUpStar")
	zbFateTable:load("config/fateHero")
	zbFateTable:load("config/fateEquip")
	zbForceLevelAwardTable:load("config.force/forceAward")
	zbForceStarAwardTable:load("config.force/forceStarAward")
	zbForceHeroTable:load("config.force/forceHero")
	zbForceSetTable:load("config.force/forceSet")
	zbForceTable:load("config.force/force")
	zbHeroExtraAttrUpgradeTable:load("config/heroExtraAttrUpgrade")
	zbHeroMainAttrUpgradeTable:load("config/heroMainAttrUpgrade")
	zbHeroQualityUpgradeTable:load("config/heroQualityUpgrade")
	zbHeroQualityTable:load("config/heroQuality")
	zbHeroServantTable:load("config/heroServant")
	zbHeroSkillTable:load("config/heroSkill")
	zbHeroFragTable:load("config/heroSoulFrag")
	zbHeroSkillUpgradeTable:load("config/heroSkillUpgrade")
	zbHeroStarUpgradeTable:load("config/heroStarUpgrade")
	zbHeroTable:load("config/hero")
	zbBarRewardTable:load("config/barRewards")
	zbAvatarTable:load("config/avatar")
	zbAvatarSoundTable:load("config/avatarsound")
	zbHeroUpgradeTable:load("config/heroUpgrade")
	zbItemTable:load("config/item")
	zbTechTable:load("config/tech")
	zbTechUpgradeTable:load("config/techUpgrade")
	zbVipTable:load("config/vip")
	zbGemsComposeTable:load("config/gemCompose")
	zbPlayerUpgradeTable:load("config/playerUpgrade")
	zbGodBaseTable:load("config.god/godBase")
	zbGodSkillTable:load("config.god/godSkill")
	zbBuffTable:load("config/buff")
	zbEffectTable:load("config/effect")
	zbGodUpgradeTable:load("config.god/godUpgrade")
	zbGodStarTable:load("config.god/godStar")
	zbGodSkillUpgradeTable:load("config.god/godSkillUpgrade")
	zbArenaBestRankAwardTable:load("config/arenaBestRankAward")
	zbArenaDailyAwardTable:load("config/arenaDailyAward")
	zbItemBoxTable:load("config/itemBox")
	zbMainTaskTable:load("config/mainTask")
	zbDailyTaskTable:load("config/dailyTask")
	zbFunctionUnlockTable:load("config/functionUnlock")
	zbActivenessRewardTable:load("config/activenessReward")
	zbShopTable:load("config/shop")
	zbFriendBossTable:load("config/friendBoss")
	zbTreaSureTable:load("config/force/forceTreasure")
	zbHeroSoulHallTable:load("config/heroSoulHall")
	zbHeroSoulTable:load("config/heroSoul")
	zbWarNodeTable:load("config/legionWar/warNode")
	zbWarNpcTable:load("config/legionWar/warNpc")
	zbVipShopTable:load("config/vipShop")
	zbActCrazyUpgradeTable:load("config.activity/actCrazyUpgrade")
	zbPataLayerBaseTable:load("config.pata/pataLayerBase")
	zbPataMatchBossTable:load("config.pata/pataMatchBoss")
	zbPataScoreAwardTable:load("config.pata/pataScoreAward")
	zbBgzScoreAwardTable:load("config/bgzScoreAward")
	zbHeroTrialBaseTable:load("config.trial/heroTrialBase")
	zbHeroTrialBossTable:load("config.trial/heroTrialBoss")
	zbHeroTrialDegreeTable:load("config.trial/heroTrialDegree")

	arg_2_0.m_kLegionBaseCfg = require("config.legion/legionBase")

	zbLegionTechTable:load("config.legion/legionTech")
	zbLegionBossTable:load("config.legion/legionBoss")
	zbLegionTechUpgradeTable:load("config.legion/legionTechUpgrade")
	zbLegionDailyAwardTable:load("config.legion/legionDailyAward")
	zbLegionHongbaoTable:load("config.legion/legionHongbao")

	arg_2_0.m_kWorldBaseCfg = require("config.world/worldBase")

	zbWorldNodeTable:load("config.world/worldNode")
	zbWorldGridTable:load("config.world/worldGrid")
	zbWorldTaskTable:load("config.world/worldTask")
	zbWorldNpcTable:load("config.world/worldNpc")
	zbWorldBossRankAwardTable:load("config.worldBoss/worldBossRankAward")
	arg_2_0:doParseBgzAward()
end

function var_0_0.free(arg_3_0)
	return
end

function createDataConfig()
	local var_4_0 = var_0_0.new()

	var_4_0:init()

	return var_4_0
end

function var_0_0.getCombatTalk(arg_5_0, arg_5_1)
	if arg_5_0.m_kCombatTalkTable == nil then
		arg_5_0.m_kCombatTalkTable = require("config/combattalk")
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0.m_kCombatTalkTable) do
		if iter_5_1.id == arg_5_1 then
			return iter_5_1.talk
		end
	end

	return nil
end

function var_0_0.getGuideTalk(arg_6_0, arg_6_1)
	if arg_6_0.m_kGuideTalkTable == nil then
		arg_6_0.m_kGuideTalkTable = require("config/guidetalk")
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.m_kGuideTalkTable) do
		if iter_6_1.id == arg_6_1 then
			return iter_6_1.talk
		end
	end

	return nil
end

function var_0_0.getGuideTitle(arg_7_0, arg_7_1)
	if arg_7_0.m_kGuideTitleTable == nil then
		arg_7_0.m_kGuideTitleTable = require("config/guidetitle")
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.m_kGuideTitleTable) do
		if iter_7_1.id == arg_7_1 then
			return iter_7_1.talk
		end
	end

	return nil
end

function var_0_0.isValidSceneId(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(g_DataConfig.kSceneTable) do
		if iter_8_1.id == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.doParseBgzAward(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.kBgzCommonTable.levelList) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1.levelAward) do
			zbGetWayItemTable:addItemNewWaysShop(iter_9_3[2], EItemGetWayType.GetWay_Yuanzheng, iter_9_3[1])
		end
	end
end
