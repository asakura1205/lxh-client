require("gamebase.zbFunctions")
require("gamecore.zbHero")

zbCombatHeroUI = class("zbCombatHeroUI", CCNodeExtend)
zbCombatHeroUI.__index = zbCombatHeroUI

function zbCombatHeroUI.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCombatHeroUI)

	return arg_1_0
end

function zbCombatHeroUI.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbCombatHeroUI.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbCombatHeroUI.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.hero = nil
		arg_3_0.index = arg_3_2
		arg_3_0.record = nil
		arg_3_0.lastHpPercent = 0
		arg_3_0.lastMpPercent = 0
		arg_3_0.lastEnergy = 0
		arg_3_0.fingerActionCreate = false
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteProgressHpBg = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.spriteProgressMpBg = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.spriteWarning = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.spriteMpFull = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(var_5_0:getChildByTag(1007), "CCLabelTTF")
		arg_3_0.qualityRoot = tolua.cast(var_5_0:getChildByTag(8), "CCNode")
		arg_3_0.nodeEnergy = tolua.cast(var_5_0:getChildByTag(9), "CCNode")
		arg_3_0.nodeFinger = tolua.cast(var_5_0:getChildByTag(21), "CCNode")
		arg_3_0.nodeDialog = tolua.cast(var_5_0:getChildByTag(22), "CCNode")
		arg_3_0.spriteFinger = tolua.cast(arg_3_0.nodeFinger:getChildByTag(1), "CCSprite")
		arg_3_0.spriteEnergy = tolua.cast(arg_3_0.nodeEnergy:getChildByTag(1), "CCSprite")
		arg_3_0.spriteEnergyHalo = tolua.cast(arg_3_0.nodeEnergy:getChildByTag(2), "CCSprite")
		arg_3_0.lbEnergyCount = tolua.cast(arg_3_0.nodeEnergy:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.spriteStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.spriteStars[iter_5_0] = arg_3_0.qualityRoot:getChildByTag(iter_5_0)
		end

		arg_3_0.progressTimerHp = zbUtil:createProgressTimer(arg_3_0.spriteProgressHpBg, "image/combat/battleui/progress_red.png")
		arg_3_0.progressTimerMp = zbUtil:createProgressTimer(arg_3_0.spriteProgressMpBg, "image/combat/battleui/progress_yellow.png")

		local var_5_1 = CCArray:create()

		var_5_1:addObject(CCFadeTo:create(0.4, 255))
		var_5_1:addObject(CCFadeTo:create(0.4, 20))

		local var_5_2 = CCSequence:create(var_5_1)
		local var_5_3 = CCSequence:create(var_5_1)

		arg_3_0.spriteWarning:stopAllActions()
		arg_3_0.spriteMpFull:stopAllActions()
		arg_3_0.spriteWarning:runAction(CCRepeatForever:create(var_5_2))
		arg_3_0.spriteMpFull:runAction(CCRepeatForever:create(var_5_3))
		arg_3_0.btnFrame:setSoundTag(SOUNDTAG_NOSOUND)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.fxMpHalo = createUIAnimation()

		arg_3_0.fxMpHalo:refreshBone("effect/spine/ui_nuqizhiman/ui_nuqizhiman")
		arg_3_0.fxMpHalo:setPosition(58, 89)
		var_5_0:addChild(arg_3_0.fxMpHalo)

		arg_3_0.fxExec = createUIAnimation()

		arg_3_0.fxExec:refreshBone("effect/spine/ui_jinengshifang/ui_jinengshifang")
		arg_3_0.fxExec:setPosition(58, 89)
		arg_3_0.fxExec:setVisible(false)
		var_5_0:addChild(arg_3_0.fxExec)
		arg_3_0.nodeFinger:setVisible(false)
		arg_3_0.nodeDialog:setVisible(false)
		arg_3_0.nodeFinger:setZOrder(ZORDER_TOP)
		arg_3_0.nodeDialog:setZOrder(ZORDER_TOP)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function zbCombatHeroUI.createFingerMoveAction(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0.4
	local var_7_1 = 8
	local var_7_2 = ccp(arg_7_2.x - var_7_1, arg_7_2.y + var_7_1)
	local var_7_3 = CCMoveTo:create(var_7_0, var_7_2)

	var_7_2.x = arg_7_2.x + var_7_1
	var_7_2.y = arg_7_2.y - var_7_1

	local var_7_4 = CCMoveTo:create(var_7_0, var_7_2)
	local var_7_5 = CCArray:create()

	var_7_5:addObject(var_7_3)
	var_7_5:addObject(CCDelayTime:create(0.1))
	var_7_5:addObject(var_7_4)

	local var_7_6 = CCSequence:create(var_7_5)

	arg_7_1:stopAllActions()
	arg_7_1:runAction(CCRepeatForever:create(var_7_6))
end

function zbCombatHeroUI.refresh(arg_8_0)
	arg_8_0.record = nil
	arg_8_0.hero = g_CombatSystem:getHero(g_CombatSystem:getMyForceType(), arg_8_0.index)

	if arg_8_0.hero == nil then
		arg_8_0:setVisible(false)

		return
	end

	arg_8_0.lastHp = 0
	arg_8_0.lastMp = 0
	arg_8_0.record = zbHeroTable:getRecord(arg_8_0.hero:getTemplateId())

	local var_8_0 = arg_8_0.hero:getLevel()
	local var_8_1 = arg_8_0.hero:getStar()
	local var_8_2 = arg_8_0.hero:getQuality()

	if g_FirstCombat:isActive() then
		var_8_0 = 60
		var_8_1 = 5
		var_8_2 = 11
	end

	local var_8_3 = zbColor:getHeroFrameTex(var_8_2)
	local var_8_4 = zbIconHelper:getHeroIconPath(arg_8_0.hero:getTemplateId())

	require("gamebase.zbUI"):setButtonPic(arg_8_0.btnFrame, var_8_3, var_8_3, var_8_3)
	arg_8_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_4))
	arg_8_0.lbLevel:setString(var_8_0)
	zbUIEffect:centerHeroStar(arg_8_0.spriteStars, var_8_1)
	arg_8_0:setVisible(arg_8_0.hero ~= nil)
	arg_8_0:refreshEnergy()
	arg_8_0:update()
end

function zbCombatHeroUI.refreshEnergy(arg_9_0)
	arg_9_0.lastEnergy = arg_9_0.hero.energy.count

	arg_9_0.nodeEnergy:setVisible(arg_9_0.hero.energy.visible)

	if arg_9_0.hero.energy.visible then
		arg_9_0.spriteEnergy:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_9_0.hero.energy.texturePath))
		arg_9_0.spriteEnergyHalo:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_9_0.hero.energy.textureHaloPath))
		arg_9_0.spriteEnergyHalo:setVisible(false)

		arg_9_0.lastEnergy = arg_9_0.hero.energy.count
	end

	arg_9_0:updateEnergy()
end

function zbCombatHeroUI.updateEnergy(arg_10_0)
	if arg_10_0.hero.energy.visible then
		arg_10_0.lbEnergyCount:setString("X" .. arg_10_0.hero.energy.count)

		if arg_10_0.hero.energy.count > arg_10_0.lastEnergy then
			arg_10_0:haloEnergyTip(arg_10_0.spriteEnergyHalo)

			arg_10_0.lastEnergy = arg_10_0.hero.energy.count
		end
	end
end

function zbCombatHeroUI.haloEnergyTip(arg_11_0, arg_11_1)
	local function var_11_0(arg_12_0)
		arg_12_0:setVisible(false)
	end

	arg_11_1:setVisible(true)
	arg_11_1:setCascadeOpacityEnabled(true)

	local var_11_1 = CCArray:create()

	var_11_1:addObject(CCFadeIn:create(0.5))
	var_11_1:addObject(CCFadeOut:create(0.5))
	var_11_1:addObject(CCCallFuncN:create(function()
		var_11_0(arg_11_1)
	end))

	local var_11_2 = CCSequence:create(var_11_1)

	arg_11_1:stopAllActions()
	arg_11_1:runAction(var_11_2)
end

function zbCombatHeroUI.update(arg_14_0)
	if arg_14_0.hero == nil then
		return
	end

	local var_14_0 = arg_14_0:isGray()
	local var_14_1 = arg_14_0.hero:isDie()

	if var_14_0 ~= var_14_1 then
		arg_14_0:setGray(var_14_1)

		local var_14_2 = arg_14_0.hero:getStar()

		zbUIEffect:centerHeroStar(arg_14_0.spriteStars, var_14_2)
	end

	local var_14_3 = arg_14_0.hero:getHpPercent()
	local var_14_4 = arg_14_0.hero:getMpPercent()

	if arg_14_0.lastHpPercent ~= var_14_3 then
		arg_14_0.progressTimerHp:runAction(CCProgressFromTo:create(0.35, arg_14_0.lastHpPercent, arg_14_0.hero:getHpPercent()))

		arg_14_0.lastHpPercent = var_14_3
	end

	if arg_14_0.lastMpPercent ~= var_14_4 then
		arg_14_0.progressTimerMp:runAction(CCProgressFromTo:create(0.35, arg_14_0.lastMpPercent, arg_14_0.hero:getMpPercent()))

		arg_14_0.lastMpPercent = var_14_4
	end

	local var_14_5 = arg_14_0:canTouch()
	local var_14_6 = arg_14_0.fxMpHalo:isVisible()

	arg_14_0.fxMpHalo:setVisible(var_14_5)
	arg_14_0.spriteMpFull:setVisible(arg_14_0.fxMpHalo:isVisible())
	arg_14_0.spriteWarning:setVisible(arg_14_0.hero:isDie() == false and arg_14_0.hero:getHpPercent() <= 30)

	if var_14_6 == false and arg_14_0.fxMpHalo:isVisible() == true then
		g_Audio:playSound(AudioDefine.UI_BATTLE_MPFULL)
		arg_14_0.fxMpHalo:setAnimation("animation", true)
	end

	arg_14_0:updateEnergy()
	arg_14_0:updateFinger()
end

function zbCombatHeroUI.updateFinger(arg_15_0)
	local var_15_0 = arg_15_0.hero.showMpFinger and arg_15_0:canTouch()

	if arg_15_0.nodeFinger:isVisible() == false and var_15_0 then
		arg_15_0.spriteFinger:setCascadeOpacityEnabled(true)
		arg_15_0.spriteFinger:setOpacity(0)
		arg_15_0.spriteFinger:stopAllActions()
		arg_15_0.spriteFinger:runAction(CCFadeIn:create(0.3))
	end

	arg_15_0.nodeFinger:setVisible(var_15_0)
	arg_15_0.nodeDialog:setVisible(var_15_0)

	if arg_15_0.nodeFinger:isVisible() and arg_15_0.fingerActionCreate == false then
		arg_15_0:createFingerMoveAction(arg_15_0.nodeFinger, ccp(arg_15_0.nodeFinger:getPosition()))

		arg_15_0.fingerActionCreate = true
	end
end

function zbCombatHeroUI.onTouch(arg_16_0)
	if arg_16_0:canTouch() == false then
		return
	end

	arg_16_0.hero:checkAndExecBigSkill()
	arg_16_0.fxExec:setVisible(true)
	arg_16_0.fxExec:setAnimation("animation", false)

	if arg_16_0.hero.showMpFinger then
		g_CombatSystem:resume()

		arg_16_0.hero.showMpFinger = false
	end
end

function zbCombatHeroUI.getFlipPlayer(arg_17_0)
	if arg_17_0.hero.forceType == ForceType.Left then
		return g_CombatSystem.combatData.rightPlayer
	else
		return g_CombatSystem.combatData.leftPlayer
	end
end

function zbCombatHeroUI.canTouch(arg_18_0)
	if g_CombatSystem:isPvPCombatType() then
		return false
	end

	if arg_18_0.hero == nil then
		return false
	end

	if arg_18_0.hero:isDie() then
		return false
	end

	if arg_18_0.hero:getMpPercent() < 100 then
		return false
	end

	if arg_18_0.hero:isChenmo() or arg_18_0.hero:isHunmi() or arg_18_0.hero:isMeihuo() then
		return false
	end

	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return false
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return
	end

	if arg_18_0:getFlipPlayer():getCurTotalHp() <= 0 then
		return false
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		return
	end

	if g_CombatSystem.combatData.combatQte:getQteTarget() ~= nil then
		return false
	end

	return arg_18_0.hero:getMpPercent() >= 100
end
