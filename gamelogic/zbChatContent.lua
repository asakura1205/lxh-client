require("gamelogic.zbChatContentItem")

local var_0_0 = class("zbChatContent", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = 2

function createChatContent()
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(data)

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	arg_3_0.startpos = 0
	arg_3_0.width = 0
	arg_3_0.chatdatas = {}
end

function var_0_0.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:removeAllChildrenWithCleanup(true)

	arg_4_0.startpos = 0
	arg_4_0.chatdatas = {}

	arg_4_0:filtContent(arg_4_1, arg_4_2)
end

function var_0_0.filtContent(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = a2u(arg_5_1)

	while arg_5_0:filtface(var_5_0) ~= nil do
		if arg_5_0:filtface(var_5_0) == nil then
			break
		end
	end

	while arg_5_0:filtcolor(var_5_0) ~= nil do
		if arg_5_0:filtcolor(var_5_0) == nil then
			break
		end
	end

	if table.getn(arg_5_0.chatdatas) == 0 then
		arg_5_0:createTextLine(var_5_0)

		return
	end

	local function var_5_1(arg_6_0, arg_6_1)
		return arg_6_0.startindex < arg_6_1.startindex
	end

	table.sort(arg_5_0.chatdatas, var_5_1)
	arg_5_0:filt2Newtable(var_5_0)
	arg_5_0:createRichLine(arg_5_2)
end

function var_0_0.filt2Newtable(arg_7_0, arg_7_1)
	arg_7_0.newChatdatas = {}

	local var_7_0 = table.getn(arg_7_0.chatdatas)

	local function var_7_1(arg_8_0, arg_8_1)
		local var_8_0 = 0

		if arg_8_1 then
			var_8_0 = arg_8_1.startindex - 1
		else
			var_8_0 = string.len(arg_7_1)
		end

		local var_8_1 = {}
		local var_8_2 = string.sub(arg_7_1, arg_8_0.endindex + 1, var_8_0)

		if var_8_2 ~= "" and var_8_2 ~= nil then
			var_8_1.content = var_8_2
			var_8_1.type = "chatstr"

			table.insert(arg_7_0.newChatdatas, var_8_1)
		end
	end

	for iter_7_0 = 1, var_7_0 do
		if iter_7_0 == 1 then
			local var_7_2 = arg_7_0.chatdatas[iter_7_0]

			if var_7_2.startindex == 1 then
				table.insert(arg_7_0.newChatdatas, var_7_2)

				local var_7_3 = arg_7_0.chatdatas[iter_7_0 + 1]

				var_7_1(var_7_2, var_7_3)
			else
				local var_7_4 = {}
				local var_7_5 = string.sub(arg_7_1, 1, var_7_2.startindex - 1)

				if var_7_5 ~= "" or var_7_5 ~= nil then
					var_7_4.content = var_7_5
					var_7_4.type = "chatstr"

					table.insert(arg_7_0.newChatdatas, var_7_4)
				end

				table.insert(arg_7_0.newChatdatas, var_7_2)

				local var_7_6 = arg_7_0.chatdatas[iter_7_0 + 1]

				var_7_1(var_7_2, var_7_6)
			end
		elseif iter_7_0 == var_7_0 then
			local var_7_7 = arg_7_0.chatdatas[iter_7_0]

			if var_7_7.endindex == string.len(arg_7_1) then
				table.insert(arg_7_0.newChatdatas, var_7_7)
			else
				table.insert(arg_7_0.newChatdatas, var_7_7)

				local var_7_8 = {}
				local var_7_9 = string.sub(arg_7_1, var_7_7.endindex + 1, string.len(arg_7_1))

				if var_7_9 ~= "" and var_7_9 ~= nil then
					var_7_8.content = var_7_9
					var_7_8.type = "chatstr"

					table.insert(arg_7_0.newChatdatas, var_7_8)
				end
			end
		else
			local var_7_10 = arg_7_0.chatdatas[iter_7_0]
			local var_7_11 = arg_7_0.chatdatas[iter_7_0 + 1]

			table.insert(arg_7_0.newChatdatas, var_7_10)

			local var_7_12 = {}
			local var_7_13 = string.sub(arg_7_1, var_7_10.endindex + 1, var_7_11.startindex - 1)

			if var_7_13 ~= "" and var_7_13 ~= nil then
				var_7_12.content = var_7_13
				var_7_12.type = "chatstr"

				table.insert(arg_7_0.newChatdatas, var_7_12)
			end
		end
	end
end

function var_0_0.createTextLine(arg_9_0, arg_9_1)
	local var_9_0 = CCLabelTTF:create(a2u(arg_9_1), "ui/font/FZY4JW--GB1-0.ttf", 22)
	local var_9_1 = var_9_0:getTxtBound()

	var_9_0:setHorizontalAlignment(kCCTextAlignmentLeft)
	var_9_0:setAnchorPoint(ccp(0, 0.5))
	var_9_0:setColor(ccc3(128, 64, 0))
	arg_9_0:addChild(var_9_0)

	arg_9_0.width = var_9_0:getContentSize().width + 30
end

function var_0_0.createRichLine(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.newChatdatas) do
		local var_10_0 = createChatContentItem(iter_10_1, arg_10_0.startpos, arg_10_1)

		arg_10_0.startpos = var_10_0.pos

		arg_10_0:addChild(var_10_0)
	end

	arg_10_0.width = arg_10_0.startpos + 30
end

function var_0_0.filtrgb(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = string.find(arg_11_1, "0x")
	local var_11_2 = string.len(arg_11_1)

	if var_11_0 == nil or var_11_1 == nil then
		local var_11_3 = {}

		for iter_11_0 = 1, 3 do
			var_11_3[iter_11_0] = 0
		end

		return var_11_3
	end

	local var_11_4 = var_11_1 + 1

	if var_11_2 <= var_11_4 then
		local var_11_5 = {}

		for iter_11_1 = 1, 3 do
			var_11_5[iter_11_1] = 0
		end

		return var_11_5
	end

	local var_11_6 = "0x" .. string.sub(arg_11_1, var_11_4, var_11_4 + 1)
	local var_11_7 = var_11_4 + 2

	if var_11_2 <= var_11_7 then
		color2 = "0x00"
	else
		color2 = "0x" .. string.sub(arg_11_1, var_11_7, var_11_7 + 1)
	end

	local var_11_8 = var_11_7 + 2

	if var_11_2 <= var_11_8 then
		color3 = "0x00"
	else
		color3 = "0x" .. string.sub(arg_11_1, var_11_8, var_11_8 + 1)
	end

	local var_11_9 = {}

	if var_11_6 == nil then
		var_11_6 = "0x00"
	end

	if color2 == nil then
		color2 = "0x00"
	end

	if color3 == nil then
		color3 = "0x00"
	end

	var_11_9[1] = string.format("%d", var_11_6)
	var_11_9[2] = string.format("%d", color2)
	var_11_9[3] = string.format("%d", color3)

	return var_11_9
end

function var_0_0.getlastdata(arg_12_0, arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0.chatdatas) do
		if iter_12_1.type == arg_12_1 and var_12_0 <= iter_12_1.endindex then
			var_12_0 = iter_12_1.endindex
		end
	end

	return var_12_0
end

function var_0_0.filtequip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getlastdata("equip")
	local var_13_1 = arg_13_1
	local var_13_2 = string.sub(var_13_1, var_13_0 + 1, string.len(arg_13_1))
	local var_13_3, var_13_4 = string.find(var_13_2, "%[e]")
	local var_13_5, var_13_6 = string.find(var_13_2, "%[/e]")

	if var_13_3 == nil or var_13_5 == nil or var_13_4 == nil or var_13_6 == nil then
		return nil
	end

	local var_13_7 = string.sub(var_13_2, var_13_4 + 1, var_13_5 - 1)
	local var_13_8 = {
		startindex = var_13_3 + var_13_0,
		endindex = var_13_6 + var_13_0,
		content = var_13_7
	}

	var_13_8.type = "equip"

	table.insert(arg_13_0.chatdatas, var_13_8)

	return var_13_7
end

function var_0_0.filtehero(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getlastdata("hero")
	local var_14_1 = arg_14_1
	local var_14_2 = string.sub(var_14_1, var_14_0 + 1, string.len(arg_14_1))
	local var_14_3, var_14_4 = string.find(var_14_2, "%[h]")
	local var_14_5, var_14_6 = string.find(var_14_2, "%[/h]")

	if var_14_3 == nil or var_14_5 == nil or var_14_4 == nil or var_14_6 == nil then
		return nil
	end

	local var_14_7 = string.sub(var_14_2, var_14_4 + 1, var_14_5 - 1)
	local var_14_8 = {
		startindex = var_14_3 + var_14_0,
		endindex = var_14_6 + var_14_0,
		content = var_14_7
	}

	var_14_8.type = "hero"

	table.insert(arg_14_0.chatdatas, var_14_8)

	return var_14_7
end

function var_0_0.filtface(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getlastdata("face")
	local var_15_1 = arg_15_1
	local var_15_2 = string.sub(var_15_1, var_15_0 + 1, string.len(arg_15_1))
	local var_15_3, var_15_4 = string.find(var_15_2, "%#")

	if var_15_3 == nil or var_15_4 == nil then
		return nil
	end

	local var_15_5 = string.sub(var_15_2, var_15_4 + 1, var_15_4 + var_0_1)
	local var_15_6 = {
		startindex = var_15_3 + var_15_0,
		endindex = var_15_3 + var_0_1 + var_15_0,
		content = var_15_5
	}

	var_15_6.type = "face"

	table.insert(arg_15_0.chatdatas, var_15_6)

	return var_15_5
end

function var_0_0.filtcolor(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getlastdata("color")
	local var_16_1 = arg_16_1
	local var_16_2 = string.sub(var_16_1, var_16_0 + 1, string.len(arg_16_1))
	local var_16_3, var_16_4 = string.find(var_16_2, "%[color=%w+]")
	local var_16_5, var_16_6 = string.find(var_16_2, "%[/color]")

	if var_16_3 == nil or var_16_5 == nil or var_16_4 == nil or var_16_6 == nil then
		return nil
	end

	local var_16_7 = string.match(var_16_2, "%[color=%w+]")
	local var_16_8 = string.sub(var_16_7, 8, string.len(var_16_7) - 1)
	local var_16_9 = arg_16_0:filtrgb(var_16_8)
	local var_16_10 = string.sub(var_16_2, var_16_4 + 1, var_16_5 - 1)
	local var_16_11 = {
		startindex = var_16_3 + var_16_0,
		endindex = var_16_6 + var_16_0,
		content = var_16_10
	}

	var_16_11.type = "color"
	var_16_11.color = var_16_9

	table.insert(arg_16_0.chatdatas, var_16_11)

	return var_16_10
end
