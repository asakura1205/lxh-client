require("gamelogic.zbTabWnd")
require("gamelogic.zbFriendList")
require("gamelogic.zbFriendJhList")
require("gamelogic.zbFriendReqList")
require("gamelogic.zbFriendAddList")
require("gamelogic.zbFriendTuijianList")

local var_0_0 = class("zbFriendWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createFriendWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		local var_5_1 = CCBReaderLoad("ccbi/friend.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeFrind = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		arg_3_0.nodebJiaohu = tolua.cast(var_5_3:getChildByTag(2), "CCNode")
		arg_3_0.nodeReq = tolua.cast(var_5_3:getChildByTag(3), "CCNode")
		arg_3_0.nodeAdd = tolua.cast(var_5_3:getChildByTag(4), "CCNode")
		arg_3_0.nodeTuijian = tolua.cast(var_5_3:getChildByTag(5), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(10), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_4 = {
			[EFriendTab.FriendList] = tolua.cast(var_5_3:getChildByTag(11), "CCControlButton"),
			[EFriendTab.Jiaohu] = tolua.cast(var_5_3:getChildByTag(12), "CCControlButton"),
			[EFriendTab.Request] = tolua.cast(var_5_3:getChildByTag(13), "CCControlButton"),
			[EFriendTab.Add] = tolua.cast(var_5_3:getChildByTag(14), "CCControlButton"),
			[EFriendTab.Tuijian] = tolua.cast(var_5_3:getChildByTag(15), "CCControlButton")
		}
		local var_5_5 = {
			[EFriendTab.FriendList] = tolua.cast(arg_3_0.nodeFrind, "CCNode"),
			[EFriendTab.Jiaohu] = tolua.cast(arg_3_0.nodebJiaohu, "CCNode"),
			[EFriendTab.Request] = tolua.cast(arg_3_0.nodeReq, "CCNode"),
			[EFriendTab.Add] = tolua.cast(arg_3_0.nodeAdd, "CCNode"),
			[EFriendTab.Tuijian] = tolua.cast(arg_3_0.nodeTuijian, "CCNode")
		}
		local var_5_6 = {
			[EFriendTab.FriendList] = "image/tab/tab_friend_friendList.png",
			[EFriendTab.Jiaohu] = "image/tab/tab_friend_jiaohu.png",
			[EFriendTab.Request] = "image/tab/tab_friend_request.png",
			[EFriendTab.Add] = "image/tab/tab_friend_add.png",
			[EFriendTab.Tuijian] = "image/tab/tab_friend_tuijian.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EFriendTab.FriendList] = createFriendList(arg_3_0.nodeFrind, var_5_4[EFriendTab.FriendList])
		arg_3_0.module[EFriendTab.Jiaohu] = createFriendJhList(arg_3_0.nodebJiaohu, var_5_4[EFriendTab.Jiaohu])
		arg_3_0.module[EFriendTab.Request] = createFriendReqList(arg_3_0.nodeReq, var_5_4[EFriendTab.Request])
		arg_3_0.module[EFriendTab.Add] = createFriendAddList(arg_3_0.nodeAdd, var_5_4[EFriendTab.Add])
		arg_3_0.module[EFriendTab.Tuijian] = createFriendTuijianList(arg_3_0.nodeTuijian, var_5_4[EFriendTab.Tuijian])

		local function var_5_7(arg_8_0)
			local var_8_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_8_0:setPosition(100, 60)
			arg_8_0:addChild(var_8_0)
			zbUIEffect:createNotifyTagScaleAction(var_8_0)

			return var_8_0
		end

		arg_3_0.notifyApplyBtn = var_5_7(var_5_4[EFriendTab.Request])
		arg_3_0.notifyTiliBtn = var_5_7(var_5_4[EFriendTab.FriendList])
		arg_3_0.notifyJhBtn = var_5_7(var_5_4[EFriendTab.Jiaohu])

		arg_3_0:initTab(var_5_4, var_5_5, var_5_6)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_UpdateFriendInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onTuijianFriendAck()
	end, zbGameEvent.Event_FriendTuijian)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onSearchFriendAck()
	end, zbGameEvent.Event_FriendSearchAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFriendApplyAck()
	end, zbGameEvent.Event_UpdateFriendApplyAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFriendListAck()
	end, zbGameEvent.Event_UpdateFriendsAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFriendActionAck()
	end, zbGameEvent.Event_UpdateFriendsActionAck)
end

function var_0_0.refresh(arg_16_0)
	if g_Self.kFriendHandler.frienddata == nil then
		return
	end

	arg_16_0.module[arg_16_0.currTab]:refresh()
end

function var_0_0.onShowCallback(arg_17_0)
	arg_17_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_18_0)
	if arg_18_0.module[arg_18_0.currTab] then
		arg_18_0.module[arg_18_0.currTab]:refresh()
	end

	if arg_18_0.currTab == EFriendTab.Jiaohu then
		g_Self.kFriendHandler.firstInJhUI = true
	end

	for iter_18_0 = 1, table.getn(arg_18_0.tabButtons) do
		if arg_18_0.tabButtons[iter_18_0] then
			if iter_18_0 == arg_18_0.currTab then
				arg_18_0.tabButtons[iter_18_0]:setZOrder(ZORDER_TOP)
			else
				arg_18_0.tabButtons[iter_18_0]:setZOrder(ZORDER_BOTTOM)
			end
		end
	end
end

function var_0_0.onTuijianFriendAck(arg_19_0)
	arg_19_0.module[EFriendTab.Tuijian]:refreshList()
end

function var_0_0.onSearchFriendAck(arg_20_0)
	arg_20_0.module[EFriendTab.Add]:refreshList()
end

function var_0_0.onUpdateFriendApplyAck(arg_21_0)
	arg_21_0.module[EFriendTab.Request]:refresh()
end

function var_0_0.onUpdateFriendListAck(arg_22_0)
	arg_22_0.module[EFriendTab.FriendList]:refresh()
end

function var_0_0.onUpdateFriendActionAck(arg_23_0)
	arg_23_0.module[EFriendTab.Jiaohu]:refresh()
end

function var_0_0.onFrameUpdate(arg_24_0, arg_24_1)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_24_0.notifyApplyBtn:setVisible(g_Self.kFriendHandler:hasFriendsApply())
	arg_24_0.notifyTiliBtn:setVisible(g_Self.kFriendHandler:hasFriendsTiliNotify())
	arg_24_0.notifyJhBtn:setVisible(g_Self.kFriendHandler:hasFriendsJhNotify())
end

function var_0_0.onTouchTest(arg_25_0)
	local var_25_0 = arg_25_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_25_0.layerTouchTest, var_25_0.x, var_25_0.y) == false and zbUtil:PointInCtrl(arg_25_0.btnClose, var_25_0.x, var_25_0.y) == false then
		arg_25_0:hide()
	end
end
