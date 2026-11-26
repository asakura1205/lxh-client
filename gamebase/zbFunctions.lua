local var_0_0 = tonumber

function tonumber(arg_1_0, arg_1_1)
	return var_0_0(arg_1_0, arg_1_1) or 0
end

function toint(arg_2_0)
	return math.round(tonumber(arg_2_0))
end

function tobool(arg_3_0)
	return arg_3_0 ~= nil and arg_3_0 ~= false
end

function totable(arg_4_0)
	if type(arg_4_0) ~= "table" then
		arg_4_0 = {}
	end

	return arg_4_0
end

function clone(arg_5_0)
	local var_5_0 = {}

	local function var_5_1(arg_6_0)
		if type(arg_6_0) ~= "table" then
			return arg_6_0
		elseif var_5_0[arg_6_0] then
			return var_5_0[arg_6_0]
		end

		local var_6_0 = {}

		var_5_0[arg_6_0] = var_6_0

		for iter_6_0, iter_6_1 in pairs(arg_6_0) do
			var_6_0[var_5_1(iter_6_0)] = var_5_1(iter_6_1)
		end

		return setmetatable(var_6_0, getmetatable(arg_6_0))
	end

	return var_5_1(arg_5_0)
end

function class(arg_7_0, arg_7_1)
	local var_7_0 = type(arg_7_1)
	local var_7_1

	if var_7_0 ~= "function" and var_7_0 ~= "table" then
		var_7_0 = nil
		arg_7_1 = nil
	end

	if var_7_0 == "function" or arg_7_1 and arg_7_1.__ctype == 1 then
		var_7_1 = {}

		if var_7_0 == "table" then
			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				var_7_1[iter_7_0] = iter_7_1
			end

			var_7_1.__create = arg_7_1.__create
			var_7_1.super = arg_7_1
		else
			var_7_1.__create = arg_7_1

			function var_7_1.ctor()
				return
			end
		end

		var_7_1.__cname = arg_7_0
		var_7_1.__ctype = 1

		function var_7_1.new(...)
			local var_9_0 = var_7_1.__create(...)

			for iter_9_0, iter_9_1 in pairs(var_7_1) do
				var_9_0[iter_9_0] = iter_9_1
			end

			var_9_0.class = var_7_1

			var_9_0:ctor(...)

			return var_9_0
		end
	else
		if arg_7_1 then
			var_7_1 = clone(arg_7_1)
			var_7_1.super = arg_7_1
		else
			var_7_1 = {
				ctor = function()
					return
				end
			}
		end

		var_7_1.__cname = arg_7_0
		var_7_1.__ctype = 2
		var_7_1.__index = var_7_1

		function var_7_1.new(...)
			local var_11_0 = setmetatable({}, var_7_1)

			var_11_0.class = var_7_1

			var_11_0:ctor(...)

			return var_11_0
		end
	end

	return var_7_1
end

function import(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = arg_12_0
	local var_12_2 = 1

	while true do
		if string.byte(arg_12_0, var_12_2) ~= 46 then
			var_12_1 = string.sub(arg_12_0, var_12_2)

			if var_12_0 and #var_12_0 > 0 then
				var_12_1 = table.concat(var_12_0, ".") .. "." .. var_12_1
			end

			break
		end

		var_12_2 = var_12_2 + 1

		if not var_12_0 then
			if not arg_12_1 then
				local var_12_3, var_12_4 = debug.getlocal(3, 1)

				arg_12_1 = var_12_4
			end

			var_12_0 = string.split(arg_12_1, ".")
		end

		table.remove(var_12_0, #var_12_0)
	end

	return require(var_12_1)
end

function handler(arg_13_0, arg_13_1)
	return function(...)
		return arg_13_1(arg_13_0, ...)
	end
end

function math.round(arg_15_0)
	return math.floor(arg_15_0 + 0.5)
end

function io.exists(arg_16_0)
	local var_16_0 = io.open(arg_16_0, "r")

	if var_16_0 then
		io.close(var_16_0)

		return true
	end

	return false
end

function io.readfile(arg_17_0)
	local var_17_0 = io.open(arg_17_0, "r")

	if var_17_0 then
		local var_17_1 = var_17_0:read("*a")

		io.close(var_17_0)

		return var_17_1
	end

	return nil
end

function io.writefile(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or "w+"

	local var_18_0 = io.open(arg_18_0, arg_18_2)

	if var_18_0 then
		if var_18_0:write(arg_18_1) == nil then
			return false
		end

		io.close(var_18_0)

		return true
	else
		return false
	end
end

function io.pathinfo(arg_19_0)
	local var_19_0 = string.len(arg_19_0)
	local var_19_1 = var_19_0 + 1

	while var_19_0 > 0 do
		local var_19_2 = string.byte(arg_19_0, var_19_0)

		if var_19_2 == 46 then
			var_19_1 = var_19_0
		elseif var_19_2 == 47 then
			break
		end

		var_19_0 = var_19_0 - 1
	end

	local var_19_3 = string.sub(arg_19_0, 1, var_19_0)
	local var_19_4 = string.sub(arg_19_0, var_19_0 + 1)
	local var_19_5 = var_19_1 - var_19_0
	local var_19_6 = string.sub(var_19_4, 1, var_19_5 - 1)
	local var_19_7 = string.sub(var_19_4, var_19_5)

	return {
		dirname = var_19_3,
		filename = var_19_4,
		basename = var_19_6,
		extname = var_19_7
	}
end

function io.filesize(arg_20_0)
	local var_20_0 = false
	local var_20_1 = io.open(arg_20_0, "r")

	if var_20_1 then
		local var_20_2 = var_20_1:seek()

		var_20_0 = var_20_1:seek("end")

		var_20_1:seek("set", var_20_2)
		io.close(var_20_1)
	end

	return var_20_0
end

function table.nums(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0) do
		var_21_0 = var_21_0 + 1
	end

	return var_21_0
end

function table.keys(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0) do
		var_22_0[#var_22_0 + 1] = iter_22_0
	end

	return var_22_0
end

function table.values(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0) do
		var_23_0[#var_23_0 + 1] = iter_23_1
	end

	return var_23_0
end

function table.merge(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		arg_24_0[iter_24_0] = iter_24_1
	end
end

function string.htmlspecialchars(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(string._htmlspecialchars_set) do
		arg_25_0 = string.gsub(arg_25_0, iter_25_0, iter_25_1)
	end

	return arg_25_0
end

string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.nl2br(arg_26_0)
	return string.gsub(arg_26_0, "\n", "<br />")
end

function string.text2html(arg_27_0)
	arg_27_0 = string.gsub(arg_27_0, "\t", "    ")
	arg_27_0 = string.htmlspecialchars(arg_27_0)
	arg_27_0 = string.gsub(arg_27_0, " ", "&nbsp;")
	arg_27_0 = string.nl2br(arg_27_0)

	return arg_27_0
end

function string.split(arg_28_0, arg_28_1)
	if arg_28_1 == "" then
		return false
	end

	local var_28_0 = 0
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in function()
		return string.find(arg_28_0, arg_28_1, var_28_0, true)
	end do
		table.insert(var_28_1, string.sub(arg_28_0, var_28_0, iter_28_0 - 1))

		var_28_0 = iter_28_1 + 1
	end

	table.insert(var_28_1, string.sub(arg_28_0, var_28_0))

	return var_28_1
end

function string.ltrim(arg_30_0)
	return string.gsub(arg_30_0, "^[ \t\n\r]+", "")
end

function string.rtrim(arg_31_0)
	return string.gsub(arg_31_0, "[ \t\n\r]+$", "")
end

function string.trim(arg_32_0)
	arg_32_0 = string.gsub(arg_32_0, "^[ \t\n\r]+", "")

	return string.gsub(arg_32_0, "[ \t\n\r]+$", "")
end

function string.ucfirst(arg_33_0)
	return string.upper(string.sub(arg_33_0, 1, 1)) .. string.sub(arg_33_0, 2)
end

function string.urlencodeChar(arg_34_0)
	return "%" .. string.format("%02X", string.byte(arg_34_0))
end

function string.urlencode(arg_35_0)
	arg_35_0 = string.gsub(arg_35_0, "([^%w%.%-_~ ])", function(arg_36_0)
		return string.format("%%%02X", string.byte(arg_36_0))
	end)

	return string.gsub(arg_35_0, " ", "%%20")
end

function string.urldecode(arg_37_0)
	arg_37_0 = string.gsub(arg_37_0, "%%(%x%x)", function(arg_38_0)
		return string.char(tonumber(arg_38_0, 16))
	end)

	return arg_37_0
end

function string.utf8len(arg_39_0)
	local var_39_0 = #arg_39_0
	local var_39_1 = 0
	local var_39_2 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while var_39_0 ~= 0 do
		local var_39_3 = string.byte(arg_39_0, -var_39_0)
		local var_39_4 = #var_39_2

		while var_39_2[var_39_4] do
			if var_39_3 >= var_39_2[var_39_4] then
				var_39_0 = var_39_0 - var_39_4

				break
			end

			var_39_4 = var_39_4 - 1
		end

		var_39_1 = var_39_1 + 1
	end

	return var_39_1
end

function string.formatNumberThousands(arg_40_0)
	local var_40_0 = tostring(tonumber(arg_40_0))

	repeat
		var_40_0, k = string.gsub(var_40_0, "^(-?%d+)(%d%d%d)", "%1,%2")
	until k == 0

	return var_40_0
end
