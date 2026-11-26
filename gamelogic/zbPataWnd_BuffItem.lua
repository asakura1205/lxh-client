zbPataWnd_BuffItem = class("zbPataWnd_BuffItem", CCNodeExtend)
zbPataWnd_BuffItem.__index = zbPataWnd_BuffItem

function zbPataWnd_BuffItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbPataWnd_BuffItem)

	return arg_1_0
end

function zbPataWnd_BuffItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbPataWnd_BuffItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbPataWnd_BuffItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.ccNode = arg_3_1
		arg_3_0.type = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbBuff = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbUseNum = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteMoney = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(5), "CCLabelTTF")

		arg_3_0.lbDesc = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(7), "CCControlButton")

		arg_3_0.btnTouch:setZoomChildNode(var_5_0)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbPataWnd_BuffItem.refresh(arg_7_0, arg_7_1)
	arg_7_0.value = arg_7_1

	arg_7_0.spriteIcon:setGray(false)
	arg_7_0.lbDesc:setString(a2u("\xB5\xE3\xBB\xF7\xBC\xA4\xBB\xEE"))

	if arg_7_1.State == 1 then
		arg_7_0.spriteIcon:setGray(true)
		arg_7_0.lbDesc:setString(a2u("\xD2ѹ\xBA\xC2\xF2"))
	end

	local var_7_0 = zbBuffTable:getRecord(arg_7_1.BuffId)

	arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/bgz.plist")

	local var_7_1 = arg_7_0.spriteframeCache:spriteFrameByName("pata_buff_" .. var_7_0.buffType .. ".png")

	if var_7_1 then
		arg_7_0.spriteIcon:initWithSpriteFrame(var_7_1)
	end

	arg_7_0.lbBuff:setString(var_7_0.description)
	arg_7_0.lbUseNum:setString(a2u("\xBF\xC9ʹ\xD3\xC3") .. arg_7_1.Count .. a2u("\xB2\xE3"))

	icon, name, desc = zbIconHelper:getMoneyPanelIconPath(arg_7_1.CostItem.Type)

	arg_7_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage(icon))
	arg_7_0.lbMoney:setString(arg_7_1.CostItem.Count)
end

function zbPataWnd_BuffItem.onTouch(arg_8_0)
	if arg_8_0.value.State == 1 then
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xB9\xBA\xC2\xF2"))

		return
	end

	if arg_8_0.type == EPataStateType.SaoDang then
		g_WsMsgHandler:WS_Pata_SaoDangBuyBuff_Req(arg_8_0.value.BuffId)
	else
		g_WsMsgHandler:WS_Pata_BuyBuff_Req(arg_8_0.value.BuffId)
	end
end
