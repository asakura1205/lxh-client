require("gamecore.zbRandomNameTable")

zbNameHelper = class("zbNameHelper")
zbNameHelper.__index = zbNameHelper

function createNameHelper()
	local var_1_0 = zbNameHelper.new()

	var_1_0:init()

	return var_1_0
end

function zbNameHelper.init(arg_2_0)
	arg_2_0.randomNameTable = nil

	math.randomseed(os_timenow())
end

function zbNameHelper.free(arg_3_0)
	return
end

function zbNameHelper.randomName(arg_4_0)
	if arg_4_0.randomNameTable == nil then
		arg_4_0.randomNameTable = zbRandomNameTable:load("config/random_name")
	end

	local var_4_0 = math.random(1, #arg_4_0.randomNameTable.firstName)
	local var_4_1 = arg_4_0.randomNameTable.firstName[var_4_0]
	local var_4_2 = math.random(1, #arg_4_0.randomNameTable.lastName)
	local var_4_3 = arg_4_0.randomNameTable.lastName[var_4_2]

	return var_4_1 .. var_4_3
end
