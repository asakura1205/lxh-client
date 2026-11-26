require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionWarAssignItem")

local var_0_0 = class("zbLegionWarAssignWnd", zbBaseWnd)

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

function createLegionWarAssignWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.buildTitle = {}
		arg_3_0.heroItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_assign.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_1:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbNumDummy = tolua.cast(arg_3_0.layer:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnAuto = tolua.cast(arg_3_0.layer:getChildByTag(30), "CCControlButton")
		arg_3_0.moveHead = tolua.cast(arg_3_0.layer:getChildByTag(20), "CCSprite")
		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumDummy, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.48)
		arg_3_0.moveHead:setVisible(false)
		arg_3_0.btnAuto:addHandleOfControlEvent(function()
			arg_3_0:onAuto()
		end, CCControlEventTouchUpInside)

		for iter_5_0 = 1, 5 do
			local var_5_3 = tolua.cast(arg_3_0.layer:getChildByTag(iter_5_0 + 10), "CCNode")

			arg_3_0.buildTitle[iter_5_0] = tolua.cast(var_5_3:getChildByTag(0), "CCLabelTTF")

			for iter_5_1 = 1, 3 do
				local var_5_4 = zbTableViewHelper:create()

				var_5_4:loadCCBFile("ccbi/tb_legionwaradd.ccbi")

				local var_5_5 = tolua.cast(var_5_3:getChildByTag(iter_5_1), "CCNode")

				var_5_5:setVisible(false)

				local var_5_6 = createLegionWarAssignItem(translateAndStrokeHelper(var_5_4:readCCBNode()), (iter_5_0 - 1) * 3 + iter_5_1, arg_3_0)

				var_5_6:setPosition(var_5_5:getPosition())

				arg_3_0.heroItems[(iter_5_0 - 1) * 3 + iter_5_1] = var_5_6

				var_5_3:addChild(var_5_6)
				var_5_5:removeFromParentAndCleanup(true)
				var_5_4:releaseSelf()
			end
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_LegionMemberDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBubble()
	end, zbGameEvent.Event_LegionWarDefendSet)
end

function var_0_0.refresh(arg_11_0, arg_11_1)
	arg_11_0.nodeId = arg_11_1

	arg_11_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_12_0)
	local var_12_0

	if zbUtil:isValidTable(g_Self.kLegionHandler.legionWarNodeList) == true then
		for iter_12_0, iter_12_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
			if arg_12_0.nodeId == iter_12_1.NodeId then
				var_12_0 = iter_12_1
			end
		end
	end

	local var_12_1 = g_Self.kLegionHandler.legionWarBaseInfo

	arg_12_0.warNode = var_12_0

	if arg_12_0.warNode == nil then
		return
	end

	local var_12_2 = zbWarNodeTable:getRecord(var_12_0.NodeId)

	if zbUtil:isValidTable(var_12_2) == false then
		return
	end

	for iter_12_2 = 1, 5 do
		arg_12_0.buildTitle[iter_12_2]:setString(var_12_2.buildNode[iter_12_2].buildName)
	end

	arg_12_0.heroList = {}

	for iter_12_3 = 1, 15 do
		arg_12_0.heroList[iter_12_3] = 0
	end

	for iter_12_4, iter_12_5 in pairs(var_12_0.BuildList) do
		local var_12_3 = 1

		for iter_12_6, iter_12_7 in pairs(iter_12_5.DefendList) do
			arg_12_0.heroList[(iter_12_5.BuildId - 1) * 3 + var_12_3] = iter_12_7
			var_12_3 = var_12_3 + 1
		end
	end

	arg_12_0:freshHeroList()
end

function var_0_0.freshHeroList(arg_13_0)
	local var_13_0 = 1
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroList) do
		local var_13_2 = g_Self.kLegionHandler:getMemberData(iter_13_1)
		local var_13_3 = arg_13_0.heroItems[var_13_0]

		if var_13_3 then
			var_13_3:refresh(var_13_2)

			if var_13_2 then
				var_13_1 = var_13_1 + 1
			end
		end

		var_13_0 = var_13_0 + 1
	end

	arg_13_0.lbNum:setString(var_13_1 .. "/" .. 15)
end

local function var_0_1(arg_14_0, arg_14_1)
	return arg_14_0.PlayerBaseInfo.FV >= arg_14_1.PlayerBaseInfo.FV
end

function var_0_0.onAuto(arg_15_0)
	if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) ~= ELegionOffice.Leader then
		g_Bubble:bubbleInfo(a2u("\xB7ǻ\xE1\xB9ݳ\xA4\xBD\xF6\xBFɲ鿴"))

		return
	end

	local var_15_0 = g_Self.kLegionHandler.legionMemberDetail.MemberList

	table.sort(var_15_0, var_0_1)

	for iter_15_0 = 1, 15 do
		arg_15_0.heroList[iter_15_0] = 0
	end

	local var_15_1 = 1

	for iter_15_1, iter_15_2 in pairs(var_15_0) do
		if var_15_1 > 15 then
			break
		end

		arg_15_0.heroList[var_15_1] = iter_15_2.PlayerBaseInfo.PlayerId
		var_15_1 = var_15_1 + 1
	end

	arg_15_0:freshHeroList()
end

function var_0_0.onTouchTest(arg_16_0)
	local var_16_0 = arg_16_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_16_0.layer, var_16_0.x, var_16_0.y) == false then
		arg_16_0:onClose()
	end
end

function var_0_0.onClose(arg_17_0)
	if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) == ELegionOffice.Leader then
		g_WsMsgHandler:WS_LegionWar_DefendSet_Req(arg_17_0.nodeId, arg_17_0.heroList)
	end

	arg_17_0:hide()
end

function var_0_0.onBubble(arg_18_0)
	g_Bubble:bubbleInfo(a2u("\xCA\xD8\xCE\xC0\xB7\xD6\xC5\xE4\xCD\xEA\xB3\xC9"))
end
