zbHeroSoulHallItem = class("zbHeroSoulHallItem", CCNodeExtend)
zbHeroSoulHallItem.__index = zbHeroSoulHallItem

function zbHeroSoulHallItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulHallItem)

	return arg_1_0
end

function zbHeroSoulHallItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHeroSoulHallItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHeroSoulHallItem.init(arg_3_0, arg_3_1, arg_3_2)
	function initMember()
		arg_3_0.ccNode = arg_3_1
		arg_3_0.myIndex = arg_3_2
	end

	local function var_3_0(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setAnchorPoint(ccp(0.5, 0.5))
		var_5_0:setPosition(arg_5_0:getContentSize().width - 25, arg_5_0:getContentSize().height - 25)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	function initCCB()
		local var_6_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteIcon = tolua.cast(var_6_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteIcon:getChildByTag(2), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(arg_3_0.spriteIcon:getChildByTag(1), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteCount = tolua.cast(var_6_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbCountDummy = tolua.cast(arg_3_0.spriteCount:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCountDummy, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.7)

		arg_3_0.lbOpen = tolua.cast(var_6_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.notify = var_3_0(arg_3_0.spriteIcon)

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_6_0:getContentSize())
	end

	initMember()
	initCCB()
end

function zbHeroSoulHallItem.refresh(arg_8_0, arg_8_1)
	arg_8_0.record = arg_8_1

	if arg_8_1 == nil then
		arg_8_0.ccNode:setVisible(false)

		return
	else
		arg_8_0.ccNode:setVisible(true)
	end

	arg_8_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_8_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herosoul.plist")

	local var_8_0 = arg_8_0.spriteframeCache:spriteFrameByName("herosoul_title" .. arg_8_1.id .. ".png")

	if var_8_0 then
		arg_8_0.spriteTitle:initWithSpriteFrame(var_8_0)
	end

	arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/herosoulhall/herosoul_bg" .. arg_8_1.id .. ".jpg"))

	if arg_8_1.openLevel > g_Self:getLevel() then
		arg_8_0.spriteCount:setVisible(false)
		arg_8_0.lbOpen:setVisible(true)
		arg_8_0.btnTouch:setVisible(false)
		arg_8_0.lbOpen:setString(a2u("(") .. arg_8_1.openLevel .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4)"))
	else
		arg_8_0.spriteCount:setVisible(true)
		arg_8_0.lbOpen:setVisible(false)
		arg_8_0.btnTouch:setVisible(true)

		if g_GameData.HeroSoulHallInfo == nil or type(g_GameData.HeroSoulHallInfo) ~= "table" then
			arg_8_0.lbCount:setString("0/5")
		else
			arg_8_0.currData = arg_8_0:getData(arg_8_1)

			if arg_8_0.currData == nil then
				arg_8_0.lbCount:setString("0/5")
			else
				arg_8_0.lbCount:setString(table.getn(arg_8_0.currData.HeroSoulList) .. "/5")
			end
		end
	end

	arg_8_0:refreshNotify()
end

function zbHeroSoulHallItem.releaseBg(arg_9_0)
	arg_9_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/herosoulhall/herosoul_bg11.jpg"))
end

function zbHeroSoulHallItem.getData(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(g_GameData.HeroSoulHallInfo.HeroSoulHallList) do
		if arg_10_1.id == iter_10_1.HallId then
			return iter_10_1
		end
	end

	return nil
end

function zbHeroSoulHallItem.onTouch(arg_11_0)
	if arg_11_0.record.openLevel > g_Self:getLevel() then
		g_Bubble:bubbleInfo(a2u("(") .. arg_11_0.record.openLevel .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4)"))

		return
	end

	g_MainScene:showHeroSoulView(arg_11_0.record, arg_11_0.myIndex)
	g_MainScene.wndHeroSoulView:setPrevWnd(g_MainScene.wndHeroSoulHall)
end

function zbHeroSoulHallItem.refreshNotify(arg_12_0)
	if arg_12_0.record.openLevel > g_Self:getLevel() then
		arg_12_0.notify:setVisible(false)

		return
	end

	local var_12_0 = false

	for iter_12_0 = 1, 5 do
		for iter_12_1 = 1, 5 do
			var_12_0 = g_Self.kHeroSoulHallHandler:hasHeroSoul(arg_12_0.record.id, iter_12_0, iter_12_1)

			if var_12_0 then
				break
			end
		end

		if var_12_0 then
			break
		end
	end

	arg_12_0.notify:setVisible(var_12_0)
end
