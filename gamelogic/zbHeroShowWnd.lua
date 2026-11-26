require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroShowItem")

local var_0_0 = class("zbHeroShowWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createHeroShowWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.warriorHeros = {}
		arg_3_0.ninjaHeros = {}
		arg_3_0.wizardHeros = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroShow.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.warriorLayer = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.ninjaLayer = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")
		arg_3_0.wizardLayer = tolua.cast(var_5_2:getChildByTag(3), "CCLayer")

		local var_5_3 = zbTableViewHelper:create()

		var_5_3:loadCCBFile("ccbi/tb_heroShow.ccbi")

		for iter_5_0 = 1, 15 do
			local var_5_4 = tolua.cast(arg_3_0.warriorLayer:getChildByTag(iter_5_0), "CCLayerColor")

			var_5_4:setVisible(false)

			local var_5_5 = zbHeroShowItem:create(arg_3_0, translateAndStrokeHelper(var_5_3:readCCBNode()))

			var_5_5:setContentSize(CCSizeMake(110, 110))
			var_5_5:setScale(0.8)
			var_5_5:setPosition(var_5_4:getPosition())

			arg_3_0.warriorHeros[iter_5_0] = var_5_5

			arg_3_0.warriorLayer:addChild(var_5_5)
		end

		for iter_5_1 = 1, 15 do
			local var_5_6 = tolua.cast(arg_3_0.ninjaLayer:getChildByTag(iter_5_1), "CCLayerColor")

			var_5_6:setVisible(false)

			local var_5_7 = zbHeroShowItem:create(arg_3_0, translateAndStrokeHelper(var_5_3:readCCBNode()))

			var_5_7:setContentSize(CCSizeMake(110, 110))
			var_5_7:setScale(0.8)
			var_5_7:setPosition(var_5_6:getPosition())

			arg_3_0.ninjaHeros[iter_5_1] = var_5_7

			arg_3_0.ninjaLayer:addChild(var_5_7)
		end

		for iter_5_2 = 1, 15 do
			local var_5_8 = tolua.cast(arg_3_0.wizardLayer:getChildByTag(iter_5_2), "CCLayerColor")

			var_5_8:setVisible(false)

			local var_5_9 = zbHeroShowItem:create(arg_3_0, translateAndStrokeHelper(var_5_3:readCCBNode()))

			var_5_9:setContentSize(CCSizeMake(110, 110))
			var_5_9:setScale(0.8)
			var_5_9:setPosition(var_5_8:getPosition())

			arg_3_0.wizardHeros[iter_5_2] = var_5_9

			arg_3_0.wizardLayer:addChild(var_5_9)
		end

		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {}, function()
			arg_3_0:hide()
		end, EListType.HeroBook)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0)
	arg_7_0:refreshItems(arg_7_0.warriorHeros, EHeroType.Warrior)
	arg_7_0:refreshItems(arg_7_0.ninjaHeros, EHeroType.Ninja)
	arg_7_0:refreshItems(arg_7_0.wizardHeros, EHeroType.Wizard)
end

function var_0_0.refreshItems(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = zbHeroTable:getHeroListForClass(arg_8_2)
	local var_8_1 = table.getn(var_8_0)
	local var_8_2 = 1

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		arg_8_1[var_8_2]:refresh(iter_8_1.id)

		var_8_2 = var_8_2 + 1
	end

	for iter_8_2 = var_8_2, 15 do
		arg_8_1[var_8_2]:refresh(HEROSHOW_UNOPEN_ID)

		var_8_2 = var_8_2 + 1
	end
end
