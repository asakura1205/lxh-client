require("gamelogic.zbTimeLabel")

zbActivityWnd_LuckCat = class("zbActivityWnd_LuckCat")
zbActivityWnd_LuckCat.__index = zbActivityWnd_LuckCat

local var_0_0 = 10

function zbActivityWnd_LuckCat.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_LuckCat)

	return arg_1_0
end

function zbActivityWnd_LuckCat.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbActivityWnd_LuckCat.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbActivityWnd_LuckCat.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	(function()
		arg_3_0.initNum = {
			6,
			6,
			6,
			6,
			6
		}
		arg_3_0.num = {
			arg_3_0:calHeight(arg_3_0.initNum[1]),
			arg_3_0:calHeight(arg_3_0.initNum[2]),
			arg_3_0:calHeight(arg_3_0.initNum[3]),
			arg_3_0:calHeight(arg_3_0.initNum[4]),
			arg_3_0:calHeight(arg_3_0.initNum[5])
		}
		arg_3_0.spriteItem = {}
		arg_3_0.ScrollView = {}
		arg_3_0.luckCat = {}
		arg_3_0.playerNode = {}
		arg_3_0.playerName = {}
		arg_3_0.playerMoney = {}
		arg_3_0.playerNum = 0
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
		arg_3_0.parentWnd = arg_3_3
	end)()
	arg_3_0.parentWnd:registerEvent(arg_3_0.nodeParent, function()
		arg_3_0:calNum()
	end, zbGameEvent.Event_LuckyDiamond_Ack)
	arg_3_0.parentWnd:registerEvent(arg_3_0.nodeParent, function()
		arg_3_0:freshPlayer()
	end, zbGameEvent.Event_LuckyRecord_Ack)
end

local var_0_1 = false

function zbActivityWnd_LuckCat.refresh(arg_7_0)
	(function()
		if arg_7_0.node ~= nil then
			return
		end

		local var_8_0 = CCBProxy:create()
		local var_8_1 = CCBReaderLoad("ccbi/activity_luckcat.ccbi", var_8_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_8_2 = tolua.cast(var_8_1:getChildByTag(1), "CCNode")

		arg_7_0.nodeParent:addChild(var_8_1)

		for iter_8_0 = 1, 5 do
			local var_8_3 = zbTableViewHelper:create()

			var_8_3:loadCCBFile("ccbi/tb_item.ccbi")

			local var_8_4 = tolua.cast(var_8_2:getChildByTag(iter_8_0 + 10), "CCNode")

			var_8_4:setVisible(true)

			arg_7_0.luckCat[iter_8_0] = tolua.cast(var_8_4:getChildByTag(1), "CCLayerColor")

			arg_7_0.luckCat[iter_8_0]:removeFromParentAndCleanup(false)

			local var_8_5 = tolua.cast(var_8_4:getChildByTag(2), "CCLayerColor")

			var_8_5:setVisible(false)

			arg_7_0.ScrollView[iter_8_0] = CCScrollView:create(var_8_5:getContentSize())

			arg_7_0.ScrollView[iter_8_0]:setDirection(kCCScrollViewDirectionVertical)
			arg_7_0.ScrollView[iter_8_0]:setPosition(var_8_5:getPosition())
			arg_7_0.ScrollView[iter_8_0]:setAnchorPoint(ccp(0, 0))
			arg_7_0.ScrollView[iter_8_0]:setBounceable(false)
			arg_7_0.ScrollView[iter_8_0]:setContainer(arg_7_0.luckCat[iter_8_0])
			arg_7_0.ScrollView[iter_8_0]:setTouchEnabled(false)
			var_8_4:addChild(arg_7_0.ScrollView[iter_8_0])
			var_8_3:releaseSelf()
		end

		local var_8_6 = tolua.cast(var_8_2:getChildByTag(33), "CCNode")

		arg_7_0.lbFinish = tolua.cast(var_8_6:getChildByTag(1), "CCLabelTTF")
		arg_7_0.btnGet = tolua.cast(var_8_6:getChildByTag(2), "CCControlButton")

		arg_7_0.btnGet:addHandleOfControlEvent(function()
			arg_7_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_7_0.btnGet:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())

		arg_7_0.nodeNeed = tolua.cast(var_8_6:getChildByTag(3), "CCNode")
		arg_7_0.lbNeedMoney = tolua.cast(arg_7_0.nodeNeed:getChildByTag(2), "CCLabelTTF")
		arg_7_0.lbNeedVIP = tolua.cast(arg_7_0.nodeNeed:getChildByTag(1), "CCLabelTTF")

		for iter_8_1 = 1, 2 do
			arg_7_0.playerNode[iter_8_1] = tolua.cast(var_8_2:getChildByTag(iter_8_1), "CCNode")
			arg_7_0.playerName[iter_8_1] = tolua.cast(arg_7_0.playerNode[iter_8_1]:getChildByTag(2), "CCLabelTTF")

			local var_8_7 = tolua.cast(arg_7_0.playerNode[iter_8_1]:getChildByTag(1004), "CCLabelTTF")

			arg_7_0.playerMoney[iter_8_1] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_8_7, arg_7_0.playerMoney[iter_8_1])
			arg_7_0.playerMoney[iter_8_1]:setScale(0.55)
			arg_7_0.playerNode[iter_8_1]:setVisible(false)
		end

		local var_8_8 = tolua.cast(var_8_2:getChildByTag(4), "CCNode")
		local var_8_9 = tolua.cast(var_8_8:getChildByTag(1004), "CCLabelTTF")

		arg_7_0.lbMaxMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_8_9, arg_7_0.lbMaxMoney)
		arg_7_0.lbMaxMoney:setScale(0.8)

		arg_7_0.node = var_8_1
	end)()

	for iter_7_0 = 1, 5 do
		if arg_7_0.initNum[iter_7_0] == 0 then
			arg_7_0.initNum[iter_7_0] = var_0_0
		end

		arg_7_0.num[iter_7_0] = arg_7_0:calHeight(arg_7_0.initNum[iter_7_0])

		arg_7_0.ScrollView[iter_7_0]:setContentOffset(ccp(0, arg_7_0.num[iter_7_0] - 1))
	end

	arg_7_0:refreshDetail()
end

function zbActivityWnd_LuckCat.refreshDetail(arg_10_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.LuckyDiamond) == false then
		return
	end

	arg_10_0.LuckyDiamond = g_GameData.ActivityAct.LuckyDiamond

	if arg_10_0.LuckyDiamond.Diamond == 0 then
		arg_10_0.lbFinish:setVisible(true)
		arg_10_0.btnGet:setVisible(false)
		arg_10_0.nodeNeed:setVisible(false)
		arg_10_0.lbMaxMoney:setString("-")
	else
		arg_10_0.lbFinish:setVisible(false)
		arg_10_0.btnGet:setVisible(true)
		arg_10_0.nodeNeed:setVisible(true)
		arg_10_0.lbNeedMoney:setString(arg_10_0.LuckyDiamond.Diamond)
		arg_10_0.lbNeedVIP:setString(a2u("(\xD0\xE8ҪVIP") .. arg_10_0.LuckyDiamond.NeedVip .. ")")
		arg_10_0.lbNeedVIP:setVisible(arg_10_0.LuckyDiamond.NeedVip > g_Self:getVipLevel())
		arg_10_0.lbMaxMoney:setString(arg_10_0.LuckyDiamond.MaxIncome)
	end

	arg_10_0:freshPlayer()
end

local var_0_2 = {
	0,
	0,
	0,
	0,
	0
}
local var_0_3 = {
	-(90 * (var_0_0 + 2) - 48),
	-(90 * (var_0_0 + 2) - 48),
	-(90 * (var_0_0 + 2) - 48),
	-(90 * (var_0_0 + 2) - 48),
	-(90 * (var_0_0 + 2) - 48)
}
local var_0_4 = {
	0,
	0,
	0,
	0,
	0
}

function zbActivityWnd_LuckCat.calNum(arg_11_0)
	local var_11_0 = {}

	var_11_0[1] = 1
	var_11_0[2] = 2
	var_11_0[3] = 3
	var_11_0[4] = 4
	var_11_0[5] = 5

	for iter_11_0 = 5, 1, -1 do
		arg_11_0.initNum[iter_11_0] = math.fmod(g_Self.kActivityHandler.HitDiamond, 10)
		var_0_3[iter_11_0] = arg_11_0.num[iter_11_0]
		g_Self.kActivityHandler.HitDiamond = math.modf(g_Self.kActivityHandler.HitDiamond / 10)

		if arg_11_0.initNum[iter_11_0] == 0 then
			arg_11_0.initNum[iter_11_0] = var_0_0
		end

		arg_11_0.num[iter_11_0] = arg_11_0:calHeight(arg_11_0.initNum[iter_11_0])
		var_0_2[iter_11_0] = 0
		var_0_4[iter_11_0] = 0
	end

	var_0_1 = true

	arg_11_0.btnGet:setEnabled(false)

	g_GameData.Wealth.Diamond = g_GameData.Wealth.Diamond - arg_11_0.LuckyDiamond.Diamond

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Wealth)
end

function zbActivityWnd_LuckCat.onFrame(arg_12_0, arg_12_1)
	if var_0_1 == false then
		return
	end

	for iter_12_0 = 1, 5 do
		if var_0_4[iter_12_0] == 0 then
			if var_0_2[iter_12_0] < 8 - iter_12_0 then
				var_0_3[iter_12_0] = var_0_3[iter_12_0] + 36 * (arg_12_1 * 30) - iter_12_0
			else
				var_0_3[iter_12_0] = var_0_3[iter_12_0] + iter_12_0 + 7
			end

			if var_0_3[iter_12_0] >= -135 then
				var_0_2[iter_12_0] = var_0_2[iter_12_0] + 1
				var_0_3[iter_12_0] = -(90 * (var_0_0 + 2) - 48)
			end
		end

		if var_0_2[iter_12_0] >= 5 - iter_12_0 and var_0_3[iter_12_0] >= arg_12_0.num[iter_12_0] then
			var_0_4[iter_12_0] = 1

			arg_12_0.ScrollView[iter_12_0]:setContentOffset(ccp(0, arg_12_0.num[iter_12_0] - 1))
		else
			arg_12_0.ScrollView[iter_12_0]:setContentOffset(ccp(0, var_0_3[iter_12_0] - 1))
		end
	end

	for iter_12_1 = 1, 5 do
		if var_0_4[iter_12_1] == 0 then
			return
		end
	end

	var_0_1 = false

	arg_12_0:refresh()
	arg_12_0.btnGet:setEnabled(true)

	if g_Self.kActivityHandler.luckData ~= nil then
		g_Self.kDataChange:update(g_Self.kActivityHandler.luckData)

		g_Self.kActivityHandler.luckData = nil
	end
end

function zbActivityWnd_LuckCat.onGet(arg_13_0)
	if zbUtil:isValidTable(arg_13_0.LuckyDiamond) == false then
		return
	end

	if g_Self:getVipLevel() < arg_13_0.LuckyDiamond.NeedVip then
		g_Bubble:bubbleInfo(a2u("VIP\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_13_0.LuckyDiamond.Diamond) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	if arg_13_0.LuckyDiamond.Diamond == 0 then
		g_Bubble:bubbleInfo(a2u("\xBB\xD2Ѿ\xADȫ\xB2\xBF\xCD\xEA\xB3\xC9"))

		return
	end

	g_WsMsgHandler:WS_ActivityAct_LuckyDiamond_Req()
end

function zbActivityWnd_LuckCat.calHeight(arg_14_0, arg_14_1)
	return -90 * (var_0_0 + 3) + 90 * (arg_14_1 + 1)
end

function zbActivityWnd_LuckCat.freshPlayer(arg_15_0)
	if zbUtil:isValidTable(g_Self.kActivityHandler.RecordList) == false or table.getn(g_Self.kActivityHandler.RecordList) <= 0 then
		return
	end

	local function var_15_0()
		for iter_16_0 = 1, 2 do
			arg_15_0.playerNum = arg_15_0.playerNum + 1

			if arg_15_0.playerNum > table.getn(g_Self.kActivityHandler.RecordList) then
				arg_15_0.playerNum = 1
			end

			local var_16_0 = g_Self.kActivityHandler.RecordList[arg_15_0.playerNum]

			arg_15_0.playerName[iter_16_0]:setString(a2u(var_16_0.RoleName))
			arg_15_0.playerMoney[iter_16_0]:setString(var_16_0.Diamond)
			arg_15_0.playerNode[iter_16_0]:setVisible(true)
		end
	end

	local var_15_1 = CCArray:create()

	var_15_1:addObject(CCCallFuncN:create(var_15_0))
	var_15_1:addObject(CCDelayTime:create(2))

	local var_15_2 = CCSequence:create(var_15_1)

	arg_15_0.node:stopAllActions()
	arg_15_0.node:runAction(CCRepeatForever:create(var_15_2))
end
