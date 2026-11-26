BUFF_REPLACE = 1
BUFF_ADD = 2
BUFF_TYPE_CONTROL_HUNMI = 1001
BUFF_TYPE_CONTROL_MEIHUO = 1002
BUFF_TYPE_CONTROL_CHENMO = 1003
BUFF_TYPE_CONTROL_CHAOFENG = 1004
BUFF_TYPE_CONTROL_ZHONGSHANG = 1005
BUFF_TYPE_PROPERTY_PHYSICATTACK = 2001
BUFF_TYPE_PROPERTY_PHYSICDEFEND = 2002
BUFF_TYPE_PROPERTY_MAGICATTACK = 2003
BUFF_TYPE_PROPERTY_MAGICDEFEND = 2004
BUFF_TYPE_PROPERTY_PHYSICATTACK_MAGICATTACK = 2006
BUFF_TYPE_PROPERTY_PHYSICDEFEND_MAGICDEFEND = 2007
BUFF_TYPE_PROPERTY_HIT = 2011
BUFF_TYPE_PROPERTY_DODGE = 2012
BUFF_TYPE_PROPERTY_VIOLENT = 2013
BUFF_TYPE_PROPERTY_TOUGH = 2014
BUFF_TYPE_PROPERTY_PIERCE = 2015
BUFF_TYPE_PROPERTY_BLOCK = 2016
BUFF_TYPE_PROPERTY_HP = 2017
BUFF_TYPE_PROPERTY_MAXHP = 2018
BUFF_TYPE_PROPERTY_MP = 2019
BUFF_TYPE_PROPERTY_HP_FIRE = 2020
BUFF_TYPE_PROPERTY_HP_LIUXUE = 2021
BUFF_TYPE_PROPERTY_HP_ZHONGDU = 2022
BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC = 2041
BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC = 2042
BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC = 2043
BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC = 2044
BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_MAGIC = 2045
BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC = 2046
BUFF_TYPE_IMMUNE_PHYSICDAMAGE = 3001
BUFF_TYPE_IMMUNE_MAGICDAMAGE = 3002
BUFF_TYPE_IMMUNE_ALLDAMAGE = 3003
BUFF_TYPE_SHIELD_PHYSICMAGIC = 4001
BUFF_TYPE_SHIELD_PHYSIC = 4002
BUFF_TYPE_SHIELD_MAGIC = 4003
BUFF_TYPE_SHIELD_ROUNDREDUCE = 4004
BUFF_TYPE_MISC_JIUQI = 5001
BUFF_TYPE_MISC_SUOLIAN = 5002
BUFF_TYPE_MISC_ZHONGZI = 5003
BUFF_TYPE_MISC_YANDIYUN = 5004
BUFF_TYPE_MISC_QINYIN = 5005
zbBuffSystem = class("zbBuffSystem")
zbBuffSystem.__index = zbBuffSystem

function zbBuffSystem.create(arg_1_0)
	local var_1_0 = zbBuffSystem.new()

	var_1_0:init()

	return var_1_0
end

function zbBuffSystem.init(arg_2_0)
	arg_2_0.buffList = {}
	arg_2_0.funCreator = {}
	arg_2_0.funCreator[BUFF_TYPE_CONTROL_HUNMI] = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
		require("gamecore.buff.zbControlHunmi")

		return zbControlHunmi:create(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_CONTROL_MEIHUO] = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
		require("gamecore.buff.zbControlMeihuo")

		return zbControlMeihuo:create(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_CONTROL_CHENMO] = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
		require("gamecore.buff.zbControlChenmo")

		return zbControlChenmo:create(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_CONTROL_CHAOFENG] = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
		require("gamecore.buff.zbControlChaofeng")

		return zbControlChaofeng:create(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_CONTROL_ZHONGSHANG] = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
		require("gamecore.buff.zbControlZhongshang")

		return zbControlZhongshang:create(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_PHYSICATTACK] = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
		require("gamecore.buff.zbAddPhysicAttack")

		return zbAddPhysicAttack:create(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_PHYSICDEFEND] = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
		require("gamecore.buff.zbAddPhysicDefend")

		return zbAddPhysicDefend:create(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_MAGICATTACK] = function(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
		require("gamecore.buff.zbAddMagicAttack")

		return zbAddMagicAttack:create(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_MAGICDEFEND] = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
		require("gamecore.buff.zbAddMagicDefend")

		return zbAddMagicDefend:create(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_PHYSICATTACK_MAGICATTACK] = function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
		require("gamecore.buff.zbAddPhysicAttackMagicAttack")

		return zbAddPhysicAttackMagicAttack:create(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_PHYSICDEFEND_MAGICDEFEND] = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
		require("gamecore.buff.zbAddPhysicDefendMagicDefend")

		return zbAddPhysicDefendMagicDefend:create(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_HIT] = function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
		require("gamecore.buff.zbAddHit")

		return zbAddHit:create(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DODGE] = function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
		require("gamecore.buff.zbAddDodge")

		return zbAddDodge:create(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_VIOLENT] = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
		require("gamecore.buff.zbAddViolent")

		return zbAddViolent:create(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_TOUGH] = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
		require("gamecore.buff.zbAddTough")

		return zbAddTough:create(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_PIERCE] = function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
		require("gamecore.buff.zbAddPierceDamage")

		return zbAddPierceDamage:create(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_BLOCK] = function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
		require("gamecore.buff.zbAddBlock")

		return zbAddBlock:create(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_HP] = function(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
		require("gamecore.buff.zbAddHp")

		return zbAddHp:create(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_MAXHP] = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
		require("gamecore.buff.zbAddMaxHp")

		return zbAddMaxHp:create(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_MP] = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
		require("gamecore.buff.zbAddMp")

		return zbAddMp:create(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_HP_FIRE] = function(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
		require("gamecore.buff.zbAddHpFire")

		return zbAddHpFire:create(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_HP_ZHONGDU] = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6)
		require("gamecore.buff.zbAddHpZhongdu")

		return zbAddHpZhongdu:create(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_HP_LIUXUE] = function(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
		require("gamecore.buff.zbAddHpLiuxue")

		return zbAddHpLiuxue:create(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_IMMUNE_PHYSICDAMAGE] = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
		require("gamecore.buff.zbImmunePhysic")

		return zbImmunePhysic:create(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_IMMUNE_MAGICDAMAGE] = function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
		require("gamecore.buff.zbImmuneMagic")

		return zbImmuneMagic:create(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_IMMUNE_ALLDAMAGE] = function(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6)
		require("gamecore.buff.zbImmuneAll")

		return zbImmuneAll:create(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_SHIELD_PHYSICMAGIC] = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6)
		require("gamecore.buff.zbShieldPM")

		return zbShieldPM:create(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_SHIELD_PHYSIC] = function(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
		require("gamecore.buff.zbShieldPhysic")

		return zbShieldPhysic:create(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_SHIELD_MAGIC] = function(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
		require("gamecore.buff.zbShieldMagic")

		return zbShieldMagic:create(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_SHIELD_ROUNDREDUCE] = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
		require("gamecore.buff.zbShieldReduce")

		return zbShieldReduce:create(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC] = function(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
		require("gamecore.buff.zbAddDamagePhysic")

		return zbAddDamagePhysic:create(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC] = function(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
		require("gamecore.buff.zbAddDamageMagic")

		return zbAddDamageMagic:create(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC] = function(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6)
		require("gamecore.buff.zbAddDamagePhysicMagic")

		return zbAddDamagePhysicMagic:create(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC] = function(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6)
		require("gamecore.buff.zbAddDamageDefendPhysic")

		return zbAddDamageDefendPhysic:create(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_MAGIC] = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6)
		require("gamecore.buff.zbAddDamageDefendMagic")

		return zbAddDamageDefendMagic:create(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC] = function(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
		require("gamecore.buff.zbAddDamageDefendPhysicMagic")

		return zbAddDamageDefendPhysicMagic:create(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_MISC_JIUQI] = function(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6)
		require("gamecore.buff.zbMiscJiuqi")

		return zbMiscJiuqi:create(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_MISC_SUOLIAN] = function(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6)
		require("gamecore.buff.zbMiscSuolian")

		return zbMiscSuolian:create(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_MISC_ZHONGZI] = function(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6)
		require("gamecore.buff.zbMiscZhongzi")

		return zbMiscZhongzi:create(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_MISC_YANDIYUN] = function(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
		require("gamecore.buff.zbMiscYandiYun")

		return zbMiscYandiYun:create(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	end
	arg_2_0.funCreator[BUFF_TYPE_MISC_QINYIN] = function(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6)
		require("gamecore.buff.zbMiscQinyin")

		return zbMiscQinyin:create(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6)
	end
end

function zbBuffSystem.update(arg_44_0, arg_44_1)
	for iter_44_0 = #arg_44_0.buffList, 1, -1 do
		local var_44_0 = arg_44_0.buffList[iter_44_0]

		var_44_0:update(arg_44_1)

		if var_44_0:isEnd() == true then
			echo(ForceTypeDesc[var_44_0.hero.forceType] .. var_44_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_44_0.buffRecord.name)
			var_44_0:free()
			table.remove(arg_44_0.buffList, iter_44_0)
		end
	end
end

function zbBuffSystem.newHeroRound(arg_45_0, arg_45_1)
	for iter_45_0 = #arg_45_0.buffList, 1, -1 do
		local var_45_0 = arg_45_0.buffList[iter_45_0]

		if arg_45_1:isSame(var_45_0.hero) then
			var_45_0:newRound()

			if var_45_0:isEnd() == true then
				echo(ForceTypeDesc[var_45_0.hero.forceType] .. var_45_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_45_0.buffRecord.name)
				var_45_0:free()
				table.remove(arg_45_0.buffList, iter_45_0)
			end
		end
	end
end

function zbBuffSystem.createLiuxueBuff(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = BUFF_TYPE_PROPERTY_HP_LIUXUE
	local var_46_1 = -math.abs(arg_46_3)
	local var_46_2 = 0
	local var_46_3 = 3

	g_BuffSystem:createBuff(arg_46_1, arg_46_2, var_46_0, var_46_1, var_46_2, var_46_3)
end

function zbBuffSystem.createControlBuff(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = zbBuffTable:getRecord(arg_47_3)

	if var_47_0 == nil then
		echo("warning: invalid buffId: " .. arg_47_3)

		return
	end

	local var_47_1 = var_47_0.param1
	local var_47_2 = var_47_0.param2
	local var_47_3 = var_47_0.round

	g_BuffSystem:createBuff(arg_47_1, arg_47_2, arg_47_3, var_47_1, var_47_2, var_47_3, arg_47_4)

	if arg_47_0:heroHasBuff(arg_47_2, BUFF_TYPE_MISC_SUOLIAN) then
		local var_47_4 = g_CombatSystem:getHeros(arg_47_2.forceType, true)

		for iter_47_0, iter_47_1 in pairs(var_47_4) do
			if arg_47_0:heroHasBuff(iter_47_1, BUFF_TYPE_MISC_SUOLIAN) then
				g_BuffSystem:createBuff(arg_47_1, iter_47_1, arg_47_3, var_47_1, var_47_2, var_47_3, arg_47_4)
			end
		end
	end
end

function zbBuffSystem.createBuff(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)
	local var_48_0 = zbBuffTable:getRecord(arg_48_3)

	if var_48_0 == nil then
		echo("warning: buffid is not exist: " .. arg_48_3)

		return
	end

	if var_48_0.bossImmune and arg_48_2:isBigBoss() then
		echo("bossImmune buff: " .. arg_48_3)

		return
	end

	local var_48_1
	local var_48_2 = arg_48_0.funCreator[var_48_0.buffType]

	if var_48_2 ~= nil then
		arg_48_0:removeReplaceExistBuff(arg_48_1, arg_48_2, arg_48_3)

		var_48_1 = var_48_2(arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)

		if var_48_1 ~= nil then
			table.insert(arg_48_0.buffList, var_48_1)

			if arg_48_1 ~= nil then
				local var_48_3 = ""
				local var_48_4 = arg_48_1.forceType == arg_48_2.forceType and "\xB8\xF8\xD3ѷ\xBD" or "\xB8\xF8\xB5з\xBD"

				echo(ForceTypeDesc[arg_48_1.forceType] .. arg_48_1.heroRecord.name .. a2u(var_48_4) .. arg_48_2.heroRecord.name .. a2u(" \xCC\xED\xBC\xD3\xC1\xCBbuff: ") .. var_48_0.name .. a2u(", \xB3\xD6\xD0\xF8") .. arg_48_6 .. a2u("\xBBغ\xCF"))
			else
				echo(a2u("\xC9\xF1\xB1\xF8\xB8\xF8 ") .. arg_48_2.heroRecord.name .. a2u(" \xCC\xED\xBC\xD3\xC1\xCBbuff: ") .. var_48_0.name .. a2u(", \xB3\xD6\xD0\xF8") .. arg_48_6 .. a2u("\xBBغ\xCF"))
			end
		end
	end

	return var_48_1
end

function zbBuffSystem.removeBuff(arg_49_0, arg_49_1, arg_49_2)
	for iter_49_0 = #arg_49_0.buffList, 1, -1 do
		local var_49_0 = arg_49_0.buffList[iter_49_0]

		if var_49_0.buffId == arg_49_2 and var_49_0.hero:isSame(arg_49_1) then
			echo(ForceTypeDesc[var_49_0.hero.forceType] .. var_49_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_49_0.buffRecord.name)
			var_49_0:free()
			table.remove(arg_49_0.buffList, iter_49_0)
		end
	end
end

function zbBuffSystem.removeReplaceExistBuff(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	for iter_50_0 = #arg_50_0.buffList, 1, -1 do
		local var_50_0 = false
		local var_50_1 = arg_50_0.buffList[iter_50_0]

		if var_50_1.buffId == arg_50_3 then
			if var_50_1.buffRecord.replaceadd == 1 and var_50_1.hero:isSame(arg_50_2) then
				var_50_0 = true
			end

			if var_50_1.attacker:isSame(arg_50_1) and var_50_1.hero:isSame(arg_50_2) then
				var_50_0 = true
			end
		end

		if var_50_0 then
			echo(ForceTypeDesc[var_50_1.hero.forceType] .. var_50_1.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_50_1.buffRecord.name)
			var_50_1:free()
			table.remove(arg_50_0.buffList, iter_50_0)
		end
	end
end

function zbBuffSystem.heroHasBuff(arg_51_0, arg_51_1, arg_51_2)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.buffList) do
		if iter_51_1.buffId == arg_51_2 and iter_51_1.hero:isSame(arg_51_1) then
			return true
		end
	end

	return false
end

function zbBuffSystem.getHeroBuff(arg_52_0, arg_52_1, arg_52_2)
	for iter_52_0, iter_52_1 in pairs(arg_52_0.buffList) do
		if iter_52_1.buffId == arg_52_2 and iter_52_1.hero:isSame(arg_52_1) then
			return iter_52_1
		end
	end

	return nil
end

function zbBuffSystem.removeHeroBuffById(arg_53_0, arg_53_1, arg_53_2)
	for iter_53_0 = #arg_53_0.buffList, 1, -1 do
		local var_53_0 = arg_53_0.buffList[iter_53_0]

		if var_53_0.hero:isSame(arg_53_1) and var_53_0.buffId == arg_53_2 then
			echo(ForceTypeDesc[var_53_0.hero.forceType] .. var_53_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_53_0.buffRecord.name)
			var_53_0:free()
			table.remove(arg_53_0.buffList, iter_53_0)
		end
	end
end

function zbBuffSystem.removeHeroAllBuff(arg_54_0, arg_54_1)
	for iter_54_0 = #arg_54_0.buffList, 1, -1 do
		local var_54_0 = arg_54_0.buffList[iter_54_0]

		if var_54_0.hero:isSame(arg_54_1) then
			echo(ForceTypeDesc[var_54_0.hero.forceType] .. var_54_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_54_0.buffRecord.name)
			var_54_0:free()
			table.remove(arg_54_0.buffList, iter_54_0)
		end
	end
end

function zbBuffSystem.removeHeroAllDebuff(arg_55_0, arg_55_1)
	for iter_55_0 = #arg_55_0.buffList, 1, -1 do
		local var_55_0 = arg_55_0.buffList[iter_55_0]

		if var_55_0:isDebuff() and var_55_0.buffRecord.canClear and var_55_0.hero:isSame(arg_55_1) then
			echo(ForceTypeDesc[var_55_0.hero.forceType] .. var_55_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff: ") .. var_55_0.buffRecord.name)
			var_55_0:free()
			table.remove(arg_55_0.buffList, iter_55_0)
		end
	end
end

function zbBuffSystem.heroHasDebuffThisRound(arg_56_0, arg_56_1)
	for iter_56_0 = #arg_56_0.buffList, 1, -1 do
		local var_56_0 = arg_56_0.buffList[iter_56_0]

		if var_56_0:isDebuff() and var_56_0.buffRecord.canClear and var_56_0.hero:isSame(arg_56_1) and var_56_0.startRound == g_CombatRound:getCurRound() then
			return true
		end
	end

	return false
end

function zbBuffSystem.hasDebuffThisRound(arg_57_0, arg_57_1)
	local var_57_0 = g_CombatSystem:getHeros(arg_57_1, true)

	for iter_57_0, iter_57_1 in pairs(var_57_0) do
		if arg_57_0:heroHasDebuffThisRound(iter_57_1) then
			return true
		end
	end

	return false
end

function zbBuffSystem.clearHeroShield(arg_58_0, arg_58_1)
	return
end

EShieldEffectType = {
	Qidun = 7,
	Pangde = 1,
	Wenchou = 2,
	Zhanghe = 10,
	Sunquan = 11,
	Lxh = 8,
	Tengjiabing = 6,
	Zhoutai = 3,
	Xingcai = 4,
	Caoren = 5,
	Zhaoyun = 9
}

function zbBuffSystem.createFaliShield(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	g_UseFaliShield = true

	local var_59_0 = BUFF_TYPE_SHIELD_PHYSICMAGIC
	local var_59_1 = arg_59_3
	local var_59_2 = 0
	local var_59_3 = 10000
	local var_59_4 = g_BuffSystem:createBuff(arg_59_1, arg_59_2, var_59_0, var_59_1, var_59_2, var_59_3)

	g_UseFaliShield = false

	return var_59_4
end

function zbBuffSystem.createSunquanShield(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	local var_60_0 = arg_60_0:createFaliShield(arg_60_1, arg_60_2, arg_60_3, arg_60_4)

	if var_60_0 ~= nil then
		var_60_0.sunquanShield = true
	end

	return var_60_0
end

function zbBuffSystem.hasSunquanShield(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in pairs(arg_61_0.buffList) do
		if iter_61_1.hero:isSame(arg_61_1) and iter_61_1.sunquanShield ~= nil and iter_61_1.sunquanShield == true then
			return true
		end
	end

	return false
end

EWudiImmuneEffectType = {
	Jiaxu = 2,
	Chanshi = 3,
	Pangtong = 1
}

function zbBuffSystem.createWudiImmuneShield(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4)
	local var_62_0 = BUFF_TYPE_IMMUNE_ALLDAMAGE
	local var_62_1 = 0
	local var_62_2 = 0
	local var_62_3 = arg_62_3

	g_BuffSystem:createBuff(arg_62_1, arg_62_2, var_62_0, var_62_1, var_62_2, var_62_3)
end

EWudiImmuneEffectType = {
	Jiaxu = 2,
	Chanshi = 3,
	Pangtong = 1
}

function zbBuffSystem.createWudiImmuneShield(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = BUFF_TYPE_IMMUNE_ALLDAMAGE
	local var_63_1 = 0
	local var_63_2 = 0
	local var_63_3 = arg_63_3

	g_BuffSystem:createBuff(arg_63_1, arg_63_2, var_63_0, var_63_1, var_63_2, var_63_3)
end

function zbBuffSystem.createLiuxueDebuff(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = BUFF_TYPE_PROPERTY_HP_LIUXUE
	local var_64_1 = -math.abs(arg_64_3)
	local var_64_2 = 0
	local var_64_3 = 2

	g_BuffSystem:createBuff(hero, arg_64_2, var_64_0, var_64_1, var_64_2, var_64_3)
end

function zbBuffSystem.createGuduDebuff(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = BUFF_TYPE_PROPERTY_HP
	local var_65_1 = -math.abs(arg_65_3)
	local var_65_2 = 0
	local var_65_3 = 3
	local var_65_4 = g_BuffSystem:createBuff(hero, arg_65_2, var_65_0, var_65_1, var_65_2, var_65_3)

	if var_65_4 ~= nil then
		var_65_4.gudu = true
	end
end

function zbBuffSystem.heroHasGuduDebuff(arg_66_0, arg_66_1)
	for iter_66_0, iter_66_1 in pairs(arg_66_0.buffList) do
		if iter_66_1.gudu ~= nil and iter_66_1.gudu == true and iter_66_1.hero:isSame(arg_66_1) then
			return true
		end
	end

	return false
end

function zbBuffSystem.createJiuqiDebuff(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = BUFF_TYPE_PROPERTY_JIUQI
	local var_67_1 = 0
	local var_67_2 = 0
	local var_67_3 = 2

	g_BuffSystem:createBuff(hero, arg_67_2, var_67_0, var_67_1, var_67_2, var_67_3)
end

function zbBuffSystem.heroHasJiuqiDebuff(arg_68_0, arg_68_1)
	for iter_68_0, iter_68_1 in pairs(arg_68_0.buffList) do
		if iter_68_1.buffId == BUFF_TYPE_PROPERTY_JIUQI and iter_68_1.hero:isSame(arg_68_1) then
			return true
		end
	end

	return false
end

function zbBuffSystem.createZhongziDebuff(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_0 = BUFF_TYPE_MISC_ZHONGZI
	local var_69_1 = -math.abs(arg_69_3)
	local var_69_2 = -math.abs(arg_69_4)
	local var_69_3 = 1

	g_BuffSystem:createBuff(arg_69_1, arg_69_2, var_69_0, var_69_1, var_69_2, var_69_3)
end

function zbBuffSystem.heroHasZhongziDebuff(arg_70_0, arg_70_1)
	for iter_70_0, iter_70_1 in pairs(arg_70_0.buffList) do
		if iter_70_1.buffId == BUFF_TYPE_MISC_ZHONGZI and iter_70_1.hero:isSame(arg_70_1) then
			return true
		end
	end

	return false
end
