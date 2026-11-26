require("gamebase.zbLoadCSV")

local var_0_0 = class("zbAvatarRecord")

var_0_0.__index = var_0_0

function createAvatarRecord()
	return (var_0_0.new())
end

zbAvatarTable = {}
zbAvatarTable.records = {}

function zbAvatarTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 then
				-- block empty
			else
				local var_2_1 = tonumber(iter_2_1[1])
				local var_2_2 = createAvatarRecord()
				local var_2_3 = 1

				var_2_2.templateId = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.parentAvatarId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.name = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.headIcon = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_2.lordhead = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				var_2_2.bone = iter_2_1[var_2_8]

				local var_2_9 = var_2_8 + 1

				var_2_2.hudOffset = arg_2_0:parseCoord(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.iconPath = iter_2_1[var_2_10]

				local var_2_11 = var_2_10 + 1

				var_2_2.talkPath = iter_2_1[var_2_11]

				local var_2_12 = var_2_11 + 1

				var_2_2.get = arg_2_0:parseSoundSequence(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.click = arg_2_0:parseSoundSequence(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.bigskill = arg_2_0:parseSoundSequence(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.provoke = arg_2_0:parseSoundSequence(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.die = arg_2_0:parseSoundSequence(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.focusOffset = ccp(0, 0)
				var_2_2.focusOffset.x = var_2_2.hudOffset.x
				var_2_2.focusOffset.y = var_2_2.hudOffset.y / 2
				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbAvatarTable.getRecord(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return nil
	end

	local var_3_0 = arg_3_0.records[arg_3_1]

	if var_3_0 == nil then
		var_3_0 = arg_3_0.records[1071]

		echo("-----warning-----: can not find avatarRecrod: " .. arg_3_1)
	end

	return var_3_0
end

function zbAvatarTable.isValidAvatar(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1] ~= nil
end

function zbAvatarTable.parseCoord(arg_5_0, arg_5_1)
	local var_5_0 = ccp(0, 0)
	local var_5_1, var_5_2 = string.find(arg_5_1, ",")
	local var_5_3 = string.sub(arg_5_1, 2, var_5_1)
	local var_5_4, var_5_5 = string.find(arg_5_1, ", ")
	local var_5_6 = string.sub(arg_5_1, var_5_5 + 1, -2)

	var_5_0.x = tonumber(var_5_3)
	var_5_0.y = tonumber(var_5_6)

	return var_5_0
end

function zbAvatarTable.parseSoundSequence(arg_6_0, arg_6_1)
	local var_6_0 = string.gsub(arg_6_1, "%[", "")
	local var_6_1 = string.gsub(var_6_0, "%]", "")

	return (string.split(var_6_1, ","))
end

function zbAvatarTable.getAvatarSoundList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getRecord(arg_7_1)

	if var_7_0 ~= nil then
		if arg_7_2 == ESoundType.E_GET then
			return var_7_0.get
		elseif arg_7_2 == ESoundType.E_CLICK then
			return var_7_0.click
		elseif arg_7_2 == ESoundType.E_BIGSKILL then
			return var_7_0.bigskill
		elseif arg_7_2 == ESoundType.E_PROVOKE then
			return var_7_0.provoke
		elseif arg_7_2 == ESoundType.E_DIE then
			return var_7_0.die
		else
			return {}
		end
	end

	return {}
end

function zbAvatarTable.getAvatarSoundPath(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getAvatarSoundList(arg_8_1, arg_8_2)
	local var_8_1 = ""

	if table.getn(var_8_0) == 1 then
		var_8_1 = var_8_0[1]
	elseif table.getn(var_8_0) > 1 then
		var_8_1 = var_8_0[zbUtil:random(1, table.getn(var_8_0))]
	end

	if var_8_1 == nil then
		var_8_1 = ""
	end

	return var_8_1
end
