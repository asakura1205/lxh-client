local var_0_0 = class("zbRankTopItem", CCNodeExtend)

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

function createRankTopItem()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.playerId = nil
		arg_3_0.eRankTab = -1
		arg_3_0.playerInfo = nil
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_ranktop.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCLayer")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteHead = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_1:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbLegion = tolua.cast(var_5_1:getChildByTag(5), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.spriteRank = tolua.cast(var_5_1:getChildByTag(7), "CCSprite")

		local var_5_3 = tolua.cast(var_5_1:getChildByTag(8), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(9), "CCControlButton")
		arg_3_0.spriteSingle = tolua.cast(var_5_1:getChildByTag(10), "CCSprite")
		arg_3_0.spriteHead2 = tolua.cast(arg_3_0.spriteSingle:getChildByTag(2), "CCSprite")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.6)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		return
	end

	arg_7_0.playerInfo = arg_7_1
	arg_7_0.eRankTab = arg_7_2

	local var_7_0 = ""
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = 0

	if arg_7_2 == ERankTab.Arena then
		arg_7_0.spriteSingle:setVisible(false)
		arg_7_0.spriteHead:setVisible(true)

		local var_7_4 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.HeadId)

		arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_4))

		arg_7_0.playerId = arg_7_1.PlayerId
		var_7_0 = arg_7_1.RoleName
		var_7_1 = arg_7_1.Level
		var_7_2 = arg_7_1.FV
		var_7_3 = arg_7_1.Rank

		arg_7_0.lbLegion:setVisible(true)

		if type(arg_7_1.LegionName) ~= "userdata" then
			arg_7_0.lbLegion:setString(a2u(arg_7_1.LegionName))
		else
			arg_7_0.lbLegion:setString("")
		end
	elseif arg_7_2 == ERankTab.FV then
		arg_7_0.spriteSingle:setVisible(false)
		arg_7_0.spriteHead:setVisible(true)

		local var_7_5 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerBaseInfo.HeadId)

		arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_5))

		arg_7_0.playerId = arg_7_1.PlayerBaseInfo.PlayerId
		var_7_0 = arg_7_1.PlayerBaseInfo.RoleName
		var_7_1 = arg_7_1.PlayerBaseInfo.Level
		var_7_2 = arg_7_1.RankInfo.RankValue
		var_7_3 = arg_7_1.RankInfo.Rank

		arg_7_0.lbLegion:setVisible(false)
	else
		arg_7_0.spriteSingle:setVisible(true)
		arg_7_0.spriteHead:setVisible(false)

		local var_7_6 = zbIconHelper:getHeroIconPath(arg_7_1.HeroDetail.HeroBaseInfo.TemplateId)

		arg_7_0.spriteHead2:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_6))

		local var_7_7 = zbColor:getHeroFrameTex(arg_7_1.HeroDetail.HeroBaseInfo.Quality)

		arg_7_0.spriteSingle:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_7))

		arg_7_0.playerId = arg_7_1.PlayerBaseInfo.PlayerId
		var_7_0 = arg_7_1.PlayerBaseInfo.RoleName
		var_7_1 = arg_7_1.HeroDetail.HeroBaseInfo.Level
		var_7_2 = arg_7_1.RankValue
		var_7_3 = arg_7_1.Rank

		arg_7_0.lbLegion:setVisible(false)
	end

	arg_7_0:setVisible(true)

	if type(var_7_0) ~= "userdata" then
		arg_7_0.lbName:setString(a2u(var_7_0))
	else
		arg_7_0.lbName:setString("")
	end

	arg_7_0.lbLevel:setString(var_7_1)
	arg_7_0.lbPower:setString(var_7_2)
	arg_7_0:refreshRankSprite(var_7_3)
end

function var_0_0.refreshRankSprite(arg_8_0, arg_8_1)
	if arg_8_1 == 1 then
		arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_firstbg.png"))
		arg_8_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_first.png"))
	elseif arg_8_1 == 2 then
		arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_secondbg.png"))
		arg_8_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_second.png"))
	elseif arg_8_1 == 3 then
		arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_thirdbg.png"))
		arg_8_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_third.png"))
	end
end

function var_0_0.onTouch(arg_9_0)
	if arg_9_0.eRankTab == ERankTab.Arena or arg_9_0.eRankTab == ERankTab.FV then
		g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_9_0.playerId)
	elseif arg_9_0.playerInfo then
		g_MainScene:showRankTipSingleWnd(arg_9_0.playerInfo.HeroDetail)
	end
end
