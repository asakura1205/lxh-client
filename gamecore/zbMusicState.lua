local var_0_0 = class("zbMusicState")

var_0_0.__index = var_0_0

function createMusicState()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.free(arg_3_0)
	return
end

function var_0_0.update(arg_4_0)
	if g_GameStateMachine == nil then
		return
	end

	local var_4_0 = g_GameStateMachine:getCurrStateId()

	if var_4_0 == GameState_Invalid or var_4_0 == GameState_Logo then
		return
	end

	if var_4_0 == GameState_Login then
		g_Audio:playMusic(AudioDefine.BGM_LOGIN)

		return
	end

	if var_4_0 == GameState_Scene then
		if g_MainScene:isWndVisible(g_MainScene.wndLoading) then
			g_Audio:playMusic(AudioDefine.BGM_LOGIN)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndWawaji) then
			g_Audio:playMusic(AudioDefine.BGM_LOGIN)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndGuideYeyejia) then
			g_Audio:playMusic(AudioDefine.BGM_WORLD)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndGuideWorldVideo) then
			g_Audio:playMusic(AudioDefine.BGM_PUB)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndPub) then
			g_Audio:playMusic(AudioDefine.BGM_PUB)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndWorld) then
			g_Audio:playMusic(AudioDefine.BGM_WORLD)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndBalanceWin) then
			g_Audio:playMusic(AudioDefine.BGM_FIGHT_BALANCE_WIN)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndBalanceLose) then
			g_Audio:playMusic(AudioDefine.BGM_FIGHT_BALANCE_LOSE)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndCombat) then
			if g_Audio.m_CurMusicName == AudioDefine.BGM_FIGHT or g_Audio.m_CurMusicName == AudioDefine.BGM_FIGHT_CHEER_WIN or g_Audio.m_CurMusicName == AudioDefine.BGM_FIGHT_CHEER_LOSE then
				return
			end

			g_Audio:playMusic(AudioDefine.BGM_FIGHT)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndWarPath) or g_MainScene:isWndVisible(g_MainScene.wndWarForce) or g_MainScene:isWndVisible(g_MainScene.wndEmbattle) then
			g_Audio:playMusic(AudioDefine.BGM_WORLD)

			return
		end

		if g_MainScene:isWndVisible(g_MainScene.wndFormation) then
			return
		end

		g_Audio:playMusic(AudioDefine.BGM_CITY)
	end
end
