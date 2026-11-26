require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbOnlineAwardWnd", zbBaseWnd)

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

function createOnlineAwardWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/online_award.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeAward = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(arg_3_0.nodeAward:getChildByTag(iter_5_0), "CCNode")

			var_5_3:setVisible(false)

			local var_5_4 = createItem()

			var_5_4:setContentSize(CCSizeMake(110, 110))
			var_5_4:setPosition(var_5_3:getPosition())

			arg_3_0.items[iter_5_0] = var_5_4

			arg_3_0.nodeAward:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.OnlineAward) then
		for iter_7_0 = 1, 3 do
			arg_7_0.items[iter_7_0]:setVisible(false)
		end

		local var_7_0 = 1

		for iter_7_1, iter_7_2 in pairs(g_GameData.ActivityAct.OnlineAward.AwardList) do
			arg_7_0.items[var_7_0]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count)
			arg_7_0.items[var_7_0]:setVisible(true)

			var_7_0 = var_7_0 + 1
		end

		zbUIEffect:centerNodeItems(arg_7_0.items)
	end
end

function var_0_0.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layer, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()
	end
end
