io.output():setvbuf("no")

function echo(...)
	if v_PutoutLog == false then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs({
		...
	}) do
		var_1_0[#var_1_0 + 1] = tostring(iter_1_1)
	end

	CCLuaLog(table.concat(var_1_0, "\t"))
end

print = echo

function printf(arg_2_0, ...)
	echo(string.format(tostring(arg_2_0), ...))
end

function echoError(arg_3_0, ...)
	echo(string.format("[ERR] %s%s", string.format(tostring(arg_3_0), ...), debug.traceback("", 2)))
end

function echoInfo(arg_4_0, ...)
	echo("[INFO] " .. string.format(tostring(arg_4_0), ...))
end

function echoLog(arg_5_0, arg_5_1, ...)
	echo(string.format("[%s] %s", string.upper(tostring(arg_5_0)), string.format(tostring(arg_5_1), ...)))
end

function dump(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if type(arg_6_3) ~= "number" then
		arg_6_3 = 99
	end

	local var_6_0 = {}
	local var_6_1 = {}

	local function var_6_2(arg_7_0)
		if type(arg_7_0) == "string" then
			arg_7_0 = "\"" .. arg_7_0 .. "\""
		end

		return tostring(arg_7_0)
	end

	local var_6_3 = string.split(debug.traceback("", 2), "\n")

	echo("dump from: " .. string.trim(var_6_3[3]))

	local function var_6_4(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		arg_8_1 = arg_8_1 or "<var>"
		spc = ""

		if type(arg_8_4) == "number" then
			spc = string.rep(" ", arg_8_4 - string.len(var_6_2(arg_8_1)))
		end

		if type(arg_8_0) ~= "table" then
			var_6_1[#var_6_1 + 1] = string.format("%s%s%s = %s", arg_8_2, var_6_2(arg_8_1), spc, var_6_2(arg_8_0))
		elseif var_6_0[arg_8_0] then
			var_6_1[#var_6_1 + 1] = string.format("%s%s%s = *REF*", arg_8_2, arg_8_1, spc)
		else
			var_6_0[arg_8_0] = true

			if arg_8_3 > arg_6_3 then
				var_6_1[#var_6_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_8_2, arg_8_1)
			else
				var_6_1[#var_6_1 + 1] = string.format("%s%s = {", arg_8_2, var_6_2(arg_8_1))

				local var_8_0 = arg_8_2 .. "    "
				local var_8_1 = {}
				local var_8_2 = 0
				local var_8_3 = {}

				for iter_8_0, iter_8_1 in pairs(arg_8_0) do
					var_8_1[#var_8_1 + 1] = iter_8_0

					local var_8_4 = var_6_2(iter_8_0)
					local var_8_5 = string.len(var_8_4)

					if var_8_2 < var_8_5 then
						var_8_2 = var_8_5
					end

					var_8_3[iter_8_0] = iter_8_1
				end

				table.sort(var_8_1, function(arg_9_0, arg_9_1)
					if type(arg_9_0) == "number" and type(arg_9_1) == "number" then
						return arg_9_0 < arg_9_1
					else
						return tostring(arg_9_0) < tostring(arg_9_1)
					end
				end)

				for iter_8_2, iter_8_3 in ipairs(var_8_1) do
					var_6_4(var_8_3[iter_8_3], iter_8_3, var_8_0, arg_8_3 + 1, var_8_2)
				end

				var_6_1[#var_6_1 + 1] = string.format("%s}", arg_8_2)
			end
		end
	end

	var_6_4(arg_6_0, arg_6_1, "- ", 1)

	if arg_6_2 then
		return table.concat(var_6_1, "\n")
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		echo(iter_6_1)
	end
end

function vardump(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}

	local function var_10_2(arg_11_0)
		if type(arg_11_0) == "string" then
			arg_11_0 = "\"" .. arg_11_0 .. "\""
		end

		return tostring(arg_11_0)
	end

	local function var_10_3(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		arg_12_1 = arg_12_1 or "<var>"

		local var_12_0 = ""

		if arg_12_3 > 1 then
			var_12_0 = ","
		end

		if type(arg_12_0) ~= "table" then
			if type(arg_12_1) == "string" then
				var_10_1[#var_10_1 + 1] = string.format("%s%s = %s%s", arg_12_2, arg_12_1, var_10_2(arg_12_0), var_12_0)
			else
				var_10_1[#var_10_1 + 1] = string.format("%s%s%s", arg_12_2, var_10_2(arg_12_0), var_12_0)
			end
		elseif not var_10_0[arg_12_0] then
			var_10_0[arg_12_0] = true

			if type(arg_12_1) == "string" then
				var_10_1[#var_10_1 + 1] = string.format("%s%s = {", arg_12_2, arg_12_1)
			else
				var_10_1[#var_10_1 + 1] = string.format("%s{", arg_12_2)
			end

			local var_12_1 = arg_12_2 .. "    "
			local var_12_2 = {}
			local var_12_3 = {}

			for iter_12_0, iter_12_1 in pairs(arg_12_0) do
				var_12_2[#var_12_2 + 1] = iter_12_0
				var_12_3[iter_12_0] = iter_12_1
			end

			table.sort(var_12_2, function(arg_13_0, arg_13_1)
				if type(arg_13_0) == "number" and type(arg_13_1) == "number" then
					return arg_13_0 < arg_13_1
				else
					return tostring(arg_13_0) < tostring(arg_13_1)
				end
			end)

			for iter_12_2, iter_12_3 in ipairs(var_12_2) do
				var_10_3(var_12_3[iter_12_3], iter_12_3, var_12_1, arg_12_3 + 1)
			end

			var_10_1[#var_10_1 + 1] = string.format("%s}%s", arg_12_2, var_12_0)
		end
	end

	var_10_3(arg_10_0, arg_10_1, "", 1)

	return table.concat(var_10_1, "\n")
end
