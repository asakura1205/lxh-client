local var_0_0 = class("zbLegionMemItem")

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

function createLegionMemItem(arg_2_0)
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

		arg_3_0.lbllevel = tolua.cast(var_5_1:getChildByTag(1001), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(3), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.5)

		arg_3_0.spoffice = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.lbltime = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")

		local var_5_4 = tolua.cast(var_5_0:getChildByTag(1007), "CCLabelTTF")

		arg_3_0.lbDonate = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbDonate)
		arg_3_0.lbDonate:setScale(0.65)

		arg_3_0.btnInfo = tolua.cast(var_5_0:getChildByTag(8), "CCControlButton")

		arg_3_0.btnInfo:addHandleOfControlEvent(function()
			arg_3_0:onInfo()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnInfo:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnInfo:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	arg_7_0:setVisible(arg_7_0.data ~= nil)

	if arg_7_0.data ~= nil then
		local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerBaseInfo.HeadId)

		arg_7_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
		arg_7_0.lbllevel:setString(arg_7_1.PlayerBaseInfo.Level)
		arg_7_0.lbVip:setString(arg_7_1.PlayerBaseInfo.VipLevel)
		arg_7_0.lblname:setString(arg_7_1.PlayerBaseInfo.RoleName)

		local var_7_1 = g_Self.kLegionHandler:getOfficeById(arg_7_1.PlayerBaseInfo.PlayerId)

		zbLegionHelp:setOfficeTexture(arg_7_0.spoffice, var_7_1)

		if arg_7_1.PlayerBaseInfo.Online == 1 then
			arg_7_0.lbltime:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_7_2 = math.max(g_Self.kTimeHandler:getServerTime() - arg_7_1.PlayerBaseInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_7_3 = zbUtil:getPassTimeShort(var_7_2)

			arg_7_0.lbltime:setString(var_7_3)
		end

		arg_7_0.lbDonate:setString(arg_7_1.MemberBaseInfo.Donate)
	end
end

function var_0_0.onInfo(arg_8_0)
	if arg_8_0.data then
		if arg_8_0.data.PlayerBaseInfo.PlayerId == g_GameData.BaseInfo.PlayerId then
			return
		end

		g_MainScene:showLegionMemInfo(arg_8_0.data)
	end
end
