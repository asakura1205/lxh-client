require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionHelp")
require("gamelogic.zbLegionBuilding")

local var_0_0 = class("zbLegionScene", zbBaseWnd)

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

function createLegionSceneWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lastDownTouch = ccp(0, 0)
		arg_3_0.lastMoveTouch = ccp(0, 0)
		arg_3_0.legionDetail = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionscene.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(2), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.nodeLayer1 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.nodeLayer2 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.nodeLayer1:removeFromParentAndCleanup(false)
		arg_3_0.nodeLayer2:removeFromParentAndCleanup(false)

		local var_5_3 = CCParallaxNode:create()

		var_5_3:addChild(arg_3_0.nodeLayer1, 1, ccp(1, 1), ccp(0, 0))
		var_5_3:addChild(arg_3_0.nodeLayer2, 2, ccp(1.5, 1), ccp(-246, 0))

		arg_3_0.paraNode = var_5_3

		var_5_2:addChild(var_5_3)

		arg_3_0.lbltitle = tolua.cast(arg_3_0.nodeLayer2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnSign = tolua.cast(arg_3_0.nodeLayer2:getChildByTag(1), "CCControlButton")

		arg_3_0.btnSign:addHandleOfControlEvent(function()
			arg_3_0:onSignChange()
		end, CCControlEventTouchDown)
		arg_3_0.btnSign:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnSign:setSwallowsTouches(false)

		local var_5_4 = tolua.cast(arg_3_0.nodeLayer2:getChildByTag(2), "CCNode")

		arg_3_0.lblsign = tolua.cast(var_5_4:getChildByTag(1), "CCLabelTTF")

		local var_5_5 = tolua.cast(arg_3_0.nodeLayer2:getChildByTag(3), "CCNode")

		arg_3_0.building = {}

		for iter_5_0 = 1, 10 do
			local var_5_6 = tolua.cast(var_5_5:getChildByTag(iter_5_0), "CCNode")

			arg_3_0.building[iter_5_0] = createLegionBuild(var_5_6, iter_5_0)
		end

		arg_3_0.nodeinfo = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.nodeinfo:setZOrder(ZORDER_TOP)

		arg_3_0.legionIcon = tolua.cast(arg_3_0.nodeinfo:getChildByTag(1), "CCSprite")
		arg_3_0.legionName = tolua.cast(arg_3_0.nodeinfo:getChildByTag(2), "CCLabelTTF")
		arg_3_0.legionlv = tolua.cast(arg_3_0.nodeinfo:getChildByTag(3), "CCSprite")

		local var_5_7 = tolua.cast(arg_3_0.nodeinfo:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.legionFv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.legionFv)
		arg_3_0.legionFv:setScale(0.6)

		arg_3_0.spriteBarBg = tolua.cast(arg_3_0.nodeinfo:getChildByTag(4), "CCSprite")

		local function var_5_8(arg_10_0, arg_10_1)
			local var_10_0 = CCSprite:create(arg_10_1)

			var_10_0:setAnchorPoint(ccp(0, 0))

			local var_10_1 = CCProgressTimer:create(var_10_0)

			var_10_1:setAnchorPoint(ccp(0, 0))
			var_10_1:setPercentage(0)
			var_10_1:setMidpoint(ccp(0, 1))
			var_10_1:setBarChangeRate(ccp(1, 0))
			var_10_1:setType(kCCProgressTimerTypeBar)
			var_10_1:retain()
			arg_10_0:addChild(var_10_1)

			return var_10_1
		end

		arg_3_0.spriteBar = var_5_8(arg_3_0.spriteBarBg, "image/common/progress.png")

		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.onFrameUpdate(arg_14_0, arg_14_1)
	if arg_14_0.isShow == false then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.building) do
		iter_14_1:update()
	end
end

function var_0_0.refresh(arg_15_0)
	arg_15_0.legionDetail = g_Self.kLegionHandler.legionDetail

	if arg_15_0.legionDetail then
		local var_15_0 = zbIconHelper:getLegionIconPath(arg_15_0.legionDetail.LegionBaseInfo.IconId)

		arg_15_0.legionIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_15_0))
		arg_15_0.legionName:setString(a2u(arg_15_0.legionDetail.LegionBaseInfo.LegionName))
		zbLegionHelp:setLegionLvTexture(arg_15_0.legionlv, arg_15_0.legionDetail.LegionBaseInfo.Level)
		arg_15_0.legionFv:setString(a2u(arg_15_0.legionDetail.LegionBaseInfo.FV))

		local var_15_1 = zbLegionHelp:getLegionMaxExp(arg_15_0.legionDetail.LegionBaseInfo.Level)
		local var_15_2 = g_Self.kLegionHandler:getTechExp(ELegionTechType.Legion)
		local var_15_3 = math.min(math.ceil(100 * (var_15_2 / var_15_1)), 100)

		arg_15_0.spriteBar:setPercentage(var_15_3)
		arg_15_0.lblsign:setString(a2u(arg_15_0.legionDetail.LegionBaseInfo.Signature))

		local var_15_4 = g_Self.kLegionHandler:getOfficeById(g_GameData.BaseInfo.PlayerId)

		arg_15_0.lbltitle:setVisible(var_15_4 ~= ELegionOffice.Member)

		for iter_15_0, iter_15_1 in pairs(arg_15_0.building) do
			iter_15_1:refresh()
		end
	else
		g_WsMsgHandler:WS_Legion_GetData_Req()
	end
end

function var_0_0.onTouchDown(arg_16_0)
	arg_16_0.lastDownTouch = arg_16_0.btnTouch:getTouch():getLocation()
end

function var_0_0.onTouchMove(arg_17_0)
	arg_17_0.lastMoveTouch = arg_17_0.btnTouch:getTouch():getLocation()

	arg_17_0:moveScene(arg_17_0.lastMoveTouch.x - arg_17_0.lastDownTouch.x)

	arg_17_0.lastDownTouch = arg_17_0.lastMoveTouch
end

function var_0_0.moveScene(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.paraNode:getPositionX() + arg_18_1

	if var_18_0 >= -164 and var_18_0 <= 0 then
		arg_18_0.paraNode:setPositionX(var_18_0)
	end
end

function var_0_0.onTouchEnd(arg_19_0)
	return
end

function var_0_0.onSignChange(arg_20_0)
	if g_Self.kLegionHandler:getOfficeById(g_GameData.BaseInfo.PlayerId) ~= ELegionOffice.Member then
		g_MainScene:showChangeLegionSignWnd()
	end
end
