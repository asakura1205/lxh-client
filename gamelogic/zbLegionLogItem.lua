local var_0_0 = class("zbLegionLogItem")

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

function createLegionLogItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.lbltime = tolua.cast(var_5_0:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbldesc = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")

		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1

	arg_6_0:setVisible(arg_6_0.data ~= nil)

	if arg_6_0.data ~= nil then
		local var_6_0 = zbUtil:SprintfYYYYMMDD(arg_6_1.Tm)
		local var_6_1 = zbUtil:SprintfHHMM(arg_6_1.Tm + g_Self.kTimeHandler:getTimeZoneDelt())
		local var_6_2 = var_6_0 .. " " .. var_6_1

		arg_6_0.lbltime:setString(var_6_2)

		local var_6_3 = zbLegionHelp:getLogDesc(arg_6_1)

		arg_6_0.lbldesc:setString(var_6_3)
		arg_6_0.lbldesc:setPositionX(arg_6_0.lbltime:getPositionX() + arg_6_0.lbltime:getContentSize().width + 10)
	end
end

function var_0_0.refreshBlessLog(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	arg_7_0:setVisible(arg_7_0.data ~= nil)

	if arg_7_0.data ~= nil then
		local var_7_0 = zbLegionHelp:getBlessLogDesc(arg_7_1)

		arg_7_0.lbltime:setString(var_7_0)
		arg_7_0.lbldesc:setString("")
	end
end

function var_0_0.refreshPartyLog(arg_8_0, arg_8_1)
	arg_8_0.data = arg_8_1

	arg_8_0:setVisible(arg_8_0.data ~= nil)

	if arg_8_0.data ~= nil then
		local var_8_0 = zbUtil:SprintfYYYYMMDD(arg_8_1.Tm)
		local var_8_1 = zbUtil:SprintfHHMM(arg_8_1.Tm + g_Self.kTimeHandler:getTimeZoneDelt())
		local var_8_2 = var_8_0 .. " " .. var_8_1

		arg_8_0.lbltime:setString(var_8_2)

		local var_8_3 = zbLegionHelp:getPartyLogDesc(arg_8_1)

		arg_8_0.lbldesc:setString(var_8_3)
		arg_8_0.lbldesc:setPositionX(arg_8_0.lbltime:getPositionX() + arg_8_0.lbltime:getContentSize().width + 10)
	end
end

function var_0_0.refreshLegionWarLog(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1

	arg_9_0:setVisible(arg_9_0.data ~= nil)

	if arg_9_0.data ~= nil then
		local var_9_0 = math.max(g_Self.kTimeHandler:getServerTime() - arg_9_1.LogTm, 0)
		local var_9_1 = zbUtil:getPassTimeShort(var_9_0)

		arg_9_0.lbltime:setString(var_9_1)
		arg_9_0.lbldesc:setString(arg_9_1.Log)
		arg_9_0.lbldesc:setPositionX(arg_9_0.lbltime:getPositionX() + arg_9_0.lbltime:getContentSize().width + 10)
	end
end
