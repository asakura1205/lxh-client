require("gamelogic.zbBaseWnd")
require("gamelogic.zbMailDetailAward")
require("gamelogic.zbMailDetailSystem")

local var_0_0 = class("zbMailDetailWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createMailDetailWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/mail_content.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerSystem = createSystemMail(tolua.cast(var_5_2:getChildByTag(20), "CCLayer"))
		arg_3_0.layerAward = createAwardMail(tolua.cast(var_5_2:getChildByTag(30), "CCLayer"))
		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:getAwardRefreshDetail()
	end, zbGameEvent.Event_Update_MailDetail)
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	arg_9_0.layerSystem:doHide()
	arg_9_0.layerAward:doHide()

	if arg_9_1 == nil then
		return
	end

	arg_9_0.mailInfo = arg_9_1

	arg_9_0.lbTitle:setString(arg_9_1.Title)

	if table.getn(arg_9_1.AwardList) > 0 then
		arg_9_0.layerAward:refreshAwardCase(arg_9_1)
	else
		arg_9_0.layerSystem:refreshTxtCase(arg_9_1)
	end
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:hide()

	if g_MainScene.wndMail then
		g_MainScene.wndMail:refresh()
	end
end

function var_0_0.getAwardRefreshDetail(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(g_Self.kMailHandler.MailList) do
		if iter_11_1.MailId == arg_11_0.mailInfo.MailId then
			arg_11_0:refresh(iter_11_1)

			return
		end
	end
end

function var_0_0.onTouchTest(arg_12_0)
	local var_12_0 = arg_12_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_12_0.layerTouchTest, var_12_0.x, var_12_0.y) == false and zbUtil:PointInCtrl(arg_12_0.btnClose, var_12_0.x, var_12_0.y) == false then
		arg_12_0:hide()

		if g_MainScene.wndMail then
			g_MainScene.wndMail:refresh()
		end
	end
end
