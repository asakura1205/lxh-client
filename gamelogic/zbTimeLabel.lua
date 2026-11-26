require("gamelogic.zbColor")

zbTimeLabel = class("zbTimeLabel")
zbTimeLabel.__index = zbTimeLabel

function zbTimeLabel.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbTimeLabel)

	return arg_1_0
end

function zbTimeLabel.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = zbTimeLabel.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function zbTimeLabel.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.label = arg_3_1
	arg_3_0.normalTip = arg_3_2
	arg_3_0.followTimeingTip = arg_3_3
	arg_3_0.showMS = arg_3_4
	arg_3_0.autoMS = false
	arg_3_0.countdown = 0
	arg_3_0.startCountdown = 0
	arg_3_0.stopUpdate = false

	arg_3_0.label:scheduleUpdateWithPriorityLua(function()
		arg_3_0:update()
	end, 0)
end

function zbTimeLabel.start(arg_5_0, arg_5_1)
	arg_5_0.countdown = arg_5_1
	arg_5_0.startCountdown = arg_5_1
	arg_5_0.startCdTime = os_timenow()
	arg_5_0.stopUpdate = false

	arg_5_0:update()
end

function zbTimeLabel.setSpecialString(arg_6_0, arg_6_1)
	arg_6_0.stopUpdate = true

	arg_6_0.label:setString(arg_6_1)
end

function zbTimeLabel.clear(arg_7_0)
	arg_7_0.countdown = 0
	arg_7_0.startCountdown = 0

	arg_7_0:update()
end

function zbTimeLabel.setAutoMS(arg_8_0, arg_8_1)
	arg_8_0.autoMS = arg_8_1
end

local var_0_0 = 86400

function zbTimeLabel.update(arg_9_0)
	if arg_9_0.stopUpdate then
		return
	end

	if arg_9_0.countdown > 0 then
		arg_9_0.countdown = arg_9_0.startCountdown - (os_timenow() - arg_9_0.startCdTime)

		if arg_9_0.countdown <= 0 then
			arg_9_0.countdown = 0
			arg_9_0.startCountdown = 0
			arg_9_0.startCdTime = -1
			arg_9_0.isRed = false
		end

		local var_9_0 = 0

		if (arg_9_0.showMS == nil or arg_9_0.showMS == false) and arg_9_0.autoMS == false then
			var_9_0 = zbUtil:SprintfHHMMSS(arg_9_0.countdown)
		elseif arg_9_0.autoMS then
			if arg_9_0.countdown > 60 then
				var_9_0 = zbUtil:SprintfHHMM(arg_9_0.countdown)
			else
				var_9_0 = zbUtil:SprintfMMSS(arg_9_0.countdown)
			end
		else
			var_9_0 = zbUtil:SprintfMMSS(arg_9_0.countdown)
		end

		if arg_9_0.followTimeingTip ~= nil then
			arg_9_0.label:setString(var_9_0 .. a2u(arg_9_0.followTimeingTip))
		else
			arg_9_0.label:setString(var_9_0)
		end

		if arg_9_0.countdown <= 0 and arg_9_0.customCallback ~= nil then
			arg_9_0.customCallback()
		end
	else
		arg_9_0.label:setString(arg_9_0.normalTip)
	end
end

function zbTimeLabel.setCustomCallback(arg_10_0, arg_10_1)
	arg_10_0.customCallback = arg_10_1
end
