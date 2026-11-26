local var_0_0 = class("zbMailHandler")

var_0_0.__index = var_0_0

function createMailHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.MailList = {}
end

function var_0_0.updateMailList(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid mailList")

		return
	end

	arg_3_0.MailList = arg_3_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_MailList)
	g_Self.kRedPointHandler:refreshMail()
end

function var_0_0.updateMailDetail(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		echo("warning: invalid mailDetail")

		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.MailList) do
		if iter_4_1.MailId == arg_4_1.MailId then
			table.remove(arg_4_0.MailList, iter_4_0)
			table.insert(arg_4_0.MailList, arg_4_1)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_MailList)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_MailDetail)
			g_Self.kRedPointHandler:refreshMail()

			return
		end
	end

	echo("warning: no match exist mailDetail")
end

function var_0_0.deleteMailList(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(arg_5_0.MailList) do
			if iter_5_3.MailId == iter_5_1 then
				table.remove(arg_5_0.MailList, iter_5_2)

				var_5_0 = true

				break
			end
		end
	end

	if var_5_0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_MailList)
	end
end

function var_0_0.getUnReadCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.MailList) do
		if iter_6_1.ReadState ~= 1 then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function var_0_0.hasAward(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.MailList) do
		if iter_7_1.ReadState == 0 then
			return true
		elseif iter_7_1.AwardState == 0 and zbUtil:isValidTable(iter_7_1.AwardList) == true and table.getn(iter_7_1.AwardList) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.updateMailRead(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= -1 and arg_8_2 then
		for iter_8_0, iter_8_1 in pairs(arg_8_0.MailList) do
			if iter_8_1.MailId == arg_8_1 and arg_8_2.Ret == 0 then
				iter_8_1.ReadState = 1

				arg_8_0:updateMailDetail(iter_8_1)

				return
			end
		end
	end
end
