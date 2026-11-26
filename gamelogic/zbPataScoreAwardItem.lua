require("gamelogic.zbItem")

zbPataScoreAwardItem = class("zbPataScoreAwardItem", CCNodeExtend)
zbPataScoreAwardItem.__index = zbPataScoreAwardItem

function zbPataScoreAwardItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbPataScoreAwardItem)

	return arg_1_0
end

function zbPataScoreAwardItem.create(arg_2_0)
	local var_2_0 = zbPataScoreAwardItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbPataScoreAwardItem.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
		arg_3_0.data = nil
		arg_3_0.state = 0
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_scoreaward.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_1
		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.state_can = tolua.cast(var_5_1:getChildByTag(3), "CCSprite")
		arg_3_0.state_limit = tolua.cast(var_5_1:getChildByTag(4), "CCSprite")
		arg_3_0.state_did = tolua.cast(var_5_1:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbScore = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbScore)
		arg_3_0.lbScore:setScale(0.55)

		arg_3_0.awardNode = tolua.cast(var_5_1:getChildByTag(6), "CCNode")

		for iter_5_0 = 1, 4 do
			local var_5_3 = tolua.cast(arg_3_0.awardNode:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.7)
			var_5_4:setSwallowsTouches(false)
			arg_3_0.awardNode:addChild(var_5_4)

			arg_3_0.awardItems[iter_5_0] = var_5_4

			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(7), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:getAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbPataScoreAwardItem.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		arg_7_0.data = arg_7_1

		arg_7_0.lbScore:setString(arg_7_1.score)

		local var_7_0 = "image/frame/scoreframe/scoreframe" .. arg_7_2 .. ".png"

		arg_7_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))

		for iter_7_0 = 1, 4 do
			arg_7_0.awardItems[iter_7_0]:setVisible(false)
		end

		local var_7_1 = 1

		for iter_7_1, iter_7_2 in pairs(arg_7_1.awardList) do
			local var_7_2 = arg_7_0.awardItems[var_7_1]

			if var_7_2 then
				var_7_2:refreshAward(iter_7_2.awardType, iter_7_2.awardId, iter_7_2.awardNum, false)
				var_7_2:setVisible(true)

				var_7_1 = var_7_1 + 1
			end
		end

		arg_7_0.state = arg_7_0:getState(g_GameData.PataInfo)

		arg_7_0.state_can:setVisible(arg_7_0.state == 1)
		arg_7_0.state_did:setVisible(arg_7_0.state == 2)
		arg_7_0.state_limit:setVisible(arg_7_0.state == 3)
		arg_7_0.layer:setGray(arg_7_0.state == 2)
		arg_7_0:setVisible(true)
	else
		arg_7_0:setVisible(false)
	end
end

function zbPataScoreAwardItem.getState(arg_8_0, arg_8_1)
	if arg_8_1.ScoreAwardInfo == nil or arg_8_0.data == nil then
		return 3
	end

	if type(arg_8_1.ScoreAwardInfo.IndexList) == "table" then
		for iter_8_0, iter_8_1 in pairs(arg_8_1.ScoreAwardInfo.IndexList) do
			if iter_8_1.Score == arg_8_0.data.score then
				return 2
			end
		end
	end

	if arg_8_0.data.score <= arg_8_1.BaseInfo.TotalScore then
		return 1
	else
		return 3
	end
end

function zbPataScoreAwardItem.getAward(arg_9_0)
	if arg_9_0.state == 3 then
		return
	elseif arg_9_0.state == 2 then
		return
	end

	g_WsMsgHandler:WS_Pata_GetScoreAward_Req(arg_9_0.data.score)
end
