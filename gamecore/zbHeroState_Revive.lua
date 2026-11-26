zbHeroState_Revive = class("zbHeroState_Revive")
zbHeroState_Revive.__index = zbHeroState_Revive

function zbHeroState_Revive.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Revive.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Revive.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Revive.enter(arg_3_0)
	echo(ForceTypeDesc[arg_3_0.hero.forceType] .. arg_3_0.hero.heroRecord.name .. a2u(" \xBD\xF8\xC8\xEB\xC1˸\xB4\xBB\xEE״̬"))

	local var_3_0 = arg_3_0.hero:getReviveSequence()

	arg_3_0.accumTime = 0
	arg_3_0.durationTime = arg_3_0.hero.anim:getAnimDuration(var_3_0) + 0.3

	arg_3_0.hero.anim:resume()
	arg_3_0.hero.anim:setAnimation(var_3_0, false)

	local var_3_1 = CCArray:create()

	var_3_1:addObject(CCFadeIn:create(0.1))
	arg_3_0.hero.anim.skeleton:stopAllActions()
	arg_3_0.hero.anim.skeleton:runAction(CCSequence:create(var_3_1))
	g_CombatBubble:showReviveBubble(arg_3_0.hero, 0)
	arg_3_0.hero:execPassiveSkill(EPassiveTriggerType.Revived)

	arg_3_0.hero.isRealDied = false
end

function zbHeroState_Revive.exit(arg_4_0)
	arg_4_0.hero.anim:setAnimation(arg_4_0.hero:getIdleWeakSequence(), true)
	echo(ForceTypeDesc[arg_4_0.hero.forceType] .. arg_4_0.hero.heroRecord.name .. a2u(" \xCD˳\xF6\xC1˸\xB4\xBB\xEE״̬"))
end

function zbHeroState_Revive.update(arg_5_0, arg_5_1)
	arg_5_0.accumTime = arg_5_0.accumTime + arg_5_1

	if arg_5_0.accumTime > arg_5_0.durationTime then
		arg_5_0.hero:setCurrState(HeroState_Fight)
	end
end
