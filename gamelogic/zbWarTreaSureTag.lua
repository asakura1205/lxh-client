require("gamelogic.zbUIEffect")

local var_0_0 = class("zbWarTreaSureTag")

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

function createWarTreaSureTag(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local function var_3_0()
		arg_3_0.rootNode = arg_3_1
		arg_3_0.chapterId = arg_3_2
		arg_3_0.levelType = arg_3_3
		arg_3_0.firstIn = arg_3_4
	end

	local function var_3_1()
		arg_3_1:setVisible(false)

		arg_3_0.btnTouch = tolua.cast(arg_3_1:getChildByTag(100), "CCControlButton")
		arg_3_0.sptag = tolua.cast(arg_3_1:getChildByTag(50), "CCSprite")
		arg_3_0.spdot = {}

		for iter_5_0 = 1, 3 do
			arg_3_0.spdot[iter_5_0] = tolua.cast(arg_3_1:getChildByTag(iter_5_0), "CCSprite")
		end

		arg_3_0.title = tolua.cast(arg_3_1:getChildByTag(10), "CCSprite")

		arg_3_0.btnTouch:setTouchPriority(g_MainScene.wndWarForce.moneyPanel.btnClose:getTouchPriority())
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		local function var_5_0(arg_7_0)
			local var_7_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_7_0:setPosition(110, 60)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		arg_3_0.notify = var_5_0(arg_3_0.sptag)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	arg_8_0.btnTouch:setVisible(arg_8_0.firstIn == false)
	arg_8_0.sptag:setVisible(arg_8_0.firstIn == false)
	arg_8_0.title:setVisible(false)

	for iter_8_0 = 1, 3 do
		arg_8_0.spdot[iter_8_0]:setVisible(arg_8_0.firstIn == false)
	end

	arg_8_0.rootNode:setVisible(true)
	arg_8_0.notify:setVisible(g_Self.kTreaSureHandler:hasRedPoint(arg_8_0.chapterId))

	local function var_8_0()
		local function var_9_0()
			arg_8_0.sptag:setVisible(true)
			arg_8_0.btnTouch:setVisible(true)
			arg_8_0.title:setVisible(true)
		end

		local var_9_1 = 1

		local function var_9_2()
			if var_9_1 > 3 then
				arg_8_0.rootNode:stopAllActions()
				var_9_0()
			elseif arg_8_0.spdot[var_9_1] then
				arg_8_0.spdot[var_9_1]:setVisible(true)
			end

			var_9_1 = var_9_1 + 1
		end

		local var_9_3 = CCCallFuncN:create(var_9_2)
		local var_9_4 = CCDelayTime:create(0.3)
		local var_9_5 = CCSequence:createWithTwoActions(var_9_3, var_9_4)

		arg_8_0.rootNode:stopAllActions()
		arg_8_0.rootNode:runAction(CCRepeatForever:create(var_9_5))
	end

	if arg_8_0.firstIn then
		var_8_0()
	end
end

function var_0_0.onTouch(arg_12_0)
	g_MainScene:showTreasureTipWnd(arg_12_0.chapterId, arg_12_0.levelType)
end
