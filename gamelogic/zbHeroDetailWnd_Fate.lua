require("gamelogic.zbHeroDetailWnd_Fate_Sub")

local var_0_0 = 120

zbHeroDetailWnd_Fate = class("zbHeroDetailWnd_Fate")
zbHeroDetailWnd_Fate.__index = zbHeroDetailWnd_Fate

function zbHeroDetailWnd_Fate.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.layerContent = tolua.cast(arg_1_1:getChildByTag(1), "CCLayerColor")
		arg_1_0.lbHint = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.btnPriority = arg_1_2
	end

	var_1_0()
	var_1_1()
end

function zbHeroDetailWnd_Fate.refresh(arg_4_0, arg_4_1)
	arg_4_0:confirmCreateView(arg_4_1)
end

function zbHeroDetailWnd_Fate.confirmCreateView(arg_5_0, arg_5_1)
	local var_5_0 = zbFateTable:getHeroFateRecord(arg_5_1.HeroBaseInfo.TemplateId, EFateType.Hero)

	if var_5_0 ~= nil then
		local var_5_1 = table.getn(var_5_0)

		if arg_5_0.tableView == nil then
			local var_5_2 = arg_5_0.layerContent:getContentSize()

			arg_5_0.tableViewHelper = zbTableViewHelper:create()
			arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_2, var_5_2, 1, arg_5_0.tableViewHelper)

			arg_5_0.tableView:setPosition(0, 0)
			arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
			arg_5_0.layerContent:addChild(arg_5_0.tableView)
		else
			arg_5_0.tableViewHelper:removeAllCells()
		end

		arg_5_0.lbHint:setVisible(false)

		local var_5_3 = var_5_1 + 6
		local var_5_4 = table.getn(arg_5_0.items)

		if var_5_3 - var_5_4 > 0 then
			for iter_5_0 = 1, var_5_3 - var_5_4 do
				local var_5_5 = zbTableViewHelper:create()

				var_5_5:loadCCBFile("ccbi/tb_fateItem.ccbi")

				local var_5_6 = zbHeroDetailWnd_Fate_Sub:create(translateAndStrokeHelper(var_5_5:readCCBNode()))

				var_5_6:retain()

				arg_5_0.items[var_5_4 + iter_5_0] = var_5_6

				var_5_5:releaseSelf()
			end
		end

		local var_5_7 = 1

		for iter_5_1, iter_5_2 in pairs(arg_5_1.FateEquipList) do
			local var_5_8 = arg_5_0.items[var_5_7]

			if iter_5_2.FateId ~= 0 then
				var_5_8:refreshEquip(arg_5_1, iter_5_2)
				arg_5_0.tableViewHelper:addCell(var_5_8)

				var_5_7 = var_5_7 + 1
			end
		end

		for iter_5_3, iter_5_4 in pairs(var_5_0) do
			local var_5_9 = arg_5_0.items[var_5_7]

			var_5_9:refreshHero(arg_5_1, iter_5_4)
			arg_5_0.tableViewHelper:addCell(var_5_9)

			var_5_7 = var_5_7 + 1
		end

		arg_5_0.tableViewHelper:refreshTabelView()
		arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())
	else
		arg_5_0.lbHint:setVisible(true)
	end
end

function zbHeroDetailWnd_Fate.free(arg_6_0)
	return
end

function createHeroFateDetailPanel(arg_7_0, arg_7_1)
	local var_7_0 = zbHeroDetailWnd_Fate.new()

	var_7_0:init(arg_7_0, arg_7_1)

	return var_7_0
end
