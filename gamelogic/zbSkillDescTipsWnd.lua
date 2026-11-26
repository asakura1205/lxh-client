require("gamelogic.zbBaseWnd")

local var_0_0 = {}

var_0_0[1] = "\xC6չ\xA5"
var_0_0[2] = "\xD6\xF7\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[3] = "\xD7Զ\xAF\xBC\xBC\xC4\xDC"
var_0_0[4] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[5] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"
zbSkillDescTipsWnd = class("zbSkillDescTipsWnd", zbBaseWnd)
zbSkillDescTipsWnd.__index = zbSkillDescTipsWnd

function zbSkillDescTipsWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSkillDescTipsWnd)

	return arg_1_0
end

function createSkillDescTipsWnd()
	local var_2_0 = zbSkillDescTipsWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbSkillDescTipsWnd.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/skillDescTip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteBg = tolua.cast(arg_3_0.layer:getChildByTag(0), "CCScale9Sprite")
		arg_3_0.skillIcon = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCSprite")

		arg_3_0.skillIcon:setMaskTexture(MASK_NOMRML_TEX)

		arg_3_0.lbName = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteLevel = tolua.cast(arg_3_0.layer:getChildByTag(4), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1), "CCLabelTTF")
		arg_3_0.detailLayer = tolua.cast(arg_3_0.layer:getChildByTag(5), "CCNode")
		arg_3_0.lbSkillDesc = tolua.cast(arg_3_0.detailLayer:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbCurrTitle = tolua.cast(arg_3_0.detailLayer:getChildByTag(6), "CCLabelTTF")
		arg_3_0.lbCurrDesc = tolua.cast(arg_3_0.detailLayer:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbNextTitle = tolua.cast(arg_3_0.detailLayer:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lbNextDesc = tolua.cast(arg_3_0.detailLayer:getChildByTag(9), "CCLabelTTF")
		arg_3_0.lbZiDong = tolua.cast(arg_3_0.layer:getChildByTag(10), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)
		arg_3_0.detailLayer:removeFromParentAndCleanup(false)

		local var_5_3 = CCScrollView:create(arg_3_0.detailLayer:getContentSize())

		var_5_3:setDirection(kCCScrollViewDirectionVertical)
		var_5_3:setPosition(arg_3_0.detailLayer:getPosition())
		var_5_3:setAnchorPoint(ccp(0, 0))
		var_5_3:setBounceable(false)
		var_5_3:setContainer(arg_3_0.detailLayer)
		var_5_3:setContentOffset(ccp(0, 0))
		arg_3_0.layer:addChild(var_5_3)

		arg_3_0.scrollView = var_5_3
		arg_3_0.layerPoint = ccp(arg_3_0.layer:getPosition())

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbSkillDescTipsWnd.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.skillIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getSkillIconPath(arg_7_2.id)))
	arg_7_0.lbZiDong:setString(a2u(var_0_0[arg_7_4]))
	arg_7_0.lbName:setString(arg_7_2.name)
	arg_7_0.lbLevel:setString(arg_7_1)
	arg_7_0.lbSkillDesc:setString(arg_7_2.descBase)
	arg_7_0.lbNextTitle:setString("")
	arg_7_0.lbNextDesc:setString("")

	local var_7_0 = string.format(arg_7_2.descLevel, arg_7_2.skillBase + arg_7_2.skillGrowth * arg_7_1)

	arg_7_0.lbCurrDesc:setString(a2u(var_7_0))

	if arg_7_1 == 0 then
		arg_7_0.spriteLevel:setVisible(false)
		arg_7_0.lbCurrTitle:setString(a2u("\xBC\xBC\xC4\xDCЧ\xB9\xFB"))
		arg_7_0.lbNextTitle:setVisible(false)
		arg_7_0.lbNextDesc:setVisible(false)
	else
		arg_7_0.lbCurrTitle:setString(a2u("\xB5\xB1ǰЧ\xB9\xFB"))

		if zbHeroSkillUpgradeTable:getMaxLevel(arg_7_2.id) == arg_7_1 then
			arg_7_0.lbNextTitle:setVisible(false)
			arg_7_0.lbNextDesc:setVisible(false)
			arg_7_0.spriteLevel:setVisible(false)
		else
			arg_7_0.spriteLevel:setVisible(true)
			arg_7_0.lbNextTitle:setVisible(true)
			arg_7_0.lbNextDesc:setVisible(true)

			local var_7_1 = string.format(arg_7_2.descLevel, arg_7_2.skillBase + arg_7_2.skillGrowth * (arg_7_1 + 1))

			arg_7_0.lbNextDesc:setString(a2u(var_7_1))
			arg_7_0.lbNextTitle:setString(a2u("\xCF¼\xB6Ч\xB9\xFB"))
		end
	end

	local var_7_2 = {
		arg_7_0.lbNextDesc,
		arg_7_0.lbNextTitle,
		arg_7_0.lbCurrDesc,
		arg_7_0.lbCurrTitle,
		arg_7_0.lbSkillDesc
	}
	local var_7_3 = ui:adjustLableHeightSkill(var_7_2, 360, 5, 20)

	arg_7_0.spriteBg:setContentSize(CCSizeMake(420, 130 + var_7_3))
	arg_7_0.detailLayer:setContentSize(CCSizeMake(380, var_7_3))

	local var_7_4 = 220 - var_7_3

	arg_7_0.scrollView:setContentOffset(ccp(0, var_7_4))

	if arg_7_3 == 0 then
		local var_7_5 = arg_7_0.layerPoint.x - 55

		arg_7_0.layer:setPosition(var_7_5, arg_7_0.layerPoint.y)
	else
		arg_7_0.layer:setPosition(arg_7_0.layerPoint)
	end
end

function zbSkillDescTipsWnd.onTouchTest(arg_8_0)
	arg_8_0:hide()
end
