local var_0_0 = class("zbFirstCombat")

var_0_0.__index = var_0_0

local var_0_1 = 1001
local var_0_2 = 1013
local var_0_3 = 5

function createFirstCombat()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.active = false

	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0.accumDamgeCount = 0
end

function var_0_0.free(arg_4_0)
	return
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	arg_5_0.active = arg_5_1
end

function var_0_0.isActive(arg_6_0)
	return arg_6_0.active
end

function var_0_0.start(arg_7_0)
	local function var_7_0()
		local var_8_0 = require("gamelogic.zbGuidePreCombatData")
		local var_8_1 = {}

		var_8_1.Level = 1
		var_8_1.Star = 1
		var_8_1.Energy = 0
		var_8_1.GodId = 1
		var_8_1.Power = 1
		var_8_1.FV = 1
		var_8_1.SkillList = {}

		local var_8_2 = {}

		var_8_2.Index = 1
		var_8_2.SkillId = 101
		var_8_2.Level = 1

		table.insert(var_8_1.SkillList, var_8_2)

		local var_8_3 = {}

		var_8_3.LevelType = 1
		var_8_3.LevelId = 10001
		var_8_3.ForceId = 1
		var_8_3.BattleInfo = {}
		var_8_3.BattleInfo.SelfBaseInfo = {}
		var_8_3.BattleInfo.SelfGodEquip = nil
		var_8_3.BattleInfo.MaxRound = 20
		var_8_3.BattleInfo.RandomSeed = 123456
		var_8_3.BattleInfo.SelfFormation = {}
		var_8_3.BattleInfo.SelfFormation[1] = {}
		var_8_3.BattleInfo.SelfFormation[1].TechDetail = nil
		var_8_3.BattleInfo.SelfFormation[1].BattleGod = var_8_1
		var_8_3.BattleInfo.SelfFormation[1].HeroList = var_8_0.LeftHeroList[1].HeroList
		var_8_3.BattleInfo.EnemyBaseInfo = {}
		var_8_3.BattleInfo.EnemyFormation = {}
		var_8_3.BattleInfo.EnemyFormation[1] = {}
		var_8_3.BattleInfo.EnemyFormation[1].TechDetail = nil
		var_8_3.BattleInfo.EnemyFormation[1].BattleGod = nil
		var_8_3.BattleInfo.EnemyFormation[1].HeroList = var_8_0.RightHeroList[1].HeroList
		g_CombatSystem.combatSceneId = COMBAT_SCENE_PATA_BRIDGE
		g_CombatSystem.combatTalkId = 12345

		g_CombatSystem:startCombatTest(var_8_3)
	end

	arg_7_0:setActive(true)
	var_7_0()
	g_MainScene:showGuideWnd()
	g_MainScene:hideGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndCombat.btnLegendTouch)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_7_0:checkAutoExecBigSkill()
	end)
end

function var_0_0.stop(arg_10_0)
	arg_10_0:setActive(false)
end

function var_0_0.roundTalkEnd(arg_11_0, arg_11_1)
	if arg_11_1 == 3 then
		g_CombatSystem:pause()
		g_MainScene.wndCombatTalk:hide()
		g_MainScene:showRoleWnd()

		return true
	elseif arg_11_1 == 4 then
		-- block empty
	end

	return false
end

function var_0_0.onRound(arg_12_0, arg_12_1)
	local var_12_0 = g_CombatSystem:getHeroByTemplateId(ForceType.Left, var_0_1)

	local function var_12_1(arg_13_0, arg_13_1)
		g_CombatSystem:getHeroByTemplateId(arg_13_0, arg_13_1).roundEnded = true
	end

	local function var_12_2(arg_14_0, arg_14_1)
		g_CombatSystem:getHeroByTemplateId(arg_14_0, arg_14_1):stopAllActions()
	end

	if arg_12_1 == 3 then
		var_12_1(ForceType.Left, var_0_1)

		g_CombatRound.sequenceRound.currAttackForceType = ForceType.Right
		g_CombatRound.sequenceRound.curEnemyFightIndex = 1

		g_CombatSystem:getHeroByTemplateId(ForceType.Right, var_0_2):addMp(100)
	elseif arg_12_1 == 4 then
		g_CombatRound.sequenceRound.currAttackForceType = ForceType.Right
		g_CombatRound.sequenceRound.curEnemyFightIndex = 1

		var_12_1(ForceType.Left, var_0_1)
		var_12_1(ForceType.Right, var_0_2)
		g_CombatSystem:pause()
		g_MainScene:showGuideWnd()
	elseif arg_12_1 == 5 then
		g_CombatSystem:pause()
		var_12_1(ForceType.Left, var_0_1)
		var_12_1(ForceType.Right, var_0_2)
		g_CombatSystem.combatData.leftPlayer:resume()
		g_CombatSystem.combatData.rightPlayer:resume()
		arg_12_0:lxhRunaway()
	end
end

function var_0_0.checkAutoExecBigSkill(arg_15_0)
	g_CombatSystem:resume()

	g_CombatSystem.combatData.leftPlayer.legend.energy = 100

	g_CombatSystem:getLegend():checkAutoExecBigSkill()
	g_MainScene:hideGuideWnd()
end

function var_0_0.lxhRunaway(arg_16_0)
	local function var_16_0()
		local var_17_0 = g_CombatSystem:getHeroByTemplateId(ForceType.Left, var_0_1)
		local var_17_1 = ccp(var_17_0:getPosition())

		var_17_0:setRotationY(180)

		local var_17_2 = 538

		var_17_1.x = var_17_1.x - var_17_2

		local function var_17_3()
			arg_16_0:setActive(false)
			g_CombatSystem:resume()
			g_CombatSystem:finish()
			g_MainScene.wndCombat:hide()
			g_MainScene:showGuideYeyejiaWnd()
		end

		local var_17_4 = CCArray:create()

		var_17_4:addObject(CCMoveTo:create(2.5, var_17_1))
		var_17_4:addObject(CCCallFuncN:create(var_17_3))
		var_17_0:stopAllActions()
		var_17_0:runAction(CCSequence:create(var_17_4))
		var_17_0.anim:setAnimation(ANIMATION_SEQUENCE_RUN, true)
	end

	local function var_16_1()
		local var_19_0 = arg_16_0.player

		if var_19_0 == nil then
			return
		end

		local var_19_1 = ccp(var_19_0:getPosition())

		var_19_0:setRotationY(0)

		local var_19_2 = 538

		var_19_1.x = var_19_1.x - var_19_2

		local function var_19_3()
			return
		end

		local var_19_4 = CCArray:create()

		var_19_4:addObject(CCMoveTo:create(2.5, var_19_1))
		var_19_4:addObject(CCCallFuncN:create(var_19_3))
		var_19_0:stopAllActions()
		var_19_0:runAction(CCSequence:create(var_19_4))
		var_19_0:setAnimation(ANIMATION_SEQUENCE_RUN, true)
	end

	var_16_0()
	var_16_1()
end

function var_0_0.onRoleCreated(arg_21_0)
	g_MainScene:roundCombatTalk(1, 31)
	arg_21_0:appearPlayer()
end

function var_0_0.appearPlayer(arg_22_0)
	local function var_22_0()
		local var_23_0 = zbAvatarTable:getRecord(g_Self:getAvatarId())

		if var_23_0 ~= nil then
			return var_23_0.bone
		else
			return "animation/hero/character_agen/character_agen"
		end
	end

	local var_22_1 = g_CombatSystem:getHeroByTemplateId(ForceType.Left, var_0_1)
	local var_22_2 = var_22_1:getFixPosition()
	local var_22_3 = createUIAnimation()

	var_22_3:refreshBone(var_22_0())
	var_22_3:setRotationY(180)
	var_22_3:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	var_22_3:setPosition(var_22_2.x - 100, var_22_2.y)
	var_22_3:setScaleX(var_22_1:getScaleX())
	var_22_3:setScaleY(var_22_1:getScaleY())
	g_MainScene.wndCombat.layerScene:addChild(var_22_3)
	var_22_3:setZOrder(var_22_1:getZOrder() + 1)

	local var_22_4 = CCSprite:create("image/combat/yingzi.png")

	var_22_4:setScale(0.7)
	var_22_4:setPosition(0, 0)

	local var_22_5 = CCScaleBy:create(1, 0.9)
	local var_22_6 = CCSequence:createWithTwoActions(var_22_5, var_22_5:reverse())

	var_22_4:runAction(CCRepeatForever:create(var_22_6))
	var_22_3:addChild(var_22_4, -1)
	var_22_4:setZOrder(-1)

	arg_22_0.animYanwu = createUIAnimation()

	arg_22_0.animYanwu:refreshBone("effect/spine/ui_yanwu/ui_yanwu")
	arg_22_0.animYanwu:setAnimation("animation", false)
	var_22_3:addChild(arg_22_0.animYanwu)

	arg_22_0.player = var_22_3
end

function var_0_0.onLegendSkillOver(arg_24_0)
	return
end

function var_0_0.update(arg_25_0, arg_25_1)
	return
end

function var_0_0.getAttackSkillId(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:getTemplateId()
	local var_26_1 = g_CombatRound:getCurRound()
	local var_26_2 = 0

	if var_26_1 == 1 then
		if var_26_0 == var_0_1 then
			var_26_2 = 0
		elseif var_26_0 == var_0_2 then
			var_26_2 = 0
		end
	elseif var_26_1 == 2 then
		if var_26_0 == var_0_1 then
			var_26_2 = 1
		elseif var_26_0 == var_0_2 then
			var_26_2 = 2
		end
	end

	return var_26_0 * 10 + var_26_2
end

function var_0_0.calcDamage(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	arg_27_0.accumDamgeCount = arg_27_0.accumDamgeCount + 1

	local var_27_0 = 0
	local var_27_1 = EDamageResult.Hit
	local var_27_2 = false
	local var_27_3 = arg_27_1:getTemplateId()
	local var_27_4 = g_CombatRound:getCurRound()

	if var_27_4 == 1 then
		if var_27_3 == var_0_1 then
			var_27_0 = arg_27_2.maxHp * 0.2
		elseif var_27_3 == var_0_2 then
			var_27_0 = arg_27_2.maxHp * 0.32

			arg_27_2:addMp(100)
		end
	elseif var_27_4 == 2 then
		if var_27_3 == var_0_1 then
			var_27_0 = arg_27_2.maxHp * 0.25 / 7
			var_27_1 = EDamageResult.Violent
		elseif var_27_3 == var_0_2 then
			var_27_0 = arg_27_2.maxHp * 0.15
		end
	elseif var_27_4 ~= 3 or var_27_3 == var_0_1 then
		-- block empty
	elseif var_27_3 == var_0_2 then
		var_27_1 = EDamageResult.Violent
		var_27_0 = arg_27_2.maxHp * 0.26 / 7
	end

	local var_27_5 = math.ceil(var_27_0 + zbUtil:random(90, 200))

	if var_27_5 > 0 then
		local var_27_6 = arg_27_0:getDamageBubbleType(arg_27_1, arg_27_2, var_27_1)

		arg_27_2:addHp(-var_27_5, isViolent, arg_27_3.hitBubbleCount, arg_27_4, arg_27_3.hitBubbleInterval)
		arg_27_3:addHitedTarget(arg_27_2)

		arg_27_3.hitTargeted = true

		local var_27_7 = zbAvatarSoundTable:getAttackSoundRecord(arg_27_1.avatarRecord.templateId, arg_27_3.skillSeqIndex)

		if var_27_7 ~= nil then
			g_Audio:playSound(var_27_7.attackSound)
		end

		if var_27_4 == 3 and var_27_3 == var_0_2 and arg_27_0.player ~= nil then
			arg_27_0.player:playAnimationOnce(ANIMATION_SEQUENCE_BEHIT, ANIMATION_SEQUENCE_WEAK, 0.125)
		end
	end

	local var_27_8 = arg_27_2:isDie()

	return var_27_1, var_27_5, var_27_8
end

function var_0_0.calcLegendDamage(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_1.curHp * 0.5

	arg_28_1:addHp(-var_28_0, false, 1)
	g_BuffSystem:createControlBuff(arg_28_1, arg_28_1, BUFF_TYPE_CONTROL_HUNMI)
end

function var_0_0.getDamageBubbleType(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = ECombatBubble.Unknown

	if arg_29_3 == EDamageResult.Immune then
		if arg_29_1.heroRecord.attackType == EAttackType.Physic then
			var_29_0 = ECombatBubble.PhyImmune
		else
			var_29_0 = ECombatBubble.MagicImmune
		end
	elseif arg_29_3 == EDamageResult.Unhit then
		var_29_0 = ECombatBubble.Unhit
	elseif arg_29_3 == EDamageResult.Hit then
		if arg_29_2.forceType == ForceType.Left then
			var_29_0 = ECombatBubble.SelfDecHp
		else
			var_29_0 = ECombatBubble.EnemyDecHp
		end
	elseif arg_29_3 == EDamageResult.Violent then
		if arg_29_2.forceType == ForceType.Left then
			var_29_0 = ECombatBubble.SelfViolentDecHp
		else
			var_29_0 = ECombatBubble.EnemyViolentDecHp
		end
	end

	return var_29_0
end
