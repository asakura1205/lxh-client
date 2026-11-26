require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")
require("gamelogic.zbAwardPreviewPop")

local var_0_0 = class("zbTreaSureWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createTreasureWnd(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_1_0:initBase()
	var_1_0:init(arg_1_0, arg_1_1)

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
		arg_3_0.role = nil
		arg_3_0.bg1 = nil
		arg_3_0.bg2 = nil
		arg_3_0.start = false
		arg_3_0.treasureRecord = nil
		arg_3_0.box3Count = 0
		arg_3_0.curTreaSureCount = 0
		arg_3_0.awardPreviewPop = nil
		arg_3_0.havecostItemNum = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/treasure.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = var_5_2
		arg_3_0.nodebg = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnRule = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnGo = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

		arg_3_0.btnGo:addHandleOfControlEvent(function()
			arg_3_0:onTreasure(1)
		end, CCControlEventTouchUpInside)

		arg_3_0.btnFast = tolua.cast(var_5_3:getChildByTag(4), "CCControlButton")

		arg_3_0.btnFast:addHandleOfControlEvent(function()
			arg_3_0:onTreasure(2)
		end, CCControlEventTouchUpInside)

		arg_3_0.lbtimes = tolua.cast(var_5_3:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbopen = tolua.cast(var_5_3:getChildByTag(5), "CCLabelTTF")
		arg_3_0.awardBox = tolua.cast(var_5_3:getChildByTag(6), "CCSprite")

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(7), "CCNode")

		arg_3_0.spriteBarBg = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")

		local function var_5_5(arg_9_0, arg_9_1)
			local var_9_0 = CCSprite:create(arg_9_1)

			var_9_0:setAnchorPoint(ccp(0, 0))

			local var_9_1 = CCProgressTimer:create(var_9_0)

			var_9_1:setAnchorPoint(ccp(0, 0))
			var_9_1:setPercentage(0)
			var_9_1:setMidpoint(ccp(0, 1))
			var_9_1:setBarChangeRate(ccp(1, 0))
			var_9_1:setType(kCCProgressTimerTypeBar)
			var_9_1:retain()
			arg_9_0:addChild(var_9_1)

			return var_9_1
		end

		arg_3_0.spriteBar = var_5_5(arg_3_0.spriteBarBg, "image/warpath/treasure/treasure_progress2.png")
		arg_3_0.nodeLocate = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.nodeLocate:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lblocateRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lblocateRep)
		arg_3_0.lblocateRep:setScale(0.65)

		arg_3_0.topawardNode = {}
		arg_3_0.btnawardTop = {}
		arg_3_0.spawardTop = {}
		arg_3_0.topspriteEffect = {}
		arg_3_0.topopentimesRep = {}

		for iter_5_0 = 1, 3 do
			local var_5_7 = tolua.cast(var_5_4:getChildByTag(99 + iter_5_0), "CCNode")

			arg_3_0.topawardNode[iter_5_0] = var_5_7
			arg_3_0.btnawardTop[iter_5_0] = tolua.cast(var_5_7:getChildByTag(2), "CCControlButton")

			arg_3_0.btnawardTop[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:getBoxAward(iter_5_0)
			end, CCControlEventTouchUpInside)

			arg_3_0.spawardTop[iter_5_0] = tolua.cast(var_5_7:getChildByTag(1), "CCSprite")
			arg_3_0.topspriteEffect[iter_5_0] = tolua.cast(var_5_7:getChildByTag(3), "CCSprite")

			local var_5_8 = tolua.cast(var_5_7:getChildByTag(1004), "CCLabelTTF")

			arg_3_0.topopentimesRep[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.topopentimesRep[iter_5_0])
			arg_3_0.topopentimesRep[iter_5_0]:setScale(0.65)

			local var_5_9 = CCRotateBy:create(5, 360)

			arg_3_0.topspriteEffect[iter_5_0]:runAction(CCRepeatForever:create(var_5_9))
		end

		arg_3_0.nodeAwardUI = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.nodeAwardUI:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.awardItems = {}

		for iter_5_1 = 1, 3 do
			local var_5_10 = tolua.cast(arg_3_0.nodeAwardUI:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_11 = createItem()

			var_5_11:setPosition(var_5_10:getPosition())
			var_5_11:setScale(0.9)
			var_5_11:setSwallowsTouches(false)
			arg_3_0.nodeAwardUI:addChild(var_5_11)

			arg_3_0.awardItems[iter_5_1] = var_5_11

			var_5_10:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.awardItems[2]:getPositionX()

		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:doHide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:loadBgAndRole()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onTreaSureAck()
	end, zbGameEvent.Event_TreaSure_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_TreaSureGetBoxAward_Ack)
end

function var_0_0.doShow(arg_15_0)
	arg_15_0:setBtnState(true)
end

function var_0_0.doHide(arg_16_0)
	arg_16_0:stopAllActions()
	arg_16_0:hide()
end

function var_0_0.loadBgAndRole(arg_17_0)
	local var_17_0 = "image/warpath/treasure/treasure_bg2.jpg"

	arg_17_0.bg1 = CCSprite:create(var_17_0)

	arg_17_0.bg1:setAnchorPoint(ccp(0, 0))
	arg_17_0.nodebg:addChild(arg_17_0.bg1)

	arg_17_0.bg2 = CCSprite:create(var_17_0)

	arg_17_0.bg2:setAnchorPoint(ccp(0, 0))
	arg_17_0.bg2:setPosition(ccp(arg_17_0.bg1:getContentSize().width, 0))
	arg_17_0.nodebg:addChild(arg_17_0.bg2)

	arg_17_0.role = createUIAnimation()

	arg_17_0.role:refreshAvatarId(g_GameData.BaseInfo.AvatarId)
	arg_17_0.role:setPosition(300, 150)
	arg_17_0.role:setRotationY(180)
	arg_17_0.role:setScale(1.5)
	arg_17_0.nodebg:addChild(arg_17_0.role)

	local var_17_1 = CCSprite:create("image/combat/yingzi.png")

	var_17_1:setScale(0.7)
	var_17_1:setPosition(0, 0)

	local var_17_2 = CCScaleBy:create(1, 0.9)
	local var_17_3 = CCSequence:createWithTwoActions(var_17_2, var_17_2:reverse())

	var_17_1:runAction(CCRepeatForever:create(var_17_3))
	arg_17_0.role:addChild(var_17_1, -1)
	var_17_1:setZOrder(-1)

	arg_17_0.animYanwu = createUIAnimation()

	arg_17_0.animYanwu:refreshBone("effect/spine/ui_yanwu/ui_yanwu")
	arg_17_0.animYanwu:setVisible(false)
	arg_17_0.animYanwu:setPosition(ccp(arg_17_0.awardBox:getPositionX(), arg_17_0.awardBox:getPositionY() - arg_17_0.awardBox:getContentSize().height / 2))
	arg_17_0.nodebg:addChild(arg_17_0.animYanwu)
end

function var_0_0.onFrameUpdate(arg_18_0)
	if arg_18_0.start == false then
		return
	end

	if arg_18_0.bg1 and arg_18_0.bg2 then
		arg_18_0.bg1:setPositionX(arg_18_0.bg1:getPositionX() - 10)
		arg_18_0.bg2:setPositionX(arg_18_0.bg2:getPositionX() - 10)

		if arg_18_0.bg1:getPositionX() <= -arg_18_0.bg1:getContentSize().width then
			arg_18_0.bg1:setPositionX(arg_18_0.bg2:getPositionX() + arg_18_0.bg2:getContentSize().width)
		elseif arg_18_0.bg2:getPositionX() <= -arg_18_0.bg2:getContentSize().width then
			arg_18_0.bg2:setPositionX(arg_18_0.bg1:getPositionX() + arg_18_0.bg1:getContentSize().width)
		end
	end
end

function var_0_0.setChapterIdAndlevel(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.chapterId = arg_19_1
	arg_19_0.levelType = arg_19_2
end

function var_0_0.refresh(arg_20_0)
	local var_20_0 = zbTreaSureTable:getRecord(arg_20_0.chapterId)

	if var_20_0 then
		local var_20_1 = var_20_0.scenePath

		arg_20_0.treasureRecord = var_20_0

		arg_20_0.bg1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_20_1))
		arg_20_0.bg2:setTexture(CCTextureCache:sharedTextureCache():addImage(var_20_1))
	end

	arg_20_0.start = false
	arg_20_0.box3Count = 0
	arg_20_0.curTreaSureCount = 0

	arg_20_0.awardBox:setVisible(false)
	arg_20_0.role:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	arg_20_0.nodeAwardUI:setVisible(false)

	for iter_20_0 = 1, 3 do
		arg_20_0.topspriteEffect[iter_20_0]:setVisible(false)
	end

	arg_20_0.lbopen:setString(a2u("\xA3\xA8vip") .. TREASURE_FAST_VIP_LIMIT .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4\xA3\xA9"))
	arg_20_0.lbopen:setVisible(TREASURE_FAST_VIP_LIMIT > g_GameData.BaseInfo.VipLevel)

	local var_20_2 = g_Self.kTreaSureHandler:getTreaSureInfoById(arg_20_0.chapterId)

	arg_20_0.treaSureInfo = var_20_2

	if var_20_2 then
		local var_20_3 = var_20_2.MagnifierCount
		local var_20_4 = 0

		if arg_20_0.treasureRecord then
			var_20_4 = arg_20_0.treasureRecord.box3Times

			arg_20_0.topawardNode[1]:setPositionX(arg_20_0.spriteBarBg:getPositionX() + arg_20_0.treasureRecord.box1Times / var_20_4 * arg_20_0.spriteBarBg:getContentSize().width)
			arg_20_0.topawardNode[2]:setPositionX(arg_20_0.spriteBarBg:getPositionX() + arg_20_0.treasureRecord.box2Times / var_20_4 * arg_20_0.spriteBarBg:getContentSize().width)
			arg_20_0.topawardNode[3]:setPositionX(arg_20_0.spriteBarBg:getPositionX() + arg_20_0.treasureRecord.box3Times / var_20_4 * arg_20_0.spriteBarBg:getContentSize().width)
			arg_20_0.topopentimesRep[1]:setString(arg_20_0.treasureRecord.box1Times)
			arg_20_0.topopentimesRep[2]:setString(arg_20_0.treasureRecord.box2Times)
			arg_20_0.topopentimesRep[3]:setString(arg_20_0.treasureRecord.box3Times)

			arg_20_0.box3Count = arg_20_0.treasureRecord.box3Times
		end

		zbUtil:setBtnEnable(arg_20_0.btnFast, TREASURE_FAST_VIP_LIMIT <= g_GameData.BaseInfo.VipLevel and var_20_3 < arg_20_0.box3Count)

		local var_20_5 = math.min(math.ceil(100 * (var_20_3 / var_20_4)), 100)

		arg_20_0.spriteBar:setPercentage(var_20_5)

		local var_20_6 = var_20_3

		if var_20_4 < var_20_6 then
			var_20_6 = var_20_4
		end

		arg_20_0.curTreaSureCount = var_20_3

		arg_20_0.nodeLocate:setPositionX(arg_20_0.spriteBarBg:getPositionX() + var_20_6 / var_20_4 * arg_20_0.spriteBarBg:getContentSize().width)

		if var_20_2.Box1State == -1 then
			arg_20_0.spawardTop[1]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox13.png"))
		elseif var_20_2.Box1State == 1 then
			arg_20_0.spawardTop[1]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox12.png"))
			arg_20_0.topspriteEffect[1]:setVisible(true)
		else
			arg_20_0.spawardTop[1]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox11.png"))
		end

		if var_20_2.Box2State == -1 then
			arg_20_0.spawardTop[2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox23.png"))
		elseif var_20_2.Box2State == 1 then
			arg_20_0.spawardTop[2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox22.png"))
			arg_20_0.topspriteEffect[2]:setVisible(true)
		else
			arg_20_0.spawardTop[2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox21.png"))
		end

		if var_20_2.Box3State == -1 then
			arg_20_0.spawardTop[3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox33.png"))
		elseif var_20_2.Box3State == 1 then
			arg_20_0.spawardTop[3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox32.png"))
			arg_20_0.topspriteEffect[3]:setVisible(true)
		else
			arg_20_0.spawardTop[3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/forcedetail/giftbox31.png"))
		end

		arg_20_0.havecostItemNum = 0

		local var_20_7 = zbItemTable:getMagnifierInfo()

		if var_20_7 then
			arg_20_0.havecostItemNum = var_20_7.Count
		end

		arg_20_0.lbtimes:setString(arg_20_0.havecostItemNum)
		arg_20_0.lblocateRep:setString(var_20_3)
	end
end

function var_0_0.setBtnState(arg_21_0, arg_21_1)
	zbUtil:setBtnEnable(arg_21_0.btnFast, TREASURE_FAST_VIP_LIMIT <= g_GameData.BaseInfo.VipLevel and arg_21_1 and arg_21_0.curTreaSureCount < arg_21_0.box3Count)
	zbUtil:setBtnEnable(arg_21_0.btnGo, arg_21_1)
end

function var_0_0.onTouchTest(arg_22_0)
	arg_22_0.nodeAwardUI:setVisible(false)
	arg_22_0.awardBox:setVisible(false)
end

function var_0_0.onTreasure(arg_23_0, arg_23_1)
	if arg_23_0.havecostItemNum <= 0 then
		g_Bubble:bubbleInfo(a2u("\xB7Ŵ\xF3\xBE\xB5\xCA\xFD\xC1\xBF\xB2\xBB\xD7\xE3"))

		return
	end

	local function var_23_0()
		arg_23_0.start = true

		arg_23_0.awardBox:setVisible(false)
		arg_23_0.role:setAnimation(ANIMATION_SEQUENCE_RUN, true)
		arg_23_0:setBtnState(false)
		arg_23_0.moneyPanel.btnClose:setVisible(false)

		local function var_24_0()
			if arg_23_1 == 1 then
				g_WsMsgHandler:WS_Treasure_Start_Req(arg_23_0.chapterId, arg_23_0.levelType)
			else
				g_WsMsgHandler:WS_Treasure_FastStart_Req(arg_23_0.chapterId, arg_23_0.levelType)
			end

			arg_23_0.moneyPanel.btnClose:setVisible(true)
		end

		local var_24_1 = CCDelayTime:create(0.8)
		local var_24_2 = CCCallFuncN:create(var_24_0)
		local var_24_3 = CCSequence:createWithTwoActions(var_24_1, var_24_2)

		arg_23_0:stopAllActions()
		arg_23_0:runAction(var_24_3)
	end

	if arg_23_1 == 2 then
		if arg_23_0.box3Count - arg_23_0.curTreaSureCount <= 0 then
			return
		end

		local function var_23_1()
			var_23_0()
		end

		local var_23_2 = string.format(a2u("\xCF\xFB\xBA\xC4%d\xB7Ŵ\xF3\xBE\xB5,ȷ\xB6\xA8һ\xBC\xFCѰ\xB1\xA6\xC2\xF0\xA3\xBF"), math.min(arg_23_0.box3Count - arg_23_0.curTreaSureCount, arg_23_0.havecostItemNum))

		g_MessageBox:showYesNo(a2u(var_23_2), var_23_1)
	else
		var_23_0()
	end
end

function var_0_0.getBoxAward(arg_27_0, arg_27_1)
	if arg_27_0.treaSureInfo == nil or arg_27_0.start then
		return
	end

	local var_27_0 = arg_27_0:getTopAward(arg_27_1)

	if arg_27_1 == 1 then
		if arg_27_0.treaSureInfo.Box1State == -1 or arg_27_0.treaSureInfo.Box1State == 0 then
			g_MainScene:showTreaSureBoxView(var_27_0)

			return
		end
	elseif arg_27_1 == 2 then
		if arg_27_0.treaSureInfo.Box2State == -1 or arg_27_0.treaSureInfo.Box2State == 0 then
			g_MainScene:showTreaSureBoxView(var_27_0)

			return
		end
	elseif arg_27_0.treaSureInfo.Box3State == -1 or arg_27_0.treaSureInfo.Box3State == 0 then
		g_MainScene:showTreaSureBoxView(var_27_0)

		return
	end

	g_WsMsgHandler:WS_Treasure_GetBoxAward_Req(arg_27_0.chapterId, arg_27_0.levelType, arg_27_1)
end

function var_0_0.getTopAward(arg_28_0, arg_28_1)
	local var_28_0 = zbTreaSureTable:getRecord(arg_28_0.chapterId)

	if var_28_0 == nil then
		return
	end

	local var_28_1 = {}

	if arg_28_1 == 1 then
		var_28_1 = var_28_0.box1Award
	elseif arg_28_1 == 2 then
		var_28_1 = var_28_0.box2Award
	elseif arg_28_1 == 3 then
		var_28_1 = var_28_0.box3Award
	end

	return var_28_1
end

function var_0_0.onTreaSureAck(arg_29_0)
	arg_29_0:refresh()
	arg_29_0.animYanwu:setVisible(true)
	arg_29_0.animYanwu:setAnimation("animation", false)

	local function var_29_0()
		arg_29_0.awardBox:setVisible(true)
		g_Audio:playSound(AudioDefine.UI_ITEM_GET)

		local function var_30_0()
			arg_29_0.nodeAwardUI:setVisible(true)
			arg_29_0:setBtnState(true)

			for iter_31_0 = 1, 3 do
				arg_29_0.awardItems[iter_31_0]:setVisible(false)
			end

			local var_31_0 = 1

			if zbUtil:isValidTable(g_Self.kTreaSureHandler.treaSurewardList) then
				for iter_31_1, iter_31_2 in pairs(g_Self.kTreaSureHandler.treaSurewardList) do
					if arg_29_0.awardItems[var_31_0] then
						arg_29_0.awardItems[var_31_0]:setVisible(true)
						arg_29_0.awardItems[var_31_0]:refreshAward(iter_31_2.Type, iter_31_2.Id, iter_31_2.Count)
					end

					var_31_0 = var_31_0 + 1
				end

				zbUIEffect:centerStar(arg_29_0.awardItems, arg_29_0.centerPositionX)
			end
		end

		local var_30_1 = CCDelayTime:create(0.5)
		local var_30_2 = CCCallFuncN:create(var_30_0)
		local var_30_3 = CCSequence:createWithTwoActions(var_30_1, var_30_2)

		arg_29_0:stopAllActions()
		arg_29_0:runAction(var_30_3)
	end

	local var_29_1 = CCDelayTime:create(0.5)
	local var_29_2 = CCCallFuncN:create(var_29_0)
	local var_29_3 = CCSequence:createWithTwoActions(var_29_1, var_29_2)

	arg_29_0:stopAllActions()
	arg_29_0:runAction(var_29_3)
end

function var_0_0.onRule(arg_32_0)
	g_MainScene:showRuleWnd(RuleType_TreaSure)
end
