require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionMemberManage", zbBaseWnd)

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

function createLegionMemManageWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.selindex = -1
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_member_manage.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnKickout = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnKickout:addHandleOfControlEvent(function()
			arg_3_0:onKickOut()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnConfirm = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

		arg_3_0.btnConfirm:addHandleOfControlEvent(function()
			arg_3_0:onConfirm()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeManage = {}
		arg_3_0.check = {}
		arg_3_0.selBtn = {}

		for iter_5_0 = 1, 3 do
			arg_3_0.nodeManage[iter_5_0] = tolua.cast(var_5_3:getChildByTag(iter_5_0 + 2), "CCNode")
			arg_3_0.check[iter_5_0] = tolua.cast(arg_3_0.nodeManage[iter_5_0]:getChildByTag(1), "CCNode")
			arg_3_0.selBtn[iter_5_0] = tolua.cast(arg_3_0.nodeManage[iter_5_0]:getChildByTag(2), "CCControlButton")

			arg_3_0.selBtn[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onSel(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0.layerTouchTest = var_5_3
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

function var_0_0.refresh(arg_11_0, arg_11_1)
	for iter_11_0 = 1, 3 do
		arg_11_0.check[iter_11_0]:setVisible(false)
	end

	arg_11_0.selindex = 1

	arg_11_0:onSel(arg_11_0.selindex)

	if arg_11_1 then
		arg_11_0.data = arg_11_1
	end
end

function var_0_0.onKickOut(arg_12_0)
	if arg_12_0.data then
		local function var_12_0()
			arg_12_0:hide()
			g_WsMsgHandler:WS_LegionManage_Kick_Req(arg_12_0.data.PlayerBaseInfo.PlayerId)
		end

		local var_12_1 = a2u("ȷ\xB6\xA8Ҫ\xB0\xD1") .. a2u(arg_12_0.data.PlayerBaseInfo.RoleName) .. a2u("\xCC߳\xF6\xBB\xE1\xB9\xDD\xC2\xF0?")

		g_MessageBox:showYesNo(var_12_1, var_12_0)
	end
end

function var_0_0.onSel(arg_14_0, arg_14_1)
	arg_14_0.selindex = arg_14_1

	for iter_14_0 = 1, 3 do
		arg_14_0.check[iter_14_0]:setVisible(false)
	end

	arg_14_0.check[arg_14_1]:setVisible(true)
end

function var_0_0.onConfirm(arg_15_0)
	if arg_15_0.selindex ~= -1 and arg_15_0.data then
		local function var_15_0()
			if arg_15_0.data then
				g_WsMsgHandler:WS_LegionManage_OfficeSet_Req(arg_15_0.data.PlayerBaseInfo.PlayerId, ELegionOffice.Leader)
			end
		end

		local var_15_1 = ""

		if arg_15_0.selindex == 1 then
			local var_15_2 = a2u("ȷ\xB6\xA8\xBD\xAB") .. a2u(arg_15_0.data.PlayerBaseInfo.RoleName) .. a2u("\xCC\xE1\xC9\xFDλ\xB9ݳ\xA4?ͬʱ\xD7Լ\xBA\xBD\xAB\xB3\xC9Ϊ\xC6\xD5ͨ\xB3\xC9Ա")

			g_MessageBox:showYesNo(var_15_2, var_15_0)
		elseif arg_15_0.selindex == 2 then
			if g_Self.kLegionHandler:getOfficeById(arg_15_0.data.PlayerBaseInfo.PlayerId) == ELegionOffice.Adviser then
				g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xCAǸ\xB1\xB9ݳ\xA4"))

				return
			end

			g_WsMsgHandler:WS_LegionManage_OfficeSet_Req(arg_15_0.data.PlayerBaseInfo.PlayerId, ELegionOffice.Adviser)
		elseif arg_15_0.selindex == 3 then
			if g_Self.kLegionHandler:getOfficeById(arg_15_0.data.PlayerBaseInfo.PlayerId) == ELegionOffice.Member then
				g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xCA\xC7\xC6\xD5ͨ\xB3\xC9Ա"))

				return
			end

			g_WsMsgHandler:WS_LegionManage_OfficeSet_Req(arg_15_0.data.PlayerBaseInfo.PlayerId, ELegionOffice.Member)
		end

		arg_15_0:hide()
	end
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.layerTouchTest, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end
