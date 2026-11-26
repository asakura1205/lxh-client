zbChannelUtil_Report = {}

local var_0_0 = "eb87123e8b4cb362383560bfb9d4143e"

function zbChannelUtil_Report.getReportPostData(arg_1_0, arg_1_1)
	if type(arg_1_1) ~= "table" then
		return ""
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		table.insert(var_1_0, iter_1_0)
	end

	table.sort(var_1_0)

	local var_1_1 = ""
	local var_1_2 = 1
	local var_1_3 = ""

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		local var_1_4 = var_1_2 == 1 and "" or "#"
		local var_1_5 = arg_1_1[iter_1_3]

		var_1_1 = var_1_1 .. var_1_4 .. iter_1_3 .. "=" .. var_1_5
		var_1_2 = var_1_2 + 1
	end

	local var_1_6 = var_1_1 .. "#" .. var_0_0
	local var_1_7 = zbGlobalUtil:getMd5(var_1_6, true)
	local var_1_8 = ""
	local var_1_9 = 1
	local var_1_10 = ""

	for iter_1_4, iter_1_5 in pairs(var_1_0) do
		local var_1_11 = var_1_9 == 1 and "" or "&"
		local var_1_12 = arg_1_1[iter_1_5]

		var_1_8 = var_1_8 .. var_1_11 .. iter_1_5 .. "=" .. var_1_12
		var_1_9 = var_1_9 + 1
	end

	return var_1_8 .. "&sign=" .. var_1_7
end

function zbChannelUtil_Report.reportGameData(arg_2_0, arg_2_1)
	local var_2_0 = {
		fun = "PostData",
		groupid = g_Login.lastServerId,
		channel = g_Login.channel,
		dtype = arg_2_1,
		os = g_Login.os,
		osvers = g_Login.os_vers,
		device = g_Login.device,
		deviceuuid = g_Login.device_uuid,
		time = os.time()
	}
	local var_2_1 = zbChannelUtil_Report:getReportPostData(var_2_0)

	g_HttpMsgHandler:sendPostMsg(g_reportgameData_url, var_2_1, E_ZB_REPORT)
end

function zbChannelUtil_Report.reportAdvice(arg_3_0, arg_3_1)
	local var_3_0 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_3_0 = g_GameData.BaseInfo.PlayerId
	end

	local var_3_1 = {
		fun = "FeedBack",
		platform = g_Login.platform,
		groupid = g_Login.lastServerId,
		roleid = var_3_0,
		channel = g_Login.channel,
		os = g_Login.os,
		osvers = g_Login.os_vers,
		device = g_Login.device,
		deviceuuid = g_Login.device_uuid,
		time = os.time(),
		content = arg_3_1
	}
	local var_3_2 = zbChannelUtil_Report:getReportPostData(var_3_1)

	g_HttpMsgHandler:sendPostMsg(g_reportgameData_url, var_3_2, E_ZB_REPORT)
end

function zbChannelUtil_Report.submitRoleInfoByChannel(arg_4_0, arg_4_1)
	if g_Login.channel == EChannelType.bilibili then
		if ESubRoleInfoType.E_EXIT_GAME == arg_4_1 or ESubRoleInfoType.E_LVUP == arg_4_1 then
			return
		end
	elseif g_Login.channel == EChannelType.manya or g_Login.channel == EChannelType.boluofan or g_Login.channel == EChannelType.u17 then
		return
	elseif g_Login.channel == EChannelType.nox then
		-- block empty
	elseif ESubRoleInfoType.E_EXIT_GAME == arg_4_1 then
		if g_Login.channel == EChannelType.meizu or g_Login.channel == EChannelType.kaopu or g_Login.channel == EChannelType.kpsuper then
			return
		end
	elseif ESubRoleInfoType.E_ENTER_GAME == arg_4_1 or g_Login.channel == EChannelType.meizu or g_Login.channel == EChannelType.qihoo or g_Login.channel == EChannelType.uc and ESubRoleInfoType.E_LVUP == arg_4_1 then
		-- block empty
	else
		return
	end

	local var_4_0 = 0
	local var_4_1 = "\xCE\xDE"
	local var_4_2 = 0
	local var_4_3 = 0
	local var_4_4 = "\xCE\xDE"
	local var_4_5 = "\xCE\xDE"

	if g_Self then
		var_4_5 = a2u(g_Self.kLegionHandler:getLegionName())
	end

	local var_4_6 = "0"
	local var_4_7 = "0"
	local var_4_8 = 0
	local var_4_9 = ""

	if g_GameData.LegionInfo then
		var_4_6 = g_GameData.LegionInfo.LegionId
	end

	if g_GameData.BaseInfo then
		var_4_0 = g_GameData.BaseInfo.PlayerId
		var_4_1 = g_GameData.BaseInfo.RoleName

		if var_4_1 == "" or var_4_1 == nil then
			var_4_1 = a2u("\xCE\xDE")
		end

		var_4_2 = g_GameData.BaseInfo.Level
		var_4_7 = g_GameData.BaseInfo.VipLevel
		var_4_8 = g_GameData.CreateTime

		local var_4_10 = g_Login:getCurServer()

		if var_4_10 then
			var_4_3 = var_4_10.ServerId
			var_4_4 = var_4_10.ServerName
		end

		if var_4_4 == "" or var_4_4 == nil then
			var_4_4 = a2u("\xCE\xDE")
		end
	end

	if g_Login.channel == EChannelType.uc then
		var_4_9 = "{RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "RoleCtTm:" .. var_4_8 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "}"
	elseif g_Login.channel == EChannelType.bilibili then
		if var_4_0 == 0 or var_4_1 == a2u("\xCE\xDE") then
			return
		end

		var_4_3 = 449
		var_4_4 = a2u("biliһ\xC7\xF8")
		var_4_9 = "{ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "," .. "RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "}"
	elseif g_Login.channel == EChannelType.m4399 then
		local var_4_11 = g_Login:getCurServer()

		if var_4_11 then
			var_4_3 = var_4_11.ServerId
		end

		var_4_9 = var_4_3
	elseif g_Login.channel == EChannelType.vivo then
		var_4_9 = "{RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "}"
	elseif g_Login.channel == EChannelType.oppo then
		var_4_9 = "{RoleName:" .. var_4_1 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "RoleLv:" .. var_4_2 .. "}"
	elseif g_Login.channel == EChannelType.huawei then
		var_4_9 = "{RoleName:" .. var_4_1 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "RoleLv:" .. var_4_2 .. "}"
	elseif zbChannelUtil:isYijieSdkChannel(g_Login.channel) then
		local var_4_12 = 0

		if g_GameData.Wealth then
			var_4_12 = g_GameData.Wealth.Diamond
		end

		local var_4_13 = math.floor(g_Self.kTimeHandler:getServerTime()) or "0"

		if var_4_5 == a2u("\xBF\xD5") then
			var_4_5 = a2u("\xCEް\xEF\xC5\xC9")
		end

		var_4_9 = "{RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "," .. "RoleCtTm:" .. var_4_8 .. "," .. "RoleLevelMTm:" .. var_4_13 .. "," .. "Viplv:" .. var_4_7 .. "," .. "LeftDiamond:" .. var_4_12 .. "," .. "LegionName:" .. var_4_5 .. "}"
	elseif g_Login.channel == EChannelType.meizu then
		var_4_9 = "{RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "," .. "LegionName:" .. var_4_5 .. "}"
	elseif g_Login.channel == EChannelType.kaopu then
		local var_4_14 = 0

		if g_GameData.Wealth then
			var_4_14 = g_GameData.Wealth.Diamond
		end

		local var_4_15 = math.floor(g_Self.kTimeHandler:getServerTime()) or "0"
		local var_4_16 = g_Self:getFightValue()

		var_4_9 = "{ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "," .. "LeftDiamond:" .. var_4_14 .. "," .. "Viplv:" .. var_4_7 .. "," .. "LegionId:" .. var_4_6 .. "," .. "LegionName:" .. var_4_5 .. "," .. "RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleCtTm:" .. var_4_8 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "RoleLevelMTm:" .. var_4_15 .. "," .. "LegionLv:0,LegionLeader:0," .. "Powe:" .. var_4_16 .. "}"
	elseif g_Login.channel == EChannelType.qihoo then
		local var_4_17 = {}

		if zbUtil:isValidTable(g_Self.kFriendHandler.frienddata) then
			var_4_17 = g_Self.kFriendHandler.frienddata.FriendsList
		end

		local var_4_18 = table.getn(var_4_17)
		local var_4_19 = "["
		local var_4_20 = ","

		if zbUtil:isValidTable(var_4_17) and var_4_18 > 0 then
			for iter_4_0 = 1, var_4_18 do
				local var_4_21 = v.PlayerBaseInfo.PlayerId
				local var_4_22 = v.FriendsBaseData.Friendly

				if var_4_18 <= iter_4_0 then
					var_4_20 = ""
				end

				var_4_19 = var_4_19 .. "{roleid:" .. var_4_21 .. "," .. "intimacy:" .. var_4_22 .. "," .. "nexusid:6,nexusname:" .. a2u("\xBA\xC3\xD3\xD1") .. "}" .. var_4_20
			end
		end

		local var_4_23 = var_4_19 .. "]"

		var_4_9 = "{RoleId:" .. var_4_0 .. "," .. "RoleName:" .. var_4_1 .. "," .. "RoleLv:" .. var_4_2 .. "," .. "ZoneId:" .. var_4_3 .. "," .. "ZoneName:" .. var_4_4 .. "," .. "Profession:" .. a2u("\xCE\xDE") .. "," .. "ProfessionId:0," .. "Power:" .. g_Self:getFightValue() .. "," .. "Viplv:" .. var_4_7 .. "," .. "LegionId:" .. var_4_6 .. "," .. "LegionName:" .. var_4_5 .. "," .. "LegionRoleId:0," .. "LegionRoleName:" .. a2u("\xCE\xDE") .. "," .. "FriendData:" .. var_4_23 .. "}"
	end

	zbGlobalUtil:submitRoleData(arg_4_1, var_4_9)
end
