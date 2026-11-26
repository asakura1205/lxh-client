local var_0_0 = class("zbDataChange")

var_0_0.__index = var_0_0

function createDataChange()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.awardList = {}
end

function var_0_0.free(arg_3_0)
	return
end

function var_0_0.update(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.RetData.Wealth
	local var_4_1 = arg_4_1.RetData.DataChange

	if arg_4_2 == nil then
		arg_4_2 = true
	end

	arg_4_0:showAwardWnd(var_4_0, var_4_1, arg_4_2)

	if zbUtil:isValidTable(var_4_0) then
		g_Self.kWealthHandler:updateWealth(var_4_0)
	end

	if zbUtil:isValidTable(var_4_1) then
		arg_4_0:onBagItemChanged(var_4_1.BagItem)
		arg_4_0:onHeroFragChanged(var_4_1.HeroFrag)
		arg_4_0:onEquipFragChanged(var_4_1.EquipFrag)
		arg_4_0:onBagEquipChanged(var_4_1.BagEquip)
		arg_4_0:onHeroChanged(var_4_1.Hero)
		g_Self.kRedPointHandler:refreshHero()
	end
end

function var_0_0.onHeroChanged(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1.New) then
		g_Self.kHeroHandler:heroNew(arg_5_1.New)
	end

	if zbUtil:isValidTable(arg_5_1.Update) then
		g_Self.kHeroHandler:heroUpdate(arg_5_1.Update)
	end

	if zbUtil:isValidTable(arg_5_1.Del) then
		g_Self.kHeroHandler:heroDel(arg_5_1.Del)
	end
end

function var_0_0.onBagItemChanged(arg_6_0, arg_6_1)
	if zbUtil:isValidTable(arg_6_1.New) then
		g_Self.kBagItemHandler:itemNew(arg_6_1.New)
	end

	if zbUtil:isValidTable(arg_6_1.Update) then
		g_Self.kBagItemHandler:itemUpdate(arg_6_1.Update)
	end

	if zbUtil:isValidTable(arg_6_1.Del) then
		g_Self.kBagItemHandler:itemDel(arg_6_1.Del)
	end
end

function var_0_0.onBagEquipChanged(arg_7_0, arg_7_1)
	if zbUtil:isValidTable(arg_7_1.New) then
		g_Self.kBagEquipHandler:equipNew(arg_7_1.New)
	end

	if zbUtil:isValidTable(arg_7_1.Update) then
		g_Self.kBagEquipHandler:equipUpdate(arg_7_1.Update)
	end

	if zbUtil:isValidTable(arg_7_1.Del) then
		g_Self.kBagEquipHandler:equipDel(arg_7_1.Del)
	end
end

function var_0_0.onHeroFragChanged(arg_8_0, arg_8_1)
	if zbUtil:isValidTable(arg_8_1.New) then
		g_Self.kHeroFragHandler:fragNew(arg_8_1.New)
	end

	if zbUtil:isValidTable(arg_8_1.Update) then
		g_Self.kHeroFragHandler:fragUpdate(arg_8_1.Update)
	end

	if zbUtil:isValidTable(arg_8_1.Del) then
		g_Self.kHeroFragHandler:fragDel(arg_8_1.Del)
	end
end

function var_0_0.onEquipFragChanged(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(arg_9_1.New) then
		g_Self.kEquipFragHandler:fragNew(arg_9_1.New)
	end

	if zbUtil:isValidTable(arg_9_1.Update) then
		g_Self.kEquipFragHandler:fragUpdate(arg_9_1.Update)
	end

	if zbUtil:isValidTable(arg_9_1.Del) then
		g_Self.kEquipFragHandler:fragDel(arg_9_1.Del)
	end
end

function var_0_0.showAwardWnd(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Hero_WearEquip_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Hero_SwapEquip_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_GameLevel_FightResult_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Bar_Draw_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Arena_FightResult_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_GameLevel_SaoDang_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Trial_FightResult_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Pata_StartSaoDang_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Pata_FightResult_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Treasure_Start_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Treasure_FastStart_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Trial_SaoDang_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_WorldBoss_FightResult_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_Bag_OpenBox_Ack or g_WsMsgHandler.lastRecvMsgId == MSG_ID.WS_LegionWar_DailyFightResult_Ack then
		return
	end

	local var_10_0 = {}

	local function var_10_1(arg_11_0, arg_11_1)
		local var_11_0 = {
			awardType = arg_11_0
		}

		var_11_0.awardId = -1
		var_11_0.awardCount = arg_11_1
		var_11_0.quality = 1

		table.insert(var_10_0, var_11_0)
	end

	local function var_10_2(arg_12_0, arg_12_1)
		local var_12_0 = {
			awardType = ECommonAwardType.Item,
			awardId = arg_12_0,
			awardCount = arg_12_1
		}

		var_12_0.quality = 1

		table.insert(var_10_0, var_12_0)
	end

	local function var_10_3(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = {
			awardType = ECommonAwardType.Item,
			awardId = arg_13_0,
			awardCount = arg_13_1,
			quality = arg_13_2
		}

		table.insert(var_10_0, var_13_0)
	end

	local function var_10_4(arg_14_0, arg_14_1)
		local var_14_0 = {
			awardType = ECommonAwardType.EquipFrag,
			awardId = arg_14_0,
			awardCount = arg_14_1
		}

		var_14_0.quality = 1

		table.insert(var_10_0, var_14_0)
	end

	local function var_10_5(arg_15_0, arg_15_1)
		local var_15_0 = {
			awardType = ECommonAwardType.HeroFrag,
			awardId = arg_15_0,
			awardCount = arg_15_1
		}

		var_15_0.quality = 1

		table.insert(var_10_0, var_15_0)
	end

	if zbUtil:isValidTable(arg_10_1) then
		local var_10_6 = arg_10_1.Gold - g_GameData.Wealth.Gold
		local var_10_7 = arg_10_1.Diamond - g_GameData.Wealth.Diamond
		local var_10_8 = arg_10_1.Food - g_GameData.Wealth.Food
		local var_10_9 = arg_10_1.Tili - g_GameData.Wealth.Tili
		local var_10_10 = arg_10_1.BarCard - g_GameData.Wealth.BarCard
		local var_10_11 = arg_10_1.BarMoney - g_GameData.Wealth.BarMoney
		local var_10_12 = arg_10_1.Soul - g_GameData.Wealth.Soul
		local var_10_13 = arg_10_1.EquipSoul - g_GameData.Wealth.EquipSoul
		local var_10_14 = arg_10_1.Arena - g_GameData.Wealth.Arena
		local var_10_15 = arg_10_1.Bgz - g_GameData.Wealth.Bgz
		local var_10_16 = arg_10_1.Legion - g_GameData.Wealth.Legion
		local var_10_17 = arg_10_1.Horn - g_GameData.Wealth.Horn
		local var_10_18 = arg_10_1.DollsMoney - g_GameData.Wealth.DollsMoney

		if var_10_6 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Gold, var_10_6)
		end

		if var_10_7 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Diamond, var_10_7)
		end

		if var_10_8 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Food, var_10_8)
		end

		if var_10_9 > 1 then
			needShow = true

			var_10_1(ECommonAwardType.Tili, var_10_9)
		end

		if var_10_10 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.BarCard, var_10_10)
		end

		if var_10_11 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.BarMoney, var_10_11)
		end

		if var_10_12 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Soul, var_10_12)
		end

		if var_10_13 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.EquipSoul, var_10_13)
		end

		if var_10_14 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Arena, var_10_14)
		end

		if var_10_15 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Bgz, var_10_15)
		end

		if var_10_16 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Legion, var_10_16)
		end

		if var_10_17 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.Horn, var_10_17)
		end

		if var_10_18 > 0 then
			needShow = true

			var_10_1(ECommonAwardType.DollsMoney, var_10_18)
		end
	end

	if zbUtil:isValidTable(arg_10_2) then
		if zbUtil:isValidTable(arg_10_2.BagItem) and zbUtil:isValidTable(arg_10_2.BagItem.Update) then
			local var_10_19 = false

			for iter_10_0, iter_10_1 in pairs(arg_10_2.BagItem.Update) do
				local var_10_20 = false

				for iter_10_2, iter_10_3 in pairs(g_GameData.BagItemList) do
					if iter_10_1.TemplateId == iter_10_3.TemplateId then
						var_10_20 = true

						local var_10_21 = iter_10_1.Count - iter_10_3.Count

						if var_10_21 > 0 then
							needShow = true

							var_10_2(iter_10_1.TemplateId, var_10_21)
						end

						break
					end
				end

				if var_10_20 == false then
					needShow = true

					var_10_2(iter_10_1.TemplateId, iter_10_1.Count)
				end
			end
		end

		if zbUtil:isValidTable(arg_10_2.BagEquip) and zbUtil:isValidTable(arg_10_2.BagEquip.Update) then
			-- block empty
		end

		if zbUtil:isValidTable(arg_10_2.HeroFrag) and zbUtil:isValidTable(arg_10_2.HeroFrag.Update) then
			local var_10_22 = false

			for iter_10_4, iter_10_5 in pairs(arg_10_2.HeroFrag.Update) do
				local var_10_23 = false

				for iter_10_6, iter_10_7 in pairs(g_GameData.HeroFragList) do
					if iter_10_5.TemplateId == iter_10_7.TemplateId then
						var_10_23 = true

						local var_10_24 = iter_10_5.Count - iter_10_7.Count

						if var_10_24 > 0 then
							needShow = true

							var_10_5(iter_10_5.TemplateId, var_10_24)
						end

						break
					end
				end

				if var_10_23 == false then
					needShow = true

					var_10_5(iter_10_5.TemplateId, iter_10_5.Count)
				end
			end
		end

		if zbUtil:isValidTable(arg_10_2.EquipFrag) and zbUtil:isValidTable(arg_10_2.EquipFrag.Update) then
			local var_10_25 = false

			for iter_10_8, iter_10_9 in pairs(arg_10_2.EquipFrag.Update) do
				local var_10_26 = false

				for iter_10_10, iter_10_11 in pairs(g_GameData.EquipFragList) do
					if iter_10_9.TemplateId == iter_10_11.TemplateId then
						var_10_26 = true

						local var_10_27 = iter_10_9.Count - iter_10_11.Count

						if var_10_27 > 0 then
							needShow = true

							var_10_4(iter_10_9.TemplateId, var_10_27)
						end

						break
					end
				end

				if var_10_26 == false then
					needShow = true

					var_10_4(iter_10_9.TemplateId, iter_10_9.Count)
				end
			end
		end

		if zbUtil:isValidTable(arg_10_2.BagItem) and zbUtil:isValidTable(arg_10_2.BagItem.New) then
			for iter_10_12, iter_10_13 in pairs(arg_10_2.BagItem.New) do
				needShow = true

				var_10_2(iter_10_13.TemplateId, iter_10_13.Count)
			end
		end

		if zbUtil:isValidTable(arg_10_2.BagEquip) and zbUtil:isValidTable(arg_10_2.BagEquip.New) then
			for iter_10_14, iter_10_15 in pairs(arg_10_2.BagEquip.New) do
				needShow = true

				var_10_3(iter_10_15.TemplateId, iter_10_15.Count, iter_10_15.Quality)
			end
		end

		if zbUtil:isValidTable(arg_10_2.HeroFrag) and zbUtil:isValidTable(arg_10_2.HeroFrag.New) then
			for iter_10_16, iter_10_17 in pairs(arg_10_2.HeroFrag.New) do
				needShow = true

				var_10_5(iter_10_17.TemplateId, iter_10_17.Count)
			end
		end

		if zbUtil:isValidTable(arg_10_2.EquipFrag) and zbUtil:isValidTable(arg_10_2.EquipFrag.New) then
			for iter_10_18, iter_10_19 in pairs(arg_10_2.EquipFrag.New) do
				needShow = true

				var_10_4(iter_10_19.TemplateId, iter_10_19.Count)
			end
		end
	end

	if arg_10_3 == false then
		return
	end

	if table.getn(var_10_0) > 0 then
		arg_10_0.awardList = var_10_0

		if table.getn(var_10_0) > 5 then
			g_MainScene:showAwardMuchWnd(var_10_0)
		else
			g_MainScene:showAwardWnd(var_10_0)
		end
	end
end
