zbLegendDarkNode = class("zbLegendDarkNode", CCNodeExtend)
zbLegendDarkNode.__index = zbLegendDarkNode

local var_0_0 = 180

function zbLegendDarkNode.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegendDarkNode)

	return arg_1_0
end

function zbLegendDarkNode.create(arg_2_0)
	local var_2_0 = zbLegendDarkNode.extend(CCNodeExtend.extend(CCNodeExtend.extend(CCLayerColor:create(ccc4(0, 0, 0, 0)))))

	var_2_0:init()

	return var_2_0
end

function zbLegendDarkNode.init(arg_3_0)
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setPosition(-5000, -5000)
	arg_3_0:setContentSize(CCSizeMake(10000, 10000))
	arg_3_0:setCascadeOpacityEnabled(true)
	arg_3_0:retain()
	arg_3_0:clear()
end

function zbLegendDarkNode.clear(arg_4_0)
	arg_4_0.accumTime = 0
	arg_4_0.hiding = false
end

function zbLegendDarkNode.free(arg_5_0)
	return
end

function zbLegendDarkNode.showDarkNode(arg_6_0)
	local function var_6_0()
		local var_7_0 = g_CombatSystem:getHeros(ForceType.Left)

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			return iter_7_1:getParent()
		end

		local var_7_1 = g_CombatSystem:getHeros(ForceType.Right)

		for iter_7_2, iter_7_3 in pairs(var_7_1) do
			return iter_7_3:getParent()
		end

		return nil
	end

	if arg_6_0:getParent() ~= nil then
		arg_6_0:removeFromParentAndCleanup(false)
	end

	if g_DarkNode:isDarking() == false then
		local var_6_1 = var_6_0()

		if var_6_1 ~= nil then
			var_6_1:addChild(arg_6_0)
		end
	end

	local var_6_2 = CCArray:create()

	var_6_2:addObject(CCFadeTo:create(0.08, var_0_0))

	local var_6_3 = CCSequence:create(var_6_2)

	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_3)
end

function zbLegendDarkNode.hideDarkNode(arg_8_0)
	if arg_8_0:getParent() ~= nil then
		arg_8_0:removeFromParentAndCleanup(false)
	end
end
