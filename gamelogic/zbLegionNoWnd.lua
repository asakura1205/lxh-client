require("gamelogic.zbTabWnd")
require("gamelogic.zbLegionHelp")
require("gamelogic.zbLegionNo_Search")
require("gamelogic.zbLegionNo_Join")
require("gamelogic.zbLegionNo_Create")

local var_0_0 = class("zbLegionNoWnd", zbTabWnd)

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

function createLegionNoWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.ItemId = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_have_nojoin.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = {
			[ELegionTabNo.LegionJoin] = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton"),
			[ELegionTabNo.LegionCreate] = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton"),
			[ELegionTabNo.LegionSearch] = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		}
		local var_5_4 = {
			[ELegionTabNo.LegionJoin] = tolua.cast(var_5_2:getChildByTag(10), "CCNode"),
			[ELegionTabNo.LegionCreate] = tolua.cast(var_5_2:getChildByTag(11), "CCNode"),
			[ELegionTabNo.LegionSearch] = tolua.cast(var_5_2:getChildByTag(12), "CCNode")
		}
		local var_5_5 = {
			[ELegionTabNo.LegionJoin] = "image/tab/tab_legionNo_legionJoin.png",
			[ELegionTabNo.LegionCreate] = "image/tab/tab_legionNo_legionCreate.png",
			[ELegionTabNo.LegionSearch] = "image/tab/tab_legionNo_legionSearch.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ELegionTabNo.LegionCreate] = createLegionNoCreatePanel(var_5_4[ELegionTabNo.LegionCreate])
		arg_3_0.module[ELegionTabNo.LegionSearch] = createLegionSearchPanel(var_5_4[ELegionTabNo.LegionSearch])
		arg_3_0.module[ELegionTabNo.LegionJoin] = createLegionJoinPanel(var_5_4[ELegionTabNo.LegionJoin])

		arg_3_0:initTab(var_5_3, var_5_4, var_5_5)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshLegionList()
	end, zbGameEvent.Event_UpdateLegionListAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onSearchLegionList()
	end, zbGameEvent.Event_LegionSearchAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onLegionIconSelBack()
	end, zbGameEvent.Event_LegionIconSelBack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.doDestroy(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.module) do
		iter_12_1:free()
	end
end

function var_0_0.onFrameUpdate(arg_13_0, arg_13_1)
	if arg_13_0.isShow == false then
		return
	end

	if arg_13_0.module[ELegionTabNo.LegionJoin] then
		arg_13_0.module[ELegionTabNo.LegionJoin]:onFrame()
	end
end

function var_0_0.onShowCallback(arg_14_0)
	g_Self.kLegionHandler.curPage = 1

	g_WsMsgHandler:WS_Legion_PageList_Req(g_Self.kLegionHandler.curPage)
	arg_14_0:selectTab(ELegionTabNo.LegionJoin)
end

function var_0_0.refresh(arg_15_0)
	return
end

function var_0_0.doSelectTab(arg_16_0)
	if arg_16_0.module[arg_16_0.currTab] then
		arg_16_0.module[arg_16_0.currTab]:refresh()
	end

	for iter_16_0 = 1, table.getn(arg_16_0.tabButtons) do
		if arg_16_0.tabButtons[iter_16_0] then
			if iter_16_0 == arg_16_0.currTab then
				arg_16_0.tabButtons[iter_16_0]:setZOrder(ZORDER_TOP)
			else
				arg_16_0.tabButtons[iter_16_0]:setZOrder(ZORDER_BOTTOM)
			end
		end
	end
end

function var_0_0.onRefreshLegionList(arg_17_0)
	if arg_17_0.module[ELegionTabNo.LegionJoin] then
		arg_17_0.module[ELegionTabNo.LegionJoin]:refresh()
	end
end

function var_0_0.onSearchLegionList(arg_18_0)
	if arg_18_0.module[ELegionTabNo.LegionSearch] then
		arg_18_0.module[ELegionTabNo.LegionSearch]:refreshList()
	end
end

function var_0_0.onLegionIconSelBack(arg_19_0)
	if arg_19_0.module[ELegionTabNo.LegionCreate] then
		arg_19_0.module[ELegionTabNo.LegionCreate]:onIconSetEnd()
	end
end
