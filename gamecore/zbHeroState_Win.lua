zbHeroState_Win = class("zbHeroState_Win")
zbHeroState_Win.__index = zbHeroState_Win

function zbHeroState_Win.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Win.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Win.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Win.enter(arg_3_0)
	arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_WIN, true)
end

function zbHeroState_Win.exit(arg_4_0)
	return
end

function zbHeroState_Win.update(arg_5_0, arg_5_1)
	return
end
