require("gamelogic.zbWarLevelTag")
require("gamelogic.zbWarTreaSureTag")

local var_0_0 = class("zbWarForceLevelPanel", CCNodeExtend)

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

function createWarForceLevelPanel()
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
		arg_3_0.treasureRecord = nil
	end

	local function var_3_1()
		for iter_5_0 = 1, 15 do
			local var_5_0 = zbTableViewHelper:create()

			var_5_0:loadCCBFile("ccbi/tb_levelstage.ccbi")

			local var_5_1 = zbWarLevelTag:create(translateAndStrokeHelper(var_5_0:readCCBNode()), iter_5_0)

			var_5_1:retain()

			arg_3_0.stages[iter_5_0] = var_5_1

			var_5_0:releaseSelf()
		end

		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.gotoForce(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if g_Self.kWarPathHandler:isVisibleForce(arg_6_1, arg_6_2) == false then
		return
	end

	arg_6_0.levelType = arg_6_1
	arg_6_0.curForceId = arg_6_2

	local var_6_0 = string.format("ccbi/warforce_%d.ccbi", arg_6_2)
	local var_6_1 = CCBProxy:create()
	local var_6_2 = CCBReaderLoad(var_6_0, var_6_1, true, "HelloCocosBuilderLayerOwner", true)
	local var_6_3 = tolua.cast(var_6_2:getChildByTag(1), "CCNode")

	arg_6_0.spriteTitleBg1 = tolua.cast(var_6_3:getChildByTag(100), "CCSprite")

	local var_6_4 = tolua.cast(arg_6_0.spriteTitleBg1:getChildByTag(1), "CCSprite")
	local var_6_5 = tolua.cast(arg_6_0.spriteTitleBg1:getChildByTag(2), "CCSprite")
	local var_6_6 = string.format("image/warpath/forcedetail/fd_bg_%03d", arg_6_2)

	var_6_4:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_6 .. "_1.jpg"))
	var_6_5:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_6 .. "_2.jpg"))

	for iter_6_0 = 1, 9 do
		local var_6_7 = tolua.cast(var_6_3:getChildByTag(iter_6_0), "CCLayerColor")
		local var_6_8 = tonumber(string.format("%d%.4d", arg_6_2, iter_6_0))

		if zbForceSetTable:getRecord(var_6_8) ~= nil then
			local var_6_9 = arg_6_0.stages[iter_6_0]

			var_6_9:removeFromParentAndCleanup(true)
			var_6_9:setPosition(var_6_7:getPosition())
			var_6_9:bind(arg_6_0.levelType, arg_6_0.curForceId, iter_6_0)
			var_6_3:addChild(var_6_9)

			local var_6_10 = math.ceil((640 - var_6_9:getPositionY()) * 64 + var_6_9:getPositionX())

			var_6_9:setZOrder(var_6_10)
			var_6_7:removeFromParentAndCleanup(true)
		end
	end

	arg_6_0.treaSureTag = nil

	local var_6_11 = zbTreaSureTable:getRecord(arg_6_0.curForceId)

	arg_6_0.treasureRecord = var_6_11

	if var_6_11 then
		local var_6_12 = tolua.cast(var_6_3:getChildByTag(50), "CCNode")

		if var_6_12 then
			local var_6_13 = true
			local var_6_14 = g_Self.kTreaSureHandler:getTreaSureInfoById(arg_6_0.curForceId)

			if var_6_14 and var_6_14.MagnifierCount > 0 then
				var_6_13 = false
			end

			arg_6_0.treaSureTag = createWarTreaSureTag(var_6_12, arg_6_0.curForceId, arg_6_0.levelType, var_6_13)
		end
	end

	arg_6_0:removeAllChildrenWithCleanup(true)
	arg_6_0:addChild(var_6_2)
	arg_6_0:refreshStages(arg_6_3)
	arg_6_0:refreshTreaSureTag()
end

function var_0_0.refreshStages(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.stages) do
		iter_7_1:refresh(arg_7_1)
	end
end

function var_0_0.refreshTreaSureTag(arg_8_0)
	if arg_8_0.treaSureTag == nil or arg_8_0.levelType ~= ELevelType.Normal then
		return
	end

	local var_8_0 = false

	if arg_8_0.treasureRecord then
		var_8_0 = g_Self.kWarPathHandler:blevelPassed(arg_8_0.curForceId, arg_8_0.treasureRecord.levelId, ELevelType.Normal)
	end

	if var_8_0 then
		arg_8_0.treaSureTag:refresh()
	end
end

function var_0_0.hideTagFinger(arg_9_0, arg_9_1)
	if arg_9_1 > 0 and arg_9_1 <= 15 and arg_9_0.stages[arg_9_1] then
		arg_9_0.stages[arg_9_1].spriteGeneralArrow:setVisible(false)
		arg_9_0.stages[arg_9_1].spriteSoliderArrow:setVisible(false)
	end
end

function var_0_0.getTagFinger(arg_10_0, arg_10_1)
	if arg_10_1 > 0 and arg_10_1 <= 15 and arg_10_0.stages[arg_10_1] then
		return arg_10_0.stages[arg_10_1].spriteGeneralArrow
	end

	return nil
end
