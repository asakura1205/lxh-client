require("gamelogic.zbLegionWarHeroItem")

local var_0_0 = class("zbLegionWarHeroWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 100

function createLegionWarHeroWnd()
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
		arg_3_0.type = 1
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_hero.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbType = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= nil then
		arg_8_0.type = arg_8_1
	end

	arg_8_0.myIndex = arg_8_2

	if arg_8_0.type == ELgionWarHero.E_NodeAdd then
		arg_8_0.lbType:setString(a2u("战力"))
	elseif arg_8_0.type == ELgionWarHero.E_EliteSet then
		arg_8_0.lbType:setString(a2u("会馆贡献"))
	end

	local var_8_0 = arg_8_0:getMemberList()

	arg_8_0:confirmCreateView(var_8_0)
	arg_8_0:refreshItems(var_8_0)
end

local function var_0_2(arg_9_0, arg_9_1)
	return arg_9_0.PlayerBaseInfo.FV >= arg_9_1.PlayerBaseInfo.FV
end

function var_0_0.addExistList(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
		if arg_10_0.type == ELgionWarHero.E_NodeAdd then
			for iter_10_2, iter_10_3 in pairs(g_MainScene.wndLegionWarAssign.heroList) do
				table.insert(arg_10_0.existList, iter_10_3)
			end
		else
			for iter_10_4, iter_10_5 in pairs(iter_10_1.EliteList) do
				table.insert(arg_10_0.existList, iter_10_5)
			end
		end
	end
end

function var_0_0.getMemberList(arg_11_0)
	local var_11_0 = {}

	arg_11_0.existList = {}

	if g_Self.kLegionHandler.legionMemberDetail then
		arg_11_0:addExistList()

		for iter_11_0, iter_11_1 in pairs(g_Self.kLegionHandler.legionMemberDetail.MemberList) do
			local var_11_1 = false

			for iter_11_2, iter_11_3 in pairs(arg_11_0.existList) do
				if iter_11_3 == iter_11_1.PlayerBaseInfo.PlayerId then
					var_11_1 = true

					break
				end
			end

			if var_11_1 == false then
				table.insert(var_11_0, iter_11_1)
			end
		end
	end

	table.sort(var_11_0, var_0_2)

	return var_11_0
end

function var_0_0.confirmCreateView(arg_12_0, arg_12_1)
	if table.getn(arg_12_0.items) == table.getn(arg_12_1) then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		iter_12_1:removeFromParentAndCleanup(false)
	end

	arg_12_0.items = {}

	if arg_12_0.tableView ~= nil then
		arg_12_0.tableView:removeFromParentAndCleanup(true)

		arg_12_0.tableView = nil
		arg_12_0.tableViewHelper = nil
	end

	local var_12_0 = table.getn(arg_12_1)
	local var_12_1 = table.getn(arg_12_0.items)
	local var_12_2 = arg_12_0.layerContent:getContentSize()
	local var_12_3 = CCSizeMake(var_12_2.width, var_0_1 * var_12_0)
	local var_12_4 = CCSizeMake(var_12_2.width, var_12_2.height)

	arg_12_0.tableViewHelper = zbTableViewHelper:create()
	arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_3, var_12_4, 1, arg_12_0.tableViewHelper)

	arg_12_0.tableView:setPosition(0, 0)
	arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_12_0.layerContent:addChild(arg_12_0.tableView)

	if var_12_0 - var_12_1 > 0 then
		local var_12_5 = zbTableViewHelper:create()

		var_12_5:loadCCBFile("ccbi/tb_legionwar_hero.ccbi")

		for iter_12_2 = 1, var_12_0 - var_12_1 do
			local var_12_6 = createLegionWarHeroItem(translateAndStrokeHelper(var_12_5:readCCBNode()), arg_12_0)

			var_12_6:retain()

			arg_12_0.items[var_12_1 + iter_12_2] = var_12_6
		end
	end

	local var_12_7 = 1

	for iter_12_3, iter_12_4 in pairs(arg_12_1) do
		local var_12_8 = arg_12_0.items[var_12_7]

		var_12_8:refresh(iter_12_4, arg_12_0.type, arg_12_0.myIndex)
		arg_12_0.tableViewHelper:addCell(var_12_8)

		var_12_7 = var_12_7 + 1
	end

	arg_12_0.tableViewHelper:refreshTabelView()
	arg_12_0.tableViewHelper:setTouchPriority(arg_12_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		arg_13_0.items[var_13_0]:refresh(iter_13_1, arg_13_0.type, arg_13_0.myIndex)

		var_13_0 = var_13_0 + 1
	end
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layer, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
