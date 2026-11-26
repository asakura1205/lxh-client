require("gamebase.zbFunctions")

local var_0_0 = class("zbArenaRecordItem", CCNodeExtend)

var_0_0.__index = var_0_0
ArenaRecordItem_Height = 110
ArenaRecordItem_Width = 820

local var_0_1 = {
	"image/arena/arena_attack.png",
	"image/arena/arena_defend.png"
}

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createArenaRecordItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.fightRecord = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteWin = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLose = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteUp = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.spriteDown = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.lbRankDelta = tolua.cast(var_5_0:getChildByTag(5), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbTime = tolua.cast(var_5_0:getChildByTag(1008), "CCLabelTTF")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(9), "CCSprite")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1010), "CCLabelTTF")

		arg_3_0.spriteFightType = tolua.cast(var_5_0:getChildByTag(11), "CCSprite")
		arg_3_0.spriteFight = tolua.cast(var_5_0:getChildByTag(12), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.spriteFight:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.btnReplay = tolua.cast(var_5_0:getChildByTag(10), "CCControlButton")
		arg_3_0.btnTip = tolua.cast(var_5_0:getChildByTag(13), "CCControlButton")

		arg_3_0.btnReplay:addHandleOfControlEvent(function()
			arg_3_0:onReplay()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTip:addHandleOfControlEvent(function()
			arg_3_0:onTip()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbSatisfy = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbSatisfy)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.5)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	end

	arg_8_0.fightRecord = arg_8_1

	arg_8_0:setVisible(true)
	arg_8_0.spriteWin:setVisible(arg_8_1.Result == 1)
	arg_8_0.spriteLose:setVisible(arg_8_1.Result == 0)
	arg_8_0.spriteUp:setVisible(arg_8_1.Result == 1 and arg_8_1.ChangeRank ~= 0)
	arg_8_0.spriteDown:setVisible(arg_8_1.Result == 0 and arg_8_1.ChangeRank ~= 0)

	if arg_8_1.ChangeRank == 0 then
		arg_8_0.lbRankDelta:setString(a2u("\xCEޱ仯"))
	elseif arg_8_1.ChangeRank > 0 then
		arg_8_0.lbRankDelta:setString(arg_8_1.ChangeRank)
	elseif arg_8_1.ChangeRank < 0 then
		arg_8_0.lbRankDelta:setString(-arg_8_1.ChangeRank)
	end

	local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.PlayerBaseInfo.HeadId)

	arg_8_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	arg_8_0.spriteFightType:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[arg_8_1.FightType]))
	arg_8_0.lbName:setString(a2u(arg_8_1.PlayerBaseInfo.RoleName))
	arg_8_0.lbLevel:setString(arg_8_1.PlayerBaseInfo.Level)
	arg_8_0.lbFight:setString(arg_8_1.PlayerBaseInfo.FV)
	arg_8_0.lbSatisfy:setString("")

	local var_8_1 = math.max(g_Self.kTimeHandler:getServerTime() - arg_8_1.RecordTm, 0)
	local var_8_2 = zbUtil:getPassTime(var_8_1)

	arg_8_0.lbTime:setString(var_8_2)
end

function var_0_0.onReplay(arg_9_0)
	if arg_9_0.fightRecord ~= nil then
		g_WsMsgHandler:WS_Common_BattleRecord_Req(arg_9_0.fightRecord.UUID)

		g_CombatArenaRecordResult = arg_9_0.fightRecord.Result
	end
end

function var_0_0.onTip(arg_10_0)
	if arg_10_0.fightRecord ~= nil then
		g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_10_0.fightRecord.PlayerBaseInfo.PlayerId)
	end
end
