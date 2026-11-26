require("gamelogic.zbBaseWnd")
require("gamelogic.zbCombatHeroUI")
require("gamelogic.zbCombatEnergyBall")
require("gamecore.zbCombatScene")
require("gamecore.zbFormationHelper")
require("gamecore.zbFormationBubble")
require("gamelogic.zbPataBuffTxt")
require("gamelogic.zbBulletScreenContent")

zbCombatWnd = class("zbCombatWnd", zbBaseWnd)
zbCombatWnd.__index = zbCombatWnd
COMBAT_QTE_CIRCLE_TIME = 1.2

function createCombatWnd()
	local var_1_0 = zbCombatWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbCombatWnd.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbCombatWnd)

	return arg_2_0
end

function zbCombatWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroUIList = {}
		arg_3_0.bulletItem = {}
		arg_3_0.bulletEnd = false
		arg_3_0.autoSectionKey = g_Login.account .. "_" .. g_Login.lastServerId .. "_autocombat"
		arg_3_0.energyBallList = {}
		arg_3_0.lastEnergyPercent = -1
		arg_3_0.lastWarningVisible = false
		arg_3_0.leftFormationId = -1
		arg_3_0.rightFormationId = -1
		arg_3_0.leftFormationLevel = 0
		arg_3_0.rightFormationLevel = 0
		arg_3_0.myFormationId = -1
		arg_3_0.enemyFormationId = -1
		arg_3_0.myFormationLevel = 0
		arg_3_0.enemyFormationLevel = 0
		arg_3_0.lastBossHp1Percent = 0
		arg_3_0.lastBossHp2Percent = 0
		arg_3_0.lastBossHpPercent = {
			100,
			100,
			100,
			100,
			100
		}
		arg_3_0.popPanelOver = false
		arg_3_0.strCombatSpeed = "CombatSpeed_" .. g_GameData.BaseInfo.PlayerId
		arg_3_0.strBulletList = "BulletList" .. g_GameData.BaseInfo.PlayerId

		local var_4_0 = COMBAT_SPEED_10
		local var_4_1 = zbGameCore:Instance():getConfigValue(arg_3_0.strCombatSpeed)

		if var_4_1 == "" then
			var_4_0 = COMBAT_SPEED_10
		elseif var_4_1 == "1" then
			var_4_0 = COMBAT_SPEED_10
		elseif var_4_1 == "2" then
			var_4_0 = COMBAT_SPEED_15
		elseif var_4_1 == "3" then
			var_4_0 = COMBAT_SPEED_20
		end

		g_CombatSystem:setSpeed(var_4_0)

		arg_3_0.lastSpeed = g_CombatSystem:getSpeed()
		arg_3_0.buffItems = {}
		arg_3_0.lastFxShowTime = os_timenow()
		arg_3_0.initPos = {}
		arg_3_0.attrLbList = {}
		arg_3_0.bulletLine = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/combat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.spritePreload = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeLeftShape = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.spriteLeftShape = tolua.cast(arg_3_0.nodeLeftShape:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLeftShapeName = tolua.cast(arg_3_0.spriteLeftShape:getChildByTag(1), "CCSprite")
		arg_3_0.nodeRightShape = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.spriteRightShape = tolua.cast(arg_3_0.nodeRightShape:getChildByTag(1), "CCSprite")
		arg_3_0.spriteRightShapeName = tolua.cast(arg_3_0.spriteRightShape:getChildByTag(1), "CCSprite")
		arg_3_0.shapeLeftBubble = zbFormationBubble:create()

		arg_3_0.nodeLeftShape:addChild(arg_3_0.shapeLeftBubble)

		arg_3_0.shapeRightBubble = zbFormationBubble:create()

		arg_3_0.nodeRightShape:addChild(arg_3_0.shapeRightBubble)

		arg_3_0.layerWarning = tolua.cast(var_5_1:getChildByTag(4), "CCSprite")
		arg_3_0.layerUIConsole = tolua.cast(var_5_1:getChildByTag(5), "CCNode")
		arg_3_0.layerUIRound = tolua.cast(var_5_1:getChildByTag(6), "CCNode")
		arg_3_0.layerUIAutoFight = tolua.cast(var_5_1:getChildByTag(7), "CCNode")
		arg_3_0.layerUILegend = tolua.cast(var_5_1:getChildByTag(8), "CCNode")
		arg_3_0.layerRecord = tolua.cast(var_5_1:getChildByTag(9), "CCNode")
		arg_3_0.layerFormation = tolua.cast(var_5_1:getChildByTag(10), "CCNode")
		arg_3_0.layerBoss = tolua.cast(var_5_1:getChildByTag(11), "CCNode")
		arg_3_0.spriteBossWarning = tolua.cast(var_5_1:getChildByTag(12), "CCSprite")
		arg_3_0.layerMuilt = tolua.cast(var_5_1:getChildByTag(13), "CCNode")
		arg_3_0.layerOpenBulllet = tolua.cast(var_5_1:getChildByTag(14), "CCNode")
		arg_3_0.layerSendBulllet = tolua.cast(var_5_1:getChildByTag(15), "CCNode")
		arg_3_0.layerFocus = tolua.cast(var_5_1:getChildByTag(16), "CCNode")
		arg_3_0.layerBuffList = tolua.cast(var_5_1:getChildByTag(17), "CCNode")
		arg_3_0.layerTarget = tolua.cast(var_5_1:getChildByTag(18), "CCNode")
		arg_3_0.layerQte = tolua.cast(var_5_1:getChildByTag(19), "CCNode")
		arg_3_0.layerQteEval = tolua.cast(var_5_1:getChildByTag(20), "CCNode")
		arg_3_0.layerQteCombo = tolua.cast(var_5_1:getChildByTag(21), "CCSprite")
		arg_3_0.layerReadyStart = tolua.cast(var_5_1:getChildByTag(22), "CCNode")
		arg_3_0.layerChange = tolua.cast(var_5_1:getChildByTag(23), "CCNode")
		arg_3_0.layerBulletList = tolua.cast(var_5_1:getChildByTag(100), "CCLayerColor")
		arg_3_0.layerBuff = tolua.cast(arg_3_0.layerBuffList:getChildByTag(1), "CCNode")
		arg_3_0.btnBuffList = tolua.cast(arg_3_0.layerBuffList:getChildByTag(2), "CCControlButton")
		arg_3_0.spritebuffBg = tolua.cast(arg_3_0.layerBuffList:getChildByTag(99), "CCSprite")
		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.layerBuff:getChildByTag(0), "CCControlButton")
		arg_3_0.lbBuffHint = tolua.cast(arg_3_0.layerBuff:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnBuffList:addHandleOfControlEvent(function()
			arg_3_0:onBuffList()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbRoundDummy = tolua.cast(arg_3_0.layerUIRound:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnPause = tolua.cast(arg_3_0.layerUIRound:getChildByTag(2), "CCControlButton")
		arg_3_0.lbRoundSection = tolua.cast(arg_3_0.layerUIRound:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnAuto = tolua.cast(arg_3_0.layerUIAutoFight:getChildByTag(1), "CCControlButton")
		arg_3_0.btnMuilt = tolua.cast(arg_3_0.layerMuilt:getChildByTag(1), "CCControlButton")
		arg_3_0.btnOpenBulllet = tolua.cast(arg_3_0.layerOpenBulllet:getChildByTag(1), "CCControlButton")
		arg_3_0.btnSendBulllet = tolua.cast(arg_3_0.layerSendBulllet:getChildByTag(1), "CCControlButton")
		arg_3_0.fxReadyStart = createUIAnimation()

		arg_3_0.fxReadyStart:refresh("effect/spine/ui_zhandoukaishi/ui_zhandoukaishi.json", "effect/spine/ui_zhandoukaishi/ui_zhandoukaishi.atlas")
		arg_3_0.layerReadyStart:addChild(arg_3_0.fxReadyStart)

		arg_3_0.fxReadyStartDuration = arg_3_0.fxReadyStart:getAnimDuration("animation")
		arg_3_0.btnFocus = tolua.cast(arg_3_0.layerFocus:getChildByTag(1), "CCControlButton")
		arg_3_0.lbFocusCDDummy = tolua.cast(arg_3_0.layerFocus:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbFocusCD = CCLabelAtlas:create("", "font/rank_num_red.png", 26, 42, string.byte("+"))

		arg_3_0.lbFocusCD:setScale(0.65)
		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbFocusCDDummy, arg_3_0.lbFocusCD)

		arg_3_0.nodeFxQte = tolua.cast(arg_3_0.layerQte:getChildByTag(1), "CCNode")
		arg_3_0.btnQte = tolua.cast(arg_3_0.layerQte:getChildByTag(2), "CCControlButton")
		arg_3_0.nodeFxPingjia = tolua.cast(arg_3_0.layerQteEval:getChildByTag(1), "CCNode")

		arg_3_0.layerQteCombo:setCascadeOpacityEnabled(true)

		arg_3_0.lbQteComboCountDummy = tolua.cast(arg_3_0.layerQteCombo:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteQteComboDamage = tolua.cast(arg_3_0.layerQteCombo:getChildByTag(2), "CCSprite")
		arg_3_0.lbQteComboCount = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		arg_3_0.lbQteComboCount:setScale(1.6)
		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbQteComboCountDummy, arg_3_0.lbQteComboCount)

		arg_3_0.fxQte = createUIAnimation()

		arg_3_0.fxQte:refresh("effect/spine/ui_qte/qte1.json", "effect/spine/ui_qte/qte1.atlas")
		arg_3_0.nodeFxQte:addChild(arg_3_0.fxQte)

		arg_3_0.fxQteTimeScale = 1 / COMBAT_QTE_CIRCLE_TIME / COMBAT_SPEED_10
		arg_3_0.fxNumTimeFactor = 1
		arg_3_0.fxPingjia = createUIAnimation()

		arg_3_0.fxPingjia:refresh("effect/spine/ui_pingjia/pingjia1.json", "effect/spine/ui_pingjia/pingjia1.atlas")
		arg_3_0.nodeFxPingjia:addChild(arg_3_0.fxPingjia)

		arg_3_0.fxPingjiaTimeScale = 0.7666666666666667 * COMBAT_SPEED_10 / 1

		arg_3_0.btnQte:addHandleOfControlEvent(function()
			arg_3_0:onQteTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteLegendFrameFg = tolua.cast(arg_3_0.layerUILegend:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLegendIcon = tolua.cast(arg_3_0.layerUILegend:getChildByTag(2), "CCSprite")
		arg_3_0.btnLegendTouch = tolua.cast(arg_3_0.layerUILegend:getChildByTag(3), "CCControlButton")
		arg_3_0.btnLegendDetail = tolua.cast(arg_3_0.layerUILegend:getChildByTag(4), "CCControlButton")
		arg_3_0.progressLegendEnergy = zbUtil:createProgressTimer(arg_3_0.spriteLegendFrameFg, "image/combat/battleui/legend/progress_fg.png")

		arg_3_0.btnLegendDetail:addHandleOfControlEvent(function()
			arg_3_0:onLegendDetail()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLegendTouch:addHandleOfControlEvent(function()
			arg_3_0:onLegendTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.fxLegendEnergyHalo = createUIAnimation()

		arg_3_0.fxLegendEnergyHalo:refreshBone("effect/spine/ui_shenbingtubiao/ui_shengbingjineng1/ui_shengbingjineng1")
		arg_3_0.fxLegendEnergyHalo:setPosition(72, 80)
		arg_3_0.fxLegendEnergyHalo:setAnimation("animation", true)
		arg_3_0.fxLegendEnergyHalo:setScale(1)
		arg_3_0.fxLegendEnergyHalo:setTimeScale(1)
		arg_3_0.fxLegendEnergyHalo:setVisible(false)
		arg_3_0.layerUILegend:addChild(arg_3_0.fxLegendEnergyHalo)
		arg_3_0.fxLegendEnergyHalo.skeleton:setCascadeOpacityEnabled(true)

		arg_3_0.fxLegendSkillExec = createUIAnimation()

		arg_3_0.fxLegendSkillExec:refreshBone("effect/spine/ui_shenbingtubiao/ui_shengbingjineng2/ui_shengbingjineng2")
		arg_3_0.fxLegendSkillExec:setPosition(80, 80)
		arg_3_0.fxLegendSkillExec:setScale(1)
		arg_3_0.fxLegendSkillExec:setTimeScale(1)
		arg_3_0.fxLegendSkillExec:setVisible(false)
		arg_3_0.layerUILegend:addChild(arg_3_0.fxLegendSkillExec)
		arg_3_0.fxLegendSkillExec.skeleton:setCascadeOpacityEnabled(true)

		arg_3_0.lbRound = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		arg_3_0.lbRound:setScale(0.5)
		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbRoundDummy, arg_3_0.lbRound)

		for iter_5_0 = 1, 5 do
			local var_5_3 = zbTableViewHelper:create()

			var_5_3:loadCCBFile("ccbi/tb_combatheroui.ccbi")

			local var_5_4 = tolua.cast(arg_3_0.layerUIConsole:getChildByTag(iter_5_0), "CCLayer")
			local var_5_5 = zbCombatHeroUI:create(translateAndStrokeHelper(var_5_3:readCCBNode()), iter_5_0)

			var_5_5:setAnchorPoint(ccp(0, 0))
			var_5_5:setPosition(var_5_4:getPosition())
			var_5_4:removeFromParentAndCleanup(true)
			arg_3_0.layerUIConsole:addChild(var_5_5)

			arg_3_0.heroUIList[iter_5_0] = var_5_5

			var_5_3:releaseSelf()
		end

		arg_3_0.centerPosX = arg_3_0.heroUIList[3]:getPositionX() + arg_3_0.heroUIList[3]:getContentSize().width / 2
		arg_3_0.lbLeftName = tolua.cast(arg_3_0.layerRecord:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbLeftLevel = tolua.cast(arg_3_0.layerRecord:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbRightName = tolua.cast(arg_3_0.layerRecord:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbRightLevel = tolua.cast(arg_3_0.layerRecord:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteLeftHeadIcon = tolua.cast(arg_3_0.layerRecord:getChildByTag(6), "CCSprite")
		arg_3_0.spriteRightHeadIcon = tolua.cast(arg_3_0.layerRecord:getChildByTag(8), "CCSprite")
		arg_3_0.spriteBossProgressHpBg = tolua.cast(arg_3_0.layerBoss:getChildByTag(1), "CCSprite")
		arg_3_0.lbBossName = tolua.cast(arg_3_0.layerBoss:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteBossHpX = tolua.cast(arg_3_0.layerBoss:getChildByTag(3), "CCSprite")
		arg_3_0.lbBossHpSectionDummy = tolua.cast(arg_3_0.layerBoss:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.spriteBossProgressMpBg = tolua.cast(arg_3_0.layerBoss:getChildByTag(5), "CCSprite")
		arg_3_0.frame = tolua.cast(arg_3_0.layerBoss:getChildByTag(6), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.frame:getChildByTag(1), "CCControlButton")

		arg_3_0.iconSkill = tolua.cast(arg_3_0.frame:getChildByTag(2), "CCSprite")
		arg_3_0.skillDetail = tolua.cast(arg_3_0.layerBoss:getChildByTag(100), "CCNode")

		local var_5_7 = tolua.cast(arg_3_0.skillDetail:getChildByTag(1), "CCSprite")

		arg_3_0.iconSkill2 = tolua.cast(var_5_7:getChildByTag(2), "CCSprite")
		arg_3_0.lbSkillName = tolua.cast(arg_3_0.skillDetail:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbSkillDesc = tolua.cast(arg_3_0.skillDetail:getChildByTag(5), "CCLabelTTF")

		arg_3_0.iconSkill:setMaskTexture(CCTextureCache:sharedTextureCache():addImage("image/icon/heroskill/heroskill_mask.jpg"))
		arg_3_0.iconSkill2:setMaskTexture(CCTextureCache:sharedTextureCache():addImage("image/icon/heroskill/heroskill_mask.jpg"))
		var_5_6:addHandleOfControlEvent(function()
			arg_3_0:onSkillDetailDown()
		end, CCControlEventTouchDown)
		var_5_6:addHandleOfControlEvent(function()
			arg_3_0:onSkillDetailEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.progressBossHpTemp = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x5.png")
		arg_3_0.progressBossHp = {}
		arg_3_0.progressBossHp[1] = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x1.png")
		arg_3_0.progressBossHp[2] = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x2.png")
		arg_3_0.progressBossHp[3] = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x3.png")
		arg_3_0.progressBossHp[4] = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x4.png")
		arg_3_0.progressBossHp[5] = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressHpBg, "image/combat/battleui/boss/progress_x5.png")
		arg_3_0.progressBossMp = zbUtil:createProgressTimer(arg_3_0.spriteBossProgressMpBg, "image/combat/battleui/boss/progress_mp.png")
		arg_3_0.lbBossHpSection = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbBossHpSectionDummy, arg_3_0.lbBossHpSection)
		arg_3_0.lbBossHpSection:setScale(0.55)

		arg_3_0.nodeMyFormation = tolua.cast(arg_3_0.layerFormation:getChildByTag(1), "CCNode")
		arg_3_0.spriteMyFormation = tolua.cast(arg_3_0.nodeMyFormation:getChildByTag(1), "CCSprite")
		arg_3_0.btnMyFormation = tolua.cast(arg_3_0.nodeMyFormation:getChildByTag(2), "CCControlButton")
		arg_3_0.nodeEnemyFormation = tolua.cast(arg_3_0.layerFormation:getChildByTag(2), "CCNode")
		arg_3_0.spriteEnemyFormation = tolua.cast(arg_3_0.nodeEnemyFormation:getChildByTag(1), "CCSprite")
		arg_3_0.btnEnemyFormation = tolua.cast(arg_3_0.nodeEnemyFormation:getChildByTag(2), "CCControlButton")
		arg_3_0.nodeFormationTip = tolua.cast(arg_3_0.layerFormation:getChildByTag(3), "CCNode")
		arg_3_0.nodeFormationTipName = tolua.cast(arg_3_0.nodeFormationTip:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nodeFormationTipLevel = tolua.cast(arg_3_0.nodeFormationTip:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeFormationTipDesc1 = tolua.cast(arg_3_0.nodeFormationTip:getChildByTag(3), "CCLabelTTF")
		arg_3_0.nodeFormationTipDesc2 = tolua.cast(arg_3_0.nodeFormationTip:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnMyFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormationMyTipDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnMyFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormationMyTipEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnEnemyFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormationEnemyTipDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnEnemyFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormationEnemyTipEnd()
		end, CCControlEventTouchEnd)

		local var_5_8 = "image/combat/battleui/button_pause_normal.png"

		zbUtil:setHighlightSprite(arg_3_0.btnPause, var_5_8)
		zbUtil:setDisableSprite(arg_3_0.btnPause, var_5_8)
		arg_3_0.btnPause:addHandleOfControlEvent(function()
			arg_3_0:onPause()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAuto:addHandleOfControlEvent(function()
			arg_3_0:onAuto()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMuilt:addHandleOfControlEvent(function()
			arg_3_0:onSpeed()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnOpenBulllet:addHandleOfControlEvent(function()
			arg_3_0:onOpenBulllet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSendBulllet:addHandleOfControlEvent(function()
			arg_3_0:onSendBulllet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFocus:addHandleOfControlEvent(function()
			arg_3_0:onFocus()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTarget = tolua.cast(arg_3_0.layerTarget:getChildByTag(1), "CCLabelTTF")
		arg_3_0.attrLbList[1] = tolua.cast(arg_3_0.layerChange:getChildByTag(1), "CCLabelTTF")
		arg_3_0.attrLbList[2] = tolua.cast(arg_3_0.layerChange:getChildByTag(2), "CCLabelTTF")
		arg_3_0.attrLbList[3] = tolua.cast(arg_3_0.layerChange:getChildByTag(3), "CCLabelTTF")
		arg_3_0.initPos[1] = ccp(arg_3_0.attrLbList[1]:getPosition())
		arg_3_0.initPos[2] = ccp(arg_3_0.attrLbList[2]:getPosition())
		arg_3_0.initPos[3] = ccp(arg_3_0.attrLbList[3]:getPosition())

		arg_3_0.attrLbList[1]:setOpacity(0)
		arg_3_0.attrLbList[2]:setOpacity(0)
		arg_3_0.attrLbList[3]:setOpacity(0)

		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0:addChild(arg_3_0.layerScene)
		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:intBullet()
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHideCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshBarrage()
	end, zbGameEvent.Event_Barrage_Pull_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshSelfBarrage()
	end, zbGameEvent.Event_Barrage_Send_Ack)
end

function zbCombatWnd.doDestroy(arg_27_0)
	arg_27_0.layerScene:free()
end

function zbCombatWnd.onShowCallback(arg_28_0)
	arg_28_0.popPanelOver = false

	g_CombatSystem:setSpeed(arg_28_0.lastSpeed)
	CCDirector:sharedDirector():setAnimationInterval(0.03125)
	arg_28_0.btnLegendDetail:setVisible(g_FirstCombat:isActive() == false)
	arg_28_0.layerQte:setVisible(false)
	arg_28_0.layerQteCombo:setVisible(false)

	arg_28_0.fxNumTimeFactor = 2.2 / COMBAT_QTE_CIRCLE_TIME
end

function zbCombatWnd.onHideCallback(arg_29_0)
	g_CombatSystem:setNormalSpeed()
	CCDirector:sharedDirector():setAnimationInterval(0.03333333333333333)
	arg_29_0.layerQte:setVisible(false)
	arg_29_0.layerQteCombo:setVisible(false)
end

function zbCombatWnd.refresh(arg_30_0)
	arg_30_0.layerScene:load(g_CombatSystem.combatSceneId)
	g_CombatBubble.bubbleLayer:setScaleX(1)
	g_CombatBubble.bubbleLayer:setScaleY(1)
	arg_30_0.layerScene:addBubbleLayer(g_CombatBubble.bubbleLayer)
	g_CombatSystem.combatData.leftPlayer:attachHeros(arg_30_0.layerScene)
	g_CombatSystem.combatData.rightPlayer:attachHeros(arg_30_0.layerScene)

	if g_Self:getLevel() < 3 then
		g_CombatSystem:setAutoCombat(false)

		local var_30_0 = g_CombatSystem:getHeros(ForceType.Left, true)

		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			if iter_30_1:getTemplateId() == 1041 then
				iter_30_1.showMpFinger = true
			else
				iter_30_1.showMpFinger = false
			end
		end
	end

	arg_30_0:resetBullet()
	arg_30_0:loadAutoConfig()
	arg_30_0:updateRound()
	arg_30_0:updateRoundSection()
	arg_30_0:updateBtnTex()
	arg_30_0:updateMult()
	arg_30_0:refreshHeroUIList()

	local var_30_1 = {
		COMBAT_TYPE_LEGIONWAR,
		COMBAT_TYPE_RANDROB,
		COMBAT_TYPE_FRIENDBOSS,
		COMBAT_TYPE_WORLDBOSS,
		COMBAT_TYPE_ARENA,
		COMBAT_TYPE_LEGIONBATTLE,
		COMBAT_TYPE_CS_DALUANDOU,
		COMBAT_TYPE_CS_LIANSAI,
		COMBAT_TYPE_CS_XIULUO,
		COMBAT_TYPE_CS_DALUANDOU
	}
	local var_30_2 = true
	local var_30_3 = g_CombatSystem:getCombatType()

	for iter_30_2, iter_30_3 in pairs(var_30_1) do
		if var_30_3 == iter_30_3 then
			var_30_2 = false

			break
		end
	end

	arg_30_0.btnPause:setVisible(var_30_2 and g_FirstCombat:isActive() == false)

	if g_Guide and g_Guide:isGuiding() then
		arg_30_0.btnPause:setVisible(false)
	end

	arg_30_0.btnOpenBulllet:setVisible(var_30_3 == COMBAT_TYPE_LEVEL or var_30_3 == COMBAT_TYPE_TRIAL)
	arg_30_0.btnSendBulllet:setVisible(var_30_3 == COMBAT_TYPE_LEVEL or var_30_3 == COMBAT_TYPE_TRIAL)
	arg_30_0.btnAuto:setVisible(g_FirstCombat:isActive() == false)
	arg_30_0.btnMuilt:setVisible(g_FirstCombat:isActive() == false)

	arg_30_0.combatStarted = false

	arg_30_0.layerReadyStart:setVisible(false)
	arg_30_0.layerQte:setVisible(false)
	arg_30_0.layerQteCombo:setVisible(false)

	arg_30_0.lastWarningVisible = false

	arg_30_0.layerWarning:setVisible(false)
	arg_30_0:refreshLegend()
	arg_30_0:refreshRecord()
	arg_30_0:refreshFormationId()
	arg_30_0:refreshFormationTip()
	arg_30_0:hideFormationEffect()

	arg_30_0.energyBallList = {}

	arg_30_0:refreshBossHud()
	arg_30_0:refreshBuffList()
	arg_30_0:refreshTarget()
	arg_30_0:newRound()
	g_EffectSystem.cameraShake:setWatchNode(arg_30_0.layerScene.shakeList)
	arg_30_0:hideUI()
end

function zbCombatWnd.hidePause(arg_31_0)
	arg_31_0.btnPause:setVisible(false)
end

function zbCombatWnd.refreshHeroUIList(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.heroUIList) do
		iter_32_1:refresh()
	end

	arg_32_0:centerHeroUI()
end

function zbCombatWnd.onFrameUpdate(arg_33_0)
	g_CombatSystem:update()

	for iter_33_0, iter_33_1 in pairs(arg_33_0.heroUIList) do
		iter_33_1:update()
	end

	for iter_33_2 = #arg_33_0.energyBallList, 1, -1 do
		local var_33_0 = arg_33_0.energyBallList[iter_33_2]

		var_33_0:update()

		if var_33_0:isEnd() == true then
			var_33_0:free()
			table.remove(arg_33_0.energyBallList, iter_33_2)
		end
	end

	arg_33_0:updateLegendEnergy()
	arg_33_0:updateLegendEnergyHalo()
	arg_33_0:updateWarning()
	arg_33_0:updateBossHp()
	arg_33_0:updateFocus()
	arg_33_0:updateQte()

	for iter_33_3, iter_33_4 in pairs(arg_33_0.energyBallList) do
		iter_33_4:checkAutoGatherEnergyBall()
	end

	arg_33_0:checkAutoExecBigSkill()

	if arg_33_0.bulletEnd == true and g_CombatSystem:isOpenBulllet() then
		arg_33_0:refreshBarrage()
	end
end

function zbCombatWnd.newRound(arg_34_0)
	arg_34_0:updateRound()
	arg_34_0:updateRoundSection()
end

function zbCombatWnd.updateRound(arg_35_0)
	local var_35_0 = 0

	if g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundKill or g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundSurvival then
		var_35_0 = zbUtil:clamp(g_CombatRound:getAccumRound(), 1, g_CombatRound.maxRound)
	else
		var_35_0 = zbUtil:clamp(g_CombatRound:getCurRound(), 1, g_CombatRound.maxRound)
	end

	arg_35_0.lbRound:setString(var_35_0 .. "/" .. g_CombatRound.maxRound)
end

function zbCombatWnd.updateRoundSection(arg_36_0)
	arg_36_0.lbRoundSection:setString(a2u("(第") .. string.format("%d/%d", g_CombatSystem.combatData.rightPlayer.curSection, g_CombatSystem.combatData.rightPlayer.maxSection) .. a2u("波)"))
	arg_36_0.lbRoundSection:setVisible(g_CombatSystem.combatData.rightPlayer.maxSection > 1 and g_CombatSystem.combatData:getTrialType() ~= ETrialType.LimitRoundKill and g_CombatSystem.combatData:getTrialType() ~= ETrialType.LimitRoundSurvival)
end

function zbCombatWnd.hideUI(arg_37_0)
	arg_37_0.layerBuffList:setVisible(false)
	arg_37_0.layerUIRound:setVisible(false)
	arg_37_0.layerUIConsole:setVisible(false)
	arg_37_0.layerUIAutoFight:setVisible(false)
	arg_37_0.layerMuilt:setVisible(false)
	arg_37_0.layerUILegend:setVisible(false)
	arg_37_0.layerRecord:setVisible(false)
	arg_37_0.layerFormation:setVisible(false)
	arg_37_0.layerBoss:setVisible(false)
	arg_37_0.spriteBossWarning:setVisible(false)
	arg_37_0.layerOpenBulllet:setVisible(false)
	arg_37_0.layerSendBulllet:setVisible(false)
	arg_37_0.layerFocus:setVisible(false)
	arg_37_0.layerQte:setVisible(false)
	arg_37_0.layerQteCombo:setVisible(false)
	arg_37_0.layerTarget:setVisible(false)
	arg_37_0.layerBulletList:setVisible(false)
	arg_37_0.btnChat:setVisible(false)
end

function zbCombatWnd.showUI(arg_38_0)
	if g_FirstCombat:isActive() and arg_38_0.combatStarted == false then
		g_CombatSystem:setAutoCombat(false)
	end

	if arg_38_0.layerUIConsole:isVisible() then
		return
	end

	arg_38_0.layerUIRound:setVisible(g_FirstCombat:isActive() == false)
	arg_38_0.layerUIConsole:setVisible(true)
	arg_38_0.layerUIAutoFight:setVisible(true)
	arg_38_0.layerMuilt:setVisible(true)
	arg_38_0.layerUILegend:setVisible(true)
	arg_38_0.layerRecord:setVisible(g_CombatSystem:getCombatType() == COMBAT_TYPE_ARENARECORD)
	arg_38_0.layerFormation:setVisible(true)
	arg_38_0.layerOpenBulllet:setVisible(g_CombatSystem:getCombatType() == COMBAT_TYPE_LEVEL or g_CombatSystem:getCombatType() == COMBAT_TYPE_TRIAL)
	arg_38_0.layerSendBulllet:setVisible(g_CombatSystem:getCombatType() == COMBAT_TYPE_LEVEL or g_CombatSystem:getCombatType() == COMBAT_TYPE_TRIAL)
	arg_38_0.layerFocus:setVisible(g_Self:getLevel() >= 8 and g_FirstCombat:isActive() == false and g_CombatSystem:isPvPCombatType() == false)
	arg_38_0.layerTarget:setVisible(g_FirstCombat:isActive() == false)

	local var_38_0 = g_CombatSystem.combatData.leftPlayer:getBuffList()

	arg_38_0.layerBuffList:setVisible(g_CombatSystem:getCombatType() == COMBAT_TYPE_PATA)
	arg_38_0.layerBoss:setVisible(g_CombatSystem.combatData:getBossHero() ~= nil)
	arg_38_0.spriteBossWarning:setVisible(false)
	arg_38_0:popupUI()

	if arg_38_0.combatStarted == false then
		local function var_38_1()
			g_CombatRound:start()
		end

		local var_38_2 = CCArray:create()

		var_38_2:addObject(CCDelayTime:create(0.7))
		var_38_2:addObject(CCCallFuncN:create(var_38_1))

		local var_38_3 = CCSequence:create(var_38_2)

		arg_38_0:stopAllActions()
		arg_38_0:runAction(var_38_3)

		arg_38_0.combatStarted = true

		local var_38_4, var_38_5 = g_CombatSystem.combatData.leftPlayer.legend:popPassiveBubble()

		arg_38_0:nextChange(var_38_4, var_38_5)
	end

	if g_CombatSystem:getCombatType() == COMBAT_TYPE_LEVEL or g_CombatSystem:getCombatType() == COMBAT_TYPE_TRIAL then
		local var_38_6 = zbGameCore:Instance():getConfigValue(arg_38_0.strBulletList)

		g_CombatSystem:setOpenBulllet(var_38_6 ~= "0")
		arg_38_0:updateBulllet(var_38_6 ~= "0")
	end

	if g_Self:getLevel() == 6 then
		local var_38_7 = "GuideAuto_" .. g_GameData.BaseInfo.PlayerId

		if zbGameCore:Instance():getConfigValue(var_38_7) ~= "1" then
			g_Guide:execGuide(GUIDE_STEP_LEVEL006)
		end
	end
end

function zbCombatWnd.popupUI(arg_40_0)
	local function var_40_0(arg_41_0, arg_41_1)
		local var_41_0 = ccp(arg_41_0:getPosition())
		local var_41_1 = CCMoveTo:create(0.3, var_41_0)
		local var_41_2 = CCArray:create()

		var_41_2:addObject(var_41_1)
		var_41_2:addObject(CCCallFuncN:create(function()
			arg_40_0.popPanelOver = true
		end))

		local var_41_3 = CCSequence:create(var_41_2)

		arg_41_0:setPosition(arg_41_0:getPositionX(), arg_41_0:getPositionY() + arg_41_1)
		arg_41_0:stopAllActions()
		arg_41_0:runAction(var_41_3)
	end

	var_40_0(arg_40_0.layerBuffList, 120)
	var_40_0(arg_40_0.layerUIRound, 120)
	var_40_0(arg_40_0.layerUIConsole, -200)
	var_40_0(arg_40_0.layerUIAutoFight, -200)
	var_40_0(arg_40_0.layerMuilt, -200)
	var_40_0(arg_40_0.layerUILegend, -200)
	var_40_0(arg_40_0.layerRecord, 120)
	var_40_0(arg_40_0.layerFormation, 120)
	var_40_0(arg_40_0.layerBoss, 120)
	var_40_0(arg_40_0.layerTarget, 120)
	var_40_0(arg_40_0.layerOpenBulllet, -200)
	var_40_0(arg_40_0.layerSendBulllet, -200)
	var_40_0(arg_40_0.layerFocus, -200)
	var_40_0(arg_40_0.btnChat, -200)
end

function zbCombatWnd.onPause(arg_43_0)
	g_MainScene:showCombatPause()
end

function zbCombatWnd.onAuto(arg_44_0)
	if g_CombatSystem:isPvPCombatType() then
		g_Bubble:bubbleInfo(g_CombatSystem:getPvPCombatTypeDesc() .. "只能自动战斗")

		return
	end

	if g_Self:getLevel() < 6 then
		g_Bubble:bubbleInfo("玩家6级开启【自动战斗】")

		return
	end

	g_CombatSystem:setAutoCombat(not g_CombatSystem:isAutoCombat())
	arg_44_0:updateBtnTex()
	arg_44_0:saveAutoConfig()

	if g_CombatSystem:isAutoCombat() then
		g_Bubble:bubbleInfo("已切换为自动战斗")
	else
		g_Bubble:bubbleInfo("已切换为手动战斗")
	end
end

function zbCombatWnd.onSpeed(arg_45_0)
	if g_Self:getLevel() < 6 then
		g_Bubble:bubbleInfo("玩家6级开启【战斗加速】")

		return
	end

	local var_45_0 = g_CombatSystem:getSpeed()
	local var_45_1 = "1"

	if var_45_0 == COMBAT_SPEED_10 then
		var_45_0 = COMBAT_SPEED_15
		var_45_1 = "2"
	elseif var_45_0 == COMBAT_SPEED_15 then
		var_45_0 = COMBAT_SPEED_20
		var_45_1 = "3"
	elseif var_45_0 == COMBAT_SPEED_20 then
		var_45_0 = COMBAT_SPEED_10
		var_45_1 = "1"
	end

	zbGameCore:Instance():setConfigValue(arg_45_0.strCombatSpeed, var_45_1)
	g_CombatSystem:setSpeed(var_45_0)

	arg_45_0.lastSpeed = g_CombatSystem:getSpeed()

	arg_45_0:updateMult()
end

function zbCombatWnd.onOpenBulllet(arg_46_0)
	g_CombatSystem:setOpenBulllet(not g_CombatSystem:isOpenBulllet())
	arg_46_0:updateBulllet(true)
end

function zbCombatWnd.onSendBulllet(arg_47_0)
	local var_47_0 = g_CombatSystem:isOpenBulllet()

	g_CombatSystem:setOpenBulllet(true)
	arg_47_0:updateBulllet(not var_47_0)
	g_MainScene:showBulletScreen(arg_47_0.bulletLine.DungeonType, arg_47_0.bulletLine.LevelId, arg_47_0.bulletLine.LevelWave)
end

function zbCombatWnd.updateBtnTex(arg_48_0)
	if g_CombatSystem:isAutoCombat() then
		require("gamebase.zbUI"):setButtonPic(arg_48_0.btnAuto, "image/combat/battleui/auto_on.png", "image/combat/battleui/auto_off.png")
	else
		require("gamebase.zbUI"):setButtonPic(arg_48_0.btnAuto, "image/combat/battleui/auto_off.png", "image/combat/battleui/auto_on.png")
	end

	if g_Self:getLevel() < 6 then
		require("gamebase.zbUI"):setButtonPic(arg_48_0.btnAuto, "image/combat/battleui/auto_lock_2.png", "image/combat/battleui/auto_lock_2.png")
	end

	if g_CombatSystem:isPvPCombatType() then
		require("gamebase.zbUI"):setButtonPic(arg_48_0.btnAuto, "image/combat/battleui/auto_lock.png", "image/combat/battleui/auto_lock.png")
	end
end

function zbCombatWnd.updateMult(arg_49_0)
	local var_49_0 = g_CombatSystem:getSpeed()

	if var_49_0 == COMBAT_SPEED_10 then
		require("gamebase.zbUI"):setButtonPic(arg_49_0.btnMuilt, "image/combat/battleui/multiple_1.png", "image/combat/battleui/multiple_1.png")
	elseif var_49_0 == COMBAT_SPEED_15 then
		require("gamebase.zbUI"):setButtonPic(arg_49_0.btnMuilt, "image/combat/battleui/multiple_2.png", "image/combat/battleui/multiple_2.png")
	elseif var_49_0 == COMBAT_SPEED_20 then
		require("gamebase.zbUI"):setButtonPic(arg_49_0.btnMuilt, "image/combat/battleui/multiple_3.png", "image/combat/battleui/multiple_3.png")
	end

	if g_Self:getLevel() < 6 then
		require("gamebase.zbUI"):setButtonPic(arg_49_0.btnMuilt, "image/combat/battleui/multiple_lock.png", "image/combat/battleui/multiple_lock.png")
	end
end

function zbCombatWnd.updateBulllet(arg_50_0, arg_50_1)
	if g_CombatSystem:isOpenBulllet() then
		require("gamebase.zbUI"):setButtonPic(arg_50_0.btnOpenBulllet, "image/combat/battleui/bulletscreen_open.png", "image/combat/battleui/bulletscreen_open.png")

		local var_50_0 = g_CombatSystem.combatData

		arg_50_0.bulletLine.DungeonType = EBarrageDungeonType.Tuitu
		arg_50_0.bulletLine.LevelId = 0
		arg_50_0.bulletLine.LevelWave = 0

		if g_CombatSystem:getCombatType() == COMBAT_TYPE_LEVEL then
			arg_50_0.bulletLine.DungeonType = EBarrageDungeonType.Tuitu
			arg_50_0.bulletLine.LevelId = var_50_0.levelBattleReadyAckData.LevelId
			arg_50_0.bulletLine.LevelWave = var_50_0.levelBattleReadyAckData.LevelType

			if arg_50_1 then
				g_WsMsgHandler:WS_Barrage_Pull_Req(arg_50_0.bulletLine)
			end

			zbGameCore:Instance():setConfigValue(arg_50_0.strBulletList, 1)
		elseif g_CombatSystem:getCombatType() == COMBAT_TYPE_TRIAL then
			arg_50_0.bulletLine.DungeonType = EBarrageDungeonType.HeroTrial
			arg_50_0.bulletLine.LevelId = var_50_0.trailReadyAckData.TrialType
			arg_50_0.bulletLine.LevelWave = var_50_0.trailReadyAckData.Level

			if arg_50_1 then
				g_WsMsgHandler:WS_Barrage_Pull_Req(arg_50_0.bulletLine)
			end

			zbGameCore:Instance():setConfigValue(arg_50_0.strBulletList, 1)
		end
	else
		require("gamebase.zbUI"):setButtonPic(arg_50_0.btnOpenBulllet, "image/combat/battleui/bulletscreen_close.png", "image/combat/battleui/bulletscreen_close.png")
		arg_50_0:resetBullet()
		zbGameCore:Instance():setConfigValue(arg_50_0.strBulletList, 0)
	end
end

function zbCombatWnd.fadeFixedNode(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = CCArray:create()

	var_51_0:addObject(CCCallFuncN:create(function()
		arg_51_1:setVisible(true)
	end))
	var_51_0:addObject(CCMoveTo:create(10 * arg_51_0.lastSpeed / COMBAT_SPEED_10, ccp(0 - arg_51_1.width, arg_51_2)))
	var_51_0:addObject(CCCallFuncN:create(function()
		arg_51_1:actionOver()
	end))
	arg_51_1:stopAllActions()
	arg_51_1:runAction(CCSequence:create(var_51_0))
	var_51_0:removeAllObjects()
end

function zbCombatWnd.fadeCenterNode(arg_54_0, arg_54_1)
	local var_54_0 = CCArray:create()

	var_54_0:addObject(CCCallFuncN:create(function()
		arg_54_1:setVisible(true)
	end))
	var_54_0:addObject(CCDelayTime:create(3 * arg_54_0.lastSpeed / COMBAT_SPEED_10))
	var_54_0:addObject(CCCallFuncN:create(function()
		arg_54_1:actionOver()
	end))
	arg_54_1:stopAllActions()
	arg_54_1:runAction(CCSequence:create(var_54_0))
	var_54_0:removeAllObjects()
end

function zbCombatWnd.refreshSelfBarrage(arg_57_0)
	if g_GameData.lastBarrage ~= nil then
		arg_57_0.layerBulletList:setVisible(true)

		g_GameData.lastBarrage.FontColor = 0
		g_GameData.lastBarrage.SMsg = "<<" .. g_GameData.lastBarrage.SMsg .. ">>"

		arg_57_0:runBulletAction(g_GameData.lastBarrage)

		g_GameData.lastBarrage = nil
	end
end

function zbCombatWnd.intBullet(arg_58_0)
	for iter_58_0 = 1, 500 do
		arg_58_0.bulletItem[iter_58_0] = createBulletScreenContent(iter_58_0)

		arg_58_0.bulletItem[iter_58_0]:setPosition(2000, 320)
		arg_58_0.layerBulletList:addChild(arg_58_0.bulletItem[iter_58_0])
	end
end

function zbCombatWnd.runBulletAction(arg_59_0, arg_59_1)
	local var_59_0

	for iter_59_0 = 1, 500 do
		var_59_0 = arg_59_0.bulletItem[iter_59_0]

		if var_59_0:isOver() == true then
			break
		end
	end

	if var_59_0 then
		var_59_0:refresh(arg_59_1)

		local var_59_1 = zbUtil:random(6, 22) * 25

		if arg_59_1.FontPos == EBarrageFontPos.Center then
			var_59_0:setPosition(568 - var_59_0.width / 2, var_59_1)
			arg_59_0:fadeCenterNode(var_59_0)
		else
			var_59_0:setPosition(1136, var_59_1)
			arg_59_0:fadeFixedNode(var_59_0, var_59_1)
		end
	end
end

function zbCombatWnd.resetBullet(arg_60_0)
	arg_60_0.layerBulletList:setVisible(false)

	arg_60_0.bulletEnd = false

	arg_60_0.layerBulletList:stopAllActions()

	for iter_60_0 = 1, 500 do
		bullet = arg_60_0.bulletItem[iter_60_0]

		bullet:setOver()
		bullet:setPosition(2000, 320)
	end
end

function zbCombatWnd.refreshBarrage(arg_61_0)
	arg_61_0.layerBulletList:setVisible(true)

	local var_61_0 = table.getn(g_GameData.BarrageList)

	arg_61_0.bulletEnd = false

	local var_61_1 = CCArray:create()

	for iter_61_0, iter_61_1 in pairs(g_GameData.BarrageList) do
		var_61_1:addObject(CCCallFuncN:create(function()
			arg_61_0:runBulletAction(iter_61_1)
		end))
		var_61_1:addObject(CCDelayTime:create(1))
	end

	for iter_61_2 = var_61_0 + 1, 100 do
		local var_61_2 = zbUtil:random(1, zbBulletScreenTable.number)
		local var_61_3 = zbBulletScreenTable:getRecord(var_61_2)

		var_61_1:addObject(CCCallFuncN:create(function()
			arg_61_0:runBulletAction(var_61_3)
		end))
		var_61_1:addObject(CCDelayTime:create(1))
	end

	var_61_1:addObject(CCDelayTime:create(0.5))
	var_61_1:addObject(CCCallFuncN:create(function()
		arg_61_0.bulletEnd = true
	end))
	arg_61_0.layerBulletList:stopAllActions()
	arg_61_0.layerBulletList:runAction(CCSequence:create(var_61_1))
end

function zbCombatWnd.refreshFormationId(arg_65_0)
	local function var_65_0(arg_66_0)
		local function var_66_0(arg_67_0, arg_67_1)
			local function var_67_0(arg_68_0)
				return arg_68_0 ~= 0 and arg_68_0 ~= -1
			end

			local var_67_1 = FormationSlots[arg_67_1]

			if var_67_1 == nil then
				return false
			end

			for iter_67_0, iter_67_1 in pairs(var_67_1) do
				if var_67_0(arg_67_0[iter_67_0]) ~= var_67_0(iter_67_1) then
					return false
				end
			end

			return true
		end

		local var_66_1 = g_CombatSystem:getHeros(arg_66_0)

		if table.getn(var_66_1) < 5 then
			return 0
		end

		local var_66_2 = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}

		for iter_66_0, iter_66_1 in pairs(var_66_1) do
			var_66_2[iter_66_1:getFormationIndex()] = 1
		end

		for iter_66_2, iter_66_3 in pairs(FormationSlots) do
			if var_66_0(var_66_2, iter_66_2) then
				return iter_66_2
			end
		end

		return 0
	end

	arg_65_0.leftFormationId = var_65_0(ForceType.Left)
	arg_65_0.rightFormationId = var_65_0(ForceType.Right)
	arg_65_0.leftFormationLevel = g_CombatSystem.combatData.leftPlayer:getFormationLevel()
	arg_65_0.rightFormationLevel = g_CombatSystem.combatData.rightPlayer:getFormationLevel()

	if g_CombatSystem:isPvPCombatType() == false then
		arg_65_0.rightFormationLevel = 1
	end

	arg_65_0.myFormationId = arg_65_0.leftFormationId
	arg_65_0.enemyFormationId = arg_65_0.rightFormationId
	arg_65_0.myFormationLevel = g_CombatSystem.combatData.leftPlayer:getFormationLevel()
	arg_65_0.enemyFormationLevel = g_CombatSystem.combatData.rightPlayer:getFormationLevel()

	if g_CombatSystem:getMyForceType() == ForceType.Right then
		arg_65_0.myFormationId = arg_65_0.rightFormationId
		arg_65_0.enemyFormationId = arg_65_0.leftFormationId
		arg_65_0.myFormationLevel = g_CombatSystem.combatData.rightPlayer:getFormationLevel()
		arg_65_0.enemyFormationLevel = g_CombatSystem.combatData.leftPlayer:getFormationLevel()
	end
end

function zbCombatWnd.refreshFormationTip(arg_69_0)
	arg_69_0.nodeMyFormation:setVisible(true)
	arg_69_0.spriteMyFormation:setVisible(arg_69_0.myFormationId ~= 0 and arg_69_0.myFormationLevel > 0)
	arg_69_0.nodeMyFormation:setVisible(arg_69_0.myFormationId ~= 0 and arg_69_0.myFormationLevel > 0)

	if arg_69_0.myFormationId ~= 0 then
		local var_69_0 = string.format("image/icon/formation/small_formation_%d.png", arg_69_0.myFormationId)

		arg_69_0.spriteMyFormation:setTexture(CCTextureCache:sharedTextureCache():addImage(var_69_0))
	end

	arg_69_0.nodeEnemyFormation:setVisible(g_CombatSystem:isPvPCombatType() and arg_69_0.enemyFormationId ~= 0 and arg_69_0.enemyFormationLevel > 0)
	arg_69_0.spriteEnemyFormation:setVisible(g_CombatSystem:isPvPCombatType() and arg_69_0.enemyFormationId ~= 0 and arg_69_0.enemyFormationLevel > 0)

	if g_CombatSystem:isPvPCombatType() and arg_69_0.enemyFormationId ~= 0 then
		local var_69_1 = string.format("image/icon/formation/small_formation_%d.png", arg_69_0.enemyFormationId)

		arg_69_0.spriteEnemyFormation:setTexture(CCTextureCache:sharedTextureCache():addImage(var_69_1))
	end

	arg_69_0.nodeFormationTip:setVisible(false)
end

function zbCombatWnd.onFormationMyTipDown(arg_70_0)
	local var_70_0, var_70_1, var_70_2 = zbFormationHelper:getFormationDesc(arg_70_0.myFormationId, arg_70_0.myFormationLevel)

	arg_70_0.nodeFormationTipName:setString(var_70_0)
	arg_70_0.nodeFormationTipLevel:setString(a2u("LV.") .. arg_70_0.myFormationLevel)
	arg_70_0.nodeFormationTipDesc1:setString(var_70_1)
	arg_70_0.nodeFormationTipDesc2:setString(var_70_2)
	arg_70_0.nodeFormationTipLevel:setVisible(arg_70_0.myFormationId ~= 0 and arg_70_0.myFormationLevel > 0)
	arg_70_0.nodeFormationTip:setVisible(true)
	arg_70_0.nodeFormationTip:setPositionX(arg_70_0.nodeMyFormation:getPositionX())
end

function zbCombatWnd.onFormationMyTipEnd(arg_71_0)
	arg_71_0.nodeFormationTip:setVisible(false)
end

function zbCombatWnd.onFormationEnemyTipDown(arg_72_0)
	local var_72_0, var_72_1, var_72_2 = zbFormationHelper:getFormationDesc(arg_72_0.enemyFormationId, arg_72_0.enemyFormationLevel)

	arg_72_0.nodeFormationTipName:setString(var_72_0)
	arg_72_0.nodeFormationTipLevel:setString(a2u("LV.") .. arg_72_0.enemyFormationLevel)
	arg_72_0.nodeFormationTipDesc1:setString(var_72_1)
	arg_72_0.nodeFormationTipDesc2:setString(var_72_2)
	arg_72_0.nodeFormationTipLevel:setVisible(arg_72_0.enemyFormationId ~= 0 and arg_72_0.enemyFormationLevel > 0)
	arg_72_0.nodeFormationTip:setVisible(true)
	arg_72_0.nodeFormationTip:setPositionX(arg_72_0.nodeEnemyFormation:getPositionX() + 110)
end

function zbCombatWnd.onFormationEnemyTipEnd(arg_73_0)
	arg_73_0.nodeFormationTip:setVisible(false)
end

function zbCombatWnd.refreshRecord(arg_74_0)
	if g_CombatSystem:getCombatType() ~= COMBAT_TYPE_ARENARECORD then
		arg_74_0.layerRecord:setVisible(false)

		return
	end

	local var_74_0 = ""
	local var_74_1 = 0
	local var_74_2 = 0
	local var_74_3 = ""
	local var_74_4 = 0
	local var_74_5 = 0
	local var_74_6 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.SelfBaseInfo[1].RoleName
	local var_74_7 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.SelfBaseInfo[1].Level
	local var_74_8 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.SelfBaseInfo[1].HeadId
	local var_74_9 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].RoleName
	local var_74_10 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].Level
	local var_74_11 = g_CombatSystem.combatData.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].HeadId

	arg_74_0.lbLeftName:setString(a2u(var_74_6))
	arg_74_0.lbLeftLevel:setString(a2u(var_74_7))
	arg_74_0.lbRightName:setString(a2u(var_74_9))
	arg_74_0.lbRightLevel:setString(a2u(var_74_10))

	local var_74_12 = zbIconHelper:getPlayerHeadIconPath(var_74_8)
	local var_74_13 = zbIconHelper:getPlayerHeadIconPath(var_74_11)
end

function zbCombatWnd.loadAutoConfig(arg_75_0)
	if g_CombatSystem:isPvPCombatType() == false then
		if g_Self:getLevel() < 6 then
			return
		end

		local var_75_0 = tonumber(zbGameCore:Instance():getConfigValue(arg_75_0.autoSectionKey)) == 1

		g_CombatSystem:setAutoCombat(var_75_0)
		arg_75_0:updateBtnTex()
	end
end

function zbCombatWnd.saveAutoConfig(arg_76_0)
	local var_76_0 = 0
	local var_76_1 = g_CombatSystem:isAutoCombat() and 1 or 0

	zbGameCore:Instance():setConfigValue(arg_76_0.autoSectionKey, var_76_1)
	zbGameCore:Instance():saveConfig()
end

function zbCombatWnd.centerHeroUI(arg_77_0)
	local var_77_0 = arg_77_0.heroUIList[3]:getContentSize().width
	local var_77_1 = 0

	for iter_77_0, iter_77_1 in pairs(arg_77_0.heroUIList) do
		if iter_77_1:isVisible() then
			var_77_1 = var_77_1 + 1
		end
	end

	for iter_77_2 = 1, var_77_1 do
		arg_77_0.heroUIList[iter_77_2]:setPositionX(arg_77_0.centerPosX + var_77_0 * var_77_1 / 2 - iter_77_2 * var_77_0)
	end
end

function zbCombatWnd.spawnEnergyBall(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	if arg_78_3 <= 0 then
		echo("warning: energy is zero")

		return
	end

	local var_78_0 = zbCombatEnergyBall:create(arg_78_1, arg_78_2, arg_78_3)

	table.insert(arg_78_0.energyBallList, var_78_0)
end

function zbCombatWnd.gatherEnergyBallImmediate(arg_79_0)
	for iter_79_0, iter_79_1 in pairs(arg_79_0.energyBallList) do
		iter_79_1:gather(true)
	end
end

function zbCombatWnd.refreshLegend(arg_80_0)
	local var_80_0 = zbGodBaseTable:getRecord(g_CombatSystem:getLegend():getId())

	if var_80_0 ~= nil then
		arg_80_0.spriteLegendIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_80_0.iconPath))
	end

	arg_80_0.lastEnergyPercent = -1

	arg_80_0.progressLegendEnergy:setPercentage(0)
	arg_80_0:updateLegendEnergy()
	arg_80_0:updateLegendEnergyHalo()
end

function zbCombatWnd.updateLegendEnergy(arg_81_0)
	local var_81_0 = g_CombatSystem:getLegend():getEnergyPercent()

	if var_81_0 == arg_81_0.lastEnergyPercent then
		return
	end

	arg_81_0.progressLegendEnergy:runAction(CCProgressFromTo:create(0.35, arg_81_0.lastEnergyPercent, var_81_0))

	arg_81_0.lastEnergyPercent = var_81_0
end

function zbCombatWnd.legendIsCanTouch(arg_82_0)
	if g_CombatSystem:getLegend():isEmpty() then
		return false
	end

	if g_CombatSystem:isPvPCombatType() then
		return false
	end

	if g_CombatSystem:getLegend():isCanExec() == false then
		return false
	end

	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return false
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return false
	end

	if g_CombatSystem.combatData.leftPlayer:getCurTotalHp() <= 0 or g_CombatSystem.combatData.rightPlayer:getCurTotalHp() <= 0 then
		return false
	end

	if g_MainScene.wndCombatTalk ~= nil and g_MainScene.wndCombatTalk.isShow and g_MainScene.wndCombatTalk:isVisible() == true then
		return false
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		return false
	end

	if g_CombatSystem.combatData.combatQte:getQteTarget() ~= nil then
		return false
	end

	return true
end

function zbCombatWnd.updateLegendEnergyHalo(arg_83_0)
	local var_83_0 = arg_83_0:legendIsCanTouch()

	arg_83_0.fxLegendEnergyHalo:setVisible(var_83_0)
end

function zbCombatWnd.onLegendTouch(arg_84_0)
	if g_CombatSystem:getLegend():isEmpty() then
		g_Bubble:bubbleInfo("当前没有激活的法宝")
	end

	if g_CombatSystem:isPvPCombatType() then
		g_Bubble:bubbleInfo(g_CombatSystem:getPvPCombatTypeDesc() .. "自动释放法宝技能")

		return
	end

	if arg_84_0:legendIsCanTouch() and g_CombatSystem:getLegend():execBigSkill() then
		arg_84_0:playLegendSkillExecFx()
	end
end

function zbCombatWnd.onLegendDetail(arg_85_0)
	local var_85_0 = zbGodBaseTable:getRecord(g_CombatSystem:getLegend():getId())

	if var_85_0 ~= nil then
		g_MainScene:showGodDetailWnd(var_85_0)
	end
end

function zbCombatWnd.playLegendSkillExecFx(arg_86_0)
	local function var_86_0()
		arg_86_0.fxLegendSkillExec:setVisible(false)
	end

	local var_86_1 = CCArray:create()

	var_86_1:addObject(CCDelayTime:create(0.5))
	var_86_1:addObject(CCCallFuncN:create(var_86_0))

	local var_86_2 = CCSequence:create(var_86_1)

	arg_86_0.fxLegendEnergyHalo:setVisible(true)
	arg_86_0.fxLegendSkillExec:setVisible(true)
	arg_86_0.fxLegendSkillExec:setAnimation("animation", false)
	arg_86_0.fxLegendSkillExec:stopAllActions()
	arg_86_0.fxLegendSkillExec:runAction(var_86_2)
end

function zbCombatWnd.checkAutoExecBigSkill(arg_88_0)
	g_CombatSystem:getLegend():checkAutoExecBigSkill()
	g_CombatSystem:getEnemyLegend():checkAutoExecBigSkill()
end

function zbCombatWnd.updateWarning(arg_89_0)
	local var_89_0 = true

	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		var_89_0 = false
	end

	if var_89_0 then
		local var_89_1 = g_CombatSystem:getHerosNoLocal(g_CombatSystem:getMyForceType())

		for iter_89_0, iter_89_1 in pairs(var_89_1) do
			if iter_89_1:getHpPercent() >= 30 then
				var_89_0 = false
			end
		end
	end

	if arg_89_0.lastWarningVisible == var_89_0 then
		return
	end

	arg_89_0.lastWarningVisible = var_89_0

	if var_89_0 then
		arg_89_0.layerWarning:setVisible(true)
		arg_89_0.layerWarning:setCascadeOpacityEnabled(true)

		local var_89_2 = CCArray:create()

		var_89_2:addObject(CCFadeTo:create(1.5, 255))
		var_89_2:addObject(CCFadeTo:create(1.5, 128))

		local var_89_3 = CCSequence:create(var_89_2)

		arg_89_0.layerWarning:stopAllActions()
		arg_89_0.layerWarning:runAction(CCRepeatForever:create(var_89_3))
	else
		arg_89_0.layerWarning:setVisible(true)
		arg_89_0.layerWarning:setCascadeOpacityEnabled(true)

		local var_89_4 = CCArray:create()

		var_89_4:addObject(CCFadeIn:create(1))
		var_89_4:addObject(CCFadeOut:create(1.5))

		local var_89_5 = CCSequence:create(var_89_4)

		arg_89_0.layerWarning:stopAllActions()
		arg_89_0.layerWarning:runAction(var_89_5)
	end
end

function zbCombatWnd.showBossWarning(arg_90_0)
	local var_90_0 = g_CombatSystem.combatData:isLevelType() and g_CombatSystem.combatData:getBossHero() ~= nil

	arg_90_0.spriteBossWarning:setVisible(var_90_0)

	if var_90_0 then
		local var_90_1 = CCArray:create()

		var_90_1:addObject(CCFadeIn:create(0.5))
		var_90_1:addObject(CCFadeTo:create(0.5, 128))
		var_90_1:addObject(CCFadeIn:create(0.5))
		var_90_1:addObject(CCFadeTo:create(0.5, 128))
		var_90_1:addObject(CCFadeIn:create(0.5))
		var_90_1:addObject(CCFadeOut:create(0.5))
		var_90_1:addObject(CCCallFuncN:create(function()
			arg_90_0.spriteBossWarning:setVisible(false)
		end))

		local var_90_2 = CCSequence:create(var_90_1)

		arg_90_0.spriteBossWarning:setOpacity(0)
		arg_90_0.spriteBossWarning:stopAllActions()
		arg_90_0.spriteBossWarning:runAction(var_90_2)
		g_Audio:playSound("audio/sound/effect_boss.mp3")
	end
end

function zbCombatWnd.refreshBossHud(arg_92_0)
	arg_92_0.bossHero = g_CombatSystem.combatData:getBossHero()

	if arg_92_0.bossHero ~= nil then
		arg_92_0.lbBossName:setString(arg_92_0.bossHero.heroRecord.name)
		arg_92_0.iconSkill:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getSkillIconPath(arg_92_0.bossHero.heroRecord.skillId1)))
	end

	arg_92_0.skillDetail:setVisible(false)
	arg_92_0.layerBoss:setVisible(arg_92_0.bossHero ~= nil and arg_92_0.bossHero.heroRecord.skillId1 ~= 6011)
	arg_92_0.frame:setVisible(arg_92_0.bossHero ~= nil and arg_92_0.bossHero.heroRecord.id ~= 601)

	for iter_92_0 = 1, 5 do
		arg_92_0.progressBossHp[iter_92_0]:setPercentage(99)

		arg_92_0.lastBossHpPercent[iter_92_0] = 99
	end

	arg_92_0.lastBossMpPercent = 0

	arg_92_0:updateBossHp()
end

function zbCombatWnd.updateBossHp(arg_93_0)
	if arg_93_0.bossHero == nil then
		return
	end

	local var_93_0 = 2

	if COMBAT_TYPE_FRIENDBOSS == g_CombatSystem:getCombatType() then
		var_93_0 = 10

		if zbUtil:isValidTable(g_Self.kFriendHandler.curBossInfo) then
			if g_Self.kFriendHandler.curBossInfo.BossDegree == 1 then
				var_93_0 = 10
			elseif g_Self.kFriendHandler.curBossInfo.BossDegree == 2 then
				var_93_0 = 15
			end
		end
	elseif COMBAT_TYPE_LEGIONBOSS == g_CombatSystem:getCombatType() or COMBAT_TYPE_WORLDBOSS == g_CombatSystem:getCombatType() then
		var_93_0 = 50
	end

	local var_93_1 = 0
	local var_93_2 = arg_93_0.bossHero:getMpPercent()

	if arg_93_0.lastBossMpPercent ~= var_93_2 then
		arg_93_0.progressBossMp:runAction(CCProgressFromTo:create(0.35, arg_93_0.lastBossMpPercent, var_93_2))

		arg_93_0.lastBossMpPercent = var_93_2
	end

	for iter_93_0 = 1, 5 do
		arg_93_0.progressBossHp[iter_93_0]:setVisible(false)

		if arg_93_0.lastBossHpPercent[iter_93_0] <= 0 then
			arg_93_0.lastBossHpPercent[iter_93_0] = 99
		end
	end

	if arg_93_0.bossHero.curHp <= 0 then
		arg_93_0.bossHero.curHp = 0

		arg_93_0.progressBossHp[1]:setPercentage(0)
	end

	local var_93_3 = arg_93_0.bossHero.maxHp / var_93_0
	local var_93_4 = math.ceil(arg_93_0.bossHero.curHp / var_93_3)
	local var_93_5 = math.fmod(var_93_4, 5)

	if var_93_5 == 0 then
		var_93_5 = 5
	end

	if var_93_4 >= 2 then
		arg_93_0.progressBossHp[var_93_5]:setVisible(true)

		if var_93_5 == 1 then
			arg_93_0.progressBossHpTemp:setVisible(true)
			arg_93_0.progressBossHpTemp:setPercentage(99)
		else
			arg_93_0.progressBossHp[var_93_5 - 1]:setVisible(true)
			arg_93_0.progressBossHp[var_93_5 - 1]:setPercentage(99)
		end

		var_93_1 = (arg_93_0.bossHero.curHp - var_93_3 * (var_93_4 - 1)) / var_93_3 * 100

		arg_93_0.lbBossHpSection:setString(var_93_4)
		arg_93_0.lbBossHpSection:setVisible(true)
		arg_93_0.spriteBossHpX:setVisible(true)
	else
		var_93_1 = arg_93_0.bossHero.curHp / var_93_3 * 100

		arg_93_0.progressBossHp[1]:setVisible(true)
		arg_93_0.lbBossHpSection:setVisible(false)
		arg_93_0.spriteBossHpX:setVisible(false)
		arg_93_0.progressBossHpTemp:setVisible(false)
	end

	for iter_93_1 = 1, 5 do
		if arg_93_0.progressBossHp[iter_93_1]:isVisible() == false then
			arg_93_0.lastBossHpPercent[iter_93_1] = 99
		end
	end

	local var_93_6 = math.min(var_93_1, 99)

	if arg_93_0.lastBossHpPercent[var_93_5] ~= var_93_6 then
		arg_93_0.progressBossHp[var_93_5]:runAction(CCProgressFromTo:create(0.35, arg_93_0.lastBossHpPercent[var_93_5], var_93_6))

		arg_93_0.lastBossHpPercent[var_93_5] = var_93_6
	end
end

function zbCombatWnd.updateFocus(arg_94_0)
	if g_CombatSystem:isPvPCombatType() then
		return
	end

	local var_94_0 = g_CombatSystem.combatData.combatFocus:getCountdown()

	if var_94_0 > 0 then
		arg_94_0.lbFocusCD:setString(var_94_0)
	end

	arg_94_0.lbFocusCD:setVisible(var_94_0 > 0)
end

function zbCombatWnd.resetQteTimeFactor(arg_95_0)
	arg_95_0.fxNumTimeFactor = 2.2 / COMBAT_QTE_CIRCLE_TIME
end

function zbCombatWnd.showQteFx(arg_96_0, arg_96_1)
	if arg_96_1 ~= nil then
		arg_96_0.layerQte:setVisible(true)
		arg_96_0.layerQte:setPosition(arg_96_1:getFocusPos())
		arg_96_0.layerQteEval:setPosition(arg_96_1:getFocusPos())
		arg_96_0.layerQteEval:setPositionY(arg_96_0.layerQteEval:getPositionY() + 100)
		arg_96_0.fxQte:setAnimation("animation", false, arg_96_0.fxQteTimeScale / arg_96_0.fxNumTimeFactor)
		arg_96_0.btnQte:setVisible(true)

		arg_96_0.lastFxShowTime = os_timenow()

		echo("zbCombatWnd:showQteFx")
	end
end

function zbCombatWnd.isQteFxVisible(arg_97_0)
	return arg_97_0.layerQte:isVisible()
end

function zbCombatWnd.onQteTouch(arg_98_0, arg_98_1)
	local var_98_0 = g_CombatSystem.combatData.combatQte:getQteAttack()

	if var_98_0 == nil then
		echo("---- warning: invalid qte attacker")

		return
	end

	local var_98_1 = 0

	if arg_98_1 == nil then
		var_98_1 = 0.05
	end

	local var_98_2 = (function()
		local var_99_0 = EQTEEval.Bad
		local var_99_1 = (os_timenow() - arg_98_0.lastFxShowTime) * g_CombatSystem:getSpeed() / COMBAT_SPEED_10 / arg_98_0.fxNumTimeFactor

		if var_99_1 > COMBAT_QTE_CIRCLE_TIME + var_98_1 then
			var_99_0 = EQTEEval.Bad
		elseif var_99_1 > COMBAT_QTE_CIRCLE_TIME - 0.2 then
			var_99_0 = EQTEEval.Perfect
		elseif var_99_1 > COMBAT_QTE_CIRCLE_TIME - 0.7 then
			var_99_0 = EQTEEval.Great
		else
			var_99_0 = EQTEEval.Good
		end

		return var_99_0
	end)()
	local var_98_3 = arg_98_0:getEvalSequence(var_98_2)

	arg_98_0.fxPingjia:setAnimation(var_98_3, false, arg_98_0.fxPingjiaTimeScale)

	if var_98_2 > EQTEEval.Bad then
		g_EffectSystem:shake()
	end

	arg_98_0.btnQte:setVisible(false)
	var_98_0:setQteEval(var_98_2)
	echo("zbCombatWnd:onQteTouch, eval=" .. var_98_2)
end

function zbCombatWnd.getEvalSequence(arg_100_0, arg_100_1)
	local var_100_0 = ""

	if arg_100_1 == EQTEEval.Bad then
		var_100_0 = "bad"
	elseif arg_100_1 == EQTEEval.Good then
		var_100_0 = "good"
	elseif arg_100_1 == EQTEEval.Great then
		var_100_0 = "great"
	elseif arg_100_1 == EQTEEval.Perfect then
		var_100_0 = "perfect"
	end

	return var_100_0
end

function zbCombatWnd.getEvalDamageSpritePath(arg_101_0, arg_101_1)
	local var_101_0 = ""

	if arg_101_1 == EQTEEval.Good then
		var_101_0 = "ui/image/combat/battleui/combo/damage_11.png"
	elseif arg_101_1 == EQTEEval.Great then
		var_101_0 = "ui/image/combat/battleui/combo/damage_13.png"
	elseif arg_101_1 == EQTEEval.Perfect then
		var_101_0 = "ui/image/combat/battleui/combo/damage_15.png"
	end

	return var_101_0
end

function zbCombatWnd.hitShowCombo(arg_102_0, arg_102_1, arg_102_2)
	arg_102_0.lbQteComboCount:setString(arg_102_1.qteComboCount)

	local var_102_0 = CCArray:create()

	var_102_0:addObject(CCScaleTo:create(0.125, 1.5))
	var_102_0:addObject(CCScaleTo:create(0.1, 0.9))
	var_102_0:addObject(CCScaleTo:create(0.1, 1))

	local var_102_1 = CCSequence:create(var_102_0)

	arg_102_0.lbQteComboCount:stopAllActions()
	arg_102_0.lbQteComboCount:runAction(var_102_1)

	local var_102_2 = arg_102_0:getEvalDamageSpritePath(arg_102_1.qteEval)

	if var_102_2 ~= "" then
		arg_102_0.spriteQteComboDamage:setTexture(CCTextureCache:sharedTextureCache():addImage(var_102_2))

		local var_102_3 = CCArray:create()

		var_102_3:addObject(CCScaleTo:create(0.125, 1.5))
		var_102_3:addObject(CCScaleTo:create(0.1, 0.9))
		var_102_3:addObject(CCScaleTo:create(0.1, 1))

		local var_102_4 = CCSequence:create(var_102_3)

		arg_102_0.spriteQteComboDamage:stopAllActions()
		arg_102_0.spriteQteComboDamage:runAction(var_102_4)
	end

	if arg_102_0.layerQteCombo:isVisible() == false then
		local var_102_5 = CCArray:create()

		var_102_5:addObject(CCFadeIn:create(0.25))

		if arg_102_1.qteComboCount >= COMBAT_QTE_MAX_COMBO then
			var_102_5:addObject(CCDelayTime:create(1.5))
			var_102_5:addObject(CCFadeOut:create(0.25))
		end

		local var_102_6 = CCSequence:create(var_102_5)

		arg_102_0.layerQteCombo:stopAllActions()
		arg_102_0.layerQteCombo:runAction(var_102_6)
		arg_102_0.layerQteCombo:setOpacity(0)
		arg_102_0.layerQteCombo:setVisible(true)
	end
end

function zbCombatWnd.fadeOutCombo(arg_103_0)
	if arg_103_0.layerQteCombo:isVisible() then
		local function var_103_0()
			arg_103_0.layerQteCombo:setVisible(false)
		end

		local var_103_1 = CCArray:create()

		var_103_1:addObject(CCDelayTime:create(1))
		var_103_1:addObject(CCFadeOut:create(0.25))
		var_103_1:addObject(CCCallFuncN:create(var_103_0))

		local var_103_2 = CCSequence:create(var_103_1)

		arg_103_0.layerQteCombo:stopAllActions()
		arg_103_0.layerQteCombo:runAction(var_103_2)
	end
end

function zbCombatWnd.updateQte(arg_105_0)
	if g_CombatSystem:isPvPCombatType() then
		return
	end

	if arg_105_0.layerQte:isVisible() and os_timenow() - arg_105_0.lastFxShowTime >= COMBAT_QTE_CIRCLE_TIME * COMBAT_SPEED_10 / g_CombatSystem:getSpeed() * arg_105_0.fxNumTimeFactor then
		echo("zbCombatWnd:check qte timeout ")

		if arg_105_0.btnQte:isVisible() then
			arg_105_0:onQteTouch(true)
			echo("zbCombatWnd:atuo qte touch")
		end

		arg_105_0.layerQte:setVisible(false)

		arg_105_0.fxNumTimeFactor = 1

		echo("zbCombatWnd:hideQteFx")
	end

	if arg_105_0.layerQteCombo:isVisible() and arg_105_0.layerQteCombo:numberOfRunningActions() == 0 and g_CombatSystem.combatData.combatQte:getQteAttack() == nil then
		arg_105_0:fadeOutCombo()
	end
end

function zbCombatWnd.showReadyStartEffect(arg_106_0)
	arg_106_0.layerReadyStart:setVisible(true)
	arg_106_0.fxReadyStart:setAnimation("animation", false, 1 / COMBAT_SPEED_10)

	arg_106_0.fxReadyStartPlayTime = os_timenow()

	g_Audio:playSound("audio/sound/effect_readygo.mp3")
end

function zbCombatWnd.isReadyStartEffectComplete(arg_107_0)
	return os_timenow() - arg_107_0.fxReadyStartPlayTime >= arg_107_0.fxReadyStartDuration * COMBAT_SPEED_10 / g_CombatSystem:getSpeed()
end

function zbCombatWnd.hideReadyStartEffect(arg_108_0)
	arg_108_0.layerReadyStart:setVisible(false)
end

function zbCombatWnd.showFormationEffect(arg_109_0)
	arg_109_0.nodeLeftShape:setVisible(true)
	arg_109_0.nodeRightShape:setVisible(true)

	local var_109_0 = zbFormationHelper:formationAnimShow(arg_109_0.spriteLeftShape, arg_109_0.spriteLeftShapeName, arg_109_0.leftFormationId, arg_109_0.leftFormationLevel)
	local var_109_1 = zbFormationHelper:formationAnimShow(arg_109_0.spriteRightShape, arg_109_0.spriteRightShapeName, arg_109_0.rightFormationId, arg_109_0.rightFormationLevel)

	if var_109_0 then
		arg_109_0.nodeLeftShape:setVisible(true)
		arg_109_0.shapeLeftBubble:showFormationType(arg_109_0.leftFormationId, arg_109_0.leftFormationLevel)
	end

	if var_109_1 then
		arg_109_0.nodeRightShape:setVisible(true)

		if g_CombatSystem:isPvPCombatType() then
			arg_109_0.shapeRightBubble:showFormationType(arg_109_0.rightFormationId, arg_109_0.rightFormationLevel)
		end
	end

	return var_109_0 or var_109_1
end

function zbCombatWnd.hideFormationEffect(arg_110_0)
	arg_110_0.nodeLeftShape:setVisible(false)
	arg_110_0.nodeRightShape:setVisible(false)
	arg_110_0.spriteLeftShape:setVisible(false)
	arg_110_0.spriteRightShape:setVisible(false)
end

function zbCombatWnd.getHeroUI(arg_111_0, arg_111_1)
	for iter_111_0, iter_111_1 in pairs(arg_111_0.heroUIList) do
		if iter_111_1.hero:isSame(arg_111_1) then
			return iter_111_1
		end
	end

	return nil
end

function zbCombatWnd.onTouchTest(arg_112_0)
	local var_112_0 = arg_112_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_112_0.layerBuff, var_112_0.x, var_112_0.y) == false then
		arg_112_0.layerBuff:setVisible(false)
		arg_112_0.spritebuffBg:setVisible(false)
	end
end

function zbCombatWnd.onBuffList(arg_113_0)
	arg_113_0.layerBuff:setVisible(true)
	arg_113_0.spritebuffBg:setVisible(true)
end

function zbCombatWnd.refreshBuffList(arg_114_0)
	arg_114_0.layerBuff:setVisible(false)
	arg_114_0.spritebuffBg:setVisible(false)

	local var_114_0 = g_CombatSystem.combatData.leftPlayer:getBuffList()

	if zbUtil:isValidTable(var_114_0) == false then
		return
	end

	if arg_114_0.tableView == nil then
		local var_114_1 = arg_114_0.layerBuff:getContentSize()

		arg_114_0.tableViewHelper = zbTableViewHelper:create()
		arg_114_0.tableView = zbTableViewHelper:createTableView(var_114_1, var_114_1, 1, arg_114_0.tableViewHelper)

		arg_114_0.tableView:setPosition(0, 0)
		arg_114_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_114_0.layerBuff:addChild(arg_114_0.tableView)
	else
		arg_114_0.tableViewHelper:removeAllCells()
	end

	local var_114_2 = table.getn(var_114_0)
	local var_114_3 = table.getn(arg_114_0.buffItems)

	arg_114_0.lbBuffHint:setVisible(var_114_2 <= 0)

	for iter_114_0 = 1, var_114_3 do
		if iter_114_0 <= var_114_2 then
			local var_114_4 = arg_114_0.buffItems[iter_114_0]

			arg_114_0.tableViewHelper:addCell(var_114_4)
		end
	end

	if var_114_2 - var_114_3 > 0 then
		for iter_114_1 = 1, var_114_2 - var_114_3 do
			local var_114_5 = zbTableViewHelper:create()

			var_114_5:loadCCBFile("ccbi/tb_patabuff_txt.ccbi")

			local var_114_6 = zbPataBuffTxt:create(translateAndStrokeHelper(var_114_5:readCCBNode()), var_114_3 + iter_114_1)

			var_114_6:retain()

			arg_114_0.buffItems[var_114_3 + iter_114_1] = var_114_6

			arg_114_0.tableViewHelper:addCell(var_114_6)
			var_114_5:releaseSelf()
		end
	end

	local var_114_7 = 1

	for iter_114_2, iter_114_3 in pairs(var_114_0) do
		arg_114_0.buffItems[var_114_7]:refresh(iter_114_3)

		var_114_7 = var_114_7 + 1
	end

	arg_114_0.tableViewHelper:refreshTabelView()
	arg_114_0.tableViewHelper:setTouchPriority(arg_114_0.btnBuffList:getTouchPriority())
end

function zbCombatWnd.refreshTarget(arg_115_0)
	local var_115_0 = ""
	local var_115_1 = g_CombatSystem.combatData:getTrialType()

	if var_115_1 == 0 then
		var_115_0 = "击杀所有敌人"
	elseif var_115_1 == ETrialType.LimitRoundKill then
		var_115_0 = string.format("%d回合内击杀Boss", g_CombatRound.maxRound)
	elseif var_115_1 == ETrialType.LimitRoundSurvival then
		var_115_0 = string.format("%d回合内坚守存活", g_CombatRound.maxRound)
	elseif var_115_1 == ETrialType.ImageFight then
		var_115_0 = "击杀所有镜像敌人"
	elseif var_115_1 == ETrialType.NarrowMeet then
		var_115_0 = "击杀所有敌人"
	elseif var_115_1 == ETrialType.GoldCopy then
		var_115_0 = "伤害输出越高，获得奖励越多"
	end

	arg_115_0.lbTarget:setString(a2u(var_115_0))
end

function zbCombatWnd.onFocus(arg_116_0)
	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return
	end

	if g_CombatSystem.combatData.leftPlayer:isAllDied() or g_CombatSystem.combatData.rightPlayer:isAllDied() then
		echo("all died")

		return
	end

	if g_CombatSystem.combatData.combatFocus:isCanExecAndTip() == false then
		echo("combatFocus:isCanExecAndTi return false")

		return
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		g_Bubble:bubbleInfo("当前正在QTE中")

		return
	end

	if g_CombatSystem.combatData.combatQte:getQteTarget() ~= nil then
		g_Bubble:bubbleInfo("当前正在QTE中")

		return
	end

	g_MainScene:showCombatFocus()
end

function zbCombatWnd.nextChange(arg_117_0, arg_117_1, arg_117_2)
	if arg_117_1 == nil or arg_117_2 == 0 then
		return
	end

	for iter_117_0 = 1, 3 do
		local var_117_0 = arg_117_0.attrLbList[iter_117_0]
		local var_117_1 = arg_117_0.initPos[iter_117_0]
		local var_117_2 = CCArray:create()
		local var_117_3 = 0

		for iter_117_1 = iter_117_0, arg_117_2, 3 do
			local var_117_4 = math.ceil(zbUtil:random(25, 35))

			var_117_2:addObject(CCCallFuncN:create(function()
				var_117_0:setPosition(var_117_1)
				var_117_0:setString(arg_117_1[iter_117_1])
				var_117_0:setOpacity(0)
			end))
			var_117_2:addObject(CCFadeIn:create(0.125))
			var_117_2:addObject(CCEaseIn:create(CCMoveTo:create(1 + 0.2 * iter_117_0, ccp(var_117_1.x, var_117_1.y + var_117_4)), 0.8))
			var_117_2:addObject(CCFadeTo:create(0.05, 0))

			var_117_3 = var_117_3 + 1
		end

		if var_117_3 > 0 then
			local var_117_5 = CCSequence:create(var_117_2)

			var_117_0:stopAllActions()
			var_117_0:runAction(var_117_5)
		end
	end
end

function zbCombatWnd.onSkillDetailDown(arg_119_0)
	arg_119_0.skillDetail:setVisible(true)

	if arg_119_0.bossHero == nil then
		return
	end

	arg_119_0.iconSkill2:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getSkillIconPath(arg_119_0.bossHero.heroRecord.skillId1)))

	local var_119_0 = zbHeroSkillTable:getRecord(arg_119_0.bossHero.heroRecord.skillId1)

	if var_119_0 then
		arg_119_0.lbSkillName:setString(var_119_0.name)
		arg_119_0.lbSkillDesc:setString(var_119_0.descBase)
	end
end

function zbCombatWnd.onSkillDetailEnd(arg_120_0)
	arg_120_0.skillDetail:setVisible(false)
end
