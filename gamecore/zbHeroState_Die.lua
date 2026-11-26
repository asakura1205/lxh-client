zbHeroState_Die = class("zbHeroState_Die")
zbHeroState_Die.__index = zbHeroState_Die

local var_0_0 = 3
local var_0_1 = 1

function zbHeroState_Die.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Die.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Die.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Die.enter(arg_3_0)
	local function var_3_0()
		arg_3_0.hero:execPassiveSkill(EPassiveTriggerType.Died_Begin)
	end

	local function var_3_1()
		local var_5_0 = g_CombatSystem:getHeros(ForceType.Left)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			if iter_5_1:isDie() == false and iter_5_1:isSame(arg_3_0.hero) == false then
				iter_5_1:execPassiveSkill(EPassiveTriggerType.NonMyDied)

				if iter_5_1.forceType == arg_3_0.hero.forceType then
					iter_5_1:execPassiveSkill(EPassiveTriggerType.FriendDied)
				else
					iter_5_1:execPassiveSkill(EPassiveTriggerType.EnemyDied)
				end
			end
		end

		local var_5_1 = g_CombatSystem:getHeros(ForceType.Right)

		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			if iter_5_3:isDie() == false and iter_5_3:isSame(arg_3_0.hero) == false then
				iter_5_3:execPassiveSkill(EPassiveTriggerType.NonMyDied)

				if iter_5_3.forceType == arg_3_0.hero.forceType then
					iter_5_3:execPassiveSkill(EPassiveTriggerType.FriendDied)
				else
					iter_5_3:execPassiveSkill(EPassiveTriggerType.EnemyDied)
				end
			end
		end

		arg_3_0.hero.isRealDied = arg_3_0.hero.curHp <= 0

		if arg_3_0.hero.isRealDied then
			g_CombatSystem.combatData.combatFocus:heroDied(arg_3_0.hero)
			g_CombatSystem:getLegend():heroDied(arg_3_0.hero)
			arg_3_0.hero:removeBossHalo()
			g_CombatSystem.combatData:checkRecordHeroDied(arg_3_0.hero)
		end
	end

	local function var_3_2()
		arg_3_0.hero:setVisible(false)
	end

	echo(arg_3_0.hero.heroRecord.name .. a2u(" \xBD\xF8\xC8\xEB\xC1\xCB\xCB\xC0\xCD\xF6״̬"))

	local var_3_3 = arg_3_0.hero:getDieSequence()

	arg_3_0.hero:setCascadeOpacityEnabled(true)
	arg_3_0.hero.anim:resume()
	arg_3_0.hero.anim:setCascadeOpacityEnabled(true)
	arg_3_0.hero.anim:setAnimation(var_3_3, false)
	var_3_0()

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCDelayTime:create(arg_3_0.hero.anim:getAnimDuration(var_3_3)))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(var_0_0 - arg_3_0.hero.anim:getAnimDuration(var_3_3), 0.1)))
	var_3_4:addObject(CCFadeOut:create(var_0_1))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	arg_3_0.hero.anim.skeleton:stopAllActions()
	arg_3_0.hero.anim.skeleton:runAction(CCSequence:create(var_3_4))

	if arg_3_0.hero.heroRecord.id then
		local var_3_5 = zbAvatarTable:getAvatarSoundPath(arg_3_0.hero.heroRecord.id, ESoundType.E_DIE)

		g_Audio:playSound(var_3_5)
	end

	g_CombatBubble:showDiedBubble(arg_3_0.hero, 1)
	arg_3_0.hero.energy:clearCount()

	if arg_3_0.hero.avatarRecord.templateId == 601 then
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2003)
	end
end

function zbHeroState_Die.exit(arg_7_0)
	arg_7_0.hero:setVisible(true)

	local var_7_0 = CCArray:create()

	var_7_0:addObject(CCFadeIn:create(0))
	arg_7_0.hero.anim.skeleton:stopAllActions()
	arg_7_0.hero.anim.skeleton:runAction(CCSequence:create(var_7_0))
end

function zbHeroState_Die.update(arg_8_0, arg_8_1)
	return
end
