require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbPubGetTenWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPubGetTenWnd()
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
		arg_3_0.pubItems = {}
		arg_3_0.effectNodes = {}
		arg_3_0.lastIndex = 0
		arg_3_0.initPos = {}
		arg_3_0.actionEnd = false
		arg_3_0.candoaction = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pub_ten.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.nodeAward = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCNode")
		arg_3_0.lbContinue = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCLabelTTF")

		for iter_5_0 = 1, 10 do
			local var_5_2 = tolua.cast(arg_3_0.nodeAward:getChildByTag(iter_5_0), "CCNode")
			local var_5_3 = createItem()

			var_5_3:setPosition(var_5_2:getPosition())
			arg_3_0.nodeAward:addChild(var_5_3, 100)

			arg_3_0.pubItems[iter_5_0] = var_5_3

			var_5_2:removeFromParentAndCleanup(true)

			arg_3_0.initPos[iter_5_0] = ccp(var_5_3:getPosition())
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if not zbUtil:isValidTable(arg_7_1) then
		return false
	end

	arg_7_0.candoaction = true
	arg_7_0.actionEnd = false

	arg_7_0:playUIEffect(arg_7_1)
end

function var_0_0.refreshItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_2.Type == ECommonAwardType.Hero then
		local var_8_0 = arg_8_0:createEffect()

		var_8_0:setAnimation("animation", true)
		var_8_0:setPosition(arg_8_3)
		arg_8_0.nodeAward:addChild(var_8_0, 0)
		table.insert(arg_8_0.effectNodes, var_8_0)

		if arg_8_4 then
			arg_8_0.candoaction = false

			arg_8_0:hide()
			g_MainScene:showPubGetHeroWnd(arg_8_2, true, true, nil, true)
		end
	end

	arg_8_1:refreshAward(arg_8_2.Type, arg_8_2.Id, arg_8_2.Count)
	arg_8_1:setVisible(true)
end

function var_0_0.playUIEffect(arg_9_0, arg_9_1)
	for iter_9_0 = 1, 10 do
		arg_9_0.pubItems[iter_9_0]:setVisible(false)
		arg_9_0.pubItems[iter_9_0]:setPosition(1136, 640)
		arg_9_0.pubItems[iter_9_0]:setScale(0.1)
		arg_9_0.pubItems[iter_9_0]:stopAllActions()
	end

	for iter_9_1, iter_9_2 in pairs(arg_9_0.effectNodes) do
		iter_9_2:removeFromParentAndCleanup(true)
	end

	if arg_9_0.lastIndex > 0 then
		for iter_9_3 = 1, arg_9_0.lastIndex do
			local var_9_0 = arg_9_0.pubItems[iter_9_3]
			local var_9_1 = arg_9_1[iter_9_3]

			if var_9_0 and var_9_1 then
				local var_9_2 = var_9_0:getContentSize()

				var_9_0:setPosition(arg_9_0.initPos[iter_9_3])
				var_9_0:setScale(1)

				local var_9_3 = ccp(arg_9_0.initPos[iter_9_3].x + var_9_2.width / 2, arg_9_0.initPos[iter_9_3].y + var_9_2.height / 2)

				arg_9_0:refreshItem(var_9_0, var_9_1, var_9_3)
			end
		end
	end

	local var_9_4 = table.getn(arg_9_1)

	local function var_9_5()
		if arg_9_0.candoaction == false then
			return
		end

		arg_9_0.lastIndex = arg_9_0.lastIndex + 1

		if arg_9_0.lastIndex > var_9_4 then
			arg_9_0.lastIndex = 0
			arg_9_0.candoaction = false
			arg_9_0.actionEnd = true

			return
		end

		local var_10_0 = arg_9_0.pubItems[arg_9_0.lastIndex]
		local var_10_1 = arg_9_1[arg_9_0.lastIndex]

		if var_10_0 and var_10_1 then
			local var_10_2 = var_10_0:getContentSize()
			local var_10_3 = ccp(arg_9_0.initPos[arg_9_0.lastIndex].x + var_10_2.width / 2, arg_9_0.initPos[arg_9_0.lastIndex].y + var_10_2.height / 2)

			arg_9_0:refreshItem(var_10_0, var_10_1, var_10_3, true)

			local var_10_4 = CCMoveTo:create(0.01, arg_9_0.initPos[arg_9_0.lastIndex])
			local var_10_5 = CCScaleTo:create(0.01, 3)
			local var_10_6 = CCScaleTo:create(0.05, 1)
			local var_10_7 = CCArray:create()

			var_10_7:addObject(var_10_4)
			var_10_7:addObject(var_10_5)
			var_10_7:addObject(var_10_6)
			var_10_7:addObject(CCDelayTime:create(0.1))

			if arg_9_0.lastIndex <= var_9_4 then
				var_10_7:addObject(CCCallFuncN:create(function()
					var_9_5()
				end))
			end

			local var_10_8 = CCSequence:create(var_10_7)

			var_10_0:stopAllActions()
			var_10_0:runAction(var_10_8)
			g_Audio:playSound(AudioDefine.UI_PUB_AWARD)
		end
	end

	var_9_5()
end

function var_0_0.createEffect(arg_12_0)
	local var_12_0 = createUIAnimation()

	var_12_0:refresh("effect/spine/ui_wupinkuang1/ui_wupinkuang1.json", "effect/spine/ui_wupinkuang1/ui_wupinkuang1.atlas")
	var_12_0:setAnchorPoint(ccp(0, 0))

	return var_12_0
end

function var_0_0.onTouchTest(arg_13_0)
	if arg_13_0.actionEnd == false then
		return
	end

	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layer, var_13_0.x, var_13_0.y) == false then
		arg_13_0.lastIndex = 0

		arg_13_0:hide()

		if g_MainScene.wndPub then
			g_MainScene.wndPub:setDrawNodeVisible(true)
		end
	end
end
