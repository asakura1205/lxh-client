local var_0_0 = class("zbLegionRedGainItem")

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

function createLegionRedGainItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.hongbaoInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbSender = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.btnGain = tolua.cast(var_5_0:getChildByTag(4), "CCControlButton")
		arg_3_0.btnDesc = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")
		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.48)
		arg_3_0.btnGain:addHandleOfControlEvent(function()
			arg_3_0:onGain()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDesc:addHandleOfControlEvent(function()
			arg_3_0:onDesc()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGain:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnDesc:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGain:setSwallowsTouches(false)
		arg_3_0.btnDesc:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.hongbaoInfo = arg_8_1

	if arg_8_1 == nil then
		return
	end

	arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legion/red/red_type" .. arg_8_1.Type .. ".png"))
	arg_8_0.lbSender:setString(a2u(arg_8_1.RoleName))
	arg_8_0.lbCount:setString(arg_8_1.LeftCount .. "/" .. arg_8_1.SendCount)

	if arg_8_1.State == 1 or arg_8_1.LeftCount == 0 or g_GameData.LegionInfo.Hongbao.GainCount >= g_GameData.LegionInfo.Hongbao.GainMax then
		arg_8_0.btnGain:setVisible(false)
		arg_8_0.btnDesc:setVisible(true)
	else
		arg_8_0.btnGain:setVisible(true)
		arg_8_0.btnDesc:setVisible(false)
	end
end

function var_0_0.onGain(arg_9_0)
	if arg_9_0.hongbaoInfo ~= nil then
		g_WsMsgHandler:WS_LegionGame_GainHongbao_Req(arg_9_0.hongbaoInfo.UUID)
	end
end

function var_0_0.onDesc(arg_10_0)
	if arg_10_0.hongbaoInfo ~= nil then
		g_MainScene:showLegionRedRank(arg_10_0.hongbaoInfo.Type)
		g_WsMsgHandler:WS_LegionGame_GainHongbao_Req(arg_10_0.hongbaoInfo.UUID)
	end
end
