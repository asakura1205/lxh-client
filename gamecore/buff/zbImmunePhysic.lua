require("gamecore.buff.zbBaseBuff")

zbImmunePhysic = class("zbImmunePhysic", zbBaseBuff)
zbImmunePhysic.__index = zbImmunePhysic

function zbImmunePhysic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbImmunePhysic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbImmunePhysic.initMy(arg_2_0)
	arg_2_0.hero:setImmunePhysic(true)
end

function zbImmunePhysic.free(arg_3_0)
	arg_3_0.hero:setImmunePhysic(false)
	echo(ForceTypeDesc[arg_3_0.hero.forceType] .. arg_3_0.hero.heroRecord.name .. a2u(" \xD2Ƴ\xFD\xC1\xCBbuff ") .. arg_3_0.buffRecord.name)
end

function zbImmunePhysic.newRound(arg_4_0)
	arg_4_0.hero:setImmunePhysic(true)
end

function zbImmunePhysic.update(arg_5_0, arg_5_1)
	return
end

function zbImmunePhysic.isDebuff(arg_6_0)
	return false
end
