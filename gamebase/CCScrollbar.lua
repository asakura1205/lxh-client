CCScrollbar = class("CCScrollbar", CCNodeExtend)
CCScrollbar.__index = CCScrollbar

local var_0_0 = 14

function CCScrollbar.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCScrollbar)

	return arg_1_0
end

function CCScrollbar.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = CCScrollbar.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function CCScrollbar.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.constheight = arg_3_3
	arg_3_0.tableView = tolua.cast(arg_3_1, "CCScrollView")
	arg_3_0.bgSprite = tolua.cast(arg_3_2:getChildByTag(1), "CCScale9Sprite")
	arg_3_0.sliderSprite = tolua.cast(arg_3_2:getChildByTag(2), "CCScale9Sprite")
	arg_3_0.container = arg_3_0.tableView
	arg_3_0.containerView = arg_3_0.container:getContentSize()

	arg_3_0.bgSprite:setContentSize(CCSizeMake(var_0_0, arg_3_0.constheight))
	arg_3_0.bgSprite:setPosition(CCPoint(0, 0))

	arg_3_0.lastViewHeight = arg_3_0.containerView.height
	arg_3_0.lastposOffsetY = arg_3_0.tableView:getContainer():getPositionY()
	arg_3_0.loadCallBack = arg_3_4
	arg_3_0.haveLoadShow = true
	arg_3_0.nodeBar = arg_3_2

	arg_3_0:update(true)
end

function CCScrollbar.refreshViewSize(arg_4_0)
	arg_4_0.containerView = arg_4_0.container:getContentSize()

	arg_4_0:update(true)
end

function CCScrollbar.refreshViewOffset(arg_5_0)
	arg_5_0.containerView = arg_5_0.container:getContentSize()

	arg_5_0.tableView:setContentOffset(ccp(0, arg_5_0.lastViewHeight - arg_5_0.containerView.height))

	arg_5_0.lastViewHeight = arg_5_0.containerView.height
	arg_5_0.haveLoadShow = true
end

local var_0_1 = 0.65

function CCScrollbar.update(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.tableView:getContainer():getPositionY()
	local var_6_1 = arg_6_0.constheight / arg_6_0.containerView.height

	arg_6_0.nodeBar:setVisible(var_6_1 < 0.9)

	if not arg_6_1 then
		if var_6_1 > 0.9 then
			return
		end

		if math.abs(arg_6_0.lastposOffsetY - var_6_0) < 3 and g_GameStateMachine:isOneSecondPassed() == false then
			return
		end
	end

	arg_6_0.sliderSprite:setContentSize(CCSizeMake(var_0_0, arg_6_0.constheight * var_6_1 * var_0_1))

	arg_6_0.lastposOffsetY = var_6_0

	local var_6_2 = arg_6_0.sliderSprite:getContentSize().height
	local var_6_3 = var_6_0 / (arg_6_0.constheight - arg_6_0.containerView.height) * (arg_6_0.constheight - var_6_2)

	if var_6_3 >= 0 and var_6_3 <= arg_6_0.constheight - var_6_2 then
		arg_6_0.sliderSprite:setPositionY(var_6_3)
	elseif var_6_3 > 5 then
		local var_6_4 = (2 * arg_6_0.constheight - var_6_2 - var_6_3) * var_6_1 * var_0_1

		if var_6_4 < 20 then
			var_6_4 = 20
		end

		arg_6_0.sliderSprite:setContentSize(CCSizeMake(var_0_0, var_6_4))
		arg_6_0.sliderSprite:setPositionY(arg_6_0.constheight - var_6_4)
	else
		local var_6_5 = math.abs(var_6_3)
		local var_6_6 = (arg_6_0.constheight - var_6_5) * var_6_1 * var_0_1

		if var_6_6 < 20 then
			var_6_6 = 20
		end

		arg_6_0.sliderSprite:setPositionY(0)
		arg_6_0.sliderSprite:setContentSize(CCSizeMake(var_0_0, var_6_6))

		if arg_6_0.loadCallBack and arg_6_0.haveLoadShow then
			arg_6_0.haveLoadShow = false

			arg_6_0.loadCallBack()
		end
	end
end
