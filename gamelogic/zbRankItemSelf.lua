local var_0_0 = class("zbRankItemSelf", CCNodeExtend)

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

function createRankItemSelf()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.playerId = 0
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_rankitemself.ccbi")

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbLegionName = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbNoRank = tolua.cast(var_5_0:getChildByTag(8), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1009), "CCLabelTTF")

		arg_3_0.spriteUp = tolua.cast(var_5_0:getChildByTag(10), "CCSprite")
		arg_3_0.lbRankUp = tolua.cast(var_5_0:getChildByTag(1011), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.6)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.8)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_0)
		arg_3_0:setContentSize(arg_3_0.btnTouch:getContentSize())
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refreshSelfRankInfo(arg_7_0, arg_7_1)
	arg_7_0.playerId = g_Self:getPlayerId()

	local var_7_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	arg_7_0.lbName:setString(a2u(g_Self:getName()))
	arg_7_0.lbLevel:setString(g_Self:getLevel())
	arg_7_0.lbPower:setString(g_Self:getFightValue())
	arg_7_0.spriteUp:setVisible(false)
	arg_7_0.lbRankUp:setVisible(false)

	if arg_7_1 == ERankTab.Arena then
		arg_7_0.lbLegionName:setVisible(true)

		if g_GameData.LegionInfo.LegionId > 0 and g_Self.kLegionHandler.legionDetail then
			arg_7_0.lbLegionName:setString(a2u(g_Self.kLegionHandler.legionDetail.LegionBaseInfo.LegionName))
		else
			arg_7_0.lbLegionName:setString("")
		end

		if zbUtil:isValidTable(g_GameData.SelfArenaInfo) == false then
			if g_Self.kArenaHandler.ArenaBaseInfo ~= nil then
				arg_7_0.lbRank:setString(g_Self.kArenaHandler.ArenaBaseInfo.Rank)
				arg_7_0.lbNoRank:setVisible(false)
				arg_7_0.lbRank:setVisible(true)
			else
				arg_7_0.lbNoRank:setVisible(true)
				arg_7_0.lbRank:setVisible(false)
			end
		else
			arg_7_0.lbRank:setString(g_GameData.SelfArenaInfo.ArenaBaseInfo.Rank)
			arg_7_0.lbNoRank:setVisible(false)
			arg_7_0.lbRank:setVisible(true)
		end
	else
		arg_7_0.lbLegionName:setVisible(false)

		if zbUtil:isValidTable(g_Self.kRankHandler.FVRankData.SelfRankInfo) == false then
			arg_7_0.lbNoRank:setVisible(true)
			arg_7_0.lbRank:setVisible(false)
		else
			arg_7_0.lbRank:setString(g_Self.kRankHandler.FVRankData.SelfRankInfo.Rank)
			arg_7_0.lbNoRank:setVisible(false)
			arg_7_0.lbRank:setVisible(true)

			if zbUtil:isValidTable(g_Self.kRankHandler.FVRankData.HistoryInfo) ~= false then
				local var_7_1 = g_Self.kRankHandler.FVRankData.SelfRankInfo.Rank - g_Self.kRankHandler.FVRankData.HistoryInfo.Rank

				arg_7_0:setRankUp(var_7_1)
			end
		end
	end
end

function var_0_0.setRankUp(arg_8_0, arg_8_1)
	if arg_8_1 == 0 then
		arg_8_0.spriteUp:setVisible(false)
		arg_8_0.lbRankUp:setVisible(false)

		return
	else
		arg_8_0.spriteUp:setVisible(true)
		arg_8_0.lbRankUp:setVisible(true)
	end

	if arg_8_1 < 0 then
		arg_8_0.spriteUp:setTexture(CCTextureCache:sharedTextureCache():addImage("image/arena/arena_up.png"))
		arg_8_0.lbRankUp:setString(a2u(string.format("\xB1\xC8\xD7\xF2\xC8\xD5\xC9\xCF\xC9\xFD%d\xC3\xFB", -arg_8_1)))
	else
		arg_8_0.spriteUp:setTexture(CCTextureCache:sharedTextureCache():addImage("image/arena/arena_down.png"))
		arg_8_0.lbRankUp:setString(a2u(string.format("\xB1\xC8\xD7\xF2\xC8\xD5\xCF½\xB5%d\xC3\xFB", arg_8_1)))
	end
end

function var_0_0.onTouch(arg_9_0)
	g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_9_0.playerId)
end
