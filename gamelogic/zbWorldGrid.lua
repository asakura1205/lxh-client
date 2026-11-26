require("gamelogic.zbWorldDefine")

local var_0_0 = class("zbWorldGrid", CCNodeExtend)

var_0_0.__index = var_0_0

function createWorldGrid(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

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

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.cellWidth = math.ceil(WORLD_SCENE_WIDTH / GRID_IMAGE_WIDTH)
	arg_3_0.cellHeight = math.ceil(WORLD_SCENE_HEIGHT / GRID_IMAGE_HEIGHT)

	arg_3_0:setPosition(WORLD_SCENE_WIDTH / 2, WORLD_SCENE_HEIGHT / 2)

	arg_3_0.nodeGrid = CCDrawNode:create()

	arg_3_0:build()
	arg_3_0:addChild(arg_3_0.nodeGrid)
	arg_3_1:addChild(arg_3_0)
end

function var_0_0.free(arg_4_0)
	return
end

function var_0_0.build(arg_5_0)
	arg_5_0.nodeGrid:clear()

	local var_5_0 = ccp(0, 0)
	local var_5_1 = ccp(0, 0)
	local var_5_2 = 1
	local var_5_3 = ccc4f(0, 1, 0, 1)
	local var_5_4 = arg_5_0.cellWidth * SEGMENG_COUNT

	for iter_5_0 = 1, var_5_4 + 1 do
		var_5_0.x, var_5_0.y = arg_5_0:getTilePos(iter_5_0 - 1, 0)
		var_5_1.x, var_5_1.y = arg_5_0:getTilePos(iter_5_0 - 1, arg_5_0.cellHeight * SEGMENG_COUNT)

		arg_5_0.nodeGrid:drawSegment(var_5_0, var_5_1, var_5_2, var_5_3)
	end

	local var_5_5 = arg_5_0.cellHeight * SEGMENG_COUNT

	for iter_5_1 = 1, var_5_5 + 1 do
		var_5_0.x, var_5_0.y = arg_5_0:getTilePos(0, iter_5_1 - 1)
		var_5_1.x, var_5_1.y = arg_5_0:getTilePos(arg_5_0.cellWidth * SEGMENG_COUNT, iter_5_1 - 1)

		arg_5_0.nodeGrid:drawSegment(var_5_0, var_5_1, var_5_2, var_5_3)
	end
end

function var_0_0.getTilePos(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 0
	local var_6_1 = 0
	local var_6_2 = (arg_6_1 - arg_6_2) * GRID_IMAGE_WIDTH / 2
	local var_6_3 = (arg_6_1 + arg_6_2) * GRID_IMAGE_HEIGHT / 2

	return var_6_2, var_6_3
end
