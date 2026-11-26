require("gamelogic.zbTabWnd")

local var_0_0 = class("zbHeroHandbookWnd", zbTabWnd)

var_0_0.__index = var_0_0

local var_0_1 = {
	[ERarityType.B] = "ui/image/hero/hero_putong.png",
	[ERarityType.A] = "ui/image/hero/hero_xiyou.png",
	[ERarityType.S] = "ui/image/hero/hero_shishi.png",
	[ERarityType.SS] = "ui/image/hero/hero_chuanshuo.png"
}

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroHandbookWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.bottomBtnNodeInitPosY = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/herohandbook.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.nodeTitle = tolua.cast(var_5_1:getChildByTag(102), "CCNode")
		arg_3_0.title = tolua.cast(arg_3_0.nodeTitle:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnTouch = tolua.cast(var_5_2:getChildByTag(1000), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnHeroPreview = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")

		arg_3_0.btnHeroPreview:addHandleOfControlEvent(function()
			arg_3_0:onHeroPreview()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnHeroSoul = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")

		arg_3_0.btnHeroSoul:addHandleOfControlEvent(function()
			arg_3_0:onHeroSoul()
		end, CCControlEventTouchUpInside)

		arg_3_0.bottomBtnNode = tolua.cast(var_5_1:getChildByTag(2), "CCLayer")
		arg_3_0.bottomBtnNodeInitPosY = arg_3_0.bottomBtnNode:getPositionY()
		arg_3_0.btnShare = tolua.cast(arg_3_0.bottomBtnNode:getChildByTag(14), "CCControlButton")

		arg_3_0.btnShare:addHandleOfControlEvent(function()
			arg_3_0:onShare()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnShare:setVisible(false)

		arg_3_0.nodeShare = tolua.cast(var_5_1:getChildByTag(110), "CCNode")

		arg_3_0.nodeShare:setVisible(false)

		arg_3_0.btnShareTouch = tolua.cast(arg_3_0.nodeShare:getChildByTag(3), "CCControlButton")

		arg_3_0.btnShareTouch:addHandleOfControlEvent(function()
			arg_3_0:onShareTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.shareName = tolua.cast(arg_3_0.nodeShare:getChildByTag(1), "CCLabelTTF")
		arg_3_0.shareArea = tolua.cast(arg_3_0.nodeShare:getChildByTag(2), "CCLabelTTF")
		arg_3_0.shareQRcode = tolua.cast(arg_3_0.nodeShare:getChildByTag(4), "CCSprite")

		local var_5_4 = {
			[ERarityType.B] = tolua.cast(arg_3_0.bottomBtnNode:getChildByTag(10), "CCControlButton"),
			[ERarityType.A] = tolua.cast(arg_3_0.bottomBtnNode:getChildByTag(11), "CCControlButton"),
			[ERarityType.S] = tolua.cast(arg_3_0.bottomBtnNode:getChildByTag(12), "CCControlButton"),
			[ERarityType.SS] = tolua.cast(arg_3_0.bottomBtnNode:getChildByTag(13), "CCControlButton")
		}

		arg_3_0.tabLayers = {}
		arg_3_0.tabLayers[ERarityType.B] = tolua.cast(var_5_2:getChildByTag(100), "CCLayer")
		arg_3_0.tabLayers[ERarityType.A] = tolua.cast(var_5_2:getChildByTag(101), "CCLayer")
		arg_3_0.tabLayers[ERarityType.S] = tolua.cast(var_5_2:getChildByTag(102), "CCLayer")
		arg_3_0.tabLayers[ERarityType.SS] = tolua.cast(var_5_2:getChildByTag(103), "CCLayer")

		local var_5_5 = {
			[ERarityType.B] = "image/tab/tab_rarity_b.png",
			[ERarityType.A] = "image/tab/tab_rarity_a.png",
			[ERarityType.S] = "image/tab/tab_rarity_s.png",
			[ERarityType.SS] = "image/tab/tab_rarity_ss.png"
		}

		arg_3_0:initTab(var_5_4, arg_3_0.tabLayers, var_5_5)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		})

		if arg_3_0.moneyPanel then
			arg_3_0.moneyPanel.layer:setVisible(false)
		end

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_12_0)
	arg_12_0:selectTab(4)
	arg_12_0.bottomBtnNode:setPositionY(arg_12_0.bottomBtnNodeInitPosY)
	arg_12_0.shareName:setString(g_GameData.BaseInfo.RoleName)

	local var_12_0 = g_Login:getCurServer()
	local var_12_1 = ""

	if var_12_0 then
		var_12_1 = var_12_0.ServerName
	end

	arg_12_0.shareArea:setString(g_Login.selectServerId .. a2u("\xC7\xF8") .. a2u(var_12_1))
	arg_12_0.shareQRcode:setVisible(zbGlobalUtil:getTargetPlatform() == "ios" or zbChannelUtil:isOfficialChannel(g_Login.channel))
	arg_12_0:childUtil()
end

function var_0_0.doSelectTab(arg_13_0)
	arg_13_0.title:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[arg_13_0.currTab]))
	arg_13_0:childUtil()
end

function var_0_0.childUtil(arg_14_0)
	local var_14_0 = arg_14_0.tabLayers[arg_14_0.currTab]
	local var_14_1 = var_14_0:getChildren()
	local var_14_2 = var_14_0:getChildrenCount()

	for iter_14_0 = 1, var_14_2 do
		local var_14_3 = tolua.cast(var_14_1:objectAtIndex(iter_14_0 - 1), "CCSprite")

		if var_14_3 then
			local var_14_4 = var_14_3:getTag()
			local var_14_5 = g_Self.kHeroHandler:hasHeroByTemplateId(var_14_4)
			local var_14_6 = ccc3(25, 25, 25)

			if var_14_5 then
				var_14_6 = ccc3(255, 255, 255)
			end

			var_14_3:setColor(var_14_6)
		end
	end
end

function var_0_0.setShareUiVisible(arg_15_0, arg_15_1)
	arg_15_0.nodeShare:setVisible(arg_15_1)
	arg_15_0.btnHeroPreview:setVisible(not arg_15_1)
	arg_15_0.btnHeroSoul:setVisible(not arg_15_1)
	arg_15_0.btnClose:setVisible(not arg_15_1)
	arg_15_0.nodeTitle:setVisible(not arg_15_1)
	arg_15_0.bottomBtnNode:setVisible(not arg_15_1)
	arg_15_0.btnTouch:setVisible(not arg_15_1)

	if g_Broadcast then
		g_Broadcast:setBroadCastVisible(not arg_15_1)
	end
end

function var_0_0.onShare(arg_16_0)
	arg_16_0:setShareUiVisible(true)
	zbGlobalUtil:shareTxtAndImage("", "")
end

function var_0_0.onShareTouch(arg_17_0)
	arg_17_0:setShareUiVisible(false)
end

function var_0_0.onTouch(arg_18_0)
	if arg_18_0:isFading() then
		return
	end

	if g_Broadcast then
		g_Broadcast:setBroadCastVisible(not arg_18_0.btnClose:isVisible())
	end

	arg_18_0.btnClose:setVisible(not arg_18_0.btnClose:isVisible())
	arg_18_0.btnHeroPreview:setVisible(not arg_18_0.btnHeroPreview:isVisible())
	arg_18_0.btnHeroSoul:setVisible(not arg_18_0.btnHeroSoul:isVisible())

	local var_18_0 = arg_18_0.bottomBtnNode:getPositionY()

	if arg_18_0.bottomBtnNodeInitPosY ~= var_18_0 then
		local var_18_1 = CCMoveTo:create(0.3, ccp(0, arg_18_0.bottomBtnNodeInitPosY))
		local var_18_2 = CCCallFuncN:create(function()
			arg_18_0.btnTouch:setEnabled(true)
		end)
		local var_18_3 = CCSequence:createWithTwoActions(var_18_1, var_18_2)

		arg_18_0.bottomBtnNode:stopAllActions()
		arg_18_0.btnTouch:setEnabled(false)
		arg_18_0.bottomBtnNode:runAction(var_18_3)
	else
		local var_18_4 = CCMoveBy:create(0.3, ccp(0, -250))
		local var_18_5 = CCCallFuncN:create(function()
			arg_18_0.btnTouch:setEnabled(true)
		end)
		local var_18_6 = CCArray:create()

		var_18_6:addObject(var_18_4)
		var_18_6:addObject(var_18_5)

		local var_18_7 = CCSequence:create(var_18_6)

		arg_18_0.bottomBtnNode:stopAllActions()
		arg_18_0.btnTouch:setEnabled(false)
		arg_18_0.bottomBtnNode:runAction(var_18_7)
	end
end

function var_0_0.onHeroPreview(arg_21_0)
	g_MainScene:showHeroPreview():setPrevWnd(arg_21_0)
end

function var_0_0.onHeroSoul(arg_22_0)
	if zbFunHelper:isLockAndTip(EFuncType.HeroSoul) then
		return
	end

	g_MainScene:showHeroSoulHall():setPrevWnd(arg_22_0)
end

function var_0_0.onFrameUpdate(arg_23_0)
	arg_23_0:updateBackEffect()
end
