areaReq_url_ZB = "http://192.168.2.150:9011/?data="
loginServer_url_ZB = "http://192.168.2.150:9012"
reportgameData_ZB = "http://192.168.2.150:9006/report"
playformType_ZB = EPlatformType.Alpha
areaReq_url_Test = "http://47.93.115.92:9001/?data="
loginServer_url_Test = "http://47.93.115.92:9002"
reportgameData_Test = "http://47.93.115.92:9006/report"
playformType_Test = EPlatformType.Official
areaReq_url_TestIOS = "http://lxh-global.bjmanya.com:9001/?data="
loginServer_url_TestIOS = "http://lxh-global.bjmanya.com:9002"
reportgameData_TestIOS = "http://lxh-global.bjmanya.com:9006/report"
playformType_TestIOS = EPlatformType.Official
areaReq_url_Office = "http://47.93.115.92:9001/?data="
loginServer_url_Office = "http://47.93.115.92:9002"
reportgameData_Office = "http://47.93.115.92:9006/report"
playformType_Office = EPlatformType.Android
areaReq_url_Tencent = "http://47.93.115.92:9001/?data="
loginServer_url_Tencent = "http://47.93.115.92:9002"
reportgameData_Tencent = "http://47.93.115.92:9006/report"
playformType_Tencent = EPlatformType.Tencent
areaReq_url_IOS = "http://lxh-global.bjmanya.com:9001/?data="
loginServer_url_IOS = "http://lxh-global.bjmanya.com:9002"
reportgameData_IOS = "http://lxh-global.bjmanya.com:9006/report"
playformType_IOS = EPlatformType.IOS

if zbGlobalUtil:getTargetPlatform() == "ios" then
	g_areaReq_url = areaReq_url_IOS
	g_loginServer_url = loginServer_url_IOS
	g_reportgameData_url = reportgameData_IOS
	g_playformType = playformType_IOS
elseif zbGlobalUtil:getTargetPlatform() == "android" then
	g_areaReq_url = areaReq_url_Office
	g_loginServer_url = loginServer_url_Office
	g_reportgameData_url = reportgameData_Office
	g_playformType = playformType_Office

	if zbGlobalUtil:getChannelType() == "kaopu" then
		g_areaReq_url = areaReq_url_Tencent
		g_loginServer_url = loginServer_url_Tencent
		g_reportgameData_url = reportgameData_Tencent
		g_playformType = playformType_Tencent
	end
else
	g_areaReq_url = areaReq_url_ZB
	g_loginServer_url = loginServer_url_ZB
	g_reportgameData_url = reportgameData_ZB
	g_playformType = playformType_ZB
end

g_qihooGetUserInfo_url = g_loginServer_url .. "/user_info.php?"
g_loginServer_url = g_loginServer_url .. "/index.php?"
loginPost_url = "http://47.93.115.92:9009/user/login"
checkAccountPost_url = "http://47.93.115.92:9009/user/check_account"
verifyPost_url = "http://47.93.115.92:9009/sms/verify"
verifyPost_url_IOS = "http://47.93.115.92:9009/sms/verifyIOS"
accountBindPost_url = "http://47.93.115.92:9009/user/account_bind"
visitorPost_url = "http://47.93.115.92:9009/user/visitor"
registerPost_url = "http://47.93.115.92:9009/user/register"
findpwdBackPost_url = "http://47.93.115.92:9009/user/reset_pass"
refreshTokenPost_url = "http://47.93.115.92:9009/auth1/refresh_token"
visitorBindPost_url = "http://47.93.115.92:9009/user/visitor_bind"

if zbGlobalUtil:getTargetPlatform() == "ios" then
	loginPost_url = "http://lxh-global.bjmanya.com:9009/user/login"
	checkAccountPost_url = "http://lxh-global.bjmanya.com:9009/user/check_account"
	verifyPost_url = "http://lxh-global.bjmanya.com:9009/sms/verify"
	verifyPost_url_IOS = "http://lxh-global.bjmanya.com:9009/sms/verifyIOS"
	accountBindPost_url = "http://lxh-global.bjmanya.com:9009/user/account_bind"
	visitorPost_url = "http://lxh-global.bjmanya.com:9009/user/visitor"
	registerPost_url = "http://lxh-global.bjmanya.com:9009/user/register"
	findpwdBackPost_url = "http://lxh-global.bjmanya.com:9009/user/reset_pass"
	refreshTokenPost_url = "http://lxh-global.bjmanya.com:9009/auth1/refresh_token"
	visitorBindPost_url = "http://lxh-global.bjmanya.com:9009/user/visitor_bind"
end
