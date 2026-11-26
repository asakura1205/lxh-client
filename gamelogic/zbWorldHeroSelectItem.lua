require("gamelogic.zbItem")

zbWorldHeroSelectItem = class("zbWorldHeroSelectItem", CCNodeExtend)
zbWorldHeroSelectItem.__index = zbWorldHeroSelectItem

function zbWorldHeroSelectItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWorldHeroSelectItem)

	return arg_1_0
end

function createWorldHeroSelectItem(arg_2_0, arg_2_1)
	local var_2_0 = zbWorldHeroSelectItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function zbWorldHeroSelectItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.heroDetail = nil
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		local var_5_0 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCNode")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCLayerColor")
		local var_5_2 = createItem()

		var_5_2:setPosition(var_5_1:getPosition())
		var_5_2:setScale(0.9)
		var_5_2:setSwallowsTouches(false)
		var_5_2:setNeedTip(false)
		var_5_2:setNodeStarVisible()

		arg_3_0.heroIcon = var_5_2

		var_5_0:addChild(arg_3_0.heroIcon)
		var_5_1:removeFromParentAndCleanup(true)

		arg_3_0.spriteType = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnTouch = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCControlButton")
		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.5)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbWorldHeroSelectItem.refresh(arg_7_0, arg_7_1)
	arg_7_0.heroDetail = arg_7_1

	if arg_7_1 == nil then
		return
	end

	arg_7_0.heroIcon:refreshHero(arg_7_1.HeroBaseInfo)
	arg_7_0.lbFight:setString(arg_7_1.HeroBaseInfo.FV)

	local var_7_0 = zbHeroTable:getRecord(arg_7_1.HeroBaseInfo.TemplateId)

	if var_7_0 then
		arg_7_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_7_0.heroType)))
	end
end

function zbWorldHeroSelectItem.onTouch(arg_8_0)
	if g_MainScene.wndWorldHeroSelect then
		g_MainScene.wndWorldHeroSelect.callback(arg_8_0.heroDetail)
		g_MainScene.wndWorldHeroSelect:hide()
	end
end
