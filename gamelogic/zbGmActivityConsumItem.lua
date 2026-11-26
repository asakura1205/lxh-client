require("gamelogic.zbItem")

local var_0_0 = class("zbGmActivityConsumItem", CCNodeExtend)

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

function createGmActivityConsumItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.gmActivityType = -1
		arg_3_0.dataInfo = nil
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.lbDesc = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteGeted = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.btnGet = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")

		for iter_5_0 = 1, 3 do
			local var_5_1 = tolua.cast(var_5_0:getChildByTag(iter_5_0), "CCLayer")
			local var_5_2 = createItem()

			var_5_2:setPosition(var_5_1:getPosition())
			var_5_2:setScale(0.85)
			var_5_2:setNeedTip(true)
			var_5_2:setSupportTouchDownTip(false)
			var_5_2:setSupportTouchTip(true)
			var_5_2:setSwallowsTouches(false)
			var_5_0:addChild(var_5_2)

			arg_3_0.items[iter_5_0] = var_5_2

			var_5_1:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGet:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGet:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(700, 135))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 == nil or arg_7_2 == nil or arg_7_3 == nil then
		return
	end

	arg_7_0.gmActivityType = arg_7_1
	arg_7_0.dataInfo = arg_7_2
	arg_7_0.actId = arg_7_3

	local var_7_0 = ""

	if arg_7_1 == EGmActivityType.RechargeDaily then
		var_7_0 = a2u("\xC0ۼƵ\xDA") .. zbUtil:getNumberBig(arg_7_2.Day) .. a2u("\xCC\xEC")
	elseif arg_7_1 == EGmActivityType.RechargeDailySum or arg_7_1 == EGmActivityType.RechargeSum then
		var_7_0 = a2u("\xC0ۼƳ\xE4ֵ" .. arg_7_2.Diamond .. "\xD7\xEA")
	elseif arg_7_1 == EGmActivityType.RechargeDailySingle or arg_7_1 == EGmActivityType.RechargeSingle then
		var_7_0 = a2u("\xB5\xA5\xB1ʳ\xE4ֵ" .. arg_7_2.Diamond .. "\xD7\xEA")
	elseif arg_7_1 == EGmActivityType.ConsumSum or arg_7_1 == EGmActivityType.ConsumDailySum then
		var_7_0 = a2u("\xC0ۼ\xC6\xCF\xFB\xBA\xC4" .. arg_7_2.Diamond .. "\xD7\xEA")
	end

	arg_7_0.lbDesc:setString(var_7_0)
	arg_7_0.btnGet:setVisible(arg_7_2.State == 1)
	arg_7_0.spriteGeted:setVisible(arg_7_2.State ~= 1)

	arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")

	local var_7_1 = ""

	if arg_7_2.State == 0 then
		var_7_1 = arg_7_0.spriteframeCache:spriteFrameByName("activity_wdc.png")
	else
		var_7_1 = arg_7_0.spriteframeCache:spriteFrameByName("activity_ylq.png")
	end

	if var_7_1 and var_7_1 ~= "" then
		arg_7_0.spriteGeted:initWithSpriteFrame(var_7_1)
	end

	for iter_7_0 = 1, 3 do
		arg_7_0.items[iter_7_0]:setVisible(false)
	end

	local var_7_2 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_2.AwardList) do
		arg_7_0.items[var_7_2]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count, false)

		if (iter_7_2.Type == ECommonAwardType.HeroFrag or iter_7_2.Type == ECommonAwardType.Hero or iter_7_2.Type == ECommonAwardType.Diamond or iter_7_2.Type == ECommonAwardType.BarMoney or iter_7_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden or iter_7_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_7_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden) and arg_7_0.scrollEffect[var_7_2] == nil then
			arg_7_0.scrollEffect[var_7_2] = g_EffectSystem:creatScrollEffect(arg_7_0.items[var_7_2], iter_7_2.Type)

			arg_7_0.scrollEffect[var_7_2]:setAnimation("animation", true)
		end

		arg_7_0.items[var_7_2]:setVisible(true)

		var_7_2 = var_7_2 + 1
	end
end

function var_0_0.onGet(arg_8_0)
	if arg_8_0.gmActivityType == EGmActivityType.RechargeDaily then
		g_WsMsgHandler:WS_ActivityGm_RechargeDaily_Req(arg_8_0.actId, arg_8_0.dataInfo.Day)
	elseif arg_8_0.gmActivityType == EGmActivityType.RechargeDailySum then
		g_WsMsgHandler:WS_ActivityGm_RechargeDailySum_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	elseif arg_8_0.gmActivityType == EGmActivityType.RechargeDailySingle then
		g_WsMsgHandler:WS_ActivityGm_RechargeDailySingle_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	elseif arg_8_0.gmActivityType == EGmActivityType.RechargeSingle then
		g_WsMsgHandler:WS_ActivityGm_RechargeSingle_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	elseif arg_8_0.gmActivityType == EGmActivityType.RechargeSum then
		g_WsMsgHandler:WS_ActivityGm_RechargeSum_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	elseif arg_8_0.gmActivityType == EGmActivityType.ConsumSum then
		g_WsMsgHandler:WS_ActivityGm_ConsumSum_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	elseif arg_8_0.gmActivityType == EGmActivityType.ConsumDailySum then
		g_WsMsgHandler:WS_ActivityGm_ConsumDailySum_Req(arg_8_0.actId, arg_8_0.dataInfo.Diamond)
	end
end

function var_0_0.refreshScorllEffect(arg_9_0)
	for iter_9_0 = 1, 3 do
		if arg_9_0.scrollEffect[iter_9_0] then
			arg_9_0.scrollEffect[iter_9_0]:setAnimation("animation", true)
		end
	end
end
