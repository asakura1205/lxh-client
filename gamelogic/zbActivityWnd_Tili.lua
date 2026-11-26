require("gamelogic.zbTilitem")

zbActivityWnd_Tili = class("zbActivityWnd_Tili")
zbActivityWnd_Tili.__index = zbActivityWnd_Tili

function zbActivityWnd_Tili.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Tili)

	return arg_1_0
end

function zbActivityWnd_Tili.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbActivityWnd_Tili.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbActivityWnd_Tili.init(arg_3_0, arg_3_1, arg_3_2)
	(function()
		arg_3_0.items = {}
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
	end)()
end

function zbActivityWnd_Tili.refresh(arg_5_0)
	(function()
		if arg_5_0.node ~= nil then
			return
		end

		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/activity_tili.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")

		for iter_6_0 = 1, 3 do
			local var_6_3 = tolua.cast(var_6_2:getChildByTag(iter_6_0), "CCLayerColor")
			local var_6_4 = zbTilitem:create(iter_6_0, arg_5_0.btnPriority)

			var_6_4:setPosition(var_6_3:getPosition())
			var_6_2:addChild(var_6_4)
			var_6_3:removeFromParentAndCleanup(true)

			arg_5_0.items[iter_6_0] = var_6_4
		end

		arg_5_0.node = var_6_1

		arg_5_0.nodeParent:addChild(var_6_1)
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.Tili) == false then
		return
	end

	local var_5_0 = 1

	for iter_5_0, iter_5_1 in pairs(g_GameData.ActivityAct.Tili) do
		arg_5_0.items[var_5_0]:refresh(iter_5_1)

		var_5_0 = var_5_0 + 1
	end
end
