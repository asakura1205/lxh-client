zbEquipDetail_Detail = class("zbEquipDetail_Detail")
zbEquipDetail_Detail.__index = zbEquipDetail_Detail

function zbEquipDetail_Detail.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.equip = nil
		arg_1_0.equipRecord = nil
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
		arg_1_0.layerGem = {}
		arg_1_0.lbWuxingAttr = {}
		arg_1_0.spriteWuxing = {}
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1

		local var_3_0 = tolua.cast(arg_1_1:getChildByTag(300), "CCLayer")

		arg_1_0.layerEquip = tolua.cast(arg_1_1:getChildByTag(14), "CCLayer")

		local var_3_1 = tolua.cast(arg_1_1:getChildByTag(1), "CCLayer")

		arg_1_0.spriteFrame = tolua.cast(var_3_1:getChildByTag(1), "CCSprite")
		arg_1_0.spriteIcon = tolua.cast(var_3_1:getChildByTag(2), "CCSprite")
		arg_1_0.lbLevelDummy = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(3), "CCLabelTTF")
		arg_1_0.lbdesc = tolua.cast(arg_1_1:getChildByTag(1004), "CCLabelTTF")
		arg_1_0.lbHeroName = tolua.cast(arg_1_1:getChildByTag(5), "CCLabelTTF")
		arg_1_0.lbFightDummy = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.btnDetail = tolua.cast(arg_1_1:getChildByTag(10), "CCControlButton")
		arg_1_0.btnFate = tolua.cast(arg_1_1:getChildByTag(11), "CCControlButton")
		arg_1_0.qualityStar = tolua.cast(arg_1_0.layerEquip:getChildByTag(5), "CCLayer")
		arg_1_0.spriteCurrStars = {}

		for iter_3_0 = 1, 10 do
			arg_1_0.spriteCurrStars[iter_3_0] = tolua.cast(arg_1_0.qualityStar:getChildByTag(iter_3_0), "CCSprite")
		end

		arg_1_0.lbMainAttrName = tolua.cast(arg_1_0.layerEquip:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbMainAttrValue = tolua.cast(arg_1_0.layerEquip:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbSubAttr = tolua.cast(arg_1_0.layerEquip:getChildByTag(3), "CCLabelTTF")

		for iter_3_1 = 11, 15 do
			arg_1_0.layerGem[iter_3_1 - 10] = tolua.cast(arg_1_0.layerEquip:getChildByTag(iter_3_1), "CCLayer")
			arg_1_0.lbWuxingAttr[iter_3_1 - 10] = tolua.cast(arg_1_0.layerGem[iter_3_1 - 10]:getChildByTag(1), "CCLabelTTF")
			arg_1_0.spriteWuxing[iter_3_1 - 10] = tolua.cast(arg_1_0.layerGem[iter_3_1 - 10]:getChildByTag(2), "CCSprite")
		end

		arg_1_0.layerAdd = tolua.cast(arg_1_0.layerEquip:getChildByTag(4), "CCLayer")
		arg_1_0.lbWuxingAdd = tolua.cast(arg_1_0.layerAdd:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbLevelDummy, arg_1_0.lbLevel)
		arg_1_0.lbLevel:setScale(0.55)

		arg_1_0.lbFight = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbFightDummy, arg_1_0.lbFight)
		arg_1_0.lbFight:setScale(0.55)
		arg_1_0.btnDetail:addHandleOfControlEvent(function()
			arg_1_0:onDetail()
		end, CCControlEventTouchUpInside)
		arg_1_0.layerEquip:removeFromParentAndCleanup(false)

		local var_3_2 = CCScrollView:create(var_3_0:getContentSize())

		var_3_2:setDirection(kCCScrollViewDirectionVertical)
		var_3_2:setPosition(var_3_0:getPosition())
		var_3_2:setAnchorPoint(ccp(0, 0))
		var_3_2:setBounceable(false)
		var_3_2:setContainer(arg_1_0.layerEquip)
		var_3_2:setContentOffset(ccp(0, -80))
		arg_1_0.layer:addChild(var_3_2)

		arg_1_0.scroll = var_3_2
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_Detail.refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.equipRecord = nil
	arg_5_0.equip = arg_5_1

	if arg_5_1.Star > 0 then
		arg_5_0.qualityStar:setVisible(true)

		for iter_5_0 = 1, 10 do
			arg_5_0.spriteCurrStars[iter_5_0]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/star/star_herodetail.png"))
			arg_5_0.spriteCurrStars[iter_5_0]:setGray(true)
		end

		for iter_5_1 = 1, arg_5_1.Star / 2 do
			arg_5_0.spriteCurrStars[iter_5_1]:setGray(false)
		end

		if math.fmod(arg_5_1.Star, 2) == 1 then
			arg_5_0.spriteCurrStars[math.ceil(arg_5_1.Star / 2)]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/star/star_herodetailhalf.png"))
			arg_5_0.spriteCurrStars[math.ceil(arg_5_1.Star / 2)]:setGray(false)
		end

		arg_5_0.layerEquip:setContentSize(CCSizeMake(372, 325))
	else
		arg_5_0.layerEquip:setContentSize(CCSizeMake(372, 265))
		arg_5_0.qualityStar:setVisible(false)
	end

	arg_5_0.scroll:setContentOffset(ccp(0, -80))

	arg_5_0.equipRecord = zbItemTable:getRecord(arg_5_0.equip.TemplateId)

	if arg_5_0.equipRecord == nil then
		echoInfo("zbEquipDetail_Detail:refresh invalidId: " .. arg_5_0.equip.TemplateId)

		return
	end

	arg_5_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_5_1.Quality)))
	arg_5_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_5_1.TemplateId)))
	arg_5_0.lbLevel:setString(arg_5_1.Level)
	arg_5_0.lbdesc:setString(arg_5_0.equipRecord.description)
	arg_5_0.lbName:setString(arg_5_0.equipRecord.name)

	local var_5_0 = zbColor:getItemColor(arg_5_1.Quality)

	arg_5_0.lbName:setColor(var_5_0)

	if arg_5_1.CLevel ~= 0 then
		arg_5_0.lbName:setString(arg_5_0.equipRecord.name .. "+" .. arg_5_1.CLevel)
	end

	arg_5_0.lbHeroName:setColor(FONT_COLOR_WHITE)
	arg_5_0.lbHeroName:setString(a2u("\xCE\xDE"))

	local var_5_1 = zbHeroTable:getRecord(arg_5_2)
	local var_5_2 = g_Self.kHeroHandler:getHeroByTemplateId(arg_5_2)

	if var_5_1 and var_5_2 then
		arg_5_0.lbHeroName:setString(var_5_1.name)

		local var_5_3 = zbColor:getHeroNameColor(var_5_2.HeroBaseInfo.Quality)

		arg_5_0.lbHeroName:setColor(var_5_3)
	end

	arg_5_0.lbFight:setString(arg_5_0.equip.FV)

	local var_5_4 = g_Self.kBagEquipHandler:getBagEquipMain(arg_5_0.equipRecord, arg_5_0.equip)

	arg_5_0.lbMainAttrName:setString(var_5_4)

	local var_5_5 = ""

	for iter_5_2, iter_5_3 in pairs(arg_5_0.equipRecord.subAttrList) do
		local var_5_6 = a2u(getItemPropStr(iter_5_3.AttrType))

		if iter_5_3.AttrAdditionType == EAttrAdditionType.Fixed then
			var_5_5 = var_5_5 .. " " .. var_5_6 .. "+" .. iter_5_3.AttrValue + arg_5_1.CLevel * iter_5_3.AttrValueGrow
		else
			var_5_5 = var_5_5 .. " " .. var_5_6 .. "+" .. (iter_5_3.AttrValue + arg_5_1.CLevel * iter_5_3.AttrValueGrow) * 100 .. "%"
		end
	end

	arg_5_0.lbSubAttr:setString(var_5_5)

	for iter_5_4 = 1, 5 do
		arg_5_0.layerGem[iter_5_4]:setVisible(false)
	end

	local var_5_7 = 1

	for iter_5_5, iter_5_6 in pairs(arg_5_0.equip.AttrInfo.GemAttr) do
		local var_5_8 = zbItemTable:getRecord(iter_5_6.TemplateId)

		if var_5_8 ~= nil then
			arg_5_0.spriteWuxing[var_5_7]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/comm_wuxing0" .. var_5_8.gemShape .. ".png"))
		end

		arg_5_0.layerGem[var_5_7]:setVisible(true)

		local var_5_9 = ""

		for iter_5_7, iter_5_8 in pairs(iter_5_6.AttrList) do
			if iter_5_8[2] == EAttrAdditionType.Fixed then
				var_5_9 = var_5_9 .. " " .. a2u(getItemPropStr(iter_5_8[1])) .. "+" .. iter_5_8[3]
			else
				var_5_9 = var_5_9 .. " " .. a2u(getItemPropStr(iter_5_8[1])) .. "+" .. iter_5_8[3] * 100 .. "%"
			end
		end

		arg_5_0.lbWuxingAttr[var_5_7]:setString(var_5_9)

		var_5_7 = var_5_7 + 1
	end

	if arg_5_0.equip.AttrInfo.Addition ~= 0 then
		arg_5_0.layerAdd:setVisible(true)
		arg_5_0.lbWuxingAdd:setString(a2u("\xD6\xF7\xCA\xF4\xD0\xD4+") .. arg_5_0.equip.AttrInfo.Addition * 100 .. "%")
	else
		arg_5_0.layerAdd:setVisible(false)
	end
end

function zbEquipDetail_Detail.onLeft(arg_6_0)
	return
end

function zbEquipDetail_Detail.onRight(arg_7_0)
	return
end

function zbEquipDetail_Detail.onDetail(arg_8_0)
	g_MainScene:showGetWayWnd(arg_8_0.equip.TemplateId, ECommonAwardType.Item)
end

function createEquipDetail(arg_9_0)
	local var_9_0 = zbEquipDetail_Detail.new()

	var_9_0:init(arg_9_0)

	return var_9_0
end
