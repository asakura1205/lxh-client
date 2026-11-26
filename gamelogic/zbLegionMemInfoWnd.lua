require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbLegionMemInfoWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionMemInfoWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

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

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionmeminfo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")

		arg_3_0.headIcon = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.lblname = tolua.cast(var_5_4:getChildByTag(3), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")

		arg_3_0.lbllv = tolua.cast(var_5_5:getChildByTag(1), "CCLabelTTF")

		local var_5_6 = tolua.cast(var_5_4:getChildByTag(4), "CCNode")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(1), "CCLabelTTF")

		arg_3_0.vipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.vipRep)
		arg_3_0.vipRep:setScale(0.55)

		arg_3_0.lblegionDonate = tolua.cast(var_5_4:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lblfightvalue = tolua.cast(var_5_4:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.lbllasttm = tolua.cast(var_5_4:getChildByTag(1007), "CCLabelTTF")

		local var_5_8 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.btnManage = tolua.cast(var_5_8:getChildByTag(1), "CCControlButton")
		arg_3_0.btnFight = tolua.cast(var_5_8:getChildByTag(2), "CCControlButton")
		arg_3_0.btnFriend = tolua.cast(var_5_8:getChildByTag(3), "CCControlButton")

		arg_3_0.btnManage:addHandleOfControlEvent(function()
			arg_3_0:onManage()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onChanlenge()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFriend:addHandleOfControlEvent(function()
			arg_3_0:onFriend()
		end, CCControlEventTouchUpInside)

		local var_5_9 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")

		arg_3_0.formationItems = {}

		for iter_5_0 = 1, 5 do
			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_11 = createItem()
			local var_5_12 = ccp(var_5_10:getPosition())

			var_5_11:setPosition(var_5_12.x, var_5_12.y)
			var_5_11:setAnchorPoint(ccp(0.5, 0.5))
			var_5_9:addChild(var_5_11)
			var_5_11:setVisible(false)

			arg_3_0.formationItems[iter_5_0] = var_5_11

			arg_3_0.formationItems[iter_5_0]:setScale(0.8)
			var_5_10:removeFromParentAndCleanup(true)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFormationInfo()
	end, zbGameEvent.Event_LegionMemBaseFormationAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.refresh(arg_14_0, arg_14_1)
	arg_14_0.data = arg_14_1

	if arg_14_1 then
		g_Self.kLegionHandler.bLegionMemBaseFormationInfoReq = true

		g_WsMsgHandler:WS_Player_Formation_Req(arg_14_1.PlayerBaseInfo.PlayerId)

		local var_14_0 = zbIconHelper:getPlayerHeadIconPath(arg_14_1.PlayerBaseInfo.HeadId)

		arg_14_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_0))
		arg_14_0.lblname:setString(a2u(arg_14_1.PlayerBaseInfo.RoleName))
		arg_14_0.lbllv:setString(arg_14_1.PlayerBaseInfo.Level)
		arg_14_0.vipRep:setString(arg_14_1.PlayerBaseInfo.VipLevel)

		if arg_14_1.PlayerBaseInfo.FV then
			arg_14_0.lblfightvalue:setString(arg_14_1.PlayerBaseInfo.FV)
		else
			arg_14_0.lblfightvalue:setString(0)
		end

		if arg_14_1.PlayerBaseInfo.Online == "1" then
			arg_14_0.lbllasttm:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_14_1 = math.max(g_Self.kTimeHandler:getServerTime() - arg_14_1.PlayerBaseInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_14_2 = zbUtil:getPassTimeShort(var_14_1)

			arg_14_0.lbllasttm:setString(a2u(var_14_2))
		end

		local var_14_3 = g_Self.kLegionHandler:getDonateValue(arg_14_1.PlayerBaseInfo.PlayerId)

		arg_14_0.lblegionDonate:setString(var_14_3)

		local var_14_4 = g_Self.kLegionHandler:getOfficeById(g_GameData.BaseInfo.PlayerId)

		arg_14_0.btnManage:setGray(var_14_4 ~= ELegionOffice.Leader)
		arg_14_0.btnManage:setEnabled(var_14_4 == ELegionOffice.Leader)

		for iter_14_0, iter_14_1 in pairs(arg_14_0.formationItems) do
			iter_14_1:setVisible(false)
		end
	end
end

function var_0_0.onUpdateFormationInfo(arg_15_0)
	if PlayerFormationInfo then
		local var_15_0 = 1

		for iter_15_0 = 1, table.getn(PlayerFormationInfo.HeroList) do
			local var_15_1 = PlayerFormationInfo.HeroList[iter_15_0]

			arg_15_0.formationItems[var_15_0]:setVisible(true)
			arg_15_0.formationItems[var_15_0]:refreshHero(var_15_1)

			var_15_0 = var_15_0 + 1
		end
	end
end

function var_0_0.onShowCallback(arg_16_0)
	return
end

function var_0_0.onChanlenge(arg_17_0)
	if PlayerFormationInfo then
		g_MainScene:showEmbattleLegionMem(PlayerFormationInfo)
		arg_17_0:hide()

		if g_MainScene.wndLegionMem then
			g_MainScene.wndLegionMem:hide()
		end

		if g_MainScene.wndLegionScene then
			g_MainScene.wndLegionScene:hide()
		end
	end
end

function var_0_0.onManage(arg_18_0)
	if arg_18_0.data then
		arg_18_0:hide()
		g_MainScene:showLegionMemMgr(arg_18_0.data)
	end
end

function var_0_0.onFriend(arg_19_0)
	if arg_19_0.data then
		g_WsMsgHandler:WS_Friends_Apply_Req(arg_19_0.data.PlayerBaseInfo.PlayerId)
	end
end

function var_0_0.onTouchTest(arg_20_0)
	local var_20_0 = arg_20_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_20_0.layerTouchTest, var_20_0.x, var_20_0.y) == false and zbUtil:PointInCtrl(arg_20_0.btnClose, var_20_0.x, var_20_0.y) == false then
		arg_20_0:hide()
	end
end
