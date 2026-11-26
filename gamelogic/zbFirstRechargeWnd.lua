require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbFirstRechargeWnd", zbBaseWnd)

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

function createFirstRechargeWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/firstcharge.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		for iter_5_0 = 1, 5 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")

			var_5_3:setVisible(false)

			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setNeedTip(true)
			var_5_4:setSupportTouchDownTip(false)
			var_5_4:setSupportTouchTip(true)

			if iter_5_0 ~= 1 then
				var_5_4:setScale(0.7)
			end

			arg_3_0.items[iter_5_0] = var_5_4

			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.lbMoney = tolua.cast(var_5_2:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnGoto = tolua.cast(var_5_2:getChildByTag(7), "CCControlButton")
		arg_3_0.btnGetAward = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnGoto:addHandleOfControlEvent(function()
			arg_3_0:onCharge()
		end, CCControlEventTouchUpInside)
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

function var_0_0.refresh(arg_9_0)
	if zbUtil:isValidTable(g_GameData.VipInfo) and zbUtil:isValidTable(g_GameData.VipInfo.FirstBuy) then
		arg_9_0.lbMoney:setString(g_GameData.VipInfo.FirstBuy.Value)
		arg_9_0.btnGoto:setVisible(g_GameData.VipInfo.FirstBuy.State == 0)
		arg_9_0.btnGetAward:setVisible(g_GameData.VipInfo.FirstBuy.State == 1)

		for iter_9_0 = 1, 5 do
			arg_9_0.items[iter_9_0]:setVisible(false)
		end

		local var_9_0 = 1

		for iter_9_1, iter_9_2 in pairs(g_GameData.VipInfo.FirstBuy.AwardList) do
			arg_9_0.items[var_9_0]:refreshAward(iter_9_2.Type, iter_9_2.Id, iter_9_2.Count, false)

			if (iter_9_2.Type == ECommonAwardType.HeroFrag or iter_9_2.Type == ECommonAwardType.Hero or iter_9_2.Type == ECommonAwardType.Diamond or iter_9_2.Type == ECommonAwardType.BarMoney or iter_9_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Golden or iter_9_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_9_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_9_2.Id) > EItemQuality.Golden) and arg_9_0.scrollEffect[var_9_0] == nil then
				arg_9_0.scrollEffect[var_9_0] = g_EffectSystem:creatScrollEffect(arg_9_0.items[var_9_0], iter_9_2.Type)

				arg_9_0.scrollEffect[var_9_0]:setAnimation("animation", true)
			end

			arg_9_0.items[var_9_0]:setVisible(true)

			var_9_0 = var_9_0 + 1
		end
	end
end

function var_0_0.onCharge(arg_10_0)
	arg_10_0:hide()
	g_MainScene:showVipBuyWnd()
end

function var_0_0.onGetAward(arg_11_0)
	if zbUtil:isValidTable(g_GameData.VipInfo) and zbUtil:isValidTable(g_GameData.VipInfo.FirstBuy) then
		for iter_11_0, iter_11_1 in pairs(g_GameData.VipInfo.FirstBuy.AwardList) do
			if iter_11_1.Type == ECommonAwardType.Hero then
				g_Self.kActivityHandler.lastTemplateId = iter_11_1.Id

				break
			end
		end

		arg_11_0:hide()
		g_WsMsgHandler:WS_ActivityAct_FirstRecharge_Req()
	end
end
