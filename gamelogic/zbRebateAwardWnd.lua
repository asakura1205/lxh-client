require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRebateAwardWnd", zbBaseWnd)

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

function createRebateAwardWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rebate.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")

			var_5_3:setVisible(false)

			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.9)
			var_5_4:setNeedTip(true)
			var_5_4:setSupportTouchDownTip(false)
			var_5_4:setSupportTouchTip(true)

			arg_3_0.items[iter_5_0] = var_5_4

			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.items[2]:getPositionX()
		arg_3_0.btnGetAward = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnGetAward:addHandleOfControlEvent(function()
			arg_3_0:onGetAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.RebateAward) then
		for iter_8_0 = 2, 3 do
			arg_8_0.items[iter_8_0]:setVisible(false)
		end

		arg_8_0.items[1]:refreshAward(g_GameData.ActivityAct.RebateAward.AwardList[1].Type, g_GameData.ActivityAct.RebateAward.AwardList[1].Id, g_GameData.ActivityAct.RebateAward.AwardList[1].Count, false)

		if g_GameData.ActivityAct.RebateAward.VipExp ~= 0 then
			arg_8_0.items[2]:refreshAward(ECommonAwardType.VipExp, -1, g_GameData.ActivityAct.RebateAward.VipExp, false)
			arg_8_0.items[2]:setVisible(true)
		end

		if g_GameData.ActivityAct.RebateAward.Diamond ~= 0 then
			arg_8_0.items[3]:refreshAward(ECommonAwardType.Diamond, -1, g_GameData.ActivityAct.RebateAward.Diamond, false)
			arg_8_0.items[3]:setVisible(true)
		end

		for iter_8_1 = 1, 3 do
			if arg_8_0.items[iter_8_1]:isVisible() and arg_8_0.scrollEffect[iter_8_1] == nil then
				arg_8_0.scrollEffect[iter_8_1] = g_EffectSystem:creatScrollEffect(arg_8_0.items[iter_8_1], ECommonAwardType.Diamond)

				arg_8_0.scrollEffect[iter_8_1]:setAnimation("animation", true)
			end
		end

		zbUIEffect:centerStar(arg_8_0.items, arg_8_0.centerPositionX, 15)
	end
end

function var_0_0.onGetAward(arg_9_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.RebateAward) then
		local function var_9_0()
			g_WsMsgHandler:WS_ActivityAct_RebateAward_Req()
			arg_9_0:hide()
		end

		local var_9_1 = a2u("\xB8ý\xB1\xC0\xF8\xBD\xF6\xCF\xDEһ\xB8\xF6\xD5˺\xC5ʹ\xD3á\xA3")

		g_MessageBox:showYesNo(var_9_1, var_9_0)
	end
end
