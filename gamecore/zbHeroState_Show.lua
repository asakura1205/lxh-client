zbHeroState_Show = class("zbHeroState_Show")
zbHeroState_Show.__index = zbHeroState_Show

function zbHeroState_Show.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Show.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Show.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Show.enter(arg_3_0)
	arg_3_0.hero:execPassiveSkill(EPassiveTriggerType.InitShow)

	arg_3_0.accumTime = 0
	arg_3_0.durationTime = arg_3_0.hero.anim:getAnimDuration(arg_3_0.hero:getShowSequence()) + 0.3

	arg_3_0.hero.anim:playAnimationOnce(arg_3_0.hero:getShowSequence(), ANIMATION_SEQUENCE_IDLE, 0.2)
end

function zbHeroState_Show.exit(arg_4_0)
	return
end

function zbHeroState_Show.update(arg_5_0, arg_5_1)
	arg_5_0.accumTime = arg_5_0.accumTime + arg_5_1

	if arg_5_0.accumTime >= arg_5_0.durationTime then
		arg_5_0.hero.isReadyFight = true

		arg_5_0.hero:setCurrState(HeroState_Fight)
	end
end
