require("gamelogic.zbWorldDefine")

local var_0_0 = class("zbWorldFog")

var_0_0.__index = var_0_0

local var_0_1 = 1
local var_0_2 = 0

TILE_IMAGE_WIDTH = 429
TILE_IMAGE_HEIGHT = 260
TILE_THICKNESS = 9.4744111674221
GRID_IMAGE_WIDTH = TILE_IMAGE_WIDTH / 3
GRID_IMAGE_HEIGHT = (TILE_IMAGE_HEIGHT - TILE_THICKNESS) / 3

function createWorldFog(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.animU = 0
	arg_2_0.animV = 0

	local var_2_0 = "image/world/fog/fog.bmp"
	local var_2_1 = "image/world/fog/fogmask.bmp"

	arg_2_0.spriteFog = CCSprite:createFogImage(var_2_0, var_2_1)

	arg_2_0.spriteFog:setAnchorPoint(ccp(0.5, 0.5))
	arg_2_0.spriteFog:setPosition(WORLD_SCENE_WIDTH / 2, WORLD_SCENE_HEIGHT / 2)
	arg_2_0.spriteFog:setScaleX(WORLD_SCENE_WIDTH / arg_2_0.spriteFog:getContentSize().width)
	arg_2_0.spriteFog:setScaleY(WORLD_SCENE_HEIGHT / arg_2_0.spriteFog:getContentSize().height)
	arg_2_0.spriteFog:setVisible(true)
	arg_2_0.spriteFog:setUserWorldFogShader(true)
	arg_2_1:addChild(arg_2_0.spriteFog)

	arg_2_0.storePosX = arg_2_0.spriteFog:getPositionX()
	arg_2_0.storePosY = arg_2_0.spriteFog:getPositionY()
	arg_2_0.gridWidth = math.round(WORLD_SCENE_WIDTH / GRID_IMAGE_WIDTH)
	arg_2_0.gridHeight = math.round(WORLD_SCENE_HEIGHT / GRID_IMAGE_HEIGHT)

	echo("zbWorldFog: gridWidth=" .. arg_2_0.gridWidth .. ", gridHeight=" .. arg_2_0.gridHeight)

	arg_2_0.gridFlags = {}

	arg_2_0:setAllLock()
end

function var_0_0.refresh(arg_3_0)
	arg_3_0.spriteFog:clearFogMask()

	local var_3_0 = -math.round(arg_3_0.gridWidth / 2)
	local var_3_1 = math.round(arg_3_0.gridWidth / 2)
	local var_3_2 = -math.round(arg_3_0.gridWidth / 2)
	local var_3_3 = math.round(arg_3_0.gridWidth / 2)
	local var_3_4 = 0
	local var_3_5 = 0

	for iter_3_0 = var_3_0, var_3_1 do
		for iter_3_1 = var_3_2, var_3_3 do
			if arg_3_0:isLock(iter_3_0, iter_3_1) == false then
				local var_3_6, var_3_7 = arg_3_0:getGridCenterPixelPos(iter_3_0, iter_3_1)

				arg_3_0.spriteFog:setFogMask(var_3_6, var_3_7)
			end
		end
	end

	arg_3_0.spriteFog:commitFogMask()
end

function var_0_0.setAllLock(arg_4_0)
	local var_4_0 = -math.round(arg_4_0.gridWidth / 2)
	local var_4_1 = math.round(arg_4_0.gridWidth / 2)
	local var_4_2 = -math.round(arg_4_0.gridWidth / 2)
	local var_4_3 = math.round(arg_4_0.gridWidth / 2)

	for iter_4_0 = var_4_0, var_4_1 do
		arg_4_0.gridFlags[iter_4_0] = {}

		for iter_4_1 = var_4_2, var_4_3 do
			arg_4_0.gridFlags[iter_4_0][iter_4_1] = var_0_2
		end
	end
end

function var_0_0.unlock(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.gridFlags[arg_5_1] == nil then
		echo("warning: invalid fog gridX=" .. arg_5_1)
	elseif arg_5_0.gridFlags[arg_5_1][arg_5_2] == nil then
		echo("warning: invalid fog gridY=" .. arg_5_1 .. ", gridY=" .. arg_5_2)
	else
		arg_5_0.gridFlags[arg_5_1][arg_5_2] = var_0_1
	end
end

function var_0_0.isLock(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.gridFlags[arg_6_1] == nil then
		echo("warning: invalid fog gridX=" .. arg_6_1)

		return true
	elseif arg_6_0.gridFlags[arg_6_1][arg_6_2] == nil then
		echo("warning: invalid fog gridY=" .. arg_6_1 .. ", gridY=" .. arg_6_2)

		return true
	else
		return arg_6_0.gridFlags[arg_6_1][arg_6_2] == var_0_2
	end
end

function var_0_0.getGridCenterPixelPos(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = (arg_7_0.storePosX + (arg_7_1 - arg_7_2) * GRID_IMAGE_WIDTH / 2) / arg_7_0.spriteFog:getScaleX()
	local var_7_3 = (arg_7_0.storePosY + (arg_7_1 + arg_7_2) * GRID_IMAGE_HEIGHT / 2 + GRID_IMAGE_HEIGHT / 2) / arg_7_0.spriteFog:getScaleY()

	return var_7_2, var_7_3
end

function var_0_0.update(arg_8_0, arg_8_1)
	arg_8_0.animU = arg_8_0.animU - arg_8_1 * 0.005
	arg_8_0.animV = arg_8_0.animV - arg_8_1 * 0.005

	if arg_8_0.animU > 1 or arg_8_0.animU < -1 then
		arg_8_0.animU = 0
	end

	if arg_8_0.animV > 1 or arg_8_0.animV < -1 then
		arg_8_0.animV = 0
	end

	arg_8_0.spriteFog:setWorldFogAnimU(arg_8_0.animU)
	arg_8_0.spriteFog:setWorldFogAnimV(arg_8_0.animV)
end
