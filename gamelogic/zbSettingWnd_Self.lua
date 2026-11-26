local var_0_0 = class("zbSettingWnd_Self")

var_0_0.__index = var_0_0

function createSettingSelfPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.lastHeadPath = ""
	end

	local function var_2_1()
		local var_4_0 = tolua.cast(arg_2_2:getChildByTag(1), "CCNode")
		local var_4_1 = tolua.cast(arg_2_2:getChildByTag(2), "CCNode")
		local var_4_2 = tolua.cast(arg_2_2:getChildByTag(3), "CCNode")

		arg_2_0.btnChangeHead = tolua.cast(var_4_0:getChildByTag(1), "CCControlButton")
		arg_2_0.spriteIcon = tolua.cast(var_4_0:getChildByTag(2), "CCSprite")
		arg_2_0.lbName = tolua.cast(var_4_0:getChildByTag(7), "CCLabelTTF")
		arg_2_0.lbAddress = tolua.cast(var_4_0:getChildByTag(1009), "CCLabelTTF")
		arg_2_0.lbLegion = tolua.cast(var_4_0:getChildByTag(1010), "CCLabelTTF")
		arg_2_0.lbId = tolua.cast(var_4_0:getChildByTag(1011), "CCLabelTTF")
		arg_2_0.lbServer = tolua.cast(var_4_0:getChildByTag(1012), "CCLabelTTF")
		arg_2_0.btnName = tolua.cast(var_4_0:getChildByTag(13), "CCControlButton")
		arg_2_0.lbLevel = tolua.cast(var_4_1:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbVip = tolua.cast(var_4_1:getChildByTag(1006), "CCLabelTTF")
		arg_2_0.lbExp = tolua.cast(var_4_1:getChildByTag(1007), "CCLabelTTF")
		arg_2_0.lbPower = tolua.cast(var_4_1:getChildByTag(1008), "CCLabelTTF")
		arg_2_0.btnHelp = tolua.cast(var_4_2:getChildByTag(1), "CCControlButton")
		arg_2_0.btnReturn = tolua.cast(var_4_2:getChildByTag(2), "CCControlButton")
		arg_2_0.btnExchange = tolua.cast(var_4_2:getChildByTag(3), "CCControlButton")
		arg_2_0.spriteSound = tolua.cast(var_4_2:getChildByTag(6), "CCSprite")
		arg_2_0.btnSound = tolua.cast(var_4_2:getChildByTag(7), "CCControlButton")
		arg_2_0.spriteMusic = tolua.cast(var_4_2:getChildByTag(8), "CCSprite")
		arg_2_0.btnMusic = tolua.cast(var_4_2:getChildByTag(9), "CCControlButton")
		arg_2_0.btnAccount = tolua.cast(var_4_2:getChildByTag(10), "CCControlButton")

		arg_2_0.btnAccount:setVisible(zbChannelUtil:isZBChannel(g_Login.channel))
		arg_2_0.btnChangeHead:addHandleOfControlEvent(function()
			arg_2_0:onChangeHead()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnName:addHandleOfControlEvent(function()
			arg_2_0:onName()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnHelp:addHandleOfControlEvent(function()
			arg_2_0:onHelp()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnReturn:addHandleOfControlEvent(function()
			arg_2_0:onReturn()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnExchange:addHandleOfControlEvent(function()
			arg_2_0:onExchange()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnSound:addHandleOfControlEvent(function()
			arg_2_0:onSound()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnMusic:addHandleOfControlEvent(function()
			arg_2_0:onMusic()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnAccount:addHandleOfControlEvent(function()
			arg_2_0:onAccount()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnHelp:setVisible(false)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_13_0)
	local var_13_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_13_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_0))
	arg_13_0.lbName:setString(a2u(g_GameData.BaseInfo.RoleName))
	arg_13_0.lbId:setString(g_GameData.BaseInfo.PlayerId)

	local var_13_1 = g_Login:getCurServer()

	if var_13_1 ~= nil then
		arg_13_0.lbServer:setString(a2u(var_13_1.ServerName))
	else
		arg_13_0.lbServer:setString(a2u("\xCE\xDE"))
	end

	arg_13_0.lbLevel:setString(g_Self:getLevel())
	arg_13_0.lbVip:setString(g_Self:getVipLevel())

	local var_13_2 = g_GameData.BaseInfo.Exp
	local var_13_3 = zbPlayerUpgradeTable:getExpNeed(g_GameData.BaseInfo.Level)

	arg_13_0.lbExp:setString(var_13_2 .. "/" .. var_13_3)
	arg_13_0.lbPower:setString(g_GameData.Formation.FV)
	arg_13_0.lbAddress:setString(a2u("\xBF\xD5"))

	if g_GameData.LegionInfo.LegionId > 0 and g_Self.kLegionHandler.legionDetail then
		arg_13_0.lbLegion:setString(a2u(g_Self.kLegionHandler.legionDetail.LegionBaseInfo.LegionName))
	else
		arg_13_0.lbLegion:setString(a2u("\xBF\xD5"))
	end

	if g_Audio:isMusicMute() then
		arg_13_0.spriteMusic:setTexture(CCTextureCache:sharedTextureCache():addImage("image/set/set_music1.png"))
	else
		arg_13_0.spriteMusic:setTexture(CCTextureCache:sharedTextureCache():addImage("image/set/set_music2.png"))
	end

	if g_Audio:isSoundMute() then
		arg_13_0.spriteSound:setTexture(CCTextureCache:sharedTextureCache():addImage("image/set/set_sound1.png"))
	else
		arg_13_0.spriteSound:setTexture(CCTextureCache:sharedTextureCache():addImage("image/set/set_sound2.png"))
	end
end

function var_0_0.onChangeHead(arg_14_0)
	g_MainScene:showChangHeadIcon():setPrevWnd(arg_14_0.parentWnd)
end

function var_0_0.onName(arg_15_0)
	g_MainScene:showChangeName(EChangeBaseInfoType.E_NAME)
end

function var_0_0.onHelp(arg_16_0)
	g_Bubble:bubbleInfo("\xB5ȴ\xFDȷ\xC8\xCFurl")
end

function var_0_0.onReturn(arg_17_0)
	g_WsMsgHandler:WS_Login_Out_Req()
	zbChannelUtil_Report:submitRoleInfoByChannel(ESubRoleInfoType.E_EXIT_GAME)
end

function var_0_0.onExchange(arg_18_0)
	g_MainScene:showChangeName(EChangeBaseInfoType.E_CODE)
end

function var_0_0.onLanguage(arg_19_0)
	return
end

function var_0_0.onSound(arg_20_0)
	g_Audio:setSoundMute(not g_Audio:isSoundMute())
	arg_20_0:refresh()
end

function var_0_0.onMusic(arg_21_0)
	g_Audio:setMusicMute(not g_Audio:isMusicMute())
	arg_21_0:refresh()
end

function var_0_0.onAccount(arg_22_0)
	g_MainScene:showAccountPopWnd()
end

function var_0_0.update(arg_23_0)
	local var_23_0 = zbGlobalUtil:getHeadPath()

	if var_23_0 ~= arg_23_0.lastHeadPath and var_23_0 ~= "" then
		arg_23_0.lastHeadPath = var_23_0

		CCTextureCache:sharedTextureCache():removeTextureForKey(var_23_0)
		arg_23_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_23_0))
		zbGlobalUtil:setHeadPath("")
	end
end
