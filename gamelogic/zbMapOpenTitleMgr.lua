require("gamelogic.zbMapNodeOpenDlg")

local var_0_0 = class("zbMapOpenTitleMgr")

var_0_0.__index = var_0_0

function createMapOpenTitleMgr(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.nodeLayer = CCNodeRGBA:create()

	arg_2_0.nodeLayer:setCascadeOpacityEnabled(true)
	arg_2_1:addChild(arg_2_0.nodeLayer)

	arg_2_0.nodelist = {}
	arg_2_0.worldmap = arg_2_2
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

function var_0_0.refreshInfo(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.nodelist) do
		iter_5_1:setlayerVisible(false)
	end

	local var_5_0 = false
	local var_5_1 = zbWorldNodeTable.records

	if zbUtil:isValidTable(var_5_1) then
		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			local var_5_2 = iter_5_3.needTechLevel
			local var_5_3 = g_Self.kTechHandler:getStudyedTechLevel(3001)

			local function var_5_4()
				return var_5_3 >= var_5_2
			end

			local var_5_5 = arg_5_0.nodelist[iter_5_3.id]

			if g_Self.kWorldHandler:isNodeOpenById(iter_5_3.id) == false and var_5_4() then
				if var_5_5 == nil then
					var_5_5 = createMapNodeOpenGlg()
					arg_5_0.nodelist[iter_5_3.id] = var_5_5

					arg_5_0.nodeLayer:addChild(var_5_5)
				end

				var_5_5:refresh(iter_5_3)
				var_5_5:setlayerVisible(true)

				var_5_0 = true or var_5_0
			end
		end
	end

	if var_5_0 == false then
		local var_5_6 = g_Self.kWorldHandler:getNextOpenNeedTechlv()

		if zbUtil:isValidTable(var_5_1) then
			for iter_5_4, iter_5_5 in pairs(var_5_1) do
				if iter_5_5.needTechLevel == var_5_6 and g_Self.kWorldHandler:isNodeOpenById(iter_5_5.id) == false then
					local var_5_7 = arg_5_0.nodelist[iter_5_5.id]

					if var_5_7 == nil then
						var_5_7 = createMapNodeOpenGlg()
						arg_5_0.nodelist[iter_5_5.id] = var_5_7

						arg_5_0.nodeLayer:addChild(var_5_7)
					end

					var_5_7:refresh(iter_5_5)
					var_5_7:setlayerVisible(true)
				end
			end
		end
	end
end

function var_0_0.update(arg_7_0)
	if arg_7_0.worldmap == nil then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.nodelist) do
		if iter_7_1 then
			arg_7_0.worldmap:objectClip(iter_7_1)
		end
	end
end
