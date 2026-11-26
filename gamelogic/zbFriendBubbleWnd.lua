require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbFriendBubbleWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createFriendBubbleWnd()
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
		arg_3_0.layerDescInitpos = ccp(0, 0)
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/friendbubble.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")

		arg_3_0.layerDesc = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.layerDescInitpos = ccp(arg_3_0.layerDesc:getPosition())
		arg_3_0.lbldesc = tolua.cast(arg_3_0.layerDesc:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.layerDesc:setVisible(true)
		arg_7_0.layerDesc:setPosition(arg_7_0.layerDescInitpos)
		arg_7_0:setDesc(arg_7_1)

		local function var_7_0()
			arg_7_0.layerDesc:setVisible(false)
			arg_7_0:hide()
		end

		local var_7_1 = CCMoveBy:create(2, ccp(0, 200))
		local var_7_2 = CCCallFunc:create(var_7_0)
		local var_7_3 = CCSequence:createWithTwoActions(var_7_1, var_7_2)

		arg_7_0.layerDesc:stopAllActions()
		arg_7_0.layerDesc:runAction(var_7_3)
	end
end

function var_0_0.setDesc(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.ActionList[1]
	local var_9_1 = var_9_0.PlayerId
	local var_9_2 = var_9_0.ActionType
	local var_9_3 = ""
	local var_9_4 = g_Self.kFriendHandler:getActionInfo(var_9_0.ActionType)

	if var_9_4 then
		var_9_3 = var_9_4.action_des
	end

	if var_9_3 ~= "" then
		local var_9_5 = math.max(g_Self.kTimeHandler:getServerTime() - var_9_0.ActionTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
		local var_9_6 = zbUtil:getPassTimeShort(var_9_5)
		local var_9_7 = a2u("\xC4\xE3")
		local var_9_8 = arg_9_1.PlayerBaseInfo.RoleName
		local var_9_9 = string.format(var_9_3, var_9_7, var_9_8) .. string.format(a2u(",\xD4\xF6\xBCӺøж\xC8%d\xB5\xE3"), var_9_0.ActionValue)

		arg_9_0.lbldesc:setString(var_9_9)
	end
end

function var_0_0.onTouchTest(arg_10_0)
	local var_10_0 = arg_10_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_10_0.layerDesc, var_10_0.x, var_10_0.y) == false then
		arg_10_0:hide()
	end
end
