require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbArenaRuleWnd", zbBaseWnd)

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

function createRuleArenaWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardNode = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rule_arena.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.sv = tolua.cast(var_5_2:getChildByTag(2), "CCScrollView")
		arg_3_0.detailLayer = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.lbl1 = tolua.cast(arg_3_0.detailLayer:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbMoney1 = tolua.cast(arg_3_0.detailLayer:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbMoney2 = tolua.cast(arg_3_0.detailLayer:getChildByTag(3), "CCLabelTTF")

		local var_5_3 = tolua.cast(arg_3_0.detailLayer:getChildByTag(4), "CCLabelTTF")

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.6)

		for iter_5_0 = 1, 5 do
			arg_3_0.awardNode[iter_5_0] = tolua.cast(arg_3_0.detailLayer:getChildByTag(iter_5_0 * 100), "CCNode")
		end

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:setSoundTag(SOUNDTAG_NOSOUND)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0.detailLayer:removeFromParentAndCleanup(false)
		arg_3_0.sv:setContainer(arg_3_0.detailLayer)
		arg_3_0.sv:setContentOffset(ccp(0, 380 - arg_3_0.detailLayer:getContentSize().height))
		arg_3_0.sv:setBounceable(false)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = g_Self.kArenaHandler.ArenaBaseInfo

	if var_8_0 ~= nil then
		local var_8_1 = zbArenaDailyAwardTable:getRecord(var_8_0.Rank)

		if var_8_1 then
			arg_8_0.lbMoney1:setString(var_8_1.diamond)
			arg_8_0.lbMoney2:setString(var_8_1.rankMoney)
		else
			arg_8_0.lbMoney1:setString("0")
			arg_8_0.lbMoney2:setString("0")
		end
	end

	local var_8_2 = a2u("\xC4\xFA\xB5Ķ\xB7˧\xB9\xAC\xC5\xC5\xC3\xFB\xCA\xC7") .. var_8_0.Rank .. a2u("\xC3\xFB,\xC4\xE3\xB5Ķ\xB7˧\xB9\xAC\xC5\xC5\xC3\xFBԽ\xB8ߣ\xAC\xBB\xF1\xB5ý\xB1\xC0\xF8Խ\xB6࣬\xB5\xB1ǰ\xB5\xC4\xC5\xC5\xC3\xFB\xA3\xAC\xBF\xC9\xC1\xECȡ\xBD\xB1\xC0\xF8Ϊ\xA3\xBA")

	arg_8_0.lbl1:setString(var_8_2)
	arg_8_0.lbRank:setString(var_8_0.BestRank)

	for iter_8_0 = 1, 5 do
		local var_8_3 = zbArenaDailyAwardTable:getRecord(iter_8_0)
		local var_8_4 = tolua.cast(arg_8_0.awardNode[iter_8_0]:getChildByTag(1), "CCLabelTTF")
		local var_8_5 = tolua.cast(arg_8_0.awardNode[iter_8_0]:getChildByTag(2), "CCLabelTTF")

		if var_8_3 then
			var_8_4:setString(var_8_3.diamond)
			var_8_5:setString(var_8_3.rankMoney)
		end
	end
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.layerTouchTest, var_9_0.x, var_9_0.y) == false and zbUtil:PointInCtrl(arg_9_0.btnClose, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
