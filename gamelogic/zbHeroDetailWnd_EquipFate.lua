require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroDetailWnd_EquipFateItem")

local var_0_0 = class("zbHeroDetailWnd_EquipFate", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createEquipFateListWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equipFate_list.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layer:getChildByTag(0), "CCSprite")
		arg_3_0.layerContent = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLayerColor")
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(100), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_Hero)
end

function var_0_0.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.fateType = arg_8_2
	arg_8_0.heroDetail = arg_8_1

	local var_8_0 = zbFateTable:getHeroFateRecord(arg_8_1.HeroBaseInfo.TemplateId, arg_8_2)

	if var_8_0 ~= nil then
		if arg_8_0.tableView == nil then
			local var_8_1 = arg_8_0.layerContent:getContentSize()

			arg_8_0.tableViewHelper = zbTableViewHelper:create()
			arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_1, var_8_1, 0, arg_8_0.tableViewHelper)

			arg_8_0.tableView:setPosition(0, 0)
			arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
			arg_8_0.layerContent:addChild(arg_8_0.tableView)
		else
			arg_8_0.tableViewHelper:removeAllCells()
		end

		local var_8_2 = table.getn(var_8_0)
		local var_8_3 = table.getn(arg_8_0.items)

		for iter_8_0 = 1, var_8_3 do
			if iter_8_0 <= var_8_2 then
				local var_8_4 = arg_8_0.items[iter_8_0]

				arg_8_0.tableViewHelper:addCell(var_8_4)
			end
		end

		if var_8_2 - var_8_3 > 0 then
			for iter_8_1 = 1, var_8_2 - var_8_3 do
				local var_8_5 = zbTableViewHelper:create()

				var_8_5:loadCCBFile("ccbi/tb_equipfateitem.ccbi")

				local var_8_6 = zbHeroDetailWnd_EquipFateItem:create(translateAndStrokeHelper(var_8_5:readCCBNode()), arg_8_0)

				var_8_6:retain()

				arg_8_0.items[var_8_3 + iter_8_1] = var_8_6

				arg_8_0.tableViewHelper:addCell(var_8_6)
				var_8_5:releaseSelf()
			end
		end

		local var_8_7 = 1

		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			arg_8_0.items[var_8_7]:refresh(arg_8_1, iter_8_3)

			var_8_7 = var_8_7 + 1
		end

		arg_8_0.tableViewHelper:refreshTabelView()
		arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnTouchTest:getTouchPriority())
		zbUtil:setTableViewOffset(arg_8_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, var_8_2, 160, 1)
	else
		arg_8_0:hide()
	end
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.spriteBg, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end

function var_0_0.refreshUpdate(arg_10_0)
	if arg_10_0.isShow == false then
		return
	end

	if arg_10_0.heroDetail ~= nil then
		arg_10_0.heroDetail = g_Self.kHeroHandler:getHeroByTemplateId(arg_10_0.heroDetail.HeroBaseInfo.TemplateId)

		if arg_10_0.heroDetail == nil then
			arg_10_0:hide()

			return
		end

		arg_10_0:refresh(arg_10_0.heroDetail, arg_10_0.fateType)
	else
		arg_10_0:hide()
	end
end
