require("gamebase.zbFunctions")

zbHeroSoulViewItem = class("zbHeroSoulViewItem", CCNodeExtend)
zbHeroSoulViewItem.__index = zbHeroSoulViewItem

function zbHeroSoulViewItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulViewItem)

	return arg_1_0
end

function zbHeroSoulViewItem.create(arg_2_0)
	local var_2_0 = zbHeroSoulViewItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbHeroSoulViewItem.init(arg_3_0)
	function initMember()
		arg_3_0.spriteHero = {}
		arg_3_0.nodeJiacheng = {}
		arg_3_0.spriteJianghun = {}
		arg_3_0.spriteJibie = {}
		arg_3_0.lbActivity = {}
		arg_3_0.btnHero = {}
		arg_3_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

		arg_3_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herosoul.plist")
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
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
	end

	initMember()
	initCCB()
end

function zbHeroSoulViewItem.gotoHeroSoulView(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.myIndex = arg_7_1
	arg_7_0.hallData = arg_7_2
	arg_7_0.hallRecord = arg_7_3

	local var_7_0 = string.format("ccbi/heroSoulview_%02d.ccbi", arg_7_1)
	local var_7_1 = CCBProxy:create()
	local var_7_2 = CCBReaderLoad(var_7_0, var_7_1, true, "HelloCocosBuilderLayerOwner", true)
	local var_7_3 = tolua.cast(var_7_2:getChildByTag(1), "CCNode")

	for iter_7_0 = 1, 5 do
		arg_7_0.spriteHero[iter_7_0] = tolua.cast(var_7_3:getChildByTag(iter_7_0), "CCSprite")

		local var_7_4 = tolua.cast(var_7_3:getChildByTag(100), "CCNode")

		arg_7_0.nodeJiacheng[iter_7_0] = tolua.cast(var_7_4:getChildByTag(iter_7_0), "CCSprite")
		arg_7_0.spriteJianghun[iter_7_0] = tolua.cast(arg_7_0.nodeJiacheng[iter_7_0]:getChildByTag(1), "CCSprite")
		arg_7_0.spriteJibie[iter_7_0] = tolua.cast(arg_7_0.nodeJiacheng[iter_7_0]:getChildByTag(2), "CCSprite")
		arg_7_0.lbActivity[iter_7_0] = tolua.cast(var_7_4:getChildByTag(iter_7_0 + 10), "CCLabelTTF")
		arg_7_0.btnHero[iter_7_0] = tolua.cast(var_7_4:getChildByTag(iter_7_0 + 20), "CCControlButton")

		arg_7_0.btnHero[iter_7_0]:setTouchPriority(g_MainScene.wndHeroSoulView.moneyPanel.btnClose:getTouchPriority())
		arg_7_0.btnHero[iter_7_0]:addHandleOfControlEvent(function()
			arg_7_0:onHero(iter_7_0)
		end, CCControlEventTouchUpInside)
	end

	arg_7_0:removeAllChildrenWithCleanup(true)
	arg_7_0:addChild(var_7_2)
	arg_7_0:refresh()
end

function zbHeroSoulViewItem.refresh(arg_9_0)
	for iter_9_0 = 1, 5 do
		arg_9_0:refreshItem(iter_9_0, nil)
	end

	if zbUtil:isValidTable(arg_9_0.hallData) == true and zbUtil:isValidTable(arg_9_0.hallData.HeroSoulList) == true then
		for iter_9_1, iter_9_2 in pairs(arg_9_0.hallData.HeroSoulList) do
			arg_9_0:refreshItem(iter_9_2.Position, iter_9_2)
		end
	end
end

function zbHeroSoulViewItem.refreshItem(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_0.spriteHero[arg_10_1]:setColor(ccc3(25, 25, 25))
		arg_10_0.nodeJiacheng[arg_10_1]:setVisible(false)
		arg_10_0.lbActivity[arg_10_1]:setVisible(true)

		return
	end

	arg_10_0.spriteHero[arg_10_1]:setColor(ccc3(255, 255, 255))
	arg_10_0.nodeJiacheng[arg_10_1]:setVisible(true)
	arg_10_0.lbActivity[arg_10_1]:setVisible(false)

	local var_10_0 = 11

	for iter_10_0, iter_10_1 in pairs(arg_10_2.SoulList) do
		if iter_10_1.Status == 1 then
			var_10_0 = iter_10_1.HeroSoulId
		end
	end

	local var_10_1 = zbHeroSoulTable:getRecordUseId(var_10_0)

	if var_10_1 ~= nil then
		local var_10_2 = arg_10_0.spriteframeCache:spriteFrameByName("herosoul_dengjie0" .. var_10_1.quality .. ".png")

		if var_10_2 then
			arg_10_0.spriteJianghun[arg_10_1]:initWithSpriteFrame(var_10_2)
		end

		local var_10_3 = arg_10_0.spriteframeCache:spriteFrameByName("herosoul_sjibie0" .. var_10_1.grade .. ".png")

		if var_10_3 then
			arg_10_0.spriteJibie[arg_10_1]:initWithSpriteFrame(var_10_3)
		end
	end
end

function zbHeroSoulViewItem.onHero(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_0.hallData == nil or type(arg_11_0.hallData) ~= "table" then
		var_11_0 = nil
	else
		for iter_11_0, iter_11_1 in pairs(arg_11_0.hallData.HeroSoulList) do
			if arg_11_1 == iter_11_1.Position then
				var_11_0 = iter_11_1

				break
			end
		end
	end

	if var_11_0 == nil then
		g_MainScene:showHeroSoulList(arg_11_0.hallRecord, arg_11_1)
		g_MainScene.wndHeroSoulList:setPrevWnd(g_MainScene.wndHeroSoulView)
	else
		g_MainScene:showHeroSoulDetail(arg_11_0.hallRecord, arg_11_1, arg_11_0.hallData)
	end
end
