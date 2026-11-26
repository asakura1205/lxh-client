local var_0_0 = class("zbChatline_system", CCNodeExtend)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createChatlineSystem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.chattm = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spframe = tolua.cast(var_5_0:getChildByTag(5), "CCScale9Sprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(3), "CCNode")

		arg_3_0.content = createChatContent()

		arg_3_0.content:setPosition(130, 45)
		var_5_1:addChild(arg_3_0.content)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	local var_6_0 = ""
	local var_6_1 = ""

	if arg_6_1.scroll == 0 then
		var_6_0 = zbUtil:SprintfHHMM(arg_6_1.ChatTm + g_Self.kTimeHandler:getTimeZoneDelt())
		var_6_1 = arg_6_1.ChatMsg
	else
		var_6_0 = zbUtil:SprintfHHMM(arg_6_1.Tm + g_Self.kTimeHandler:getTimeZoneDelt())
		var_6_1 = arg_6_1.Content
	end

	arg_6_0.chattm:setString(var_6_0)
	arg_6_0.content:refresh(var_6_1)
	arg_6_0.spframe:setPreferredSize(CCSizeMake(arg_6_0.content.width, 45))
end
