require("gamelogic.zbSettingWnd_SocialItem")

local var_0_0 = class("zbSettingWnd_Social")

var_0_0.__index = var_0_0

function createSettingSocialPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		arg_2_0.layerSocial = tolua.cast(arg_2_2:getChildByTag(1), "CCLayer")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.items) do
		iter_5_1:removeFromParentAndCleanup(false)
	end

	if arg_5_0.tableView ~= nil then
		arg_5_0.tableView:removeFromParentAndCleanup(true)

		arg_5_0.tableView = nil
		arg_5_0.tableViewHelper = nil
	end

	local var_5_0 = {
		ESocialType.WeiBo,
		ESocialType.BaiDu,
		ESocialType.WeiXin,
		ESocialType.Magic
	}
	local var_5_1 = table.getn(var_5_0)
	local var_5_2 = table.getn(arg_5_0.items)
	local var_5_3 = 90
	local var_5_4 = arg_5_0.layerSocial:getContentSize()
	local var_5_5 = CCSizeMake(var_5_4.width, var_5_3 * var_5_1)
	local var_5_6 = CCSizeMake(var_5_4.width, var_5_4.height)

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_5, var_5_6, 1, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.layerSocial:addChild(arg_5_0.tableView)

	if var_5_1 - var_5_2 > 0 then
		for iter_5_2 = 1, var_5_1 - var_5_2 do
			local var_5_7 = zbTableViewHelper:create()

			var_5_7:loadCCBFile("ccbi/tb_setSocial.ccbi")

			local var_5_8 = createSetting_SocialItem(translateAndStrokeHelper(var_5_7:readCCBNode()))

			var_5_8:retain()

			arg_5_0.items[var_5_2 + iter_5_2] = var_5_8

			var_5_7:releaseSelf()
		end
	end

	local var_5_9 = 1

	for iter_5_3, iter_5_4 in pairs(var_5_0) do
		local var_5_10 = arg_5_0.items[var_5_9]

		var_5_10:refresh(iter_5_4)
		arg_5_0.tableViewHelper:addCell(var_5_10)

		var_5_9 = var_5_9 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.parentWnd.btnClose:getTouchPriority())
end
