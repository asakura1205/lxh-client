require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbPubGetItemWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPubGetItemWnd()
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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pub_item.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		local var_5_2 = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLayerColor")
		local var_5_3 = createItem()

		var_5_3:setPosition(var_5_2:getPosition())
		var_5_3:setScale(0.9)
		var_5_3:setSwallowsTouches(false)
		arg_3_0.layer:addChild(var_5_3)

		arg_3_0.equipItemDummy = var_5_3

		var_5_2:removeFromParentAndCleanup(true)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.equipItemDummy:refreshAward(arg_7_1.Type, arg_7_1.Id, arg_7_1.Count)
end

function var_0_0.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layer, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()

		if g_MainScene.wndPub then
			g_MainScene.wndPub:setDrawNodeVisible(true)
		end
	end
end
