zbDarkNode = class("zbDarkNode", CCNodeExtend)
zbDarkNode.__index = zbDarkNode

local var_0_0 = 180

function zbDarkNode.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbDarkNode)

	return arg_1_0
end

function zbDarkNode.create(arg_2_0)
	local var_2_0 = zbDarkNode.extend(CCNodeExtend.extend(CCNodeExtend.extend(CCLayerColor:create(ccc4(0, 0, 0, 0)))))

	var_2_0:init()

	return var_2_0
end

function zbDarkNode.init(arg_3_0)
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setPosition(-5000, -5000)
	arg_3_0:setContentSize(CCSizeMake(10000, 10000))
	arg_3_0:setCascadeOpacityEnabled(true)
	arg_3_0:retain()
	arg_3_0:clear()
end

function zbDarkNode.clear(arg_4_0)
	arg_4_0.accumTime = 0
	arg_4_0.hiding = false
	arg_4_0.hero = nil
end

function zbDarkNode.free(arg_5_0)
	return
end

function zbDarkNode.showDarkNode(arg_6_0, arg_6_1)
	if arg_6_0.hero ~= nil then
		arg_6_0.hero:setZOrder(arg_6_0.hero:getInitZOrder())
	end

	arg_6_0.hero = arg_6_1

	if arg_6_0:getParent() ~= nil then
		arg_6_0:removeFromParentAndCleanup(false)
		arg_6_0.hero:addChild(arg_6_0)
		arg_6_0:setOpacity(var_0_0)
	else
		arg_6_0:removeFromParentAndCleanup(false)
		arg_6_0.hero:addChild(arg_6_0)
		arg_6_0:runAction(CCFadeTo:create(0.08, var_0_0))
	end

	arg_6_0:setZOrder(ZORDER_BOTTOM)
	arg_6_0.hero:setZOrder(ZORDER_TOP)

	arg_6_0.accumTime = 0
	arg_6_0.hiding = false
end

function zbDarkNode.hideDarkNode(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return
	end

	if arg_7_0.hero == nil then
		return
	end

	g_CombatSystem:resumeExclude(arg_7_1)
	arg_7_1:setZOrder(arg_7_1:getInitZOrder())

	if arg_7_0.hero:isSame(arg_7_1) then
		arg_7_0:removeFromParentAndCleanup(false)
		arg_7_0:stopAllActions()

		arg_7_0.hero = nil
	end
end

function zbDarkNode.isDarking(arg_8_0)
	return arg_8_0:getParent() ~= nil
end

function zbDarkNode.checkHide(arg_9_0)
	if arg_9_0:getParent() ~= nil then
		arg_9_0:removeFromParentAndCleanup(false)
	end

	if arg_9_0.hero ~= nil then
		g_CombatSystem:resumeExclude(arg_9_0.hero)
		arg_9_0.hero:setZOrder(arg_9_0.hero:getInitZOrder())

		arg_9_0.hero = nil
	end
end

function zbDarkNode.update(arg_10_0, arg_10_1)
	if arg_10_0.hero == nil then
		return
	end

	arg_10_0.accumTime = arg_10_0.accumTime + arg_10_1

	if arg_10_0.accumTime > 4.5 and g_CombatSystem:getLegend():isExecBigSkilling() == false and arg_10_0.hiding == false then
		arg_10_0:hideDarkNode(arg_10_0.hero)

		arg_10_0.hiding = true
	end

	if arg_10_0.accumTime > 4.5 then
		arg_10_0:checkHide()
	end
end

function zbDarkNode.resetSection(arg_11_0)
	if arg_11_0.hero == nil then
		return
	end

	arg_11_0.hero = nil

	if arg_11_0:getParent() ~= nil then
		arg_11_0:removeFromParentAndCleanup(false)
	end
end
