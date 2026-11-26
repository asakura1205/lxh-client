zbAudioPreLoad = class("zbAudioPreLoad")
zbAudioPreLoad.__index = zbAudioPreLoad

function zbAudioPreLoad.create(arg_1_0)
	local var_1_0 = zbAudioPreLoad.new()

	var_1_0:init()

	return var_1_0
end

function zbAudioPreLoad.init(arg_2_0)
	arg_2_0.powerOn = true
	arg_2_0.working = false
	arg_2_0.startTime = 0
	arg_2_0.lastTaskTime = 0
	arg_2_0.taskList = {}
end

function zbAudioPreLoad.free(arg_3_0)
	arg_3_0.working = false
	arg_3_0.startTime = 0
	arg_3_0.lastTaskTime = 0
	arg_3_0.taskList = {}
end

function zbAudioPreLoad.isExistTask(arg_4_0, arg_4_1)
	if arg_4_1 == "" then
		return true
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.taskList) do
		if iter_4_1.soundPath == arg_4_1 then
			return true
		end
	end

	return false
end

function zbAudioPreLoad.addTask(arg_5_0, arg_5_1)
	if arg_5_0:isExistTask(arg_5_1) then
		return
	end

	if g_Audio:isSoundMute() then
		return
	end

	local var_5_0 = {
		soundPath = arg_5_1
	}

	var_5_0.loaded = false

	table.insert(arg_5_0.taskList, var_5_0)

	arg_5_0.working = true
	arg_5_0.startTime = os_timenow()
	arg_5_0.lastTaskTime = arg_5_0.startTime
end

function zbAudioPreLoad.preHero(arg_6_0, arg_6_1)
	local var_6_0 = zbHeroTable:getRecord(arg_6_1)

	if var_6_0 ~= nil then
		arg_6_0:preAvatar(var_6_0.avatarId)
	end
end

function zbAudioPreLoad.preAvatar(arg_7_0, arg_7_1)
	local var_7_0 = zbAvatarSoundTable:getSoundList(arg_7_1)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.sequenceName == ANIMATION_SEQUENCE_MOVE or iter_7_1.sequenceName == ANIMATION_SEQUENCE_BEHIT or iter_7_1.sequenceName == ANIMATION_SEQUENCE_DIE or iter_7_1.sequenceName == ANIMATION_SEQUENCE_PHYATTACK or iter_7_1.sequenceName == ANIMATION_SEQUENCE_SKILL1 or iter_7_1.sequenceName == ANIMATION_SEQUENCE_SKILL2 then
			arg_7_0:addTask(iter_7_1.sound1)
			arg_7_0:addTask(iter_7_1.sound2)
		end
	end
end

function zbAudioPreLoad.stop(arg_8_0)
	arg_8_0.working = false
end

function zbAudioPreLoad.update(arg_9_0)
	if arg_9_0.powerOn == false then
		return
	end

	if arg_9_0.working == false then
		return
	end

	local var_9_0 = os_timenow()

	if var_9_0 - arg_9_0.lastTaskTime <= 0.25 then
		return
	end

	if var_9_0 - arg_9_0.startTime > 5 then
		arg_9_0.working = false

		return
	end

	arg_9_0.lastTaskTime = var_9_0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.taskList) do
		if iter_9_1.loaded == false and iter_9_1.soundPath ~= nil and iter_9_1.json ~= "" then
			g_Audio:preloadSound(iter_9_1.soundPath)

			iter_9_1.loaded = true
			arg_9_0.lastTaskTime = os_timenow()

			break
		end
	end
end
