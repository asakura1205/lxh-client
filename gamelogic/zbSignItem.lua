require("gamelogic.zbItem")

zbSignItem = class("zbSignItem", CCNodeExtend)
zbSignItem.__index = zbSignItem

function zbSignItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSignItem)

	return arg_1_0
end

function zbSignItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbSignItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbSignItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.scrollEffect = nil
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_signitem.ccbi")

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteDouble = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.spriteGeted = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.lbCountDummy = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lbLVDouble = tolua.cast(arg_3_0.spriteDouble:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCountDummy, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.5)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onSign()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:setContentSize(arg_3_0.spriteIcon:getContentSize())
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbSignItem.createFingerTag(arg_7_0)
	arg_7_0.spriteFinger = CCSprite:create("image/guide/finger.png")

	arg_7_0.spriteFinger:setAnchorPoint(ccp(0.5, 1))
	arg_7_0.spriteFinger:setPosition(62, 57)
	arg_7_0.spriteFinger:setScale(0.7)
	arg_7_0.spriteFinger:setFlipY(true)
	arg_7_0:addChild(arg_7_0.spriteFinger)
end

function zbSignItem.refresh(arg_8_0, arg_8_1)
	zbAwardHelper:refreshAwardItem(arg_8_1.AwardItem.Type, arg_8_1.AwardItem.Id, nil, arg_8_0.btnFrame, arg_8_0.spriteIcon)

	if (arg_8_1.AwardItem.Type == ECommonAwardType.HeroFrag or arg_8_1.AwardItem.Type == ECommonAwardType.Hero or arg_8_1.AwardItem.Type == ECommonAwardType.Diamond or arg_8_1.AwardItem.Type == ECommonAwardType.BarMoney or arg_8_1.AwardItem.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(arg_8_1.AwardItem.Id) > EItemQuality.Golden or arg_8_1.AwardItem.Type == ECommonAwardType.Item and zbItemTable:getItemType(arg_8_1.AwardItem.Id) == EItemType.Equip and zbItemTable:getItemQuality(arg_8_1.AwardItem.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(arg_8_1.AwardItem.Id) > EItemQuality.Golden) and arg_8_0.scrollEffect == nil then
		arg_8_0.scrollEffect = g_EffectSystem:creatScrollEffect(arg_8_0, arg_8_1.AwardItem.Type)

		arg_8_0.scrollEffect:setAnimation("animation", true)
	end

	if arg_8_1.AwardItem.Count <= 1 then
		arg_8_0.lbCount:setString("")
	else
		arg_8_0.lbCount:setString(arg_8_1.AwardItem.Count)
	end
end

function zbSignItem.refreshState(arg_9_0, arg_9_1)
	arg_9_0.awardData = arg_9_1

	arg_9_0:setVisible(true)

	if arg_9_1.Day <= g_GameData.ActivityAct.DailySign.SignCount then
		arg_9_0.spriteIcon:setGray(true)
		arg_9_0.spriteGeted:setVisible(true)
	else
		arg_9_0.spriteIcon:setGray(false)
		arg_9_0.spriteGeted:setVisible(false)
	end

	if g_GameData.ActivityAct.DailySign.SignToday ~= 1 and arg_9_1.Day == g_GameData.ActivityAct.DailySign.SignCount + 1 then
		if arg_9_0.spriteFinger == nil then
			arg_9_0:createFingerTag()
		end

		arg_9_0.spriteFinger:setVisible(true)
		zbUIEffect:createArrowMoveAction(arg_9_0.spriteFinger, 5, 0.5)
	elseif arg_9_0.spriteFinger ~= nil then
		arg_9_0.spriteFinger:setVisible(false)
	end

	if arg_9_1.Vip > 0 then
		arg_9_0.lbLVDouble:setString("V" .. arg_9_1.Vip .. a2u("˫\xB1\xB6"))
		arg_9_0.spriteDouble:setVisible(true)
	else
		arg_9_0.spriteDouble:setVisible(false)
	end
end

function zbSignItem.refreshFinger(arg_10_0)
	if arg_10_0.spriteFinger ~= nil and arg_10_0.spriteFinger:isVisible() and arg_10_0.spriteFinger:numberOfRunningActions() <= 0 then
		zbUIEffect:createArrowMoveAction(arg_10_0.spriteFinger, 5, 0.5)
	end

	if arg_10_0.scrollEffect then
		arg_10_0.scrollEffect:setAnimation("animation", true)
	end
end

function zbSignItem.onSign(arg_11_0)
	if g_GameData.ActivityAct.DailySign.SignToday ~= 1 and arg_11_0.awardData.Day == g_GameData.ActivityAct.DailySign.SignCount + 1 then
		if arg_11_0.awardData.AwardItem.Type == ECommonAwardType.Hero then
			g_Self.kActivityHandler.lastTemplateId = arg_11_0.awardData.AwardItem.Id
		end

		g_WsMsgHandler:WS_ActivityAct_DailySign_Req()
	end
end
