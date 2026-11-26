require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")
require("gamelogic.zbLegionHelp")

local var_0_0 = class("zbLegionWar_DailyWnd", zbBaseWnd)

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

function createLegionWarDailyWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroItems = {}
		arg_3_0.nodeAdd = {}
		arg_3_0.spriteAdd = {}
		arg_3_0.lbAdd = {}
		arg_3_0.awardItems = {}
		arg_3_0.repairItems = {}
		arg_3_0.ssRepairItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_daily.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_1:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteHead = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCSprite")
		arg_3_0.lbname = tolua.cast(arg_3_0.spriteHead:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbLegionName = tolua.cast(arg_3_0.layer:getChildByTag(4), "CCLabelTTF")
		arg_3_0.legionlv = tolua.cast(arg_3_0.layer:getChildByTag(5), "CCSprite")
		arg_3_0.spriteBarBg = tolua.cast(arg_3_0.layer:getChildByTag(6), "CCSprite")
		arg_3_0.lbHpPointDummy = tolua.cast(arg_3_0.layer:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbHpPoint = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbHpPointDummy, arg_3_0.lbHpPoint)
		arg_3_0.lbHpPoint:setScale(0.6)

		local function var_5_3(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(0)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBar = var_5_3(arg_3_0.spriteBarBg, "image/common/progress.png")
		arg_3_0.nodeFight = tolua.cast(arg_3_0.layer:getChildByTag(7), "CCNode")
		arg_3_0.playIcon = tolua.cast(arg_3_0.nodeFight:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLv = tolua.cast(arg_3_0.nodeFight:getChildByTag(2), "CCSprite")
		arg_3_0.lbPlayLevelDummy = tolua.cast(arg_3_0.spriteLv:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbPlayLevel = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbPlayLevelDummy, arg_3_0.lbPlayLevel)
		arg_3_0.lbPlayLevel:setScale(0.6)

		arg_3_0.lbPlayName = tolua.cast(arg_3_0.nodeFight:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteFV = tolua.cast(arg_3_0.nodeFight:getChildByTag(4), "CCSprite")
		arg_3_0.lbPlayFVDummy = tolua.cast(arg_3_0.spriteFV:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbPlayFV = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbPlayFVDummy, arg_3_0.lbPlayFV)
		arg_3_0.lbPlayFV:setScale(0.6)

		arg_3_0.lbNeedFoodDummy = tolua.cast(arg_3_0.nodeFight:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbNeedFood = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNeedFoodDummy, arg_3_0.lbNeedFood)
		arg_3_0.lbNeedFood:setScale(0.6)

		arg_3_0.btnFight = tolua.cast(arg_3_0.nodeFight:getChildByTag(8), "CCControlButton")
		arg_3_0.nodeComm = tolua.cast(arg_3_0.nodeFight:getChildByTag(9), "CCNode")
		arg_3_0.lbCommTitle = tolua.cast(arg_3_0.nodeComm:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbCommCountDummy = tolua.cast(arg_3_0.nodeComm:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbCommCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCommCountDummy, arg_3_0.lbCommCount)
		arg_3_0.lbCommCount:setScale(0.55)

		arg_3_0.lbCommGetTitle = tolua.cast(arg_3_0.nodeComm:getChildByTag(2), "CCLabelTTF")

		local var_5_4 = tolua.cast(arg_3_0.nodeComm:getChildByTag(3), "CCLayer")

		for iter_5_0 = 1, 4 do
			local var_5_5 = tolua.cast(var_5_4:getChildByTag(iter_5_0), "CCNode")

			var_5_5:setVisible(false)

			local var_5_6 = createItem()

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_6:setScale(0.7)
			var_5_6:setNeedTip(true)

			arg_3_0.awardItems[iter_5_0] = var_5_6

			var_5_4:addChild(var_5_6)
			var_5_5:removeFromParentAndCleanup(true)
		end

		local var_5_7 = tolua.cast(arg_3_0.nodeFight:getChildByTag(5), "CCLayer")

		for iter_5_1 = 1, 5 do
			local var_5_8 = tolua.cast(var_5_7:getChildByTag(iter_5_1), "CCNode")

			var_5_8:setVisible(false)

			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(0.7)
			var_5_9:setNeedTip(true)

			arg_3_0.heroItems[iter_5_1] = var_5_9

			var_5_7:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)
		end

		arg_3_0.nodeDefen = tolua.cast(arg_3_0.layer:getChildByTag(8), "CCNode")

		for iter_5_2 = 1, 4 do
			arg_3_0.nodeAdd[iter_5_2] = tolua.cast(arg_3_0.nodeDefen:getChildByTag(iter_5_2), "CCNode")
			arg_3_0.spriteAdd[iter_5_2] = tolua.cast(arg_3_0.nodeAdd[iter_5_2]:getChildByTag(6), "CCSprite")
			arg_3_0.lbAdd[iter_5_2] = tolua.cast(arg_3_0.nodeAdd[iter_5_2]:getChildByTag(1), "CCLabelTTF")
		end

		arg_3_0.nodeRepair = tolua.cast(arg_3_0.nodeDefen:getChildByTag(11), "CCNode")
		arg_3_0.lbRepairFoodDummy = tolua.cast(arg_3_0.nodeRepair:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbRepairFood = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbRepairFoodDummy, arg_3_0.lbRepairFood)
		arg_3_0.lbRepairFood:setScale(0.6)

		arg_3_0.btnRepair = tolua.cast(arg_3_0.nodeRepair:getChildByTag(12), "CCControlButton")

		for iter_5_3 = 1, 3 do
			local var_5_10 = tolua.cast(arg_3_0.nodeRepair:getChildByTag(iter_5_3), "CCNode")

			var_5_10:setVisible(false)

			local var_5_11 = createItem()

			var_5_11:setPosition(var_5_10:getPosition())
			var_5_11:setScale(0.55)
			var_5_11:setNeedTip(true)

			arg_3_0.repairItems[iter_5_3] = var_5_11

			arg_3_0.nodeRepair:addChild(var_5_11)
			var_5_10:removeFromParentAndCleanup(true)
		end

		arg_3_0.nodeSSRepair = tolua.cast(arg_3_0.nodeDefen:getChildByTag(12), "CCNode")
		arg_3_0.lbSSRepairFoodDummy = tolua.cast(arg_3_0.nodeSSRepair:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbSSRepairFood = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbSSRepairFoodDummy, arg_3_0.lbSSRepairFood)
		arg_3_0.lbSSRepairFood:setScale(0.6)

		arg_3_0.btnSSRepair = tolua.cast(arg_3_0.nodeSSRepair:getChildByTag(12), "CCControlButton")

		for iter_5_4 = 1, 3 do
			local var_5_12 = tolua.cast(arg_3_0.nodeSSRepair:getChildByTag(iter_5_4), "CCNode")

			var_5_12:setVisible(false)

			local var_5_13 = createItem()

			var_5_13:setPosition(var_5_12:getPosition())
			var_5_13:setScale(0.55)
			var_5_13:setNeedTip(true)

			arg_3_0.ssRepairItems[iter_5_4] = var_5_13

			arg_3_0.nodeSSRepair:addChild(var_5_13)
			var_5_12:removeFromParentAndCleanup(true)
		end

		arg_3_0.lbFenPeiNum = tolua.cast(arg_3_0.nodeDefen:getChildByTag(13), "CCLabelTTF")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRepair:addHandleOfControlEvent(function()
			arg_3_0:onRepair()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSSRepair:addHandleOfControlEvent(function()
			arg_3_0:onSSRepair()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_LegionWarDailyRepair)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionWarFight_Ack)
end

function var_0_0.refresh(arg_14_0, arg_14_1)
	arg_14_0.nodeId = arg_14_1

	arg_14_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_15_0)
	local var_15_0

	if zbUtil:isValidTable(g_Self.kLegionHandler.legionWarNodeList) == true then
		for iter_15_0, iter_15_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
			if arg_15_0.nodeId == iter_15_1.NodeId then
				var_15_0 = iter_15_1
			end
		end
	end

	local var_15_1 = g_Self.kLegionHandler.legionWarBaseInfo

	arg_15_0.warNode = var_15_0

	if arg_15_0.warNode == nil then
		arg_15_0.nodeFight:setVisible(false)
		arg_15_0.nodeDefen:setVisible(false)

		return
	end

	if var_15_0.Legion.LegionId == g_GameData.LegionInfo.LegionId then
		arg_15_0.nodeFight:setVisible(false)
		arg_15_0.nodeDefen:setVisible(true)
		arg_15_0:refreshSelf(var_15_0, var_15_1)
	else
		arg_15_0.nodeFight:setVisible(true)
		arg_15_0.nodeDefen:setVisible(false)
		arg_15_0:refreshOther(var_15_0, var_15_1)
	end

	local var_15_2 = tonumber(string.format("%.2f", 100 * (var_15_0.LeftHp / var_15_0.HpMax)))
	local var_15_3 = math.min(var_15_2, 100)

	arg_15_0.spriteBar:setPercentage(var_15_3)
	arg_15_0.lbHpPoint:setString(var_15_3 .. ";")

	if var_15_0.Legion.LegionId > 0 then
		arg_15_0.lbLegionName:setString(var_15_0.Legion.LegionName)
		zbLegionHelp:setLegionLvTexture(arg_15_0.legionlv, var_15_0.Legion.Level)
		arg_15_0.legionlv:setVisible(true)
	else
		arg_15_0.lbLegionName:setString(a2u("\xBEݵ\xE3\xCA\xD8\xCE\xC0"))
		arg_15_0.legionlv:setVisible(false)
	end

	local var_15_4 = zbWorldNodeTable:getRecord(var_15_0.NodeId)

	if var_15_4 then
		arg_15_0.lbTitle:setString(var_15_4.name)
		arg_15_0.lbDesc:setString(var_15_4.desc)
		arg_15_0.lbname:setString(var_15_4.name)

		local var_15_5 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_15_4.texPath)

		if var_15_5 then
			arg_15_0.spriteHead:initWithSpriteFrame(var_15_5)
		end
	end
end

function var_0_0.refreshSelf(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = zbWorldNodeTable:getRecord(arg_16_1.NodeId)

	if var_16_0 == nil then
		arg_16_0.nodeFight:setVisible(false)
		arg_16_0.nodeDefen:setVisible(false)

		return
	end

	local var_16_1 = 1

	for iter_16_0, iter_16_1 in pairs(zbWorldNodeTable.records) do
		if var_16_0.areaId == iter_16_1.areaId and EWorldNodeType.ResNode == iter_16_1.nodeType then
			local var_16_2 = zbIconHelper:getAwardIconPath(iter_16_1.resOut[1], iter_16_1.resOut[2])

			arg_16_0.spriteAdd[var_16_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_16_2))
			arg_16_0.lbAdd[var_16_1]:setString(a2u(iter_16_1.name) .. a2u(" \xB5\xC0\xBE߲\xFA\xB3\xF6+") .. iter_16_1.addRatio * 100 .. "%")

			var_16_1 = var_16_1 + 1
		end

		if var_16_0.areaId == iter_16_1.areaId and EWorldNodeType.TaskNode == iter_16_1.nodeType then
			local var_16_3 = zbIconHelper:getAwardIconPath(iter_16_1.resOut[1], iter_16_1.resOut[2])

			arg_16_0.lbAdd[4]:setString(a2u(iter_16_1.name) .. a2u(" ս\xC1\xA6\xD0\xE8\xC7\xF3-") .. iter_16_1.decreaseFight * 100 .. "%")

			local var_16_4 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(iter_16_1.texPath)

			if var_16_4 then
				arg_16_0.spriteAdd[4]:initWithSpriteFrame(var_16_4)
			end
		end
	end

	arg_16_0.lbFenPeiNum:setString(a2u("(\xD0޸\xB4\xB4\xCE\xCA\xFD\xA3\xBA") .. arg_16_2.DailyRepairMax - arg_16_2.DailyRepairNum .. "/" .. arg_16_2.DailyRepairMax .. ")")
	arg_16_0.lbRepairFood:setString(g_DataConfig.m_kWarBaseCfg.foodRepairCost)
	arg_16_0.lbSSRepairFood:setString(g_DataConfig.m_kWarBaseCfg.diamondRepairCost)

	for iter_16_2, iter_16_3 in pairs(arg_16_0.repairItems) do
		iter_16_3:setVisible(false)
	end

	for iter_16_4, iter_16_5 in pairs(arg_16_0.ssRepairItems) do
		iter_16_5:setVisible(false)
	end

	local var_16_5 = zbWarNodeTable:getRecord(arg_16_1.NodeId)

	if zbUtil:isValidTable(var_16_5) then
		local var_16_6 = arg_16_0.repairItems[1]

		if var_16_6 ~= nil then
			var_16_6:refreshAward(ECommonAwardType.Legion, 0, g_DataConfig.m_kWarBaseCfg.foodRepairDonate, false, true)
			var_16_6:setVisible(true)
		end

		local var_16_7 = 2

		for iter_16_6, iter_16_7 in pairs(var_16_5.foodRepairAwardList) do
			local var_16_8 = arg_16_0.repairItems[var_16_7]

			if var_16_8 ~= nil then
				var_16_8:refreshAward(iter_16_7.type, iter_16_7.id, iter_16_7.count, false, true)
				var_16_8:setVisible(true)
			end

			var_16_7 = var_16_7 + 1
		end

		local var_16_9 = arg_16_0.ssRepairItems[1]

		if var_16_9 ~= nil then
			var_16_9:refreshAward(ECommonAwardType.Legion, 0, g_DataConfig.m_kWarBaseCfg.diamondRepairDonate, false, true)
			var_16_9:setVisible(true)
		end

		local var_16_10 = 2

		for iter_16_8, iter_16_9 in pairs(var_16_5.diamondRepairAwardList) do
			local var_16_11 = arg_16_0.ssRepairItems[var_16_10]

			if var_16_11 ~= nil then
				var_16_11:refreshAward(iter_16_9.type, iter_16_9.id, iter_16_9.count, false, true)
				var_16_11:setVisible(true)
			end

			var_16_10 = var_16_10 + 1
		end
	end
end

function var_0_0.refreshOther(arg_17_0, arg_17_1, arg_17_2)
	if zbWorldNodeTable:getRecord(arg_17_1.NodeId) == nil then
		arg_17_0.nodeFight:setVisible(false)
		arg_17_0.nodeDefen:setVisible(false)

		return
	end

	arg_17_0.formaList = {}
	arg_17_0.formaList.HeroList = {}
	arg_17_0.formaList.PlayerId = 0
	arg_17_0.formaList.NpcId = 0

	if zbUtil:isValidTable(g_Self.kLegionHandler.DefendFormation) then
		for iter_17_0 = 1, 5 do
			arg_17_0.heroItems[iter_17_0]:setVisible(false)
		end

		local var_17_0 = g_Self.kLegionHandler.DefendFormation.HeroList
		local var_17_1 = 1

		for iter_17_1, iter_17_2 in pairs(var_17_0) do
			if var_17_1 <= 5 then
				arg_17_0.heroItems[var_17_1]:refreshHero(iter_17_2)
				arg_17_0.heroItems[var_17_1]:setVisible(true)
			end

			var_17_1 = var_17_1 + 1
		end

		arg_17_0.lbPlayFV:setString(g_Self.kLegionHandler.DefendFormation.PlayerBaseInfo.FV)
		arg_17_0.lbPlayLevel:setString(g_Self.kLegionHandler.DefendFormation.PlayerBaseInfo.Level)

		local var_17_2 = zbIconHelper:getPlayerHeadIconPath(g_Self.kLegionHandler.DefendFormation.PlayerBaseInfo.HeadId)

		arg_17_0.playIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_17_2))
		arg_17_0.lbPlayName:setString(g_Self.kLegionHandler.DefendFormation.PlayerBaseInfo.RoleName)

		arg_17_0.formaList.HeroList = var_17_0
		arg_17_0.formaList.PlayerId = g_Self.kLegionHandler.DefendFormation.PlayerBaseInfo.PlayerId

		arg_17_0.spriteLv:setVisible(true)
		arg_17_0.spriteFV:setVisible(true)

		g_Self.kLegionHandler.DefendFormation = nil
	else
		local var_17_3 = zbWarNpcTable:getRecord(g_Self.kLegionHandler.NpcId)

		for iter_17_3 = 1, 5 do
			arg_17_0.heroItems[iter_17_3]:setVisible(false)
		end

		if var_17_3 then
			local var_17_4 = var_17_3.heroList
			local var_17_5 = 1

			for iter_17_4, iter_17_5 in pairs(var_17_4) do
				if var_17_5 <= 5 then
					local var_17_6 = {}

					arg_17_0.heroItems[var_17_5]:refreshNpc(iter_17_5, iter_17_5.level)
					arg_17_0.heroItems[var_17_5]:setVisible(true)

					var_17_6.TemplateId = iter_17_5.templateId
					var_17_6.Index = iter_17_5.formationIndex

					table.insert(arg_17_0.formaList.HeroList, var_17_6)
				end

				var_17_5 = var_17_5 + 1
			end

			local var_17_7 = zbIconHelper:getPlayerHeadIconPath(var_17_4[1].templateId)

			arg_17_0.playIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_17_7))
		end

		arg_17_0.lbPlayName:setString(a2u("\xBEݵ\xE3\xCA\xD8\xCE\xC0"))

		arg_17_0.formaList.NpcId = g_Self.kLegionHandler.NpcId

		arg_17_0.spriteLv:setVisible(false)
		arg_17_0.spriteFV:setVisible(false)
	end

	for iter_17_6, iter_17_7 in pairs(arg_17_0.awardItems) do
		iter_17_7:setVisible(false)
	end

	local var_17_8 = zbWarNodeTable:getRecord(arg_17_1.NodeId)

	if zbUtil:isValidTable(var_17_8) then
		local var_17_9 = arg_17_0.awardItems[1]

		if var_17_9 ~= nil then
			var_17_9:refreshAward(ECommonAwardType.Legion, 0, g_DataConfig.m_kWarBaseCfg.iDonate, false, true)
			var_17_9:setVisible(true)
		end

		local var_17_10 = 2

		for iter_17_8, iter_17_9 in pairs(var_17_8.iWinAwardList) do
			local var_17_11 = arg_17_0.awardItems[var_17_10]

			if var_17_11 ~= nil then
				var_17_11:refreshAward(iter_17_9.type, iter_17_9.id, iter_17_9.count, false, true)
				var_17_11:setVisible(true)
			end

			var_17_10 = var_17_10 + 1
		end
	end

	arg_17_0.lbNeedFood:setString(g_DataConfig.m_kWarBaseCfg.iCostFood)
	arg_17_0.lbCommTitle:setString(a2u("\xBD\xF8\xB9\xA5\xB4\xCE\xCA\xFD\xA3\xBA"))
	arg_17_0.lbCommGetTitle:setString(a2u("ʤ\xC0\xFB\xCA\xD5\xD2棺"))
	arg_17_0.lbCommCount:setString(arg_17_2.DailyCombatMax - arg_17_2.DailyCombatNum .. "/" .. arg_17_2.DailyCombatMax)
end

function var_0_0.onFight(arg_18_0)
	local var_18_0 = g_Self.kLegionHandler.legionWarBaseInfo

	if var_18_0.DailyCombatNum >= var_18_0.DailyCombatMax then
		g_Bubble:bubbleInfo(a2u("\xD2Ѵ﹥\xBB\xF7\xB4\xCE\xCA\xFD\xC9\xCF\xCFޡ\xA3"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, g_DataConfig.m_kWarBaseCfg.iCostFood) == false then
		g_Bubble:bubbleInfo(a2u("è\xB7\xB9\xB2\xBB\xD7㡣"))

		return
	end

	local function var_18_1()
		arg_18_0:hide()

		if g_MainScene.wndMain then
			g_MainScene.wndMain:hide()
		end

		g_MainScene:showEmbattleLegionWar(arg_18_0.warNode, arg_18_0.formaList)
	end

	if arg_18_0.warNode.DailyLeftHp <= 0 then
		local var_18_2 = a2u("\xBD\xF1\xC8մ˾ݵ\xE3\xC4;\xC3\xC6ƻ\xB5\xD2Ѵ\xEF\xC9\xCF\xCFޣ\xAC\xCAǷ\xF1ȷ\xB6\xA8\xBC\xCC\xD0\xF8\xC6ƻ\xB5\xA3\xBF")

		g_MessageBox:showYesNo(var_18_2, var_18_1)
	else
		var_18_1()
	end
end

function var_0_0.onRepair(arg_20_0)
	local var_20_0 = g_Self.kLegionHandler.legionWarBaseInfo

	if var_20_0.DailyRepairNum >= var_20_0.DailyRepairMax then
		g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xD0޸\xB4\xB4\xCE\xCA\xFD\xC9\xCF\xCFޡ\xA3"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, g_DataConfig.m_kWarBaseCfg.foodRepairCost) == false then
		g_Bubble:bubbleInfo(a2u("è\xB7\xB9\xB2\xBB\xD7㡣"))

		return
	end

	g_WsMsgHandler:WS_LegionWar_DailyRepair_Req(arg_20_0.warNode.NodeId, EMoneyType.Food)
end

function var_0_0.onSSRepair(arg_21_0)
	local var_21_0 = g_Self.kLegionHandler.legionWarBaseInfo

	if var_21_0.DailyRepairNum >= var_21_0.DailyRepairMax then
		g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xD0޸\xB4\xB4\xCE\xCA\xFD\xC9\xCF\xCFޡ\xA3"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, g_DataConfig.m_kWarBaseCfg.diamondRepairCost) == false then
		g_Bubble:bubbleInfo(a2u("è\xB7\xB9\xB2\xBB\xD7㡣"))

		return
	end

	g_WsMsgHandler:WS_LegionWar_DailyRepair_Req(arg_21_0.warNode.NodeId, EMoneyType.Diamond)
end

function var_0_0.onTouchTest(arg_22_0)
	local var_22_0 = arg_22_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_22_0.layer, var_22_0.x, var_22_0.y) == false then
		arg_22_0:hide()
	end
end
