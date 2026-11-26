zbTipCommonWnd_Item = class("zbTipCommonWnd_Item")
zbTipCommonWnd_Item.__index = zbTipCommonWnd_Item

function zbTipCommonWnd_Item.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		return
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.btnFrame = tolua.cast(arg_1_1:getChildByTag(2), "CCControlButton")
		arg_1_0.spriteIcon = tolua.cast(arg_1_1:getChildByTag(3), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.OwnerNum = tolua.cast(arg_1_1:getChildByTag(7), "CCLabelTTF")
		arg_1_0.NeedLevel = tolua.cast(arg_1_1:getChildByTag(8), "CCLabelTTF")
		arg_1_0.spriteMoney = tolua.cast(arg_1_1:getChildByTag(4), "CCSprite")
		arg_1_0.bmPrice = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.lbDesc1 = tolua.cast(arg_1_1:getChildByTag(9), "CCLabelTTF")
		arg_1_0.qualityRoot = tolua.cast(arg_1_1:getChildByTag(11), "CCNode")
		arg_1_0.spriteType = tolua.cast(arg_1_1:getChildByTag(12), "CCSprite")
		arg_1_0.spriteStars = {}

		for iter_3_0 = 1, 8 do
			arg_1_0.spriteStars[iter_3_0] = arg_1_0.qualityRoot:getChildByTag(iter_3_0)
		end

		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height * arg_1_1:getScaleY() * arg_1_2:getScaleY()
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width * arg_1_1:getScaleX() * arg_1_2:getScaleX()
	end

	var_1_0()
	var_1_1()
end

function zbTipCommonWnd_Item.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.layer:setVisible(true)
	arg_4_0.qualityRoot:setVisible(false)
	arg_4_0.spriteType:setVisible(false)
	arg_4_0.OwnerNum:setVisible(true)
	arg_4_0.spriteMoney:setVisible(true)
	arg_4_0.bmPrice:setVisible(true)
	zbAwardHelper:refreshAwardItem(arg_4_1, arg_4_2, 1, arg_4_0.btnFrame, arg_4_0.spriteIcon, arg_4_0.lbName)

	local var_4_0 = zbItemTable:getRecord(arg_4_2)

	if var_4_0 == nil then
		return
	end

	local var_4_1 = g_Self.kBagItemHandler:getItemCountByTemplateId(arg_4_2)

	arg_4_0.OwnerNum:setString(a2u("ӵ\xD3\xD0:") .. var_4_1)
	arg_4_0.lbDesc1:setString(var_4_0.description)
	arg_4_0.bmPrice:setString(var_4_0.sellPrice)
	arg_4_0.NeedLevel:setVisible(false)
	arg_4_0.lbName:setString(var_4_0.name)
end

function zbTipCommonWnd_Item.refreshHeroTemplate(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.layer:setVisible(true)
	arg_5_0.qualityRoot:setVisible(true)
	arg_5_0.spriteType:setVisible(true)
	arg_5_0.OwnerNum:setVisible(false)
	arg_5_0.spriteMoney:setVisible(false)
	arg_5_0.bmPrice:setVisible(false)

	local var_5_0 = zbHeroTable:getRecord(arg_5_2)

	if var_5_0 == nil then
		arg_5_0:setVisible(false)

		return
	end

	local var_5_1 = zbIconHelper:getHeroTypeIconPath(var_5_0.heroType)

	arg_5_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_1))
	arg_5_0.lbName:setString(var_5_0.name)
	arg_5_0.lbDesc1:setString(var_5_0.description .. "  " .. var_5_0.description2)
	arg_5_0.NeedLevel:setVisible(false)

	local var_5_2 = zbIconHelper:getHeroIconPath(arg_5_2)

	arg_5_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_2))

	local var_5_3 = zbColor:getEquipFrameTex(1)

	if arg_5_1 == ECommonAwardType.Hero then
		var_5_3 = zbColor:getHeroFrameTex(var_5_0.quality)
	elseif arg_5_1 == ECommonAwardType.HeroFrag then
		var_5_3 = zbColor:getHeroFragFrameTex(var_5_0.quality)
	end

	require("gamebase.zbUI"):setButtonPic(arg_5_0.btnFrame, var_5_3, var_5_3, var_5_3)

	local var_5_4 = var_5_0.star

	zbUIEffect:centerHeroStar(arg_5_0.spriteStars, var_5_4)
end

function zbTipCommonWnd_Item.refreshHero(arg_6_0, arg_6_1)
	arg_6_0.layer:setVisible(true)
	arg_6_0.qualityRoot:setVisible(true)
	arg_6_0.spriteType:setVisible(true)
	arg_6_0.OwnerNum:setVisible(false)
	arg_6_0.spriteMoney:setVisible(false)
	arg_6_0.bmPrice:setVisible(false)

	if arg_6_1 == nil then
		arg_6_0:setVisible(false)

		return
	end

	local var_6_0 = zbIconHelper:getHeroIconPath(arg_6_1.TemplateId)

	arg_6_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))

	local var_6_1 = zbColor:getHeroFrameTex(arg_6_1.Quality)

	require("gamebase.zbUI"):setButtonPic(arg_6_0.btnFrame, var_6_1, var_6_1, var_6_1)
	arg_6_0.NeedLevel:setString(a2u("LV.") .. arg_6_1.Level)

	local var_6_2 = zbHeroTable:getRecord(arg_6_1.TemplateId)

	if var_6_2 ~= nil then
		arg_6_0.lbName:setString(var_6_2.name)
		arg_6_0.lbDesc1:setString(var_6_2.description .. "  " .. var_6_2.description2)

		local var_6_3 = zbIconHelper:getHeroTypeIconPath(var_6_2.heroType)

		arg_6_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_3))
	end

	local var_6_4 = arg_6_1.Star

	zbUIEffect:centerHeroStar(arg_6_0.spriteStars, var_6_4)
end

function createTipCommonWndItem(arg_7_0, arg_7_1)
	local var_7_0 = zbTipCommonWnd_Item.new()

	var_7_0:init(arg_7_0, arg_7_1)

	return var_7_0
end
