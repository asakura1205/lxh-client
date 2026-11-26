local var_0_0 = class("zbSetHandler")

var_0_0.__index = var_0_0
E_DECOMPOSE_SET_BLUE = "decompose_set_blue"
E_DECOMPOSE_SET_PURPLE = "decompose_set_purple"
E_DECOMPOSE_SET_GOLDEN = "decompose_set_golden"
E_DECOMPOSE_SET_RED = "decompose_set_red"
E_DECOMPOSE_SET_BLACK = "decompose_set_black"
E_DECOMPOSE_DESC = {}
E_DECOMPOSE_DESC[EItemQuality.Blue] = E_DECOMPOSE_SET_BLUE
E_DECOMPOSE_DESC[EItemQuality.Purple] = E_DECOMPOSE_SET_PURPLE
E_DECOMPOSE_DESC[EItemQuality.Golden] = E_DECOMPOSE_SET_GOLDEN
E_DECOMPOSE_DESC[EItemQuality.Red] = E_DECOMPOSE_SET_RED
E_DECOMPOSE_DESC[EItemQuality.Black] = E_DECOMPOSE_SET_BLACK

function createSetHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.decomposeSets = {}
	arg_2_0.decomposeSets[EItemQuality.Blue] = tonumber(arg_2_0:getDecomposeQuality(EItemQuality.Blue))
	arg_2_0.decomposeSets[EItemQuality.Purple] = tonumber(arg_2_0:getDecomposeQuality(EItemQuality.Purple))
	arg_2_0.decomposeSets[EItemQuality.Golden] = tonumber(arg_2_0:getDecomposeQuality(EItemQuality.Golden))
	arg_2_0.decomposeSets[EItemQuality.Red] = tonumber(arg_2_0:getDecomposeQuality(EItemQuality.Red))
	arg_2_0.decomposeSets[EItemQuality.Black] = tonumber(arg_2_0:getDecomposeQuality(EItemQuality.Black))
end

function var_0_0.setDecomposeQuality(arg_3_0, arg_3_1, arg_3_2)
	if E_DECOMPOSE_DESC[arg_3_1] then
		zbGameCore:Instance():setConfigValue(E_DECOMPOSE_DESC[arg_3_1], arg_3_2)
	end

	if arg_3_0.decomposeSets[arg_3_1] then
		arg_3_0.decomposeSets[arg_3_1] = arg_3_2
	end
end

function var_0_0.getDecomposeQuality(arg_4_0, arg_4_1)
	if E_DECOMPOSE_DESC[arg_4_1] then
		return zbGameCore:Instance():getConfigValue(E_DECOMPOSE_DESC[arg_4_1]) or 0
	end

	return 0
end
