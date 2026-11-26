require("gamelogic.zbTimeLabel")

local var_0_0 = class("zbLegionHeroTrainItem", CCNodeExtend)

var_0_0.__index = var_0_0
HeroTrainListItem_Width = 150
HeroTrainListItem_Height = 150

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createLegionHeroTrainItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.parent = arg_3_2
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCSprite")
		arg_3_0.layerlock = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCNode")
		arg_3_0.lbLimit = tolua.cast(arg_3_0.layerlock:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.layerHero = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCNode")
		arg_3_0.lbTimeDummy = tolua.cast(arg_3_0.layerHero:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.btnHero = tolua.cast(arg_3_0.layerHero:getChildByTag(1), "CCControlButton")
		arg_3_0.lbTime = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbTimeDummy, arg_3_0.lbTime)
		arg_3_0.lbTime:setScale(0.48)

		arg_3_0.timeLabelHelper = zbTimeLabel:create(arg_3_0.lbTime, a2u(""), a2u(""))

		arg_3_0.timeLabelHelper:setCustomCallback(function()
			arg_3_0:onFinishHero()
		end)

		local var_5_0 = tolua.cast(arg_3_0.layerHero:getChildByTag(2), "CCLayerColor")

		arg_3_0.heroIcon = createItem()

		arg_3_0.heroIcon:setPosition(var_5_0:getPosition())
		arg_3_0.heroIcon:setScale(0.8)
		arg_3_0.heroIcon:setNeedTip(false)
		arg_3_0.heroIcon:setSwallowsTouches(false)
		arg_3_0.layerHero:addChild(arg_3_0.heroIcon)
		var_5_0:removeFromParentAndCleanup(true)

		arg_3_0.layerAdd = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCNode")
		arg_3_0.btnAdd = tolua.cast(arg_3_0.layerAdd:getChildByTag(1), "CCControlButton")

		arg_3_0.btnAdd:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnAdd:setSwallowsTouches(false)
		arg_3_0.btnHero:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnHero:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(HeroTrainListItem_Width, HeroTrainListItem_Height))
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onAdd()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnHero:addHandleOfControlEvent(function()
			arg_3_0:onHero()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	arg_9_0.trainData = arg_9_1

	if arg_9_1.State == ELegionTrainState.Lock then
		arg_9_0.layerAdd:setVisible(false)
		arg_9_0.layerlock:setVisible(true)
		arg_9_0.layerHero:setVisible(false)
		arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/train/train_lock.png"))
	elseif arg_9_1.State == ELegionTrainState.Free then
		arg_9_0.layerAdd:setVisible(true)
		arg_9_0.layerlock:setVisible(false)
		arg_9_0.layerHero:setVisible(false)
		arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/train/train_add.png"))
	else
		arg_9_0.layerAdd:setVisible(false)
		arg_9_0.layerlock:setVisible(false)
		arg_9_0.layerHero:setVisible(true)

		local var_9_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_9_1.TemplateId)
		local var_9_1 = require("cjson")

		arg_9_0.heroIcon:refreshHero(var_9_0.HeroBaseInfo)
		arg_9_0.heroIcon:setNodeStarVisible()

		local var_9_2 = 3600

		if arg_9_0.trainData.EndTm ~= nil then
			var_9_2 = arg_9_0.trainData.EndTm - g_Self.kTimeHandler:getServerTime()
		end

		arg_9_0.timeLabelHelper:start(var_9_2)
		arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/train/train_item" .. arg_9_1.TrainMode .. ".png"))
	end
end

function var_0_0.onAdd(arg_10_0)
	g_MainScene:showLegionHeroTrainSelect(arg_10_0.trainData.Index)
end

function var_0_0.onHero(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(g_Self.kLegionHandler.legionDetail.Train) do
		if arg_11_0.trainData.TemplateId == iter_11_1.TemplateId and arg_11_0.parent.trainData.TemplateId ~= arg_11_0.trainData.TemplateId then
			arg_11_0.parent.trainData = iter_11_1

			arg_11_0.parent:refreshHero()

			local var_11_0 = zbAvatarTable:getAvatarSoundPath(arg_11_0.trainData.TemplateId, ESoundType.E_CLICK)

			g_Audio:playSound(var_11_0)

			break
		end
	end
end

function var_0_0.onFinishHero(arg_12_0)
	arg_12_0.parent.trainData = arg_12_0.trainData

	arg_12_0.parent:refreshHero()

	local var_12_0 = zbAvatarTable:getAvatarSoundPath(arg_12_0.trainData.TemplateId, ESoundType.E_CLICK)

	g_Audio:playSound(var_12_0)
end
