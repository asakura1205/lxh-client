require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

zbLegionLuckyCatWnd = class("zbLegionLuckyCatWnd", zbBaseWnd)
zbLegionLuckyCatWnd.__index = zbLegionLuckyCatWnd

local var_0_0 = 138

function zbLegionLuckyCatWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionLuckyCatWnd)

	return arg_1_0
end

function createLegionLuckyCatWnd()
	local var_2_0 = zbLegionLuckyCatWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbLegionLuckyCatWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.initNum = {
			6,
			6,
			6,
			6,
			6
		}
		arg_3_0.num = {
			arg_3_0:calHeight(arg_3_0.initNum[1]),
			arg_3_0:calHeight(arg_3_0.initNum[2]),
			arg_3_0:calHeight(arg_3_0.initNum[3]),
			arg_3_0:calHeight(arg_3_0.initNum[4]),
			arg_3_0:calHeight(arg_3_0.initNum[5])
		}
		arg_3_0.spriteItem = {}
		arg_3_0.playerNum = 0
		arg_3_0.ScrollView = {}
		arg_3_0.luckCat = {}
		arg_3_0.initHeroNum = {
			6,
			6,
			6,
			6,
			6
		}
		arg_3_0.items = {}
		arg_3_0.heroItem = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionGame_LuckCat.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0 + 10), "CCNode")

			var_5_3:setVisible(true)

			arg_3_0.luckCat[iter_5_0] = tolua.cast(var_5_3:getChildByTag(1), "CCLayerColor")

			local var_5_4 = tolua.cast(arg_3_0.luckCat[iter_5_0]:getChildByTag(1), "CCSprite")
			local var_5_5, var_5_6 = zbIconHelper:getAwardIconPath(ECommonAwardType.HeroFrag, g_DataConfig.m_kLegionBaseCfg.rolling.heroTemplateId)

			var_5_4:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_5))
			arg_3_0.luckCat[iter_5_0]:removeFromParentAndCleanup(false)

			local var_5_7 = tolua.cast(var_5_3:getChildByTag(2), "CCLayerColor")

			var_5_7:setVisible(false)

			arg_3_0.ScrollView[iter_5_0] = CCScrollView:create(var_5_7:getContentSize())

			arg_3_0.ScrollView[iter_5_0]:setDirection(kCCScrollViewDirectionVertical)
			arg_3_0.ScrollView[iter_5_0]:setPosition(var_5_7:getPosition())
			arg_3_0.ScrollView[iter_5_0]:setAnchorPoint(ccp(0, 0))
			arg_3_0.ScrollView[iter_5_0]:setBounceable(false)
			arg_3_0.ScrollView[iter_5_0]:setContainer(arg_3_0.luckCat[iter_5_0])
			arg_3_0.ScrollView[iter_5_0]:setTouchEnabled(false)
			var_5_3:addChild(arg_3_0.ScrollView[iter_5_0])
		end

		arg_3_0.nodeAward = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		for iter_5_1 = 1, 4 do
			local var_5_8 = tolua.cast(arg_3_0.nodeAward:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(0.7)
			arg_3_0.nodeAward:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)

			arg_3_0.items[iter_5_1] = var_5_9
		end

		arg_3_0.lbHint = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_10 = zbHeroTable:getRecord(g_DataConfig.m_kLegionBaseCfg.rolling.heroTemplateId)

		if var_5_10 then
			arg_3_0.lbHint:setString(a2u("\xBD\xB1\xC0\xF8:") .. var_5_10.name .. a2u("\xCB\xE9Ƭ\xA3\xAC\xBE\xAD\xD1\xE9ҩˮ"))
		end

		arg_3_0.nodeStart = tolua.cast(var_5_2:getChildByTag(32), "CCNode")
		arg_3_0.btnStart = tolua.cast(arg_3_0.nodeStart:getChildByTag(1), "CCControlButton")

		local var_5_11 = tolua.cast(arg_3_0.nodeStart:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbStartNum = tolua.cast(arg_3_0.nodeStart:getChildByTag(3), "CCLabelTTF")
		arg_3_0.nodeContinue = tolua.cast(var_5_2:getChildByTag(33), "CCNode")
		arg_3_0.btnContinue = tolua.cast(arg_3_0.nodeContinue:getChildByTag(2), "CCControlButton")
		arg_3_0.btnEnd = tolua.cast(arg_3_0.nodeContinue:getChildByTag(1), "CCControlButton")
		arg_3_0.nodeFree = tolua.cast(arg_3_0.nodeContinue:getChildByTag(4), "CCNode")

		local var_5_12 = tolua.cast(arg_3_0.nodeFree:getChildByTag(1), "CCLabelTTF")

		arg_3_0.lbFreeNum = tolua.cast(arg_3_0.nodeFree:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeUnFree = tolua.cast(arg_3_0.nodeContinue:getChildByTag(3), "CCNode")

		local var_5_13 = tolua.cast(arg_3_0.nodeUnFree:getChildByTag(1), "CCLabelTTF")

		arg_3_0.lbUnFreeNum = tolua.cast(arg_3_0.nodeUnFree:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.btnTip = tolua.cast(var_5_2:getChildByTag(99), "CCControlButton")

		arg_3_0.btnStart:addHandleOfControlEvent(function()
			arg_3_0:onStart()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTip:addHandleOfControlEvent(function()
			arg_3_0:onTip()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnContinue:addHandleOfControlEvent(function()
			arg_3_0:onContinue()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnEnd:addHandleOfControlEvent(function()
			arg_3_0:onEnd()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:calNum()
	end, zbGameEvent.Event_LegionRollingOpenAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionLuckCatEnd)
end

local var_0_1 = false

function zbLegionLuckyCatWnd.refresh(arg_14_0)
	local var_14_0 = g_Self.kLegionHandler.legionDetail.Rolling

	if var_14_0 then
		local var_14_1 = zbHeroTable:getRecord(g_DataConfig.m_kLegionBaseCfg.rolling.heroTemplateId)
		local var_14_2 = 0

		for iter_14_0 = 1, 5 do
			arg_14_0.initHeroNum[iter_14_0] = var_14_0.LevelState[iter_14_0]

			if arg_14_0.initHeroNum[iter_14_0] == 1 then
				arg_14_0.initHeroNum[iter_14_0] = 8
			end

			if arg_14_0.initHeroNum[iter_14_0] == 7 then
				var_14_2 = var_14_2 + 1
			end

			arg_14_0.num[iter_14_0] = arg_14_0:calHeight(arg_14_0.initHeroNum[iter_14_0])

			arg_14_0.ScrollView[iter_14_0]:setContentOffset(ccp(0, arg_14_0.num[iter_14_0] - 1))
		end

		if var_14_0.State == 0 then
			arg_14_0.nodeAward:setVisible(false)
			arg_14_0.lbHint:setVisible(true)
			arg_14_0.nodeStart:setVisible(true)
			arg_14_0.nodeContinue:setVisible(false)
		else
			arg_14_0.nodeAward:setVisible(true)
			arg_14_0.lbHint:setVisible(false)
			arg_14_0.nodeStart:setVisible(false)
			arg_14_0.nodeContinue:setVisible(true)

			if var_14_2 >= 5 then
				arg_14_0.btnContinue:setEnabled(false)
				arg_14_0.btnContinue:setGray(true)
			else
				arg_14_0.btnContinue:setEnabled(true)
				arg_14_0.btnContinue:setGray(false)
			end
		end

		for iter_14_1 = 1, 4 do
			arg_14_0.items[iter_14_1]:setVisible(false)
		end

		for iter_14_2, iter_14_3 in pairs(g_DataConfig.m_kLegionBaseCfg.rolling.levelAward) do
			if iter_14_3.headCount == var_14_2 then
				for iter_14_4, iter_14_5 in pairs(iter_14_3.award) do
					if iter_14_4 <= 4 then
						arg_14_0.items[iter_14_4]:refreshAward(iter_14_5.awardType, iter_14_5.awardId, iter_14_5.awardCount, false)
						arg_14_0.items[iter_14_4]:setVisible(true)
					end
				end

				break
			end
		end

		local var_14_3 = ELegionTechType.Treasure
		local var_14_4 = zbLegionTechTable:getRecord(var_14_3)
		local var_14_5 = 0

		if var_14_4 then
			local var_14_6 = var_14_4.upgradeId
			local var_14_7 = zbLegionTechUpgradeTable:getlimitByIdAndLv(var_14_4.upgradeId, g_Self.kLegionHandler:getTechLevel(ELegionTechType.Treasure))

			arg_14_0.lbStartNum:setString(var_14_7 - var_14_0.OpenCount .. "/" .. var_14_7)
		end

		local var_14_8 = table.maxn(g_DataConfig.m_kLegionBaseCfg.rolling.costDiamond)
		local var_14_9 = var_14_0.ContinueCount - g_DataConfig.m_kLegionBaseCfg.rolling.freeNum
		local var_14_10 = g_DataConfig.m_kLegionBaseCfg.rolling.costDiamond[var_14_9 + 1]

		if var_14_8 <= var_14_9 then
			arg_14_0.nodeUnFree:setVisible(true)
			arg_14_0.nodeFree:setVisible(false)
			arg_14_0.lbUnFreeNum:setString(g_DataConfig.m_kLegionBaseCfg.rolling.costDiamond[var_14_8])
		elseif var_14_9 < 0 then
			arg_14_0.nodeFree:setVisible(true)
			arg_14_0.nodeUnFree:setVisible(false)
			arg_14_0.lbFreeNum:setString(g_DataConfig.m_kLegionBaseCfg.rolling.freeNum - var_14_0.ContinueCount .. "/" .. g_DataConfig.m_kLegionBaseCfg.rolling.freeNum)
		else
			arg_14_0.nodeUnFree:setVisible(true)
			arg_14_0.nodeFree:setVisible(false)
			arg_14_0.lbUnFreeNum:setString(g_DataConfig.m_kLegionBaseCfg.rolling.costDiamond[var_14_9 + 1])
		end
	end
end

function zbLegionLuckyCatWnd.onStart(arg_15_0)
	g_WsMsgHandler:WS_LegionGame_RollingOpen_Req()
end

function zbLegionLuckyCatWnd.onTip(arg_16_0)
	g_MainScene:showRuleWnd(RuleType_LegionGame)
end

local var_0_2 = {
	0,
	0,
	0,
	0,
	0
}
local var_0_3 = {
	-762,
	-762,
	-762,
	-762,
	-762
}
local var_0_4 = {
	0,
	0,
	0,
	0,
	0
}

function zbLegionLuckyCatWnd.calNum(arg_17_0)
	local var_17_0 = g_Self.kLegionHandler.legionDetail.Rolling

	for iter_17_0 = 1, 5 do
		arg_17_0.initNum[iter_17_0] = var_17_0.LevelState[iter_17_0]
		var_0_3[iter_17_0] = arg_17_0.num[iter_17_0]

		if arg_17_0.initNum[iter_17_0] == 1 then
			arg_17_0.initNum[iter_17_0] = 8
		end

		arg_17_0.num[iter_17_0] = arg_17_0:calHeight(arg_17_0.initNum[iter_17_0])
		var_0_2[iter_17_0] = 0
		var_0_4[iter_17_0] = 0
	end

	var_0_1 = true

	arg_17_0.btnStart:setEnabled(false)
	arg_17_0.btnContinue:setEnabled(false)
	arg_17_0.btnEnd:setEnabled(false)
end

function zbLegionLuckyCatWnd.onFrameUpdate(arg_18_0, arg_18_1)
	if var_0_1 == false then
		return
	end

	for iter_18_0 = 1, 5 do
		if var_0_4[iter_18_0] == 0 then
			if var_0_2[iter_18_0] < 8 - iter_18_0 then
				var_0_3[iter_18_0] = var_0_3[iter_18_0] + 36 * (arg_18_1 * 30) - iter_18_0
			else
				var_0_3[iter_18_0] = var_0_3[iter_18_0] + iter_18_0 + 7
			end

			if var_0_3[iter_18_0] >= -135 then
				var_0_2[iter_18_0] = var_0_2[iter_18_0] + 1
				var_0_3[iter_18_0] = -762
			end
		end

		if arg_18_0.initHeroNum[iter_18_0] ~= 7 then
			if var_0_2[iter_18_0] >= 8 - iter_18_0 and var_0_3[iter_18_0] >= arg_18_0.num[iter_18_0] then
				var_0_4[iter_18_0] = 1

				arg_18_0.ScrollView[iter_18_0]:setContentOffset(ccp(0, arg_18_0.num[iter_18_0] - 1))
			else
				arg_18_0.ScrollView[iter_18_0]:setContentOffset(ccp(0, var_0_3[iter_18_0] - 1))
			end
		else
			var_0_4[iter_18_0] = 1
		end
	end

	for iter_18_1 = 1, 5 do
		if var_0_4[iter_18_1] == 0 then
			return
		end
	end

	var_0_1 = false

	arg_18_0.btnStart:setEnabled(true)
	arg_18_0.btnContinue:setEnabled(true)
	arg_18_0.btnEnd:setEnabled(true)
	arg_18_0:refresh()
end

function zbLegionLuckyCatWnd.onContinue(arg_19_0)
	g_WsMsgHandler:WS_LegionGame_RollingContinue_Req()
end

function zbLegionLuckyCatWnd.onEnd(arg_20_0)
	g_WsMsgHandler:WS_LegionGame_RollingGain_Req()
end

function zbLegionLuckyCatWnd.calHeight(arg_21_0, arg_21_1)
	return -900 + 90 * arg_21_1
end
