local var_0_0 = class("zbCombatFocus")

var_0_0.__index = var_0_0

local var_0_1 = 3

function createCombatFocus()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.cdRound = 0
	arg_2_0.target = nil
end

function var_0_0.free(arg_3_0)
	return
end

function var_0_0.newRound(arg_4_0, arg_4_1)
	arg_4_0.cdRound = math.max(arg_4_0.cdRound - 1, 0)
end

function var_0_0.getCountdown(arg_5_0)
	return arg_5_0.cdRound
end

function var_0_0.isCanExecAndTip(arg_6_0)
	if g_CombatSystem:isPvPCombatType() then
		g_Bubble:bubbleInfo("pvp\xB2\xBB\xC4\xDC\xC9\xE8\xD6ü\xAF\xBB\xF0Ŀ\xB1\xEA")

		return false
	end

	if arg_6_0.cdRound > 0 then
		g_Bubble:bubbleInfo(string.format("\xBC\xAF\xBB\xF0\xC0\xE4ȴʣ\xD3\xE0%d\xBBغ\xCF", arg_6_0.cdRound))

		return false
	end

	return true
end

function var_0_0.setTarget(arg_7_0, arg_7_1)
	if arg_7_0:isCanExecAndTip() == false then
		return false
	end

	if arg_7_1 == nil then
		return
	end

	if arg_7_1 ~= nil and arg_7_0.target ~= nil and arg_7_0.target:isSame(arg_7_1) then
		return
	end

	arg_7_0.cdRound = var_0_1
	arg_7_0.target = arg_7_1

	g_CombatBubble:showBubble(arg_7_1, ECombatBubble.Focus, 0, 0, 1)

	return true
end

function var_0_0.getTarget(arg_8_0)
	return arg_8_0.target
end

function var_0_0.heroDied(arg_9_0, arg_9_1)
	if arg_9_0.target ~= nil and arg_9_0.target:isSame(arg_9_1) then
		arg_9_0.target = nil
	end
end

function var_0_0.clearTarget(arg_10_0)
	arg_10_0.target = nil
end

function var_0_0.update(arg_11_0, arg_11_1)
	return
end
