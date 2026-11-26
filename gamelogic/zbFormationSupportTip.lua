zbFormationSupportTip = class("zbFormationSupportTip")
zbFormationSupportTip.__index = zbFormationSupportTip

function zbFormationSupportTip.create(arg_1_0, arg_1_1)
	local var_1_0 = zbFormationSupportTip.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbFormationSupportTip.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.supportNode = {}
		arg_2_0.supportTitle = {}
		arg_2_0.supportAtt = {}
		arg_2_0.supportHero = {}
	end

	local function var_2_1()
		arg_2_0.uiNode = arg_2_1

		for iter_4_0 = 1, 3 do
			arg_2_0.supportNode[iter_4_0] = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCNode")
			arg_2_0.supportTitle[iter_4_0] = tolua.cast(arg_2_0.supportNode[iter_4_0]:getChildByTag(1), "CCLabelTTF")
			arg_2_0.supportAtt[iter_4_0] = tolua.cast(arg_2_0.supportNode[iter_4_0]:getChildByTag(2), "CCLabelTTF")
			arg_2_0.supportHero[iter_4_0] = tolua.cast(arg_2_0.supportNode[iter_4_0]:getChildByTag(3), "CCLabelTTF")

			arg_2_0.supportAtt[iter_4_0]:setVisible(false)
			arg_2_0.supportHero[iter_4_0]:setVisible(false)
		end
	end

	var_2_0()
	var_2_1()
end

function zbFormationSupportTip.show(arg_5_0)
	arg_5_0.uiNode:setVisible(true)

	for iter_5_0 = 1, 3 do
		local var_5_0 = g_Self.kFormation:getPartPropertyAdd(iter_5_0)

		arg_5_0.supportTitle[iter_5_0]:setString(var_5_0)
	end
end

function zbFormationSupportTip.hide(arg_6_0)
	arg_6_0.uiNode:setVisible(false)
end
