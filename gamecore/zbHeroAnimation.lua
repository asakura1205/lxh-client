require("gamecore.zbAnimation")

zbHeroAnimation = class("zbHeroAnimation", CCNodeExtend)
zbHeroAnimation.__index = zbHeroAnimation

function zbHeroAnimation.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroAnimation)

	return arg_1_0
end

function zbHeroAnimation.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroAnimation.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroAnimation.init(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getTemplateId()

	arg_3_0.heroRecord = zbHeroTable:getRecord(var_3_0)

	if arg_3_0.heroRecord == nil then
		echoInfo("warning: hero templateId not exist" .. var_3_0)

		return
	end

	arg_3_0.avatarRecord = zbAvatarTable:getRecord(arg_3_0.heroRecord.avatarId)

	if arg_3_0.avatarRecord == nil then
		echoInfo("warning: hero avatar not exist: " .. arg_3_0.heroRecord.avatarId)

		return
	end

	local var_3_1 = arg_3_0.avatarRecord.bone .. ".json"
	local var_3_2 = arg_3_0.avatarRecord.bone .. ".atlas"

	arg_3_0.skeleton = createSpineAnimation(var_3_1, var_3_2, 1, true)

	if arg_3_0.avatarRecord.parentAvatarId == 201 then
		arg_3_0.skeleton:setScale(0.75)
	end

	arg_3_0:addChild(arg_3_0.skeleton)
	arg_3_0:setRotationY(HeroRotateY[arg_3_1.forceType])
	arg_3_1:addChild(arg_3_0)

	arg_3_0.hero = arg_3_1
	arg_3_0.curSequenceName = ""
	arg_3_0.curSequenceLoop = false

	arg_3_0:checkAnimDuration()
	arg_3_0.skeleton:setCascadeOpacityEnabled(true)

	arg_3_0.nodeSound = CCNode:create()

	arg_3_0:addChild(arg_3_0.nodeSound)
end

function zbHeroAnimation.free(arg_4_0)
	arg_4_0:clearSoundAction()

	if arg_4_0.skeleton ~= nil then
		arg_4_0.skeleton:removeFromParentAndCleanup(true)

		arg_4_0.skeleton = nil
	end
end

function zbHeroAnimation.setAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.skeleton:clearTracks()

	if arg_5_0.curSequenceName ~= "" and arg_5_0.curSequenceName ~= arg_5_1 then
		arg_5_0.skeleton:setMix(arg_5_0.curSequenceName, arg_5_1, 0.125)
	end

	arg_5_0.curSequenceName = arg_5_1
	arg_5_0.curSequenceLoop = arg_5_2

	if arg_5_0.skeleton:setAnimation(0, arg_5_1, arg_5_2) == nil then
		-- block empty
	end

	arg_5_0:playAnimSound(arg_5_1, arg_5_3)
end

function zbHeroAnimation.playAnimationOnce(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_5 == nil then
		arg_6_5 = true
	end

	arg_6_0.curSequenceName = arg_6_1

	arg_6_0.skeleton:clearTracks()
	arg_6_0.skeleton:setMix(arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.skeleton:setMix(arg_6_2, arg_6_1, arg_6_3)

	local var_6_0

	if arg_6_0.skeleton:setAnimation(0, arg_6_1, false) == nil then
		arg_6_0.skeleton:setAnimation(0, ANIMATION_SEQUENCE_IDLE, false)
		echo(string.format("%s setAnimation %s failed", arg_6_0.hero.heroRecord.name, arg_6_1))
	end

	if arg_6_0.skeleton:addAnimation(0, arg_6_2, arg_6_5) == nil then
		arg_6_0.skeleton:addAnimation(0, ANIMATION_SEQUENCE_IDLE, true)
		echo(string.format("%s addAnimation %s failed", arg_6_0.hero.heroRecord.name, arg_6_2))
	end

	arg_6_0:playAnimSound(arg_6_1, arg_6_4)
end

function zbHeroAnimation.setAnimationStartTime(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.skeleton:clearTracks()

	if arg_7_0.curSequenceName ~= "" and arg_7_0.curSequenceName ~= arg_7_1 then
		arg_7_0.skeleton:setMix(arg_7_0.curSequenceName, arg_7_1, 0.125)
	end

	arg_7_0.curSequenceName = arg_7_1
	arg_7_0.curSequenceLoop = false

	local var_7_0 = arg_7_0.skeleton:setAnimation(0, arg_7_1, false)

	if var_7_0 == nil then
		echo(string.format("%s setAnimation %s failed", arg_7_0.hero.heroRecord.name, arg_7_1))
	end

	var_7_0.time = arg_7_2
	var_7_0.timeScale = arg_7_3
end

function zbHeroAnimation.playAnimSound(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.nodeSound:stopAllActions()

	if arg_8_1 == ANIMATION_SEQUENCE_RUN then
		return
	end

	local var_8_0, var_8_1 = zbAvatarSoundTable:getSound(arg_8_0.avatarRecord.parentAvatarId, arg_8_1)

	if var_8_0 == nil or var_8_0 == "" then
		return
	end

	local function var_8_2()
		g_Audio:playSound(var_8_0)
	end

	local var_8_3 = CCArray:create()

	var_8_3:addObject(CCDelayTime:create(var_8_1))
	var_8_3:addObject(CCCallFuncN:create(var_8_2))
	arg_8_0.nodeSound:stopAllActions()
	arg_8_0.nodeSound:runAction(CCSequence:create(var_8_3))
end

function zbHeroAnimation.clearSoundAction(arg_10_0)
	arg_10_0.nodeSound:stopAllActions()
end

function zbHeroAnimation.update(arg_11_0, arg_11_1)
	return
end

function zbHeroAnimation.pause(arg_12_0)
	arg_12_0.skeleton:pauseSchedulerAndActions()
end

function zbHeroAnimation.resume(arg_13_0)
	arg_13_0.skeleton:resumeSchedulerAndActions()
end

function zbHeroAnimation.checkAnimDuration(arg_14_0)
	arg_14_0.animDurations = {}
	arg_14_0.animDurations[ANIMATION_SEQUENCE_SHOW] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_SHOW)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_PHYATTACK] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_PHYATTACK)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_SKILL1] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_SKILL1)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_SKILL2] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_SKILL2)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_SKILL3] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_SKILL3)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_SKILL4] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_SKILL4)
	arg_14_0.animDurations[ANIMATION_SEQUENCE_DIE] = arg_14_0:checkSequenceDuration(ANIMATION_SEQUENCE_DIE)
end

function zbHeroAnimation.checkSequenceDuration(arg_15_0, arg_15_1)
	arg_15_0.skeleton:clearTracks()

	local var_15_0 = arg_15_0.skeleton:setAnimation(0, arg_15_1, false)

	if var_15_0 ~= nil then
		return math.max(var_15_0.endTime - 0.1, 0)
	end

	return 0
end

function zbHeroAnimation.getAnimDuration(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.animDurations[arg_16_1]

	if var_16_0 == nil then
		var_16_0 = 0

		echo(string.format("warning: %s getAnimDuration failed: %s", arg_16_0.hero.heroRecord.name, arg_16_1))
	end

	return var_16_0
end
