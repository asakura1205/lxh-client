zbBaseBuff = class("zbBaseBuff")
zbBaseBuff.__index = zbBaseBuff

function zbBaseBuff.initBase(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	arg_1_0.attacker = arg_1_1
	arg_1_0.hero = arg_1_2
	arg_1_0.buffId = arg_1_3
	arg_1_0.param1 = arg_1_4
	arg_1_0.param2 = arg_1_5
	arg_1_0.round = arg_1_6
	arg_1_0.bubbleDelayTime = arg_1_7

	if arg_1_0.bubbleDelayTime == nil then
		arg_1_0.bubbleDelayTime = 0
	end

	arg_1_0.buffRecord = zbBuffTable:getRecord(arg_1_3)
	arg_1_0.startRound = math.max(g_CombatRound:getCurRound(), 1)
	arg_1_0.removeWhenDied = false
	arg_1_0.startTime = os_timenow()
	arg_1_0.heroEndActionIndex = arg_1_2.accumRoundCount + arg_1_6

	arg_1_0:showBubble()
end

function zbBaseBuff.isDebuff(arg_2_0)
	return false
end

function zbBaseBuff.isEnd(arg_3_0)
	if arg_3_0.hero:isDie() and arg_3_0.removeWhenDied then
		return true
	end

	if g_CombatStateMachine:getCurrStateId() == CombatState_Finish then
		return true
	end

	if arg_3_0.hero.accumRoundCount > arg_3_0.heroEndActionIndex then
		return true
	elseif arg_3_0.hero.accumRoundCount == arg_3_0.heroEndActionIndex and arg_3_0.hero:isRoundEnd() then
		if arg_3_0.buffRecord.buffType == BUFF_TYPE_CONTROL_HUNMI and g_CombatRound:getCurRound() <= arg_3_0.startRound + 1 and os_timenow() - arg_3_0.startTime < 0.5 then
			return false
		end

		return true
	end

	return false
end

function zbBaseBuff.showBubble(arg_4_0)
	local var_4_0 = ECombatBubble.Unknown
	local var_4_1 = arg_4_0.buffRecord.buffType

	if var_4_1 == BUFF_TYPE_CONTROL_HUNMI then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_HUNMI)

		var_4_0 = ECombatBubble.CtrlHunmi
	elseif var_4_1 == BUFF_TYPE_CONTROL_MEIHUO then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_MEIHUO)

		var_4_0 = ECombatBubble.CtrlMeihuo
	elseif var_4_1 == BUFF_TYPE_CONTROL_CHENMO then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_CHENMO)

		var_4_0 = ECombatBubble.CtrlChenmo
	elseif var_4_1 == BUFF_TYPE_CONTROL_CHAOFENG then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_CHAOFENG)

		var_4_0 = ECombatBubble.CtrlChaofeng
	elseif var_4_1 == BUFF_TYPE_CONTROL_ZHONGSHANG then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_ZHONGSHANG)

		var_4_0 = ECombatBubble.CtrlZhongshang
	elseif var_4_1 == BUFF_TYPE_IMMUNE_PHYSICDAMAGE then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_IMMUNE_PHYSIC)
	elseif var_4_1 == BUFF_TYPE_IMMUNE_MAGICDAMAGE then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_IMMUNE_MAGIC)
	elseif var_4_1 == BUFF_TYPE_IMMUNE_ALLDAMAGE then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_IMMUNE_PM)
	elseif var_4_1 == BUFF_TYPE_SHIELD_PHYSIC then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PHYSIC)
	elseif var_4_1 == BUFF_TYPE_SHIELD_MAGIC then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_MAGIC)
	elseif var_4_1 == BUFF_TYPE_SHIELD_PHYSICMAGIC then
		if g_UseHeixiuShield then
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PM_HEIXIU)
		elseif g_UseBangqiuShield then
			arg_4_0.hero.buffGround:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PM_BANGQIU_BOTTOM)
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PM_BANGQIU_FRONT)
		elseif g_UseFangcunheShield then
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE)
		else
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_PM)
		end
	elseif var_4_1 == BUFF_TYPE_SHIELD_ROUNDREDUCE then
		if g_UseHuaxianziShield then
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_ROUND_REDUCE_HUAXIANZI)
		else
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_SHIELD_ROUND_REDUCE)
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_PHYSICATTACK then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicAttackUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicAttackDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_PHYSICDEFEND then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicDefendDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_MAGICATTACK then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.MagicAttackUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.MagicAttackDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_MAGICDEFEND then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.MagicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.MagicDefendDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_PHYSICATTACK_MAGICATTACK then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicMagicAttackUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicMagicAttackDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_PHYSICDEFEND_MAGICDEFEND then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicMagicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicMagicDefendDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_HP then
		if arg_4_0.param1 < 0 then
			arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_LIUXUE)
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_HP_FIRE then
		if arg_4_0.param1 < 0 then
			arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_FIRE)
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_HP_LIUXUE then
		if arg_4_0.param1 < 0 then
			arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_LIUXUE)
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_HP_ZHONGDU then
		if arg_4_0.param1 < 0 then
			arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_ZHONGDU)

			var_4_0 = ECombatBubble.ZhongDu
		end
	elseif var_4_1 == BUFF_TYPE_MISC_SUOLIAN then
		arg_4_0.hero.buffGround:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_MISC_SUOLIAN)
	elseif var_4_1 == BUFF_TYPE_MISC_ZHONGZI then
		arg_4_0.hero.buffHead:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_MISC_ZHONGZI)
	elseif var_4_1 == BUFF_TYPE_MISC_QINYIN then
		arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_CAIWENJI_QINYIN)
	elseif var_4_1 == BUFF_TYPE_PROPERTY_MAXHP then
		var_4_0 = ECombatBubble.MaxHpUp
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DODGE then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.DodgeUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.DodgeDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_VIOLENT then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.ViolentUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.ViolentDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_TOUGH then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.ToughUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.ToughDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_PIERCE then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PierceUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PierceDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_BLOCK then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.BlockUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.BlockDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicDamageUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicDamageDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.MagicDamageUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.MagicDamageDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicMagicDamageUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicMagicDamageDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicDefendDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_MAGIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.MagicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.MagicDefendDown
		end
	elseif var_4_1 == BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC then
		if arg_4_0.param1 > 0 then
			var_4_0 = ECombatBubble.PhysicMagicDefendUp
		elseif arg_4_0.param1 < 0 then
			var_4_0 = ECombatBubble.PhysicMagicDefendDown
		end

		if g_UseLoalong then
			arg_4_0.hero.buffFront:showBuffEffect(arg_4_0.buffId, BUFF_SEQUENCE_LAOLONG)
		end
	end

	if var_4_0 ~= ECombatBubble.Unknown then
		g_CombatBubble:showBubble(arg_4_0.hero, var_4_0, 0, arg_4_0.bubbleDelayTime, 1)
	end
end
