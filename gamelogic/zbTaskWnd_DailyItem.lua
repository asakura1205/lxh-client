require("gamelogic.zbItem")

local var_0_0 = class("zbTaskWnd_DailyItem")

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

function createTaskDailyItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.dailyDetail = nil
		arg_3_0.record = nil
		arg_3_0.awardItem = nil
		arg_3_0.parentWnd = arg_3_1
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_task.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_1
		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteHeadIcon = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_1:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_1:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.btnGetAward = tolua.cast(var_5_1:getChildByTag(5), "CCControlButton")
		arg_3_0.btnGoto = tolua.cast(var_5_1:getChildByTag(6), "CCControlButton")
		arg_3_0.lbTimesDummy = tolua.cast(var_5_1:getChildByTag(1007), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(11), "CCLayerColor")
		local var_5_3 = createItem()

		var_5_3:setPosition(var_5_2:getPosition())
		var_5_3:setScale(0.35)
		var_5_3:setNeedTip(false)
		var_5_1:addChild(var_5_3)

		arg_3_0.awardItem = var_5_3

		var_5_2:removeFromParentAndCleanup(true)

		local var_5_4 = tolua.cast(var_5_1:getChildByTag(1014), "CCLabelTTF")

		arg_3_0.lbActive = tolua.cast(var_5_1:getChildByTag(1015), "CCLabelTTF")
		arg_3_0.lbAward = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbAward)
		arg_3_0.lbAward:setScale(0.4)

		arg_3_0.lbTimes = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbTimesDummy, arg_3_0.lbTimes)
		arg_3_0.lbTimes:setScale(0.5)
		arg_3_0.btnGoto:addHandleOfControlEvent(function()
			arg_3_0:onGotoDaily()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGoto:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGoto:setSwallowsTouches(false)
		arg_3_0.btnGetAward:addHandleOfControlEvent(function()
			arg_3_0:onGetAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGetAward:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGetAward:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_1:getContentSize())
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.dailyDetail = arg_8_1

	local var_8_0 = zbDailyTaskTable:getRecord(arg_8_1.TaskType)

	if var_8_0 == nil then
		return
	end

	arg_8_0.record = var_8_0

	local var_8_1 = zbIconHelper:getDailyIconPath(arg_8_1.TaskType)

	arg_8_0.spriteHeadIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))
	arg_8_0.lbName:setString(var_8_0.linkName)
	arg_8_0.lbDesc:setString(var_8_0.description)
	arg_8_0.lbActive:setString(a2u("\xBB\xEEԾ\xB6\xC8:") .. var_8_0.active)

	if arg_8_1.AwardList[1] then
		arg_8_0.awardItem:refreshAward(arg_8_1.AwardList[1].Type, arg_8_1.AwardList[1].Id, arg_8_1.AwardList[1].Count, false, false)
		arg_8_0.lbAward:setString(arg_8_1.AwardList[1].Count)
	end

	if arg_8_1.State == 1 then
		arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/task/task_itembg1.png"))
		arg_8_0.lbTimes:setVisible(false)
		arg_8_0.btnGoto:setVisible(false)
		arg_8_0.btnGetAward:setVisible(true)
	else
		arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/task/task_itembg2.png"))
		arg_8_0.lbTimes:setVisible(true)
		arg_8_0.lbTimes:setString(arg_8_1.CompleteCount .. "/" .. arg_8_1.NeedCount)
		arg_8_0.btnGoto:setVisible(true)
		arg_8_0.btnGetAward:setVisible(false)
		arg_8_0.layerContent:setGray(arg_8_1.CompleteCount >= arg_8_1.NeedCount)
	end
end

function var_0_0.onGetAward(arg_9_0)
	if arg_9_0.dailyDetail.State == 1 then
		g_WsMsgHandler:WS_DailyTask_Complete_Req(arg_9_0.dailyDetail.TaskType)
	end
end

function var_0_0.onGotoDaily(arg_10_0)
	if arg_10_0.record.type ~= EDailyTaskType.ExchangeGold and arg_10_0.record.type ~= EDailyTaskType.ExchangeFood then
		arg_10_0.parentWnd:hide()
	end

	zbLinkHelper:execLink(arg_10_0.record.linkUrl)
end
