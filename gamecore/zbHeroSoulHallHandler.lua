zbHeroSoulHallHandler = class("zbHeroSoulHallHandler")
zbHeroSoulHallHandler.__index = zbHeroSoulHallHandler

function createHeroSoulHallHandler()
	local var_1_0 = zbHeroSoulHallHandler.new()

	var_1_0:init()

	return var_1_0
end

function zbHeroSoulHallHandler.init(arg_2_0)
	arg_2_0.heroSoulHallRank = nil
	arg_2_0.bReqPlayer = false
end

function zbHeroSoulHallHandler.hasHeroSoulHall(arg_3_0)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in pairs(zbHeroSoulHallTable.records) do
		if iter_3_1.openLevel > g_Self:getLevel() then
			var_3_0 = false
		else
			for iter_3_2 = 1, 5 do
				for iter_3_3 = 1, 5 do
					var_3_0 = arg_3_0:hasHeroSoul(iter_3_1.id, iter_3_2, iter_3_3)

					if var_3_0 then
						break
					end
				end

				if var_3_0 then
					break
				end
			end
		end

		if var_3_0 then
			break
		end
	end

	return var_3_0
end

function zbHeroSoulHallHandler.hasHeroSoul(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = zbHeroSoulTable:getRecord(arg_4_3)

	if var_4_0[1] ~= nil and var_4_0[1].openLevel > g_Self:getLevel() then
		return false
	end

	local var_4_1 = zbHeroSoulHallTable:getHeroID(arg_4_1, arg_4_2)

	if g_Self.kHeroHandler:hasHeroByTemplateId(var_4_1) == false then
		return false
	end

	local var_4_2 = g_GameData.HeroSoulHallInfo

	if var_4_2 == nil or type(var_4_2) ~= "table" then
		return true
	end

	if var_4_2.HeroSoulHallList == nil or type(var_4_2.HeroSoulHallList) ~= "table" then
		return true
	end

	local var_4_3

	for iter_4_0, iter_4_1 in pairs(g_GameData.HeroSoulHallInfo.HeroSoulHallList) do
		if arg_4_1 == iter_4_1.HallId then
			var_4_3 = iter_4_1

			break
		end
	end

	if var_4_3 == nil then
		return true
	end

	local var_4_4

	for iter_4_2, iter_4_3 in pairs(var_4_3.HeroSoulList) do
		if arg_4_2 == iter_4_3.Position then
			var_4_4 = iter_4_3

			break
		end
	end

	if var_4_4 == nil then
		return true
	end

	local var_4_5 = 0

	for iter_4_4, iter_4_5 in pairs(var_4_4.SoulList) do
		if iter_4_5.Status == 1 then
			var_4_5 = iter_4_5.HeroAddAttr.AttrValue

			break
		end
	end

	for iter_4_6, iter_4_7 in pairs(var_4_4.SoulList) do
		if var_4_5 < iter_4_7.HeroAddAttr.AttrValue then
			local var_4_6 = zbHeroSoulTable:getRecordUseId(iter_4_7.HeroSoulId)

			if var_4_6 and var_4_6.quality == arg_4_3 then
				return true
			end
		end
	end

	for iter_4_8, iter_4_9 in pairs(var_4_0) do
		if iter_4_9.grade == 1 and var_4_5 < zbHeroSoulTable:getAddition(iter_4_9, arg_4_2) then
			return true
		end
	end

	return false
end
