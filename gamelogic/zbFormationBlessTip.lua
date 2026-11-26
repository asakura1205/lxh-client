require("gamelogic.zbTimeLabel")

zbFormationBlessTip = class("zbFormationBlessTip")
zbFormationBlessTip.__index = zbFormationBlessTip

function zbFormationBlessTip.create(arg_1_0, arg_1_1)
	local var_1_0 = zbFormationBlessTip.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbFormationBlessTip.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.supportNode = {}
		arg_2_0.supportAtt = {}
		arg_2_0.timeLabelHelper = {}
		arg_2_0.supportTime = {}
	end

	local function var_2_1()
		arg_2_0.uiNode = arg_2_1
		arg_2_0.spriteBg = tolua.cast(arg_2_1:getChildByTag(0), "CCScale9Sprite")

		for iter_4_0 = 1, 5 do
			arg_2_0.supportNode[iter_4_0] = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCNode")
			arg_2_0.supportAtt[iter_4_0] = tolua.cast(arg_2_0.supportNode[iter_4_0]:getChildByTag(1), "CCLabelTTF")
			arg_2_0.supportTime[iter_4_0] = tolua.cast(arg_2_0.supportNode[iter_4_0]:getChildByTag(2), "CCLabelTTF")
			arg_2_0.timeLabelHelper[iter_4_0] = zbTimeLabel:create(arg_2_0.supportTime[iter_4_0], a2u(""), a2u(""))
		end
	end

	var_2_0()
	var_2_1()
end

function zbFormationBlessTip.show(arg_5_0)
	arg_5_0.uiNode:setVisible(true)

	for iter_5_0 = 1, 5 do
		arg_5_0.supportNode[iter_5_0]:setVisible(false)
		arg_5_0.supportAtt[iter_5_0]:setString(a2u("\xCE\xDE"))
	end

	if not g_GameData.LegionInfo or not (g_GameData.LegionInfo.LegionId > 0) then
		arg_5_0.supportNode[1]:setVisible(true)
		arg_5_0.spriteBg:setContentSize(CCSizeMake(320, 60))

		return
	end

	if g_Self.kLegionHandler.legionDetail.LegionBless == nil then
		arg_5_0.uiNode:setVisible(false)

		return nil
	end

	local var_5_0 = 0

	for iter_5_1, iter_5_2 in pairs(g_Self.kLegionHandler.legionDetail.LegionBless) do
		local var_5_1 = math.max(iter_5_2.EndTm - g_Self.kTimeHandler:getServerTime(), 0)

		if iter_5_2.Level == 0 or var_5_1 <= 0 then
			-- block empty
		else
			var_5_0 = var_5_0 + 1

			arg_5_0.supportAtt[var_5_0]:setString(a2u(a2u(getItemPropStr(iter_5_2.AttrType) .. "+" .. iter_5_2.Addition .. "%")))
			arg_5_0.supportNode[var_5_0]:setVisible(true)
			arg_5_0.timeLabelHelper[var_5_0]:start(var_5_1)
		end
	end

	local var_5_2 = math.max(var_5_0, 1)

	arg_5_0.supportNode[var_5_2]:setVisible(true)

	local var_5_3 = 30

	arg_5_0.spriteBg:setContentSize(CCSizeMake(320, var_5_3 + 30 * var_5_2))
end

function zbFormationBlessTip.hide(arg_6_0)
	arg_6_0.uiNode:setVisible(false)
end
