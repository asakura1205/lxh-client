require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbLegionWarFightWnd", zbBaseWnd)

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

function createLegionWarFightWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroList = {}
		arg_3_0.nodeFight = {}
		arg_3_0.lbNoPlay = {}
		arg_3_0.playIcon = {}
		arg_3_0.lbPlayLevel = {}
		arg_3_0.lbPlayName = {}
		arg_3_0.lbPlayFV = {}
		arg_3_0.spriteLv = {}
		arg_3_0.spriteFV = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_fight.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
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
		arg_3_0.spriteBarBg = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCSprite")
		arg_3_0.lbHpDummy = tolua.cast(arg_3_0.layer:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbHp = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbHpDummy, arg_3_0.lbHp)
		arg_3_0.lbHp:setScale(0.48)

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

		arg_3_0.spriteBar = var_5_3(arg_3_0.spriteBarBg, "image/legionwar/legionwar_progress.png")

		for iter_5_0 = 1, 3 do
			arg_3_0.nodeFight[iter_5_0] = tolua.cast(arg_3_0.layer:getChildByTag(iter_5_0 + 10), "CCNode")
			arg_3_0.playIcon[iter_5_0] = tolua.cast(arg_3_0.nodeFight[iter_5_0]:getChildByTag(1), "CCSprite")
			arg_3_0.spriteLv[iter_5_0] = tolua.cast(arg_3_0.nodeFight[iter_5_0]:getChildByTag(2), "CCSprite")

			local var_5_4 = tolua.cast(arg_3_0.spriteLv[iter_5_0]:getChildByTag(1001), "CCLabelTTF")

			arg_3_0.lbPlayLevel[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbPlayLevel[iter_5_0])
			arg_3_0.lbPlayLevel[iter_5_0]:setScale(0.6)

			arg_3_0.lbPlayName[iter_5_0] = tolua.cast(arg_3_0.nodeFight[iter_5_0]:getChildByTag(3), "CCLabelTTF")
			arg_3_0.spriteFV[iter_5_0] = tolua.cast(arg_3_0.nodeFight[iter_5_0]:getChildByTag(4), "CCSprite")

			local var_5_5 = tolua.cast(arg_3_0.spriteFV[iter_5_0]:getChildByTag(1001), "CCLabelTTF")

			arg_3_0.lbPlayFV[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbPlayFV[iter_5_0])
			arg_3_0.lbPlayFV[iter_5_0]:setScale(0.6)

			local var_5_6 = tolua.cast(arg_3_0.nodeFight[iter_5_0]:getChildByTag(5), "CCNode")
			local var_5_7 = {}

			for iter_5_1 = 1, 5 do
				local var_5_8 = tolua.cast(var_5_6:getChildByTag(iter_5_1), "CCNode")

				var_5_8:setVisible(false)

				local var_5_9 = createItem()

				var_5_9:setPosition(var_5_8:getPosition())
				var_5_9:setScale(0.7)

				var_5_7[iter_5_1] = var_5_9

				var_5_6:addChild(var_5_9)
				var_5_8:removeFromParentAndCleanup(true)
			end

			arg_3_0.heroList[iter_5_0] = var_5_7
			arg_3_0.lbNoPlay[iter_5_0] = tolua.cast(arg_3_0.layer:getChildByTag(iter_5_0 + 20), "CCLabelTTF")
		end

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(20), "CCControlButton")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_LegionWarFight)
end

function var_0_0.refresh(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.warNodeInfo = arg_11_1
	arg_11_0.stageIndex = arg_11_2
	arg_11_0.type = arg_11_3

	arg_11_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_12_0)
	for iter_12_0 = 1, 3 do
		arg_12_0.nodeFight[iter_12_0]:setVisible(false)

		for iter_12_1, iter_12_2 in pairs(arg_12_0.heroList[iter_12_0]) do
			iter_12_2:setVisible(false)
		end

		arg_12_0.lbNoPlay[iter_12_0]:setVisible(true)
	end

	arg_12_0.formaList = {}
	arg_12_0.formaList.HeroList = {}
	arg_12_0.formaList.PlayerId = 0
	arg_12_0.formaList.NpcId = 0

	local var_12_0 = zbWarNodeTable:getRecord(arg_12_0.warNodeInfo.NodeId)

	if var_12_0 == nil then
		return
	end

	local var_12_1 = var_12_0.buildNode[arg_12_0.stageIndex]

	if var_12_1 == nil then
		return
	end

	arg_12_0.lbTitle:setString(var_12_1.buildName)
	arg_12_0.lbDesc:setString(var_12_1.buildDesc)

	local var_12_2

	for iter_12_3, iter_12_4 in pairs(arg_12_0.warNodeInfo.BuildList) do
		if iter_12_4.BuildId == arg_12_0.stageIndex then
			var_12_2 = iter_12_4

			break
		end
	end

	local var_12_3 = tonumber(string.format("%.2f", 100 * (var_12_2.LeftHp / var_12_2.HpMax)))
	local var_12_4 = math.min(var_12_3, 100)

	arg_12_0.spriteBar:setPercentage(var_12_4)
	arg_12_0.lbHp:setString(var_12_4 .. ";")

	if zbUtil:isValidTable(g_Self.kLegionHandler.DefendList) == false then
		local var_12_5 = zbWarNpcTable:getRecord(var_12_1.buildNpc)

		if var_12_5 then
			arg_12_0.lbNoPlay[1]:setVisible(false)
			arg_12_0.nodeFight[1]:setVisible(true)

			local var_12_6 = var_12_5.heroList
			local var_12_7 = 1
			local var_12_8 = arg_12_0.heroList[1]

			for iter_12_5, iter_12_6 in pairs(var_12_6) do
				if var_12_7 <= 5 then
					local var_12_9 = {}

					var_12_8[var_12_7]:refreshNpc(iter_12_6, iter_12_6.level)
					var_12_8[var_12_7]:setVisible(true)

					var_12_9.TemplateId = iter_12_6.templateId
					var_12_9.Index = iter_12_6.formationIndex

					table.insert(arg_12_0.formaList.HeroList, var_12_9)
				end

				var_12_7 = var_12_7 + 1
			end

			local var_12_10 = zbIconHelper:getPlayerHeadIconPath(var_12_6[1].templateId)

			arg_12_0.playIcon[1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_10))
			arg_12_0.lbPlayName[1]:setString(a2u("\xBEݵ\xE3\xCA\xD8\xCE\xC0"))
			arg_12_0.spriteLv[1]:setVisible(false)
			arg_12_0.spriteFV[1]:setVisible(false)
		end

		arg_12_0.formaList.NpcId = var_12_1.buildNpc
	else
		local var_12_11 = 1

		for iter_12_7, iter_12_8 in pairs(var_12_2.DefendList) do
			for iter_12_9, iter_12_10 in pairs(g_Self.kLegionHandler.DefendList) do
				if iter_12_10 and iter_12_10.PlayerBaseInfo.PlayerId == iter_12_8 then
					arg_12_0.lbNoPlay[var_12_11]:setVisible(false)
					arg_12_0.nodeFight[var_12_11]:setVisible(true)

					local var_12_12 = arg_12_0.heroList[var_12_11]
					local var_12_13 = 1

					for iter_12_11, iter_12_12 in pairs(iter_12_10.HeroList) do
						if var_12_13 <= 5 then
							local var_12_14 = {}

							var_12_12[var_12_13]:refreshHero(iter_12_12)
							var_12_12[var_12_13]:setVisible(true)

							var_12_14.TemplateId = iter_12_12.templateId
							var_12_14.Index = iter_12_12.formationIndex
						end

						var_12_13 = var_12_13 + 1
					end

					arg_12_0.lbPlayLevel[var_12_11]:setString(iter_12_10.PlayerBaseInfo.Level)
					arg_12_0.lbPlayFV[var_12_11]:setString(iter_12_10.PlayerBaseInfo.FV)
					arg_12_0.lbPlayName[var_12_11]:setString(iter_12_10.PlayerBaseInfo.RoleName)

					arg_12_0.formaList.HeroList = iter_12_10.HeroList
					arg_12_0.formaList.PlayerId = iter_12_8

					arg_12_0.spriteLv[var_12_11]:setVisible(true)
					arg_12_0.spriteFV[var_12_11]:setVisible(true)

					var_12_11 = var_12_11 + 1
				end
			end
		end

		g_Self.kLegionHandler.DefendList = nil
	end
end

function var_0_0.onFight(arg_13_0, arg_13_1)
	arg_13_0:hide()

	if g_MainScene.wndMain then
		g_MainScene.wndMain:hide()
	end

	if g_MainScene.wndLegionWarPosition then
		g_MainScene.wndLegionWarPosition:hide()
	end

	g_MainScene:showEmbattleLegionWar(arg_13_0.warNodeInfo, arg_13_0.formaList, arg_13_0.stageIndex)
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layer, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
