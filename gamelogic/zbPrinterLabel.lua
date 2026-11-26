zbPrinterLabel = class("zbPrinterLabel")
zbPrinterLabel.__index = zbPrinterLabel

function zbPrinterLabel.create(arg_1_0)
	local var_1_0 = zbPrinterLabel.new()

	var_1_0:init()

	return var_1_0
end

function zbPrinterLabel.init(arg_2_0)
	return
end

function zbPrinterLabel.start(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.label = arg_3_1
	arg_3_0.content = arg_3_2
	arg_3_0.wordsCount = arg_3_0:getWordsCount(arg_3_2)
	arg_3_0.wordsIndex = 0
	arg_3_0.accumTime = 0
	arg_3_0.PRINT_SPEED_PERWORD = 0.032
end

function zbPrinterLabel.isEnd(arg_4_0)
	if arg_4_0.label == nil then
		return true
	end

	return arg_4_0.wordsIndex >= arg_4_0.wordsCount
end

function zbPrinterLabel.addSpeed(arg_5_0)
	arg_5_0.PRINT_SPEED_PERWORD = 0.015
end

function zbPrinterLabel.update(arg_6_0, arg_6_1)
	if arg_6_0.label == nil then
		return
	end

	if arg_6_0.wordsIndex >= arg_6_0.wordsCount then
		return
	end

	arg_6_0.accumTime = arg_6_0.accumTime + arg_6_1
	arg_6_0.wordsIndex = tonumber(math.floor(arg_6_0.accumTime / arg_6_0.PRINT_SPEED_PERWORD))

	local var_6_0 = arg_6_0:getSubWords(arg_6_0.content, arg_6_0.wordsIndex)

	arg_6_0.label:setString(var_6_0)
end

function zbPrinterLabel.getWordsCount(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = 1
	local var_7_2 = arg_7_1:len()

	while var_7_1 <= var_7_2 do
		local var_7_3 = 2

		var_7_1 = var_7_1 + (string.byte(arg_7_1, var_7_1) > 128 and 3 or 1)
		var_7_0 = var_7_0 + 1
	end

	return var_7_0
end

function zbPrinterLabel.getSubWords(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = 1
	local var_8_2 = arg_8_1:len()

	while var_8_1 <= var_8_2 do
		local var_8_3 = 2

		var_8_1 = var_8_1 + (string.byte(arg_8_1, var_8_1) > 128 and 3 or 1)
		var_8_0 = var_8_0 + 1

		if arg_8_2 <= var_8_0 then
			break
		end
	end

	return arg_8_1:sub(1, var_8_1 - 1)
end
