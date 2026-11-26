require("gamelogic.zbUIEffect")

zbWarLevelTag = class("zbWarLevelTag", CCNodeExtend)
zbWarLevelTag.__index = zbWarLevelTag

function zbWarLevelTag.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWarLevelTag)

	return arg_1_0
end

function zbWarLevelTag.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbWarLevelTag.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbWarLevelTag.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.stageIndex = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerSolider = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		arg_3_0.layerGeneral = tolua.cast(var_5_0:getChildByTag(2), "CCNode")
		arg_3_0.btnSoliderStage = tolua.cast(arg_3_0.layerSolider:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteSoliderStage = tolua.cast(arg_3_0.layerSolider:getChildByTag(2), "CCSprite")
		arg_3_0.spriteSoliderArrow = tolua.cast(arg_3_0.layerSolider:getChildByTag(3), "CCSprite")
		arg_3_0.btnGeneralStage = tolua.cast(arg_3_0.layerGeneral:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteGeneralStage = tolua.cast(arg_3_0.layerGeneral:getChildByTag(2), "CCSprite")
		arg_3_0.spriteGeneralArrow = tolua.cast(arg_3_0.layerGeneral:getChildByTag(3), "CCSprite")
		arg_3_0.spriteBoss = tolua.cast(arg_3_0.layerGeneral:getChildByTag(4), "CCSprite")
		arg_3_0.spriteStars = {}
		arg_3_0.spriteStars[1] = tolua.cast(arg_3_0.layerGeneral:getChildByTag(5), "CCSprite")
		arg_3_0.spriteStars[2] = tolua.cast(arg_3_0.layerGeneral:getChildByTag(6), "CCSprite")
		arg_3_0.spriteStars[3] = tolua.cast(arg_3_0.layerGeneral:getChildByTag(7), "CCSprite")
		arg_3_0.nodeTalk = tolua.cast(arg_3_0.layerGeneral:getChildByTag(10), "CCNode")
		arg_3_0.spriteTalk = tolua.cast(arg_3_0.nodeTalk:getChildByTag(6), "CCSprite")
		arg_3_0.lbTalk = tolua.cast(arg_3_0.nodeTalk:getChildByTag(7), "CCLabelTTF")

		zbUtil:setCascadeOpacityEnabled(arg_3_0.nodeTalk, true)

		arg_3_0.centerPositionX = arg_3_0.spriteStars[2]:getPositionX()

		arg_3_0.btnSoliderStage:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGeneralStage:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0.spriteSoliderStage:setCascadeOpacityEnabled(true)
		arg_3_0.spriteGeneralStage:setCascadeOpacityEnabled(true)

		arg_3_0.spriteSoliderArrowInitPos = ccp(arg_3_0.spriteSoliderArrow:getPosition())
		arg_3_0.spriteGeneralArrowInitPos = ccp(arg_3_0.spriteGeneralArrow:getPosition())
		arg_3_0.spriteGeneralArrowInitPosY = arg_3_0.spriteGeneralArrowInitPos.y
	end

	var_3_0()
	var_3_1()
end

function zbWarLevelTag.bind(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.levelType = arg_8_1
	arg_8_0.forceId = arg_8_2
	arg_8_0.levelId = tonumber(string.format("%d%.4d", arg_8_2, arg_8_3))
	arg_8_0.stageIndex = arg_8_3

	arg_8_0:refershGeneralButton()

	if zbForceSetTable:getLastLevelId(arg_8_0.forceId) == arg_8_0.levelId then
		arg_8_0.spriteGeneralArrowInitPos.y = arg_8_0.spriteGeneralArrowInitPosY + 20
	end
end

function zbWarLevelTag.refershSoliderButton(arg_9_0)
	local var_9_0 = "image/warpath/forcedetail/stage_normal.png"
	local var_9_1 = "image/warpath/forcedetail/stage_press.png"
	local var_9_2 = "image/warpath/forcedetail/stage_disable.png"
	local var_9_3 = arg_9_0.stageIndex % 3 == 0

	if arg_9_0.levelType == ELevelType.Normal and var_9_3 == false and arg_9_0.levelId < g_Self.kWarPathHandler.levelModes[arg_9_0.levelType].curLevelId then
		var_9_0 = "image/warpath/forcedetail/stage_passed.png"
		var_9_1 = "image/warpath/forcedetail/stage_passed.png"
		var_9_2 = "image/warpath/forcedetail/stage_passed.png"
	end

	require("gamebase.zbUI"):setButtonPic(arg_9_0.btnSoliderStage, var_9_0, var_9_1, var_9_2)
end

function zbWarLevelTag.refershGeneralButton(arg_10_0)
	if arg_10_0.stageIndex % 3 == 0 and arg_10_0.btnSoliderStage ~= nil then
		local var_10_0 = zbForceSetTable:getRecord(arg_10_0.levelId)

		if var_10_0.levelIcon == "" then
			var_10_0.levelIcon = "image/icon/leveltag/50003.png"
		end

		local var_10_1 = arg_10_0.stageIndex / 3

		require("gamebase.zbUI"):setButtonPic(arg_10_0.btnGeneralStage, var_10_0.levelIcon, var_10_0.levelIcon, var_10_0.levelIcon)
		zbUtil:setHighlightSprite(arg_10_0.btnGeneralStage, var_10_0.levelIcon)
		arg_10_0.spriteGeneralStage:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_0.levelIcon))
	end
end

function zbWarLevelTag.refresh(arg_11_0, arg_11_1)
	if zbForceSetTable:getRecord(arg_11_0.levelId) == nil then
		return
	end

	local var_11_0 = g_Self.kWarPathHandler.levelModes[arg_11_0.levelType].curLevelId
	local var_11_1 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, arg_11_0.forceId, arg_11_0.levelId)
	local var_11_2 = arg_11_0.stageIndex % 3 == 0
	local var_11_3 = zbForceSetTable:getLastLevelId(arg_11_0.forceId) == arg_11_0.levelId
	local var_11_4 = g_MainScene.wndWarForce.btnLeft:getTouchPriority()

	arg_11_0.btnSoliderStage:setTouchPriority(var_11_4)
	arg_11_0.btnGeneralStage:setTouchPriority(var_11_4)
	arg_11_0:refershSoliderButton()
	arg_11_0.spriteBoss:setVisible(var_11_3)
	arg_11_0.layerSolider:setVisible(not var_11_2)
	arg_11_0.layerGeneral:setVisible(var_11_2)

	if arg_11_0.levelType == ELevelType.Nightmare then
		arg_11_0.layerSolider:setVisible(not var_11_3)
		arg_11_0.layerGeneral:setVisible(var_11_3)
	end

	if arg_11_0.levelType == ELevelType.Elite and var_11_1 <= 0 or var_11_0 < arg_11_0.levelId or arg_11_0.levelType == ELevelType.Elite and var_11_2 == false then
		arg_11_0.spriteSoliderArrow:setVisible(false)
		arg_11_0.spriteGeneralArrow:setVisible(false)
		arg_11_0.spriteSoliderArrow:stopAllActions()
		arg_11_0.spriteGeneralArrow:stopAllActions()
		arg_11_0.nodeTalk:setVisible(false)
		arg_11_0:setGray(true)
		arg_11_0.spriteBoss:setGray(false)
		arg_11_0.btnSoliderStage:setVisible(false)
		arg_11_0.spriteSoliderStage:setVisible(true)
		arg_11_0.btnGeneralStage:setVisible(false)
		arg_11_0.spriteGeneralStage:setVisible(true)
	elseif arg_11_0.levelType == ELevelType.Nightmare and var_11_3 == false then
		arg_11_0.spriteSoliderArrow:setVisible(false)
		arg_11_0.spriteGeneralArrow:setVisible(false)
		arg_11_0.spriteSoliderArrow:stopAllActions()
		arg_11_0.spriteGeneralArrow:stopAllActions()
		arg_11_0.nodeTalk:setVisible(false)
		arg_11_0:setGray(true)
		arg_11_0.btnSoliderStage:setVisible(false)
		arg_11_0.spriteSoliderStage:setVisible(true)
		arg_11_0.btnGeneralStage:setVisible(false)
		arg_11_0.spriteGeneralStage:setVisible(true)
	elseif arg_11_0.levelId == var_11_0 then
		arg_11_0.spriteSoliderArrow:setVisible(true)
		arg_11_0:refreshTalk(arg_11_1)
		arg_11_0:createArrowMoveAction(arg_11_0.spriteSoliderArrow, arg_11_0.spriteSoliderArrowInitPos)
		arg_11_0:createArrowMoveAction(arg_11_0.spriteGeneralArrow, arg_11_0.spriteGeneralArrowInitPos)
		arg_11_0:setGray(false)
		arg_11_0.btnSoliderStage:setVisible(true)
		arg_11_0.spriteSoliderStage:setVisible(false)
		arg_11_0.btnGeneralStage:setVisible(true)
		arg_11_0.spriteGeneralStage:setVisible(false)
	elseif var_11_0 > arg_11_0.levelId then
		arg_11_0.spriteSoliderArrow:setVisible(false)
		arg_11_0.spriteGeneralArrow:setVisible(false)
		arg_11_0.spriteSoliderArrow:stopAllActions()
		arg_11_0.spriteGeneralArrow:stopAllActions()
		arg_11_0.nodeTalk:setVisible(false)
		arg_11_0:setGray(false)
		arg_11_0.btnSoliderStage:setVisible(true)
		arg_11_0.spriteSoliderStage:setVisible(false)
		arg_11_0.btnGeneralStage:setVisible(true)
		arg_11_0.spriteGeneralStage:setVisible(false)
	end

	local var_11_5 = g_Self.kWarPathHandler:getLevelStar(arg_11_0.levelType, arg_11_0.forceId, arg_11_0.levelId)

	for iter_11_0 = 1, 3 do
		local var_11_6 = false

		if iter_11_0 <= var_11_5 then
			var_11_6 = true
		end

		arg_11_0.spriteStars[iter_11_0]:setVisible(var_11_6)
	end

	zbUIEffect:centerStar(arg_11_0.spriteStars, arg_11_0.centerPositionX)

	if arg_11_1 == EForceEnterWay.FragWay then
		arg_11_0.nodeTalk:setVisible(false)

		if arg_11_0.levelType == g_curFragLevelMode and arg_11_0.forceId == g_curFragForceId and arg_11_0.levelId == g_curFragLevelId then
			arg_11_0.spriteSoliderArrow:setVisible(true)
			arg_11_0.spriteGeneralArrow:setVisible(true)
			arg_11_0:createArrowMoveAction(arg_11_0.spriteSoliderArrow, arg_11_0.spriteSoliderArrowInitPos)
			arg_11_0:createArrowMoveAction(arg_11_0.spriteGeneralArrow, arg_11_0.spriteGeneralArrowInitPos)
		else
			arg_11_0.spriteSoliderArrow:setVisible(false)
			arg_11_0.spriteGeneralArrow:setVisible(false)
			arg_11_0.spriteSoliderArrow:stopAllActions()
			arg_11_0.spriteGeneralArrow:stopAllActions()
		end
	end
end

function zbWarLevelTag.refreshTalk(arg_12_0, arg_12_1)
	if arg_12_1 == EForceEnterWay.FragWay or arg_12_0.levelType == ELevelType.Nightmare then
		arg_12_0.nodeTalk:setVisible(false)

		return
	end

	local var_12_0 = zbForceSetTable:getRecord(arg_12_0.levelId)

	arg_12_0.lbTalk:setString(var_12_0.desc2)
	arg_12_0.lbTalk:setOpacity(255)
	arg_12_0.spriteTalk:setOpacity(255)
	arg_12_0.nodeTalk:setVisible(true)
	arg_12_0.spriteGeneralArrow:setVisible(false)

	local var_12_1 = CCArray:create()

	var_12_1:addObject(CCDelayTime:create(2))
	var_12_1:addObject(CCCallFuncN:create(function()
		arg_12_0.spriteTalk:stopAllActions()
		arg_12_0.spriteTalk:runAction(CCFadeOut:create(1))
		arg_12_0.lbTalk:stopAllActions()
		arg_12_0.lbTalk:runAction(CCFadeOut:create(2))
	end))
	var_12_1:addObject(CCDelayTime:create(0.5))
	var_12_1:addObject(CCCallFuncN:create(function()
		arg_12_0.spriteGeneralArrow:setVisible(true)
		arg_12_0.nodeTalk:setVisible(false)
	end))

	local var_12_2 = CCSequence:create(var_12_1)

	arg_12_0.nodeTalk:stopAllActions()
	arg_12_0.nodeTalk:runAction(var_12_2)
end

function zbWarLevelTag.onTouch(arg_15_0)
	if arg_15_0.levelType == ELevelType.Nightmare then
		return
	end

	if arg_15_0.levelType == ELevelType.Normal and arg_15_0.stageIndex % 3 == 0 == false and arg_15_0.levelId < g_Self.kWarPathHandler.levelModes[arg_15_0.levelType].curLevelId then
		return
	end

	if arg_15_0:isGray() then
		g_Bubble:bubbleInfo("\xB9ؿ\xA8\xC9\xD0δ\xBD\xE2\xCB\xF8")
	else
		g_MainScene:showLevelDialog(arg_15_0.levelType, arg_15_0.forceId, arg_15_0.levelId)
	end
end

function zbWarLevelTag.createArrowMoveAction(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:setPosition(arg_16_2)

	local var_16_0 = 0.9
	local var_16_1 = 15
	local var_16_2 = ccp(arg_16_1:getPosition())

	var_16_2.y = var_16_2.y - var_16_1

	local var_16_3 = CCMoveTo:create(var_16_0, var_16_2)

	var_16_2.y = var_16_2.y + var_16_1 * 2

	local var_16_4 = CCMoveTo:create(var_16_0, var_16_2)
	local var_16_5 = CCArray:create()

	var_16_5:addObject(var_16_3)
	var_16_5:addObject(var_16_4)

	local var_16_6 = CCSequence:create(var_16_5)

	arg_16_1:stopAllActions()
	arg_16_1:runAction(CCRepeatForever:create(var_16_6))
end
