require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionWarBalanceWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionWarBalanceWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.items = {}
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = createUIAnimation()

			var_6_0:refreshBone(arg_6_1)
			var_6_0:setPosition(arg_6_2)
			arg_6_0:addChild(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/legionwarBalance.ccbi", var_5_1, true, "")

		arg_3_0.layerDetail = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.nodeHead = tolua.cast(arg_3_0.layerDetail:getChildByTag(1), "CCNode")
		arg_3_0.spriteHeadIcon = tolua.cast(arg_3_0.nodeHead:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.nodeHead:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteBarBg = tolua.cast(arg_3_0.nodeHead:getChildByTag(3), "CCSprite")
		arg_3_0.lbPercent = tolua.cast(arg_3_0.nodeHead:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbHitStat = tolua.cast(arg_3_0.nodeHead:getChildByTag(5), "CCLabelTTF")

		local function var_5_3(arg_7_0, arg_7_1)
			local var_7_0 = CCSprite:create(arg_7_1)

			var_7_0:setAnchorPoint(ccp(0, 0))

			local var_7_1 = CCProgressTimer:create(var_7_0)

			var_7_1:setAnchorPoint(ccp(0, 0))
			var_7_1:setPercentage(0)
			var_7_1:setMidpoint(ccp(0, 1))
			var_7_1:setBarChangeRate(ccp(1, 0))
			var_7_1:setType(kCCProgressTimerTypeBar)
			var_7_1:retain()
			arg_7_0:addChild(var_7_1)

			return var_7_1
		end

		arg_3_0.spriteBar = var_5_3(arg_3_0.spriteBarBg, "image/balance/balance_progress_red.png")

		local var_5_4 = tolua.cast(arg_3_0.layerDetail:getChildByTag(2), "CCNode")

		for iter_5_0 = 1, 6 do
			local var_5_5 = tolua.cast(var_5_4:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_6 = createItem()

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_6:setScale(var_5_5:getScale())
			var_5_4:addChild(var_5_6)
			var_5_5:removeFromParentAndCleanup(true)

			arg_3_0.items[iter_5_0] = var_5_6
		end

		arg_3_0.lbHitSecting = tolua.cast(var_5_4:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbJiFen = tolua.cast(var_5_4:getChildByTag(12), "CCLabelTTF")
		arg_3_0.nodeAnimBottom = tolua.cast(arg_3_0.layerDetail:getChildByTag(11), "CCNode")
		arg_3_0.nodeTop = tolua.cast(arg_3_0.layerDetail:getChildByTag(12), "CCNode")
		arg_3_0.fxYunTopLeft = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zuoshangyun/zuoshangyun", ccp(0, 0))
		arg_3_0.fxYunTopRight = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/youshangyun/youshangyun", ccp(0, 0))
		arg_3_0.fxYunBottomLeft = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/zuoxiayun/zuoxiayun", ccp(0, 0))
		arg_3_0.fxYunBottomRight = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/youxiayun/youxiayun", ccp(0, 0))
		arg_3_0.fxWinStar = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zhandoujiesuan_shengli/zhandoujiesuan_shengli", ccp(0, 25))

		arg_3_0.fxYunTopLeft:setAnimation("animation", true)
		arg_3_0.fxYunTopRight:setAnimation("animation", true)
		arg_3_0.fxYunBottomLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomRight:setAnimation("animation", true)

		arg_3_0.btnReturn = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(31), "CCControlButton")

		arg_3_0.btnReturn:addHandleOfControlEvent(function()
			arg_3_0:onReturn()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_10_0)
	if g_MainScene.wndCombat then
		g_MainScene.wndCombat:hideUI()
		g_MainScene.wndCombat.layerScene:hideHeros()
	end
end

function var_0_0.refreshResultData(arg_11_0)
	arg_11_0.balanceAckData = g_CombatSystem.combatData.balanceAckData
	arg_11_0.warNodeInfo = nil

	for iter_11_0, iter_11_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
		if arg_11_0.balanceAckData.NodeId == iter_11_1.NodeId then
			arg_11_0.warNodeInfo = iter_11_1

			break
		end
	end

	if arg_11_0.warNodeInfo == nil then
		return
	end

	local var_11_0 = zbWarNodeTable:getRecord(arg_11_0.warNodeInfo.NodeId)

	if var_11_0 == nil then
		return
	end

	local var_11_1 = var_11_0.buildNode[arg_11_0.balanceAckData.BuildId]

	if var_11_1 == nil then
		return
	end

	arg_11_0.lbName:setString(var_11_1.buildName)

	arg_11_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_11_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/legionwar.plist")

	local var_11_2 = arg_11_0.spriteframeCache:spriteFrameByName(var_11_1.buildIcon)

	if var_11_2 then
		arg_11_0.spriteHeadIcon:initWithSpriteFrame(var_11_2)
	end

	arg_11_0.lbHitSecting:setString(arg_11_0.balanceAckData.DefendCount - (3 - arg_11_0.balanceAckData.Result) .. "/" .. arg_11_0.balanceAckData.DefendCount)
	arg_11_0.lbJiFen:setString(arg_11_0.balanceAckData.Score)
	arg_11_0.lbHitStat:setString(arg_11_0.balanceAckData.Score)

	local var_11_3

	for iter_11_2, iter_11_3 in pairs(arg_11_0.warNodeInfo.BuildList) do
		if iter_11_3.BuildId == arg_11_0.balanceAckData.BuildId then
			var_11_3 = iter_11_3

			break
		end
	end

	if var_11_3 == nil then
		return
	end

	local var_11_4 = tonumber(string.format("%.2f", 100 * (var_11_3.LeftHp / var_11_3.HpMax)))
	local var_11_5 = math.min(var_11_4, 100)

	arg_11_0.spriteBar:setPercentage(var_11_5)
	arg_11_0.lbPercent:setString(var_11_5 .. "%")

	for iter_11_4, iter_11_5 in pairs(arg_11_0.items) do
		iter_11_5:setVisible(false)
	end

	if zbUtil:isValidTable(g_CombatSystem.combatData.awardList) then
		local var_11_6 = 1

		for iter_11_6, iter_11_7 in pairs(g_CombatSystem.combatData.awardList) do
			local var_11_7 = arg_11_0.items[var_11_6]

			if var_11_7 ~= nil then
				var_11_7:refreshAward(iter_11_7.Type, iter_11_7.Id, iter_11_7.Count)
				var_11_7:setVisible(true)
			end

			var_11_6 = var_11_6 + 1
		end
	end

	arg_11_0:animEffect()
end

function var_0_0.animEffect(arg_12_0)
	local var_12_0 = 0

	local function var_12_1()
		local function var_13_0(arg_14_0)
			arg_12_0.fxWinStar:setVisible(true)
			arg_12_0.fxWinStar:setAnimation("jieshu_01", false)
		end

		local function var_13_1()
			arg_12_0.fxWinStar:setAnimation("jieshu_02", true)
		end

		local var_13_2 = CCArray:create()

		var_13_2:addObject(CCCallFuncN:create(var_13_0))
		var_13_2:addObject(CCDelayTime:create(3))
		var_13_2:addObject(CCCallFuncN:create(var_13_1))
		arg_12_0.fxWinStar:setVisible(false)
		arg_12_0.fxWinStar:stopAllActions()
		arg_12_0.fxWinStar:runAction(CCSequence:create(var_13_2))

		var_12_0 = var_12_0 + 1
	end

	local function var_12_2(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		local function var_16_0(arg_17_0)
			arg_17_0:setVisible(true)
		end

		local function var_16_1()
			arg_16_0:animHeroExpUp()
			arg_16_0:animSkillExpUp()
		end

		local var_16_2 = CCArray:create()

		var_16_2:addObject(CCDelayTime:create(var_12_0))
		var_16_2:addObject(CCCallFuncN:create(var_16_0))

		if arg_16_1 then
			var_16_2:addObject(CCScaleTo:create(0.1, 0.9))
			var_16_2:addObject(CCScaleTo:create(0.05, 0.95))
		end

		if arg_16_2 then
			var_16_2:addObject(CCCallFuncN:create(var_16_1))
		end

		arg_16_0:setVisible(false)
		arg_16_0:stopAllActions()
		arg_16_0:runAction(CCSequence:create(var_16_2))

		var_12_0 = var_12_0 + arg_16_3
	end

	var_12_1()

	var_12_0 = 0.15

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		if iter_12_1:isVisible() == true then
			var_12_2(iter_12_1, false, false, 0.125)
		end
	end

	var_12_2(arg_12_0.btnReturn, false, false, 0.125)
end

function var_0_0.onReturn(arg_19_0)
	arg_19_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end
end
