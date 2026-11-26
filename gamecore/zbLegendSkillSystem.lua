require("gamecore.zbLegendDarkNode")

zbLegendSkillSystem = class("zbLegendSkillSystem")
zbLegendSkillSystem.__index = zbLegendSkillSystem

function zbLegendSkillSystem.create(arg_1_0)
	local var_1_0 = zbLegendSkillSystem.new()

	var_1_0:init()

	return var_1_0
end

function zbLegendSkillSystem.init(arg_2_0)
	arg_2_0.funCreator = {}
	arg_2_0.funCreator[1] = function(arg_3_0, arg_3_1)
		require("gamecore.legend.zbTianmingzhu")

		return zbTianmingzhu:create(arg_3_0, arg_3_1)
	end
	arg_2_0.funCreator[2] = function(arg_4_0, arg_4_1)
		require("gamecore.legend.zbFangcunhe")

		return zbFangcunhe:create(arg_4_0, arg_4_1)
	end
	arg_2_0.funCreator[3] = function(arg_5_0, arg_5_1)
		require("gamecore.legend.zbBanyuehu")

		return zbBanyuehu:create(arg_5_0, arg_5_1)
	end
	arg_2_0.funCreator[4] = function(arg_6_0, arg_6_1)
		require("gamecore.legend.zbLanyupan")

		return zbLanyupan:create(arg_6_0, arg_6_1)
	end
	arg_2_0.funCreator[5] = function(arg_7_0, arg_7_1)
		require("gamecore.legend.zbRuyijie")

		return zbRuyijie:create(arg_7_0, arg_7_1)
	end
	arg_2_0.legendDarkNode = zbLegendDarkNode:create()
end

function zbLegendSkillSystem.createLegender(arg_8_0, arg_8_1, arg_8_2)
	if zbUtil:isValidTable(arg_8_2) == false then
		echo("warning: invalid battleGod info")

		return
	end

	local var_8_0
	local var_8_1 = arg_8_0.funCreator[arg_8_2.GodId]

	if var_8_1 ~= nil then
		var_8_0 = var_8_1(arg_8_1, arg_8_2)

		if var_8_0 == nil then
			echo("warning: can not find valid legend: " .. arg_8_2.GodId)
		end
	end

	return var_8_0
end
