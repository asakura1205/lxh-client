local var_0_0 = class("zbHeroDesc")

var_0_0.__index = var_0_0

function createHerodesc()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.heroTemplateId = -1
	arg_2_0.isSpeartor = false
	arg_2_0.isSpeartor2 = false
	arg_2_0.isEmpty = false
	arg_2_0.isFrag = false
	arg_2_0.heroLevel = -1
	arg_2_0.fragCount = -1
	arg_2_0.fragNeedCount = -1
end
