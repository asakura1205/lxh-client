require("gamelogic.zbBaseWnd")
require("gamelogic.zbGetWayItem")
require("gamelogic.zbGetWayNewHeroSkill")
require("gamelogic.zbItem")

zbGetWayNewHeroWnd = class("zbGetWayNewHeroWnd", zbBaseWnd)
zbGetWayNewHeroWnd.__index = zbGetWayNewHeroWnd

function zbGetWayNewHeroWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbGetWayNewHeroWnd)

	return arg_1_0
end

function createGetWayNewHeroWnd()
	local var_2_0 = zbGetWayNewHeroWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbGetWayNewHeroWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.headDummy = nil
		arg_3_0.templateId = -1
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.skillItems = {}
		arg_3_0.fateNode = {}
		arg_3_0.fateTitle = {}
		arg_3_0.fateHero = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/fraggetway_newhero.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())

		arg_3_0.headDummy = var_5_4

		var_5_2:addChild(arg_3_0.headDummy)
		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbCompose = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.lbEmpty = tolua.cast(var_5_2:getChildByTag(1000), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(7), "CCLayer")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_6 = zbTableViewHelper:create()

			var_5_6:loadCCBFile("ccbi/tb_item.ccbi")

			local var_5_7 = tolua.cast(var_5_5:getChildByTag(iter_5_0), "CCNode")
			local var_5_8 = zbGetWayNewHeroSkill:create(translateAndStrokeHelper(var_5_6:readCCBNode()), iter_5_0)

			var_5_8:setPosition(var_5_7:getPosition())
			var_5_8:setScale(0.6)

			arg_3_0.skillItems[iter_5_0] = var_5_8

			var_5_5:addChild(var_5_8)
			var_5_7:removeFromParentAndCleanup(true)
			var_5_6:releaseSelf()
		end

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.btnFate = tolua.cast(var_5_2:getChildByTag(101), "CCControlButton")

		arg_3_0.btnFate:setVisible(false)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.layerFate = tolua.cast(var_5_2:getChildByTag(99), "CCNode")

		arg_3_0.layerFate:setZOrder(ZORDER_TOP)
		arg_3_0.layerFate:setVisible(false)

		arg_3_0.lbFateHint = tolua.cast(arg_3_0.layerFate:getChildByTag(0), "CCLabelTTF")
		arg_3_0.spriteFateBg = tolua.cast(arg_3_0.layerFate:getChildByTag(50), "CCScale9Sprite")

		for iter_5_1 = 1, 9 do
			arg_3_0.fateNode[iter_5_1] = tolua.cast(arg_3_0.layerFate:getChildByTag(iter_5_1), "CCNode")
			arg_3_0.fateTitle[iter_5_1] = tolua.cast(arg_3_0.fateNode[iter_5_1]:getChildByTag(3), "CCLabelTTF")
			arg_3_0.fateHero[iter_5_1] = tolua.cast(arg_3_0.fateNode[iter_5_1]:getChildByTag(2), "CCLabelTTF")

			arg_3_0.fateHero[iter_5_1]:setVisible(false)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbGetWayNewHeroWnd.refresh(arg_10_0, arg_10_1)
	arg_10_0.templateId = arg_10_1

	arg_10_0.headDummy:refreshAward(ECommonAwardType.HeroFrag, arg_10_1, nil, false)

	local var_10_0 = zbHeroTable:getRecord(arg_10_1)
	local var_10_1 = g_Self.kHeroFragHandler:getHeroFragCount(arg_10_1)
	local var_10_2 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_10_1)

	if var_10_2 ~= nil then
		arg_10_0.lbCompose:setString(var_10_1 .. "/" .. var_10_2.needFrag)
	end

	if var_10_0 ~= nil then
		arg_10_0.lbName:setString(var_10_0.name)
		arg_10_0.lbDesc:setString(var_10_0.description)
	end

	for iter_10_0 = 1, 5 do
		arg_10_0.skillItems[iter_10_0]:setVisible(false)
	end

	for iter_10_1 = 1, 5 do
		local var_10_3 = zbHeroTable:getHeroSkillId(arg_10_1, iter_10_1)

		if var_10_3 ~= 0 then
			arg_10_0.skillItems[iter_10_1]:refresh(var_10_3, iter_10_1)
			arg_10_0.skillItems[iter_10_1]:setVisible(true)
		end
	end

	if arg_10_0.tableView == nil then
		local var_10_4 = arg_10_0.layerContent:getContentSize()

		arg_10_0.tableViewHelper = zbTableViewHelper:create()
		arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_4, var_10_4, 1, arg_10_0.tableViewHelper)

		arg_10_0.tableView:setPosition(5, 0)
		arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_10_0.layerContent:addChild(arg_10_0.tableView)
	else
		arg_10_0.tableViewHelper:removeAllCells()
	end

	local var_10_5 = g_Self.kGetWayHandler:getWays(arg_10_0.templateId)
	local var_10_6 = table.getn(var_10_5.ways)
	local var_10_7 = table.getn(arg_10_0.items)

	for iter_10_2 = 1, var_10_7 do
		if iter_10_2 <= var_10_6 then
			local var_10_8 = arg_10_0.items[iter_10_2]

			arg_10_0.tableViewHelper:addCell(var_10_8)
		end
	end

	if var_10_6 - var_10_7 > 0 then
		for iter_10_3 = 1, var_10_6 - var_10_7 do
			local var_10_9 = zbTableViewHelper:create()

			var_10_9:loadCCBFile("ccbi/tb_getway.ccbi")

			local var_10_10 = zbGetWayItem:create(translateAndStrokeHelper(var_10_9:readCCBNode()), arg_10_0)

			var_10_10:retain()

			arg_10_0.items[var_10_7 + iter_10_3] = var_10_10

			arg_10_0.tableViewHelper:addCell(var_10_10)
			var_10_9:releaseSelf()
		end
	end

	local var_10_11 = 1

	for iter_10_4, iter_10_5 in pairs(var_10_5.ways) do
		arg_10_0.items[var_10_11]:refresh(iter_10_5, arg_10_0.parentFromWnd)

		var_10_11 = var_10_11 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnTouchTest:getTouchPriority())
	arg_10_0.lbEmpty:setVisible(var_10_6 <= 0)
end

function zbGetWayNewHeroWnd.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end

function zbGetWayNewHeroWnd.onTouchDown(arg_12_0)
	arg_12_0:refreshFate(arg_12_0.templateId)
	arg_12_0.layerFate:setVisible(true)
end

function zbGetWayNewHeroWnd.onTouchEnd(arg_13_0)
	arg_13_0.layerFate:setVisible(false)
end

function zbGetWayNewHeroWnd.refreshFate(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.fateNode) do
		iter_14_1:setVisible(false)
	end

	arg_14_0.lbFateHint:setVisible(false)

	local var_14_0 = zbFateTable:getRecord(arg_14_1)

	if var_14_0 == nil then
		arg_14_0.lbFateHint:setVisible(true)
		arg_14_0.spriteFateBg:setContentSize(CCSizeMake(450, 200))

		return
	end

	local var_14_1 = 0

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		if var_14_1 >= 5 or iter_14_3 == nil then
			return
		end

		if iter_14_3.fateType == EFateType.Hero then
			-- block empty
		else
			arg_14_0.fateTitle[var_14_1 + 1]:setString(a2u(EFateAttrTypeName[iter_14_3.fateAttr] .. "+" .. iter_14_3.growthPercent * 100 .. "%"))

			local var_14_2 = ""

			for iter_14_4, iter_14_5 in pairs(iter_14_3.fateCondition) do
				arg_14_0.haveEquip = false

				for iter_14_6, iter_14_7 in pairs(arg_14_0.heroDetail.FateEquipList) do
					if iter_14_7.FateId == iter_14_5 then
						arg_14_0.haveEquip = true

						break
					end
				end

				local var_14_3 = zbItemTable:getRecord(iter_14_5)

				if var_14_3 then
					local var_14_4 = ""

					if arg_14_0.haveEquip then
						var_14_4 = zbUtil:getRichColorString(var_14_3.name .. a2u("(\xBC\xA4\xBB\xEE)"), HEX_FONT_COLOR_GREEN)
					else
						var_14_4 = zbUtil:getRichColorString(var_14_3.name .. a2u("(δ\xBC\xA4\xBB\xEE)"), HEX_FONT_COLOR_RED)
					end

					if iter_14_4 == 1 then
						var_14_2 = var_14_4
					else
						var_14_2 = var_14_2 .. "," .. var_14_4
					end
				end
			end

			arg_14_0.fateHero[var_14_1 + 1]:setRichString(var_14_2)
			arg_14_0.fateNode[var_14_1 + 1]:setVisible(true)

			var_14_1 = var_14_1 + 1
		end
	end

	if var_14_1 <= 0 then
		arg_14_0.lbFateHint:setVisible(true)
		arg_14_0.spriteFateBg:setContentSize(CCSizeMake(450, 200))

		return
	end

	local var_14_5 = 70

	arg_14_0.spriteFateBg:setContentSize(CCSizeMake(450, var_14_5 + 35 * (var_14_1 - 1)))
end
