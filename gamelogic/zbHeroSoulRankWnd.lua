require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroSoulRankCell")
require("gamelogic.zbLegionHelp")

local var_0_0 = class("zbHeroSoulRankWnd", zbBaseWnd)

var_0_0.__index = var_0_0
LegionBossRank_height = 130

function createHeroSoulRankWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.awardItems = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroSoulrank.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.mainLayer = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()

			g_Self.kLegionHandler.HeroSoulRank = nil
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refreshDetail(arg_7_0)
	arg_7_0.heroSoulHallRank = g_Self.kRankHandler.HeroSoulRankData

	local var_7_0 = arg_7_0.heroSoulHallRank.RankList

	if zbUtil:isValidTable(var_7_0) then
		arg_7_0:createList(var_7_0)
		arg_7_0:refreshItems(var_7_0)
	end
end

function var_0_0.createList(arg_8_0, arg_8_1)
	if table.getn(arg_8_0.items) == table.getn(arg_8_1) then
		return
	end

	local var_8_0 = table.getn(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:removeFromParentAndCleanup(true)
	end

	arg_8_0.items = {}

	if arg_8_0.tableView ~= nil then
		arg_8_0.tableView:removeFromParentAndCleanup(true)

		arg_8_0.tableView = nil
		arg_8_0.tableViewHelper = nil
	end

	local var_8_1 = arg_8_0.mainLayer:getContentSize()
	local var_8_2 = CCSizeMake(var_8_1.width, LegionBossRank_height * var_8_0)
	local var_8_3 = CCSizeMake(var_8_1.width, var_8_1.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_2, var_8_3, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.mainLayer:addChild(arg_8_0.tableView)

	if var_8_0 > 0 then
		local var_8_4 = zbTableViewHelper:create()

		var_8_4:loadCCBFile("ccbi/tb_herosoulrank.ccbi")

		for iter_8_2 = 1, var_8_0 do
			local var_8_5 = createHeroSoulRankCell(translateAndStrokeHelper(var_8_4:readCCBNode()))

			var_8_5:retain()

			arg_8_0.items[iter_8_2] = var_8_5
		end

		var_8_4:releaseSelf()
	end

	local var_8_6 = 1

	for iter_8_3, iter_8_4 in pairs(arg_8_1) do
		local var_8_7 = arg_8_0.items[var_8_6]

		arg_8_0.tableViewHelper:addCell(var_8_7)

		var_8_6 = var_8_6 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_9_0, arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		arg_9_0.items[var_9_0]:refresh(iter_9_1, var_9_0)

		var_9_0 = var_9_0 + 1
	end
end
