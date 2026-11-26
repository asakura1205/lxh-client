local var_0_0 = class("zbChatHornItem")

var_0_0.__index = var_0_0

function createChatHorn(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.itemsState = 0
		arg_3_0.node = arg_3_1
	end

	local function var_3_1()
		arg_3_0.nodeMsg = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.scrollView = tolua.cast(arg_3_1:getChildByTag(2), "CCScrollView")

		arg_3_0.nodeMsg:removeFromParentAndCleanup(false)
		arg_3_0.nodeMsg:setPosition(0, 25)
		arg_3_0.scrollView:setContainer(arg_3_0.nodeMsg)

		arg_3_0.node_content = createChatContent()

		arg_3_0.nodeMsg:addChild(arg_3_0.node_content)
		arg_3_1:setVisible(false)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.actionInit(arg_6_0)
	arg_6_0.nodeMsg:setAnchorPoint(ccp(0, 0.5))
	arg_6_0.nodeMsg:setScaleY(0)
	arg_6_0.nodeMsg:setVisible(true)
	arg_6_0.node:setVisible(true)
end

function var_0_0.doHornAction(arg_7_0, arg_7_1)
	arg_7_0.itemsState = 1

	local var_7_0 = arg_7_1.SenderName .. ":" .. arg_7_1.ChatMsg

	arg_7_0.node_content:refresh(a2u(var_7_0), ccc3(254, 251, 0))

	local var_7_1 = 8 * arg_7_0.nodeMsg:getContentSize().width / arg_7_0.scrollView:getContentSize().width

	local function var_7_2()
		arg_7_0.nodeMsg:setVisible(false)
		arg_7_0.node:setVisible(false)
	end

	local function var_7_3()
		arg_7_0.itemsState = 0

		arg_7_0:refresh()
	end

	local var_7_4 = CCDelayTime:create(0.8)
	local var_7_5 = CCScaleTo:create(0.3, 1, 1)
	local var_7_6 = CCDelayTime:create(5)
	local var_7_7 = CCCallFuncN:create(var_7_2)
	local var_7_8 = CCDelayTime:create(1)
	local var_7_9 = CCCallFuncN:create(var_7_3)
	local var_7_10 = CCArray:create()

	var_7_10:addObject(var_7_4)
	var_7_10:addObject(var_7_5)
	var_7_10:addObject(var_7_6)
	var_7_10:addObject(var_7_7)
	var_7_10:addObject(var_7_8)
	var_7_10:addObject(var_7_9)

	local var_7_11 = CCSequence:create(var_7_10)

	arg_7_0:actionInit()
	arg_7_0.nodeMsg:stopAllActions()
	arg_7_0.nodeMsg:runAction(var_7_11)
end

function var_0_0.refresh(arg_10_0)
	if arg_10_0.itemsState == 0 then
		for iter_10_0 = 1, table.getn(g_Self.kChatHandler.hornChats) do
			local var_10_0 = g_Self.kChatHandler.hornChats[iter_10_0]

			if var_10_0 then
				arg_10_0:doHornAction(var_10_0)
			end

			table.remove(g_Self.kChatHandler.hornChats, iter_10_0)
		end
	end
end
