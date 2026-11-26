require("gamelogic.zbItem")

zbPataWnd_AwardItem = class("zbPataWnd_AwardItem", CCNodeExtend)
zbPataWnd_AwardItem.__index = zbPataWnd_AwardItem

function zbPataWnd_AwardItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbPataWnd_AwardItem)

	return arg_1_0
end

function zbPataWnd_AwardItem.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbPataWnd_AwardItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbPataWnd_AwardItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.ccNode = arg_3_1
		arg_3_0.type = arg_3_3
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.nodeBox = tolua.cast(var_5_0:getChildByTag(3), "CCNode")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeBox:getChildByTag(1), "CCSprite")

		local var_5_1 = tolua.cast(arg_3_0.nodeBox:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)

		arg_3_0.lbDesc = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnBox = tolua.cast(var_5_0:getChildByTag(0), "CCControlButton")

		arg_3_0.btnBox:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBox:setSwallowsTouches(false)
		arg_3_0.btnBox:setZoomChildNode(var_5_0)
		arg_3_0.btnBox:setZoomOnTouchDown(true)

		arg_3_0.spriteBox = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(4), "CCLayerColor")
		local var_5_3 = createItem()

		var_5_3:setPosition(var_5_2:getPosition())
		var_5_3:setScale(0.6)
		var_5_0:addChild(var_5_3)

		arg_3_0.boxShowItems = var_5_3

		var_5_2:removeFromParentAndCleanup(true)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbPataWnd_AwardItem.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.spriteBox:setGray(false)

	arg_7_0.have = false
	arg_7_0.layerIndex = arg_7_2

	arg_7_0.boxShowItems:setVisible(false)

	arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/bgz.plist")

	local var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName("pata_box.png")

	if var_7_0 then
		arg_7_0.spriteBox:initWithSpriteFrame(var_7_0)
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if arg_7_0.index == iter_7_1.Index then
			arg_7_0.spriteBox:setGray(true)

			arg_7_0.have = true

			arg_7_0.nodeBox:setVisible(false)
			arg_7_0.lbDesc:setVisible(true)
			arg_7_0.lbDesc:setString(a2u("\xD2\xD1\xC1\xECȡ"))

			local var_7_1 = arg_7_0.spriteframeCache:spriteFrameByName("pata_box2.png")

			if var_7_1 then
				arg_7_0.spriteBox:initWithSpriteFrame(var_7_1)
			end

			arg_7_0.boxShowItems:refreshAward(iter_7_1.AwardList[1].Type, iter_7_1.AwardList[1].Id, iter_7_1.AwardList[1].Count, false)
			arg_7_0.boxShowItems:setVisible(true)

			return
		end
	end

	local var_7_2 = table.getn(arg_7_1)

	if var_7_2 == 0 then
		arg_7_0.nodeBox:setVisible(false)
		arg_7_0.lbDesc:setVisible(true)
		arg_7_0.lbDesc:setString(a2u("\xC3\xE2 \xB7\xD1"))
	else
		arg_7_0.nodeBox:setVisible(true)
		arg_7_0.lbDesc:setVisible(false)

		if arg_7_0.type == EPataStateType.SaoDang then
			arg_7_0.lbMoney:setString(g_DataConfig.kPataCommonTable.randAwardDiamond[var_7_2 + 1] * (1 + math.floor(arg_7_0.layerIndex / 10)))
		else
			arg_7_0.lbMoney:setString(g_DataConfig.kPataCommonTable.randAwardDiamond[var_7_2 + 1] * (1 + math.floor(g_GameData.PataInfo.BaseInfo.Layer / 10)))
		end
	end
end

function zbPataWnd_AwardItem.onTouch(arg_8_0)
	if arg_8_0.have == true then
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xC1\xECȡ"))

		return
	end

	if arg_8_0.type == EPataStateType.SaoDang then
		g_WsMsgHandler:WS_Pata_SaoDangTurnBrand_Req(arg_8_0.layerIndex, arg_8_0.index)
	else
		g_WsMsgHandler:WS_Pata_GetAward_Req(arg_8_0.index)
	end
end
