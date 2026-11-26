require("gamelogic.zbItem")

zbPataWnd_Fight = class("zbPataWnd_Fight")
zbPataWnd_Fight.__index = zbPataWnd_Fight

function createPataWnd_Fight(arg_1_0, arg_1_1)
	local var_1_0 = zbPataWnd_Fight.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function zbPataWnd_Fight.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.layer = arg_2_1
		arg_2_0.parent = arg_2_2
	end

	local function var_2_1()
		function initAvatar(arg_5_0)
			local var_5_0
			local var_5_1 = CCSprite:create("image/combat/yingzi.png")

			var_5_1:setPosition(0, 5)
			var_5_1:setFlipX(true)
			arg_5_0:addChild(var_5_1)

			local var_5_2 = createUIAnimation()

			var_5_2:setPosition(0, 0)
			arg_5_0:addChild(var_5_2)

			return var_5_2
		end

		arg_2_0.lbCanSweep = tolua.cast(arg_2_1:getChildByTag(4), "CCLabelTTF")
		arg_2_0.btnSweep = tolua.cast(arg_2_1:getChildByTag(5), "CCControlButton")
		arg_2_0.btnFight = tolua.cast(arg_2_1:getChildByTag(6), "CCControlButton")

		arg_2_0.btnSweep:addHandleOfControlEvent(function()
			arg_2_0:onSweep()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnFight:addHandleOfControlEvent(function()
			arg_2_0:onFight()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function zbPataWnd_Fight.refresh(arg_8_0, arg_8_1)
	arg_8_0.PataInfo = arg_8_1
	arg_8_0.run = false

	arg_8_0.parent.nodeEnemy:setVisible(false)
	arg_8_0.parent.nodeInfo:setVisible(false)
	arg_8_0.btnSweep:setVisible(false)
	arg_8_0.btnFight:setVisible(false)
	arg_8_0.lbCanSweep:setVisible(false)

	if zbUtil:isValidTable(arg_8_0.PataInfo.FightLayerInfo.PlayerInfo) == false then
		return
	end

	arg_8_0:refreshBase()

	if arg_8_0.PataInfo.FightLayerInfo.FightResultState == 0 then
		arg_8_0.parent.enemyAvatar:refreshAvatarId(arg_8_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.HeadId)
		arg_8_0.parent.enemyAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
		arg_8_0.parent.btnGoOn:setVisible(false)
	else
		arg_8_0.parent.enemyAvatar:refreshAvatarId(arg_8_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.HeadId)
		arg_8_0.parent.enemyAvatar:setAnimation(ANIMATION_SEQUENCE_DIE, false)
		arg_8_0.parent.btnGoOn:setVisible(true)
	end

	arg_8_0:playEffect()
end

function zbPataWnd_Fight.refreshBase(arg_9_0)
	arg_9_0.layer:setVisible(true)

	local var_9_0 = zbPataMatchBossTable:getRecord(arg_9_0.PataInfo.BaseInfo.Layer)

	if var_9_0 ~= nil then
		arg_9_0.parent.lbBaseScore:setString(var_9_0.baseScore)
	end

	arg_9_0.parent.lbName:setString(arg_9_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.RoleName)
	arg_9_0.parent.lbLevel:setString(arg_9_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.Level)
	arg_9_0.parent.lbPower:setString(arg_9_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.FV)

	arg_9_0.heroRecord = zbHeroTable:getRecord(arg_9_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.HeadId)

	if arg_9_0.heroRecord == nil then
		echoInfo("zbHero:init: roleTempalte == nil(templateId=" .. arg_9_0.PataInfo.FightLayerInfo.PlayerInfo.PlayerBaseInfo.HeadId .. ")")

		return
	end

	arg_9_0.avatarRecord = zbAvatarTable:getRecord(arg_9_0.heroRecord.avatarId)

	if arg_9_0.avatarRecord == nil then
		echoInfo("zbHero:init: monster == nil")

		return
	end

	if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
		arg_9_0.parent.nodeEnemy:setPosition(arg_9_0.parent.positionEnemy)
		arg_9_0.parent.nodeInfo:setPosition(arg_9_0.parent.positionEnemy.x, arg_9_0.parent.positionEnemy.y + arg_9_0.avatarRecord.hudOffset.y)
		arg_9_0.parent.enemyAvatar:setRotationY(0)
	else
		arg_9_0.parent.nodeEnemy:setPosition(arg_9_0.parent.positionEnemyTemp)
		arg_9_0.parent.nodeInfo:setPosition(arg_9_0.parent.positionEnemyTemp.x, arg_9_0.parent.positionEnemyTemp.y + arg_9_0.avatarRecord.hudOffset.y)
		arg_9_0.parent.enemyAvatar:setRotationY(180)
	end

	if arg_9_0.PataInfo.BaseInfo.TodaySaoDangLayer > arg_9_0.PataInfo.BaseInfo.Layer then
		arg_9_0.lbCanSweep:setString(a2u("\xBF\xC9ɨ\xB5\xB4\xB5\xBD:") .. arg_9_0.PataInfo.BaseInfo.TodaySaoDangLayer .. a2u("\xB2\xE3"))
	end
end

function zbPataWnd_Fight.onFight(arg_10_0)
	if arg_10_0.run == true then
		return
	end

	arg_10_0.parent.moneyPanel.btnClose:setVisible(false)

	arg_10_0.run = true

	local var_10_0 = 0
	local var_10_1 = 0

	if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
		var_10_0 = arg_10_0.parent.positionEnemy.x - 100
		var_10_1 = arg_10_0.parent.positionEnemy.y - 20
	else
		var_10_0 = arg_10_0.parent.positionEnemyTemp.x + 100
		var_10_1 = arg_10_0.parent.positionEnemyTemp.y - 20
	end

	arg_10_0.parent.heroAvatar:setAnimation(ANIMATION_SEQUENCE_MOVE, true)

	local var_10_2 = CCArray:create()

	var_10_2:addObject(CCMoveTo:create(2, ccp(var_10_0, var_10_1)))
	var_10_2:addObject(CCCallFuncN:create(function()
		g_MainScene:showEmbattlePata(arg_10_0.PataInfo.FightLayerInfo.PlayerInfo, arg_10_0.PataInfo.BaseInfo.Layer)

		arg_10_0.run = false
	end))

	local var_10_3 = CCSequence:create(var_10_2)

	arg_10_0.parent.nodeHero:stopAllActions()
	arg_10_0.parent.nodeHero:runAction(var_10_3)
end

function zbPataWnd_Fight.onSweep(arg_12_0)
	g_WsMsgHandler:WS_Pata_StartSaoDang_Req()
end

function zbPataWnd_Fight.playEffect(arg_13_0)
	local var_13_0 = 0

	local function var_13_1(arg_14_0, arg_14_1)
		local function var_14_0(arg_15_0)
			arg_15_0:setVisible(true)
		end

		local var_14_1 = CCArray:create()

		var_14_1:addObject(CCDelayTime:create(var_13_0))
		var_14_1:addObject(CCCallFuncN:create(var_14_0))
		arg_14_0:setVisible(false)
		arg_14_0:stopAllActions()
		arg_14_0:runAction(CCSequence:create(var_14_1))

		var_13_0 = var_13_0 + arg_14_1
	end

	var_13_1(arg_13_0.parent.nodeEnemy, 0.25)
	var_13_1(arg_13_0.parent.nodeInfo, 0.25)

	if arg_13_0.PataInfo.FightLayerInfo.FightResultState == 0 then
		var_13_1(arg_13_0.btnFight, 0.25)

		if arg_13_0.PataInfo.BaseInfo.TodaySaoDangLayer > arg_13_0.PataInfo.BaseInfo.Layer then
			var_13_1(arg_13_0.btnSweep, 0.25)
			var_13_1(arg_13_0.lbCanSweep, 0)
		end
	elseif arg_13_0.PataInfo.BaseInfo.Layer < zbPataLayerBaseTable.number then
		var_13_1(arg_13_0.parent.btnGoOn, 0.25)
	end
end
