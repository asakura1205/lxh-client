local var_0_0 = class("zbMapNodeMgr")

var_0_0.__index = var_0_0

function createMapNodeMgr(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.nodeLayer = CCNodeRGBA:create()

	arg_2_0.nodeLayer:setCascadeOpacityEnabled(true)
	arg_2_1:addChild(arg_2_0.nodeLayer)

	arg_2_0.worldmap = arg_2_2
	arg_2_0.nodelist = {}
	arg_2_0.randNodelist = {}

	arg_2_0:initMainCity()
end

function var_0_0.setLayerOpacity(arg_3_0, arg_3_1)
	if arg_3_1 <= 150 then
		arg_3_0.nodeLayer:setVisible(false)
	else
		arg_3_0.nodeLayer:setVisible(true)
	end
end

function var_0_0.setLayerVisible(arg_4_0, arg_4_1)
	arg_4_0.nodeLayer:setVisible(arg_4_1)
end

function var_0_0.getNodeById(arg_5_0, arg_5_1)
	return arg_5_0.nodelist[arg_5_1]
end

function var_0_0.initMainCity(arg_6_0)
	local var_6_0 = zbWorldNodeTable.maincityRecord

	if var_6_0 then
		local var_6_1 = createMapNodeMainCity(var_6_0)

		arg_6_0.nodeLayer:addChild(var_6_1)

		arg_6_0.nodelist[var_6_0.id] = var_6_1
	end
end

function var_0_0.refreshNodeResById(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.nodelist[arg_7_1]

	if var_7_0 then
		var_7_0:refreshInfo()
	end
end

function var_0_0.initNodes(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.nodelist) do
		iter_8_1:setlayerVisible(false)
	end

	local var_8_0 = g_Self.kWorldHandler.worldInfo

	if var_8_0 and zbUtil:isValidTable(var_8_0.ViewNodeList) then
		for iter_8_2, iter_8_3 in pairs(var_8_0.ViewNodeList) do
			local var_8_1 = zbWordHelp:createMapNode(iter_8_3.NodeId, arg_8_0.nodeLayer, arg_8_0.nodelist)

			if var_8_1 then
				var_8_1:refresh(EWorldNodeOccupyType.E_LOSE)
			end
		end
	end

	if var_8_0 and zbUtil:isValidTable(var_8_0.HoldNodeList) then
		for iter_8_4, iter_8_5 in pairs(var_8_0.HoldNodeList) do
			local var_8_2 = zbWordHelp:createMapNode(iter_8_5.NodeId, arg_8_0.nodeLayer, arg_8_0.nodelist)

			if var_8_2 then
				var_8_2:refresh(EWorldNodeOccupyType.E_HOLD)
			end
		end
	end

	if var_8_0 and zbUtil:isValidTable(var_8_0.TaskList) then
		for iter_8_6, iter_8_7 in pairs(var_8_0.TaskList) do
			local var_8_3 = zbWordHelp:createMapNode(iter_8_7.NodeId, arg_8_0.nodeLayer, arg_8_0.nodelist)

			if var_8_3 then
				var_8_3:refresh()
			end
		end
	end

	if var_8_0 and zbUtil:isValidTable(var_8_0.GodDomainList) then
		for iter_8_8, iter_8_9 in pairs(var_8_0.GodDomainList) do
			local var_8_4 = zbWordHelp:createMapNode(iter_8_9.NodeId, arg_8_0.nodeLayer, arg_8_0.nodelist)

			if var_8_4 then
				var_8_4:refresh(iter_8_9)
			end
		end
	end

	if var_8_0 and zbUtil:isValidTable(var_8_0.NodeList) then
		for iter_8_10, iter_8_11 in pairs(var_8_0.NodeList) do
			local var_8_5 = zbWorldNodeTable:getRecord(iter_8_11)

			if var_8_5 and var_8_5.nodeType == EWorldNodeType.WorldBoss then
				local var_8_6 = createMapNodeBoss(var_8_5)

				arg_8_0.nodeLayer:addChild(var_8_6)

				arg_8_0.nodelist[var_8_5.id] = var_8_6
			end
		end
	end
end

function var_0_0.initRandNodeInfo(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.randNodelist) do
		iter_9_1:setlayerVisible(false)
	end

	local var_9_0 = g_Self.kWorldHandler.worldInfo

	if var_9_0 and zbUtil:isValidTable(var_9_0.SpecialList) then
		for iter_9_2, iter_9_3 in pairs(var_9_0.SpecialList) do
			local var_9_1 = zbWordHelp:createMapNode(iter_9_3, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_1 then
				var_9_1:refresh(nil)
			end
		end
	end

	if var_9_0 and zbUtil:isValidTable(var_9_0.HorseCarList) then
		for iter_9_4, iter_9_5 in pairs(var_9_0.HorseCarList) do
			local var_9_2 = iter_9_5.NodeId
			local var_9_3 = zbWordHelp:createMapNode(var_9_2, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_3 then
				var_9_3:refresh(EWorldSpecialNode.HorseCar)
			end
		end
	end

	if var_9_0 and zbUtil:isValidTable(var_9_0.FaceList) then
		for iter_9_6, iter_9_7 in pairs(var_9_0.FaceList) do
			local var_9_4 = iter_9_7.NodeId
			local var_9_5 = zbWordHelp:createMapNode(var_9_4, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_5 then
				var_9_5:refresh(EWorldSpecialNode.Face)
			end
		end
	end

	if var_9_0 and zbUtil:isValidTable(var_9_0.AwardBoxList) then
		for iter_9_8, iter_9_9 in pairs(var_9_0.AwardBoxList) do
			local var_9_6 = iter_9_9
			local var_9_7 = zbWordHelp:createMapNode(var_9_6, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_7 then
				var_9_7:refresh(EWorldSpecialNode.AwardBox)
			end
		end
	end

	if var_9_0 and var_9_0.BgzInfo then
		local var_9_8 = var_9_0.BgzInfo.NodeId

		if var_9_8 ~= 0 then
			local var_9_9 = zbWordHelp:createMapNode(var_9_8, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_9 then
				var_9_9:refresh(EWorldSpecialNode.BgzClue)
			end
		end
	end

	if var_9_0 and var_9_0.ShopInfo then
		local var_9_10 = var_9_0.ShopInfo.NodeId

		if var_9_10 ~= 0 then
			local var_9_11 = zbWordHelp:createMapNode(var_9_10, arg_9_0.nodeLayer, arg_9_0.randNodelist)

			if var_9_11 then
				var_9_11:refresh(EWorldSpecialNode.Shop)
			end
		end
	end
end

function var_0_0.unlockNode(arg_10_0)
	if WorldUnlockAckData then
		local var_10_0 = WorldUnlockAckData.NodeId

		if WorldUnlockAckData.NodeType == EWorldNodeType.ResNode then
			local var_10_1 = zbWordHelp:createMapNode(var_10_0, arg_10_0.nodeLayer, arg_10_0.nodelist)

			if var_10_1 then
				var_10_1:refresh(EWorldNodeOccupyType.E_LOSE)
			end
		elseif WorldUnlockAckData.NodeType == EWorldNodeType.TaskNode then
			local var_10_2 = zbWordHelp:createMapNode(var_10_0, arg_10_0.nodeLayer, arg_10_0.nodelist)

			if var_10_2 then
				var_10_2:refresh()
			end
		elseif WorldUnlockAckData.NodeType == EWorldNodeType.GodDomain then
			local var_10_3 = zbWordHelp:createMapNode(var_10_0, arg_10_0.nodeLayer, arg_10_0.nodelist)

			if var_10_3 then
				var_10_3:refresh()
			end
		elseif WorldUnlockAckData.NodeType == EWorldNodeType.NullNode then
			if WorldUnlockAckData.SpecialNode ~= 0 then
				local var_10_4 = zbWordHelp:createMapNode(var_10_0, arg_10_0.nodeLayer, arg_10_0.randNodelist)

				if var_10_4 then
					var_10_4:refresh(nil)
				end
			end
		elseif WorldUnlockAckData.NodeType == EWorldNodeType.WorldBoss then
			local var_10_5 = zbWorldNodeTable:getRecord(var_10_0)

			if var_10_5 then
				local var_10_6 = createMapNodeBoss(var_10_5)

				arg_10_0.nodeLayer:addChild(var_10_6)

				arg_10_0.nodelist[var_10_5.id] = var_10_6
			end
		end
	end
end

function var_0_0.update(arg_11_0)
	if arg_11_0.worldmap == nil then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.nodelist) do
		if iter_11_1 then
			arg_11_0.worldmap:objectClip(iter_11_1)
			iter_11_1:update()
		end
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.randNodelist) do
		if iter_11_3 then
			arg_11_0.worldmap:objectClip(iter_11_3)
			iter_11_3:update()
		end
	end
end
