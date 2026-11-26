require("gamecore.zbAudioTouchHook")
require("gamecore.zbAudioPreLoad")

local var_0_0 = class("zbAudioSystem")

var_0_0.__index = var_0_0

local var_0_1 = SimpleAudioEngine:sharedEngine()

function createAudioSystem()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	arg_3_0.m_bMusicMute = false
	arg_3_0.m_bSoundMute = false
	arg_3_0.m_fMusicVolume = 1
	arg_3_0.m_fSoundVolume = 1
	arg_3_0.m_CurMusicName = ""

	local var_3_0 = tonumber(zbGameCore:Instance():getConfigValue(CONFIG_KEY_SETTING_MUSICMUTE)) == 1
	local var_3_1 = tonumber(zbGameCore:Instance():getConfigValue(CONFIG_KEY_SETTING_SOUNDMUTE)) == 1

	arg_3_0:setMusicMute(var_3_0)
	arg_3_0:setSoundMute(var_3_1)
	registerGlobalEventHook()

	arg_3_0.m_SoundPlayTimeTable = {}
	arg_3_0.preLoadMgr = zbAudioPreLoad:create()
end

function var_0_0.free(arg_4_0)
	arg_4_0.preLoadMgr:free()
	unregisterGlobalEventHook()

	arg_4_0.m_SoundPlayTimeTable = {}
end

function var_0_0.update(arg_5_0, arg_5_1)
	arg_5_0.preLoadMgr:update(arg_5_1)
end

function var_0_0.isMusicMute(arg_6_0)
	return arg_6_0.m_bMusicMute
end

function var_0_0.isSoundMute(arg_7_0)
	return arg_7_0.m_bSoundMute
end

function var_0_0.setMusicMute(arg_8_0, arg_8_1)
	local var_8_0 = 0

	if arg_8_1 == true then
		arg_8_0:setMusicVolume(0)

		var_8_0 = 1

		echo("zbAudioSystem:setMusicMute true")
	else
		arg_8_0:setMusicVolume(1)

		var_8_0 = 0

		echo("zbAudioSystem:setMusicMute false")
	end

	arg_8_0.m_bMusicMute = arg_8_1

	zbGameCore:Instance():setConfigValue(CONFIG_KEY_SETTING_MUSICMUTE, var_8_0)
	zbGameCore:Instance():saveConfig()
end

function var_0_0.setSoundMute(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if arg_9_1 == true then
		arg_9_0:stopAllSound()

		var_9_0 = 1

		echo("zbAudioSystem:setSoundMute true")
	else
		var_9_0 = 0

		echo("zbAudioSystem:setSoundMute false")
	end

	arg_9_0.m_bSoundMute = arg_9_1

	zbGameCore:Instance():setConfigValue(CONFIG_KEY_SETTING_SOUNDMUTE, var_9_0)
	zbGameCore:Instance():saveConfig()
end

function var_0_0.preloadMusic(arg_10_0, arg_10_1)
	var_0_1:preloadBackgroundMusic(arg_10_1)
end

function var_0_0.preloadSound(arg_11_0, arg_11_1)
	if arg_11_0.m_bSoundMute == false then
		var_0_1:preloadEffect(arg_11_1)
	end
end

function var_0_0.playMusic(arg_12_0, arg_12_1)
	local var_12_0 = true

	if arg_12_1 == AudioDefine.BGM_FIGHT_CHEER_WIN or arg_12_1 == AudioDefine.BGM_FIGHT_CHEER_LOSE or arg_12_1 == AudioDefine.BGM_FIGHT_BALANCE_WIN or arg_12_1 == AudioDefine.BGM_FIGHT_BALANCE_LOSE then
		var_12_0 = false
	end

	if arg_12_0.m_CurMusicName ~= arg_12_1 then
		echo("zbAudioSystem:playMusic: " .. arg_12_1)

		arg_12_0.m_CurMusicName = arg_12_1

		var_0_1:playBackgroundMusic(arg_12_1, var_12_0)
	end
end

function var_0_0.stopMusic(arg_13_0)
	arg_13_0.m_CurMusicName = ""

	var_0_1:stopBackgroundMusic(true)
end

function var_0_0.setMusicVolume(arg_14_0, arg_14_1)
	if arg_14_1 > 1 then
		arg_14_1 = 1
	elseif arg_14_1 < 0 then
		arg_14_1 = 0
	end

	arg_14_0.m_fMusicVolume = arg_14_1

	var_0_1:setBackgroundMusicVolume(arg_14_1)
end

function var_0_0.getMusicVolume(arg_15_0)
	arg_15_0.m_fMusicVolume = var_0_1:getBackgroundMusicVolume()

	return arg_15_0.m_fMusicVolume
end

function var_0_0.isMusicPlaying(arg_16_0)
	local var_16_0 = var_0_1:isBackgroundMusicPlaying()

	if var_16_0 ~= nil then
		return var_16_0
	else
		return false
	end
end

function var_0_0.unloadSound(arg_17_0, arg_17_1)
	var_0_1:unloadEffect(arg_17_1)
end

function var_0_0.playSound(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.m_bSoundMute == false and arg_18_1 ~= nil and arg_18_1 ~= "" then
		local var_18_0 = os_timenow()

		if arg_18_0.m_SoundPlayTimeTable[arg_18_1] == nil then
			arg_18_0.m_SoundPlayTimeTable[arg_18_1] = {}
			arg_18_0.m_SoundPlayTimeTable[arg_18_1].PlayTime = var_18_0
		elseif var_18_0 < arg_18_0.m_SoundPlayTimeTable[arg_18_1].PlayTime + 0.125 then
			return -1
		else
			arg_18_0.m_SoundPlayTimeTable[arg_18_1].PlayTime = var_18_0
		end

		if arg_18_2 ~= nil and arg_18_2 == true then
			return (var_0_1:playEffect(arg_18_1, true))
		else
			return (var_0_1:playEffect(arg_18_1, false))
		end
	end

	return -1
end

function var_0_0.stopSound(arg_19_0, arg_19_1)
	var_0_1:stopEffect(arg_19_1)
end

function var_0_0.getSoundVolume(arg_20_0)
	arg_20_0.m_fSoundVolume = var_0_1:getEffectsVolume()

	return arg_20_0.m_fSoundVolume
end

function var_0_0.setSoundVolume(arg_21_0, arg_21_1)
	if arg_21_1 > 1 then
		arg_21_1 = 1
	elseif arg_21_1 < 0 then
		arg_21_1 = 0
	end

	arg_21_0.m_fSoundVolume = arg_21_1

	var_0_1:setEffectsVolume(arg_21_1)
end

function var_0_0.stopAllSound(arg_22_0)
	var_0_1:stopAllEffects()
end
