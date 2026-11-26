require("gamelogic.zbVipGiftItem")
require("gamelogic.zbAttributeLine")

local var_0_0 = class("zbVipTequanPanel")

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

function createVipTequanPanel(arg_2_0)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.layer = arg_3_1
		arg_3_0.giftItem = nil
		arg_3_0.curLv = 1
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = zbTableViewHelper:create()

		var_5_0:loadCCBFile("ccbi/tb_viptequan_gift.ccbi")

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(100), "CCLayerColor")

		arg_3_0.giftItem = createVipGiftItem(translateAndStrokeHelper(var_5_0:readCCBNode()))

		var_5_0:releaseSelf()

		local var_5_2 = ccp(var_5_1:getPosition())

		arg_3_0.giftItem:setPosition(var_5_2.x, var_5_2.y)
		arg_3_1:addChild(arg_3_0.giftItem)
		var_5_1:removeFromParentAndCleanup(true)

		arg_3_0.price = tolua.cast(arg_3_1:getChildByTag(1), "CCLabelTTF")
		arg_3_0.discountPrice = tolua.cast(arg_3_1:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnBuy = tolua.cast(arg_3_1:getChildByTag(3), "CCControlButton")

		arg_3_0.btnBuy:addHandleOfControlEvent(function()
			arg_3_0:onBuy()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnBuyed = tolua.cast(arg_3_1:getChildByTag(10), "CCControlButton")

		local function var_5_3(arg_7_0)
			local var_7_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_7_0:setPosition(160, 70)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		arg_3_0.notifyBuy = var_5_3(arg_3_0.btnBuy)

		local var_5_4 = tolua.cast(arg_3_1:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.curViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.curViplvRep)
		arg_3_0.curViplvRep:setScale(0.65)

		arg_3_0.layerVipDesc = tolua.cast(arg_3_1:getChildByTag(5), "CCLayer")

		local var_5_5 = tolua.cast(arg_3_1:getChildByTag(6), "CCNode")

		arg_3_0.leftArrow = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.rightArrow = tolua.cast(var_5_5:getChildByTag(2), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.leftArrow)
		zbUIEffect:runFadeToAction(arg_3_0.rightArrow)

		arg_3_0.leftButton = tolua.cast(var_5_5:getChildByTag(3), "CCControlButton")
		arg_3_0.rightButton = tolua.cast(var_5_5:getChildByTag(4), "CCControlButton")

		arg_3_0.leftButton:addHandleOfControlEvent(function()
			arg_3_0:onPageChange(2)
		end, CCControlEventTouchUpInside)
		arg_3_0.rightButton:addHandleOfControlEvent(function()
			arg_3_0:onPageChange(1)
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_10_0)
	arg_10_0.curViplvRep:setString(arg_10_0.curLv)
	arg_10_0.btnBuyed:setVisible(false)
	arg_10_0.btnBuy:setVisible(true)

	local var_10_0 = g_Self.kVipHandler:getVipGiftDetailByLevel(arg_10_0.curLv)

	if var_10_0 and arg_10_0.giftItem then
		arg_10_0.giftItem:refresh(var_10_0.AwardList)
		arg_10_0.price:setString(var_10_0.ShowDiamond)
		arg_10_0.discountPrice:setString(var_10_0.SaleDiamond)
		zbUtil:setBtnEnable(arg_10_0.btnBuy, var_10_0.State == 1)
		arg_10_0.notifyBuy:setVisible(var_10_0.State == 1)
		arg_10_0.btnBuyed:setVisible(var_10_0.State == 2)
		arg_10_0.btnBuy:setVisible(var_10_0.State ~= 2)
	end

	arg_10_0:refreshAtrribute()
end

function var_0_0.onBuy(arg_11_0)
	g_WsMsgHandler:WS_Vip_VipGiftBuy_Req(arg_11_0.curLv)
end

function var_0_0.onPageChange(arg_12_0, arg_12_1)
	if arg_12_1 == 1 then
		arg_12_0.curLv = arg_12_0.curLv + 1
	else
		arg_12_0.curLv = arg_12_0.curLv - 1
	end

	if arg_12_0.curLv > MAX_VIPLEVEL then
		arg_12_0.curLv = 1
	elseif arg_12_0.curLv < 1 then
		arg_12_0.curLv = MAX_VIPLEVEL
	end

	arg_12_0:refresh()
end

function var_0_0.refreshAtrribute(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.items) do
		iter_13_1:removeFromParentAndCleanup(false)
	end

	if arg_13_0.tableView ~= nil then
		arg_13_0.tableView:removeFromParentAndCleanup(true)

		arg_13_0.tableView = nil
		arg_13_0.tableViewHelper = nil
	end

	local var_13_0 = arg_13_0.layerVipDesc:getContentSize()
	local var_13_1 = CCSizeMake(var_13_0.width, var_13_0.height)
	local var_13_2 = CCSizeMake(var_13_0.width, var_13_0.height)

	arg_13_0.tableViewHelper = zbTableViewHelper:create()
	arg_13_0.tableView = zbTableViewHelper:createTableView(var_13_1, var_13_2, 1, arg_13_0.tableViewHelper, 0)

	arg_13_0.tableView:setPosition(ccp(0, 0))
	arg_13_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_13_0.layerVipDesc:addChild(arg_13_0.tableView)
	arg_13_0.tableViewHelper:refreshTabelView()

	local var_13_3 = zbVipTable:getVipLevelDesc(arg_13_0.curLv)
	local var_13_4 = table.maxn(var_13_3)

	for iter_13_2 = 1, var_13_4 do
		local var_13_5 = table.maxn(arg_13_0.items)
		local var_13_6

		if var_13_5 < iter_13_2 then
			local var_13_7 = zbTableViewHelper:create()

			var_13_7:loadCCBFile("ccbi/commonTextLine.ccbi")

			var_13_6 = createAttributeLine(var_13_7:readCCBNode())

			var_13_6:setDefaultColor(ccc3(90, 44, 30))
			var_13_6:retain()

			arg_13_0.items[iter_13_2] = var_13_6

			var_13_7:releaseSelf()
		else
			var_13_6 = arg_13_0.items[iter_13_2]
		end

		if var_13_6 ~= nil then
			local var_13_8 = var_13_3[iter_13_2]

			if var_13_8 then
				var_13_6:refresh(var_13_8, 0)
				arg_13_0.tableViewHelper:addCell(var_13_6)
			end
		end
	end

	arg_13_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndVip then
		arg_13_0.tableViewHelper:setTouchPriority(g_MainScene.wndVip.btnBuy:getTouchPriority())
	end
end

function var_0_0.setVisible(arg_14_0, arg_14_1)
	arg_14_0.layer:setVisible(arg_14_1)
end
