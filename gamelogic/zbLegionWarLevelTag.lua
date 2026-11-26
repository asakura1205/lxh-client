require("gamelogic.zbUIEffect")

zbLegionWarLevelTag = class("zbLegionWarLevelTag", CCNodeExtend)
zbLegionWarLevelTag.__index = zbLegionWarLevelTag

function zbLegionWarLevelTag.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionWarLevelTag)

	return arg_1_0
end

function zbLegionWarLevelTag.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbLegionWarLevelTag.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbLegionWarLevelTag.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.stageIndex = arg_3_2
	end

	local function var_3_1()
		arg_3_0.btnGeneralStage = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteGeneralStage = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")
		arg_3_0.spriteGeneralArrow = tolua.cast(arg_3_1:getChildByTag(3), "CCSprite")
		arg_3_0.spriteBoss = tolua.cast(arg_3_1:getChildByTag(4), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_1:getChildByTag(5), "CCLabelTTF")
		arg_3_0.spriteLock = tolua.cast(arg_3_1:getChildByTag(6), "CCSprite")
		arg_3_0.spriteBarBg = tolua.cast(arg_3_1:getChildByTag(7), "CCSprite")
		arg_3_0.spriteHurted = tolua.cast(arg_3_1:getChildByTag(8), "CCSprite")
		arg_3_0.spriteUp = tolua.cast(arg_3_1:getChildByTag(9), "CCSprite")

		local function var_5_0(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(0)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		arg_3_0.spriteBar = var_5_0(arg_3_0.spriteBarBg, "image/balance/balance_progress_red.png")

		arg_3_0.btnGeneralStage:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0.spriteGeneralStage:setCascadeOpacityEnabled(true)
	end

	var_3_0()
	var_3_1()
end

function zbLegionWarLevelTag.bind(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.warNodeInfo = arg_8_1
	arg_8_0.stageIndex = arg_8_2

	local var_8_0 = zbWarNodeTable:getRecord(arg_8_0.warNodeInfo.NodeId)

	if var_8_0 == nil then
		return
	end

	local var_8_1 = var_8_0.buildNode[arg_8_0.stageIndex]

	if var_8_1 == nil then
		return
	end

	arg_8_0:refershGeneralButton(var_8_1)
	arg_8_0.spriteBoss:setVisible(arg_8_0.stageIndex == 5)
	arg_8_0.lbName:setString(var_8_1.buildName)
end

function zbLegionWarLevelTag.refershGeneralButton(arg_9_0, arg_9_1)
	arg_9_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_9_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/legionwar.plist")

	local var_9_0 = arg_9_0.spriteframeCache:spriteFrameByName(arg_9_1.buildIcon)

	if var_9_0 then
		arg_9_0.spriteGeneralStage:initWithSpriteFrame(var_9_0)
	end
end

function zbLegionWarLevelTag.refresh(arg_10_0)
	local var_10_0 = zbWarNodeTable:getRecord(arg_10_0.warNodeInfo.NodeId)

	if var_10_0 == nil then
		echo("......warNodeRecord...", arg_10_0.warNodeInfo.NodeId)

		return
	end

	local var_10_1 = g_MainScene.wndLegionWarPosition.moneyPanel.btnClose:getTouchPriority()

	arg_10_0.btnGeneralStage:setTouchPriority(var_10_1)

	local var_10_2

	for iter_10_0, iter_10_1 in pairs(arg_10_0.warNodeInfo.BuildList) do
		if iter_10_1.BuildId == arg_10_0.stageIndex then
			var_10_2 = iter_10_1

			break
		end
	end

	arg_10_0.spriteUp:setVisible(arg_10_0.stageIndex == 2 or arg_10_0.stageIndex == 3)

	if var_10_2.LeftHp <= 0 or arg_10_0.warNodeInfo.NodeState == ELegionWarNodeState.Occupy then
		arg_10_0.btnGeneralStage:setVisible(false)
		arg_10_0.spriteGeneralStage:setGray(true)
		arg_10_0.spriteGeneralArrow:setVisible(false)
		arg_10_0.spriteLock:setVisible(false)
		arg_10_0.spriteBarBg:setVisible(false)
		arg_10_0.spriteHurted:setVisible(true)
		arg_10_0.spriteUp:setVisible(false)

		if arg_10_0.stageIndex == 2 then
			g_MainScene.wndLegionWarPosition.lbJiaCheng1:setVisible(false)
		end

		if arg_10_0.stageIndex == 3 then
			g_MainScene.wndLegionWarPosition.lbJiaCheng2:setVisible(false)
		end

		return
	end

	arg_10_0.spriteHurted:setVisible(false)

	local var_10_3 = var_10_0.buildNode[arg_10_0.stageIndex]

	if var_10_3 == nil then
		echo("......buildRecord...", arg_10_0.stageIndex)

		return
	end

	local var_10_4 = false

	for iter_10_2, iter_10_3 in pairs(var_10_3.buildPre) do
		for iter_10_4, iter_10_5 in pairs(arg_10_0.warNodeInfo.BuildList) do
			if iter_10_3 == iter_10_5.BuildId and iter_10_5.LeftHp <= 0 then
				var_10_4 = true

				break
			end
		end
	end

	if var_10_4 == true or table.getn(var_10_3.buildPre) == 0 then
		arg_10_0.btnGeneralStage:setVisible(true)
		arg_10_0.spriteGeneralStage:setGray(false)
		arg_10_0.spriteGeneralArrow:setVisible(true)
		arg_10_0.spriteLock:setVisible(false)
		arg_10_0.spriteBarBg:setVisible(true)

		local var_10_5 = math.min(100 * (var_10_2.LeftHp / var_10_2.HpMax), 100)

		arg_10_0.spriteBar:setPercentage(var_10_5)
		zbUIEffect:createArrowMoveAction(arg_10_0.spriteGeneralArrow, 5, 1)
	else
		arg_10_0.btnGeneralStage:setVisible(false)
		arg_10_0.spriteGeneralStage:setGray(true)
		arg_10_0.spriteGeneralArrow:setVisible(false)
		arg_10_0.spriteLock:setVisible(true)
		arg_10_0.spriteBarBg:setVisible(false)
	end
end

function zbLegionWarLevelTag.onTouch(arg_11_0)
	if arg_11_0.warNodeInfo.Legion.LegionId == g_GameData.LegionInfo.LegionId then
		return
	end

	local var_11_0

	for iter_11_0, iter_11_1 in pairs(arg_11_0.warNodeInfo.BuildList) do
		if iter_11_1.BuildId == arg_11_0.stageIndex then
			var_11_0 = iter_11_1

			break
		end
	end

	if var_11_0.LeftHp <= 0 then
		return
	end

	if arg_11_0.warNodeInfo.Legion.LegionId == 0 then
		g_MainScene:showLegionWarFightWnd(arg_11_0.warNodeInfo, arg_11_0.stageIndex, ELgionWarFight.E_NodeNPC)

		return
	end

	g_WsMsgHandler:WS_LegionWar_BuildDefendInfo_Req(arg_11_0.warNodeInfo.NodeId, arg_11_0.stageIndex)
end
