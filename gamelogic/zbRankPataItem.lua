local var_0_0 = class("zbRankPataItem", CCNodeExtend)

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

function createRankPataItem()
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

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_rankpata.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		arg_3_0.layerDetail = var_5_1
		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(1), "CCControlButton")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteHead = tolua.cast(var_5_1:getChildByTag(3), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_1:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbLegionName = tolua.cast(var_5_1:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.lbLegionName:setVisible(false)

		local var_5_3 = tolua.cast(var_5_1:getChildByTag(1006), "CCLabelTTF")
		local var_5_4 = tolua.cast(var_5_1:getChildByTag(1007), "CCLabelTTF")
		local var_5_5 = tolua.cast(var_5_1:getChildByTag(1008), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_1:getChildByTag(1009), "CCLabelTTF")

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.6)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbRank)

		arg_3_0.lbYesScore = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbYesScore)

		arg_3_0.lbFloor = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbFloor)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_0)
		arg_3_0:setContentSize(var_5_1:getContentSize())
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return
	end

	arg_7_0.playerId = arg_7_1.PlayerBaseInfo.PlayerId

	local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerBaseInfo.HeadId)

	arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	arg_7_0.lbName:setString(a2u(arg_7_1.PlayerBaseInfo.RoleName))
	arg_7_0.lbLevel:setString(arg_7_1.PlayerBaseInfo.Level)
	arg_7_0.lbVip:setString(arg_7_1.PlayerBaseInfo.VipLevel)
	arg_7_0.lbYesScore:setString(arg_7_1.RankInfo.RankValue)
	arg_7_0.lbRank:setString(arg_7_1.RankInfo.Rank)
	arg_7_0.lbFloor:setString(arg_7_1.RankInfo.ExtraValue)
end

function var_0_0.onTouch(arg_8_0)
	g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_8_0.playerId)
end
