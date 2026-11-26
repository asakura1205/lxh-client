require("gamecore.buff.zbBaseBuff")

zbMiscYandiYun = class("zbMiscYandiYun", zbBaseBuff)
zbMiscYandiYun.__index = zbMiscYandiYun

function zbMiscYandiYun.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbMiscYandiYun.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbMiscYandiYun.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true
	arg_2_0.hero.yandiYunEnable = true

	local var_2_0 = getFlipForceType(arg_2_0.hero.forceType)
	local var_2_1 = getCombatHeroPos(var_2_0, 5)

	var_2_1.y = var_2_1.y + 370

	g_EffectSystem:createBombEffect(arg_2_0.hero, var_2_0, var_2_1, 1012044, 0)
end

function zbMiscYandiYun.free(arg_3_0)
	arg_3_0.hero.yandiYunEnable = false
end

function zbMiscYandiYun.newRound(arg_4_0)
	return
end

function zbMiscYandiYun.update(arg_5_0, arg_5_1)
	return
end

function zbMiscYandiYun.isDebuff(arg_6_0)
	return false
end
