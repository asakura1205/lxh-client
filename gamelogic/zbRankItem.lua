local var_0_0 = class("zbRankItem", CCNodeExtend)

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

function createRankItem()
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

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_rankitem.ccbi")

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbLegionName = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")
		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1009), "CCLabelTTF")

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

function var_0_0.refreshOthersRankInfo(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		return
	end

	local var_7_0 = 0
	local var_7_1 = ""
	local var_7_2 = 0
	local var_7_3 = 0
	local var_7_4 = 0

	if arg_7_2 == ERankTab.Arena then
		arg_7_0.playerId = arg_7_1.PlayerId
		var_7_0 = arg_7_1.HeadId
		var_7_1 = arg_7_1.RoleName
		var_7_2 = arg_7_1.Level
		var_7_3 = arg_7_1.FV
		var_7_4 = arg_7_1.Rank

		arg_7_0.lbLegionName:setVisible(true)

		if type(arg_7_1.LegionName) ~= "userdata" then
			arg_7_0.lbLegionName:setString(a2u(arg_7_1.LegionName))
		else
			arg_7_0.lbLegionName:setString("")
		end
	else
		arg_7_0.playerId = arg_7_1.PlayerBaseInfo.PlayerId
		var_7_0 = arg_7_1.PlayerBaseInfo.HeadId
		var_7_1 = arg_7_1.PlayerBaseInfo.RoleName
		var_7_2 = arg_7_1.PlayerBaseInfo.Level
		var_7_3 = arg_7_1.RankInfo.RankValue
		var_7_4 = arg_7_1.RankInfo.Rank

		arg_7_0.lbLegionName:setVisible(false)
	end

	local var_7_5 = zbIconHelper:getPlayerHeadIconPath(var_7_0)

	arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_5))
	arg_7_0.lbName:setString(a2u(var_7_1))
	arg_7_0.lbLevel:setString(var_7_2)
	arg_7_0.lbPower:setString(var_7_3)
	arg_7_0.lbRank:setString(var_7_4)
end

function var_0_0.onTouch(arg_8_0)
	g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_8_0.playerId)
end
