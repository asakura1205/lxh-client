local var_0_0 = class("zbActivityHandler")

var_0_0.__index = var_0_0

function createActivityHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.wishTurntableSoltType = 1
	arg_2_0.RecordList = nil
	arg_2_0.lastTemplateId = 0
end
