local var_0_0 = class("zbFriendTuijianItem")

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

function createFriendTuijianItem(arg_2_0)
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
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.lbLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLvRep)
		arg_3_0.lbLvRep:setScale(0.55)

		arg_3_0.lbfightRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbfightRep)
		arg_3_0.lbfightRep:setScale(0.55)

		arg_3_0.btnAdd = tolua.cast(var_5_0:getChildByTag(1006), "CCControlButton")

		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onAdd()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	if arg_7_1 == nil then
		return
	end

	local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.HeadId)

	arg_7_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	arg_7_0.lbname:setString(a2u(arg_7_1.RoleName))
	arg_7_0.lbfightRep:setString(arg_7_1.FV)
	arg_7_0.lbLvRep:setString(arg_7_1.Level)
	zbUtil:setBtnEnable(arg_7_0.btnAdd, true)
end

function var_0_0.onAdd(arg_8_0)
	if arg_8_0.data then
		zbUtil:setBtnEnable(arg_8_0.btnAdd, false)
		g_WsMsgHandler:WS_Friends_Apply_Req(arg_8_0.data.PlayerId)
	end
end
