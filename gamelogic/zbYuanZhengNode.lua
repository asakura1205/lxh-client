require("gamelogic.zbYuanzhengItem")

zbYuanZhengNode = class("zbYuanZhengNode", CCNodeExtend)
zbYuanZhengNode.__index = zbYuanZhengNode

function zbYuanZhengNode.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbYuanZhengNode)

	return arg_1_0
end

function zbYuanZhengNode.create(arg_2_0)
	local var_2_0 = zbYuanZhengNode.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbYuanZhengNode.init(arg_3_0)
	function initMember()
		arg_3_0.itemBgz = {}
	end

	function initCCB()
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
	end

	initMember()
	initCCB()
end

function zbYuanZhengNode.gotoYuanZheng(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.myIndex = arg_6_1
	arg_6_0.bgzInfo = arg_6_2

	local var_6_0 = string.format("ccbi/yuanzheng_%d.ccbi", arg_6_1)
	local var_6_1 = CCBProxy:create()
	local var_6_2 = CCBReaderLoad(var_6_0, var_6_1, true, "HelloCocosBuilderLayerOwner", true)
	local var_6_3 = tolua.cast(var_6_2:getChildByTag(1), "CCNode")

	for iter_6_0 = 1, 6 do
		arg_6_0.itemBgz[iter_6_0] = createYuanzhengItem(tolua.cast(var_6_3:getChildByTag(iter_6_0), "CCNode"), iter_6_0)
	end

	arg_6_0:removeAllChildrenWithCleanup(true)
	arg_6_0:addChild(var_6_2)
	var_6_2:setPosition(0, 0)
	var_6_3:setVisible(arg_6_0.bgzInfo.CurLevel <= 8)
	arg_6_0:refresh()
end

function zbYuanZhengNode.refresh(arg_7_0)
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in pairs(arg_7_0.bgzInfo.LayerList) do
		arg_7_0.itemBgz[var_7_0]:refresh(iter_7_1)

		var_7_0 = var_7_0 + 1
	end

	arg_7_0.itemBgz[6].ccNode:setVisible(arg_7_0.bgzInfo.CurLevel >= 2)
	arg_7_0.itemBgz[6]:refresh()
end
