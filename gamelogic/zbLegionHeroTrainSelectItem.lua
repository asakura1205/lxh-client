local var_0_0 = class("zbLegionHeroTrainSelectItem", CCNodeExtend)

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

function createLegionHeroTrainSelectItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
		arg_3_0.templateId = 0
	end

	local function var_3_1()
		arg_3_0.layer = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.btnTouch = tolua.cast(arg_3_0.layer:getChildByTag(0), "CCControlButton")
		arg_3_0.layerContent = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCNode")

		local var_5_0 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCNode")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCLayerColor")

		arg_3_0.heroIcon = createItem()

		arg_3_0.heroIcon:setPosition(var_5_1:getPosition())
		arg_3_0.heroIcon:setScale(0.9)
		arg_3_0.heroIcon:setNeedTip(false)
		arg_3_0.heroIcon:setSwallowsTouches(false)
		var_5_0:addChild(arg_3_0.heroIcon)
		var_5_1:removeFromParentAndCleanup(true)

		local var_5_2 = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCSprite")

		arg_3_0.spriteSelOk = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCNode")

		arg_3_0.lbExpDummy = tolua.cast(var_5_3:getChildByTag(1013), "CCLabelTTF")
		arg_3_0.lbExp = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbExpDummy, arg_3_0.lbExp)
		arg_3_0.lbExp:setScale(0.48)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomChildNode(arg_3_0.layerContent)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.heroDesc = arg_7_1

	arg_7_0:setVisible(true)

	if arg_7_1 == nil then
		return
	end

	arg_7_0.templateId = arg_7_1.HeroBaseInfo.TemplateId

	arg_7_0.heroIcon:refreshHero(arg_7_0.heroDesc.HeroBaseInfo)
	arg_7_0.heroIcon:setNodeStarVisible()
	arg_7_0.lbExp:setString(arg_7_1.HeroSubInfo.SkillPoint)
end

function var_0_0.setSelecteState(arg_8_0, arg_8_1)
	arg_8_0.spriteSelOk:setVisible(arg_8_1 == arg_8_0.templateId)
end

function var_0_0.onTouch(arg_9_0)
	if g_MainScene.wndLegionHeroTrainSelect then
		g_MainScene.wndLegionHeroTrainSelect:selectCard(arg_9_0.templateId)
	end
end
