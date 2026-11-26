require("gamelogic.zbItem")

local var_0_0 = class("zbLegionWarEliteSetWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionWarEliteSetWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
		arg_3_0.spriteElite = {}
		arg_3_0.btnElite = {}
		arg_3_0.btnBox = {}
		arg_3_0.nodeId = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_eliteset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteLeader = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")

		for iter_5_0 = 1, 5 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")

			arg_3_0.spriteElite[iter_5_0] = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
			arg_3_0.btnElite[iter_5_0] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

			arg_3_0.btnElite[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onElite(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		for iter_5_1 = 1, 3 do
			arg_3_0.btnBox[iter_5_1] = tolua.cast(var_5_2:getChildByTag(iter_5_1 + 10), "CCControlButton")

			arg_3_0.btnBox[iter_5_1]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_1)
			end, CCControlEventTouchDown)
			arg_3_0.btnBox[iter_5_1]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_1)
			end, CCControlEventTouchEnd)
		end

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeBox = tolua.cast(var_5_1:getChildByTag(2), "CCLayer")

		for iter_5_2 = 1, 3 do
			local var_5_4 = tolua.cast(arg_3_0.nodeBox:getChildByTag(iter_5_2), "CCNode")

			var_5_4:setVisible(false)

			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())

			arg_3_0.awardItems[iter_5_2] = var_5_5

			arg_3_0.nodeBox:addChild(var_5_5)
			var_5_4:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.awardItems[2]:getPositionX()

		arg_3_0.nodeBox:setVisible(false)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionMemberDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_LegionWarNodeInfo)
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	if arg_12_1 ~= nil then
		arg_12_0.nodeId = arg_12_1
	end

	if g_Self.kLegionHandler.legionDetail and g_Self.kLegionHandler.legionDetail.ManagerInfo then
		local var_12_0 = g_Self.kLegionHandler:getMemberData(g_Self.kLegionHandler.legionDetail.ManagerInfo.LeaderId)

		if var_12_0 then
			local var_12_1 = zbIconHelper:getPlayerHeadIconPath(var_12_0.PlayerBaseInfo.HeadId)

			arg_12_0.spriteLeader:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_1))
		end
	end

	arg_12_0.eliteList = {}

	for iter_12_0 = 1, 5 do
		arg_12_0.eliteList[iter_12_0] = 0
	end

	local var_12_2 = g_Self.kLegionHandler:getNodeInfobyId(arg_12_0.nodeId)

	if var_12_2 ~= nil then
		local var_12_3 = 1

		for iter_12_1, iter_12_2 in pairs(var_12_2.EliteList) do
			arg_12_0.eliteList[var_12_3] = iter_12_2
			var_12_3 = var_12_3 + 1
		end
	end

	arg_12_0:refreshEliteList()
end

function var_0_0.refreshEliteList(arg_13_0)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_0.eliteList) do
		local var_13_1 = g_Self.kLegionHandler:getMemberData(iter_13_1)

		if var_13_1 and var_13_1.PlayerBaseInfo then
			local var_13_2 = zbIconHelper:getPlayerHeadIconPath(var_13_1.PlayerBaseInfo.HeadId)

			arg_13_0.spriteElite[var_13_0]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_2))
			arg_13_0.spriteElite[var_13_0]:setVisible(true)
		else
			arg_13_0.spriteElite[var_13_0]:setVisible(false)
		end

		var_13_0 = var_13_0 + 1
	end
end

function var_0_0.onElite(arg_14_0, arg_14_1)
	if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) ~= ELegionOffice.Leader then
		g_Bubble:bubbleInfo(a2u("\xB7ǻ\xE1\xB9ݳ\xA4\xBD\xF6\xBFɲ鿴"))

		return
	end

	if arg_14_0.eliteList[arg_14_1] == 0 then
		g_MainScene:showLegionWarHeroWnd(ELgionWarHero.E_EliteSet, arg_14_1):setPrevWnd(arg_14_0)

		return
	end

	arg_14_0.eliteList[arg_14_1] = 0

	g_WsMsgHandler:WS_LegionWar_EliteSet_Req(arg_14_0.nodeId, arg_14_0.eliteList)
end

function var_0_0.onTouchDown(arg_15_0, arg_15_1)
	local var_15_0 = zbWarNodeTable:getRecord(arg_15_0.nodeId)

	if var_15_0 == nil then
		return
	end

	local var_15_1 = {}

	if arg_15_1 == 1 then
		var_15_1 = var_15_0.awardList1
	elseif arg_15_1 == 2 then
		var_15_1 = var_15_0.awardList2
	elseif arg_15_1 == 3 then
		var_15_1 = var_15_0.awardList3
	end

	for iter_15_0 = 1, 3 do
		arg_15_0.awardItems[iter_15_0]:setVisible(false)
	end

	local var_15_2 = 1

	for iter_15_1, iter_15_2 in pairs(var_15_1) do
		arg_15_0.awardItems[var_15_2]:refreshAward(iter_15_2.type, iter_15_2.id, iter_15_2.count, false)
		arg_15_0.awardItems[var_15_2]:setVisible(true)

		var_15_2 = var_15_2 + 1
	end

	zbUIEffect:centerStar(arg_15_0.awardItems, arg_15_0.centerPositionX)
	arg_15_0.nodeBox:setPositionY(arg_15_0.btnBox[arg_15_1]:getPositionY() + 50)
	arg_15_0.nodeBox:setVisible(true)
end

function var_0_0.onTouchEnd(arg_16_0, arg_16_1)
	arg_16_0.nodeBox:setVisible(false)
end

function var_0_0.onClose(arg_17_0)
	local var_17_0 = g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId())

	arg_17_0:hide()
end
