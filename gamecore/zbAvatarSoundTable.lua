require("gamebase.zbLoadCSV")

local var_0_0 = class("zbSoundRecord")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0)
	arg_1_0.avatarId = -1
	arg_1_0.sequenceName = ""
	arg_1_0.sound = ""
end

function createSoundRecord()
	return (var_0_0.new())
end

zbAvatarSoundTable = {}
zbAvatarSoundTable.records = {}
zbAvatarSoundTable.subRecords = {}

function zbAvatarSoundTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 then
				-- block empty
			else
				local var_3_1 = tonumber(iter_3_1[1])
				local var_3_2 = createSoundRecord()

				var_3_2.avatarId = tonumber(iter_3_1[1])
				var_3_2.sequenceName = iter_3_1[2]
				var_3_2.sound1 = iter_3_1[3]
				var_3_2.sound1Frame = tonumber(iter_3_1[4]) / 30
				var_3_2.sound2 = iter_3_1[5]
				var_3_2.sound2Frame = tonumber(iter_3_1[6]) / 30
				var_3_2.attackSound = iter_3_1[7]
				var_3_2.skillIndex = -1

				if var_3_2.sequenceName == "phyattack" then
					var_3_2.skillIndex = 0
				elseif var_3_2.sequenceName == "skill1" then
					var_3_2.skillIndex = 1
				elseif var_3_2.sequenceName == "skill2" then
					var_3_2.skillIndex = 2
				elseif var_3_2.sequenceName == "skill3" then
					var_3_2.skillIndex = 3
				elseif var_3_2.sequenceName == "skill4" then
					var_3_2.skillIndex = 4
				end

				table.insert(arg_3_0.records, var_3_2)

				local var_3_3 = arg_3_0.subRecords[var_3_2.avatarId]

				if var_3_3 == nil then
					arg_3_0.subRecords[var_3_2.avatarId] = {}
					var_3_3 = arg_3_0.subRecords[var_3_2.avatarId]
				end

				var_3_3[var_3_2.sequenceName] = var_3_2
			end
		end
	end

	return arg_3_0
end

function zbAvatarSoundTable.getAttackSoundRecord(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = zbAvatarSoundTable:getSoundList(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if iter_4_1.skillIndex == arg_4_2 then
			if iter_4_1.attackSound == "" then
				echo(string.format("warning: attackSound path is empty: avatarId=%d, skillIndex=%d, sound=%s", arg_4_1, arg_4_2, iter_4_1.attackSound))
			end

			return iter_4_1
		end
	end

	echo(string.format("warning: can not find attackSound: avatarId=%d, skillIndex=%d", arg_4_1, arg_4_2))

	return nil
end

function zbAvatarSoundTable.getSoundList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.subRecords[arg_5_1]

	if var_5_0 ~= nil then
		return var_5_0
	else
		return {}
	end
end

function zbAvatarSoundTable.getSound(arg_6_0, arg_6_1, arg_6_2)
	local function var_6_0(arg_7_0, arg_7_1)
		if arg_7_0 == "" and arg_7_1 == "" then
			return ""
		end

		if arg_7_0 ~= "" and arg_7_1 == "" then
			return arg_7_0
		end

		if arg_7_0 == "" and arg_7_1 ~= "" then
			return arg_7_1
		end

		if math.random(1, 2) == 1 then
			return arg_7_0
		else
			return arg_7_1
		end
	end

	local var_6_1 = arg_6_0.subRecords[arg_6_1]

	if var_6_1 ~= nil then
		local var_6_2 = var_6_1[arg_6_2]

		if var_6_2 ~= nil then
			local var_6_3 = var_6_0(var_6_2.sound1, var_6_2.sound2)

			if var_6_3 == var_6_2.sound1 then
				return var_6_2.sound1, var_6_2.sound1Frame
			elseif var_6_3 == var_6_2.sound2 then
				return var_6_2.sound2, var_6_2.sound2Frame
			end
		end
	end

	return "", 0
end
