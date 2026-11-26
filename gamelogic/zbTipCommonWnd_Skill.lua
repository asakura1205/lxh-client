zbTipCommonWnd_Skill = class("zbTipCommonWnd_Skill")
zbTipCommonWnd_Skill.__index = zbTipCommonWnd_Skill

function zbTipCommonWnd_Skill.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		arg_1_0.nextLevelPos = ccp(0, 0)
		arg_1_0.nextDescPos = ccp(0, 0)
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.node = arg_1_2
		arg_1_0.spriteBg = tolua.cast(arg_1_1:getChildByTag(0), "CCScale9Sprite")
		arg_1_0.spriteFrame = tolua.cast(arg_1_1:getChildByTag(2), "CCSprite")
		arg_1_0.spriteIcon = tolua.cast(arg_1_1:getChildByTag(3), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbDesc = tolua.cast(arg_1_1:getChildByTag(4), "CCLabelTTF")
		arg_1_0.lbUpgrade = tolua.cast(arg_1_1:getChildByTag(5), "CCLabelTTF")
		arg_1_0.lbCurrTitle = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.lbCurDesc = tolua.cast(arg_1_1:getChildByTag(7), "CCLabelTTF")
		arg_1_0.lbNextTitle = tolua.cast(arg_1_1:getChildByTag(8), "CCLabelTTF")
		arg_1_0.lbNextDesc = tolua.cast(arg_1_1:getChildByTag(9), "CCLabelTTF")

		arg_1_0.spriteIcon:setMaskTexture(MASK_NOMRML_TEX)

		arg_1_0.nextLevelPos = ccp(arg_1_0.lbNextTitle:getPosition())
		arg_1_0.nextDescPos = ccp(arg_1_0.lbNextDesc:getPosition())
		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height * arg_1_1:getScaleY() * arg_1_2:getScaleY()
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width * arg_1_1:getScaleX() * arg_1_2:getScaleX()
	end

	var_1_0()
	var_1_1()
end

function zbTipCommonWnd_Skill.refresh(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = zbHeroSkillTable:getRecord(arg_4_1)

	if var_4_0 == nil then
		return
	end

	arg_4_0.layer:setVisible(true)
	arg_4_0.lbName:setString(var_4_0.name)
	arg_4_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_0.icon))
	arg_4_0.lbDesc:setString(var_4_0.descBase)
	arg_4_0.lbNextTitle:setString("")
	arg_4_0.lbNextDesc:setString("")

	local var_4_1 = string.format(var_4_0.descLevel, var_4_0.skillBase + var_4_0.skillGrowth * arg_4_2)

	arg_4_0.lbCurDesc:setString(a2u(var_4_1))

	if arg_4_2 == 0 then
		arg_4_0.lbUpgrade:setString(a2u("δ\xBF\xAA\xC6\xF4"))
		arg_4_0.lbCurrTitle:setString(a2u("\xBC\xBC\xC4\xDCЧ\xB9\xFB"))
		arg_4_0.lbNextTitle:setVisible(false)
		arg_4_0.lbNextDesc:setVisible(false)
		arg_4_0.spriteBg:setContentSize(CCSizeMake(345, 300))
	else
		arg_4_0.lbUpgrade:setString(a2u("Lv") .. arg_4_2)
		arg_4_0.lbCurrTitle:setString(a2u("\xB5\xB1ǰЧ\xB9\xFB"))
		arg_4_0.spriteBg:setContentSize(CCSizeMake(345, 360))

		if zbHeroSkillUpgradeTable:getMaxLevel(var_4_0.id) == arg_4_2 then
			arg_4_0.lbNextTitle:setVisible(false)
			arg_4_0.lbNextDesc:setVisible(false)
		else
			arg_4_0.lbNextTitle:setVisible(true)
			arg_4_0.lbNextDesc:setVisible(true)

			local var_4_2 = string.format(var_4_0.descLevel, var_4_0.skillBase + var_4_0.skillGrowth * (arg_4_2 + 1))

			arg_4_0.lbNextDesc:setString(a2u(var_4_2))
			arg_4_0.lbNextTitle:setString(a2u("\xCF¼\xB6Ч\xB9\xFB"))
		end
	end
end

function createTipCommonWndSkill(arg_5_0, arg_5_1)
	local var_5_0 = zbTipCommonWnd_Skill.new()

	var_5_0:init(arg_5_0, arg_5_1)

	return var_5_0
end
