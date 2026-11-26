require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroSoulViewItem")

zbHeroSoulViewWnd = class("zbHeroSoulViewWnd", zbBaseWnd)
zbHeroSoulViewWnd.__index = zbHeroSoulViewWnd

function zbHeroSoulViewWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulViewWnd)

	return arg_1_0
end

function createHeroSoulViewWnd()
	local var_2_0 = zbHeroSoulViewWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroSoulViewWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.circleItems = {}
		arg_3_0.heroSoulCount = {}
		arg_3_0.nodeJiaCheng = {}
		arg_3_0.lbJiachengName = {}
		arg_3_0.lbJiachengNum = {}
		arg_3_0.postionY = {}
		arg_3_0.hallData = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroSoulview.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")

		arg_3_0.contentLayer = tolua.cast(var_5_3:getChildByTag(1), "CCLayerColor")
		arg_3_0.uiLayer = tolua.cast(var_5_3:getChildByTag(2), "CCLayerColor")
		arg_3_0.uiMainLayer = tolua.cast(var_5_3:getChildByTag(10), "CCLayerColor")

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(102), "CCNode")

		arg_3_0.spriteTitle = tolua.cast(var_5_4:getChildByTag(102), "CCSprite")
		arg_3_0.spriteLeft = tolua.cast(var_5_1:getChildByTag(21), "CCSprite")
		arg_3_0.spriteRight = tolua.cast(var_5_1:getChildByTag(22), "CCSprite")
		arg_3_0.btnLeft = tolua.cast(var_5_1:getChildByTag(23), "CCControlButton")
		arg_3_0.btnRight = tolua.cast(var_5_1:getChildByTag(24), "CCControlButton")

		arg_3_0.btnLeft:addHandleOfControlEvent(function()
			arg_3_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRight:addHandleOfControlEvent(function()
			arg_3_0:onRight()
		end, CCControlEventTouchUpInside)

		arg_3_0.pnlSoulView = zbHeroSoulViewItem:create()

		arg_3_0.uiMainLayer:addChild(arg_3_0.pnlSoulView)
		zbUIEffect:runFadeToAction(arg_3_0.spriteLeft)
		zbUIEffect:runFadeToAction(arg_3_0.spriteRight)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Diamond
		}, function()
			arg_3_0:hide()
		end)
		arg_3_0.btnLeft:setTouchPriority(arg_3_0.moneyPanel.btnClose:getTouchPriority() - 1)
		arg_3_0.btnRight:setTouchPriority(arg_3_0.moneyPanel.btnClose:getTouchPriority() - 1)
	end

	local function var_3_2()
		arg_3_0.type = tolua.cast(arg_3_0.uiLayer:getChildByTag(1), "CCSprite")
		arg_3_0.lbNothing = tolua.cast(arg_3_0.uiLayer:getChildByTag(3), "CCLabelTTF")

		for iter_9_0 = 1, 5 do
			arg_3_0.nodeJiaCheng[iter_9_0] = tolua.cast(arg_3_0.uiLayer:getChildByTag(10 + iter_9_0), "CCNode")

			local var_9_0 = tolua.cast(arg_3_0.nodeJiaCheng[iter_9_0]:getChildByTag(1), "CCLabelTTF")

			arg_3_0.lbJiachengName[iter_9_0] = tolua.cast(arg_3_0.nodeJiaCheng[iter_9_0]:getChildByTag(5), "CCLabelTTF")
			arg_3_0.postionY[iter_9_0] = arg_3_0.nodeJiaCheng[iter_9_0]:getPositionY()
			arg_3_0.lbJiachengNum[iter_9_0] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_9_0, arg_3_0.lbJiachengNum[iter_9_0])
			arg_3_0.lbJiachengNum[iter_9_0]:setScale(0.55)
		end

		local function var_9_1(arg_10_0)
			local var_10_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_10_0:setPosition(ccp(90, 25))
			var_10_0:setVisible(false)
			arg_10_0:addChild(var_10_0)
			zbUIEffect:createNotifyTagScaleAction(var_10_0)

			return var_10_0
		end
	end

	var_3_0()
	var_3_1()
	var_3_2()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreCurItem()
	end, zbGameEvent.Event_HeroSoulHall_Ack)
end

function zbHeroSoulViewWnd.free(arg_12_0)
	return
end

function zbHeroSoulViewWnd.refresh(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.hallRecord = arg_13_1
	arg_13_0.myIndex = arg_13_2

	arg_13_0:refreCurItem()
end

function zbHeroSoulViewWnd.refreCurItem(arg_14_0)
	arg_14_0.hallData = nil

	if g_GameData.HeroSoulHallInfo ~= nil and type(g_GameData.HeroSoulHallInfo) == "table" then
		for iter_14_0, iter_14_1 in pairs(g_GameData.HeroSoulHallInfo.HeroSoulHallList) do
			if arg_14_0.hallRecord.id == iter_14_1.HallId then
				arg_14_0.hallData = iter_14_1
			end
		end
	end

	arg_14_0.pnlSoulView:gotoHeroSoulView(arg_14_0.myIndex, arg_14_0.hallData, arg_14_0.hallRecord)

	arg_14_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_14_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herosoul.plist")

	local var_14_0 = arg_14_0.spriteframeCache:spriteFrameByName("herosoul_title" .. arg_14_0.hallRecord.id .. ".png")

	if var_14_0 then
		arg_14_0.spriteTitle:initWithSpriteFrame(var_14_0)
	end

	arg_14_0:refreshSoul(arg_14_0.hallData)
	arg_14_0:updateArrowVisible()
end

function zbHeroSoulViewWnd.refreshSoul(arg_15_0, arg_15_1)
	for iter_15_0 = 1, 5 do
		arg_15_0.nodeJiaCheng[iter_15_0]:setVisible(false)
		arg_15_0.lbNothing:setVisible(true)
		arg_15_0.nodeJiaCheng[iter_15_0]:setPositionY(arg_15_0.postionY[iter_15_0])
	end

	if arg_15_1 ~= nil then
		local var_15_0 = 1

		for iter_15_1, iter_15_2 in pairs(arg_15_1.HeroAddAttrList) do
			if var_15_0 > 5 then
				break
			end

			arg_15_0.lbJiachengName[var_15_0]:setString(a2u(g_strAttrType[iter_15_2.AttrType]))
			arg_15_0.lbJiachengNum[var_15_0]:setString("+" .. iter_15_2.AttrValue)
			arg_15_0.nodeJiaCheng[var_15_0]:setVisible(true)
			arg_15_0.lbNothing:setVisible(false)

			var_15_0 = var_15_0 + 1
		end
	end
end

function zbHeroSoulViewWnd.updateArrowVisible(arg_16_0)
	local var_16_0 = arg_16_0.hallRecord.id - 1 >= zbHeroSoulHallTable:getMinForceId()

	arg_16_0.spriteLeft:setVisible(var_16_0)
	arg_16_0.btnLeft:setVisible(var_16_0)

	local var_16_1 = arg_16_0.hallRecord.id + 1 <= zbHeroSoulHallTable:getMaxForceId()

	arg_16_0.spriteRight:setVisible(var_16_1)
	arg_16_0.btnRight:setVisible(var_16_1)
end

function zbHeroSoulViewWnd.touchOnItem(arg_17_0)
	local var_17_0 = arg_17_0.circleScrollView:getCenterCellIdx()

	arg_17_0.currHeroSeat = arg_17_0.heroSoulCount[var_17_0 + 1]

	local var_17_1

	if arg_17_0.hallData == nil or type(arg_17_0.hallData) ~= "table" then
		var_17_1 = nil
	else
		for iter_17_0, iter_17_1 in pairs(arg_17_0.hallData.HeroSoulList) do
			if arg_17_0.currHeroSeat == iter_17_1.Position then
				var_17_1 = iter_17_1

				break
			end
		end
	end

	if var_17_1 == nil then
		g_MainScene:showHeroSoulList(arg_17_0.hallRecord, arg_17_0.currHeroSeat)
		g_MainScene.wndHeroSoulList:setPrevWnd(g_MainScene.wndHeroSoulView)
	else
		g_MainScene:showHeroSoulDetail(arg_17_0.hallRecord, arg_17_0.currHeroSeat, arg_17_0.hallData)
	end
end

function zbHeroSoulViewWnd.onLeft(arg_18_0)
	local var_18_0 = arg_18_0.hallRecord.id - 1
	local var_18_1 = zbHeroSoulHallTable:getRecord(var_18_0)

	if var_18_1 then
		arg_18_0:refresh(var_18_1, var_18_0 - 10)
	end
end

function zbHeroSoulViewWnd.onRight(arg_19_0)
	local var_19_0 = arg_19_0.hallRecord.id + 1
	local var_19_1 = zbHeroSoulHallTable:getRecord(var_19_0)

	if var_19_1 then
		arg_19_0:refresh(var_19_1, var_19_0 - 10)
	end
end
