require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroDesc")

local var_0_0 = class("zbHeroDecomposeWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 5
local var_0_2 = ccp(-14.9, 40.7)
local var_0_3 = 0.8

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroDecomposeWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	arg_3_0.effectList = {}
	arg_3_0.heroDescList = {}

	local function var_3_0()
		arg_3_0.effectList = {}
		arg_3_0.heroDescList = {}
		arg_3_0.startIndex = 1
		arg_3_0.showTips = false
		arg_3_0.tempList = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/hero_decompose.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layerDetail = var_5_1

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.effectRoot = tolua.cast(var_5_1:getChildByTag(300), "CCNode")
		arg_3_0.matLayer = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		arg_3_0.matRoot = {}
		arg_3_0.matRootPos = {}
		arg_3_0.matBtn = {}
		arg_3_0.matFrame = {}
		arg_3_0.matIcon = {}
		arg_3_0.matStar = {}
		arg_3_0.matNum = {}

		for iter_5_0 = 1, var_0_1 do
			arg_3_0.matRoot[iter_5_0] = tolua.cast(arg_3_0.matLayer:getChildByTag(iter_5_0), "CCLayerColor")
			arg_3_0.matBtn[iter_5_0] = tolua.cast(arg_3_0.matRoot[iter_5_0]:getChildByTag(1), "CCControlButton")
			arg_3_0.matFrame[iter_5_0] = tolua.cast(arg_3_0.matRoot[iter_5_0]:getChildByTag(2), "CCSprite")
			arg_3_0.matIcon[iter_5_0] = tolua.cast(arg_3_0.matRoot[iter_5_0]:getChildByTag(3), "CCSprite")

			local var_5_3 = tolua.cast(arg_3_0.matRoot[iter_5_0]:getChildByTag(5), "CCNode")

			arg_3_0.matStar[iter_5_0] = {}

			for iter_5_1 = 1, 8 do
				arg_3_0.matStar[iter_5_0][iter_5_1] = tolua.cast(var_5_3:getChildByTag(iter_5_1), "CCSprite")
			end

			arg_3_0.matNum[iter_5_0] = tolua.cast(arg_3_0.matRoot[iter_5_0]:getChildByTag(6), "CCLabelTTF")
			arg_3_0.matRootPos[iter_5_0] = ccp(arg_3_0.matRoot[iter_5_0]:getPosition())

			arg_3_0.matBtn[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:btnMatCallback(iter_5_0)
			end, CCControlEventTouchUpInside)
			arg_3_0.matBtn[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			arg_3_0.matBtn[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_0)
			end, CCControlEventTouchEnd)
		end

		arg_3_0.heroRoot = {}
		arg_3_0.heroBtn = {}

		for iter_5_2 = 1, var_0_1 do
			arg_3_0.heroRoot[iter_5_2] = tolua.cast(arg_3_0.matLayer:getChildByTag(iter_5_2 * 100), "CCSprite")
			arg_3_0.heroBtn[iter_5_2] = tolua.cast(arg_3_0.heroRoot[iter_5_2]:getChildByTag(1), "CCControlButton")

			arg_3_0.heroBtn[iter_5_2]:addHandleOfControlEvent(function()
				arg_3_0:btnAddCallback(iter_5_2)
			end, CCControlEventTouchUpInside)
			zbUIEffect:runFadeToAction(arg_3_0.heroBtn[iter_5_2])
		end

		arg_3_0.node_btn = tolua.cast(var_5_1:getChildByTag(102), "CCNode")
		arg_3_0.btnShop = tolua.cast(arg_3_0.node_btn:getChildByTag(3), "CCControlButton")

		arg_3_0.btnShop:addHandleOfControlEvent(function()
			arg_3_0:btnShopCallback()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnCleanMat = tolua.cast(var_5_2:getChildByTag(7), "CCControlButton")

		arg_3_0.btnCleanMat:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.cleanAllMat), CCControlEventTouchUpInside)

		arg_3_0.btnDecompose = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")

		arg_3_0.btnDecompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnDecomposeCallback), CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Soul
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:playerEffect()
	end, zbGameEvent.Event_HeroDecomposeSuccess)
end

function var_0_0.doShow(arg_13_0)
	arg_13_0:cleanAllMat()
end

function var_0_0.doHide(arg_14_0)
	return
end

function var_0_0.onUpdateHero(arg_15_0)
	for iter_15_0 = 1, var_0_1 do
		arg_15_0:cleanupMatSlot(iter_15_0)
		arg_15_0.heroRoot[iter_15_0]:setVisible(true)
		arg_15_0.matRoot[iter_15_0]:setVisible(false)
	end

	arg_15_0.btnCleanMat:setGray(true)
	arg_15_0.btnCleanMat:setEnabled(false)
end

function var_0_0.cleanAllMat(arg_16_0)
	for iter_16_0 = 1, var_0_1 do
		arg_16_0.matRoot[iter_16_0]:stopAllActions()
		arg_16_0:cleanupMatSlot(iter_16_0)
		arg_16_0.heroRoot[iter_16_0]:setVisible(true)
		arg_16_0.matRoot[iter_16_0]:setVisible(false)
	end

	arg_16_0.heroDescList = {}

	arg_16_0.btnCleanMat:setGray(true)
	arg_16_0.btnCleanMat:setEnabled(false)
end

function var_0_0.cleanupMatSlot(arg_17_0, arg_17_1)
	arg_17_0.matRoot[arg_17_1]:setPosition(arg_17_0.matRootPos[arg_17_1])
end

function var_0_0.refreshMatSlot(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == nil then
		return
	end

	local var_18_0 = zbHeroTable:getRecord(arg_18_2.heroDesc.heroTemplateId)

	if var_18_0 == nil then
		return
	end

	zbUIEffect:centerHeroStar(arg_18_0.matStar[arg_18_1], var_18_0.star)

	if arg_18_2.heroDesc.isFrag then
		arg_18_0.matNum[arg_18_1]:setString(arg_18_2.count)
	end

	local var_18_1 = zbColor:getHeroFragFrameTex(var_18_0.quality)

	arg_18_0.matFrame[arg_18_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_18_1))

	local var_18_2 = zbIconHelper:getHeroIconPath(arg_18_2.heroDesc.heroTemplateId)

	arg_18_0.matIcon[arg_18_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_18_2))
end

function var_0_0.showResult(arg_19_0)
	return
end

function var_0_0.fillMaterialSlots(arg_20_0, arg_20_1)
	if table.getn(arg_20_1) <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEBѡ\xD4\xF1\xC8\xDB\xC1\xB6\xCB\xE9Ƭ"))

		return
	end

	g_WsMsgHandler:WS_HeroFrag_Decompose_Req(arg_20_1)
end

function var_0_0.btnRuleCallback(arg_21_0)
	g_MainScene:showRuleWnd(RuleType_HeroDecompose)
end

function var_0_0.btnShopCallback(arg_22_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Shop) then
		return
	end

	g_MainScene:showShopWnd(EShopTab.Mystery)
	g_MainScene.wndShop:setPrevWnd(arg_22_0)
end

function var_0_0.btnDecomposeCallback(arg_23_0)
	arg_23_0:fillMaterialSlots(arg_23_0.heroDescList)
end

function var_0_0.btnMatCallback(arg_24_0, arg_24_1)
	if arg_24_0.showTips == false then
		arg_24_0.matRoot[arg_24_1]:setVisible(false)
		arg_24_0.heroRoot[arg_24_1]:setVisible(true)

		local var_24_0 = arg_24_0.tempList[arg_24_1]

		arg_24_0:removeItem(var_24_0)
	end
end

function var_0_0.removeItem(arg_25_0, arg_25_1)
	if table.getn(arg_25_0.heroDescList) <= 0 or arg_25_1 == nil then
		arg_25_0.btnCleanMat:setGray(true)
		arg_25_0.btnCleanMat:setEnabled(false)

		return
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.heroDescList) do
		if iter_25_1.heroDesc.heroTemplateId == arg_25_1 then
			table.remove(arg_25_0.heroDescList, iter_25_0)

			if table.getn(arg_25_0.heroDescList) <= 0 then
				arg_25_0.btnCleanMat:setGray(true)
				arg_25_0.btnCleanMat:setEnabled(false)
			end

			return
		end
	end
end

function var_0_0.onTouchDown(arg_26_0, arg_26_1)
	arg_26_0.showTips = false
	arg_26_0.lastDownTouch = arg_26_0.matBtn[arg_26_1]:getTouch():getLocation()

	local var_26_0 = CCArray:create()

	var_26_0:addObject(CCDelayTime:create(0.3))
	var_26_0:addObject(CCCallFuncN:create(function()
		arg_26_0:onShowTips(arg_26_1)
	end))

	local var_26_1 = CCSequence:create(var_26_0)

	arg_26_0:stopAllActions()
	arg_26_0:runAction(var_26_1)
end

function var_0_0.onShowTips(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.layerDetail

	while var_28_0:getParent() ~= nil do
		var_28_0 = var_28_0:getParent()
	end

	if arg_28_0.heroDescList[arg_28_1] ~= nil then
		arg_28_0.showTips = true

		local var_28_1 = var_28_0:convertToNodeSpace(arg_28_0.lastDownTouch)

		g_MainScene:showAwardTip(ECommonAwardType.HeroFrag, arg_28_0.heroDescList[arg_28_1].heroDesc.heroTemplateId)
		g_MainScene.wndCommomTip:refreshPos(var_28_1)
	end
end

function var_0_0.onTouchEnd(arg_29_0, arg_29_1)
	arg_29_0:stopAllActions()

	if g_MainScene.wndCommomTip ~= nil then
		g_MainScene.wndCommomTip:hideTips()
	end
end

function var_0_0.btnAddCallback(arg_30_0, arg_30_1)
	arg_30_0.startIndex = arg_30_1

	g_MainScene:showHeroDecomposeHeroSelect(arg_30_0.heroDescList)
	g_MainScene.wndHeroDecomposeHeroSelect:setCallback(handler(arg_30_0, arg_30_0.heroSelectBack))
end

function var_0_0.heroSelectBack(arg_31_0, arg_31_1)
	for iter_31_0 = 1, var_0_1 do
		arg_31_0:cleanupMatSlot(iter_31_0)
		arg_31_0.heroRoot[iter_31_0]:setVisible(true)
		arg_31_0.matRoot[iter_31_0]:setVisible(false)
	end

	arg_31_0.heroDescList = arg_31_1
	arg_31_0.tempList = {}

	for iter_31_1, iter_31_2 in pairs(arg_31_1) do
		arg_31_0.tempList[iter_31_1] = iter_31_2.heroDesc.heroTemplateId
	end

	if table.getn(arg_31_1) == 0 then
		arg_31_0.btnCleanMat:setGray(true)
		arg_31_0.btnCleanMat:setEnabled(false)

		return
	end

	arg_31_0.btnCleanMat:setGray(false)
	arg_31_0.btnCleanMat:setEnabled(true)

	local var_31_0
	local var_31_1 = 0
	local var_31_2 = table.getn(arg_31_1)

	local function var_31_3()
		arg_31_0:refreshMatSlot(var_31_1, arg_31_1[var_31_1])
		arg_31_0.heroRoot[var_31_1]:setVisible(false)
		arg_31_0.matRoot[var_31_1]:setVisible(true)
		arg_31_0.matRoot[var_31_1]:setPosition(arg_31_0.matRootPos[var_31_1])
	end

	local function var_31_4()
		var_31_0()
	end

	function var_31_0()
		var_31_1 = var_31_1 + 1

		local var_34_0 = CCArray:create()

		var_34_0:addObject(CCCallFuncN:create(function()
			var_31_3()
		end))
		var_34_0:addObject(CCScaleTo:create(0.1, 1.05))
		var_34_0:addObject(CCScaleTo:create(0.1, 1))

		if var_31_1 < var_31_2 then
			var_34_0:addObject(CCCallFuncN:create(function()
				var_31_4()
			end))
		end

		local var_34_1 = CCSequence:create(var_34_0)

		arg_31_0.matRoot[var_31_1]:stopAllActions()
		arg_31_0.matRoot[var_31_1]:runAction(var_34_1)
	end

	var_31_0()
end

function var_0_0.playerEffect(arg_37_0)
	local var_37_0 = 1
	local var_37_1 = table.getn(arg_37_0.heroDescList)

	arg_37_0.heroDescList = {}

	for iter_37_0 = 1, var_0_1 do
		arg_37_0.matRoot[iter_37_0]:setScale(1)

		if var_37_0 == var_37_1 then
			var_37_0 = 1

			local function var_37_2()
				g_Audio:playSound(AudioDefine.UI_HERO_DECOMPOSE_SUCCESS)
			end

			local function var_37_3()
				arg_37_0:onUpdateHero()
				arg_37_0:showResult()
			end

			local var_37_4 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))
			local var_37_5 = CCCallFuncN:create(var_37_2)
			local var_37_6 = CCDelayTime:create(0.8)
			local var_37_7 = CCCallFuncN:create(var_37_3)
			local var_37_8 = CCArray:create()

			var_37_8:addObject(var_37_4)
			var_37_8:addObject(var_37_5)
			var_37_8:addObject(var_37_6)
			var_37_8:addObject(var_37_7)
			arg_37_0.matRoot[iter_37_0]:runAction(CCSequence:create(var_37_8))
		else
			var_37_0 = var_37_0 + 1

			local var_37_9 = CCSpawn:createWithTwoActions(CCEaseIn:create(CCMoveTo:create(var_0_3, var_0_2), 0.9), CCScaleTo:create(var_0_3, 0))

			arg_37_0.matRoot[iter_37_0]:runAction(var_37_9)
		end
	end
end

function var_0_0.onFrameUpdate(arg_40_0)
	arg_40_0:updateBackEffect()
end
