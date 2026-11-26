require("gamelogic.zbLegionWarLevelTag")

local var_0_0 = class("zbLegionWarLevelPanel", CCNodeExtend)

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

function createLegionWarLevelPanel()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.curForceId = -1
		arg_3_0.stages = {}
		arg_3_0.treaSureTag = nil
		arg_3_0.lastTreaSureId = -1
		arg_3_0.treasureRecord = nil
	end

	local function var_3_1()
		local var_5_0 = zbTableViewHelper:create()

		var_5_0:loadCCBFile("ccbi/tb_legionwarstage.ccbi")

		for iter_5_0 = 1, 5 do
			local var_5_1 = zbLegionWarLevelTag:create(translateAndStrokeHelper(var_5_0:readCCBNode()), iter_5_0)

			var_5_1:retain()

			arg_3_0.stages[iter_5_0] = var_5_1
		end

		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.gotoForce(arg_6_0, arg_6_1)
	arg_6_0.warNodeInfo = arg_6_1

	local var_6_0 = string.format("ccbi/legionwar_position%d.ccbi", arg_6_0.warNodeInfo.NodeId)
	local var_6_1 = CCBProxy:create()
	local var_6_2 = CCBReaderLoad(var_6_0, var_6_1, true, "HelloCocosBuilderLayerOwner", true)
	local var_6_3 = tolua.cast(var_6_2:getChildByTag(1), "CCNode")

	arg_6_0.spriteTitleBg1 = tolua.cast(var_6_3:getChildByTag(100), "CCSprite")

	local var_6_4 = tolua.cast(arg_6_0.spriteTitleBg1:getChildByTag(1), "CCSprite")
	local var_6_5 = tolua.cast(arg_6_0.spriteTitleBg1:getChildByTag(2), "CCSprite")

	for iter_6_0 = 1, 5 do
		local var_6_6 = tolua.cast(var_6_3:getChildByTag(iter_6_0), "CCLayerColor")

		if zbWarNodeTable:getRecord(arg_6_0.warNodeInfo.NodeId) ~= nil then
			local var_6_7 = arg_6_0.stages[iter_6_0]

			var_6_7:removeFromParentAndCleanup(true)
			var_6_7:setPosition(var_6_6:getPosition())
			var_6_7:bind(arg_6_0.warNodeInfo, iter_6_0)
			var_6_3:addChild(var_6_7)

			local var_6_8 = math.ceil((640 - var_6_7:getPositionY()) * 64 + var_6_7:getPositionX())

			var_6_7:setZOrder(var_6_8)
			var_6_6:removeFromParentAndCleanup(true)
		end
	end

	arg_6_0:removeAllChildrenWithCleanup(true)
	arg_6_0:addChild(var_6_2)
	arg_6_0:refreshStages()
end

function var_0_0.refreshStages(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.stages) do
		iter_7_1:refresh()
	end
end
