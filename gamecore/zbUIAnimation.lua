require("gamecore.zbAnimation")

local var_0_0 = class("zbUIAnimation", CCNodeExtend)

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

function createUIAnimation()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0.pool = false

	var_2_0:init()

	return var_2_0
end

function createUIPoolAnimation()
	local var_3_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_3_0.pool = true

	var_3_0:init()

	return var_3_0
end

function var_0_0.init(arg_4_0)
	arg_4_0.skeleton = nil
	arg_4_0.skeletonFile = ""
	arg_4_0.textureFile = ""
end

function var_0_0.free(arg_5_0)
	if arg_5_0.skeleton ~= nil then
		arg_5_0.skeleton:removeFromParentAndCleanup(true)

		arg_5_0.skeleton = nil
	end

	arg_5_0.skeletonFile = ""
	arg_5_0.textureFile = ""
end

function var_0_0.refreshHeroTemplateId(arg_6_0, arg_6_1)
	local var_6_0 = zbHeroTable:getRecord(arg_6_1)

	if var_6_0 == nil then
		return false
	end

	return arg_6_0:refreshAvatarId(var_6_0.avatarId)
end

function var_0_0.refreshAvatarId(arg_7_0, arg_7_1)
	local var_7_0 = zbAvatarTable:getRecord(arg_7_1)

	if var_7_0 == nil then
		echo("warning: can not find avatarId: " .. arg_7_1)

		return false
	end

	return arg_7_0:refreshBone(var_7_0.bone)
end

function var_0_0.refreshBone(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 .. ".json"
	local var_8_1 = arg_8_1 .. ".atlas"

	return arg_8_0:refresh(var_8_0, var_8_1)
end

function var_0_0.refresh(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0.skeletonFile == arg_9_1 and arg_9_0.skeletonFile == arg_9_1 then
		return false
	end

	if arg_9_3 == nil then
		arg_9_3 = 1
	end

	if arg_9_3 ~= 1 and arg_9_3 > 0.1 then
		spAtlas_ScaleAtlas(1 / arg_9_3)
	else
		spAtlas_ScaleAtlas(1)
	end

	arg_9_0:free()

	arg_9_0.skeletonFile = arg_9_1
	arg_9_0.textureFile = arg_9_2
	arg_9_0.skeleton = createSpineAnimation(arg_9_1, arg_9_2, arg_9_3, arg_9_0.pool)

	if arg_9_0.skeleton ~= nil then
		arg_9_0:addChild(arg_9_0.skeleton)
	end

	if arg_9_3 ~= nil and arg_9_3 ~= 1 then
		spAtlas_ScaleAtlas(1)
	end

	arg_9_0.curSequenceName = ""

	return true
end

function var_0_0.playAnimationOnce(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.curSequenceName = arg_10_1

	arg_10_0.skeleton:clearTracks()
	arg_10_0.skeleton:setMix(arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.skeleton:setMix(arg_10_2, arg_10_1, arg_10_3)

	local var_10_0

	if arg_10_0.skeleton:setAnimation(0, arg_10_1, false) == nil then
		arg_10_0.skeleton:setAnimation(0, ANIMATION_SEQUENCE_IDLE, false)
		echo("setAnimation failed: ", arg_10_1)
	end

	if arg_10_0.skeleton:addAnimation(0, arg_10_2, true) == nil then
		arg_10_0.skeleton:addAnimation(0, ANIMATION_SEQUENCE_IDLE, true)
		echo("addAnimation failed: ", arg_10_2)
	end
end

function var_0_0.setAnimation(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.skeleton == nil then
		return
	end

	if arg_11_0.curSequenceName ~= "" and arg_11_0.curSequenceName ~= arg_11_1 then
		arg_11_0.skeleton:setMix(arg_11_0.curSequenceName, arg_11_1, 0.125)
	end

	arg_11_0.curSequenceName = arg_11_1

	arg_11_0.skeleton:clearTracks()

	local var_11_0 = arg_11_0.skeleton:setAnimation(0, arg_11_1, arg_11_2)

	if var_11_0 ~= nil and arg_11_3 ~= nil then
		var_11_0.timeScale = arg_11_3
	end
end

function var_0_0.clearTracks(arg_12_0)
	if arg_12_0.skeleton == nil then
		return
	end

	arg_12_0.skeleton:clearTracks()
end

function var_0_0.setTimeScale(arg_13_0, arg_13_1)
	if arg_13_0.skeleton == nil then
		return
	end

	arg_13_0.skeleton.timeScale = arg_13_1
end

function var_0_0.getAnimDuration(arg_14_0, arg_14_1)
	if arg_14_0.skeleton == nil then
		return 0
	end

	arg_14_0.skeleton:clearTracks()

	local var_14_0 = arg_14_0.skeleton:setAnimation(0, arg_14_1, false)

	if var_14_0 ~= nil then
		return var_14_0.endTime
	end

	return 0
end

function var_0_0.setStartTime(arg_15_0, arg_15_1)
	if arg_15_0.skeleton == nil then
		return
	end

	arg_15_0.skeleton:update(arg_15_1)
end

function var_0_0.setRandomStartTime(arg_16_0)
	local var_16_0 = zbUtil:random(0, 1000) / 1000

	arg_16_0:setStartTime(var_16_0)
end

function var_0_0.isComplete(arg_17_0)
	if arg_17_0.skeleton ~= nil and arg_17_0.skeleton:getCurrent(0) ~= nil then
		return arg_17_0.skeleton:isComplete(0)
	else
		return false
	end
end
