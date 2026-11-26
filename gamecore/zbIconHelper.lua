zbIconHelper = {}

function zbIconHelper.getMoneyPanelIconPath(arg_1_0, arg_1_1)
	local var_1_0 = ""
	local var_1_1 = ""
	local var_1_2 = ""

	if arg_1_1 == EMoneyPanelResType.Gold then
		var_1_0 = "image/common/money_gold.png"
		var_1_1 = a2u("\xBD\xF0\xDF\xF7\xB1\xD2")
		var_1_2 = a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xCA\xC7\xCD\xF2\xC4ܵģ\xACû\xD3н\xF0\xDF\xF7\xB1\xD2\xCA\xC7\xCD\xF2\xCD\xF2\xB2\xBB\xC4ܵġ\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Diamond then
		var_1_0 = "image/common/money_diamond.png"
		var_1_1 = a2u("\xD7\xEAʯ")
		var_1_2 = a2u("\xD7\xEAʯ\xBA\xE3\xBE\xC3Զ\xA3\xAC\xBFſ\xC5\xD3\xC0\xC1\xF7\xB4\xAB\xA3\xACӲͨ\xBB\xF5\xA3\xACӵ\xD3м\xB4\xBFɳ\xC9Ϊ\xB8߸\xBB˧\xA1\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Food then
		var_1_0 = "image/common/money_food.png"
		var_1_1 = a2u("è\xB7\xB9")
		var_1_2 = a2u("\xD6\xF7Ҫ\xC0\xB4\xD7\xD4ũ\xCC\xEF\xCAջ񣬿\xC9\xD3\xC3\xD3ھ\xFD\xB8\xF3\xC9\xFD\xBC\xB6\xBA\xCD\xCA\xC0\xBD\xE7̽\xCB\xF7\xA1\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Tili then
		var_1_0 = "image/common/money_tili.png"
		var_1_1 = a2u("\xD3\xE3\xB8\xC9")
		var_1_2 = a2u("\xB3\xF6ս\xB1ر\xB8\xB5\xC4\xCF\xFB\xBAĲ\xC4\xC1ϡ\xA3")
	elseif arg_1_1 == EMoneyPanelResType.BarCard then
		var_1_0 = "image/common/money_barcard.png"
		var_1_1 = a2u("\xBB\xBD\xC1\xE9ʯ")
		var_1_2 = a2u("\xD3\xC3\xD3\xDAС\xBA\xDA\xCE\xDD\xD6н\xF8\xD0\xD0\xD5ٻ\xBD\xB5ĵ\xC0\xBEߡ\xA3")
	elseif arg_1_1 == EMoneyPanelResType.BarMoney then
		var_1_0 = "image/common/money_barmoney.png"
		var_1_1 = a2u("\xB4\xCEԪ\xCB\xE9Ƭ")
		var_1_2 = a2u("\xD3\xC3\xD3\xDAС\xBA\xDA\xCE\xDD\xD6\xD0\xD5ٻ\xBD\xA1\xBEϡ\xD3л\xEF\xB0顿\xA1\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Soul then
		var_1_0 = "image/common/money_soul.png"
		var_1_1 = a2u("\xD3\xF1\xBB\xEA")
		var_1_2 = a2u("\xBB\xEF\xB0\xE9\xCB\xE9Ƭ\xC8\xDB\xC1\xB6\xBB\xF1\xB5õĲ\xC4\xC1ϣ\xAC\xBF\xC9\xD4\xDA\xC9\xF1\xC3\xD8\xC9̵\xEA\xD6\xD0ʹ\xD3á\xA3")
	elseif arg_1_1 == EMoneyPanelResType.EquipSoul then
		var_1_0 = "image/common/money_equipmoney.png"
		var_1_1 = a2u("\xC6\xF7\xBB\xEA")
		var_1_2 = a2u("װ\xB1\xB8\xC8\xDB\xC1\xB6\xBB\xF1\xB5õĲ\xC4\xC1ϣ\xAC\xBF\xC9\xD4\xDA\xC9\xF1\xC3\xD8\xC9̵\xEA\xD6\xD0ʹ\xD3á\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Arena then
		var_1_0 = "image/common/money_arena.png"
		var_1_1 = a2u("\xC8\xD9\xD3\xFE\xB1\xD2")
		var_1_2 = a2u("ͨ\xB9\xFD\xB6\xB7˧\xB9\xAC\xCD淨\xBB\xF1\xB5ã\xAC\xBF\xC9\xD4\xDA\xC9\xF1\xC3\xD8\xC9̵\xEA\xD6\xD0ʹ\xD3á\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Bgz then
		var_1_0 = "image/common/money_bgz.png"
		var_1_1 = a2u("\xB0\xCB\xD8Ա\xD2")
		var_1_2 = a2u("ͨ\xB9\xFD\xCD\xC5\xCA\xF3\xB4\xF3\xD7\xF7ս\xCD淨\xBB\xF1\xB5ã\xAC\xBF\xC9\xD4\xDA\xC9\xF1\xC3\xD8\xC9̵\xEA\xD6\xD0ʹ\xD3á\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Legion then
		var_1_0 = "image/common/money_legion.png"
		var_1_1 = a2u("\xBB\xE1\xB9ݱ\xD2")
		var_1_2 = a2u("ͨ\xB9\xFD\xBB\xE1\xB9\xDD\xCD淨\xBB\xF1\xB5ã\xAC\xBF\xC9\xD4ھ\xBA\xBC\xBC\xC9̵\xEA\xD6\xD0ʹ\xD3á\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Horn then
		var_1_0 = "image/common/money_horn.png"
		var_1_1 = a2u("\xC0\xAE\xB0\xC8")
		var_1_2 = a2u("ͨ\xB9\xFD\xC9̵깺\xC2\xF2\xBB\xF1\xB5ã\xAC\xBF\xC9\xD2\xD4\xD4\xDA\xC1\xC4\xCC\xEC\xD6\xD0˵\xBB\xB0\xB8\xFC\xB4\xF3\xC9\xF9\xA1\xA3")
	elseif arg_1_1 == EMoneyPanelResType.SkillBook then
		var_1_0 = "image/common/money_skillbook.png"
		var_1_1 = a2u("\xBC\xBC\xC4\xDC\xCA\xE9")
		var_1_2 = a2u("\xBC\xC7¼ս\xB6\xB7\xD6м\xBC\xC4ܸ\xD0\xCE\xF2\xB5\xC4С\xB2\xE1\xD7ӣ\xAC\xD3\xC3\xD3ڻ\xEF\xB0鼼\xC4\xDC\xC9\xFD\xBC\xB6\xA1\xA3")
	elseif arg_1_1 == EMoneyPanelResType.DollsMoney then
		var_1_0 = "image/common/money_dolls.png"
		var_1_1 = a2u("\xCD\xDE\xCD޻\xFA\xB4\xFA\xB1\xD2")
		var_1_2 = a2u("\xCD\xDE\xCD޻\xFA\xB4\xFA\xB1ң\xAC\xBF\xC9\xD3\xC3\xD3\xDAץ\xCD\xDE\xCDޡ\xA3")
	elseif arg_1_1 == EMoneyPanelResType.Reset then
		var_1_0 = "image/common/money_reset.png"
		var_1_1 = a2u("\xBB\xD8¯ʯ")
		var_1_2 = a2u("\xD6\xD8\xD0\xC2\xD0\xDE\xD0У\xAC\xD3\xC3\xD3ڻ\xEF\xB0\xE9\xB5Ļ\xD8¯\xB9\xA6\xC4ܡ\xA3")
	elseif arg_1_1 == EMoneyPanelResType.GemOpen then
		var_1_0 = "image/common/money_gembook.png"
		var_1_1 = a2u("\xBD\xE2ӡ\xB7\xFB")
		var_1_2 = a2u("\xD3\xC3\xD3\xDAװ\xB1\xB8\xC1\xE9\xB2۵Ŀ\xAA\xC6\xF4\xA1\xA3")
	else
		var_1_0 = "image/common/invalid.png"
		var_1_1 = ""
		var_1_2 = ""
	end

	return var_1_0, var_1_1, var_1_2
end

function zbIconHelper.getAwardIconPath(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ""
	local var_2_1 = ""

	if arg_2_1 == ECommonAwardType.Gold then
		var_2_0 = "image/icon/item/item_gold.png"
		var_2_1 = a2u("\xBD\xF0\xDF\xF7\xB1\xD2")
	elseif arg_2_1 == ECommonAwardType.Diamond then
		var_2_0 = "image/icon/item/item_diamond.png"
		var_2_1 = a2u("\xD7\xEAʯ")
	elseif arg_2_1 == ECommonAwardType.Food then
		var_2_0 = "image/icon/item/item_food.png"
		var_2_1 = a2u("è\xB7\xB9")
	elseif arg_2_1 == ECommonAwardType.Tili then
		var_2_0 = "image/icon/item/item_tili.png"
		var_2_1 = a2u("\xD3\xE3\xB8\xC9")
	elseif arg_2_1 == ECommonAwardType.BarCard then
		var_2_0 = "image/icon/item/item_barcard.png"
		var_2_1 = a2u("\xBB\xBD\xC1\xE9ʯ")
	elseif arg_2_1 == ECommonAwardType.BarMoney then
		var_2_0 = "image/icon/item/item_barmoney.png"
		var_2_1 = a2u("\xB4\xCEԪ\xCB\xE9Ƭ")
	elseif arg_2_1 == ECommonAwardType.Soul then
		var_2_0 = "image/icon/item/item_soul.png"
		var_2_1 = a2u("\xD3\xF1\xBB\xEA")
	elseif arg_2_1 == ECommonAwardType.EquipSoul then
		var_2_0 = "image/icon/item/item_equip.png"
		var_2_1 = a2u("\xC6\xF7\xBB\xEA")
	elseif arg_2_1 == ECommonAwardType.DollsMoney then
		var_2_0 = "image/icon/item/item_dolls.png"
		var_2_1 = a2u("\xCD\xDE\xCD޻\xFA\xB4\xFA\xB1\xD2")
	elseif arg_2_1 == ECommonAwardType.Arena then
		var_2_0 = "image/icon/item/item_arena.png"
		var_2_1 = a2u("\xC8\xD9\xD3\xFE\xB1\xD2")
	elseif arg_2_1 == ECommonAwardType.Bgz then
		var_2_0 = "image/icon/item/item_bgz.png"
		var_2_1 = a2u("\xB0\xCB\xD8Ա\xD2")
	elseif arg_2_1 == ECommonAwardType.Legion then
		var_2_0 = "image/icon/item/item_legion.png"
		var_2_1 = a2u("\xBB\xE1\xB9ݱ\xD2")
	elseif arg_2_1 == ECommonAwardType.Horn then
		var_2_0 = "image/icon/item/item_horn.png"
		var_2_1 = a2u("\xC0\xAE\xB0\xC8")
	elseif arg_2_1 == ECommonAwardType.RoleExp then
		var_2_0 = "image/icon/item/jingYan.png"
		var_2_1 = a2u("\xBE\xAD\xD1\xE9ֵ")
	elseif arg_2_1 == ECommonAwardType.VipExp then
		var_2_0 = "image/icon/item/VIP.png"
		var_2_1 = a2u("Vip\xBE\xAD\xD1\xE9ֵ")
	elseif arg_2_1 == ECommonAwardType.Item or arg_2_1 == ECommonAwardType.EquipFrag then
		var_2_0 = arg_2_0:getItemIconPath(arg_2_2)

		local var_2_2 = zbItemTable:getRecord(arg_2_2)

		if var_2_2 ~= nil and var_2_2.name ~= nil then
			var_2_1 = var_2_2.name
		end
	elseif arg_2_1 == ECommonAwardType.Hero or arg_2_1 == ECommonAwardType.HeroFrag then
		var_2_0 = arg_2_0:getHeroIconPath(arg_2_2)

		local var_2_3 = zbHeroTable:getRecord(arg_2_2)

		if var_2_3 ~= nil and var_2_3.name ~= nil then
			var_2_1 = var_2_3.name
		end
	else
		var_2_0 = "image/icon/invalid/invald.png"
		var_2_1 = ""
	end

	return var_2_0, var_2_1
end

function zbIconHelper.getPlayerHeadIconPath(arg_3_0, arg_3_1)
	local var_3_0 = ""
	local var_3_1 = zbHeroTable:getRecord(arg_3_1)

	if var_3_1 ~= nil then
		local var_3_2 = zbAvatarTable:getRecord(var_3_1.avatarId)

		if var_3_2 ~= nil then
			var_3_0 = var_3_2.lordhead
		end
	else
		local var_3_3 = zbAvatarTable:getRecord(arg_3_1)

		if var_3_3 ~= nil then
			var_3_0 = var_3_3.lordhead
		end
	end

	if var_3_0 == "" then
		var_3_0 = "image/icon/headicon/1011.png"
	end

	return var_3_0
end

function zbIconHelper.getHeroIconPath(arg_4_0, arg_4_1)
	local var_4_0 = ""
	local var_4_1 = zbHeroTable:getRecord(arg_4_1)

	if var_4_1 ~= nil then
		local var_4_2 = zbAvatarTable:getRecord(var_4_1.avatarId)

		if var_4_2 ~= nil then
			var_4_0 = var_4_2.headIcon
		end
	else
		local var_4_3 = zbAvatarTable:getRecord(arg_4_1)

		if var_4_3 ~= nil then
			var_4_0 = var_4_3.headIcon
		end
	end

	if var_4_0 == "" then
		var_4_0 = "image/icon/invalid/invald.png"
	end

	return var_4_0
end

function zbIconHelper.getHeroCardIconPath(arg_5_0, arg_5_1)
	local var_5_0 = ""
	local var_5_1 = zbHeroTable:getRecord(arg_5_1)

	if var_5_1 ~= nil then
		local var_5_2 = zbAvatarTable:getRecord(var_5_1.avatarId)

		if var_5_2 ~= nil then
			var_5_0 = var_5_2.iconPath
		end
	else
		local var_5_3 = zbAvatarTable:getRecord(arg_5_1)

		if var_5_3 ~= nil then
			var_5_0 = var_5_3.iconPath
		end
	end

	if var_5_0 == "" then
		var_5_0 = "image/icon/invalid/invald.png"
	end

	return var_5_0
end

function zbIconHelper.getHeroTalkIconPath(arg_6_0, arg_6_1)
	local var_6_0 = ""
	local var_6_1 = zbHeroTable:getRecord(arg_6_1)

	if var_6_1 ~= nil then
		local var_6_2 = zbAvatarTable:getRecord(var_6_1.avatarId)

		if var_6_2 ~= nil then
			var_6_0 = var_6_2.talkPath
		end
	else
		local var_6_3 = zbAvatarTable:getRecord(arg_6_1)

		if var_6_3 ~= nil then
			var_6_0 = var_6_3.talkPath
		end
	end

	if var_6_0 == "" then
		var_6_0 = "image/icon/invalid/invald.png"
	end

	return var_6_0
end

function zbIconHelper.getItemIconPath(arg_7_0, arg_7_1)
	local var_7_0 = ""
	local var_7_1 = zbItemTable:getRecord(arg_7_1)

	if var_7_1 ~= nil then
		var_7_0 = var_7_1.icon
	end

	if var_7_0 == "" then
		var_7_0 = "image/icon/invalid/invald.png"
	end

	return var_7_0
end

function zbIconHelper.getSkillIconPath(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = zbHeroSkillTable:getRecord(arg_8_1)

	if var_8_1 ~= nil then
		var_8_0 = var_8_1.icon
	end

	if var_8_0 == "" then
		var_8_0 = "image/icon/invalid/invald.png"
	end

	return var_8_0
end

function zbIconHelper.getHeroTypeIconPath(arg_9_0, arg_9_1)
	local var_9_0 = ""
	local var_9_1 = ""

	return arg_9_1 == EHeroType.Force and "image/icon/herotag/type_li.png" or arg_9_1 == EHeroType.Intelligence and "image/icon/herotag/type_zhi.png" or arg_9_1 == EHeroType.Tili and "image/icon/herotag/type_ti.png" or "image/icon/invalid/invald.png"
end

function zbIconHelper.getExchangeValue(arg_10_0, arg_10_1)
	local var_10_0 = ""
	local var_10_1 = ""
	local var_10_2 = ""

	if arg_10_1 == EExchangeType.Gold then
		var_10_0 = "image/common/money_gold.png"
		var_10_1 = "image/title/title_excgold.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xB6һ\xBB\xB4\xF3\xC1\xBF\xBD\xF0\xDF\xF7\xB1\xD2")
	elseif arg_10_1 == EExchangeType.Food then
		var_10_0 = "image/common/money_food.png"
		var_10_1 = "image/title/title_exfood.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xBB\xBBȡ\xB4\xF3\xC1\xBFè\xB7\xB9")
	elseif arg_10_1 == EExchangeType.Tili then
		var_10_0 = "image/common/money_tili.png"
		var_10_1 = "image/title/title_extili.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xBB\xBBȡ\xB4\xF3\xC1\xBF\xD3\xE3\xB8\xC9")
	elseif arg_10_1 == EExchangeType.SkillBook then
		var_10_0 = "image/common/money_skillbook.png"
		var_10_1 = "image/title/title_exskillbook.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xBB\xBBȡ\xB4\xF3\xC1\xBF\xBC\xBC\xC4\xDC\xCA\xE9")
	elseif arg_10_1 == EExchangeType.GemOpenHole then
		var_10_0 = "image/common/money_gembook.png"
		var_10_1 = "image/title/title_exgemopen.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xBB\xBBȡ\xB4\xF3\xC1\xBF\xBD\xE2ӡ\xB7\xFB")
	elseif arg_10_1 == EExchangeType.DollsMoney then
		var_10_0 = "image/common/money_dolls.png"
		var_10_1 = "image/title/title_exdolls.png"
		var_10_2 = a2u("\xC9\xD9\xC1\xBF\xD7\xEAʯ\xBB\xBBȡ\xB4\xF3\xC1\xBF\xCD\xDE\xCD޻\xFA\xB4\xFA\xB1\xD2")
	else
		var_10_0 = "image/icon/invalid/invald.png"
		var_10_1 = "invalid eExchangeType"
		var_10_2 = "invalid eExchangeType"
	end

	return var_10_0, var_10_1, var_10_2
end

function zbIconHelper.getTechIconPath(arg_11_0, arg_11_1)
	local var_11_0 = ""
	local var_11_1 = zbTechTable:getRecord(arg_11_1)

	if var_11_1 ~= nil then
		var_11_0 = var_11_1.iconPath
	end

	if var_11_0 == "" then
		var_11_0 = "image/icon/invalid/invald.png"
	end

	return var_11_0
end

function zbIconHelper.getGodSkillIconPath(arg_12_0, arg_12_1)
	local var_12_0 = ""
	local var_12_1 = zbGodSkillTable:getRecord(arg_12_1)

	if var_12_1 ~= nil then
		var_12_0 = var_12_1.iconPath
	end

	if var_12_0 == "" then
		var_12_0 = "image/icon/invalid/invald.png"
	end

	return var_12_0
end

function zbIconHelper.getSetSocialIconDesc(arg_13_0, arg_13_1)
	local var_13_0 = ""
	local var_13_1 = ""
	local var_13_2

	if arg_13_1 == ESocialType.WeiBo then
		var_13_0 = "\xBC\xD3\xC8\xEB\xCE\xD2\xC3ǵ\xC4\xD3\xCEϷ\xC9\xE7\xC7\xF8\xA3\xA1"
		var_13_2 = "image/set/set_weibo.png"
	elseif arg_13_1 == ESocialType.BaiDu then
		var_13_0 = "\xCB\xE6ʱ\xB9\xD8ע\xD3\xCEϷ\xB6\xAF̬\xA3\xA1"
		var_13_2 = "image/set/set_baidu.png"
	elseif arg_13_1 == ESocialType.WeiXin then
		var_13_0 = "\xB9\xD8ע\xCE\xD2\xC3ǵĹ\xAB\xD6ںţ\xA1"
		var_13_2 = "image/set/set_weixin.png"
	elseif arg_13_1 == ESocialType.Magic then
		var_13_0 = "\xB9\xD8ע\xB0\xD7ħ\xB7\xA8ʦ\xC2\xDB̳\xA3\xA1"
		var_13_2 = "image/set/set_magic.png"
	else
		var_13_0 = "invalid socaialType"
		var_13_2 = "image/icon/invalid/invald.png"
	end

	return var_13_2, a2u(var_13_0)
end

function zbIconHelper.getStarAwardTitleIcon(arg_14_0, arg_14_1)
	local var_14_0 = ""

	return arg_14_1 == 5 and "image/title/title_star5.png" or arg_14_1 == 10 and "image/title/title_star10.png" or arg_14_1 == 15 and "image/title/title_star15.png" or "image/icon/invalid/invald.png"
end

function zbIconHelper.getDailyIconPath(arg_15_0, arg_15_1)
	local var_15_0 = ""
	local var_15_1 = zbDailyTaskTable:getRecord(arg_15_1)

	if var_15_1 ~= nil then
		var_15_0 = var_15_1.icon
	end

	if var_15_0 == "" then
		var_15_0 = "image/icon/invalid/invald.png"
	end

	return var_15_0
end

function zbIconHelper.getLegionIconPath(arg_16_0, arg_16_1)
	local var_16_0 = ""

	return "image/icon/legion/" .. arg_16_1 .. ".png"
end

function zbIconHelper.getLockIconPath(arg_17_0, arg_17_1)
	local var_17_0 = ""
	local var_17_1 = zbFunctionUnlockTable:getRecord(arg_17_1)

	if var_17_1 ~= nil then
		var_17_0 = var_17_1.icon
	end

	if var_17_0 == "" then
		var_17_0 = "image/icon/invalid/invald.png"
	end

	return var_17_0
end

function zbIconHelper.getHeroSoundPath(arg_18_0, arg_18_1)
	local var_18_0 = ""
	local var_18_1 = zbUtil:random(1, 2)

	return "audio/sound/voice/" .. arg_18_1 .. "_" .. var_18_1 .. ".mp3"
end
