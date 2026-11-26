zbLegionHelp = {}

local var_0_0 = {
	"ui/image/rank/rank_first.png",
	"ui/image/rank/rank_second.png",
	"ui/image/rank/rank_third.png"
}
local var_0_1 = {
	"member.png",
	"adviser.png",
	"leader.png"
}
local var_0_2 = {
	[ELegionTechType.Legion] = "ui/image/legion/donate/donatetype0.png",
	[ELegionTechType.Member] = "ui/image/legion/donate/donatetype1.png",
	[ELegionTechType.LegionBoss] = "ui/image/legion/donate/donatetype2.png",
	[ELegionTechType.Treasure] = "ui/image/legion/donate/donatetype4.png",
	[ELegionTechType.DinnerOpen] = "ui/image/legion/donate/donatetype5.png",
	[ELegionTechType.DinnerGain] = "ui/image/legion/donate/donatetype6.png",
	[ELegionTechType.Training] = "ui/image/legion/donate/donatetype3.png"
}
local var_0_3 = {
	[ELegionTechType.Legion] = "\xCC\xE1\xC9\xFD\xBB\xE1\xB9ݵȼ\xB6",
	[ELegionTechType.Member] = "\xCC\xE1\xC9\xFD\xBB\xE1\xB9ݿ\xC9\xC8\xDD\xC4ɳ\xC9Ա\xCA\xFD\xC1\xBF",
	[ELegionTechType.LegionBoss] = "\xCC\xE1\xC9\xFD\xBE\xABӢ\xCC\xF4ս\xC8\xFC\xBF\xC9\xD2\xD4\xCC\xF4ս\xB5ľ\xABӢ\xCA\xFD\xC1\xBF",
	[ELegionTechType.Treasure] = "\xCC\xE1\xC9\xFD\xB9\xAB\xBB\xE1\xB3\xC9Ա\xD4ڷ\xAD\xB9\xF6\xB0ɱ\xA6\xB2\xD8\xD6еĿ\xAA\xBEִ\xCE\xCA\xFD",
	[ELegionTechType.DinnerOpen] = "\xCC\xE1\xC9\xFD\xD1\xE7\xBB\xE1\xCCṩ\xB5\xC4\xD7\xDC\xD3\xE3\xB8\xC9\xCA\xFD\xC1\xBF",
	[ELegionTechType.DinnerGain] = "\xCC\xE1\xC9\xFD\xB9\xAB\xBB\xE1\xB3\xC9Ա\xBF\xC9\xD2\xD4\xD4\xDA\xD1\xE7\xBB\xE1\xD6\xD0\xC1\xECȡ\xB5\xC4\xD3\xE3\xB8\xC9\xCA\xFD\xC1\xBF",
	[ELegionTechType.Training] = "\xCC\xE1\xC9\xFD\xC1\xB7\xCE䳡\xD6\xD0ͬʱ\xBF\xC9ѵ\xC1\xB7\xB5Ļ\xEF\xB0\xE9\xCA\xFD\xC1\xBF"
}
local var_0_4 = {
	ELegionTechType.Legion,
	ELegionTechType.LegionDonate,
	ELegionTechType.Bless,
	ELegionTechType.Training,
	ELegionTechType.DinnerOpen,
	ELegionTechType.LegionBattle,
	ELegionTechType.LegionBoss,
	ELegionTechType.Treasure,
	ELegionTechType.LegionWelfare,
	ELegionTechType.Hongbao
}

function zbLegionHelp.setLegionRankTexture(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_2:setVisible(arg_1_3 > 3)
	arg_1_1:setVisible(arg_1_3 <= 3)

	if arg_1_3 <= 3 then
		arg_1_1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_0[arg_1_3]))
	else
		arg_1_2:setString(arg_1_3)
	end
end

function zbLegionHelp.setLegionLvTexture(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_2_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/legion.plist")

	local var_2_0 = arg_2_0.spriteframeCache:spriteFrameByName("legionlv" .. arg_2_2 .. ".png")

	if var_2_0 then
		arg_2_1:initWithSpriteFrame(var_2_0)
	end
end

function zbLegionHelp.setLegionDonateTypeTexture(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = var_0_2[arg_3_3]
	local var_3_1 = var_0_3[arg_3_3]

	if var_3_0 then
		arg_3_1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_3_0))
	end

	if var_3_1 then
		arg_3_2:setString(a2u(var_3_1))
	else
		arg_3_2:setString(a2u(""))
	end
end

function zbLegionHelp.getLegionMaxExp(arg_4_0, arg_4_1)
	local var_4_0 = ELegionTechType.Legion
	local var_4_1 = zbLegionTechTable:getRecord(var_4_0)
	local var_4_2 = 0

	if var_4_1 then
		local var_4_3 = var_4_1.upgradeId

		return (zbLegionTechUpgradeTable:getexpByIdAndLv(var_4_3, arg_4_1))
	end

	return 0
end

function zbLegionHelp.getLegionDonateList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(zbLegionTechTable.records) do
		if iter_5_1.upgradeId ~= 0 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	local function var_5_1(arg_6_0, arg_6_1)
		return arg_6_0.unlock < arg_6_1.unlock
	end

	table.sort(var_5_0, var_5_1)

	return var_5_0
end

function zbLegionHelp.getBuildingTechId(arg_7_0, arg_7_1)
	if var_0_4[arg_7_1] then
		return var_0_4[arg_7_1]
	end

	return 0
end

function zbLegionHelp.setOfficeTexture(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_8_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/legion.plist")

	local var_8_0 = arg_8_0.spriteframeCache:spriteFrameByName(var_0_1[arg_8_2])

	if var_8_0 then
		arg_8_1:initWithSpriteFrame(var_8_0)
	end
end

function zbLegionHelp.getLogDesc(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return "nil"
	end

	local var_9_0 = ""

	arg_9_1.OpType = tonumber(arg_9_1.Type)

	if arg_9_1.OpType == ELegionLogType.Join then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xBC\xD3\xC8\xEB\xBB\xE1\xB9\xDD")
	elseif arg_9_1.OpType == ELegionLogType.Quit then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xC0뿪\xBB\xE1\xB9\xDD")
	elseif arg_9_1.OpType == ELegionLogType.Kick then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xB1\xBB\xCC߳\xF6\xBB\xE1\xB9\xDD")
	elseif arg_9_1.OpType == ELegionLogType.Leader then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xB3\xC9Ϊ\xB9ݳ\xA4")
	elseif arg_9_1.OpType == ELegionLogType.Adviser then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xB3\xC9Ϊ\xB8\xB1\xB9ݳ\xA4")
	elseif arg_9_1.OpType == ELegionLogType.Donate then
		var_9_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xBE\xE8\xCF\xD7\xC1\xCB") .. arg_9_1.Value
		arg_9_1.VType = tonumber(arg_9_1.VType)

		if arg_9_1.VType == EMoneyType.Gold then
			var_9_0 = var_9_0 .. a2u("\xBD\xF0\xB1\xD2")
		else
			var_9_0 = var_9_0 .. a2u("\xD7\xEAʯ")
		end
	elseif arg_9_1.OpType == ELegionLogType.Dinner then
		var_9_0 = a2u("\xA1\xBE\xCD\xE6\xBC\xD2") .. a2u(arg_9_1.RoleName) .. a2u("\xA1\xBF\xBF\xAA\xC6\xF4\xC1\xCB\xD1\xE7\xBB\xE1")
	end

	return var_9_0
end

function zbLegionHelp.getBlessLogDesc(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		return "nil"
	end

	local var_10_0 = ""

	if arg_10_1.AttrType == EAttrType.HP then
		var_10_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_10_1.RoleName) .. a2u("\xA1\xBF\xBB\xA8\xB7\xD1") .. arg_10_1.Cost .. a2u("\xD7\xEAʯ\xBD\xF8\xD0С\xBEѪ\xC1\xBF\xC6\xED\xB8\xA3\xA1\xBF\xA3\xACѪ\xC1\xBF\xBCӳ\xC9Ϊ" .. arg_10_1.Addition .. "%")
	elseif arg_10_1.AttrType == EAttrType.PhysicAttack then
		var_10_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_10_1.RoleName) .. a2u("\xA1\xBF\xBB\xA8\xB7\xD1") .. arg_10_1.Cost .. a2u("\xD7\xEAʯ\xBD\xF8\xD0С\xBE\xCE\xEF\xC0\xED\xB9\xA5\xBB\xF7\xC6\xED\xB8\xA3\xA1\xBF\xA3\xAC\xCE\xEF\xC0\xED\xB9\xA5\xBB\xF7\xBCӳ\xC9Ϊ" .. arg_10_1.Addition .. "%")
	elseif arg_10_1.AttrType == EAttrType.PhysicDefend then
		var_10_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_10_1.RoleName) .. a2u("\xA1\xBF\xBB\xA8\xB7\xD1") .. arg_10_1.Cost .. a2u("\xD7\xEAʯ\xBD\xF8\xD0С\xBE\xCE\xEF\xC0\xED\xB7\xC0\xD3\xF9\xC6\xED\xB8\xA3\xA1\xBF\xA3\xAC\xCE\xEF\xC0\xED\xB7\xC0\xD3\xF9\xBCӳ\xC9Ϊ" .. arg_10_1.Addition .. "%")
	elseif arg_10_1.AttrType == EAttrType.MagicAttack then
		var_10_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_10_1.RoleName) .. a2u("\xA1\xBF\xBB\xA8\xB7\xD1") .. arg_10_1.Cost .. a2u("\xD7\xEAʯ\xBD\xF8\xD0С\xBE\xB7\xA8\xCA\xF5\xB9\xA5\xBB\xF7\xC6\xED\xB8\xA3\xA1\xBF\xA3\xAC\xB7\xA8\xCA\xF5\xB9\xA5\xBB\xF7\xBCӳ\xC9Ϊ" .. arg_10_1.Addition .. "%")
	elseif arg_10_1.AttrType == EAttrType.MagicDefend then
		var_10_0 = a2u("\xCD\xE6\xBCҡ\xBE") .. a2u(arg_10_1.RoleName) .. a2u("\xA1\xBF\xBB\xA8\xB7\xD1") .. arg_10_1.Cost .. a2u("\xD7\xEAʯ\xBD\xF8\xD0С\xBE\xB7\xA8\xCA\xF5\xB7\xC0\xD3\xF9\xC6\xED\xB8\xA3\xA1\xBF\xA3\xAC\xB7\xA8\xCA\xF5\xB7\xC0\xD3\xF9\xBCӳ\xC9Ϊ" .. arg_10_1.Addition .. "%")
	end

	return var_10_0
end

function zbLegionHelp.getPartyLogDesc(arg_11_0, arg_11_1)
	if arg_11_1 == nil then
		return "nil"
	end

	local var_11_0 = ""

	if ELegionLogType.JoinDinner == arg_11_1.Type then
		if arg_11_1.Value == 0 then
			var_11_0 = a2u("\xA1\xBE\xCD\xE6\xBC\xD2") .. a2u(arg_11_1.RoleName) .. a2u("\t\xA1\xBF\xD2\xD4\xC6\xD5ͨ\xC8˵\xC4\xC9\xED\xB7ݲμ\xD3\xC1\xCB\xD1\xE7\xBB\xE1")
		else
			var_11_0 = a2u("\xA1\xBE\xCD\xE6\xBC\xD2") .. a2u(arg_11_1.RoleName) .. a2u("\t\xA1\xBF\xD2Թ\xF3\xB1\xF6\xB5\xC4\xC9\xED\xB7ݲμ\xD3\xC1\xCB\xD1\xE7\xBB\xE1")
		end
	else
		var_11_0 = a2u("\xA1\xBE\xCD\xE6\xBC\xD2") .. a2u(arg_11_1.RoleName) .. a2u("\t\xA1\xBF\xBF\xAA\xC6\xF4\xC1\xCB\xD1\xE7\xBB\xE1")
	end

	return var_11_0
end

local var_0_5 = 60
local var_0_6 = 1

function zbLegionHelp.getLimitedLevel(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		return a2u("1\xBC\xB6\xD2\xD4\xC9\xCF"), var_0_6
	end

	if arg_12_1 > var_0_5 then
		return a2u("60\xBC\xB6\xD2\xD4\xC9\xCF"), var_0_5
	end

	if arg_12_1 < var_0_6 then
		return a2u("1\xBC\xB6\xD2\xD4\xC9\xCF"), var_0_6
	end

	return a2u(arg_12_1 .. a2u("\xBC\xB6\xD2\xD4\xC9\xCF")), arg_12_1
end

local var_0_7 = {
	a2u("\xC8κ\xCE\xC8˿ɼ\xD3\xC8\xEB"),
	a2u("\xD0\xE8Ҫ\xC9\xEA\xC7\xEB")
}

function zbLegionHelp.getLimitedType(arg_13_0, arg_13_1)
	if arg_13_1 < 1 then
		arg_13_1 = 1
	end

	if arg_13_1 > 2 then
		arg_13_1 = 2
	end

	return var_0_7[arg_13_1], arg_13_1
end
