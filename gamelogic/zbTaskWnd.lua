require("gamelogic.zbTabWnd")
require("gamelogic.zbTaskWnd_Daily")
require("gamelogic.zbTaskWnd_Success")

local var_0_0 = class("zbTaskWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createTaskWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		arg_3_0.firstOpenItem = {}
		arg_3_0.firstOpenItem[ETaskType.Success] = true
		arg_3_0.firstOpenItem[ETaskType.Daily] = true
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 25, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/task.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		local var_5_5 = tolua.cast(var_5_2:getChildByTag(102), "CCSprite")

		arg_3_0.spriteTitle = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.node = var_5_2
		arg_3_0.layer = var_5_3
		arg_3_0.layerTab = var_5_4

		local var_5_6 = {
			[ETaskType.Success] = tolua.cast(var_5_4:getChildByTag(2), "CCControlButton"),
			[ETaskType.Daily] = tolua.cast(var_5_4:getChildByTag(1), "CCControlButton")
		}

		arg_3_0.tabButtons = var_5_6
		arg_3_0.notifySuccess = var_5_0(var_5_6[ETaskType.Success])
		arg_3_0.notifyDaily = var_5_0(var_5_6[ETaskType.Daily])

		local var_5_7 = {
			[ETaskType.Success] = "image/tab/tab_task_success.png",
			[ETaskType.Daily] = "image/tab/tab_task_daily.png"
		}
		local var_5_8 = {
			[ETaskType.Success] = tolua.cast(var_5_3:getChildByTag(1), "CCLayer"),
			[ETaskType.Daily] = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		}

		arg_3_0.module = {}
		arg_3_0.module[ETaskType.Success] = createTaskSuccess(var_5_8[ETaskType.Success], var_5_6[ETaskType.Success], arg_3_0)
		arg_3_0.module[ETaskType.Daily] = createTaskDaily(var_5_8[ETaskType.Daily], var_5_6[ETaskType.Daily], arg_3_0)

		arg_3_0:initTab(var_5_6, var_5_8, var_5_7)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Tili
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Task_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Daily_Ack)
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0:selectTab(arg_10_1)
	end
end

function var_0_0.doSelectTab(arg_11_0)
	if arg_11_0.currTab == ETaskType.Daily then
		g_WsMsgHandler:WS_DailyTask_GetData_Req()
	elseif arg_11_0.firstOpenItem[ETaskType.Success] == true then
		g_WsMsgHandler:WS_MainTask_GetData_Req()

		arg_11_0.firstOpenItem[ETaskType.Success] = false
	end

	arg_11_0.module[arg_11_0.currTab]:refresh()
end

function var_0_0.bopen(arg_12_0, arg_12_1)
	if arg_12_1 == ETaskType.Daily and zbFunHelper:isLockAndTip(EFuncType.DailyTask) then
		return false
	end

	return true
end

function var_0_0.onDataUpdateAck(arg_13_0)
	if arg_13_0.isShow and arg_13_0.module[arg_13_0.currTab] then
		arg_13_0.module[arg_13_0.currTab]:refresh()
	end

	arg_13_0:refreshNotify()
end

function var_0_0.refreshNotify(arg_14_0)
	arg_14_0.notifySuccess:setVisible(g_Self.kTaskHandler:hasFinishTask())
	arg_14_0.notifyDaily:setVisible(g_Self.kDailyHandler:hasFinishDaily())
end

function var_0_0.onFrameUpdate(arg_15_0)
	arg_15_0:updateBackEffect()

	if arg_15_0.currTab then
		arg_15_0.module[arg_15_0.currTab]:onFrame()
	end
end
