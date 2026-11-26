require("gamelogic.zbLegionHeroTrainItem")

local var_0_0 = class("zbLegionHeroTrainWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createLegionHeroTrainWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.trainItems = {}
		arg_3_0.index = nil
	end

	local function var_3_1()
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
			var_6_1:setPosition(1, 0)
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		function initAvatar(arg_7_0)
			local var_7_0
			local var_7_1 = CCSprite:create("image/combat/yingzi.png")

			var_7_1:setPosition(0, 5)
			var_7_1:setFlipX(true)
			arg_7_0:addChild(var_7_1)

			local var_7_2 = createUIAnimation()

			var_7_2:setPosition(0, 0)
			arg_7_0:addChild(var_7_2)

			return var_7_2
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/legionHeroTrain.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layer = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.heroNode = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCNode")
		arg_3_0.hintFinish = tolua.cast(arg_3_0.layer:getChildByTag(5), "CCNode")
		arg_3_0.lbhintFinish = tolua.cast(arg_3_0.hintFinish:getChildByTag(1), "CCLabelTTF")
		arg_3_0.hintOpen = tolua.cast(arg_3_0.layer:getChildByTag(6), "CCNode")
		arg_3_0.lbhintOpen = tolua.cast(arg_3_0.hintOpen:getChildByTag(1), "CCLabelTTF")

		arg_3_0.hintFinish:setVisible(false)
		arg_3_0.hintOpen:setVisible(false)

		arg_3_0.layerDetail = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCNode")
		arg_3_0.lbName = tolua.cast(arg_3_0.layerDetail:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLevel = tolua.cast(arg_3_0.layerDetail:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.layerDetail:getChildByTag(5), "CCSprite")
		arg_3_0.lbCountDummy = tolua.cast(arg_3_0.layerDetail:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnGetReward = tolua.cast(arg_3_0.layerDetail:getChildByTag(8), "CCControlButton")
		arg_3_0.levelup_fg = tolua.cast(arg_3_0.layerDetail:getChildByTag(200), "CCSprite")
		arg_3_0.levelupPre = var_5_0(arg_3_0.levelup_fg, "image/common/progress.png")
		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCountDummy, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.48)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnRuleDesc = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteShadow = CCSprite:create("image/combat/yingzi.png")

		arg_3_0.spriteShadow:setScale(1.3)
		arg_3_0.spriteShadow:setPosition(8, -67)
		arg_3_0.heroNode:addChild(arg_3_0.spriteShadow)

		arg_3_0.heroAvatar = initAvatar(arg_3_0.heroNode)

		arg_3_0.btnRuleDesc:addHandleOfControlEvent(function()
			arg_3_0:onOpenRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGetReward:addHandleOfControlEvent(function()
			arg_3_0:onGetReward()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerContent = tolua.cast(arg_3_0.layer:getChildByTag(4), "CCNode")
		arg_3_0.maskPanelLeft = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCNode")
		arg_3_0.maskPanelRight = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCNode")

		zbUIEffect:runFadeToAction(arg_3_0.maskPanelLeft)
		zbUIEffect:runFadeToAction(arg_3_0.maskPanelRight)

		for iter_5_0, iter_5_1 in pairs(arg_3_0.trainItems) do
			iter_5_1:removeFromParentAndCleanup(false)
		end

		if arg_3_0.tableView ~= nil then
			arg_3_0.tableView:removeFromParentAndCleanup(true)

			arg_3_0.tableView = nil
			arg_3_0.tableViewHelper = nil
		end

		local var_5_4 = table.getn(g_Self.kLegionHandler.legionDetail.Train)
		local var_5_5 = arg_3_0.layerContent:getContentSize()
		local var_5_6 = CCSizeMake(HeroTrainListItem_Width * var_5_4, HeroTrainListItem_Height)
		local var_5_7 = CCSizeMake(var_5_5.width, var_5_5.height)

		arg_3_0.tableViewHelper = zbTableViewHelper:create()
		arg_3_0.tableView = zbTableViewHelper:createTableView(var_5_6, var_5_7, kCCScrollViewDirectionHorizontal, arg_3_0.tableViewHelper)

		arg_3_0.tableView:setPosition(0, 0)
		arg_3_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_3_0.layerContent:addChild(arg_3_0.tableView)
		arg_3_0.tableViewHelper:setMaskPanel(arg_3_0.maskPanelLeft, arg_3_0.maskPanelRight, nil, nil)

		local var_5_8 = zbTableViewHelper:create()

		var_5_8:loadCCBFile("ccbi/tb_herotrain_Item.ccbi")

		for iter_5_2, iter_5_3 in pairs(g_Self.kLegionHandler.legionDetail.Train) do
			local var_5_9 = createLegionHeroTrainItem(translateAndStrokeHelper(var_5_8:readCCBNode()), arg_3_0)

			var_5_9:retain()

			arg_3_0.trainItems[iter_5_3.Index] = var_5_9

			arg_3_0.tableViewHelper:addCell(var_5_9)
		end

		arg_3_0.tableViewHelper:refreshTabelView()
		arg_3_0.tableViewHelper:setTouchPriority(arg_3_0.btnRuleDesc:getTouchPriority())
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionTrainStart_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionTrainComplete_Ack)
end

function var_0_0.onOpenRule(arg_13_0)
	g_MainScene:showRuleWnd(RuleType_LegionTrain)
end

function var_0_0.onGetReward(arg_14_0)
	g_WsMsgHandler:WS_LegionGame_TrainComplete_Req(arg_14_0.trainData.Index)
end

function var_0_0.initHero(arg_15_0)
	arg_15_0.trainData = nil

	for iter_15_0, iter_15_1 in pairs(g_Self.kLegionHandler.legionDetail.Train) do
		if iter_15_1.TemplateId > 0 then
			arg_15_0.trainData = iter_15_1
		end
	end
end

function var_0_0.refreshHero(arg_16_0)
	local function var_16_0()
		local var_17_0 = CCArray:create()

		var_17_0:addObject(CCCallFuncN:create(function()
			arg_16_0.heroAvatar:playAnimationOnce(ANIMATION_SEQUENCE_PHYATTACK, ANIMATION_SEQUENCE_IDLE, 0.2)
		end))
		var_17_0:addObject(CCDelayTime:create(1.5))
		var_17_0:addObject(CCCallFuncN:create(function()
			arg_16_0.heroAvatar:playAnimationOnce(ANIMATION_SEQUENCE_SKILL1, ANIMATION_SEQUENCE_IDLE, 0.2)
		end))
		var_17_0:addObject(CCDelayTime:create(1.5))
		var_17_0:addObject(CCCallFuncN:create(function()
			arg_16_0.heroAvatar:playAnimationOnce(ANIMATION_SEQUENCE_SKILL2, ANIMATION_SEQUENCE_IDLE, 0.2)
		end))
		var_17_0:addObject(CCDelayTime:create(1.5))
		var_17_0:addObject(CCCallFuncN:create(function()
			arg_16_0.heroAvatar:playAnimationOnce(ANIMATION_SEQUENCE_SKILL3, ANIMATION_SEQUENCE_IDLE, 0.2)
		end))
		var_17_0:addObject(CCDelayTime:create(1.5))

		local var_17_1 = CCRepeatForever:create(CCSequence:create(var_17_0))

		arg_16_0.heroAvatar:stopAllActions()
		arg_16_0.heroAvatar:runAction(var_17_1)
	end

	if arg_16_0.trainData ~= nil then
		arg_16_0.layerDetail:setVisible(true)
		arg_16_0.heroNode:setVisible(true)
		arg_16_0.heroAvatar:refreshHeroTemplateId(arg_16_0.trainData.TemplateId)
		arg_16_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
		var_16_0()

		local var_16_1 = zbHeroTable:getRecord(arg_16_0.trainData.TemplateId)

		if var_16_1 == nil then
			echoInfo("error hero template id: " .. arg_16_0.trainData.TemplateId)

			return
		end

		arg_16_0.lbName:setString(var_16_1.name)

		local var_16_2 = g_Self.kHeroHandler:getHeroByTemplateId(arg_16_0.trainData.TemplateId)
		local var_16_3 = zbColor:getHeroNameColor(var_16_2.HeroBaseInfo.Quality)

		arg_16_0.lbName:setColor(var_16_3)
		arg_16_0.lbLevel:setString(a2u("LV.") .. var_16_2.HeroBaseInfo.Level)

		local var_16_4 = g_DataConfig.m_kLegionBaseCfg.train.trainMode

		if arg_16_0.trainData ~= nil or arg_16_0.trainData ~= 0 then
			local var_16_5 = 3600

			if arg_16_0.trainData.EndTm ~= nil then
				var_16_5 = arg_16_0.trainData.EndTm - g_Self.kTimeHandler:getServerTime()
			end

			if var_16_5 > 0 then
				local var_16_6 = var_16_4[arg_16_0.trainData.TrainMode].needHour * 3600
				local var_16_7 = (var_16_6 - var_16_5) / var_16_6

				arg_16_0.levelupPre:setPercentage(var_16_7 * 100)
				arg_16_0.spriteIcon:setVisible(false)
				arg_16_0.lbCount:setVisible(false)
				arg_16_0.btnGetReward:setVisible(false)
			else
				arg_16_0.spriteIcon:setVisible(true)
				arg_16_0.lbCount:setVisible(true)
				arg_16_0.btnGetReward:setVisible(true)
				arg_16_0.levelupPre:setPercentage(100)

				local var_16_8 = var_16_4[arg_16_0.trainData.TrainMode].point

				arg_16_0.lbCount:setString(var_16_8)
			end
		end
	else
		arg_16_0.layerDetail:setVisible(false)
		arg_16_0.heroNode:setVisible(false)
	end
end

function var_0_0.refresh(arg_22_0)
	arg_22_0:initHero()
	arg_22_0:refreshHero()

	for iter_22_0, iter_22_1 in pairs(g_Self.kLegionHandler.legionDetail.Train) do
		arg_22_0.trainItems[iter_22_1.Index]:refresh(iter_22_1)
	end
end
