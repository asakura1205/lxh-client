require("gamelogic.zbBaseWnd")
require("gamelogic.zbWorldBossRankItem")

local var_0_0 = class("zbWorldBossRankWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 125

function createWorldBossRankWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		local var_5_1 = CCBReaderLoad("ccbi/world_boss_rank.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.lbRank = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDamage = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(2), "CCLayerColor")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1.SelfRank and type(arg_7_1.SelfRank) ~= "userdata" and arg_7_1.SelfRank ~= 0 then
		arg_7_0.lbRank:setString(arg_7_1.SelfRank)
	else
		arg_7_0.lbRank:setString(a2u("δ\xC9ϰ\xF1"))
	end

	if arg_7_1.SelfHurtHp and type(arg_7_1.SelfHurtHp) ~= "userdata" and arg_7_1.SelfHurtHp ~= 0 then
		arg_7_0.lbDamage:setString(arg_7_1.SelfHurtHp)
	else
		arg_7_0.lbDamage:setString(a2u("δ\xD4\xEC\xB3\xC9\xC9˺\xA6"))
	end

	arg_7_0:confirmCreateView(arg_7_1.RankList)
	arg_7_0:refreshItems(arg_7_1.RankList)
end

function var_0_0.confirmCreateView(arg_8_0, arg_8_1)
	if table.maxn(arg_8_0.items) == table.maxn(arg_8_1) then
		return
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:removeFromParentAndCleanup(false)
	end

	arg_8_0.items = {}

	if arg_8_0.tableView ~= nil then
		arg_8_0.tableView:removeFromParentAndCleanup(true)

		arg_8_0.tableView = nil
		arg_8_0.tableViewHelper = nil
	end

	if arg_8_1 == nil then
		arg_8_1 = {}
	end

	local var_8_0 = table.maxn(arg_8_1)
	local var_8_1 = table.maxn(arg_8_0.items)
	local var_8_2 = arg_8_0.layerContent:getContentSize()
	local var_8_3 = CCSizeMake(var_8_2.width, var_0_1 * var_8_0)
	local var_8_4 = CCSizeMake(var_8_2.width, var_8_2.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_3, var_8_4, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(ccp(0, 0))
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.layerContent:addChild(arg_8_0.tableView)

	if var_8_0 - var_8_1 > 0 then
		for iter_8_2 = 1, var_8_0 - var_8_1 do
			local var_8_5 = zbTableViewHelper:create()

			var_8_5:loadCCBFile("ccbi/tb_worldboss_rank.ccbi")

			local var_8_6 = createWorldBossRankItem(translateAndStrokeHelper(var_8_5:readCCBNode()))

			var_8_6:retain()

			arg_8_0.items[var_8_1 + iter_8_2] = var_8_6

			var_8_5:releaseSelf()
		end
	end

	local var_8_7 = 1

	for iter_8_3, iter_8_4 in pairs(arg_8_1) do
		local var_8_8 = arg_8_0.items[var_8_7]

		arg_8_0.tableViewHelper:addCell(var_8_8)

		var_8_7 = var_8_7 + 1
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
