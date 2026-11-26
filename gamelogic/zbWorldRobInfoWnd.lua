require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbWorldRobInfoWnd", zbBaseWnd)

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

function createWorldRobInfoWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroItems = {}
		arg_3_0.playerInfo = nil
		arg_3_0.horseData = nil
		arg_3_0.record = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_robinfo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.nodeInfo = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.lbName = tolua.cast(arg_3_0.nodeInfo:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteHead = tolua.cast(arg_3_0.nodeInfo:getChildByTag(4), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(5), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")
		local var_5_5 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(6), "CCSprite")
		local var_5_6 = tolua.cast(var_5_5:getChildByTag(1), "CCLabelTTF")
		local var_5_7 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(7), "CCNode")
		local var_5_8 = tolua.cast(var_5_7:getChildByTag(1), "CCLabelTTF")

		arg_3_0.lbLegion = tolua.cast(arg_3_0.nodeInfo:getChildByTag(1008), "CCLabelTTF")

		local var_5_9 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(9), "CCLayer")

		for iter_5_0 = 1, 5 do
			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0), "CCNode")

			var_5_10:setVisible(false)

			local var_5_11 = createItem()

			var_5_11:setPosition(var_5_10:getPosition())
			var_5_11:setScale(0.8)
			var_5_11:setNodeStarVisible()

			arg_3_0.heroItems[iter_5_0] = var_5_11

			var_5_9:addChild(var_5_11)
			var_5_10:removeFromParentAndCleanup(true)
		end

		local var_5_12 = tolua.cast(var_5_2:getChildByTag(10), "CCNode")
		local var_5_13 = createItem()

		var_5_13:setPosition(var_5_12:getPosition())
		var_5_13:setScale(0.5)
		var_5_13:setNodeStarVisible()
		var_5_2:addChild(var_5_13)
		var_5_12:removeFromParentAndCleanup(true)

		arg_3_0.awardItem = var_5_13
		arg_3_0.lbMoney = tolua.cast(var_5_2:getChildByTag(11), "CCLabelTTF")
		arg_3_0.btnLetgo = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLetgo:addHandleOfControlEvent(function()
			arg_3_0:onLetgo()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.6)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.6)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.6)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshPlayerInfo()
	end, zbGameEvent.Event_WorldHorseBaseFormationAck)
end

function var_0_0.refreshPlayerInfo(arg_9_0)
	arg_9_0.playerInfo = PlayerFormationInfo

	if zbUtil:isValidTable(arg_9_0.playerInfo) == false then
		if zbUtil:isValidTable(arg_9_0.horseData) then
			g_Self.kWorldHandler.bworldHorseBaseFormationInfoReq = true

			g_WsMsgHandler:WS_Player_Formation_Req(arg_9_0.horseData.PlayerId)
		end

		return
	end

	if arg_9_0.playerInfo.PlayerTipsInfo ~= nil then
		arg_9_0.nodeInfo:setVisible(true)
		arg_9_0.lbName:setString(arg_9_0.playerInfo.PlayerTipsInfo.RoleName)
		arg_9_0.lbLevel:setString(arg_9_0.playerInfo.PlayerTipsInfo.Level)
		arg_9_0.lbFight:setString(arg_9_0.playerInfo.PlayerTipsInfo.FV)
		arg_9_0.lbVip:setString(arg_9_0.playerInfo.PlayerTipsInfo.VipLevel)

		if zbUtil:isValidTable(arg_9_0.playerInfo.PlayerTipsInfo.LegionName) then
			arg_9_0.lbLegion:setString(a2u(arg_9_0.playerInfo.PlayerTipsInfo.LegionName))
		else
			arg_9_0.lbLegion:setString("")
		end

		local var_9_0 = zbIconHelper:getPlayerHeadIconPath(arg_9_0.playerInfo.PlayerTipsInfo.HeadId)

		arg_9_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_0))
	end

	for iter_9_0 = 1, 5 do
		arg_9_0.heroItems[iter_9_0]:setVisible(false)
	end

	local var_9_1 = arg_9_0.playerInfo.HeroList
	local var_9_2 = 1

	for iter_9_1, iter_9_2 in pairs(var_9_1) do
		if var_9_2 <= 5 then
			arg_9_0.heroItems[var_9_2]:refreshHero(iter_9_2)
			arg_9_0.heroItems[var_9_2]:setVisible(true)
		end

		var_9_2 = var_9_2 + 1
	end
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	PlayerFormationInfo = nil

	arg_10_0.nodeInfo:setVisible(false)

	arg_10_0.record = arg_10_1

	if arg_10_1 then
		arg_10_0.horseData = g_Self.kWorldHandler:getWorldHorseInfoById(arg_10_1.id)

		arg_10_0:refreshPlayerInfo()

		local var_10_0 = ""
		local var_10_1 = ""

		if zbUtil:isValidTable(g_DataConfig.m_kWorldBaseCfg.special.list) then
			for iter_10_0, iter_10_1 in pairs(g_DataConfig.m_kWorldBaseCfg.special.list) do
				if iter_10_1.type == EWorldSpecialNode.HorseCar then
					var_10_0 = iter_10_1.title
					var_10_1 = iter_10_1.desc
				end
			end
		end

		arg_10_0.lbTitle:setString(a2u(var_10_0))
		arg_10_0.lbDesc:setString(a2u(var_10_1))

		if arg_10_0.horseData and zbUtil:isValidTable(arg_10_0.horseData.AwardList) and table.getn(arg_10_0.horseData.AwardList) > 0 then
			local var_10_2 = arg_10_0.horseData.AwardList[1]

			arg_10_0.awardItem:refreshAward(var_10_2.Type, var_10_2.Id, var_10_2.Count, false, false)
			arg_10_0.lbMoney:setString(var_10_2.Count)
		end
	end
end

function var_0_0.onFight(arg_11_0)
	if arg_11_0.playerInfo == nil or arg_11_0.record == nil then
		return
	end

	arg_11_0:hide()

	if g_MainScene.wndMain then
		g_MainScene.wndMain:hide()
	end

	g_Self.kWorldHandler.combatSeceneId = 1

	g_MainScene:showEmbattleWorldHorse(arg_11_0.record.id, arg_11_0.playerInfo)
end

function var_0_0.onLetgo(arg_12_0)
	if arg_12_0.record == nil then
		return
	end

	local function var_12_0()
		arg_12_0:hide()
		g_WsMsgHandler:WS_WorldSpe_HCGiveUp_Req(arg_12_0.record.id)
	end

	local var_12_1 = a2u("\xB7\xC5\xC6\xFA\xB5Ļ\xB0\xA3\xAC\xC8\xEB\xC7\xD6\xD5\xDF\xC5ܵ\xF4\xBE\xCD\xCE޷\xA8\xBB\xF1\xB5ý\xB1\xC0\xF8Ŷ\xA3\xA1")

	g_MessageBox:showYesNo(var_12_1, var_12_0)
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layer, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
