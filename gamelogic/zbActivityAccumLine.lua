require("gamelogic.zbItem")

zbActivityAccumLine = class("zbActivityAccumLine", CCNodeExtend)
zbActivityAccumLine.__index = zbActivityAccumLine

function zbActivityAccumLine.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityAccumLine)

	return arg_1_0
end

function createActivityAccumLine(arg_2_0, arg_2_1)
	local var_2_0 = zbActivityAccumLine.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function zbActivityAccumLine.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.type = arg_3_1
		arg_3_0.index = arg_3_2
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
		arg_3_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

		arg_3_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_signaccum.ccbi")

		arg_3_0.lbDaysDummy = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.spriteGeted = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.btnGet = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")
		arg_3_0.spriteDouble = tolua.cast(var_5_0:getChildByTag(7), "CCSprite")
		arg_3_0.spriteUp01 = tolua.cast(var_5_0:getChildByTag(101), "CCSprite")
		arg_3_0.lbDays = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbDaysDummy, arg_3_0.lbDays)
		arg_3_0.lbDays:setScale(0.6)

		for iter_5_0 = 1, 3 do
			local var_5_1 = tolua.cast(var_5_0:getChildByTag(iter_5_0), "CCLayer")

			var_5_1:setVisible(false)

			item = createItem()

			item:setPosition(var_5_1:getPosition())
			item:setScale(0.7)
			item:setNeedTip(true)
			item:setSupportTouchDownTip(false)
			item:setSupportTouchTip(true)
			item:setSwallowsTouches(false)
			var_5_1:removeFromParentAndCleanup(true)
			var_5_0:addChild(item)

			arg_3_0.items[iter_5_0] = item
		end

		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGet:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGet:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(602, 110))
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbActivityAccumLine.refreshAccum(arg_7_0, arg_7_1)
	arg_7_0.listData = arg_7_1

	arg_7_0.lbDays:setString(arg_7_0.index)
	arg_7_0.spriteUp01:setVisible(false)
	arg_7_0.spriteDouble:setVisible(false)

	for iter_7_0 = 1, 3 do
		if arg_7_0.items[iter_7_0] ~= nil then
			arg_7_0.items[iter_7_0]:setVisible(false)
		end
	end

	local var_7_0 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_0.listData.AwardList) do
		if arg_7_0.items[var_7_0] ~= nil then
			arg_7_0.items[var_7_0]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count, false)
			arg_7_0.items[var_7_0]:setVisible(true)
		end

		var_7_0 = var_7_0 + 1
	end
end

function zbActivityAccumLine.refreshAccumState(arg_8_0, arg_8_1)
	arg_8_0.listData = arg_8_1

	local var_8_0 = arg_8_0.listData.State

	arg_8_0.btnGet:setVisible(var_8_0 == 1)
	arg_8_0.spriteGeted:setVisible(var_8_0 ~= 1)

	local var_8_1 = ""

	if var_8_0 == 0 then
		var_8_1 = arg_8_0.spriteframeCache:spriteFrameByName("activity_wdc.png")
	else
		var_8_1 = arg_8_0.spriteframeCache:spriteFrameByName("activity_ylq.png")
	end

	if var_8_1 and var_8_1 ~= "" then
		arg_8_0.spriteGeted:initWithSpriteFrame(var_8_1)
	end
end

function zbActivityAccumLine.refreshUpgrade(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1

	arg_9_0.spriteUp01:setVisible(true)

	if arg_9_1.rank100 == 1 then
		arg_9_0.spriteDouble:setVisible(true)
	else
		arg_9_0.spriteDouble:setVisible(false)
	end

	arg_9_0.lbDays:setString(arg_9_1.level)

	for iter_9_0 = 1, 3 do
		if arg_9_0.items[iter_9_0] ~= nil then
			arg_9_0.items[iter_9_0]:setVisible(false)
		end
	end

	local var_9_0 = 1

	for iter_9_1, iter_9_2 in pairs(arg_9_0.data.AwardList) do
		if arg_9_0.items[var_9_0] ~= nil then
			arg_9_0.items[var_9_0]:refreshAward(iter_9_2.Type, iter_9_2.Id, iter_9_2.Count, false)

			if (iter_9_2.Type == ECommonAwardType.HeroFrag or iter_9_2.Type == ECommonAwardType.Hero or iter_9_2.Type == ECommonAwardType.Diamond or iter_9_2.Type == ECommonAwardType.BarMoney or iter_9_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Golden or iter_9_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_9_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Golden) and arg_9_0.scrollEffect[var_9_0] == nil then
				arg_9_0.scrollEffect[var_9_0] = g_EffectSystem:creatScrollEffect(arg_9_0.items[var_9_0], iter_9_2.Type)

				arg_9_0.scrollEffect[var_9_0]:setAnimation("animation", true)
			end

			arg_9_0.items[var_9_0]:setVisible(true)
		end

		var_9_0 = var_9_0 + 1
	end
end

function zbActivityAccumLine.refreshUpgradeState(arg_10_0, arg_10_1)
	arg_10_0.data = arg_10_1

	local var_10_0 = g_GameData.ActivityAct.CrazyUpgrade
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if arg_10_1.level == iter_10_1 then
			var_10_1 = 1

			break
		end
	end

	arg_10_0.btnGet:setVisible(var_10_1 ~= 1 and g_Self:getLevel() >= arg_10_1.level)
	arg_10_0.spriteGeted:setVisible(var_10_1 == 1 or g_Self:getLevel() < arg_10_1.level)

	local var_10_2 = ""

	if var_10_1 == 1 then
		var_10_2 = arg_10_0.spriteframeCache:spriteFrameByName("activity_ylq.png")
	else
		var_10_2 = arg_10_0.spriteframeCache:spriteFrameByName("activity_wdc.png")
	end

	if var_10_2 and var_10_2 ~= "" then
		arg_10_0.spriteGeted:initWithSpriteFrame(var_10_2)
	end
end

function zbActivityAccumLine.onGet(arg_11_0)
	if arg_11_0.type == EActivityType.SignAccum then
		g_WsMsgHandler:WS_ActivityAct_SerialLogin_Req(arg_11_0.index)
	else
		g_WsMsgHandler:WS_ActivityAct_CrazyUpgrade_Req(arg_11_0.data.level)
	end
end

function zbActivityAccumLine.refreshScorllEffect(arg_12_0)
	for iter_12_0 = 1, 3 do
		if arg_12_0.scrollEffect[iter_12_0] then
			arg_12_0.scrollEffect[iter_12_0]:setAnimation("animation", true)
		end
	end
end
