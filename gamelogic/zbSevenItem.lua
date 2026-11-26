require("gamelogic.zbItem")

local var_0_0 = class("zbSevenItem", CCNodeExtend)

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

function createSevenItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.type = arg_3_1
		arg_3_0.itemData = itemData
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_seven.ccbi")

		arg_3_0.cellNode = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.cellNode:getChildByTag(0), "CCSprite")
		arg_3_0.spriteGeted = tolua.cast(arg_3_0.cellNode:getChildByTag(4), "CCSprite")
		arg_3_0.btnGet = tolua.cast(arg_3_0.cellNode:getChildByTag(5), "CCControlButton")
		arg_3_0.spriteSign = tolua.cast(arg_3_0.cellNode:getChildByTag(101), "CCSprite")

		local var_5_1 = tolua.cast(arg_3_0.spriteSign:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteStar = tolua.cast(arg_3_0.cellNode:getChildByTag(102), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.spriteStar:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteLevel = tolua.cast(arg_3_0.cellNode:getChildByTag(103), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spritePata = tolua.cast(arg_3_0.cellNode:getChildByTag(104), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.spritePata:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteArena = tolua.cast(arg_3_0.cellNode:getChildByTag(105), "CCNode")
		arg_3_0.spriteRankTop = tolua.cast(arg_3_0.spriteArena:getChildByTag(1), "CCSprite")
		arg_3_0.spriteRankNormal = tolua.cast(arg_3_0.spriteArena:getChildByTag(2), "CCSprite")

		local var_5_5 = tolua.cast(arg_3_0.spriteRankNormal:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spritePower = tolua.cast(arg_3_0.cellNode:getChildByTag(106), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.spritePower:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteCharge = tolua.cast(arg_3_0.cellNode:getChildByTag(107), "CCSprite")

		local var_5_7 = tolua.cast(arg_3_0.spriteCharge:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbSign = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbSign)
		arg_3_0.lbSign:setScale(0.75)

		arg_3_0.lbStar = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbStar)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.75)

		arg_3_0.lbPata = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbPata)
		arg_3_0.lbPata:setScale(0.75)

		arg_3_0.lbArena = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbArena)
		arg_3_0.lbArena:setScale(0.8)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.7)

		arg_3_0.lbCharge = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbCharge)
		arg_3_0.lbCharge:setScale(0.6)

		for iter_5_0 = 1, 3 do
			local var_5_8 = tolua.cast(arg_3_0.cellNode:getChildByTag(iter_5_0), "CCLayer")
			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(0.7)
			var_5_9:setNeedTip(true)
			var_5_9:setSupportTouchDownTip(false)
			var_5_9:setSupportTouchTip(true)
			var_5_9:setSwallowsTouches(false)

			arg_3_0.items[iter_5_0] = var_5_9

			arg_3_0.cellNode:addChild(arg_3_0.items[iter_5_0])
			var_5_8:removeFromParentAndCleanup(true)
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

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.itemData = arg_7_1

	arg_7_0.spriteSign:setVisible(arg_7_0.type == ESevenType.Sign)
	arg_7_0.spriteStar:setVisible(arg_7_0.type == ESevenType.Star)
	arg_7_0.spriteLevel:setVisible(arg_7_0.type == ESevenType.Level)
	arg_7_0.spritePata:setVisible(arg_7_0.type == ESevenType.Pata)
	arg_7_0.spriteArena:setVisible(arg_7_0.type == ESevenType.Arena)
	arg_7_0.spritePower:setVisible(arg_7_0.type == ESevenType.Power)
	arg_7_0.spriteCharge:setVisible(arg_7_0.type == ESevenType.Charge)

	if arg_7_0.type == ESevenType.Sign then
		arg_7_0.lbSign:setString(arg_7_1.Day)
	elseif arg_7_0.type == ESevenType.Star then
		arg_7_0.lbStar:setString(arg_7_1.Star)
	elseif arg_7_0.type == ESevenType.Level then
		arg_7_0.lbLevel:setString(arg_7_1.Level)
	elseif arg_7_0.type == ESevenType.Pata then
		arg_7_0.lbPata:setString(arg_7_1.Level)
	elseif arg_7_0.type == ESevenType.Arena then
		arg_7_0.spriteRankTop:setVisible(arg_7_1.Rank <= 3)
		arg_7_0.spriteRankNormal:setVisible(arg_7_1.Rank > 3)

		if arg_7_1.Rank == 1 then
			arg_7_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_first.png"))
		elseif arg_7_1.Rank == 2 then
			arg_7_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_second.png"))
		elseif arg_7_1.Rank == 3 then
			arg_7_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_third.png"))
		else
			arg_7_0.lbArena:setString(arg_7_1.Rank)
		end
	elseif arg_7_0.type == ESevenType.Power then
		arg_7_0.lbPower:setString(arg_7_1.FV)
	elseif arg_7_0.type == ESevenType.Charge then
		arg_7_0.lbCharge:setString(arg_7_1.Diamond)
	end

	for iter_7_0 = 1, 3 do
		arg_7_0.items[iter_7_0]:setVisible(false)
	end

	local var_7_0 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_1.AwardList) do
		arg_7_0.items[var_7_0]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count, false)

		if (iter_7_2.Type == ECommonAwardType.HeroFrag or iter_7_2.Type == ECommonAwardType.Hero or iter_7_2.Type == ECommonAwardType.Diamond or iter_7_2.Type == ECommonAwardType.BarMoney or iter_7_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden or iter_7_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_7_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden) and arg_7_0.scrollEffect[var_7_0] == nil then
			arg_7_0.scrollEffect[var_7_0] = g_EffectSystem:creatScrollEffect(arg_7_0.items[var_7_0], iter_7_2.Type)

			arg_7_0.scrollEffect[var_7_0]:setAnimation("animation", true)
		end

		arg_7_0.items[var_7_0]:setVisible(true)

		var_7_0 = var_7_0 + 1
	end
end

function var_0_0.refreshState(arg_8_0, arg_8_1)
	arg_8_0.itemData = arg_8_1

	arg_8_0.btnGet:setVisible(arg_8_1.State == 1)
	arg_8_0.spriteGeted:setVisible(arg_8_1.State ~= 1)

	local var_8_0 = "image/seven/seven_cell" .. arg_8_1.State .. ".png"
	local var_8_1 = arg_8_0.type == ESevenType.Arena and arg_8_1.State ~= 2 and (arg_8_1.Rank <= 3 and "image/seven/seven_cell.png" or "image/seven/seven_cell1.png") or "image/seven/seven_cell" .. arg_8_1.State .. ".png"

	arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))

	arg_8_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_8_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")

	local var_8_2 = ""

	if arg_8_1.State == 0 then
		var_8_2 = arg_8_0.spriteframeCache:spriteFrameByName("activity_wdc.png")
	else
		var_8_2 = arg_8_0.spriteframeCache:spriteFrameByName("activity_ylq.png")
	end

	if var_8_2 and var_8_2 ~= "" then
		arg_8_0.spriteGeted:initWithSpriteFrame(var_8_2)
	end
end

function var_0_0.onGet(arg_9_0)
	if arg_9_0.type == ESevenType.Sign then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.itemData.AwardList) do
			if iter_9_1.Type == ECommonAwardType.Hero then
				g_Self.kActivityHandler.lastTemplateId = iter_9_1.Id
			end
		end

		g_WsMsgHandler:WS_ActivityOs_LoginAward_Req(arg_9_0.itemData.Day)
	elseif arg_9_0.type == ESevenType.Star then
		g_WsMsgHandler:WS_ActivityOs_StarAward_Req(arg_9_0.itemData.Star)
	elseif arg_9_0.type == ESevenType.Level then
		for iter_9_2, iter_9_3 in pairs(arg_9_0.itemData.AwardList) do
			if iter_9_3.Type == ECommonAwardType.Hero then
				g_Self.kSevenHandler.lastTemplateId = iter_9_3.Id
			end
		end

		g_WsMsgHandler:WS_ActivityOs_LevelAward_Req(arg_9_0.itemData.Level)
	elseif arg_9_0.type == ESevenType.Pata then
		g_WsMsgHandler:WS_ActivityOs_PataAward_Req(arg_9_0.itemData.Level)
	elseif arg_9_0.type == ESevenType.Arena then
		g_WsMsgHandler:WS_ActivityOs_ArenaAward_Req(arg_9_0.itemData.Rank)
	elseif arg_9_0.type == ESevenType.Power then
		g_WsMsgHandler:WS_ActivityOs_FVAward_Req(arg_9_0.itemData.FV)
	elseif arg_9_0.type == ESevenType.Charge then
		g_WsMsgHandler:WS_ActivityOs_RechargeAward_Req(arg_9_0.itemData.Diamond)
	end
end

function var_0_0.refreshScorllEffect(arg_10_0)
	for iter_10_0 = 1, 3 do
		if arg_10_0.scrollEffect[iter_10_0] then
			arg_10_0.scrollEffect[iter_10_0]:setAnimation("animation", true)
		end
	end
end
