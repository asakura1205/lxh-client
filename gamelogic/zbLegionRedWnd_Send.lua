require("gamelogic.zbLegionRedSendItem")

local var_0_0 = class("zbLegionRedWnd_Send")

var_0_0.__index = var_0_0

function createLegionRedSend(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.parentWnd = arg_2_3
		arg_2_0.hongbaoItem = {}
	end

	local function var_2_1()
		local var_4_0 = zbTableViewHelper:create()

		var_4_0:loadCCBFile("ccbi/tb_legion_redsend.ccbi")

		for iter_4_0 = 1, 4 do
			local var_4_1 = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCLayerColor")
			local var_4_2 = zbLegionRedSendItem:create(translateAndStrokeHelper(var_4_0:readCCBNode()))

			var_4_2:setPosition(var_4_1:getPosition())
			arg_2_1:addChild(var_4_2)

			arg_2_0.hongbaoItem[iter_4_0] = var_4_2

			var_4_1:removeFromParentAndCleanup(true)
		end
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	if zbLegionHongbaoTable.records == nil then
		return
	end

	for iter_5_0 = 1, 4 do
		arg_5_0.hongbaoItem[iter_5_0]:setVisible(false)
	end

	local var_5_0 = 1

	for iter_5_1, iter_5_2 in pairs(zbLegionHongbaoTable.records) do
		arg_5_0.hongbaoItem[var_5_0]:refresh(iter_5_2)
		arg_5_0.hongbaoItem[var_5_0]:setVisible(true)

		var_5_0 = var_5_0 + 1
	end
end
