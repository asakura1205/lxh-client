require("gamelogic.zbItem")
require("gamelogic.zbPataWnd_AwardItem")

zbPataWnd_Award = class("zbPataWnd_Award")
zbPataWnd_Award.__index = zbPataWnd_Award

function createPataWnd_Award(arg_1_0, arg_1_1)
	local var_1_0 = zbPataWnd_Award.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function zbPataWnd_Award.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parent = arg_2_2
		arg_2_0.layer = arg_2_1
		arg_2_0.boxItems = {}
		arg_2_0.boxShowItems = {}
		arg_2_0.itemPoint = {}
	end

	local function var_2_1()
		for iter_4_0 = 1, 3 do
			local var_4_0 = zbTableViewHelper:create()

			var_4_0:loadCCBFile("ccbi/tb_patabox.ccbi")

			local var_4_1 = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCLayerColor")
			local var_4_2 = zbPataWnd_AwardItem:create(translateAndStrokeHelper(var_4_0:readCCBNode()), iter_4_0)
			local var_4_3 = ccp(var_4_1:getPosition())

			var_4_2:setPosition(var_4_3.x, var_4_3.y - 15)
			arg_2_1:addChild(var_4_2)

			arg_2_0.boxItems[iter_4_0] = var_4_2
			arg_2_0.itemPoint[iter_4_0] = ccp(var_4_1:getPosition())

			var_4_1:removeFromParentAndCleanup(true)
			var_4_0:releaseSelf()
		end

		arg_2_0.awardLayer = tolua.cast(arg_2_1:getChildByTag(4), "CCLayer")

		for iter_4_1 = 1, 3 do
			local var_4_4 = tolua.cast(arg_2_0.awardLayer:getChildByTag(10 + iter_4_1), "CCLayerColor")
			local var_4_5 = createItem()

			var_4_5:setPosition(var_4_4:getPosition())
			var_4_5:setScale(0.8)
			arg_2_0.awardLayer:addChild(var_4_5)

			arg_2_0.boxShowItems[iter_4_1] = var_4_5

			var_4_4:removeFromParentAndCleanup(true)
		end
	end

	var_2_0()
	var_2_1()
end

function zbPataWnd_Award.refresh(arg_5_0, arg_5_1)
	arg_5_0.layer:setVisible(true)

	arg_5_0.PataInfo = arg_5_1

	arg_5_0.awardLayer:setVisible(true)

	for iter_5_0 = 1, 3 do
		arg_5_0.boxItems[iter_5_0]:setVisible(false)

		if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
			arg_5_0.boxItems[iter_5_0]:setPosition(arg_5_0.itemPoint[iter_5_0])
		else
			arg_5_0.boxItems[iter_5_0]:setPosition(arg_5_0.itemPoint[4 - iter_5_0].x, arg_5_0.itemPoint[iter_5_0].y)
		end
	end

	for iter_5_1, iter_5_2 in pairs(arg_5_0.boxItems) do
		iter_5_2:setVisible(false)
		iter_5_2:refresh(arg_5_0.PataInfo.AwardLayerInfo.AwardLayerInfo.BrandList)
	end

	local var_5_0 = 1

	for iter_5_3, iter_5_4 in pairs(arg_5_0.PataInfo.AwardLayerInfo.AwardLayerInfo.AwardList) do
		local var_5_1 = arg_5_0.boxShowItems[var_5_0]

		if var_5_1 ~= nil then
			var_5_1:refreshAward(iter_5_4.Type, iter_5_4.Id, iter_5_4.Count, false)

			var_5_0 = var_5_0 + 1
		end
	end

	arg_5_0:playEffect()
end

function zbPataWnd_Award.onBox(arg_6_0)
	return
end

function zbPataWnd_Award.playEffect(arg_7_0)
	local var_7_0 = 0

	local function var_7_1(arg_8_0, arg_8_1)
		local function var_8_0(arg_9_0)
			arg_9_0:setVisible(true)
		end

		local var_8_1 = CCArray:create()

		var_8_1:addObject(CCDelayTime:create(var_7_0))
		var_8_1:addObject(CCCallFuncN:create(var_8_0))
		arg_8_0:setVisible(false)
		arg_8_0:stopAllActions()
		arg_8_0:runAction(CCSequence:create(var_8_1))

		var_7_0 = var_7_0 + arg_8_1
	end

	var_7_1(arg_7_0.boxItems[1], 0.25)
	var_7_1(arg_7_0.boxItems[2], 0.25)
	var_7_1(arg_7_0.boxItems[3], 0.25)
	var_7_1(arg_7_0.awardLayer, 0.25)

	if arg_7_0.PataInfo.BaseInfo.Layer < zbPataLayerBaseTable.number then
		var_7_1(arg_7_0.parent.btnGoOn, 0.25)
	end
end
