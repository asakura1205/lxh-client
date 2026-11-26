require("gamelogic.zbItem")

zbWorldTaskItem = class("zbWorldTaskItem", CCNodeExtend)
zbWorldTaskItem.__index = zbWorldTaskItem
WorldTaskItem_Width = 660
WorldTaskItem_Height = 95

function zbWorldTaskItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWorldTaskItem)

	return arg_1_0
end

function zbWorldTaskItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbWorldTaskItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbWorldTaskItem.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.heroItems = {}
		arg_3_0.data = nil
		arg_3_0.maxTime = 0
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(100)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(2), "CCNode")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.7)
			var_5_4:setNodeStarVisible()

			arg_3_0.heroItems[iter_5_0] = var_5_4

			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.nodeResult = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.nodeAward = tolua.cast(arg_3_0.nodeResult:getChildByTag(1), "CCNode")
		arg_3_0.lbResult = tolua.cast(arg_3_0.nodeAward:getChildByTag(1), "CCLabelTTF")

		local var_5_5 = tolua.cast(arg_3_0.nodeAward:getChildByTag(2), "CCNode")
		local var_5_6 = createItem()

		var_5_6:setPosition(var_5_5:getPosition())
		var_5_6:setScale(0.7)

		arg_3_0.awardItem = var_5_6

		arg_3_0.nodeAward:addChild(var_5_6)
		var_5_5:removeFromParentAndCleanup(true)

		arg_3_0.lbAwardCount = tolua.cast(arg_3_0.nodeAward:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteResult = tolua.cast(arg_3_0.nodeResult:getChildByTag(4), "CCSprite")
		arg_3_0.btnResult = tolua.cast(arg_3_0.nodeResult:getChildByTag(5), "CCControlButton")

		arg_3_0.btnResult:addHandleOfControlEvent(function()
			arg_3_0:onResult()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeProgress = tolua.cast(var_5_1:getChildByTag(4), "CCNode")
		arg_3_0.spriteProgressBg = tolua.cast(arg_3_0.nodeProgress:getChildByTag(1), "CCSprite")
		arg_3_0.spriteProgress = var_5_0(arg_3_0.spriteProgressBg, "image/common/progress147x25.png")
		arg_3_0.lbPercent = tolua.cast(arg_3_0.nodeProgress:getChildByTag(2), "CCLabelTTF")

		local var_5_7 = tolua.cast(arg_3_0.nodeProgress:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.lbSuccessRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbSuccessRep)
		arg_3_0.lbSuccessRep:setScale(0.6)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_1:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function zbWorldTaskItem.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.data = arg_8_2

	arg_8_0:setVisible(arg_8_2 ~= nil)

	if arg_8_2 then
		arg_8_0.nodeId = arg_8_1

		for iter_8_0 = 1, 3 do
			arg_8_0.heroItems[iter_8_0]:setVisible(false)
		end

		local var_8_0 = 1

		for iter_8_1, iter_8_2 in pairs(arg_8_2.HeroList) do
			local var_8_1 = g_Self.kHeroHandler:getHeroByTemplateId(iter_8_2)

			arg_8_0.heroItems[var_8_0]:refreshHero(var_8_1.HeroBaseInfo)
			arg_8_0.heroItems[var_8_0]:setVisible(true)

			var_8_0 = var_8_0 + 1
		end

		local var_8_2 = math.max(arg_8_2.EndTm - g_Self.kTimeHandler:getServerTime(), 0)

		arg_8_0.maxTime = var_8_2

		if var_8_2 <= 0 then
			arg_8_0:onTaskEnd()
		else
			arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/world/task/world_task_cell1.png"))
			arg_8_0.nodeProgress:setVisible(true)
			arg_8_0.nodeResult:setVisible(false)
			arg_8_0.lbSuccessRep:setString(arg_8_2.Rate .. ";")

			local var_8_3 = zbUtil:SprintfHHMMSSNo24(var_8_2)

			arg_8_0.lbPercent:setString(var_8_3)

			local var_8_4 = arg_8_0.maxTime - var_8_2
			local var_8_5 = math.max(var_8_4, 0)
			local var_8_6 = math.min(math.ceil(100 * (var_8_5 / arg_8_0.maxTime)), 100)

			arg_8_0.spriteProgress:setPercentage(var_8_6)
		end
	end
end

function zbWorldTaskItem.onTaskEnd(arg_9_0)
	arg_9_0.nodeProgress:setVisible(false)
	arg_9_0.nodeResult:setVisible(true)

	if arg_9_0.data.Result == 1 then
		local var_9_0 = arg_9_0.data.AwardList[1]

		arg_9_0.awardItem:refreshAward(var_9_0.Type, var_9_0.Id, var_9_0.Count, false)
		arg_9_0.lbAwardCount:setString("x" .. var_9_0.Count)
		arg_9_0.lbResult:setString(a2u("\xCAջ\xF1:"))
		arg_9_0.spriteResult:setTexture(CCTextureCache:sharedTextureCache():addImage("image/world/task/world_task_finish.png"))

		local var_9_1 = "image/world/task/world_task_award.png"

		require("gamebase.zbUI"):setButtonPic(arg_9_0.btnResult, var_9_1, var_9_1, var_9_1)
		arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/world/task/world_task_cell2.png"))
	else
		arg_9_0.spriteResult:setTexture(CCTextureCache:sharedTextureCache():addImage("image/world/task/world_task_false.png"))

		local var_9_2 = "image/world/task/world_task_confirm.png"

		require("gamebase.zbUI"):setButtonPic(arg_9_0.btnResult, var_9_2, var_9_2, var_9_2)
		arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/world/task/world_task_cell3.png"))
		arg_9_0.lbResult:setString(a2u("\xB4\xEDʧ:"))

		local var_9_3 = arg_9_0.data.AwardList[1]

		arg_9_0.awardItem:refreshAward(var_9_3.Type, var_9_3.Id, var_9_3.Count, false)
		arg_9_0.lbAwardCount:setString("x" .. var_9_3.Count)
	end
end

function zbWorldTaskItem.update(arg_10_0)
	if arg_10_0.data then
		if g_GameStateMachine:isOneSecondPassed() == false then
			return
		end

		local var_10_0 = math.max(arg_10_0.data.EndTm - g_Self.kTimeHandler:getServerTime(), 0)

		if var_10_0 > 0 then
			local var_10_1 = zbUtil:SprintfHHMMSSNo24(var_10_0)

			arg_10_0.lbPercent:setString(var_10_1)

			local var_10_2 = arg_10_0.maxTime - var_10_0
			local var_10_3 = math.max(var_10_2, 0)
			local var_10_4 = math.min(math.ceil(100 * (var_10_3 / arg_10_0.maxTime)), 100)

			arg_10_0.spriteProgress:setPercentage(var_10_4)
		else
			arg_10_0:onTaskEnd()
		end
	end
end

function zbWorldTaskItem.onResult(arg_11_0)
	if arg_11_0.data then
		g_WsMsgHandler:WS_WorldTask_Gain_Req(arg_11_0.nodeId, arg_11_0.data.Index)
	end
end
