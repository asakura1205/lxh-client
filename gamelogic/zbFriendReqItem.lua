local var_0_0 = class("zbFriendReqItem")

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

function createFriendReqItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.headIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbname = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbLastTime = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lbLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLvRep)
		arg_3_0.lbLvRep:setScale(0.55)

		arg_3_0.btnAgree = tolua.cast(var_5_0:getChildByTag(1006), "CCControlButton")
		arg_3_0.btnRefuse = tolua.cast(var_5_0:getChildByTag(1007), "CCControlButton")

		arg_3_0.btnRefuse:addHandleOfControlEvent(function()
			arg_3_0:onRefuse()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAgree:addHandleOfControlEvent(function()
			arg_3_0:onAgree()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.data = arg_8_1

	arg_8_0:setVisible(arg_8_1 ~= nil)

	if arg_8_0.data ~= nil then
		local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.PlayerBaseInfo.HeadId)

		arg_8_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
		arg_8_0.lbname:setString(a2u(arg_8_1.PlayerBaseInfo.RoleName))
		arg_8_0.lbLvRep:setString(arg_8_1.PlayerBaseInfo.Level)

		local var_8_1 = math.max(g_Self.kTimeHandler:getServerTime() - arg_8_1.ApplyTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
		local var_8_2 = zbUtil:getPassTimeShort(var_8_1)

		arg_8_0.lbLastTime:setString(var_8_2)
	end
end

function var_0_0.onRefuse(arg_9_0)
	if arg_9_0.data then
		local function var_9_0()
			g_WsMsgHandler:WS_Friends_ApplyRefuse_Req(arg_9_0.data.PlayerBaseInfo.PlayerId)
		end

		g_MessageBox:showYesNo(a2u("ȷ\xB6\xA8\xBEܾ\xF8\xBA\xC3\xD3\xD1\xC9\xEA\xC7\xEB\xC2\xF0?"), var_9_0)
	end
end

function var_0_0.onAgree(arg_11_0)
	if arg_11_0.data then
		g_WsMsgHandler:WS_Friends_ApplyPass_Req(arg_11_0.data.PlayerBaseInfo.PlayerId)
	end
end
