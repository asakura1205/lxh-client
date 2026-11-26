require("gamelogic.zbItem")

local var_0_0 = 4

zbEquipDetail_StarUp = class("zbEquipDetail_StarUp")
zbEquipDetail_StarUp.__index = zbEquipDetail_StarUp

function zbEquipDetail_StarUp.init(arg_1_0, arg_1_1)
	local function var_1_0()
		return
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.lbCurrpop = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.spriteCurrStars = {}

		for iter_3_0 = 1, 10 do
			arg_1_0.spriteCurrStars[iter_3_0] = tolua.cast(arg_1_0.layer:getChildByTag(2):getChildByTag(iter_3_0), "CCSprite")
		end

		arg_1_0.subNode = tolua.cast(arg_1_0.layer:getChildByTag(3), "CCNode")
		arg_1_0.subAttrName = tolua.cast(arg_1_0.subNode:getChildByTag(1), "CCLabelTTF")
		arg_1_0.subCurrAttr = tolua.cast(arg_1_0.subNode:getChildByTag(2), "CCLabelTTF")
		arg_1_0.subNextAttr = tolua.cast(arg_1_0.subNode:getChildByTag(3), "CCLabelTTF")

		local var_3_0 = tolua.cast(arg_1_0.layer:getChildByTag(4), "CCNode")

		arg_1_0.progressBg = tolua.cast(var_3_0:getChildByTag(6), "CCSprite")

		local var_3_1 = tolua.cast(var_3_0:getChildByTag(1001), "CCLabelTTF")

		arg_1_0.lbSuccess = tolua.cast(var_3_0:getChildByTag(9), "CCLabelTTF")

		local var_3_2 = tolua.cast(var_3_0:getChildByTag(1003), "CCLabelTTF")

		arg_1_0.lbExp = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_1, arg_1_0.lbExp)
		arg_1_0.lbExp:setScale(0.55)

		arg_1_0.lbLuck = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_2, arg_1_0.lbLuck)
		arg_1_0.lbLuck:setScale(0.55)

		arg_1_0.progress = zbUtil:createProgressTimer(arg_1_0.progressBg, "image/equip/equip_progress.png")

		local var_3_3 = tolua.cast(arg_1_0.layer:getChildByTag(5), "CCNode")
		local var_3_4 = tolua.cast(var_3_3:getChildByTag(1001), "CCLabelTTF")
		local var_3_5 = tolua.cast(var_3_3:getChildByTag(1002), "CCLabelTTF")

		arg_1_0.lbShengxing = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_4, arg_1_0.lbShengxing)
		arg_1_0.lbShengxing:setScale(0.55)

		arg_1_0.lbGold = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_5, arg_1_0.lbGold)
		arg_1_0.lbGold:setScale(0.55)

		arg_1_0.btnStarUp = tolua.cast(arg_1_0.layer:getChildByTag(7), "CCControlButton")

		arg_1_0.btnStarUp:addHandleOfControlEvent(function()
			arg_1_0:onStarUp()
		end, CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_StarUp.refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroTemplateId = arg_5_1
	arg_5_0.equip = arg_5_2

	local var_5_0 = zbItemTable:getRecord(arg_5_2.TemplateId)

	if var_5_0 == nil then
		echoInfo("fail to get item record: " .. tostring(arg_5_2.TemplateId))

		return
	end

	arg_5_0.equipRecord = var_5_0

	for iter_5_0 = 1, 10 do
		arg_5_0.spriteCurrStars[iter_5_0]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/star/star_herodetail.png"))
		arg_5_0.spriteCurrStars[iter_5_0]:setGray(true)
	end

	for iter_5_1 = 1, arg_5_2.Star / 2 do
		arg_5_0.spriteCurrStars[iter_5_1]:setGray(false)
	end

	if math.fmod(arg_5_2.Star, 2) == 1 then
		arg_5_0.spriteCurrStars[math.ceil(arg_5_2.Star / 2)]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/star/star_herodetailhalf.png"))
		arg_5_0.spriteCurrStars[math.ceil(arg_5_2.Star / 2)]:setGray(false)
	end

	if arg_5_2.Star >= 20 then
		arg_5_0.btnStarUp:setVisible(false)

		return
	end

	arg_5_0.lbCurrpop:setString(var_5_0.name)

	local var_5_1 = zbColor:getItemColor(arg_5_2.Quality)

	arg_5_0.lbCurrpop:setColor(var_5_1)

	if arg_5_2.CLevel ~= 0 then
		arg_5_0.lbCurrpop:setString(var_5_0.name .. "+" .. arg_5_2.CLevel)
	end

	local var_5_2 = arg_5_2.Star + 1

	if arg_5_2.Star >= 20 then
		var_5_2 = 20
	end

	local var_5_3 = g_Self.kBagItemHandler:getItemCountByTemplateId(2041701)
	local var_5_4 = zbEquipUpStarTable:getRecord(arg_5_2.Star)

	if var_5_4 then
		arg_5_0.lbSuccess:setString(var_5_4.rate)
		arg_5_0.subCurrAttr:setString("+" .. var_5_4.addAttrRate * 100 .. "%")
		arg_5_0.lbExp:setString(arg_5_2.SLucky .. "/" .. var_5_4.luckyValue)
		arg_5_0.lbShengxing:setString(var_5_4.upStarStone .. "/" .. var_5_3)
		arg_5_0.lbGold:setString(var_5_4.gold)

		local var_5_5 = math.min(math.ceil(100 * (arg_5_2.SLucky / var_5_4.luckyValue)), 99)

		arg_5_0.progress:setPercentage(var_5_5)

		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_5_4.gold) == true then
			arg_5_0.lbGold:setColor(FONT_COLOR_GREEN)
		else
			arg_5_0.lbGold:setColor(FONT_COLOR_RED)
		end

		if var_5_3 >= var_5_4.upStarStone then
			arg_5_0.lbShengxing:setColor(FONT_COLOR_GREEN)
		else
			arg_5_0.lbShengxing:setColor(FONT_COLOR_RED)
		end
	end

	arg_5_0.lbLuck:setString(arg_5_2.SLucky)

	local var_5_6 = zbEquipUpStarTable:getRecord(var_5_2)

	if var_5_6 then
		arg_5_0.subNextAttr:setString("+" .. var_5_6.addAttrRate * 100 .. "%")
	end
end

function zbEquipDetail_StarUp.onStarUp(arg_6_0)
	local var_6_0 = arg_6_0.heroTemplateId
	local var_6_1 = arg_6_0.equip
	local var_6_2 = zbEquipUpStarTable:getRecord(var_6_1.Star)

	if g_Self.kBagItemHandler:getItemCountByTemplateId(2041701) < var_6_2.upStarStone then
		g_MainScene:showGetWayWnd(2041701, ECommonAwardType.Item)

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_6_2.gold) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	local var_6_3 = {}

	if arg_6_0.heroTemplateId and arg_6_0.heroTemplateId > 0 then
		if var_6_1 then
			var_6_3.SlotType = EEquipSlotType.Hero
			var_6_3.HeroTid = var_6_0
			var_6_3.EquipId = var_6_1.EquipId
		end
	elseif var_6_1 then
		var_6_3.SlotType = EEquipSlotType.Bag
		var_6_3.HeroTid = 0
		var_6_3.EquipId = var_6_1.EquipId
	end

	g_WsMsgHandler:WS_Equip_UpStar_Req(var_6_3)
end

function createEquipDetail_StarUp(arg_7_0)
	local var_7_0 = zbEquipDetail_StarUp.new()

	var_7_0:init(arg_7_0)

	return var_7_0
end
