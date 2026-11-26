zbPataBuffTxt = class("zbPataBuffTxt", CCNodeExtend)
zbPataBuffTxt.__index = zbPataBuffTxt

function zbPataBuffTxt.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbPataBuffTxt)

	return arg_1_0
end

function zbPataBuffTxt.create(arg_2_0, arg_2_1)
	local var_2_0 = zbPataBuffTxt.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbPataBuffTxt.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.shopItemDummy = nil
		arg_3_0.shopItemDetail = nil
		arg_3_0.shopType = 0
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.lbBuff = tolua.cast(var_5_0:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbNum = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")

		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbPataBuffTxt.refresh(arg_6_0, arg_6_1)
	if type(arg_6_1) == "number" then
		local var_6_0 = zbBuffTable:getRecord(arg_6_1)

		arg_6_0.lbBuff:setString(var_6_0.name .. " +" .. var_6_0.pataDesc * 100 .. "%")
		arg_6_0.lbNum:setVisible(false)
	else
		local var_6_1 = zbBuffTable:getRecord(arg_6_1.BuffId)

		arg_6_0.lbBuff:setString(var_6_1.name .. " +" .. var_6_1.pataDesc * 100 .. "%")
		arg_6_0.lbNum:setString(a2u("(") .. arg_6_1.Count .. a2u(")"))
		arg_6_0.lbNum:setVisible(true)
	end
end
