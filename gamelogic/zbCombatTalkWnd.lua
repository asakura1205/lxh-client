require("gamelogic.zbBaseWnd")

zbCombatTalkWnd = class("zbCombatTalkWnd", zbBaseWnd)
zbCombatTalkWnd.__index = zbCombatTalkWnd

local var_0_0 = 1
local var_0_1 = 2
local var_0_2 = 0
local var_0_3 = 100
local var_0_4 = 101

function zbCombatTalkWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCombatTalkWnd)

	return arg_1_0
end

function createCombatTalkWnd()
	local var_2_0 = zbCombatTalkWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbCombatTalkWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.talkData = nil
		arg_3_0.curSection = 0
		arg_3_0.curRound = 0
		arg_3_0.curStep = 0
		arg_3_0.talkedRounds = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/combat_talk.ccbi", var_5_0, true, "")

		arg_3_0.layerBlack = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		arg_3_0.layerLeft = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.layerRight = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(4), "CCControlButton")
		arg_3_0.leftHero = tolua.cast(arg_3_0.layerLeft:getChildByTag(1), "CCSprite")
		arg_3_0.leftDescBg = tolua.cast(arg_3_0.layerLeft:getChildByTag(2), "CCSprite")
		arg_3_0.leftDesc = tolua.cast(arg_3_0.layerLeft:getChildByTag(3), "CCLabelTTF")
		arg_3_0.leftName = tolua.cast(arg_3_0.layerLeft:getChildByTag(4), "CCLabelTTF")
		arg_3_0.rightHero = tolua.cast(arg_3_0.layerRight:getChildByTag(1), "CCSprite")
		arg_3_0.rightDescBg = tolua.cast(arg_3_0.layerRight:getChildByTag(2), "CCSprite")
		arg_3_0.rightDesc = tolua.cast(arg_3_0.layerRight:getChildByTag(3), "CCLabelTTF")
		arg_3_0.rightName = tolua.cast(arg_3_0.layerRight:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnTouch:setSoundTag(SOUNDTAG_GUIDE)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbCombatTalkWnd.isHasShowLevelTalk(arg_7_0)
	if g_FirstCombat:isActive() then
		return false
	end

	local var_7_0 = g_MainScene.wndEmbattle

	if var_7_0 ~= nil and var_7_0.battleMode == EMBATTLE_TYPE_LEVEL and (var_7_0.levelType == ELevelType.Nightmare or var_7_0.levelType == ELevelType.Elite or g_Self.kWarPathHandler:getLevelStar(var_7_0.levelType, var_7_0.forceId, var_7_0.levelId) > 0) then
		return true
	end

	return false
end

function zbCombatTalkWnd.start(arg_8_0, arg_8_1)
	arg_8_0.curSection = 0
	arg_8_0.curRound = 0
	arg_8_0.curStep = 0
	arg_8_0.talkedRounds = {}

	if arg_8_0:isHasShowLevelTalk() then
		arg_8_0:popupCombatWnd()

		return
	end

	if arg_8_0:checkBossShow(arg_8_1, var_0_2) then
		return
	end

	arg_8_0.talkData = g_DataConfig:getCombatTalk(g_CombatSystem.combatTalkId)

	if arg_8_0.talkData == nil then
		arg_8_0:popupCombatWnd()

		return
	end

	arg_8_0.layerLeft:setVisible(false)
	arg_8_0.layerRight:setVisible(false)
	arg_8_0:goto(arg_8_1, var_0_2, 1)
end

function zbCombatTalkWnd.newRound(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.talkedRounds[arg_9_2] ~= nil then
		arg_9_0:popupCombatWnd()

		return false
	end

	if arg_9_0:isHasShowLevelTalk() then
		arg_9_0:popupCombatWnd()

		return false
	end

	arg_9_0.talkData = g_DataConfig:getCombatTalk(g_CombatSystem.combatTalkId)

	if arg_9_0.talkData == nil then
		arg_9_0:popupCombatWnd()

		return false
	end

	arg_9_0.talkedRounds[arg_9_2] = 1

	arg_9_0.layerLeft:setVisible(false)
	arg_9_0.layerRight:setVisible(false)

	return arg_9_0:goto(arg_9_1, arg_9_2, 1)
end

function zbCombatTalkWnd.checkBossShow(arg_10_0, arg_10_1, arg_10_2)
	if g_CombatSystem.combatData:getLevelType() == ELevelType.Normal then
		local var_10_0 = zbForceSetTable:getRecord(g_CombatSystem.combatData:getLevelId())

		if var_10_0 ~= nil and var_10_0.showBoss then
			local var_10_1 = g_CombatSystem.combatData:getBossHero()

			if var_10_1 ~= nil then
				arg_10_0:hide()
				g_MainScene:showShowNewBossWnd(var_10_1.heroRecord.id, arg_10_1, arg_10_2)

				return true
			end
		end
	end

	return false
end

function zbCombatTalkWnd.finish(arg_11_0)
	arg_11_0.layerLeft:setVisible(false)
	arg_11_0.layerRight:setVisible(false)

	if arg_11_0:isHasShowLevelTalk() then
		arg_11_0:popupCombatWnd()

		return
	end

	arg_11_0.talkData = g_DataConfig:getCombatTalk(g_CombatSystem.combatTalkId)

	if arg_11_0.talkData == nil then
		arg_11_0:popupCombatWnd()

		return
	end

	if g_CombatSystem.combatResult.result >= EBattleResult.Win1 then
		arg_11_0:goto(1, var_0_3, 1)
	else
		arg_11_0:popupCombatWnd()
	end
end

function zbCombatTalkWnd.getTalkRoundData(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.talkData == nil then
		return nil
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.talkData) do
		if iter_12_1.section ~= nil and iter_12_1.section == arg_12_1 and iter_12_1.triggerRound == arg_12_2 or iter_12_1.triggerRound == arg_12_2 and (arg_12_2 == var_0_3 or arg_12_2 == var_0_4) then
			return iter_12_1
		end
	end

	return nil
end

function zbCombatTalkWnd.goto(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local function var_13_0(arg_14_0)
		if a2u(arg_14_0) == a2u("\xCD\xE6\xBC\xD2") or a2u(arg_14_0) == a2u("\xD6\xF7\xBD\xC7") then
			return g_Self:getName()
		else
			return arg_14_0
		end
	end

	local function var_13_1(arg_15_0, arg_15_1)
		if a2u(arg_15_0) == a2u("\xCD\xE6\xBC\xD2") or a2u(arg_15_0) == a2u("\xD6\xF7\xBD\xC7") then
			return g_Self:getAvatarId()
		else
			return arg_15_1
		end
	end

	arg_13_0.curSection = arg_13_1
	arg_13_0.curRound = arg_13_2
	arg_13_0.curStep = arg_13_3

	local var_13_2 = arg_13_0:getTalkRoundData(arg_13_0.curSection, arg_13_0.curRound)

	if var_13_2 == nil then
		arg_13_0:popupCombatWnd()

		return false
	end

	local var_13_3 = var_13_2.content[arg_13_0.curStep]

	if var_13_3 == nil then
		arg_13_0:popupCombatWnd()

		return false
	end

	local function var_13_4(arg_16_0)
		local var_16_0 = string.gsub(arg_16_0, "%[color=0x[%a%d]+%]", "")
		local var_16_1 = string.gsub(var_16_0, "%[/color%]", "")

		return (string.gsub(var_16_1, a2u("\xCD\xE6\xBC\xD2"), a2u(g_Self:getName())))
	end

	local function var_13_5(arg_17_0)
		if arg_17_0 == 0 then
			return g_Self:getAvatarId()
		else
			return arg_17_0
		end
	end

	local function var_13_6(arg_18_0)
		if arg_18_0 == 1234560 then
			return "image/icon/herotalk/zj.png"
		else
			return zbIconHelper:getHeroTalkIconPath(arg_18_0)
		end
	end

	if var_13_3.dir == var_0_0 then
		arg_13_0.layerRight:setZOrder(101)
		arg_13_0.layerBlack:setZOrder(100)
		arg_13_0.layerLeft:setZOrder(102)
		print("--------------------")
		arg_13_0.layerLeft:setVisible(true)
		arg_13_0.leftDescBg:setVisible(true)
		arg_13_0.leftName:setVisible(true)
		arg_13_0.leftDesc:setVisible(true)
		arg_13_0.leftHero:setVisible(true)
		arg_13_0.layerRight:setVisible(false)
		arg_13_0.rightDescBg:setVisible(false)
		arg_13_0.rightDesc:setVisible(false)

		local var_13_7 = var_13_5(var_13_3.avatarId)
		local var_13_8 = var_13_6(var_13_7)

		arg_13_0.leftHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_8))
		arg_13_0.leftName:setString((var_13_0(var_13_3.name)))

		local var_13_9 = var_13_4(var_13_3.desc)

		arg_13_0.leftDesc:setString(a2u(var_13_9))
	else
		arg_13_0.layerLeft:setZOrder(101)
		arg_13_0.layerBlack:setZOrder(100)
		arg_13_0.layerRight:setZOrder(102)
		arg_13_0.layerRight:setVisible(true)
		arg_13_0.rightDescBg:setVisible(true)
		arg_13_0.rightName:setVisible(true)
		arg_13_0.rightDesc:setVisible(true)
		arg_13_0.rightHero:setVisible(true)
		arg_13_0.layerLeft:setVisible(false)
		arg_13_0.leftDescBg:setVisible(false)
		arg_13_0.leftDesc:setVisible(false)

		local var_13_10 = var_13_5(var_13_3.avatarId)
		local var_13_11 = var_13_6(var_13_10)

		arg_13_0.rightHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_11))
		arg_13_0.rightName:setString((var_13_0(var_13_3.name)))

		local var_13_12 = var_13_4(var_13_3.desc)

		arg_13_0.rightDesc:setString(a2u(var_13_12))
	end

	local var_13_13 = CCArray:create()

	var_13_13:addObject(CCDelayTime:create(1.5))
	var_13_13:addObject(CCCallFuncN:create(function()
		arg_13_0:stepEndCallback()
	end))

	local var_13_14 = CCSequence:create(var_13_13)

	arg_13_0:stopAllActions()
	arg_13_0:runAction(var_13_14)
	arg_13_0:popupTalkWnd()

	return true
end

function zbCombatTalkWnd.stepEndCallback(arg_20_0)
	local var_20_0 = arg_20_0:getTalkRoundData(arg_20_0.curSection, arg_20_0.curRound)

	if var_20_0 == nil then
		return
	end

	if var_20_0.content[arg_20_0.curStep] == nil then
		return
	end

	if arg_20_0.curStep > table.getn(var_20_0.content) then
		arg_20_0:popupCombatWnd()
	end
end

function zbCombatTalkWnd.nextStep(arg_21_0)
	arg_21_0:goto(arg_21_0.curSection, arg_21_0.curRound, arg_21_0.curStep + 1)
end

function zbCombatTalkWnd.popupCombatWnd(arg_22_0)
	if g_FirstCombat:isActive() and g_FirstCombat:roundTalkEnd(arg_22_0.curRound) then
		return
	end

	arg_22_0:hide()
	g_CombatSystem:resume()
	g_MainScene.wndCombat:showUI()

	if g_CombatStateMachine:getCurrStateId() == CombatState_Finish then
		g_CombatStateMachine:getCurrState():talkOver()
	end
end

function zbCombatTalkWnd.popupTalkWnd(arg_23_0)
	g_CombatSystem:pause()
	g_MainScene.wndCombat:hideUI()
	arg_23_0:show()
end

function zbCombatTalkWnd.onTouch(arg_24_0)
	arg_24_0:nextStep()
end
