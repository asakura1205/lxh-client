require("gamelogic.zbTabWnd")
require("gamelogic.zbLegionHelp")
require("gamelogic.zbLegionMemberList")
require("gamelogic.zbLegionLogList")
require("gamelogic.zbLegionShenHeList")

local var_0_0 = class("zbLegionMemberWnd", zbTabWnd)

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

function createLegionMemWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_have_join.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = {
			[ELegionTab.LegionInfo] = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton"),
			[ELegionTab.LegionShenHe] = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton"),
			[ELegionTab.LegionLog] = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		}
		local var_5_4 = {
			[ELegionTab.LegionInfo] = tolua.cast(var_5_2:getChildByTag(10), "CCNode"),
			[ELegionTab.LegionShenHe] = tolua.cast(var_5_2:getChildByTag(11), "CCNode"),
			[ELegionTab.LegionLog] = tolua.cast(var_5_2:getChildByTag(12), "CCNode")
		}
		local var_5_5 = {
			[ELegionTab.LegionInfo] = "image/tab/tab_legion_legionInfo.png",
			[ELegionTab.LegionShenHe] = "image/tab/tab_legion_legionShenHe.png",
			[ELegionTab.LegionLog] = "image/tab/tab_legion_legionLog.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ELegionTab.LegionInfo] = createLegionMemPanel(var_5_4[ELegionTab.LegionInfo])
		arg_3_0.module[ELegionTab.LegionShenHe] = createLegionShenHePanel(var_5_4[ELegionTab.LegionShenHe])
		arg_3_0.module[ELegionTab.LegionLog] = createLegionLogPanel(var_5_4[ELegionTab.LegionLog])

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
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshMemberInfo()
	end, zbGameEvent.Event_LegionMemberDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshLog()
	end, zbGameEvent.Event_LegionLogAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshApplyList()
	end, zbGameEvent.Event_LegionApplyListAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRefreshApplyInfo()
	end, zbGameEvent.Event_LegionLimitSetAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.refresh(arg_12_0)
	arg_12_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_13_0)
	if arg_13_0.module[arg_13_0.currTab] then
		arg_13_0.module[arg_13_0.currTab]:refresh()
	end

	for iter_13_0 = 1, table.getn(arg_13_0.tabButtons) do
		if arg_13_0.tabButtons[iter_13_0] then
			if iter_13_0 == arg_13_0.currTab then
				arg_13_0.tabButtons[iter_13_0]:setZOrder(ZORDER_TOP)
			else
				arg_13_0.tabButtons[iter_13_0]:setZOrder(ZORDER_BOTTOM)
			end
		end
	end
end

function var_0_0.onRefreshMemberInfo(arg_14_0)
	if arg_14_0.module[ELegionTab.LegionInfo] then
		arg_14_0.module[ELegionTab.LegionInfo]:refreshReslut()
	end
end

function var_0_0.onRefreshLog(arg_15_0)
	if arg_15_0.module[ELegionTab.LegionLog] then
		arg_15_0.module[ELegionTab.LegionLog]:refreshReslut()
	end
end

function var_0_0.onRefreshApplyList(arg_16_0)
	if arg_16_0.module[ELegionTab.LegionShenHe] then
		arg_16_0.module[ELegionTab.LegionShenHe]:refreshReslut()
	end
end

function var_0_0.onRefreshApplyInfo(arg_17_0)
	if g_MainScene.wndLegionLimitSet then
		g_MainScene.wndLegionLimitSet:hide()
	end

	if arg_17_0.module[ELegionTab.LegionShenHe] then
		arg_17_0.module[ELegionTab.LegionShenHe]:refreshSetInfo()
	end
end
