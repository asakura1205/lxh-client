zbBase64Encode = {}

local var_0_0 = string

zbBase64Encode.__code = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"+",
	"/"
}
zbBase64Encode.__decode = {}

for iter_0_0, iter_0_1 in pairs(zbBase64Encode.__code) do
	zbBase64Encode.__decode[var_0_0.byte(iter_0_1, 1)] = iter_0_0 - 1
end

function zbBase64Encode.encode(arg_1_0)
	local var_1_0 = var_0_0.len(arg_1_0)
	local var_1_1 = var_1_0 % 3
	local var_1_2 = var_1_0 - var_1_1
	local var_1_3 = {}
	local var_1_4 = 1

	for iter_1_0 = 1, var_1_2, 3 do
		local var_1_5 = var_0_0.byte(arg_1_0, iter_1_0)
		local var_1_6 = var_0_0.byte(arg_1_0, iter_1_0 + 1)
		local var_1_7 = var_0_0.byte(arg_1_0, iter_1_0 + 2)
		local var_1_8 = var_1_5 * 65536 + var_1_6 * 256 + var_1_7

		for iter_1_1 = 1, 4 do
			local var_1_9 = math.floor(var_1_8 / 2^((4 - iter_1_1) * 6)) % 64 + 1

			var_1_3[var_1_4] = zbBase64Encode.__code[var_1_9]
			var_1_4 = var_1_4 + 1
		end
	end

	if var_1_1 == 1 then
		zbBase64Encode.__left1(var_1_3, var_1_4, arg_1_0, var_1_2)
	elseif var_1_1 == 2 then
		zbBase64Encode.__left2(var_1_3, var_1_4, arg_1_0, var_1_2)
	end

	return table.concat(var_1_3)
end

function zbBase64Encode.__left2(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.byte(arg_2_2, arg_2_3 + 1) * 1024 + var_0_0.byte(arg_2_2, arg_2_3 + 2) * 4
	local var_2_1 = math.floor(var_2_0 / 4096) % 64 + 1

	arg_2_0[arg_2_1] = zbBase64Encode.__code[var_2_1]

	local var_2_2 = math.floor(var_2_0 / 64) % 64 + 1

	arg_2_0[arg_2_1 + 1] = zbBase64Encode.__code[var_2_2]

	local var_2_3 = var_2_0 % 64 + 1

	arg_2_0[arg_2_1 + 2] = zbBase64Encode.__code[var_2_3]
	arg_2_0[arg_2_1 + 3] = "="
end

function zbBase64Encode.__left1(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = var_0_0.byte(arg_3_2, arg_3_3 + 1) * 16

	tmp = math.floor(var_3_0 / 64)

	local var_3_1 = tmp % 64 + 1

	arg_3_0[arg_3_1] = zbBase64Encode.__code[var_3_1]

	local var_3_2 = var_3_0 % 64 + 1

	arg_3_0[arg_3_1 + 1] = zbBase64Encode.__code[var_3_2]
	arg_3_0[arg_3_1 + 2] = "="
	arg_3_0[arg_3_1 + 3] = "="
end

function zbBase64Encode.decode(arg_4_0)
	local var_4_0 = var_0_0.len(arg_4_0)
	local var_4_1 = 0

	if var_0_0.sub(arg_4_0, var_4_0 - 1) == "==" then
		var_4_1 = 2
		var_4_0 = var_4_0 - 4
	elseif var_0_0.sub(arg_4_0, var_4_0) == "=" then
		var_4_1 = 1
		var_4_0 = var_4_0 - 4
	end

	local var_4_2 = {}
	local var_4_3 = 1
	local var_4_4 = zbBase64Encode.__decode

	for iter_4_0 = 1, var_4_0, 4 do
		local var_4_5 = var_4_4[var_0_0.byte(arg_4_0, iter_4_0)]
		local var_4_6 = var_4_4[var_0_0.byte(arg_4_0, iter_4_0 + 1)]
		local var_4_7 = var_4_4[var_0_0.byte(arg_4_0, iter_4_0 + 2)]
		local var_4_8 = var_4_4[var_0_0.byte(arg_4_0, iter_4_0 + 3)]
		local var_4_9 = var_4_5 * 262144 + var_4_6 * 4096 + var_4_7 * 64 + var_4_8
		local var_4_10 = var_0_0.char(var_4_9 % 256)
		local var_4_11 = math.floor(var_4_9 / 256)
		local var_4_12 = var_0_0.char(var_4_11 % 256)
		local var_4_13 = math.floor(var_4_11 / 256)

		var_4_2[var_4_3] = var_0_0.char(var_4_13 % 256)
		var_4_2[var_4_3 + 1] = var_4_12
		var_4_2[var_4_3 + 2] = var_4_10
		var_4_3 = var_4_3 + 3
	end

	if var_4_1 == 1 then
		zbBase64Encode.__decodeLeft1(var_4_2, var_4_3, arg_4_0, var_4_0)
	elseif var_4_1 == 2 then
		zbBase64Encode.__decodeLeft2(var_4_2, var_4_3, arg_4_0, var_4_0)
	end

	return table.concat(var_4_2)
end

function zbBase64Encode.__decodeLeft1(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = zbBase64Encode.__decode
	local var_5_1 = var_5_0[var_0_0.byte(arg_5_2, arg_5_3 + 1)]
	local var_5_2 = var_5_0[var_0_0.byte(arg_5_2, arg_5_3 + 2)]
	local var_5_3 = var_5_0[var_0_0.byte(arg_5_2, arg_5_3 + 3)]
	local var_5_4 = var_5_1 * 4096 + var_5_2 * 64 + var_5_3
	local var_5_5 = math.floor(var_5_4 / 1024) % 256
	local var_5_6 = math.floor(var_5_4 / 4) % 256

	arg_5_0[arg_5_1] = var_0_0.char(var_5_5)
	arg_5_0[arg_5_1 + 1] = var_0_0.char(var_5_6)
end

function zbBase64Encode.__decodeLeft2(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = zbBase64Encode.__decode
	local var_6_1 = var_6_0[var_0_0.byte(arg_6_2, arg_6_3 + 1)]
	local var_6_2 = var_6_0[var_0_0.byte(arg_6_2, arg_6_3 + 2)]
	local var_6_3 = var_6_1 * 64 + var_6_2
	local var_6_4 = math.floor(var_6_3 / 16)

	arg_6_0[arg_6_1] = var_0_0.char(var_6_4)
end

function zbBase64Encode.test()
	local var_7_0 = "a\xC1\xCF="
	local var_7_1 = zbBase64Encode.encode(var_7_0)

	print(var_7_1)

	def = zbBase64Encode.decode(var_7_1)

	if def == var_7_0 then
		print("yes")
	end
end

zbBase64Encode.test()
