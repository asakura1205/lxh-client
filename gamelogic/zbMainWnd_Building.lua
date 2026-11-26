require("gamelogic.zbBuildingCommon")
require("gamelogic.zbBuildingFarm")

local var_0_0 = class("zbMainWnd_Building")

var_0_0.__index = var_0_0

function createMainWndBuilding(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.parentWnd = arg_2_1
	arg_2_0.earthLayer = tolua.cast(arg_2_2:getChildByTag(100), "CCLayerColor")
	arg_2_0.buildingLayer = tolua.cast(arg_2_0.earthLayer:getChildByTag(100), "CCNode")
	arg_2_0.hintShow1 = 0
	arg_2_0.hintShow2 = 0
	arg_2_0.buildings = {}

	for iter_2_0, iter_2_1 in pairs(buildingConfig) do
		if iter_2_1.buildingType == EBuildingType.Farm then
			local var_2_0 = createBuildingFarm(arg_2_1, arg_2_0.buildingLayer, iter_2_1)

			table.insert(arg_2_0.buildings, var_2_0)
		else
			local var_2_1 = createBuildingCommon(arg_2_1, arg_2_0.buildingLayer, iter_2_1)

			table.insert(arg_2_0.buildings, var_2_1)
		end
	end

	local var_2_2 = CCArray:create()

	var_2_2:addObject(CCCallFuncN:create(function()
		arg_2_0:showHint()
	end))
	var_2_2:addObject(CCDelayTime:create(1200))

	local var_2_3 = CCSequence:create(var_2_2)

	arg_2_0.parentWnd:stopAllActions()
	arg_2_0.parentWnd:runAction(CCRepeatForever:create(var_2_3))
end

function var_0_0.showHint(arg_4_0)
	local var_4_0 = arg_4_0.hintShow1
	local var_4_1 = arg_4_0.hintShow2
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in pairs(EBuildingHint) do
		if zbFunHelper:isBuildingLockNoTip(iter_4_1.buildingType) == false then
			if arg_4_0.hintShow1 == 0 then
				arg_4_0.hintShow1 = iter_4_1.buildingType
			end

			if arg_4_0.hintShow1 ~= 0 then
				arg_4_0.hintShow2 = iter_4_1.buildingType
			end

			var_4_2 = var_4_2 + 1
		end
	end

	if var_4_2 > 2 then
		arg_4_0:randomShowHint()

		while arg_4_0.hintShow1 * arg_4_0.hintShow1 + arg_4_0.hintShow2 * arg_4_0.hintShow2 == var_4_0 * var_4_0 + var_4_1 * var_4_1 do
			arg_4_0:randomShowHint()
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.buildings) do
		if iter_4_3.config.buildingType ~= EBuildingType.Farm then
			iter_4_3:showHint(arg_4_0.hintShow1, arg_4_0.hintShow2)
		end
	end
end

function var_0_0.randomShowHint(arg_5_0)
	local var_5_0 = zbUtil:random(1, 5)

	while zbFunHelper:isBuildingLockNoTip(EBuildingHint[var_5_0].buildingType) == true do
		var_5_0 = zbUtil:random(1, 5)
	end

	arg_5_0.hintShow1 = EBuildingHint[var_5_0].buildingType

	local var_5_1 = zbUtil:random(1, 5)

	while zbFunHelper:isBuildingLockNoTip(EBuildingHint[var_5_1].buildingType) == true or var_5_1 == var_5_0 do
		var_5_1 = zbUtil:random(1, 5)
	end

	arg_5_0.hintShow2 = EBuildingHint[var_5_1].buildingType
end

function var_0_0.free(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.buildings) do
		if iter_6_1 then
			iter_6_1:free()
		end
	end
end

function var_0_0.getBuldPos(arg_7_0, arg_7_1)
	local var_7_0 = tolua.cast(arg_7_0.buildingLayer:getChildByTag(arg_7_1), "CCNode")

	if var_7_0 then
		return ccp(var_7_0:getPosition())
	end
end

function var_0_0.getBuldNode(arg_8_0, arg_8_1)
	return (tolua.cast(arg_8_0.buildingLayer:getChildByTag(arg_8_1), "CCNode"))
end

function var_0_0.onFrameUpdate(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.buildings) do
		iter_9_1:onFrameUpdate(arg_9_1)
	end
end

function var_0_0.touchBegan(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.startPos = ccp(arg_10_1, arg_10_2)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.buildings) do
		iter_10_1:touchBegan(arg_10_1, arg_10_2)
	end
end

function var_0_0.touchMoved(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.buildings) do
		iter_11_1:touchMoved(arg_11_1, arg_11_2)
	end
end

function var_0_0.touchEnded(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.buildings) do
		iter_12_1:touchEnded(arg_12_1, arg_12_2)
	end
end
