require("gamebase.zbFramework")
require("gamebase.zbLayout")
require("gamebase.CCBReaderLoad")
require("gamebase.zbUtil")
require("gamebase.zbFunctions")
require("gamebase.zbChannelUtil")
require("gamebase.zbChannelUtil_Report")
require("gamebase.zbChannelUtil_Login")
require("gamebase.zbChannelUtil_Pay")
require("gamecore.types")
require("gamecore.zbTypes")
require("gamecore.zbDataConfig")
require("gamecore.zbGameEventMgr")
require("gamecore.zbAudioSystem")
require("gamecore.zbAudioDefine")
require("gamecore.zbAudioDefine")
require("gamecore.zbMusicState")
require("gamecore.zbLinkHelper")
require("gamecore.zbNameHelper")
require("gamecore.zbIconHelper")
require("gamecore.zbAwardHelper")
require("gamecore.zbHeroHelper")
require("gamecore.zbFunHelper")
require("gamelogic.zbLogin")
require("gamelogic.zbGameStateMachine")
require("gamelogic.zbHttpMsgHandler")
require("gamelogic.zbWsMsgHandler")
require("gamelogic.zbMessageBox")
require("gamelogic.zbBubble")
require("gamelogic.zbBroadcast")
require("gamelogic.zbLuaErrorDialog")
require("gamelogic.zbColor")
require("gamelogic.zbUIEffect")
require("gamelogic.zbNetUrl")
require("gamelogic.zbChatHelp")
require("gamelogic.zbFirstCombat")
require("gamemain.zbGlobalVar")

game = {}

function game.startUp()
	zbGameCore:Instance():loadConfig()

	g_Layout = createLayout()
	g_LugErrorDialog = createLuaErrorDialog()
	g_HttpMsgHandler = createHttpMsgHandler()
	g_WsMsgHandler = createWsMsgHandler()
	g_DataConfig = createDataConfig()
	g_Login = createLogin()
	g_Audio = createAudioSystem()
	g_GameEventMgr = createGameEventMgr()
	g_GameStateMachine = createStateMachine()
	g_MessageBox = zbMessageBox
	g_Bubble = createBubbleInfo()
	g_Broadcast = createBroadcast()
	g_MusicState = createMusicState()
	g_NameHelper = createNameHelper()
	g_FirstCombat = createFirstCombat()
	MASK_NOMRML_TEX = CCTextureCache:sharedTextureCache():addImage("image/frame/mask_frame.jpg")

	MASK_NOMRML_TEX:retain()
	zbChannelUtil_Pay:initIOSPayCallback()

	-- [本地私服] 保留日志输出，便于排查
	v_PutoutLog = true

	echoInfo("finish create global handler")
end

function game.exit()
	g_HttpMsgHandler:free()
	g_WsMsgHandler:free()
	g_DataConfig:Free()
	g_GameStateMachine:free()
	g_Login:free()
	g_GameEventMgr:free()
	g_MessageBox:free()
	g_NameHelper:free()
	g_LugErrorDialog:free()

	g_HttpMsgHandler = nil
	g_WsMsgHandler = nil
	g_Self = nil
	g_DataConfig = nil
	g_GameStateMachine = nil
	g_GameData = nil
	g_Login = nil
	g_GameEventMgr = nil
	g_NameHelper = nil
	g_MusicState = nil
	g_LugErrorDialog = nil
end
