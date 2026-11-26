zbCombatPreLoad = class("zbCombatPreLoad")
zbCombatPreLoad.__index = zbCombatPreLoad

function zbCombatPreLoad.create(arg_1_0)
	local var_1_0 = zbCombatPreLoad.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatPreLoad.init(arg_2_0)
	arg_2_0.powerOn = true
	arg_2_0.working = false
	arg_2_0.startTime = 0
	arg_2_0.lastTaskTime = 0
	arg_2_0.taskList = {}
end

function zbCombatPreLoad.free(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.taskList) do
		if iter_3_1.animNode ~= nil then
			iter_3_1.animNode:release()

			iter_3_1.animNode = nil
		end

		if iter_3_1.texture ~= nil then
			iter_3_1.texture:release()

			iter_3_1.texture = nil
		end
	end

	arg_3_0.working = false
	arg_3_0.startTime = 0
	arg_3_0.lastTaskTime = 0
	arg_3_0.taskList = {}
end

function zbCombatPreLoad.addAnimTask(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {
		json = arg_4_1,
		atlas = arg_4_2,
		tex = arg_4_3
	}

	var_4_0.loaded = false
	var_4_0.animNode = nil

	table.insert(arg_4_0.taskList, var_4_0)
end

function zbCombatPreLoad.start(arg_5_0)
	local function var_5_0(arg_6_0)
		local var_6_0 = zbEffectTable:getRecord(arg_6_0)

		if var_6_0 == nil then
			return
		end

		if var_6_0.ccbi == "" then
			return
		end

		if var_6_0.ccbi ~= "" then
			local var_6_1 = var_6_0.ccbi .. ".json"
			local var_6_2 = var_6_0.ccbi .. ".atlas"
			local var_6_3 = var_6_0.ccbi .. ".png"

			arg_5_0:addAnimTask(var_6_1, var_6_2, var_6_3)
		end
	end

	local function var_5_1(arg_7_0, arg_7_1)
		local var_7_0 = zbHeroSkillTable:getRecord(arg_7_1)

		if var_7_0 ~= nil then
			arg_7_0[var_7_0.riseEffectId] = 1
			arg_7_0[var_7_0.riseAttackEffectId] = 1
			arg_7_0[var_7_0.flyEffectId] = 1
			arg_7_0[var_7_0.hitEffectId] = 1
			arg_7_0[var_7_0.targetEffectId] = 1
		end
	end

	local function var_5_2(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in pairs(arg_8_1.skillList) do
			var_5_1(arg_8_0, iter_8_1.skillId)
		end
	end

	arg_5_0:free()

	local var_5_3 = {}
	local var_5_4 = g_CombatSystem:getHeros(ForceType.Left)
	local var_5_5 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_5_0, iter_5_1 in pairs(var_5_4) do
		var_5_2(var_5_3, iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(var_5_5) do
		var_5_2(var_5_3, iter_5_3)
	end

	for iter_5_4, iter_5_5 in pairs(var_5_3) do
		var_5_0(iter_5_4)
	end

	arg_5_0.working = true
	arg_5_0.startTime = os_timenow()
	arg_5_0.lastTaskTime = arg_5_0.startTime
end

function zbCombatPreLoad.stop(arg_9_0)
	arg_9_0.working = false
end

function zbCombatPreLoad.update(arg_10_0)
	if arg_10_0.powerOn == false then
		return
	end

	if arg_10_0.working == false then
		return
	end

	local var_10_0 = os_timenow()

	if var_10_0 - arg_10_0.lastTaskTime <= 0.25 then
		return
	end

	if var_10_0 - arg_10_0.startTime > 10 then
		arg_10_0.working = false

		return
	end

	arg_10_0.lastTaskTime = var_10_0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.taskList) do
		if iter_10_1.loaded == false and iter_10_1.json ~= nil and iter_10_1.json ~= "" then
			iter_10_1.texture = CCTextureCache:sharedTextureCache():addImage(iter_10_1.tex)

			if iter_10_1.texture then
				iter_10_1.texture:retain()

				if g_MainScene.wndCombat ~= nil then
					g_MainScene.wndCombat.spritePreload:setTexture(iter_10_1.texture)
				end

				iter_10_1.loaded = true
				arg_10_0.lastTaskTime = os_timenow()

				echo("preload task ok: " .. iter_10_1.tex)

				break
			end
		end
	end
end
