require("gamelogic.zbBaseWnd")
require("gamelogic.zbChatContent")

local var_0_0 = class("zbBroadcast", zbBaseWnd)

var_0_0.__index = var_0_0

function createBroadcast()
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
		arg_3_0.scrollDataList = {}
		arg_3_0.scrollState = 0
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/broadcast.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layerInfo = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layerInfo:getChildByTag(1), "CCSprite")
		arg_3_0.layerBroad = tolua.cast(arg_3_0.layerInfo:getChildByTag(2), "CCLayer")

		arg_3_0.layerInfo:setCascadeOpacityEnabled(true)
		arg_3_0.layerInfo:setVisible(false)
		arg_3_0:addChild(var_5_1)
		arg_3_0:retain()
	end

	var_3_0()
	var_3_1()
	arg_3_0:setZOrder(ZORDER_TOP)
	arg_3_0:confirmCreateView()
end

function var_0_0.setBroadCastVisible(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0:setZOrder(ZORDER_TOP)
	else
		arg_6_0:setZOrder(ZORDER_BOTTOM)
	end
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if g_Self == nil or g_Self:getName() == "" then
		return
	end

	local function var_7_0(arg_8_0, arg_8_1)
		if arg_8_0.Priority == arg_8_1.Priority then
			return arg_8_0.Tm < arg_8_1.Tm
		end

		return arg_8_0.Priority < arg_8_1.Priority
	end

	if arg_7_1 ~= nil then
		arg_7_0.layerInfo:setVisible(true)

		for iter_7_0 = 1, arg_7_1.Repeat do
			if iter_7_0 ~= 1 then
				local var_7_1 = {
					ScrollType = arg_7_1.ScrollType,
					Priority = arg_7_1.Priority,
					Repeat = arg_7_1.Repeat,
					Interval = arg_7_1.Interval,
					SysChat = arg_7_1.SysChat,
					Content = arg_7_1.Content,
					Tm = arg_7_1.Tm + arg_7_1.Interval * (iter_7_0 - 1)
				}

				table.insert(arg_7_0.scrollDataList, var_7_1)
			else
				table.insert(arg_7_0.scrollDataList, arg_7_1)

				if arg_7_1.SysChat == 1 then
					arg_7_1.scroll = 1
					arg_7_1.ChatType = EChatType.ESystem

					g_Self.kChatHandler:onNewChatNtf(arg_7_1)
				elseif arg_7_1.SysChat == 2 then
					arg_7_1.scroll = 1
					arg_7_1.ChatType = EChatType.ELegion

					g_Self.kChatHandler:onNewChatNtf(arg_7_1)
				end
			end
		end

		table.sort(arg_7_0.scrollDataList, var_7_0)

		if table.getn(arg_7_0.scrollDataList) >= 50 then
			local var_7_2 = 0

			for iter_7_1, iter_7_2 in pairs(arg_7_0.scrollDataList) do
				var_7_2 = var_7_2 + 1

				if var_7_2 == 50 then
					table.remove(arg_7_0.scrollDataList, iter_7_1)

					break
				end
			end
		end

		if arg_7_0.scrollState == 0 then
			arg_7_0:refreshScrollDataList()
		end
	end
end

function var_0_0.refreshScrollDataList(arg_9_0)
	if g_Self == nil or g_Self:getName() == "" then
		return
	end

	local var_9_0 = 1

	for iter_9_0 = 1, table.getn(arg_9_0.scrollDataList) do
		if arg_9_0.scrollDataList[iter_9_0] ~= nil and arg_9_0.scrollDataList[iter_9_0].Tm <= math.ceil(g_Self.kTimeHandler:getServerTime()) and (g_MainScene.wndLoading == nil or g_MainScene.wndLoading.isShow == false) then
			arg_9_0:playBroadcast(arg_9_0.scrollDataList[iter_9_0])
			table.remove(arg_9_0.scrollDataList, iter_9_0)

			var_9_0 = 0

			break
		end
	end

	if table.getn(arg_9_0.scrollDataList) > 0 and var_9_0 == 1 then
		local var_9_1 = arg_9_0.scrollDataList[1].Tm - math.ceil(g_Self.kTimeHandler:getServerTime())

		if var_9_1 <= 0 then
			if g_MainScene.wndLoading == nil or g_MainScene.wndLoading.isShow == false then
				arg_9_0:refreshScrollDataList()

				return
			else
				var_9_1 = 1
			end
		end

		local var_9_2 = CCArray:create()

		var_9_2:addObject(CCDelayTime:create(var_9_1))
		var_9_2:addObject(CCCallFuncN:create(function()
			arg_9_0:refreshScrollDataList()
		end))

		local var_9_3 = CCSequence:create(var_9_2)

		arg_9_0:stopAllActions()
		arg_9_0:runAction(var_9_3)
	end
end

function var_0_0.playBroadcast(arg_11_0, arg_11_1)
	arg_11_0.layerInfo:setVisible(true)

	local var_11_0 = 650
	local var_11_1 = arg_11_0.items[1]

	var_11_1:stopAllActions()

	local var_11_2 = arg_11_1.Content .. "[color=0xFFFFFF] [/color]"

	var_11_1:refresh(var_11_2, FONT_COLOR_WHITE)

	local var_11_3 = var_11_1.width

	if var_11_3 < var_11_0 then
		var_11_3 = var_11_0
	end

	var_11_1:setPositionX(var_11_3)

	local var_11_4 = (750 - var_11_3) * 0.5

	if var_11_4 < 50 then
		var_11_4 = 50
	end

	local var_11_5 = 5 * var_11_3 / 600
	local var_11_6 = CCMoveTo:create(0.2, ccp(var_11_4 + 100, -18))
	local var_11_7 = CCMoveTo:create(0.1, ccp(var_11_4, -18))
	local var_11_8 = CCDelayTime:create(2.5)
	local var_11_9 = CCMoveTo:create(var_11_5, ccp(-var_11_3, -18))

	arg_11_0.scrollState = 1

	local var_11_10 = CCArray:create()

	var_11_10:addObject(var_11_6)
	var_11_10:addObject(var_11_7)
	var_11_10:addObject(var_11_8)
	var_11_10:addObject(var_11_9)
	var_11_10:addObject(CCCallFuncN:create(function()
		var_11_1:setVisible(false)
		arg_11_0.layerInfo:setVisible(false)

		arg_11_0.scrollState = 0
	end))
	var_11_10:addObject(CCCallFuncN:create(function()
		arg_11_0:refreshScrollDataList()
	end))

	local var_11_11 = CCSequence:create(var_11_10)

	var_11_1:setVisible(true)
	var_11_1:stopAllActions()
	var_11_1:runAction(var_11_11)
	arg_11_0:removeFromParentAndCleanup(false)
	CCDirector:sharedDirector():getRunningScene():addChild(arg_11_0)
end

function var_0_0.confirmCreateView(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.items) do
		iter_14_1:removeFromParentAndCleanup(false)
	end

	if arg_14_0.tableView ~= nil then
		arg_14_0.tableView:removeFromParentAndCleanup(true)

		arg_14_0.tableView = nil
		arg_14_0.tableViewHelper = nil
	end

	local var_14_0 = 1
	local var_14_1 = table.getn(arg_14_0.items)
	local var_14_2 = arg_14_0.layerBroad:getContentSize()
	local var_14_3 = CCSizeMake(var_14_2.width, var_14_2.height)

	arg_14_0.tableViewHelper = zbTableViewHelper:create()
	arg_14_0.tableView = zbTableViewHelper:createTableView(var_14_2, var_14_2, 0, arg_14_0.tableViewHelper)

	arg_14_0.tableView:setPosition(0, 0)
	arg_14_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_14_0.layerBroad:addChild(arg_14_0.tableView)

	if var_14_0 - var_14_1 > 0 then
		for iter_14_2 = 1, var_14_0 - var_14_1 do
			local var_14_4 = createChatContent()

			var_14_4:retain()
			table.insert(arg_14_0.items, var_14_4)
			arg_14_0.tableViewHelper:addCell(var_14_4)
		end
	end

	arg_14_0.tableViewHelper:refreshTabelView()
	arg_14_0.tableViewHelper:setCanMove(false)
end
