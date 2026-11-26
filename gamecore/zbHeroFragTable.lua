require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroFragRecord")

var_0_0.__index = var_0_0

function createHeroFragRecord()
	return (var_0_0.new())
end

zbHeroFragTable = {}
zbHeroFragTable.records = {}

function zbHeroFragTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		local var_2_1 = 1

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_2 = createHeroFragRecord()
				local var_2_3 = 1

				var_2_2.rarity = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.num = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				arg_2_0.records[var_2_1] = var_2_2
				var_2_1 = var_2_1 + 1
			end
		end
	end

	return arg_2_0
end

function zbHeroFragTable.getHunyunNum(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.records) do
		if iter_3_1.rarity == arg_3_1 then
			return iter_3_1.num
		end
	end
end
