zbBaseLegendSkill = class("zbBaseLegendSkill")
zbBaseLegendSkill.__index = zbBaseLegendSkill

function zbBaseLegendSkill.initBase(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.legend = arg_1_1
	arg_1_0.battleGod = arg_1_2
	arg_1_0.forceType = arg_1_0.legend.forceType
	arg_1_0.actioning = false
end

function zbBaseLegendSkill.getSkillValue(arg_2_0, arg_2_1)
	local var_2_0 = false
	local var_2_1 = 0
	local var_2_2 = 0
	local var_2_3

	for iter_2_0, iter_2_1 in pairs(arg_2_0.battleGod.SkillList) do
		if iter_2_1.Index == arg_2_1 then
			local var_2_4 = zbGodSkillTable:getRecord(iter_2_1.SkillId)

			if var_2_4 ~= nil then
				var_2_0 = true
				var_2_1 = var_2_4.base1 + var_2_4.powerFactor * g_GameData.GodInfo.Power * math.pow(1.1, iter_2_1.Level)
				var_2_2 = var_2_4.base2 + iter_2_1.Level * var_2_4.lvlFactor
				var_2_3 = var_2_4

				break
			end
		end
	end

	if var_2_0 == false then
		echo("--------- warning: invalid legendSkillIndex " .. arg_2_1)
	end

	return var_2_0, var_2_1, var_2_2, var_2_3
end

function zbBaseLegendSkill.isFriend(arg_3_0, arg_3_1)
	return arg_3_1.forceType == arg_3_0.forceType
end

function zbBaseLegendSkill.isActioning(arg_4_0)
	return arg_4_0.actioning
end

function zbBaseLegendSkill.newRound(arg_5_0)
	return
end

function zbBaseLegendSkill.execInitPassiveSkill(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.battleGod.SkillList) do
		local var_6_0, var_6_1, var_6_2 = arg_6_0:getSkillValue(iter_6_1.Index)

		if var_6_0 and iter_6_1.Level > 0 then
			if iter_6_1.Index == 2 then
				arg_6_0:action2(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 3 then
				arg_6_0:action3(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 4 then
				arg_6_0:action4(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 5 then
				arg_6_0:action5(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 6 then
				arg_6_0:action6(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 7 then
				arg_6_0:action7(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 8 then
				arg_6_0:action8(arg_6_1, var_6_1, var_6_2)
			elseif iter_6_1.Index == 9 then
				arg_6_0:action9(arg_6_1, var_6_1, var_6_2)
			end
		end
	end
end

function zbBaseLegendSkill.popPassiveBubble(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.battleGod.SkillList) do
		if iter_7_1.Level > 0 and iter_7_1.Index > 1 then
			local var_7_2, var_7_3, var_7_4, var_7_5 = arg_7_0:getSkillValue(iter_7_1.Index)

			if var_7_5 ~= nil then
				var_7_1 = var_7_1 + 1
				var_7_0[var_7_1] = var_7_5.name

				echo("---------------:" .. var_7_5.name)
			end
		end
	end

	return var_7_0, var_7_1
end
