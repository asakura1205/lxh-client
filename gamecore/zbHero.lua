require("gamecore.zbHeroHud")
require("gamecore.zbHeroBuff")
require("gamecore.zbHeroShadow")
require("gamecore.zbHeroFocus")
require("gamecore.zbHeroQte")
require("gamecore.zbHeroStateMachine")
require("gamecore.zbHeroAnimation")
require("gamecore.zbCombatDefine")
require("gamecore.zbHeroEnergy")
require("gamecore.zbHeroGoldEmitter")

zbHero = class("zbHero", CCNodeExtend)
zbHero.__index = zbHero

function zbHero.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHero)

	return arg_1_0
end

function zbHero.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHero.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHero.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.forceType = arg_3_1
	arg_3_0.heroBattleData = arg_3_2
	arg_3_0.isReadyFight = false
	arg_3_0.isRealDied = false
	arg_3_0.fv = 0
	arg_3_0.mySkillSequence = {}
	arg_3_0.curSkill = nil
	arg_3_0.roundEnded = false
	arg_3_0.fixPosition = getCombatHeroPos(arg_3_0.forceType, arg_3_0:getFormationIndex())
	arg_3_0.physicReduceRate = 0
	arg_3_0.physicReduce = 0
	arg_3_0.magicReduceRate = 0
	arg_3_0.magicReduce = 0
	arg_3_0.pmReduceRate = 0
	arg_3_0.pmReduceAbs = 0
	arg_3_0.pmReduceRatio = 0
	arg_3_0.roundReduceEnable = false
	arg_3_0.roundReduceRatio = 0
	arg_3_0.roundReduceAbs = 0
	arg_3_0.totalPMShield = 0
	arg_3_0.curPMShield = 0
	arg_3_0.totalPhysicShield = 0
	arg_3_0.curPhysicShield = 0
	arg_3_0.totalMagicShield = 0
	arg_3_0.curMagicShield = 0
	arg_3_0.fanTanRate = 0
	arg_3_0.fanTanPercent = 0
	arg_3_0.fanTanAbs = 0
	arg_3_0.fanTanControlBuffId = 0
	arg_3_0.doubleAttackRate = 0
	arg_3_0.targetDebuffDamageAddSkill = nil
	arg_3_0.targetDebuffDamageAddRatio = 0
	arg_3_0.targetDebuffDamageAddAbs = 0
	arg_3_0.initZOrder = 0
	arg_3_0.reviveSequence = ANIMATION_SEQUENCE_IDLE
	arg_3_0.showSequence = ANIMATION_SEQUENCE_SHOW
	arg_3_0.lastAttacker = nil
	arg_3_0.bubbleNodes = {}
	arg_3_0.destPos = ccp(0, 0)
	arg_3_0.movingPos = false
	arg_3_0.accumRoundCount = 0
	arg_3_0.showMpFinger = false
	arg_3_0.absPhysicAttack = 0
	arg_3_0.absPhysicDefend = 0
	arg_3_0.absMagicAttack = 0
	arg_3_0.absMagicDefend = 0
	arg_3_0.absHit = 0
	arg_3_0.absDodge = 0
	arg_3_0.absViolent = 0
	arg_3_0.absTough = 0
	arg_3_0.absPierceDamage = 0
	arg_3_0.absBlock = 0
	arg_3_0.buffRoundHpAdd = 0
	arg_3_0.buffRoundMpAdd = 0
	arg_3_0.buffMaxHpAdd = 0
	arg_3_0.extraPhysicDamageRatio = 0
	arg_3_0.extraPhysicDamageAbs = 0
	arg_3_0.extraMagicDamageRatio = 0
	arg_3_0.extraMagicDamageAbs = 0
	arg_3_0.extraPhysicDamageDefendRatio = 1
	arg_3_0.extraPhysicDamageDefendAbs = 0
	arg_3_0.extraMagicDamageDefendRatio = 1
	arg_3_0.extraMagicDamageDefendAbs = 0
	arg_3_0.maxDamageHpPercentEnable = false
	arg_3_0.maxDamageHpPercent = 0
	arg_3_0.bImmunePhysic = false
	arg_3_0.bImmuneMagic = false
	arg_3_0.bHunmi = false
	arg_3_0.bMeihuo = false
	arg_3_0.bChenmo = false
	arg_3_0.chaofengSrc = nil
	arg_3_0.bZhongshang = false
	arg_3_0.bZhongdu = false
	arg_3_0.bFire = false
	arg_3_0.zhongziTargetDamageAddPercent = 0
	arg_3_0.zhongziTargetDamageAddAbs = 0
	arg_3_0.zhongshangTargetDamageAddPercent = 0
	arg_3_0.zhongshangTargetDamageAddAbs = 0
	arg_3_0.zhongshangTargetReduceRate = 0
	arg_3_0.zhongshangTargetReduceRatio = 0
	arg_3_0.zhongshangTargetReduceAbs = 0
	arg_3_0.zhongduTargetDamageAddPercent = 0
	arg_3_0.zhongduTargetDamageAddAbs = 0
	arg_3_0.damage2CureRate = 0
	arg_3_0.damage2CureSkill = nil
	arg_3_0.jiuxianPutongDamageAddRatio = 0
	arg_3_0.jiuxianPutongDamageAddAbs = 0
	arg_3_0.lastQteLeftRound = -100
	arg_3_0.lastQteRightRound = -100
	arg_3_0.qteEval = 0
	arg_3_0.qteComboCount = 0
	arg_3_0.qteTarget = nil
	arg_3_0.hasBossHalo = false

	local var_3_0 = arg_3_0:getTemplateId()

	arg_3_0.heroRecord = zbHeroTable:getRecord(var_3_0)

	if arg_3_0.heroRecord == nil then
		echoInfo("zbHero:init: roleTempalte == nil(templateId=" .. var_3_0 .. ")")

		return
	end

	arg_3_0.avatarRecord = zbAvatarTable:getRecord(arg_3_0.heroRecord.avatarId)

	if arg_3_0.avatarRecord == nil then
		echoInfo("zbHero:init: monster == nil")

		return
	end

	arg_3_0.buffHead = zbHeroBuff:create(arg_3_0, BUFF_POS_HEAD)
	arg_3_0.buffFront = zbHeroBuff:create(arg_3_0, BUFF_POS_FRONT)
	arg_3_0.buffGround = zbHeroBuff:create(arg_3_0, BUFF_POS_GROUND)
	arg_3_0.hud = zbHeroHud:create(arg_3_0)
	arg_3_0.shadow = zbHeroShadow:create(arg_3_0)
	arg_3_0.anim = zbHeroAnimation:create(arg_3_0)
	arg_3_0.focus = zbHeroFocus:create(arg_3_0)
	arg_3_0.qte = zbHeroQte:create(arg_3_0)
	arg_3_0.stateMachine = zbHeroStateMachine:create(arg_3_0)
	arg_3_0.energy = zbHeroEnergy:create(arg_3_0)

	arg_3_0:updateRotationY()
	arg_3_0:createPassiveSkillBubble()

	if arg_3_0.avatarRecord.templateId == 601 then
		arg_3_0.goldEmitter = zbHeroGoldEmitter:create(arg_3_0)
	end

	arg_3_0:checkBossHalo()

	if g_FirstCombat:isActive() then
		arg_3_0:caclFirstCombatProperty()
	elseif g_CombatSystem:getCombatType() == COMBAT_TYPE_LOCALTEST then
		arg_3_0:caclLocalProperty()
	else
		arg_3_0:caclServerProperty(arg_3_2)
	end

	arg_3_0:loadSkill()
	arg_3_0:saveBackupSkillPoint()

	arg_3_0.recordExtraDodge = 0
	arg_3_0.recordExtraViolent = 0
	arg_3_0.recordExtraResist = 0
	arg_3_0.recordExtraMagicResist = 0
	arg_3_0.yandiYunEnable = false
	arg_3_0.qinyin = false
	arg_3_0.qinyinCureValue = 0
	arg_3_0.backupExp = 0

	local var_3_1 = g_Self.kHeroHandler:getHeroByTemplateId(arg_3_0:getTemplateId())

	if var_3_1 ~= nil then
		arg_3_0.backupExp = var_3_1.HeroBaseInfo.Exp
	end
end

function zbHero.free(arg_4_0)
	if arg_4_0.anim ~= nil then
		arg_4_0.anim:free()
	end

	g_BuffSystem:removeHeroAllBuff(arg_4_0)
	g_EffectSystem:removeByHero(arg_4_0)

	if arg_4_0.buffHead ~= nil then
		arg_4_0.buffHead:free()
	end

	if arg_4_0.buffFront ~= nil then
		arg_4_0.buffFront:free()
	end

	if arg_4_0.buffGround ~= nil then
		arg_4_0.buffGround:free()
	end

	arg_4_0:stopAllActions()
	arg_4_0:removeFromParentAndCleanup(true)
end

function zbHero.clearHeroAddedProperty(arg_5_0)
	arg_5_0:resetQteSection()
	g_BuffSystem:removeHeroBuffById(arg_5_0, 1)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 2)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 3)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 4)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 5)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 10)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 11)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 55)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 34)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 207)
	g_BuffSystem:removeHeroBuffById(arg_5_0, 204)
	g_BuffSystem:removeHeroAllDebuff(arg_5_0)

	if g_CombatSystem:isPvPCombatType() == false then
		return
	end

	g_BuffSystem:removeHeroAllBuff(arg_5_0)
	arg_5_0:updateFightProperty()
end

function zbHero.saveBackupSkillPoint(arg_6_0)
	local var_6_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_6_0:getTemplateId())

	if var_6_0 ~= nil then
		arg_6_0.backupSkillPoint = var_6_0.HeroSubInfo.SkillPoint
	else
		arg_6_0.backupSkillPoint = 0
	end
end

function zbHero.getBackupSkillPoint(arg_7_0)
	return arg_7_0.backupSkillPoint
end

function zbHero.loadSkill(arg_8_0)
	function parseSkillSequence(arg_9_0)
		local var_9_0 = wzUnserialize(arg_9_0)
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			var_9_1[iter_9_0] = tonumber(iter_9_1)
		end

		return var_9_1
	end

	local function var_8_0(arg_10_0)
		if arg_10_0 == arg_8_0.heroRecord.skillId0 or arg_10_0 == arg_8_0.heroRecord.skillId1 or arg_8_0:getSkillLevel(arg_10_0) > 0 then
			local var_10_0 = g_SkillSystem:createSkill(arg_8_0, arg_10_0)

			if var_10_0 ~= nil then
				table.insert(arg_8_0.skillList, var_10_0)

				if arg_10_0 == arg_8_0.heroRecord.skillId1 then
					var_10_0.isBigSkill = true
				end
			elseif arg_10_0 ~= 0 and arg_10_0 ~= -1 then
				echo("------------------ invalid skillId = " .. arg_10_0)
			end
		end
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.heroRecord.skillSequence) do
		local var_8_1 = arg_8_0:getSkillIdBySequence(iter_8_1)

		if arg_8_0:getSkillLevel(var_8_1) > 0 then
			table.insert(arg_8_0.mySkillSequence, iter_8_1)
		end
	end

	arg_8_0.skillList = {}
	arg_8_0.bigSkill = nil

	var_8_0(arg_8_0.heroRecord.skillId0)
	var_8_0(arg_8_0.heroRecord.skillId1)
	var_8_0(arg_8_0.heroRecord.skillId2)
	var_8_0(arg_8_0.heroRecord.skillId3)
	var_8_0(arg_8_0.heroRecord.skillId4)

	for iter_8_2, iter_8_3 in pairs(arg_8_0.skillList) do
		if iter_8_3.isBigSkill then
			arg_8_0.bigSkill = iter_8_3

			break
		end
	end

	arg_8_0.curSkillSequenceIndex = -1
end

function zbHero.getSkillIdBySequence(arg_11_0, arg_11_1)
	if arg_11_1 == 0 then
		return arg_11_0.heroRecord.skillId0
	elseif arg_11_1 == 1 then
		return arg_11_0.heroRecord.skillId1
	elseif arg_11_1 == 2 then
		return arg_11_0.heroRecord.skillId2
	elseif arg_11_1 == 3 then
		return arg_11_0.heroRecord.skillId3
	elseif arg_11_1 == 4 then
		return arg_11_0.heroRecord.skillId4
	else
		return 0
	end
end

function zbHero.getSkillById(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.skillList) do
		if iter_12_1.skillId == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function zbHero.getBigSkill(arg_13_0)
	return arg_13_0.bigSkill
end

function zbHero.caclServerProperty(arg_14_0, arg_14_1)
	local var_14_0 = zbHeroHelper:getHeroAttributeTable(arg_14_1)

	arg_14_0.force = var_14_0[EAttrType.Force]
	arg_14_0.intelligence = var_14_0[EAttrType.Intelligence]
	arg_14_0.tili = var_14_0[EAttrType.Tili]
	arg_14_0.physicAttack = var_14_0[EAttrType.PhysicAttack]
	arg_14_0.physicDefend = var_14_0[EAttrType.PhysicDefend]
	arg_14_0.magicAttack = var_14_0[EAttrType.MagicAttack]
	arg_14_0.magicDefend = var_14_0[EAttrType.MagicDefend]
	arg_14_0.hit = var_14_0[EAttrType.Hit]
	arg_14_0.dodge = var_14_0[EAttrType.Dodge]
	arg_14_0.violent = var_14_0[EAttrType.Violent]
	arg_14_0.tough = var_14_0[EAttrType.Tough]
	arg_14_0.pierceDamage = var_14_0[EAttrType.PierceDamage]
	arg_14_0.block = var_14_0[EAttrType.Block]

	if arg_14_0:isLevelBoss() then
		arg_14_0:addExtraPhysicDamageRatio(0.5)
		arg_14_0:addExtraMagicDamageRatio(0.5)
	elseif arg_14_0:isLegionBoss() then
		arg_14_0:addExtraPhysicDamageRatio(1.5)
		arg_14_0:addExtraMagicDamageRatio(1.5)
	elseif arg_14_0:isFriendBoss() then
		arg_14_0:addExtraPhysicDamageRatio(0.5)
		arg_14_0:addExtraMagicDamageRatio(0.5)
	elseif arg_14_0:isWorldBoss() then
		arg_14_0:addExtraPhysicDamageRatio(2)
		arg_14_0:addExtraMagicDamageRatio(2)
	end

	arg_14_0.curHp = var_14_0[EAttrType.HP]
	g_ShowBubble = false
	g_ShowHp = false

	if arg_14_0:isLevelBoss() then
		arg_14_0.curHp = arg_14_0.curHp * 5
	elseif arg_14_0:isLegionBoss() then
		arg_14_0.curHp = arg_14_0.curHp * 720
	elseif arg_14_0:isFriendBoss() and zbUtil:isValidTable(g_Self.kFriendHandler.curBossInfo) then
		if g_Self.kFriendHandler.curBossInfo.BossDegree == 1 then
			arg_14_0.curHp = arg_14_0.curHp * 30
		elseif g_Self.kFriendHandler.curBossInfo.BossDegree == 2 then
			arg_14_0.curHp = arg_14_0.curHp * 100
		end
	elseif arg_14_0:isWorldBoss() then
		arg_14_0.curHp = arg_14_0.curHp * 9000
	end

	g_ShowBubble = true
	g_ShowHp = true
	arg_14_0.maxHp = arg_14_0.curHp
	arg_14_0.baseMaxHp = arg_14_0.maxHp

	if arg_14_0:isBigBoss() and g_CombatSystem.combatType == COMBAT_TYPE_LEGIONBOSS and g_Self.kLegionHandler.fightBossInfo then
		arg_14_0.curHp = math.max(1, arg_14_0.maxHp * g_Self.kLegionHandler.fightBossInfo.LeftHp / 100)
	end

	if arg_14_0:isBigBoss() and g_CombatSystem.combatType == COMBAT_TYPE_FRIENDBOSS and g_Self.kFriendHandler.curBossInfo then
		arg_14_0.curHp = math.max(1, arg_14_0.maxHp * g_Self.kFriendHandler.curBossInfo.HpPercent / 100)
	end

	arg_14_0.bigBossInitHp = arg_14_0.curHp
	arg_14_0.curMp = 0
	arg_14_0.maxMp = 100
	arg_14_0.lastMpFullAccumTime = 0
	arg_14_0.damageStat = 0

	if g_CombatSystem:isPvPCombatType() then
		arg_14_0.curMp = 20
	elseif arg_14_0.forceType == ForceType.Left then
		arg_14_0.curMp = 70
	end

	arg_14_0.basePhysicAttack = arg_14_0.physicAttack
	arg_14_0.basePhysicDefend = arg_14_0.physicDefend
	arg_14_0.baseMagicAttack = arg_14_0.magicAttack
	arg_14_0.baseMagicDefend = arg_14_0.magicDefend
	arg_14_0.baseHit = arg_14_0.hit
	arg_14_0.baseDodge = arg_14_0.dodge
	arg_14_0.baseViolent = arg_14_0.violent
	arg_14_0.baseTough = arg_14_0.tough
	arg_14_0.basePierceDamage = arg_14_0.pierceDamage
	arg_14_0.baseBlock = arg_14_0.block

	arg_14_0:printProperty()
end

function zbHero.caclLocalProperty(arg_15_0)
	local function var_15_0()
		return arg_15_0.heroRecord.forceBase + arg_15_0.heroRecord.forceGrowth * (arg_15_0:getLevel() - 1)
	end

	local function var_15_1()
		return arg_15_0.heroRecord.intelligenceBase + arg_15_0.heroRecord.intelligenceGrowth * (arg_15_0:getLevel() - 1)
	end

	local function var_15_2()
		return arg_15_0.heroRecord.tiliBase + arg_15_0.heroRecord.tiliGrowth * (arg_15_0:getLevel() - 1)
	end

	arg_15_0.force = var_15_0()
	arg_15_0.intelligence = var_15_1()
	arg_15_0.tili = var_15_2()
	arg_15_0.physicAttack = arg_15_0.heroRecord.physicAttackBase + arg_15_0.force * 2 + arg_15_0.tili * 1
	arg_15_0.physicDefend = arg_15_0.heroRecord.physicDefendBase + arg_15_0.force * 1 + arg_15_0.tili * 1
	arg_15_0.magicAttack = arg_15_0.heroRecord.magicAttackBase + arg_15_0.intelligence * 2
	arg_15_0.magicDefend = arg_15_0.heroRecord.magicDefendBase + arg_15_0.intelligence * 1
	arg_15_0.hit = 950 + arg_15_0.heroRecord.hitBase
	arg_15_0.dodge = arg_15_0.heroRecord.dodgeBase
	arg_15_0.violent = 50 + arg_15_0.heroRecord.violentBase
	arg_15_0.tough = arg_15_0.heroRecord.toughBase
	arg_15_0.pierceDamage = arg_15_0.heroRecord.pierceDamageBase
	arg_15_0.block = arg_15_0.heroRecord.blockBase
	arg_15_0.curHp = (arg_15_0.heroRecord.hpBase + arg_15_0.tili * 10) * 10
	arg_15_0.maxHp = arg_15_0.curHp
	arg_15_0.baseMaxHp = arg_15_0.maxHp
	arg_15_0.curMp = 0
	arg_15_0.maxMp = 100
	arg_15_0.damageStat = 0
	arg_15_0.basePhysicAttack = arg_15_0.physicAttack
	arg_15_0.basePhysicDefend = arg_15_0.physicDefend
	arg_15_0.baseMagicAttack = arg_15_0.magicAttack
	arg_15_0.baseMagicDefend = arg_15_0.magicDefend
	arg_15_0.baseHit = arg_15_0.hit
	arg_15_0.baseDodge = arg_15_0.dodge
	arg_15_0.baseViolent = arg_15_0.violent
	arg_15_0.baseTough = arg_15_0.tough
	arg_15_0.basePierceDamage = arg_15_0.pierceDamage
	arg_15_0.baseBlock = arg_15_0.block

	arg_15_0:printProperty()
end

function zbHero.caclFirstCombatProperty(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = 0
	local var_19_2 = 0
	local var_19_3 = 0
	local var_19_4 = 0

	if arg_19_0.heroRecord.id == 1013 then
		var_19_0 = 11772
		var_19_1 = 7848
		var_19_2 = 15696
		var_19_3 = 7848
		var_19_4 = 68860
	elseif arg_19_0.heroRecord.id == 1001 then
		var_19_0 = 19620
		var_19_1 = 11772
		var_19_2 = 7848
		var_19_3 = 3924
		var_19_4 = 58860
	elseif arg_19_0.heroRecord.id == 1013 then
		var_19_0 = 1
		var_19_1 = 1
		var_19_2 = 1
		var_19_3 = 2000
		var_19_4 = 25000
	end

	arg_19_0.force = 1
	arg_19_0.intelligence = 1
	arg_19_0.tili = 1
	arg_19_0.physicAttack = var_19_0
	arg_19_0.physicDefend = var_19_1
	arg_19_0.magicAttack = var_19_2
	arg_19_0.magicDefend = var_19_3
	arg_19_0.hit = 950 + arg_19_0.heroRecord.hitBase
	arg_19_0.dodge = arg_19_0.heroRecord.dodgeBase
	arg_19_0.violent = 50 + arg_19_0.heroRecord.violentBase
	arg_19_0.tough = arg_19_0.heroRecord.toughBase
	arg_19_0.pierceDamage = arg_19_0.heroRecord.pierceDamageBase
	arg_19_0.block = arg_19_0.heroRecord.blockBase
	arg_19_0.curHp = var_19_4
	arg_19_0.maxHp = arg_19_0.curHp
	arg_19_0.baseMaxHp = arg_19_0.maxHp
	arg_19_0.curMp = 0
	arg_19_0.maxMp = 100
	arg_19_0.damageStat = 0
	arg_19_0.basePhysicAttack = arg_19_0.physicAttack
	arg_19_0.basePhysicDefend = arg_19_0.physicDefend
	arg_19_0.baseMagicAttack = arg_19_0.magicAttack
	arg_19_0.baseMagicDefend = arg_19_0.magicDefend
	arg_19_0.baseHit = arg_19_0.hit
	arg_19_0.baseDodge = arg_19_0.dodge
	arg_19_0.baseViolent = arg_19_0.violent
	arg_19_0.baseTough = arg_19_0.tough
	arg_19_0.basePierceDamage = arg_19_0.pierceDamage
	arg_19_0.baseBlock = arg_19_0.block

	arg_19_0:printProperty()
end

function zbHero.printProperty(arg_20_0)
	return
end

function zbHero.getSkillLevel(arg_21_0, arg_21_1)
	if arg_21_0.heroBattleData.SkillList == nil then
		return 1
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0.heroBattleData.SkillList) do
		if iter_21_1.SkillId == arg_21_1 then
			return iter_21_1.Level
		end
	end

	echo("------------- can not find hero sklll level info: " .. arg_21_1)

	return 0
end

function zbHero.update(arg_22_0, arg_22_1)
	arg_22_0.stateMachine:update(arg_22_1)
	arg_22_0.anim:update(arg_22_1)
	arg_22_0.hud:update(arg_22_1)
	arg_22_0.shadow:update(arg_22_1)
	arg_22_0.focus:update(arg_22_1)
	arg_22_0.qte:update(arg_22_1)
	arg_22_0:updateZOrder(arg_22_1)
	arg_22_0:updateBeattackedSkill(arg_22_1)
	arg_22_0:updatePassiveSkillBubble(arg_22_1)
	arg_22_0.buffHead:update(arg_22_1)
	arg_22_0.buffFront:update(arg_22_1)
	arg_22_0.buffGround:update(arg_22_1)
	arg_22_0:updateRotationY()
	arg_22_0:updateRoundSkill(arg_22_1)
	arg_22_0:updateRoundEndFlag()
	arg_22_0:updateLastMpFullTime(arg_22_1)

	if arg_22_0.goldEmitter ~= nil then
		arg_22_0.goldEmitter:update(arg_22_1)
	end
end

function zbHero.updateLastMpFullTime(arg_23_0, arg_23_1)
	if arg_23_0.curMp >= arg_23_0.maxMp then
		arg_23_0.lastMpFullAccumTime = arg_23_0.lastMpFullAccumTime + arg_23_1
	else
		arg_23_0.lastMpFullAccumTime = 0
	end
end

function zbHero.updateRotationY(arg_24_0)
	arg_24_0.anim:setRotationY(arg_24_0:getRotationY())
end

function zbHero.getRotationY(arg_25_0)
	if arg_25_0:isMeihuo() then
		return HeroRotateY[arg_25_0.forceType] + 180
	else
		return HeroRotateY[arg_25_0.forceType]
	end
end

function zbHero.clearRoundFlag(arg_26_0)
	arg_26_0.curSkill = nil
	arg_26_0.roundEnded = false
end

function zbHero.newMyRound(arg_27_0, arg_27_1)
	if arg_27_0:isDie() == false then
		if arg_27_0.buffRoundHpAdd ~= 0 and arg_27_1 > 1 then
			arg_27_0:addHp(arg_27_0.buffRoundHpAdd, false, 1)
		end

		arg_27_0.curMp = math.min(arg_27_0.curMp + arg_27_0.buffRoundMpAdd, arg_27_0.maxMp)

		if arg_27_0:isBigBoss() then
			arg_27_0.curMp = math.min(arg_27_0.curMp + 25, arg_27_0.maxMp)
		else
			arg_27_0.curMp = math.min(arg_27_0.curMp + 20, arg_27_0.maxMp)
		end
	end

	arg_27_0:updateFightProperty()
	g_BuffSystem:newHeroRound(arg_27_0)
end

function zbHero.updateFightProperty(arg_28_0)
	arg_28_0.physicAttack = math.max(0, arg_28_0.absPhysicAttack + arg_28_0.basePhysicAttack)
	arg_28_0.physicDefend = math.max(0, arg_28_0.absPhysicDefend + arg_28_0.basePhysicDefend)
	arg_28_0.magicAttack = math.max(0, arg_28_0.absMagicAttack + arg_28_0.baseMagicAttack)
	arg_28_0.magicDefend = math.max(0, arg_28_0.absMagicDefend + arg_28_0.baseMagicDefend)
	arg_28_0.hit = math.max(0, arg_28_0.absHit + arg_28_0.baseHit)
	arg_28_0.dodge = math.max(0, arg_28_0.absDodge + arg_28_0.baseDodge)
	arg_28_0.violent = math.max(0, arg_28_0.absViolent + arg_28_0.baseViolent)
	arg_28_0.tough = math.max(0, arg_28_0.absTough + arg_28_0.baseTough)
	arg_28_0.pierceDamage = math.max(0, arg_28_0.absPierceDamage + arg_28_0.basePierceDamage)
	arg_28_0.block = math.max(0, arg_28_0.absBlock + arg_28_0.baseBlock)
end

function zbHero.roundBegin(arg_29_0)
	echo(string.format("%s%s %s", ForceTypeDesc[arg_29_0.forceType], arg_29_0.heroRecord.name, a2u(" \xD7\xD4\xC9\xED\xBBغϿ\xAAʼ")))
	arg_29_0:newMyRound(g_CombatRound:getCurRound())

	arg_29_0.accumRoundCount = arg_29_0.accumRoundCount + 1
	arg_29_0.roundEnded = false

	arg_29_0:execSequenceSkill()
	arg_29_0:resetQteRound()
end

function zbHero.roundBeginQteNormal(arg_30_0)
	arg_30_0.roundEnded = false

	local var_30_0 = arg_30_0:getSkillIdBySequence(0)

	arg_30_0.curSkill = arg_30_0:getSkillById(var_30_0)

	arg_30_0.curSkill:execSkill(true)
end

function zbHero.roundSimpleNoAction(arg_31_0)
	arg_31_0.accumRoundCount = arg_31_0.accumRoundCount + 1

	arg_31_0:newMyRound(g_CombatRound:getCurRound())
end

function zbHero.isRoundEnd(arg_32_0)
	return arg_32_0.roundEnded
end

function zbHero.hasSkillExecing(arg_33_0)
	return arg_33_0.curSkill ~= nil and arg_33_0.curSkill:isActioning()
end

function zbHero.execLootSkill(arg_34_0, arg_34_1)
	arg_34_0.roundEnded = false
	arg_34_0.curSkill = arg_34_1

	if arg_34_0.curSkill ~= nil then
		arg_34_0.curSkill:execSkill()
	else
		local var_34_0 = arg_34_0:getSkillIdBySequence(0)
		local var_34_1 = a2u("\xBB\xEF\xB0鼼\xC4ܲ\xBB\xB4\xE6\xD4\xDA:") .. arg_34_0.heroRecord.name .. ", skillId=" .. var_34_0

		arg_34_0.roundEnded = true

		echo(var_34_1)
	end
end

function zbHero.execSequenceSkill(arg_35_0)
	if g_CombatSystem:isPvPCombatType() == false and arg_35_0.forceType == ForceType.Right and arg_35_0:checkAndExecBigSkill() then
		echo(arg_35_0.heroRecord.name .. a2u(" \xB5з\xBD\xD7\xD4\xC9\xED\xBBغ\xCFִ\xD0\xD0\xC1˴\xF3\xD5\xD0: ") .. a2u(arg_35_0.curSkill.skillRecord.name))

		return true
	end

	arg_35_0.curSkill = (function()
		if arg_35_0:isMeihuo() then
			local var_36_0 = arg_35_0:getSkillIdBySequence(0)

			return (arg_35_0:getSkillById(var_36_0))
		end

		local var_36_1 = table.getn(arg_35_0.mySkillSequence)

		if arg_35_0.curSkillSequenceIndex < 0 then
			arg_35_0.curSkillSequenceIndex = 1
		elseif var_36_1 <= arg_35_0.curSkillSequenceIndex then
			arg_35_0.curSkillSequenceIndex = 1
		else
			arg_35_0.curSkillSequenceIndex = arg_35_0.curSkillSequenceIndex + 1
		end

		local var_36_2 = arg_35_0:getSkillIdBySequence(arg_35_0.mySkillSequence[arg_35_0.curSkillSequenceIndex])

		if g_FirstCombat:isActive() then
			var_36_2 = g_FirstCombat:getAttackSkillId(arg_35_0)
		end

		return (arg_35_0:getSkillById(var_36_2))
	end)()

	if arg_35_0.curSkill ~= nil then
		if g_FirstCombat:isActive() and arg_35_0.curSkill.isBigSkill and arg_35_0.curMp >= 100 and arg_35_0:checkAndExecBigSkill() then
			echo(arg_35_0.heroRecord.name .. a2u(" \xB5з\xBD\xD7\xD4\xC9\xED\xBBغ\xCFִ\xD0\xD0\xC1˴\xF3\xD5\xD0: ") .. a2u(arg_35_0.curSkill.skillRecord.name))

			return
		end

		arg_35_0.curSkill:execSkill()
	else
		local var_35_0 = arg_35_0:getSkillIdBySequence(arg_35_0.mySkillSequence[arg_35_0.curSkillSequenceIndex])
		local var_35_1 = a2u("\xBB\xEF\xB0鼼\xC4ܲ\xBB\xB4\xE6\xD4\xDA:") .. arg_35_0.heroRecord.name .. ", skillId=" .. var_35_0

		arg_35_0.roundEnded = true

		echo(var_35_1)
	end
end

function zbHero.checkAutoBigSkill(arg_37_0)
	local var_37_0 = true

	if g_CombatSystem:isPvPCombatType() == false and arg_37_0.forceType == ForceType.Right then
		var_37_0 = false
	elseif g_CombatSystem:isPvPCombatType() == false and arg_37_0.forceType == ForceType.Left and g_CombatSystem:isAutoCombat() == false then
		var_37_0 = false
	end

	if var_37_0 and arg_37_0.lastMpFullAccumTime > 1 and arg_37_0:checkAndExecBigSkill() then
		echo(arg_37_0.heroRecord.name .. a2u(" \xD7\xD4\xC9\xED\xBBغ\xCFִ\xD0\xD0\xC1˴\xF3\xD5\xD0: ") .. a2u(arg_37_0.curSkill.skillRecord.name))

		return true
	end

	return false
end

function zbHero.updateRoundSkill(arg_38_0, arg_38_1)
	if arg_38_0.curSkill ~= nil then
		arg_38_0.curSkill:update(arg_38_1)
	end
end

function zbHero.updateRoundEndFlag(arg_39_0)
	if arg_39_0.roundEnded == false and arg_39_0.curSkill ~= nil and arg_39_0.curSkill:isActioning() == false then
		arg_39_0.curSkill:checkHitedTargetPassiveSkill()

		arg_39_0.curSkill = nil
		arg_39_0.roundEnded = true
	end
end

function zbHero.execPassiveSkill(arg_40_0, arg_40_1)
	if arg_40_0:isHunmi() then
		return
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_0.skillList) do
		if iter_40_1.isPassiveSkill == true and iter_40_1.passiveTriggerType == arg_40_1 then
			iter_40_1:execSkill()
		end
	end
end

function zbHero.updateBeattackedSkill(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.skillList) do
		if iter_41_1.passiveTriggerType == EPassiveTriggerType.Beattacked and iter_41_1:isActioning() then
			iter_41_1:update(arg_41_1)
		end
	end
end

function zbHero.isExecBeattackedSkill(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.skillList) do
		if iter_42_1.passiveTriggerType == EPassiveTriggerType.Beattacked and iter_42_1:isActioning() then
			return true
		end
	end

	return false
end

function zbHero.hasLootAttackSkill(arg_43_0)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.skillList) do
		if iter_43_1.passiveTriggerType == EPassiveTriggerType.LootAttack then
			return true
		end
	end

	return false
end

function zbHero.execLootAttackSkill(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.skillList) do
		if iter_44_1.passiveTriggerType == EPassiveTriggerType.LootAttack and arg_44_0:isHunmi() == false and iter_44_1:checkTriggerRate() then
			arg_44_0:execLootSkill(iter_44_1)

			return true
		end
	end

	return false
end

function zbHero.lootAttackIsOver(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.skillList) do
		if iter_45_1.passiveTriggerType == EPassiveTriggerType.LootAttack and arg_45_0.curSkill ~= nil then
			return arg_45_0.curSkill:isActioning() == false
		end
	end

	return true
end

function zbHero.getFlipPlayer(arg_46_0)
	if arg_46_0.forceType == ForceType.Left then
		return g_CombatSystem.combatData.rightPlayer
	else
		return g_CombatSystem.combatData.leftPlayer
	end
end

function zbHero.checkAndExecBigSkill(arg_47_0)
	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return false
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return false
	end

	if g_CombatSystem:getLegend():isExecBigSkilling() or g_CombatSystem:getEnemyLegend():isExecBigSkilling() then
		return false
	end

	if arg_47_0.curMp < arg_47_0.maxMp then
		return false
	end

	if arg_47_0:getFlipPlayer():getCurTotalHp() <= 0 then
		return false
	end

	if arg_47_0:isChenmo() or arg_47_0:isHunmi() or arg_47_0:isMeihuo() then
		return false
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		return false
	end

	if g_CombatSystem.combatData.combatQte:getQteTarget() ~= nil then
		return false
	end

	local var_47_0 = arg_47_0:getBigSkill()

	if var_47_0 ~= nil then
		if arg_47_0.curSkill ~= nil then
			arg_47_0.curSkill:immediatelyEnd()

			arg_47_0.curSkill = nil
		end

		var_47_0:execSkill()

		arg_47_0.curMp = 0
		arg_47_0.curSkill = var_47_0
		g_CombatRound.sequenceRound.lastNormalSeqTime = 0

		return true
	end

	return false
end

function zbHero.isExecBigSkilling(arg_48_0)
	local var_48_0 = arg_48_0:getBigSkill()

	if var_48_0 ~= nil then
		return var_48_0:isActioning()
	end

	return false
end

function zbHero.addPhysicReduceRate(arg_49_0, arg_49_1)
	arg_49_0.physicReduceRate = arg_49_0.physicReduceRate + arg_49_1
end

function zbHero.addPhysicReduce(arg_50_0, arg_50_1)
	arg_50_0.physicReduce = arg_50_0.physicReduce + arg_50_1
end

function zbHero.getPhysicReduce(arg_51_0)
	if zbCombatFormula:isSucceedRate(arg_51_0.physicReduceRate * 1000) then
		return arg_51_0.physicReduce
	else
		return 0
	end
end

function zbHero.addMagicReduceRate(arg_52_0, arg_52_1)
	arg_52_0.magicReduceRate = arg_52_0.magicReduceRate + arg_52_1
end

function zbHero.addMagicReduce(arg_53_0, arg_53_1)
	arg_53_0.magicReduce = arg_53_0.magicReduce + arg_53_1
end

function zbHero.getMagicReduce(arg_54_0)
	if zbCombatFormula:isSucceedRate(arg_54_0.magicReduceRate * 1000) then
		return arg_54_0.magicReduce
	else
		return 0
	end
end

function zbHero.addPMReduceRate(arg_55_0, arg_55_1)
	arg_55_0.pmReduceRate = arg_55_0.pmReduceRate + arg_55_1
end

function zbHero.addPMReduce(arg_56_0, arg_56_1)
	arg_56_0.pmReduceAbs = arg_56_0.pmReduceAbs + arg_56_1
end

function zbHero.addPMReduceRatio(arg_57_0, arg_57_1)
	arg_57_0.pmReduceRatio = arg_57_0.pmReduceRatio + arg_57_1
end

function zbHero.getPMReduceRatio(arg_58_0)
	return arg_58_0.pmReduceRatio
end

function zbHero.getPMReduceAbs(arg_59_0)
	return arg_59_0.pmReduceAbs
end

function zbHero.isCanPMReduce(arg_60_0)
	if arg_60_0.pmReduceRate <= 0 then
		return false
	end

	return zbCombatFormula:isSucceedRate(arg_60_0.pmReduceRate * 1000)
end

function zbHero.setImmunePhysic(arg_61_0, arg_61_1)
	arg_61_0.bImmunePhysic = arg_61_1
end

function zbHero.isImmunePhysic(arg_62_0)
	return arg_62_0.bImmunePhysic
end

function zbHero.setImmuneMagic(arg_63_0, arg_63_1)
	arg_63_0.bImmuneMagic = arg_63_1
end

function zbHero.isImmuneMagic(arg_64_0)
	return arg_64_0.bImmuneMagic
end

function zbHero.setHunmi(arg_65_0, arg_65_1)
	arg_65_0.bHunmi = arg_65_1
end

function zbHero.isHunmi(arg_66_0)
	return arg_66_0.bHunmi
end

function zbHero.setMeihuo(arg_67_0, arg_67_1)
	arg_67_0.bMeihuo = arg_67_1
end

function zbHero.isMeihuo(arg_68_0)
	return arg_68_0.bMeihuo
end

function zbHero.setChenmo(arg_69_0, arg_69_1)
	arg_69_0.bChenmo = arg_69_1
end

function zbHero.isChenmo(arg_70_0)
	return arg_70_0.bChenmo
end

function zbHero.setChaofengSrc(arg_71_0, arg_71_1)
	arg_71_0.chaofengSrc = arg_71_1
end

function zbHero.getChaofengSrc(arg_72_0)
	return arg_72_0.chaofengSrc
end

function zbHero.setZhongshang(arg_73_0, arg_73_1)
	arg_73_0.bZhongshang = arg_73_1
end

function zbHero.isZhongshang(arg_74_0)
	return arg_74_0.bZhongshang
end

function zbHero.setZhongdu(arg_75_0, arg_75_1)
	arg_75_0.bZhongdu = arg_75_1
end

function zbHero.isZhongdu(arg_76_0)
	return arg_76_0.bZhongdu
end

function zbHero.setFire(arg_77_0, arg_77_1)
	arg_77_0.bFire = arg_77_1
end

function zbHero.isFire(arg_78_0)
	return arg_78_0.bFire
end

function zbHero.addPhysicAttack(arg_79_0, arg_79_1)
	arg_79_0.absPhysicAttack = arg_79_0.absPhysicAttack + arg_79_1

	arg_79_0:updateFightProperty()
end

function zbHero.addPhysicDefend(arg_80_0, arg_80_1)
	arg_80_0.absPhysicDefend = arg_80_0.absPhysicDefend + arg_80_1

	arg_80_0:updateFightProperty()
end

function zbHero.addMagicAttack(arg_81_0, arg_81_1)
	arg_81_0.absMagicAttack = arg_81_0.absMagicAttack + arg_81_1

	arg_81_0:updateFightProperty()
end

function zbHero.addMagicDefend(arg_82_0, arg_82_1)
	arg_82_0.absMagicDefend = arg_82_0.absMagicDefend + arg_82_1

	arg_82_0:updateFightProperty()
end

function zbHero.addHit(arg_83_0, arg_83_1)
	arg_83_0.absHit = arg_83_0.absHit + arg_83_1

	arg_83_0:updateFightProperty()
end

function zbHero.addDodge(arg_84_0, arg_84_1)
	arg_84_0.absDodge = arg_84_0.absDodge + arg_84_1

	arg_84_0:updateFightProperty()
end

function zbHero.addViolent(arg_85_0, arg_85_1)
	arg_85_0.absViolent = arg_85_0.absViolent + arg_85_1

	arg_85_0:updateFightProperty()
end

function zbHero.addTough(arg_86_0, arg_86_1)
	arg_86_0.absTough = arg_86_0.absTough + arg_86_1

	arg_86_0:updateFightProperty()
end

function zbHero.addPierceDamage(arg_87_0, arg_87_1)
	arg_87_0.absPierceDamage = arg_87_0.absPierceDamage + arg_87_1

	arg_87_0:updateFightProperty()
end

function zbHero.addBlock(arg_88_0, arg_88_1)
	arg_88_0.absBlock = math.max(arg_88_0.absBlock + arg_88_1, 0)

	arg_88_0:updateFightProperty()
end

function zbHero.addBuffRoundHp(arg_89_0, arg_89_1)
	arg_89_0.buffRoundHpAdd = arg_89_0.buffRoundHpAdd + arg_89_1

	arg_89_0:updateFightProperty()
end

function zbHero.addBuffRoundMp(arg_90_0, arg_90_1)
	arg_90_0.buffRoundMpAdd = arg_90_0.buffRoundMpAdd + arg_90_1

	arg_90_0:updateFightProperty()
end

function zbHero.addBuffMaxHp(arg_91_0, arg_91_1)
	if arg_91_1 < 0 then
		echo("warning: invalid reduceBuffMaxHp param: " .. arg_91_1)

		return
	end

	arg_91_0.buffMaxHpAdd = arg_91_0.buffMaxHpAdd + arg_91_1

	local var_91_0 = arg_91_0.maxHp

	arg_91_0.maxHp = math.max(1, arg_91_0.baseMaxHp + arg_91_0.baseMaxHp * arg_91_0.buffMaxHpAdd)

	arg_91_0:addHp(arg_91_0.maxHp - var_91_0, false, 1, 0)
end

function zbHero.reduceBuffMaxHp(arg_92_0, arg_92_1)
	if arg_92_1 < 0 then
		echo("warning: invalid reduceBuffMaxHp param: " .. arg_92_1)

		return
	end

	arg_92_0.buffMaxHpAdd = arg_92_0.buffMaxHpAdd - arg_92_1
	arg_92_0.maxHp = math.max(1, arg_92_0.baseMaxHp + arg_92_0.baseMaxHp * arg_92_0.buffMaxHpAdd)
	arg_92_0.curHp = math.max(1, math.min(arg_92_0.curHp, arg_92_0.maxHp))
end

function zbHero.addBuffMaxHpPoint(arg_93_0, arg_93_1)
	arg_93_0:addBuffMaxHp(arg_93_1 / arg_93_0.baseMaxHp)
end

function zbHero.reduceBuffMaxHpPoint(arg_94_0, arg_94_1)
	arg_94_0:reduceBuffMaxHp(arg_94_1 / arg_94_0.baseMaxHp)
end

function zbHero.addExtraPhysicDamageRatio(arg_95_0, arg_95_1)
	arg_95_0.extraPhysicDamageRatio = arg_95_0.extraPhysicDamageRatio + arg_95_1
end

function zbHero.addExtraPhysicDamageAbs(arg_96_0, arg_96_1)
	arg_96_0.extraPhysicDamageAbs = arg_96_0.extraPhysicDamageAbs + arg_96_1
end

function zbHero.addExtraMagicDamageRatio(arg_97_0, arg_97_1)
	arg_97_0.extraMagicDamageRatio = arg_97_0.extraMagicDamageRatio + arg_97_1
end

function zbHero.addExtraMagicDamageAbs(arg_98_0, arg_98_1)
	arg_98_0.extraMagicDamageAbs = arg_98_0.extraMagicDamageAbs + arg_98_1
end

function zbHero.addExtraPhysicDamageDefendRatio(arg_99_0, arg_99_1)
	arg_99_0.extraPhysicDamageDefendRatio = arg_99_0.extraPhysicDamageDefendRatio * (1 - arg_99_1)
end

function zbHero.removeExtraPhysicDamageDefendRatio(arg_100_0, arg_100_1)
	arg_100_0.extraPhysicDamageDefendRatio = arg_100_0.extraPhysicDamageDefendRatio / (1 + arg_100_1)
end

function zbHero.addExtraPhysicDamageDefendAbs(arg_101_0, arg_101_1)
	arg_101_0.extraPhysicDamageDefendAbs = arg_101_0.extraPhysicDamageDefendAbs + arg_101_1
end

function zbHero.addExtraMagicDamageDefendRatio(arg_102_0, arg_102_1)
	arg_102_0.extraMagicDamageDefendRatio = arg_102_0.extraMagicDamageDefendRatio * (1 - arg_102_1)
end

function zbHero.removeExtraMagicDamageDefendRatio(arg_103_0, arg_103_1)
	arg_103_0.extraMagicDamageDefendRatio = arg_103_0.extraMagicDamageDefendRatio / (1 + arg_103_1)
end

function zbHero.addExtraMagicDamageDefendAbs(arg_104_0, arg_104_1)
	arg_104_0.extraMagicDamageDefendAbs = arg_104_0.extraMagicDamageDefendAbs + arg_104_1
end

function zbHero.addTargetDebuffDamageAddRatio(arg_105_0, arg_105_1)
	arg_105_0.targetDebuffDamageAddRatio = arg_105_0.targetDebuffDamageAddRatio + arg_105_1
end

function zbHero.addTargetDebuffDamageAddAbs(arg_106_0, arg_106_1)
	arg_106_0.targetDebuffDamageAddAbs = arg_106_0.targetDebuffDamageAddAbs + arg_106_1
end

function zbHero.setCurrState(arg_107_0, arg_107_1)
	arg_107_0.stateMachine:setCurrState(arg_107_1)
end

function zbHero.addHp(arg_108_0, arg_108_1, arg_108_2, arg_108_3, arg_108_4, arg_108_5, arg_108_6)
	local function var_108_0()
		if arg_108_1 > 0 then
			if arg_108_2 then
				if arg_108_0.forceType == ForceType.Left then
					return ECombatBubble.SelfViolentAddHp
				else
					return ECombatBubble.EnemyViolentAddHp
				end
			elseif arg_108_0.forceType == ForceType.Left then
				return ECombatBubble.SelfAddHp
			else
				return ECombatBubble.EnemyAddHp
			end
		elseif arg_108_2 then
			if arg_108_0.forceType == ForceType.Left then
				return ECombatBubble.SelfViolentDecHp
			else
				return ECombatBubble.EnemyViolentDecHp
			end
		elseif arg_108_0.forceType == ForceType.Left then
			return ECombatBubble.SelfDecHp
		else
			return ECombatBubble.EnemyDecHp
		end
	end

	if arg_108_1 == 0 then
		return
	end

	if arg_108_1 > 0 and arg_108_0:isZhongshang() then
		arg_108_1 = arg_108_1 * 0.7
	end

	if arg_108_0.curHp <= 0 and arg_108_1 > 0 then
		arg_108_0:setCurrState(HeroState_Revive)
	end

	if arg_108_1 < 0 and arg_108_0:isBigBoss() then
		arg_108_1 = math.max(arg_108_1, -arg_108_0.maxHp * 0.05)
	end

	if arg_108_1 > 0 then
		arg_108_1 = math.ceil(arg_108_1)
	elseif arg_108_1 < 0 then
		arg_108_1 = math.floor(arg_108_1)
	end

	local var_108_1 = arg_108_0.curHp

	arg_108_0.curHp = arg_108_0.curHp + arg_108_1
	arg_108_0.curHp = zbUtil:clamp(arg_108_0.curHp, 0, arg_108_0.maxHp)

	if arg_108_0.curHp <= 0 then
		arg_108_0.curMp = 0
	end

	arg_108_0.hud:triggerVisible()

	if arg_108_5 == nil then
		arg_108_5 = 0.2
	end

	if arg_108_1 < 0 and arg_108_6 ~= nil then
		arg_108_1 = math.floor(arg_108_1 - math.abs(arg_108_6))
	end

	local var_108_2 = 0
	local var_108_3 = 0
	local var_108_4 = var_108_0()

	for iter_108_0 = 1, arg_108_3 do
		if iter_108_0 < arg_108_3 then
			local var_108_5 = zbUtil:random(96, 104) / 100

			var_108_3 = arg_108_1 / arg_108_3 * var_108_5
			var_108_3 = math.ceil(var_108_3)
			var_108_2 = var_108_2 + var_108_3
		else
			var_108_3 = arg_108_1 - var_108_2
		end

		local var_108_6 = 0.1

		if arg_108_4 ~= nil then
			var_108_6 = arg_108_4
		end

		g_CombatBubble:showBubble(arg_108_0, var_108_4, var_108_3, var_108_6 + (iter_108_0 - 1) * arg_108_5, 0)
	end
end

function zbHero.addMp(arg_110_0, arg_110_1)
	if arg_110_0:isDie() then
		return
	end

	if arg_110_1 > 0 then
		arg_110_1 = math.ceil(arg_110_1)
	elseif arg_110_1 < 0 then
		arg_110_1 = math.floor(arg_110_1)
	end

	arg_110_0.curMp = arg_110_0.curMp + arg_110_1
	arg_110_0.curMp = zbUtil:clamp(arg_110_0.curMp, 0, arg_110_0.maxMp)
end

function zbHero.getHpPercent(arg_111_0)
	return math.min(math.ceil(arg_111_0.curHp * 100 / arg_111_0.maxHp), 100)
end

function zbHero.getBigBossDamagePercent(arg_112_0)
	local var_112_0 = string.format("%.3f", math.max((arg_112_0.bigBossInitHp - arg_112_0.curHp) / arg_112_0.maxHp * 100, 0))

	return (math.min(tonumber(var_112_0), 100))
end

function zbHero.getMpPercent(arg_113_0)
	return math.min(math.ceil(arg_113_0.curMp * 100 / arg_113_0.maxMp), 100)
end

function zbHero.getMsPercent(arg_114_0)
	local var_114_0 = arg_114_0.curPMShield + arg_114_0.curPhysicShield + arg_114_0.curMagicShield
	local var_114_1 = arg_114_0.totalPMShield + arg_114_0.totalPhysicShield + arg_114_0.totalMagicShield

	if var_114_1 > 1 then
		return math.min(math.ceil(var_114_0 * 100 / var_114_1), 100)
	else
		return 0
	end
end

function zbHero.getTemplateId(arg_115_0)
	return arg_115_0.heroBattleData.HeroBaseInfo.TemplateId
end

function zbHero.getFormationIndex(arg_116_0)
	return arg_116_0.heroBattleData.HeroBaseInfo.Index
end

function zbHero.getLevel(arg_117_0)
	return arg_117_0.heroBattleData.HeroBaseInfo.Level
end

function zbHero.getQuality(arg_118_0)
	if arg_118_0.heroBattleData.HeroBaseInfo.Quality == nil then
		return 1
	end

	return arg_118_0.heroBattleData.HeroBaseInfo.Quality
end

function zbHero.getStar(arg_119_0)
	if arg_119_0.heroBattleData.HeroBaseInfo.Star == nil then
		return 1
	end

	return arg_119_0.heroBattleData.HeroBaseInfo.Star
end

function zbHero.isForceHero(arg_120_0)
	return arg_120_0.heroRecord.heroType == EHeroType.Force
end

function zbHero.isIntelligenceHero(arg_121_0)
	return arg_121_0.heroRecord.heroType == EHeroType.Intelligence
end

function zbHero.isTiliHero(arg_122_0)
	return arg_122_0.heroRecord.heroType == EHeroType.Tili
end

function zbHero.getCountry(arg_123_0)
	return arg_123_0.heroRecord.country
end

function zbHero.isCountryWei(arg_124_0)
	return arg_124_0.heroRecord.country == ECountryType.Wei
end

function zbHero.isCountryShu(arg_125_0)
	return arg_125_0.heroRecord.country == ECountryType.Shu
end

function zbHero.isCountryWu(arg_126_0)
	return arg_126_0.heroRecord.country == ECountryType.Wu
end

function zbHero.getBackupExp(arg_127_0)
	return arg_127_0.backupExp
end

function zbHero.isSame(arg_128_0, arg_128_1)
	if arg_128_1 == nil or arg_128_1.forceType ~= arg_128_0.forceType or arg_128_1:getFormationIndex() ~= arg_128_0:getFormationIndex() then
		return false
	end

	return true
end

function zbHero.isDie(arg_129_0)
	return arg_129_0.curHp <= 0
end

function zbHero.addDamageStat(arg_130_0, arg_130_1)
	arg_130_0.damageStat = arg_130_0.damageStat + arg_130_1
end

function zbHero.getDamageStat(arg_131_0)
	return arg_131_0.damageStat
end

function zbHero.getFixPosition(arg_132_0)
	return ccp(arg_132_0.fixPosition.x, arg_132_0.fixPosition.y)
end

function zbHero.getFixPositionX(arg_133_0)
	return arg_133_0.fixPosition.x
end

function zbHero.getBeattackOffset(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = 0
	local var_134_1 = arg_134_1.avatarRecord.parentAvatarId

	if var_134_1 == 1001 then
		if arg_134_2 == 0 then
			var_134_0 = 485
		elseif arg_134_2 == 1 then
			var_134_0 = 300
		elseif arg_134_2 == 2 then
			var_134_0 = 340
		end
	elseif var_134_1 == 1013 then
		if arg_134_2 == 0 then
			var_134_0 = 160
		end
	elseif var_134_1 == 1021 then
		if arg_134_2 == 0 then
			var_134_0 = 300
		end
	elseif var_134_1 == 1022 then
		if arg_134_2 == 0 then
			var_134_0 = 130
		elseif arg_134_2 == 1 then
			var_134_0 = 330
		elseif arg_134_2 == 3 then
			var_134_0 = 65
		end
	elseif var_134_1 == 1024 then
		if arg_134_2 == 0 then
			var_134_0 = 150
		end
	elseif var_134_1 == 1041 then
		if arg_134_2 == 0 then
			var_134_0 = 130
		elseif arg_134_2 == 1 then
			var_134_0 = 330
		end
	elseif var_134_1 == 1043 then
		if arg_134_2 == 0 then
			var_134_0 = 70
		elseif arg_134_2 == 1 then
			var_134_0 = 100
		elseif arg_134_2 == 2 then
			var_134_0 = 0
		end
	elseif var_134_1 == 1044 then
		if arg_134_2 == 0 then
			var_134_0 = 210
		elseif arg_134_2 == 2 then
			var_134_0 = 70
		end
	elseif var_134_1 == 1045 then
		if arg_134_2 == 0 then
			var_134_0 = 145
		end
	elseif var_134_1 == 1051 then
		if arg_134_2 == 1 then
			var_134_0 = 170
		end
	elseif var_134_1 == 1053 then
		if arg_134_2 == 0 then
			var_134_0 = 230
		end
	elseif var_134_1 == 1055 then
		if arg_134_2 == 0 then
			var_134_0 = 85
		end
	elseif var_134_1 == 1062 then
		if arg_134_2 == 0 then
			var_134_0 = 195
		elseif arg_134_2 == 1 then
			var_134_0 = 195
		elseif arg_134_2 == 2 then
			var_134_0 = 300
		end
	elseif var_134_1 == 1064 then
		if arg_134_2 == 0 then
			var_134_0 = 337
		end
	elseif var_134_1 == 1065 then
		if arg_134_2 == 0 then
			var_134_0 = 205
		end
	elseif var_134_1 == 1071 then
		if arg_134_2 == 0 then
			var_134_0 = 250
		elseif arg_134_2 == 1 then
			var_134_0 = 205
		elseif arg_134_2 == 2 then
			var_134_0 = 115
		end
	elseif var_134_1 == 1074 then
		if arg_134_2 == 0 then
			var_134_0 = 30
		end
	elseif var_134_1 == 1081 then
		if arg_134_2 == 0 then
			var_134_0 = 355
		elseif arg_134_2 == 1 then
			var_134_0 = 320
		elseif arg_134_2 == 2 then
			var_134_0 = 290
		end
	elseif var_134_1 == 1082 then
		if arg_134_2 == 0 then
			var_134_0 = 410
		end
	elseif var_134_1 == 1083 then
		if arg_134_2 == 0 then
			var_134_0 = 170
		elseif arg_134_2 == 1 then
			var_134_0 = 170
		end
	elseif var_134_1 == 1084 then
		if arg_134_2 == 0 then
			var_134_0 = 150
		elseif arg_134_2 == 1 then
			var_134_0 = 160
		end
	elseif var_134_1 == 1085 then
		if arg_134_2 == 0 then
			var_134_0 = 170
		elseif arg_134_2 == 1 then
			var_134_0 = 160
		end
	elseif var_134_1 == 1094 then
		if arg_134_2 == 0 then
			var_134_0 = 110
		elseif arg_134_2 == 2 then
			var_134_0 = 120
		end
	elseif var_134_1 == 1201 then
		if arg_134_2 == 2 then
			var_134_0 = 200
		end
	elseif var_134_1 == 1203 then
		if arg_134_2 == 0 then
			var_134_0 = 140
		elseif arg_134_2 == 2 then
			var_134_0 = 20
		end
	elseif var_134_1 == 602 then
		if arg_134_2 == 0 then
			var_134_0 = 580
		elseif arg_134_2 == 2 then
			var_134_0 = 610
		end
	elseif var_134_1 == 21 then
		if arg_134_2 == 0 then
			var_134_0 = 275
		end
	elseif var_134_1 == 22 then
		if arg_134_2 == 0 then
			var_134_0 = 275
		elseif arg_134_2 == 1 then
			var_134_0 = 235
		elseif arg_134_2 == 2 then
			var_134_0 = 305
		end
	elseif var_134_1 == 201 then
		if arg_134_2 == 0 then
			var_134_0 = 250
		elseif arg_134_2 == 1 then
			var_134_0 = 400
		elseif arg_134_2 == 2 then
			var_134_0 = 330
		end
	end

	return var_134_0
end

function zbHero.getBeattackPosition(arg_135_0, arg_135_1, arg_135_2)
	local var_135_0 = arg_135_0:frontHeroPos()

	if arg_135_1 ~= nil then
		local var_135_1 = arg_135_0:getBeattackOffset(arg_135_1, arg_135_2)

		if var_135_1 > 0 then
			if arg_135_0.forceType == ForceType.Left then
				var_135_0.x = var_135_0.x + var_135_1
			else
				var_135_0.x = var_135_0.x - var_135_1
			end
		end
	end

	return var_135_0
end

function zbHero.frontHeroPos(arg_136_0)
	local var_136_0 = ccp(arg_136_0:getPosition())
	local var_136_1 = getCombatGridOffset()

	if arg_136_0.movingPos then
		var_136_0.x = arg_136_0.destPos.x
		var_136_0.y = arg_136_0.destPos.y
	end

	if arg_136_0.forceType == ForceType.Left then
		var_136_0.x = var_136_0.x + var_136_1
	else
		var_136_0.x = var_136_0.x - var_136_1
	end

	return var_136_0
end

function zbHero.setDesPos(arg_137_0, arg_137_1, arg_137_2)
	arg_137_0.destPos.x = arg_137_1
	arg_137_0.destPos.y = arg_137_2
end

function zbHero.setMovingFlag(arg_138_0, arg_138_1)
	arg_138_0.movingPos = arg_138_1
end

function zbHero.setInitZOrder(arg_139_0, arg_139_1)
	arg_139_0.initZOrder = arg_139_1

	arg_139_0:setZOrder(arg_139_1)
end

function zbHero.getInitZOrder(arg_140_0)
	return arg_140_0.initZOrder
end

function zbHero.updateZOrder(arg_141_0)
	if arg_141_0:getZOrder() == ZORDER_TOP then
		return
	end

	local var_141_0 = arg_141_0:getZOrder()
	local var_141_1 = var_141_0
	local var_141_2 = 1136
	local var_141_3 = arg_141_0:getPositionX()
	local var_141_4 = 0

	if arg_141_0.curSkill ~= nil and arg_141_0.curSkill:isActioning() then
		var_141_4 = arg_141_0:getBeattackOffset(arg_141_0, arg_141_0.curSkill.skillSeqIndex)
	end

	local var_141_5 = arg_141_0:getFormationCenterFrontPosX()

	if arg_141_0.forceType == ForceType.Left then
		if var_141_3 + var_141_4 >= var_141_2 / 2 - 100 and var_141_5 < var_141_3 then
			var_141_1 = getLineZOrder(arg_141_0:getPositionY()) + 100
		elseif arg_141_0.movingPos and (arg_141_0.destPos.x > 10 or arg_141_0.destPos.x < -10) then
			var_141_1 = getLineZOrder(arg_141_0:getPositionY()) + 100
		else
			var_141_1 = arg_141_0.initZOrder
		end
	elseif var_141_3 - var_141_4 <= var_141_2 / 2 + 100 and var_141_3 < var_141_5 then
		var_141_1 = getLineZOrder(arg_141_0:getPositionY())
	elseif arg_141_0.movingPos and (arg_141_0.destPos.x > 10 or arg_141_0.destPos.x < -10) then
		var_141_1 = arg_141_0.initZOrder + 100
	else
		var_141_1 = arg_141_0.initZOrder
	end

	if var_141_0 ~= var_141_1 then
		arg_141_0:setZOrder(var_141_1)
	end
end

function zbHero.getFormationCenterFrontPosX(arg_142_0)
	local var_142_0 = getCombatHeroPosX(arg_142_0.forceType, 2)
	local var_142_1 = 50

	if forceType == ForceType.Left then
		return var_142_0 + var_142_1
	else
		return var_142_0 - var_142_1
	end
end

function zbHero.getShowSequence(arg_143_0)
	return arg_143_0.showSequence
end

function zbHero.setShowSequence(arg_144_0, arg_144_1)
	arg_144_0.showSequence = arg_144_1
end

function zbHero.getBehitSequence(arg_145_0)
	if arg_145_0.avatarRecord.templateId == 601 then
		local var_145_0 = arg_145_0:getHpPercent()

		if var_145_0 > 70 then
			return "behit1"
		elseif var_145_0 > 40 then
			return "behit2"
		else
			return "behit3"
		end
	else
		return ANIMATION_SEQUENCE_BEHIT
	end
end

function zbHero.getIdleWeakSequence(arg_146_0)
	if arg_146_0:isHunmi() or arg_146_0:getHpPercent() < 30 then
		return ANIMATION_SEQUENCE_WEAK
	else
		return ANIMATION_SEQUENCE_IDLE
	end
end

function zbHero.getDieSequence(arg_147_0)
	if arg_147_0.avatarRecord.templateId == 601 then
		return "behit4"
	else
		return ANIMATION_SEQUENCE_DIE
	end
end

function zbHero.getReviveSequence(arg_148_0)
	return arg_148_0.reviveSequence
end

function zbHero.setReviveSequence(arg_149_0, arg_149_1)
	arg_149_0.reviveSequence = arg_149_1
end

function zbHero.isReviving(arg_150_0)
	return arg_150_0.stateMachine:getCurrStateId() == HeroState_Revive
end

function zbHero.playBehitAnimation(arg_151_0, arg_151_1, arg_151_2, arg_151_3)
	if arg_151_0:isExecBigSkilling() then
		return
	end

	arg_151_0:resume()

	if arg_151_0.avatarRecord.templateId == 1011 and arg_151_0.anim.curSequenceName == ANIMATION_SEQUENCE_SKILL3 or arg_151_0.anim.curSequenceName == ANIMATION_SEQUENCE_SKILL4 then
		return
	end

	if arg_151_0.avatarRecord.templateId == 601 then
		arg_151_0.anim:setAnimation(arg_151_0:getBehitSequence(), false, arg_151_1)
	else
		arg_151_0.anim:playAnimationOnce(arg_151_0:getBehitSequence(), arg_151_0:getIdleWeakSequence(), 0.125, arg_151_1)
	end

	local var_151_0 = zbEffectTable:getRecord(arg_151_1)

	if var_151_0 ~= nil then
		g_Audio:playSound(var_151_0.sound)
	end

	if arg_151_1 ~= nil then
		g_EffectSystem:createInstantEffect(arg_151_0, arg_151_1)
	end

	if arg_151_2 ~= nil and arg_151_2:isNeedShake() or arg_151_3 ~= nil and arg_151_3 == true then
		g_EffectSystem:shake()
	end

	if arg_151_0.goldEmitter ~= nil then
		arg_151_0.goldEmitter:emitGlod()
	end
end

function zbHero.playDodgeAnimation(arg_152_0)
	if arg_152_0:isDie() then
		return
	end

	if arg_152_0:isExecBigSkilling() then
		return
	end

	arg_152_0.anim:playAnimationOnce(ANIMATION_SEQUENCE_DODGE, arg_152_0:getIdleWeakSequence(), 0.125)
end

function zbHero.pause(arg_153_0)
	arg_153_0.anim:pause()
	arg_153_0:pauseSchedulerAndActions()
end

function zbHero.resume(arg_154_0)
	arg_154_0:resumeSchedulerAndActions()
	arg_154_0.anim:resume()
end

function zbHero.createPassiveSkillBubble(arg_155_0)
	arg_155_0.spriteSkillBubble = CCSprite:create("image/combat/bubble/skillbg.png")

	arg_155_0.spriteSkillBubble:setAnchorPoint(ccp(0.5, 0))
	arg_155_0.spriteSkillBubble:setCascadeOpacityEnabled(true)
	arg_155_0.spriteSkillBubble:ignoreAnchorPointForPosition(false)
	arg_155_0.spriteSkillBubble:setVisible(false)
	arg_155_0.spriteSkillBubble:retain()

	arg_155_0.lbSkillName = CCLabelTTF:create("1", DefaultFontName, 24)

	arg_155_0.lbSkillName:setAnchorPoint(ccp(0.5, 0.5))
	arg_155_0.lbSkillName:setPosition(arg_155_0.spriteSkillBubble:getContentSize().width / 2, arg_155_0.spriteSkillBubble:getContentSize().height / 2)
	arg_155_0.lbSkillName:setHorizontalAlignment(kCCTextAlignmentCenter)
	arg_155_0.lbSkillName:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
	arg_155_0.lbSkillName:ignoreAnchorPointForPosition(false)
	arg_155_0.lbSkillName:retain()
	ui:setTTFStroke(arg_155_0.lbSkillName)
	arg_155_0.spriteSkillBubble:addChild(arg_155_0.lbSkillName)
	arg_155_0.spriteSkillBubble:setZOrder(ZORDER_TOP)
	g_CombatBubble.bubbleLayer:addChild(arg_155_0.spriteSkillBubble)
end

function zbHero.popupPassiveSkillBubble(arg_156_0, arg_156_1, arg_156_2)
	if arg_156_1 == nil then
		return
	end

	arg_156_0.lbSkillName:setString(arg_156_1.skillRecord.name)
	arg_156_0.spriteSkillBubble:setOpacity(0)
	arg_156_0.spriteSkillBubble:setVisible(true)

	local var_156_0 = CCArray:create()

	if arg_156_2 ~= nil and arg_156_2 > 0 then
		var_156_0:addObject(CCDelayTime:create(arg_156_2))
	end

	var_156_0:addObject(CCFadeIn:create(0.125))
	var_156_0:addObject(CCDelayTime:create(0.85))
	var_156_0:addObject(CCFadeOut:create(0.125))
	var_156_0:addObject(CCCallFuncN:create(function()
		arg_156_0:popupStringBubbleEndCB()
	end))
	arg_156_0.spriteSkillBubble:stopAllActions()
	arg_156_0.spriteSkillBubble:runAction(CCSequence:create(var_156_0))
	arg_156_0:updatePassiveSkillBubble()
end

function zbHero.updatePassiveSkillBubble(arg_158_0)
	if arg_158_0.avatarRecord.parentAvatarId == 1082 then
		arg_158_0.spriteSkillBubble:setPosition(arg_158_0:getFixPositionX(), arg_158_0:getPositionY() + arg_158_0:getCombatBubblePassiveSkillHeight())
	else
		arg_158_0.spriteSkillBubble:setPosition(arg_158_0:getPositionX(), arg_158_0:getPositionY() + arg_158_0:getCombatBubblePassiveSkillHeight())
	end
end

function zbHero.popupStringBubbleEndCB(arg_159_0)
	arg_159_0.spriteSkillBubble:setVisible(false)
end

function zbHero.popupStringBubble(arg_160_0, arg_160_1)
	arg_160_0.lbSkillName:setString(arg_160_1)
	arg_160_0.spriteSkillBubble:setOpacity(0)
	arg_160_0.spriteSkillBubble:setVisible(true)

	local var_160_0 = CCArray:create()

	var_160_0:addObject(CCFadeIn:create(0.125))
	var_160_0:addObject(CCDelayTime:create(0.85))
	var_160_0:addObject(CCFadeOut:create(0.125))
	var_160_0:addObject(CCCallFuncN:create(function()
		arg_160_0:popupStringBubbleEndCB()
	end))
	arg_160_0.spriteSkillBubble:stopAllActions()
	arg_160_0.spriteSkillBubble:runAction(CCSequence:create(var_160_0))
	arg_160_0:updatePassiveSkillBubble()
end

function zbHero.getHudHpHeight(arg_162_0)
	return arg_162_0.avatarRecord.hudOffset.y * arg_162_0.anim:getScale()
end

function zbHero.getCombatBubbleNumHeight(arg_163_0)
	if arg_163_0.spriteSkillBubble:isVisible() then
		return arg_163_0:getHudHpHeight() + 20
	else
		return arg_163_0:getHudHpHeight() + 0
	end
end

function zbHero.getCombatBubbleTextHeight(arg_164_0)
	if arg_164_0.spriteSkillBubble:isVisible() then
		return arg_164_0:getHudHpHeight() + 60
	else
		return arg_164_0:getHudHpHeight() + 20
	end
end

function zbHero.getCombatBubblePassiveSkillHeight(arg_165_0)
	return arg_165_0:getHudHpHeight() + 20
end

function zbHero.setPhysicShield(arg_166_0, arg_166_1)
	arg_166_0.totalPhysicShield = arg_166_1
	arg_166_0.curPhysicShield = arg_166_1
end

function zbHero.getPhysicShield(arg_167_0)
	return arg_167_0.curPhysicShield
end

function zbHero.setMagicShield(arg_168_0, arg_168_1)
	arg_168_0.totalMagicShield = arg_168_1
	arg_168_0.curMagicShield = arg_168_1
end

function zbHero.getMagicShield(arg_169_0)
	return arg_169_0.curMagicShield
end

function zbHero.setPMDamageShield(arg_170_0, arg_170_1)
	arg_170_0.totalPMShield = arg_170_1
	arg_170_0.curPMShield = arg_170_1
end

function zbHero.getPMDamageShield(arg_171_0)
	return arg_171_0.curPMShield
end

function zbHero.useDamageShield(arg_172_0, arg_172_1, arg_172_2)
	if arg_172_2 == EAttackType.Physic then
		local var_172_0 = arg_172_0.curPhysicShield

		arg_172_1, arg_172_0.curPhysicShield = math.max(arg_172_1 - arg_172_0.curPhysicShield, 0), math.max(arg_172_0.curPhysicShield - arg_172_1, 0)
	elseif arg_172_2 == EAttackType.Magic then
		local var_172_1 = arg_172_0.curMagicShield

		arg_172_1, arg_172_0.curMagicShield = math.max(arg_172_1 - arg_172_0.curMagicShield, 0), math.max(arg_172_0.curMagicShield - arg_172_1, 0)
	end

	local var_172_2 = arg_172_0.curPMShield
	local var_172_3 = math.max(arg_172_1 - arg_172_0.curPMShield, 0)

	arg_172_0.curPMShield = math.max(arg_172_0.curPMShield - arg_172_1, 0)

	return var_172_3
end

function zbHero.checkBossHalo(arg_173_0)
	if arg_173_0:isBigBoss() then
		arg_173_0.bossHalo = createUIAnimation()

		arg_173_0.bossHalo:refresh("effect/spine/bosscycle/bosscycle.json", "effect/spine/bosscycle/bosscycle.atlas")
		arg_173_0.bossHalo:setAnimation("animation", true)
		arg_173_0.bossHalo:setAnchorPoint(ccp(0.5, 0.5))
		arg_173_0.bossHalo:setPosition(0, 0)
		arg_173_0.bossHalo:setZOrder(ZORDER_BOTTOM)
		arg_173_0:addChild(arg_173_0.bossHalo)

		arg_173_0.hasBossHalo = true
	elseif arg_173_0.heroBattleData.HeroBaseInfo.Boss ~= nil and arg_173_0.heroBattleData.HeroBaseInfo.Boss == 1 then
		arg_173_0.bossHalo = createUIAnimation()

		arg_173_0.bossHalo:refresh("effect/spine/bosscycle/bosscycle.json", "effect/spine/bosscycle/bosscycle.atlas")
		arg_173_0.bossHalo:setAnimation("animation", true)
		arg_173_0.bossHalo:setAnchorPoint(ccp(0.5, 0.5))
		arg_173_0.bossHalo:setPosition(0, 0)
		arg_173_0.bossHalo:setZOrder(ZORDER_BOTTOM)
		arg_173_0:addChild(arg_173_0.bossHalo)

		arg_173_0.hasBossHalo = true
	end

	if (arg_173_0.avatarRecord.templateId == 601 or arg_173_0.avatarRecord.templateId == 602) and arg_173_0.bossHalo ~= nil then
		arg_173_0.bossHalo:setVisible(false)
	end
end

function zbHero.removeBossHalo(arg_174_0)
	if arg_174_0.bossHalo ~= nil then
		arg_174_0.bossHalo:setVisible(false)
	end
end

function zbHero.isHasBossHalo(arg_175_0)
	return arg_175_0.hasBossHalo
end

function zbHero.isBigBoss(arg_176_0)
	return (g_CombatSystem.combatType == COMBAT_TYPE_FRIENDBOSS or g_CombatSystem.combatType == COMBAT_TYPE_LEGIONBOSS or g_CombatSystem.combatType == COMBAT_TYPE_WORLDBOSS) and arg_176_0.forceType == ForceType.Right
end

function zbHero.isLevelBoss(arg_177_0)
	return arg_177_0.hasBossHalo == true and (g_CombatSystem.combatType == COMBAT_TYPE_LEVEL or g_CombatSystem.combatType == COMBAT_TYPE_TRIAL)
end

function zbHero.isLegionBoss(arg_178_0)
	return arg_178_0.hasBossHalo == true and g_CombatSystem.combatType == COMBAT_TYPE_LEGIONBOSS
end

function zbHero.isFriendBoss(arg_179_0)
	return g_CombatSystem.combatType == COMBAT_TYPE_FRIENDBOSS and arg_179_0.forceType == ForceType.Right
end

function zbHero.isWorldBoss(arg_180_0)
	return g_CombatSystem.combatType == COMBAT_TYPE_WORLDBOSS and arg_180_0.forceType == ForceType.Right
end

function zbHero.getFocusPos(arg_181_0)
	local var_181_0 = arg_181_0:getPositionX() + arg_181_0.focus:getPositionX()
	local var_181_1 = arg_181_0:getPositionY() + arg_181_0.focus:getPositionY()

	return var_181_0, var_181_1
end

function zbHero.enterQte(arg_182_0, arg_182_1)
	local var_182_0 = g_CombatRound:getCurRound()

	arg_182_0.lastQteLeftRound = var_182_0
	arg_182_0.qteComboCount = 1
	arg_182_0.qteEval = EQTEEval.Bad
	arg_182_0.qteTarget = arg_182_1
	arg_182_1.lastQteRightRound = var_182_0

	g_MainScene.wndCombat:showQteFx(arg_182_1)
	g_DarkNode:showDarkNode(arg_182_0)
	g_MainScene.wndCombat:resetQteTimeFactor()
end

function zbHero.comboQte(arg_183_0, arg_183_1, arg_183_2)
	if arg_183_2:isSame(arg_183_0.qteTarget) == false then
		-- block empty
	end

	arg_183_0.qteComboCount = arg_183_0.qteComboCount + 1

	g_MainScene.wndCombat:hitShowCombo(arg_183_1, arg_183_2)

	if arg_183_0.qteComboCount < COMBAT_QTE_MAX_COMBO then
		g_MainScene.wndCombat:showQteFx(arg_183_0.qteTarget)
	end
end

function zbHero.exitQte(arg_184_0)
	arg_184_0.lastQteLeftRound = g_CombatRound:getCurRound()
	arg_184_0.qteEval = EQTEEval.Bad
	arg_184_0.qteComboCount = 0
	arg_184_0.qteTarget = nil

	g_CombatRound:setRedoHero(nil)
end

function zbHero.getQteEval(arg_185_0)
	return arg_185_0.qteEval
end

function zbHero.setQteEval(arg_186_0, arg_186_1)
	if arg_186_0:isQting() == false then
		return
	end

	arg_186_0.qteEval = arg_186_1

	if arg_186_1 > EQTEEval.Bad then
		g_CombatRound:setRedoHero(arg_186_0)
	else
		arg_186_0:exitQte()
	end

	if g_DarkNode:isDarking() then
		g_DarkNode:hideDarkNode(arg_186_0)
	end
end

function zbHero.getQteEvalDamage(arg_187_0)
	if arg_187_0.qteEval == EQTEEval.Good then
		return 1.1
	elseif arg_187_0.qteEval == EQTEEval.Great then
		return 1.3
	elseif arg_187_0.qteEval == EQTEEval.Perfect then
		return 1.5
	else
		return 1
	end
end

function zbHero.isQting(arg_188_0)
	local var_188_0 = g_CombatRound:getCurRound()

	return arg_188_0:isDie() == false and arg_188_0.lastQteLeftRound == var_188_0 and arg_188_0.qteTarget ~= nil
end

function zbHero.resetQteRound(arg_189_0)
	arg_189_0.qteEval = EQTEEval.Bad
	arg_189_0.qteComboCount = 0
	arg_189_0.qteTarget = nil
end

function zbHero.resetQteSection(arg_190_0)
	arg_190_0.lastQteLeftRound = -100
	arg_190_0.qteEval = EQTEEval.Bad
	arg_190_0.qteComboCount = 0
	arg_190_0.qteTarget = nil
end

function zbHero.setQinyin(arg_191_0, arg_191_1, arg_191_2)
	arg_191_0.qinyin = arg_191_1
	arg_191_0.qinyinCureValue = arg_191_2
end

function zbHero.isQinyin(arg_192_0)
	return arg_192_0.qinyin
end
