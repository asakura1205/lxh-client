local var_0_0 = class("zbLegionItem")

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

function createLegionItem(arg_2_0)
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

		arg_3_0.sprank = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.lbrankRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbrankRep)
		arg_3_0.lbrankRep:setScale(1.2)

		arg_3_0.legionIcon = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.legionName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.legionlv = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.lblMemberNum = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		arg_3_0.lbcondition = tolua.cast(var_5_0:getChildByTag(7), "CCLabelTTF")
		arg_3_0.btnReq = tolua.cast(var_5_0:getChildByTag(8), "CCControlButton")

		arg_3_0.btnReq:addHandleOfControlEvent(function()
			arg_3_0:onReq()
		end, CCControlEventTouchUpInside)
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
		zbLegionHelp:setLegionRankTexture(arg_7_0.sprank, arg_7_0.lbrankRep, arg_7_1.Rank)

		local var_7_0 = zbIconHelper:getLegionIconPath(arg_7_1.IconId)

		arg_7_0.legionIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
		arg_7_0.legionName:setString(a2u(arg_7_1.LegionName))
		zbLegionHelp:setLegionLvTexture(arg_7_0.legionlv, arg_7_1.Level)
		arg_7_0.lblMemberNum:setString(arg_7_1.MemberCount .. "/" .. arg_7_1.MaxMemberCount)

		if arg_7_1.Confirm == 1 then
			arg_7_0.lbcondition:setString(arg_7_1.LimitLvl .. a2u("\xBC\xB6\xD2\xD4\xC9\xCF\xD0\xE8\xC9\xEA\xC7\xEB"))
		else
			arg_7_0.lbcondition:setString(arg_7_1.LimitLvl .. a2u("\xBC\xB6\xD2\xD4\xC9\xCF"))
		end
	end
end

function var_0_0.onReq(arg_8_0)
	local var_8_0 = g_GameData.LegionInfo.LeftTm

	if var_8_0 > 0 then
		g_MainScene:showLegionJoinCdClearWnd(var_8_0)

		return
	end

	if arg_8_0.data then
		g_WsMsgHandler:WS_Legion_Apply_Req(arg_8_0.data.LegionId)
	end
end
