function zbMainScene.setNewFunLocalFlag(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = g_Login.account .. "_" .. g_Login.lastServerId .. "_newfun_" .. arg_1_1.id

	zbGameCore:Instance():setConfigValue(var_1_0, arg_1_2)
end

function zbMainScene.readLocalWaitFunShowList(arg_2_0)
	for iter_2_0 = 1, EFuncType.God do
		local var_2_0 = g_Login.account .. "_" .. g_Login.lastServerId .. "_newfun_" .. iter_2_0

		if zbGameCore:Instance():getConfigValue(var_2_0) == "1" then
			local var_2_1 = zbFunctionUnlockTable:getRecord(iter_2_0)

			if var_2_1 ~= nil then
				arg_2_0:pushHomeFunShow(var_2_1)
			end
		end
	end
end

function zbMainScene.pushHomeFunShow(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.waitShowNewFunList) do
		if iter_3_1.id == arg_3_1.id then
			return
		end
	end

	table.insert(arg_3_0.waitShowNewFunList, arg_3_1)
	arg_3_0:setNewFunLocalFlag(arg_3_1, 1)
end

function zbMainScene.popHomeFunShow(arg_4_0, arg_4_1)
	arg_4_0:setNewFunLocalFlag(arg_4_1, 0)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.waitShowNewFunList) do
		if iter_4_1.id == arg_4_1.id then
			table.remove(arg_4_0.waitShowNewFunList, iter_4_0)

			return
		end
	end
end

function zbMainScene.checkNewFunction(arg_5_0)
	local var_5_0 = g_MainScene:isOnlyMainVisible()

	if arg_5_0.lastOnlyMainVisible == false and var_5_0 == true and (g_Guide:isGuiding() == false or g_Self:getLevel() >= 5) then
		local var_5_1

		for iter_5_0, iter_5_1 in pairs(arg_5_0.waitShowNewFunList) do
			var_5_1 = iter_5_1

			break
		end

		if var_5_1 ~= nil then
			g_MainScene:checkShowNewFuncWndImmRecord(var_5_1)
			arg_5_0:popHomeFunShow(var_5_1)
		end
	end

	arg_5_0.lastOnlyMainVisible = var_5_0
end
