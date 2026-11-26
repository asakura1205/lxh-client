require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")
require("gamelogic.zbWorldTaskItem")

local var_0_0 = class("zbWorldTaskWnd", zbBaseWnd)

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

function createWorldTaskWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
		arg_3_0.taskItems = {}
		arg_3_0.taskdata = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_task.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbname = tolua.cast(arg_3_0.spriteHead:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbNeedTime = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(5), "CCLayer")

		for iter_5_0 = 1, 4 do
			local var_5_4 = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCNode")

			var_5_4:setVisible(false)

			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setScale(0.55)

			arg_3_0.awardItems[iter_5_0] = var_5_5

			var_5_3:addChild(var_5_5)
			var_5_4:removeFromParentAndCleanup(true)
		end

		arg_3_0.layerList = tolua.cast(var_5_2:getChildByTag(6), "CCLayer")
		arg_3_0.lbNoExplore = tolua.cast(var_5_2:getChildByTag(1007), "CCLabelTTF")
		arg_3_0.lbTimes = tolua.cast(var_5_2:getChildByTag(8), "CCLabelTTF")
		arg_3_0.btnSendHeros = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSendHeros:addHandleOfControlEvent(function()
			arg_3_0:onSendHeros()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onEventRfresh()
	end, zbGameEvent.Event_UpdateWorldTaskNode)
end

function var_0_0.onFrameUpdate(arg_10_0)
	if arg_10_0.isShow == false then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.taskItems) do
		iter_10_1:update()
	end
end

function var_0_0.onEventRfresh(arg_11_0)
	if arg_11_0.taskdata then
		local var_11_0 = g_Self.kWorldHandler:getWorldTaskInfoById(arg_11_0.taskdata.NodeId)

		if var_11_0 then
			arg_11_0:refresh(var_11_0)
		end
	end
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		return
	end

	arg_12_0.taskdata = arg_12_1

	local var_12_0 = arg_12_1.TeamList

	arg_12_0.lbNoExplore:setVisible(table.getn(var_12_0) <= 0)

	if zbUtil:isValidTable(var_12_0) then
		arg_12_0:confirmCreateView(var_12_0)
		arg_12_0:refreshItems(var_12_0)
	end

	local var_12_1 = arg_12_1.NodeId
	local var_12_2 = zbWorldNodeTable:getRecord(var_12_1)

	if var_12_2 then
		arg_12_0.lbTitle:setString(var_12_2.name)
		arg_12_0.lbname:setString(var_12_2.name)

		local var_12_3 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_12_2.texPath)

		if var_12_3 then
			arg_12_0.spriteHead:initWithSpriteFrame(var_12_3)
		end

		local var_12_4 = var_12_2.taskId

		for iter_12_0 = 1, 4 do
			arg_12_0.awardItems[iter_12_0]:setVisible(false)
		end

		local var_12_5 = zbWorldTaskTable:getRecord(var_12_4)

		if var_12_5 then
			local var_12_6 = 1

			for iter_12_1, iter_12_2 in pairs(var_12_5.awardPreview) do
				arg_12_0.awardItems[var_12_6]:setVisible(true)
				arg_12_0.awardItems[var_12_6]:refreshAward(iter_12_2.awardType, iter_12_2.awardId, iter_12_2.awardCount, false)

				var_12_6 = var_12_6 + 1
			end

			arg_12_0.lbDesc:setString(var_12_5.desc)
			arg_12_0.lbNeedTime:setString(var_12_5.needTm .. a2u("\xB7\xD6\xD6\xD3"))

			local var_12_7 = var_12_5.maxTeamCnt
			local var_12_8 = arg_12_1.DailyCount

			arg_12_0.lbTimes:setString(var_12_7 - var_12_8 .. "/" .. var_12_7)
			arg_12_0.btnSendHeros:setGray(var_12_7 <= var_12_8)
			arg_12_0.btnSendHeros:setEnabled(var_12_8 < var_12_7)
		end
	end
end

function var_0_0.confirmCreateView(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1

	if table.getn(arg_13_0.taskItems) == table.getn(var_13_0) then
		return
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.taskItems) do
		iter_13_1:removeFromParentAndCleanup(false)
	end

	arg_13_0.taskItems = {}

	if arg_13_0.tableView ~= nil then
		arg_13_0.tableView:removeFromParentAndCleanup(true)

		arg_13_0.tableView = nil
	end

	if arg_13_0.tableViewHelper ~= nil then
		arg_13_0.tableViewHelper = nil
	end

	local var_13_1 = table.getn(var_13_0)
	local var_13_2 = table.getn(arg_13_0.taskItems)
	local var_13_3 = arg_13_0.layerList:getContentSize()
	local var_13_4 = CCSizeMake(WorldTaskItem_Width, WorldTaskItem_Height * var_13_1)
	local var_13_5 = CCSizeMake(var_13_3.width, var_13_3.height)

	arg_13_0.tableViewHelper = zbTableViewHelper:create()
	arg_13_0.tableView = zbTableViewHelper:createTableView(var_13_4, var_13_5, kCCScrollViewDirectionVertical, arg_13_0.tableViewHelper)

	arg_13_0.tableView:setPosition(10, 0)
	arg_13_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_13_0.layerList:addChild(arg_13_0.tableView)

	if var_13_1 - var_13_2 > 0 then
		for iter_13_2 = 1, var_13_1 - var_13_2 do
			local var_13_6 = zbTableViewHelper:create()

			var_13_6:loadCCBFile("ccbi/tb_world_task.ccbi")

			local var_13_7 = zbWorldTaskItem:create(translateAndStrokeHelper(var_13_6:readCCBNode()))

			var_13_7:retain()

			arg_13_0.taskItems[var_13_2 + iter_13_2] = var_13_7

			var_13_6:releaseSelf()
		end
	end

	local var_13_8 = 1

	for iter_13_3, iter_13_4 in pairs(var_13_0) do
		local var_13_9 = arg_13_0.taskItems[var_13_8]

		arg_13_0.tableViewHelper:addCell(var_13_9)

		var_13_8 = var_13_8 + 1
	end

	arg_13_0.tableViewHelper:refreshTabelView()
	arg_13_0.tableViewHelper:setTouchPriority(arg_13_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_14_0, arg_14_1)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		arg_14_0.taskItems[var_14_0]:refresh(arg_14_0.taskdata.NodeId, iter_14_1)

		var_14_0 = var_14_0 + 1
	end
end

function var_0_0.onSendHeros(arg_15_0)
	if arg_15_0.taskdata then
		g_MainScene:showWorldTaskSetWnd(arg_15_0.taskdata):setPrevWnd(arg_15_0)
	end
end

function var_0_0.onTouchTest(arg_16_0)
	local var_16_0 = arg_16_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_16_0.layer, var_16_0.x, var_16_0.y) == false then
		arg_16_0:hide()
	end
end
