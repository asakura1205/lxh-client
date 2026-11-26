require("gamelogic.zbBaseWnd")
require("gamelogic.zbVipGiftItem")
require("gamelogic.zbAttributeLine")

local var_0_0 = class("zbShowVipLevelUpWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createVipLevelUpWnd()
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
		arg_3_0.giftItem = nil
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/viplevelup.ccbi", var_5_0, true, "")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCNode")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.btnFinish = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(arg_3_0.spriteBg:getChildByTag(31), "CCControlButton")

		local var_5_2 = zbTableViewHelper:create()

		var_5_2:loadCCBFile("ccbi/tb_viptequan_gift.ccbi")

		local var_5_3 = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCLayerColor")

		arg_3_0.giftItem = createVipGiftItem(translateAndStrokeHelper(var_5_2:readCCBNode()))

		var_5_2:releaseSelf()

		local var_5_4 = ccp(var_5_3:getPosition())

		arg_3_0.giftItem:setPosition(var_5_4.x, var_5_4.y)
		arg_3_0.spriteBg:addChild(arg_3_0.giftItem)
		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.layerVipDesc = tolua.cast(arg_3_0.spriteBg:getChildByTag(5), "CCLayer")

		local var_5_5 = tolua.cast(arg_3_0.spriteBg:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.curViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.curViplvRep)
		arg_3_0.curViplvRep:setScale(0.65)
		arg_3_0.btnFinish:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	local function var_3_2()
		arg_3_0.effect = createUIAnimation()

		arg_3_0.effect:refresh("effect/spine/zhanshi/zhanshi.json", "effect/spine/zhanshi/zhanshi.atlas")
		arg_3_0.effect:setPosition(0, 85)
		arg_3_0.nodeEffect:addChild(arg_3_0.effect)
	end

	var_3_0()
	var_3_1()
	var_3_2()
end

function var_0_0.refresh(arg_9_0)
	g_Audio:playSound(AudioDefine.UI_NEWHERO)
	arg_9_0:showDetails()
	arg_9_0:playEffect()
end

function var_0_0.onFinish(arg_10_0)
	if arg_10_0.btnClose:isVisible() == false then
		return
	end

	arg_10_0:hide()
	g_MainScene:showVipTequan()
end

function var_0_0.showDetails(arg_11_0)
	local var_11_0 = g_GameData.BaseInfo.VipLevel

	arg_11_0.curViplvRep:setString(var_11_0)

	local var_11_1 = g_Self.kVipHandler:getVipGiftDetailByLevel(var_11_0)

	if var_11_1 and arg_11_0.giftItem then
		arg_11_0.giftItem:refresh(var_11_1.AwardList)
	end

	arg_11_0:refreshAtrribute()
end

function var_0_0.refreshAtrribute(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		iter_12_1:removeFromParentAndCleanup(false)
	end

	if arg_12_0.tableView ~= nil then
		arg_12_0.tableView:removeFromParentAndCleanup(true)

		arg_12_0.tableView = nil
		arg_12_0.tableViewHelper = nil
	end

	local var_12_0 = arg_12_0.layerVipDesc:getContentSize()
	local var_12_1 = CCSizeMake(var_12_0.width, var_12_0.height)
	local var_12_2 = CCSizeMake(var_12_0.width, var_12_0.height)

	arg_12_0.tableViewHelper = zbTableViewHelper:create()
	arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_1, var_12_2, 1, arg_12_0.tableViewHelper, 0)

	arg_12_0.tableView:setPosition(ccp(0, 0))
	arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_12_0.layerVipDesc:addChild(arg_12_0.tableView)
	arg_12_0.tableViewHelper:refreshTabelView()

	local var_12_3 = zbVipTable:getVipLevelDesc(g_GameData.BaseInfo.VipLevel)
	local var_12_4 = table.maxn(var_12_3)

	for iter_12_2 = 1, var_12_4 do
		local var_12_5 = table.maxn(arg_12_0.items)
		local var_12_6

		if var_12_5 < iter_12_2 then
			local var_12_7 = zbTableViewHelper:create()

			var_12_7:loadCCBFile("ccbi/commonTextLine.ccbi")

			var_12_6 = createAttributeLine(var_12_7:readCCBNode())

			var_12_6:retain()

			arg_12_0.items[iter_12_2] = var_12_6

			var_12_7:releaseSelf()
		else
			var_12_6 = arg_12_0.items[iter_12_2]
		end

		if var_12_6 ~= nil then
			local var_12_8 = var_12_3[iter_12_2]

			if var_12_8 then
				var_12_6:refresh(var_12_8, 0)
				arg_12_0.tableViewHelper:addCell(var_12_6)
			end
		end
	end

	arg_12_0.tableViewHelper:refreshTabelView()
	arg_12_0.tableViewHelper:setTouchPriority(arg_12_0.btnClose:getTouchPriority())
end

function var_0_0.playEffect(arg_13_0)
	local var_13_0 = 0

	local function var_13_1(arg_14_0, arg_14_1, arg_14_2)
		local function var_14_0(arg_15_0)
			arg_15_0:setVisible(true)
		end

		local var_14_1 = CCArray:create()

		var_14_1:addObject(CCDelayTime:create(var_13_0))
		var_14_1:addObject(CCCallFuncN:create(var_14_0))
		arg_14_0:setVisible(false)
		arg_14_0:stopAllActions()
		arg_14_0:runAction(CCSequence:create(var_14_1))

		var_13_0 = var_13_0 + arg_14_1
	end

	arg_13_0.effect:playAnimationOnce("starup_1", "starup_2", 0.125)

	var_13_0 = var_13_0 + 0.5

	var_13_1(arg_13_0.spriteTitle, 0.25)
	var_13_1(arg_13_0.btnFinish, 0.25)
	var_13_1(arg_13_0.btnClose, 0.25)
end
