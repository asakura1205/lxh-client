CCSpriteExtend = class("CCSpriteExtend", CCNodeExtend)
CCSpriteExtend.__index = CCSpriteExtend

function CCSpriteExtend.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCSpriteExtend)

	local function var_1_1(arg_2_0)
		if arg_2_0 == "enter" then
			echoInfo("Scene \"%s:onEnter()\"", arg_1_0.name or arg_1_0.className or "unknown")
			arg_1_0:onEnter()
		end
	end

	arg_1_0:registerNodeEvent(var_1_1)

	return arg_1_0
end

function CCSpriteExtend.playAnimationOnce(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return transition.playAnimationOnce(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function CCSpriteExtend.playAnimationForever(arg_4_0, arg_4_1, arg_4_2)
	return transition.playAnimationForever(arg_4_0, arg_4_1, arg_4_2)
end

function CCSpriteExtend.autoCleanup(arg_5_0)
	if not arg_5_0.IMAGE_FILENAME or arg_5_0.AUTO_CLEANUP then
		return
	end

	local function var_5_0(arg_6_0)
		if arg_6_0 == "exit" then
			display.removeSpriteFrameByImageName(arg_5_0.IMAGE_FILENAME)
		end
	end

	arg_5_0:registerScriptHandler(var_5_0)

	arg_5_0.AUTO_CLEANUP = true
end
