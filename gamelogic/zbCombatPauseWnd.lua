require("gamelogic.zbBaseWnd")
require("gamecore.zbCombatSystem")

zbCombatPauseWnd = class("zbCombatPauseWnd", zbBaseWnd)
zbCombatPauseWnd.__index = zbCombatPauseWnd

function zbCombatPauseWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCombatPauseWnd)

	return arg_1_0
end

function createCombatPauseWnd()
	local var_2_0 = zbCombatPauseWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbCombatPauseWnd.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/combat_pause.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnExit = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")
		arg_3_0.btnMusic = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.lbMusicTip = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnSound = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.lbSoundTip = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnShake = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")
		arg_3_0.lbShakeTip = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.btnResume = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")

		arg_3_0.btnExit:addHandleOfControlEvent(function()
			arg_3_0:onExit()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMusic:addHandleOfControlEvent(function()
			arg_3_0:onMusic()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSound:addHandleOfControlEvent(function()
			arg_3_0:onSound()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnResume:addHandleOfControlEvent(function()
			arg_3_0:onResume()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnShake:addHandleOfControlEvent(function()
			arg_3_0:onShake()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)

		local var_5_3 = "image/combat/battleui/pausewnd/exit_normal.png"

		zbUtil:setHighlightSprite(arg_3_0.btnExit, var_5_3)
		zbUtil:setDisableSprite(arg_3_0.btnExit, var_5_3)

		local var_5_4 = "image/combat/battleui/pausewnd/resume_normal.png"

		zbUtil:setHighlightSprite(arg_3_0.btnResume, var_5_4)
		zbUtil:setDisableSprite(arg_3_0.btnResume, var_5_4)
	end

	var_3_0()
	var_3_1()
end

function zbCombatPauseWnd.refresh(arg_11_0)
	arg_11_0:refreshSoundTex()
	arg_11_0:refreshMusicTex()
	g_CombatSystem:pause()
end

function zbCombatPauseWnd.onExit(arg_12_0)
	arg_12_0:hide()
	g_CombatSystem:resume()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_CombatSystem.combatType == COMBAT_TYPE_OCCUPY_CITY then
		g_Self.kWorldHandler:openWorld()

		return
	elseif g_CombatSystem.combatType == COMBAT_TYPE_LEGIONBATTLE then
		if g_GameData.LegionId > 0 then
			g_NetMsgHandler:LegionInfo_Req()
		else
			g_MainScene:showLegionNoJoinWnd()
		end

		return
	end

	if g_CombatSystem.combatType ~= COMBAT_TYPE_ARENARECORD and g_MainScene.wndEmbattle then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end
end

function zbCombatPauseWnd.onResume(arg_13_0)
	g_CombatSystem:resume()
	arg_13_0:hide()
end

function zbCombatPauseWnd.onMusic(arg_14_0)
	g_Audio:setMusicMute(not g_Audio:isMusicMute())
	arg_14_0:refreshMusicTex()
end

function zbCombatPauseWnd.refreshMusicTex(arg_15_0)
	if g_Audio:isMusicMute() then
		require("gamebase.zbUI"):setButtonPic(arg_15_0.btnMusic, "image/combat/battleui/pausewnd/music_off.png", "image/combat/battleui/pausewnd/music_on.png")
		arg_15_0.lbMusicTip:setString(a2u("\xD2\xF4\xC0\xD6:\xB9\xD8"))
	else
		require("gamebase.zbUI"):setButtonPic(arg_15_0.btnMusic, "image/combat/battleui/pausewnd/music_on.png", "image/combat/battleui/pausewnd/music_off.png")
		arg_15_0.lbMusicTip:setString(a2u("\xD2\xF4\xC0\xD6:\xBF\xAA"))
	end
end

function zbCombatPauseWnd.onSound(arg_16_0)
	g_Audio:setSoundMute(not g_Audio:isSoundMute())
	arg_16_0:refreshSoundTex()
end

function zbCombatPauseWnd.refreshSoundTex(arg_17_0)
	if g_Audio:isSoundMute() then
		require("gamebase.zbUI"):setButtonPic(arg_17_0.btnSound, "image/combat/battleui/pausewnd/sound_off.png", "image/combat/battleui/pausewnd/sound_on.png")
		arg_17_0.lbSoundTip:setString(a2u("\xD2\xF4Ч:\xB9\xD8"))
	else
		require("gamebase.zbUI"):setButtonPic(arg_17_0.btnSound, "image/combat/battleui/pausewnd/sound_on.png", "image/combat/battleui/pausewnd/sound_off.png")
		arg_17_0.lbSoundTip:setString(a2u("\xD2\xF4Ч:\xBF\xAA"))
	end
end

function zbCombatPauseWnd.onShake(arg_18_0)
	g_EffectSystem.cameraShake:setEnable(not g_EffectSystem.cameraShake:isEnable())
	arg_18_0:refreshShakeTex()
end

function zbCombatPauseWnd.refreshShakeTex(arg_19_0)
	if g_EffectSystem.cameraShake:isEnable() then
		require("gamebase.zbUI"):setButtonPic(arg_19_0.btnShake, "image/combat/battleui/pausewnd/shake_off.png", "image/combat/battleui/pausewnd/shake_on.png")
		arg_19_0.lbShakeTip:setString(a2u("\xB6\xB6\xB6\xAF:\xBF\xAA"))
	else
		require("gamebase.zbUI"):setButtonPic(arg_19_0.btnShake, "image/combat/battleui/pausewnd/shake_on.png", "image/combat/battleui/pausewnd/shake_off.png")
		arg_19_0.lbShakeTip:setString(a2u("\xB6\xB6\xB6\xAF:\xB9\xD8"))
	end
end
