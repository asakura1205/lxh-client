require("gamebase.zbLoadCSV")

local var_0_0 = class("zbEffectRecord")

var_0_0.__index = var_0_0

function createEffectRecord()
	return (var_0_0.new())
end

zbEffectTable = {}
zbEffectTable.records = {}

function zbEffectTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = tonumber(iter_2_1[1])
				local var_2_2 = createEffectRecord()

				var_2_2.id = tonumber(iter_2_1[1])
				var_2_2.name = iter_2_1[2]
				var_2_2.sound = iter_2_1[3]
				var_2_2.ccbi = iter_2_1[4]
				var_2_2.durationTime = tonumber(iter_2_1[5])
				var_2_2.dummy = iter_2_1[6]
				var_2_2.attackEffectPosX = tonumber(iter_2_1[7])
				var_2_2.attackEffectPosY = tonumber(iter_2_1[8])
				var_2_2.rotateY = tonumber(iter_2_1[9]) == 1
				var_2_2.heroBehide = tonumber(iter_2_1[10]) == 1
				var_2_2.parentNode = tonumber(iter_2_1[11])
				var_2_2.sequenceName = iter_2_1[12]
				var_2_2.scale = tonumber(iter_2_1[13])
				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbEffectTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbEffectTable.getEffectPosOffset(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.records[arg_4_1]

	if var_4_0 == nil then
		return 0, 0
	end

	return var_4_0.attackEffectPosX, var_4_0.attackEffectPosY
end
