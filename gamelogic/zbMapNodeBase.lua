zbMapNodeBase = class("zbMapNodeBase", CCNodeExtend)
zbMapNodeBase.__index = zbMapNodeBase

function zbMapNodeBase.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbMapNodeBase)

	return arg_1_0
end

function zbMapNodeBase.init(arg_2_0)
	arg_2_0.layer = nil
end

function zbMapNodeBase.pickTest(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.layer == nil or arg_3_0.layer:isVisible() == false then
		return false
	end

	local var_3_0 = arg_3_0:getAbsRect()

	if zbUtil:PointInRect(arg_3_1, arg_3_2, var_3_0) == false then
		return false
	end

	return true
end

function zbMapNodeBase.getAbsRect(arg_4_0)
	return CCRectMake(arg_4_0:getPositionX(), arg_4_0:getPositionY(), arg_4_0:getContentSize().width, arg_4_0:getContentSize().height)
end

function zbMapNodeBase.onClick(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return
end

function zbMapNodeBase.doClickAction(arg_6_0)
	local var_6_0 = CCScaleTo:create(0.1, 0.8)
	local var_6_1 = CCScaleTo:create(0.1, 1.2)
	local var_6_2 = CCScaleTo:create(0.1, 1)
	local var_6_3 = CCArray:create()

	var_6_3:addObject(var_6_0)
	var_6_3:addObject(var_6_1)
	var_6_3:addObject(var_6_2)

	local var_6_4 = CCSequence:create(var_6_3)

	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_4)
end

function zbMapNodeBase.reset(arg_7_0)
	return
end

function zbMapNodeBase.setlayerVisible(arg_8_0)
	return
end

function zbMapNodeBase.refreshInfo(arg_9_0)
	return
end

function zbMapNodeBase.refresh(arg_10_0)
	return
end

function zbMapNodeBase.update(arg_11_0)
	return
end
