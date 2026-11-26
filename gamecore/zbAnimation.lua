g_UseAnimPool = true

function createSkeletonAnimation(arg_1_0, arg_1_1, arg_1_2)
	if CCFileUtils:sharedFileUtils().isFileExist ~= nil then
		local var_1_0 = CCFileUtils:sharedFileUtils():fullPathForFilename(arg_1_0)

		if CCFileUtils:sharedFileUtils():isFileExist(var_1_0) == false then
			echoInfo("createSkeletonAnimation failed, file is not exist: " .. var_1_0)

			return nil
		end
	end

	if arg_1_2 == nil then
		arg_1_2 = 1
	end

	if arg_1_2 ~= 1 and arg_1_2 > 0.1 then
		spAtlas_ScaleAtlas(1 / arg_1_2)
	else
		spAtlas_ScaleAtlas(1)
	end

	local var_1_1 = zbAnimCacheUtil:SharedAnimCache():CreateAnimation(arg_1_0, arg_1_1, arg_1_2)

	if var_1_1 == nil then
		echoInfo("failed to create skeleton animation(" .. arg_1_0 .. ", " .. arg_1_1 .. ")")
	end

	var_1_1.json = arg_1_0

	return var_1_1
end

g_FightAnimTable = {}

function createSpineAnimation(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 == nil then
		arg_2_2 = 1
	end

	if arg_2_3 == nil then
		arg_2_3 = false
	end

	if g_UseAnimPool and arg_2_3 then
		for iter_2_0, iter_2_1 in pairs(g_FightAnimTable) do
			if iter_2_1:getParent() == nil and iter_2_1.json == arg_2_0 and iter_2_1.pool then
				iter_2_1:setOpacity(255)
				iter_2_1:setScale(1)
				iter_2_1:setPosition(0, 0)
				iter_2_1:setRotationY(0)
				iter_2_1:setRotationX(0)
				iter_2_1:stopAllActions()
				iter_2_1:unscheduleUpdate()
				iter_2_1:scheduleUpdate()
				iter_2_1:resumeSchedulerAndActions()

				iter_2_1.timeScale = 1

				return iter_2_1
			end
		end
	end

	local var_2_0 = createSkeletonAnimation(arg_2_0, arg_2_1, arg_2_2)

	if var_2_0 then
		var_2_0:retain()

		var_2_0.pool = g_UseAnimPool and arg_2_3

		table.insert(g_FightAnimTable, var_2_0)
	end

	return var_2_0
end

function clearSpinePoolAnimation()
	for iter_3_0, iter_3_1 in pairs(g_FightAnimTable) do
		if g_UseAnimPool and iter_3_1:getParent() == nil then
			iter_3_1:removeAllChildrenWithCleanup(true)
		end

		iter_3_1:release()
	end

	g_FightAnimTable = {}
end
