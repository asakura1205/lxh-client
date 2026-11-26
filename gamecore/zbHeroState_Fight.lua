zbHeroState_Fight = class("zbHeroState_Fight")
zbHeroState_Fight.__index = zbHeroState_Fight

function zbHeroState_Fight.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Fight.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Fight.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Fight.enter(arg_3_0)
	return
end

function zbHeroState_Fight.exit(arg_4_0)
	return
end

function zbHeroState_Fight.update(arg_5_0, arg_5_1)
	return
end
