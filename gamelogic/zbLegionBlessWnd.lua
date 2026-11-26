require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionBlessItem")

local var_0_0 = class("zbLegionBlessWnd", zbBaseWnd)

var_0_0.__index = var_0_0
LegionBlessItem_Width = 260

function createLegionBlessWnd()
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
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_bless.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.mainLayer = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnRule = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.btnLog = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLog:addHandleOfControlEvent(function()
			arg_3_0:onBlessLog()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionBless_Ack)
end

function var_0_0.refresh(arg_10_0)
	local var_10_0 = g_Self.kLegionHandler.legionDetail.LegionBless

	if zbUtil:isValidTable(var_10_0) then
		arg_10_0:refreshDetail(var_10_0)
	else
		g_WsMsgHandler:WS_LegionGame_GetBless_Req()
	end
end

function var_0_0.refreshDetail(arg_11_0, arg_11_1)
	local var_11_0 = table.getn(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.items) do
		iter_11_1:removeFromParentAndCleanup(false)
	end

	arg_11_0.items = {}

	if arg_11_0.tableView ~= nil then
		arg_11_0.tableView:removeFromParentAndCleanup(true)

		arg_11_0.tableView = nil
		arg_11_0.tableViewHelper = nil
	end

	local var_11_1 = arg_11_0.mainLayer:getContentSize()
	local var_11_2 = CCSizeMake(LegionBlessItem_Width * var_11_0, var_11_1.height)
	local var_11_3 = CCSizeMake(var_11_1.width, var_11_1.height)

	arg_11_0.tableViewHelper = zbTableViewHelper:create()
	arg_11_0.tableView = zbTableViewHelper:createTableView(var_11_2, var_11_3, 0, arg_11_0.tableViewHelper)

	arg_11_0.tableView:setPosition(0, 0)
	arg_11_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_11_0.mainLayer:addChild(arg_11_0.tableView)
	arg_11_0.tableViewHelper:setMaskPanel(arg_11_0.left_arrow, arg_11_0.right_arrow, nil, nil)

	if var_11_0 > 0 then
		local var_11_4 = zbTableViewHelper:create()

		var_11_4:loadCCBFile("ccbi/tb_legionbless.ccbi")

		for iter_11_2 = 1, var_11_0 do
			local var_11_5 = createLegionBlessItem(translateAndStrokeHelper(var_11_4:readCCBNode()))

			var_11_5:retain()

			arg_11_0.items[iter_11_2] = var_11_5
		end
	end

	local var_11_6 = 1

	for iter_11_3, iter_11_4 in pairs(arg_11_1) do
		local var_11_7 = arg_11_0.items[var_11_6]

		var_11_7:refresh(iter_11_4)
		arg_11_0.tableViewHelper:addCell(var_11_7)

		var_11_6 = var_11_6 + 1
	end

	arg_11_0.tableViewHelper:refreshTabelView()
	arg_11_0.tableViewHelper:setTouchPriority(arg_11_0.btnRule:getTouchPriority())
end

function var_0_0.onRule(arg_12_0)
	g_MainScene:showRuleWnd(RuleType_LegionBless)
end

function var_0_0.onBlessLog(arg_13_0)
	g_WsMsgHandler:WS_LegionGame_GetBlessLog_Req()
end
