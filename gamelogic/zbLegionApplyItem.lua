local var_0_0 = class("zbLegionApplyItem")

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

function createLegionApplyItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.lblname = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.headIcon = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		arg_3_0.lbllevel = tolua.cast(var_5_1:getChildByTag(1), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(3), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.5)

		arg_3_0.lbltime = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.btnYes = tolua.cast(var_5_0:getChildByTag(7), "CCControlButton")
		arg_3_0.btnNo = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")

		arg_3_0.btnYes:addHandleOfControlEvent(function()
			arg_3_0:OnYes()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnNo:addHandleOfControlEvent(function()
			arg_3_0:OnNo()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.data = arg_8_1

	arg_8_0:setVisible(arg_8_0.data ~= nil)

	if arg_8_0.data ~= nil then
		local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.HeadId)

		arg_8_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
		arg_8_0.lbllevel:setString(arg_8_1.Level)
		arg_8_0.lbVip:setString(arg_8_1.VipLevel)
		arg_8_0.lblname:setString(arg_8_1.RoleName)

		if arg_8_1.Online == 1 then
			arg_8_0.lbltime:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_8_1 = math.max(g_Self.kTimeHandler:getServerTime() - arg_8_1.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_8_2 = zbUtil:getPassTimeShort(var_8_1)

			arg_8_0.lbltime:setString(var_8_2)
		end
	end
end

function var_0_0.OnYes(arg_9_0)
	if arg_9_0.data then
		g_WsMsgHandler:WS_LegionManage_ApplyPass_Req(arg_9_0.data.PlayerId)
	end
end

function var_0_0.OnNo(arg_10_0)
	if arg_10_0.data then
		g_WsMsgHandler:WS_LegionManage_ApplyRefuse_Req(arg_10_0.data.PlayerId)
	end
end
