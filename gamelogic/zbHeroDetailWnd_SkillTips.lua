require("gamelogic.zbBaseWnd")

local var_0_0 = {}

var_0_0[1] = "\xC6չ\xA5"
var_0_0[2] = "\xD6\xF7\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[3] = "\xD7Զ\xAF\xBC\xBC\xC4\xDC"
var_0_0[4] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[5] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"
zbHeroDetailWnd_SkillTips = class("zbHeroDetailWnd_SkillTips")
zbHeroDetailWnd_SkillTips.__index = zbHeroDetailWnd_SkillTips

function createHeroDetailSkillTips(arg_1_0)
	local var_1_0 = zbHeroDetailWnd_SkillTips.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function zbHeroDetailWnd_SkillTips.init(arg_2_0, arg_2_1)
	local function var_2_0()
		return
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.spriteBg = tolua.cast(arg_2_0.layer:getChildByTag(0), "CCScale9Sprite")
		arg_2_0.skillframe = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCSprite")
		arg_2_0.skillIcon = tolua.cast(arg_2_0.skillframe:getChildByTag(2), "CCSprite")
		arg_2_0.lbName = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCLabelTTF")
		arg_2_0.spriteLevel = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCSprite")
		arg_2_0.lbLevelDummy = tolua.cast(arg_2_0.spriteLevel:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbSkillDesc = tolua.cast(arg_2_0.layer:getChildByTag(5), "CCLabelTTF")
		arg_2_0.lbCurrTitle = tolua.cast(arg_2_0.layer:getChildByTag(6), "CCLabelTTF")
		arg_2_0.lbCurr = tolua.cast(arg_2_0.layer:getChildByTag(7), "CCLabelTTF")
		arg_2_0.lbNextTitle = tolua.cast(arg_2_0.layer:getChildByTag(8), "CCLabelTTF")
		arg_2_0.lbNext = tolua.cast(arg_2_0.layer:getChildByTag(9), "CCLabelTTF")
		arg_2_0.lbZiDong = tolua.cast(arg_2_0.layer:getChildByTag(10), "CCLabelTTF")

		arg_2_0.lbCurr:setVisible(false)
		arg_2_0.lbNext:setVisible(false)

		arg_2_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.lbLevelDummy, arg_2_0.lbLevel)
		arg_2_0.lbLevel:setScale(0.55)

		arg_2_0.btnTouchTest = tolua.cast(arg_2_0.layer:getChildByTag(100), "CCControlButton")

		arg_2_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_2_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_2_0.skillIcon:setMaskTexture(CCTextureCache:sharedTextureCache():addImage("image/icon/heroskill/heroskill_mask.jpg"))
	end

	var_2_0()
	var_2_1()
end

function zbHeroDetailWnd_SkillTips.onTouchTest(arg_6_0)
	arg_6_0.layer:setVisible(false)
end

function zbHeroDetailWnd_SkillTips.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.lbCurrDesc = arg_7_0:refreshRichText(arg_7_0.lbCurr, arg_7_0.lbCurrDesc)
	arg_7_0.lbNextDesc = arg_7_0:refreshRichText(arg_7_0.lbNext, arg_7_0.lbNextDesc)

	arg_7_0.layer:addChild(arg_7_0.lbCurrDesc)
	arg_7_0.layer:addChild(arg_7_0.lbNextDesc)
	arg_7_0.layer:setVisible(true)
	arg_7_0.skillIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getSkillIconPath(arg_7_2.id)))
	arg_7_0.lbZiDong:setString(a2u(var_0_0[arg_7_3]))
	arg_7_0.lbName:setString(arg_7_2.name)
	arg_7_0.lbLevel:setString(arg_7_1)
	arg_7_0.lbSkillDesc:setString(arg_7_2.descBase)
	arg_7_0.lbNextTitle:setString("")
	arg_7_0.lbNextDesc:setRichString("")

	local var_7_0 = math.max(arg_7_1, 1)
	local var_7_1 = string.format(arg_7_2.descLevel, (arg_7_2.skillBase + arg_7_2.skillGrowth * var_7_0) * math.floor(0.2 * var_7_0 + 1.8) * 0.5)
	local var_7_2, var_7_3 = string.find(a2u(var_7_1), "%[.*%]")
	local var_7_4 = string.sub(a2u(var_7_1), 1, var_7_2 - 1)
	local var_7_5 = string.sub(a2u(var_7_1), var_7_2, var_7_3)
	local var_7_6 = string.sub(a2u(var_7_1), var_7_3 + 1)
	local var_7_7 = zbUtil:getRichColorString(var_7_4, HEX_FONT_COLOR_ORANGE)
	local var_7_8 = zbUtil:getRichColorString(var_7_5, HEX_FONT_COLOR_GREEN)
	local var_7_9 = zbUtil:getRichColorString(var_7_6, HEX_FONT_COLOR_ORANGE)

	arg_7_0.lbCurrDesc:setRichString(var_7_7 .. var_7_8 .. var_7_9)

	if arg_7_1 == 0 then
		arg_7_0.spriteLevel:setVisible(false)
		arg_7_0.lbCurrTitle:setString(a2u("\xBC\xBC\xC4\xDCЧ\xB9\xFB"))
		arg_7_0.lbNextTitle:setVisible(false)
		arg_7_0.lbNextDesc:setVisible(false)
	else
		arg_7_0.lbCurrTitle:setString(a2u("\xB5\xB1ǰЧ\xB9\xFB"))

		if arg_7_2.maxLevel == arg_7_1 then
			arg_7_0.lbNextTitle:setVisible(false)
			arg_7_0.lbNextDesc:setVisible(false)
			arg_7_0.spriteLevel:setVisible(false)
		else
			arg_7_0.spriteLevel:setVisible(true)
			arg_7_0.lbNextTitle:setVisible(true)
			arg_7_0.lbNextDesc:setVisible(true)

			local var_7_10 = string.format(arg_7_2.descLevel, (arg_7_2.skillBase + arg_7_2.skillGrowth * (arg_7_1 + 1)) * math.floor(0.2 * (arg_7_1 + 1) + 1.8) * 0.5)
			local var_7_11, var_7_12 = string.find(a2u(var_7_10), "%[.*%]")
			local var_7_13 = string.sub(a2u(var_7_10), 1, var_7_11 - 1)
			local var_7_14 = string.sub(a2u(var_7_10), var_7_11, var_7_12)
			local var_7_15 = string.sub(a2u(var_7_10), var_7_12 + 1)
			local var_7_16 = zbUtil:getRichColorString(var_7_13, HEX_FONT_COLOR_ORANGE)
			local var_7_17 = zbUtil:getRichColorString(var_7_14, HEX_FONT_COLOR_GREEN)
			local var_7_18 = zbUtil:getRichColorString(var_7_15, HEX_FONT_COLOR_ORANGE)

			arg_7_0.lbNextDesc:setRichString(var_7_16 .. var_7_17 .. var_7_18)
			arg_7_0.lbNextTitle:setString(a2u("\xCF¼\xB6Ч\xB9\xFB"))
		end
	end
end

function zbHeroDetailWnd_SkillTips.refreshRichText(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 ~= nil then
		arg_8_2:removeFromParentAndCleanup(true)

		arg_8_2 = nil
	end

	local var_8_0 = arg_8_1:getTxtBound().width
	local var_8_1 = arg_8_1:getContentSize()

	arg_8_2 = CCRichLabelTTF:create(var_8_1.width, var_8_1.height, arg_8_1:getFontSize(), arg_8_1:getFontName(), ccc3(255, 255, 255), false)

	arg_8_2:setVisible(true)

	local var_8_2 = ccp(arg_8_1:getPosition())

	arg_8_2:setPosition(var_8_2.x, var_8_2.y - var_8_1.height * 0.5)

	return arg_8_2
end
