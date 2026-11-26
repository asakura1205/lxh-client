require("gamebase.zbFunctions")

local var_0_0 = class("zbLegionBlessItem", CCNodeExtend)

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

function createLegionBlessItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	function initMember()
		arg_3_0.data = nil
	end

	function initCCB()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLv = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		local var_5_1 = tolua.cast(arg_3_0.spriteLv:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbDesc = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.nodeMoney = tolua.cast(var_5_0:getChildByTag(4), "CCNode")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.btnBless = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")
		arg_3_0.lbTimeDummy = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		arg_3_0.lbTime = zbTimeLabel:create(arg_3_0.lbTimeDummy, "", "")

		arg_3_0.lbTime:setCustomCallback(function()
			g_WsMsgHandler:WS_LegionGame_GetBless_Req()
		end)
		arg_3_0.btnBless:addHandleOfControlEvent(function()
			arg_3_0:onBless()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.5)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	initMember()
	initCCB()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	end

	arg_8_0.data = arg_8_1
	arg_8_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_8_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/legion.plist")

	local var_8_0 = arg_8_0.spriteframeCache:spriteFrameByName("bless_type" .. arg_8_1.AttrType .. ".png")

	if var_8_0 then
		arg_8_0.spriteBg:initWithSpriteFrame(var_8_0)
	end

	local var_8_1 = math.max(arg_8_1.EndTm - g_Self.kTimeHandler:getServerTime(), 0)

	if arg_8_1.Level == 0 or var_8_1 <= 0 then
		arg_8_0.spriteBg:setGray(true)
		arg_8_0.spriteLv:setVisible(false)
		arg_8_0.lbDesc:setString(a2u("δ\xBF\xAA\xC6\xF4"))
		zbUtil:setButtonTitle(arg_8_0.btnBless, a2u("\xC6\xED\xB8\xA3"))
	else
		arg_8_0.spriteBg:setGray(false)
		arg_8_0.spriteLv:setVisible(true)
		arg_8_0.lbLevel:setString(arg_8_1.Level)
		arg_8_0.lbDesc:setString(a2u(getItemPropStr(arg_8_1.AttrType) .. "+" .. arg_8_1.Addition .. "%"))
		zbUtil:setButtonTitle(arg_8_0.btnBless, a2u("\xBC\xCC\xD0\xF8\xC6\xED\xB8\xA3"))
	end

	if arg_8_0.data.Level >= arg_8_0.data.MaxLevel and var_8_1 > 0 then
		arg_8_0.btnBless:setGray(true)
		arg_8_0.nodeMoney:setVisible(false)
	else
		arg_8_0.btnBless:setGray(false)
		arg_8_0.nodeMoney:setVisible(true)
		arg_8_0.lbMoney:setString(arg_8_1.Cost)
	end

	arg_8_0.lbTime:clear()
	arg_8_0.lbTime:start(var_8_1)
end

function var_0_0.onBless(arg_9_0)
	if arg_9_0.data then
		local var_9_0 = math.max(arg_9_0.data.EndTm - g_Self.kTimeHandler:getServerTime(), 0)

		if arg_9_0.data.Level >= arg_9_0.data.MaxLevel and var_9_0 > 0 then
			g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xC6\xED\xB8\xA3\xB5ȼ\xB6\xC9\xCF\xCFޡ\xA3"))

			return
		end

		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_9_0.data.Cost) == false then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7㡣"))

			return
		end

		g_WsMsgHandler:WS_LegionGame_BuyBless_Req(arg_9_0.data.AttrType)
	end
end
