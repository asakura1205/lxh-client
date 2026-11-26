local var_0_0 = class("zbGmActivityWnd_Active")

var_0_0.__index = var_0_0

function createGmActivityWnd_Active(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.activeInfo = nil
		arg_2_0.items = {}
		arg_2_0.scrollEffect = {}
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.DailyActive) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.activeInfo = iter_2_1

				break
			end
		end
	end
end

function var_0_0.refresh(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_active.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.nodeAward = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 4 do
			local var_5_3 = tolua.cast(arg_4_0.nodeAward:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.8)
			var_5_4:setSwallowsTouches(false)
			arg_4_0.nodeAward:addChild(var_5_4)

			arg_4_0.items[iter_5_0] = var_5_4

			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_4_0.centerPositionX = (arg_4_0.items[2]:getPositionX() + arg_4_0.items[3]:getPositionX()) / 2
		arg_4_0.btnGet = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")

		arg_4_0.btnGet:addHandleOfControlEvent(function()
			arg_4_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnGet:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_4_0.btnGet:setSwallowsTouches(false)
		arg_4_0.btnGet:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_2:getChildByTag(1004), "CCLabelTTF")
		local var_5_7 = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")

		arg_4_0.lbActive = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_4_0.lbActive)
		arg_4_0.lbActive:setScale(0.5)

		arg_4_0.lbStart = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_4_0.lbStart)
		arg_4_0.lbStart:setScale(0.5)

		arg_4_0.lbEnd = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_4_0.lbEnd)
		arg_4_0.lbEnd:setScale(0.5)
		arg_4_0.lbStart:setString(0)
		arg_4_0.lbEnd:setString(100)

		local function var_5_8(arg_7_0, arg_7_1)
			local var_7_0 = CCSprite:create(arg_7_1)

			var_7_0:setAnchorPoint(ccp(0, 0))

			local var_7_1 = CCProgressTimer:create(var_7_0)

			var_7_1:setAnchorPoint(ccp(0, 0))
			var_7_1:setPercentage(100)
			var_7_1:setMidpoint(ccp(0, 1))
			var_7_1:setBarChangeRate(ccp(1, 0))
			var_7_1:setType(kCCProgressTimerTypeBar)
			var_7_1:retain()
			var_7_1:setPosition(1, 0)
			arg_7_0:addChild(var_7_1)

			return var_7_1
		end

		arg_4_0.spriteProgressBg = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")
		arg_4_0.spriteProgress = var_5_8(arg_4_0.spriteProgressBg, "image/gmactivity/gmactivity_progress.png")
		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
		CCLabelTTF:endDelayCreateTexture(var_5_1)
	end)()

	if arg_4_0.activeInfo == nil then
		return
	end

	arg_4_0.activeInfo = g_Self.kGmActivityHandler:getActiveInfoByActId(arg_4_0.activeInfo.ActId)

	if arg_4_0.activeInfo == nil then
		return
	end

	arg_4_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_4_0.activeInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.activeInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.activeInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.activeInfo.GmBaseInfo.ActEnd)))
	arg_4_0.lbDesc:setString(a2u(arg_4_0.activeInfo.GmBaseInfo.Content))
	arg_4_0.spriteProgress:runAction(CCProgressTo:create(0, g_GameData.DailyTask.ActiveCount))
	arg_4_0.lbActive:setString(g_GameData.DailyTask.ActiveCount .. "/100")
	arg_4_0.btnGet:setGray(arg_4_0.activeInfo.State == 1)

	for iter_4_0 = 1, 4 do
		arg_4_0.items[iter_4_0]:setVisible(false)
	end

	local var_4_0 = 1

	for iter_4_1, iter_4_2 in pairs(arg_4_0.activeInfo.AwardList) do
		local var_4_1 = arg_4_0.items[var_4_0]

		if var_4_1 then
			var_4_1:refreshAward(iter_4_2.Type, iter_4_2.Id, iter_4_2.Count, false)

			if (iter_4_2.Type == ECommonAwardType.HeroFrag or iter_4_2.Type == ECommonAwardType.Hero or iter_4_2.Type == ECommonAwardType.Diamond or iter_4_2.Type == ECommonAwardType.BarMoney or iter_4_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_4_2.Id) > EItemQuality.Golden or iter_4_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_4_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_4_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_4_2.Id) > EItemQuality.Golden) and arg_4_0.scrollEffect[var_4_0] == nil then
				arg_4_0.scrollEffect[var_4_0] = g_EffectSystem:creatScrollEffect(arg_4_0.items[var_4_0], iter_4_2.Type)

				arg_4_0.scrollEffect[var_4_0]:setAnimation("animation", true)
			end

			var_4_1:setVisible(true)

			var_4_0 = var_4_0 + 1
		end
	end

	zbUIEffect:centerStar(arg_4_0.items, arg_4_0.centerPositionX)
end

function var_0_0.onGet(arg_8_0)
	if arg_8_0.activeInfo.State == 1 then
		g_Bubble:bubbleInfo(a2u("\xBD\xB1\xC0\xF8\xD2\xD1\xC1\xECȡ\xA1\xAB"))

		return
	elseif g_GameData.DailyTask.ActiveCount < 100 then
		g_Bubble:bubbleInfo(a2u("\xBB\xEEԾ\xB6Ȳ\xBB\xD7\xE3\xDFϡ\xAB"))

		return
	end

	g_WsMsgHandler:WS_ActivityGm_DailyActive_Req(arg_8_0.activeInfo.ActId)
end
