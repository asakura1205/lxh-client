require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGodWnd", zbBaseWnd)

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

function createGodWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.curGodInfo = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/godequip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.nodeGod = tolua.cast(var_5_3:getChildByTag(100), "CCNode")
		arg_3_0.godSprite = tolua.cast(arg_3_0.nodeGod:getChildByTag(100), "CCSprite")
		arg_3_0.godTouch = tolua.cast(arg_3_0.nodeGod:getChildByTag(101), "CCControlButton")
		arg_3_0.godName = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")

		zbUIEffect:runScaleToAction(arg_3_0.godSprite)

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.godPowerRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.godPowerRep)
		arg_3_0.godPowerRep:setScale(0.7)

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(3), "CCLabelTTF")

		arg_3_0.godLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.godLvRep)
		arg_3_0.godLvRep:setScale(0.55)

		arg_3_0.spriteBarBg = tolua.cast(var_5_3:getChildByTag(4), "CCSprite")

		local function var_5_6(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(0)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		arg_3_0.spriteBar = var_5_6(arg_3_0.spriteBarBg, "image/common/progress.png")
		arg_3_0.godQuality = tolua.cast(var_5_3:getChildByTag(5), "CCSprite")

		local function var_5_7(arg_7_0)
			local var_7_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_7_0:setPosition(160, 70)
			var_7_0:setVisible(false)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		arg_3_0.btnLvUp = tolua.cast(var_5_3:getChildByTag(6), "CCControlButton")
		arg_3_0.btnQualityUp = tolua.cast(var_5_3:getChildByTag(7), "CCControlButton")
		arg_3_0.godType = tolua.cast(var_5_3:getChildByTag(8), "CCSprite")
		arg_3_0.godDesc = tolua.cast(var_5_3:getChildByTag(1009), "CCLabelTTF")
		arg_3_0.notifyLevel = var_5_7(arg_3_0.btnLvUp)
		arg_3_0.notifyStar = var_5_7(arg_3_0.btnQualityUp)

		arg_3_0.godTouch:addHandleOfControlEvent(function()
			arg_3_0:onGodTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLvUp:addHandleOfControlEvent(function()
			arg_3_0:onLevelUpTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnQualityUp:addHandleOfControlEvent(function()
			arg_3_0:onQualityUpTouch()
		end, CCControlEventTouchUpInside)

		local var_5_8 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		local var_5_9 = tolua.cast(var_5_8:getChildByTag(10), "CCNode")

		arg_3_0.skill = {}
		arg_3_0.spskillLevel = {}
		arg_3_0.lblskillRep = {}
		arg_3_0.skillNotify = {}

		for iter_5_0 = 1, 9 do
			arg_3_0.skill[iter_5_0] = tolua.cast(var_5_8:getChildByTag(iter_5_0), "CCNode")
			arg_3_0.spskillLevel[iter_5_0] = tolua.cast(arg_3_0.skill[iter_5_0]:getChildByTag(3), "CCSprite")
			arg_3_0.skillNotify[iter_5_0] = tolua.cast(arg_3_0.skill[iter_5_0]:getChildByTag(4), "CCSprite")

			arg_3_0.skillNotify[iter_5_0]:setVisible(false)
			zbUIEffect:createNotifyTagScaleAction(arg_3_0.skillNotify[iter_5_0])

			local var_5_10 = tolua.cast(arg_3_0.spskillLevel[iter_5_0]:getChildByTag(1), "CCLabelTTF")

			arg_3_0.lblskillRep[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_10, arg_3_0.lblskillRep[iter_5_0])
			arg_3_0.lblskillRep[iter_5_0]:setScale(0.55)
		end

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
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_GodInfo)
end

function var_0_0.refresh(arg_13_0)
	if g_GameData.GodInfo == nil then
		return
	end

	arg_13_0.curGodInfo = g_GameData.GodInfo

	local var_13_0 = arg_13_0.curGodInfo.GodId
	local var_13_1 = zbGodBaseTable:getRecord(var_13_0)

	if var_13_1 then
		arg_13_0.godName:setString(a2u(var_13_1.name))
		arg_13_0.godSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(var_13_1.iconPath))
		arg_13_0.godDesc:setString(a2u(var_13_1.desc))
		g_Self.kGodHandler:setGodTypeTexture(arg_13_0.godType, var_13_1.type)
	end

	arg_13_0.godPowerRep:setString(arg_13_0.curGodInfo.Power)
	arg_13_0.godLvRep:setString(arg_13_0.curGodInfo.Level)

	local var_13_2 = g_Self.kGodHandler:getGodMaxLevel()
	local var_13_3 = 1

	if var_13_2 <= arg_13_0.curGodInfo.Level then
		var_13_3 = var_13_2
	else
		var_13_3 = arg_13_0.curGodInfo.Level + 1
	end

	local var_13_4 = g_Self.kGodHandler:getCurLevelMaxExp(var_13_3)
	local var_13_5 = arg_13_0.curGodInfo.Exp
	local var_13_6 = math.min(math.ceil(100 * (var_13_5 / var_13_4)), 100)

	arg_13_0.spriteBar:setPercentage(var_13_6)
	g_Self.kGodHandler:setGodStarTexture(arg_13_0.godQuality, arg_13_0.curGodInfo.Star)

	if g_Self.kGodHandler.bgodChange then
		local var_13_7 = CCScaleTo:create(0.2, 1.5)
		local var_13_8 = CCScaleTo:create(0.08, 1)
		local var_13_9 = CCArray:create()

		var_13_9:addObject(var_13_7)
		var_13_9:addObject(var_13_8)

		local var_13_10 = CCSequence:create(var_13_9)

		arg_13_0.nodeGod:stopAllActions()
		arg_13_0.nodeGod:runAction(var_13_10)
	end

	arg_13_0:refreshSkill()
end

function var_0_0.refreshSkill(arg_14_0)
	for iter_14_0 = 1, 9 do
		arg_14_0.skill[iter_14_0]:setVisible(false)
	end

	arg_14_0.btnskill = {}

	if zbUtil:isValidTable(arg_14_0.curGodInfo.SkillList) then
		for iter_14_1, iter_14_2 in pairs(arg_14_0.curGodInfo.SkillList) do
			if arg_14_0.skill[iter_14_2.Index] then
				arg_14_0.spskillLevel[iter_14_2.Index]:setVisible(iter_14_2.Level > 0)
				arg_14_0.spskillLevel[iter_14_2.Index]:setVisible(iter_14_2.Level > 0)
				arg_14_0.lblskillRep[iter_14_2.Index]:setString(iter_14_2.Level)

				local var_14_0 = tolua.cast(arg_14_0.skill[iter_14_2.Index]:getChildByTag(2), "CCLabelTTF")

				var_14_0:setVisible(iter_14_2.Level == 0)

				if iter_14_2.Level == 0 then
					var_14_0:setString(iter_14_2.Index .. a2u("\xBD׿\xAA\xC6\xF4"))
				end

				arg_14_0.btnskill[iter_14_2.Index] = tolua.cast(arg_14_0.skill[iter_14_2.Index]:getChildByTag(1), "CCControlButton")

				arg_14_0.btnskill[iter_14_2.Index]:addHandleOfControlEvent(function()
					arg_14_0:onSkillTouch(iter_14_2)
				end, CCControlEventTouchUpInside)
				arg_14_0.btnskill[iter_14_2.Index]:addHandleOfControlEvent(function()
					arg_14_0:onTouchDown(iter_14_2)
				end, CCControlEventTouchDown)
				arg_14_0.btnskill[iter_14_2.Index]:addHandleOfControlEvent(function()
					arg_14_0:onTouchEnd(iter_14_2)
				end, CCControlEventTouchEnd)

				local var_14_1 = zbIconHelper:getGodSkillIconPath(iter_14_2.SkillId)

				ui:setButtonPic(arg_14_0.btnskill[iter_14_2.Index], var_14_1, var_14_1, var_14_1)
				arg_14_0.skill[iter_14_2.Index]:setVisible(not g_Self.kGodHandler.bgodChange)
				arg_14_0.skill[iter_14_2.Index]:setGray(iter_14_2.Level == 0)
			end
		end
	end

	if g_Self.kGodHandler.bgodChange then
		local var_14_2 = 1
		local var_14_3 = 9

		local function var_14_4()
			if var_14_2 > var_14_3 then
				arg_14_0:stopAllActions()
			elseif arg_14_0.skill[var_14_2] then
				arg_14_0.skill[var_14_2]:setVisible(true)
			end

			var_14_2 = var_14_2 + 1
		end

		local var_14_5 = CCArray:create()

		var_14_5:addObject(CCDelayTime:create(0.1))
		var_14_5:addObject(CCCallFuncN:create(var_14_4))

		local var_14_6 = CCSequence:create(var_14_5)

		arg_14_0:stopAllActions()
		arg_14_0:runAction(CCRepeatForever:create(var_14_6))

		g_Self.kGodHandler.bgodChange = false
	end
end

function var_0_0.onFrameUpdate(arg_19_0, arg_19_1)
	arg_19_0.notifyLevel:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GodLevelUp))
	arg_19_0.notifyStar:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GodStarUp))
	arg_19_0:updateBackEffect()

	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if zbUtil:isValidTable(arg_19_0.curGodInfo.SkillList) then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.curGodInfo.SkillList) do
			if arg_19_0.skillNotify[iter_19_1.Index] then
				arg_19_0.skillNotify[iter_19_1.Index]:setVisible(g_Self.kGodHandler:isGodSkillCanUp(iter_19_1))
			end
		end
	end
end

function var_0_0.onSkillTouch(arg_20_0, arg_20_1)
	if arg_20_1 and arg_20_1.Level == 0 then
		return
	end

	g_MainScene:showGodSkillUpWnd(arg_20_1)
end

function var_0_0.onTouchDown(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1.Level == 0 then
		arg_21_0:showTip(arg_21_1)
	end
end

function var_0_0.onTouchEnd(arg_22_0, arg_22_1)
	g_MainScene:hideCommonTip()
end

function var_0_0.showTip(arg_23_0, arg_23_1)
	if arg_23_1 == nil or arg_23_0.btnskill[arg_23_1.Index] == nil then
		return
	end

	arg_23_0.lastDownTouch = arg_23_0.btnskill[arg_23_1.Index]:getTouch():getLocation()

	local var_23_0 = arg_23_0.btnskill[arg_23_1.Index]

	while var_23_0:getParent() ~= nil do
		var_23_0 = var_23_0:getParent()
	end

	local var_23_1 = var_23_0:convertToNodeSpace(arg_23_0.lastDownTouch)

	g_MainScene:showGodEquipSkillTips(arg_23_1)
	g_MainScene.wndCommomTip:refreshPos(var_23_1)
end

function var_0_0.onGodTouch(arg_24_0)
	g_MainScene:showGodListWnd()
end

function var_0_0.onLevelUpTouch(arg_25_0)
	g_MainScene:showGodLevelUpWnd()
end

function var_0_0.onQualityUpTouch(arg_26_0)
	g_MainScene:showGodStarUpWnd()
end
