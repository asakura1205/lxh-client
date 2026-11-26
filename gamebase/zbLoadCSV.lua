local function var_0_0(arg_1_0)
	return string.gsub(arg_1_0, "^%s+", "")
end

local function var_0_1(arg_2_0)
	return string.gsub(arg_2_0, "%s+$", "")
end

local function var_0_2(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = arg_3_0 .. ","

	while var_3_1 ~= "" do
		local var_3_2 = ""
		local var_3_3 = true
		local var_3_4 = true

		while var_3_1 ~= "" and string.find(var_3_1, "^,") == nil do
			if string.find(var_3_1, "^\"") then
				local var_3_5, var_3_6, var_3_7, var_3_8 = string.find(var_3_1, "^\"(.-)\"(.*)")

				if var_3_7 == nil then
					return nil
				end

				if var_3_2 == "" then
					local var_3_9 = false
				end

				var_3_2 = var_3_2 .. var_3_7
				var_3_1 = var_3_8

				while string.find(var_3_1, "^\"") do
					local var_3_10, var_3_11, var_3_12, var_3_13 = string.find(var_3_1, "^\"(.-)\"(.*)")

					if var_3_12 == nil then
						return nil
					end

					var_3_2 = var_3_2 .. "\"" .. var_3_12
					var_3_1 = var_3_13
				end

				local var_3_14 = true
			else
				local var_3_15, var_3_16, var_3_17, var_3_18 = string.find(var_3_1, "^(.-)([,\"].*)")

				if var_3_17 ~= nil then
					var_3_2 = var_3_2 .. var_3_17
					var_3_1 = var_3_18
				else
					var_3_2 = var_3_2 .. var_3_1
					var_3_1 = ""
				end

				local var_3_19 = false
			end
		end

		local var_3_20 = var_0_1(var_0_0(var_3_2))

		var_3_0[table.getn(var_3_0) + 1] = var_3_20

		if string.find(var_3_1, "^,") then
			var_3_1 = string.gsub(var_3_1, "^,", "")
		end
	end

	return var_3_0
end

local function var_0_3(arg_4_0)
	local var_4_0
	local var_4_1 = false
	local var_4_2 = 0

	while true do
		local var_4_3 = arg_4_0:read()

		if not var_4_3 then
			if var_4_2 == 0 then
				var_4_1 = true
			end

			break
		end

		if not var_4_0 then
			var_4_0 = var_4_3
		else
			var_4_0 = var_4_0 .. var_4_3
		end

		local var_4_4 = 1

		while true do
			local var_4_5 = string.find(var_4_3, "\"", var_4_4)

			if not var_4_5 then
				break
			end

			var_4_4 = var_4_5 + 1
			var_4_2 = var_4_2 + 1
		end

		if var_4_2 % 2 == 0 then
			var_4_1 = true

			break
		end
	end

	if not var_4_1 then
		assert(1 ~= 1)
	end

	return var_4_0
end

function LoadCsv(arg_5_0)
	function split(arg_6_0, arg_6_1)
		local var_6_0 = {}

		string.gsub(arg_6_0, "[^" .. arg_6_1 .. "]+", function(arg_7_0)
			table.insert(var_6_0, arg_7_0)
		end)

		return var_6_0
	end

	local var_5_0 = CCString:createWithContentsOfFile(arg_5_0):getStdString()
	local var_5_1 = split(var_5_0, "\n\r")
	local var_5_2 = {}

	for iter_5_0 = 1, #var_5_1 do
		var_5_2[iter_5_0] = var_0_2(var_5_1[iter_5_0])
	end

	return var_5_2
end

function LoadCsvData(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = require(arg_8_0)
	local var_8_2 = {}

	for iter_8_0 = 1, table.getn(var_8_1) do
		data = var_8_1[iter_8_0]

		local var_8_3 = {}

		if iter_8_0 == 1 then
			-- block empty
		elseif iter_8_0 == 2 then
			var_8_2 = data
		else
			for iter_8_1, iter_8_2 in pairs(data) do
				var_8_3[var_8_2[iter_8_1]] = tonumber(iter_8_2) ~= 0 and tonumber(iter_8_2) or iter_8_2

				if iter_8_2 == "0" then
					var_8_3[var_8_2[iter_8_1]] = 0
				end
			end

			var_8_0[#var_8_0 + 1] = var_8_3
		end
	end

	return var_8_0
end

function LoadCsvLine(arg_9_0)
	return (var_0_2(arg_9_0))
end
