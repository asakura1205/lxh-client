zbHeroState_Wait = class("zbHeroState_Wait")
zbHeroState_Wait.__index = zbHeroState_Wait

function zbHeroState_Wait.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Wait.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Wait.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Wait.free(arg_3_0)
	return
end

function zbHeroState_Wait.enter(arg_4_0)
	arg_4_0.hero:setVisible(false)
end

function zbHeroState_Wait.exit(arg_5_0)
	arg_5_0.hero:setVisible(true)
end

function zbHeroState_Wait.update(arg_6_0, arg_6_1)
	return
end
