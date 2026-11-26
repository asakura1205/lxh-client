require("gamemain.zbGlobalVar")

CCSceneExtend = class("CCSceneExtend", CCNodeExtend)
CCSceneExtend.__index = CCSceneExtend

function CCSceneExtend.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCSceneExtend)

	local function var_1_1(arg_2_0)
		if arg_2_0 == "enter" then
			arg_1_0:onEnter()
		elseif arg_2_0 == "enterTransitionFinish" then
			arg_1_0:onEnterTransitionFinish()
		elseif arg_2_0 == "exitTransitionStart" then
			arg_1_0:onExitTransitionStart()
		elseif arg_2_0 == "cleanup" then
			arg_1_0:onCleanup()
		elseif arg_2_0 == "exit" then
			if arg_1_0.AUTO_CLEANUP_IMAGES then
				for iter_2_0, iter_2_1 in pairs(arg_1_0.AUTO_CLEANUP_IMAGES) do
					display.removeSpriteFrameByImageName(iter_2_0)
				end

				arg_1_0.AUTO_CLEANUP_IMAGES = nil
			end

			arg_1_0:onExit()

			if DEBUG_MEM then
				CCTextureCache:sharedTextureCache():dumpCachedTextureInfo()
			end
		elseif arg_2_0 == "cleanup" then
			arg_1_0:onCleanup()
		end
	end

	arg_1_0:registerNodeEvent(var_1_1)

	return arg_1_0
end

function CCSceneExtend.addAutoCleanImage(arg_3_0, arg_3_1)
	if not arg_3_0.AUTO_CLEANUP_IMAGES then
		arg_3_0.AUTO_CLEANUP_IMAGES = {}
	end

	arg_3_0.AUTO_CLEANUP_IMAGES[arg_3_1] = true
end

function CCSceneExtend.checkHit(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	if arg_4_1:getParent() == nil then
		var_4_0 = ccp(arg_4_1:getPosition())
	else
		var_4_0 = arg_4_1:getParent():convertToWorldSpace(ccp(arg_4_1:getPosition()))
	end

	local var_4_1 = arg_4_1:getAnchorPoint()
	local var_4_2
	local var_4_3 = arg_4_1:getScaleX()
	local var_4_4 = arg_4_1:getParent()

	while var_4_4 ~= nil do
		var_4_3 = var_4_3 * var_4_4:getScaleX()
		var_4_4 = var_4_4:getParent()
	end

	local var_4_5 = arg_4_1:getScaleY()
	local var_4_6 = arg_4_1:getParent()

	while var_4_6 ~= nil do
		var_4_5 = var_4_5 * var_4_6:getScaleY()
		var_4_6 = var_4_6:getParent()
	end

	local var_4_7 = arg_4_1:getContentSize().width * var_4_3
	local var_4_8 = arg_4_1:getContentSize().height * var_4_5

	return CCRectMake(var_4_0.x - var_4_1.x * var_4_7, var_4_0.y - var_4_1.y * var_4_8, var_4_7, var_4_8):containsPoint(ccp(arg_4_2, arg_4_3))
end

function CCSceneExtend.addUpDownBorder(arg_5_0)
	if not g_Layout:isWHRatio4_3() then
		return
	end

	local function var_5_0(arg_6_0, arg_6_1)
		local var_6_0 = CCLayerColor:create(ccc4(0, 0, 0, 255))

		var_6_0:setContentSize(CCSizeMake(g_Layout.FRAME_WIDTH, g_Layout:fullScreenWndOffsetY()))
		var_6_0:ignoreAnchorPointForPosition(false)
		var_6_0:setAnchorPoint(arg_6_0)
		var_6_0:setPosition(arg_6_1)
		arg_5_0:addChild(var_6_0)
		var_6_0:setZOrder(2147483647)

		local function var_6_1(arg_7_0, arg_7_1, arg_7_2)
			if arg_7_0 == TOUCH_EVENT_TYPE_BEGAN then
				return zbUtil:PointInCtrl(var_6_0, arg_7_1, arg_7_2)
			end
		end

		var_6_0:setTouchEnabled(true)
		var_6_0:registerScriptTouchHandler(var_6_1, false, -10000000, true)

		return var_6_0
	end

	var_5_0(ccp(0, 1), ccp(0, g_Layout.FRAME_HEIGHT))
	var_5_0(ccp(0, 0), ccp(0, 0))
end
