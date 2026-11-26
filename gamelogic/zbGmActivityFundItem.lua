local var_0_0 = class("zbGmActivityFundItem", CCNodeExtend)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createGmActivityFundItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.fundInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1010), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteGeted = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.btnGet = tolua.cast(var_5_0:getChildByTag(3), "CCControlButton")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.65)
		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGet:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGet:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(470, 105))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil or arg_7_2 == nil then
		return
	end

	arg_7_0.fundInfo = arg_7_1

	arg_7_0.lbMoney:setString(arg_7_1.Diamond)
	arg_7_0.lbLevel:setString(arg_7_1.Level)

	if arg_7_1.State == 0 and g_Self:getLevel() >= arg_7_1.Level and arg_7_2 == 1 then
		arg_7_0.btnGet:setVisible(true)
		arg_7_0.spriteGeted:setVisible(false)
	else
		arg_7_0.btnGet:setVisible(false)
		arg_7_0.spriteGeted:setVisible(true)

		arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

		arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")

		local var_7_0 = ""

		if arg_7_1.State == 0 and (g_Self:getLevel() < arg_7_1.Level or arg_7_2 == 0) then
			var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName("activity_wdc.png")
		else
			var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName("activity_ylq.png")
		end

		if var_7_0 and var_7_0 ~= "" then
			arg_7_0.spriteGeted:initWithSpriteFrame(var_7_0)
		end
	end
end

function var_0_0.onGet(arg_8_0)
	g_WsMsgHandler:WS_ActivityGm_FundAward_Req(arg_8_0.fundInfo.Level)
end
