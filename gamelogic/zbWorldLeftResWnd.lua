require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbWorldLeftResWnd", zbBaseWnd)

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

function createWorldLeftResWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_leftres.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")

			var_5_3:setVisible(false)

			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.8)

			arg_3_0.awardItems[iter_5_0] = var_5_4

			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.awardItems[2]:getPositionX()
		arg_3_0.btnGet = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")

		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGet()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		})
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	for iter_9_0 = 1, 3 do
		arg_9_0.awardItems[iter_9_0]:setVisible(false)
	end

	local var_9_0 = 1

	for iter_9_1, iter_9_2 in pairs(arg_9_1) do
		if arg_9_0.awardItems[var_9_0] then
			arg_9_0.awardItems[var_9_0]:setVisible(true)
			arg_9_0.awardItems[var_9_0]:refreshAward(iter_9_2.Type, iter_9_2.Id, iter_9_2.Count)
		end

		var_9_0 = var_9_0 + 1
	end

	zbUIEffect:centerStar(arg_9_0.awardItems, arg_9_0.centerPositionX)
end

function var_0_0.onGet(arg_10_0)
	arg_10_0:hide()
	g_WsMsgHandler:WS_WorldRes_Settle_Req()
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
