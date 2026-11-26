local var_0_0 = class("zbTipCommonWnd_godEquipSkill")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		return
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.node = arg_1_2
		arg_1_0.spriteBg = tolua.cast(arg_1_1:getChildByTag(0), "CCScale9Sprite")
		arg_1_0.spriteIcon = tolua.cast(arg_1_1:getChildByTag(3), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbDesc = tolua.cast(arg_1_1:getChildByTag(4), "CCLabelTTF")
		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width
	end

	var_1_0()
	var_1_1()
end

function var_0_0.refresh(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.SkillId
	local var_4_1 = zbGodSkillTable:getRecord(var_4_0)

	if var_4_1 then
		arg_4_0.layer:setVisible(true)
		arg_4_0.lbName:setString(var_4_1.name)

		local var_4_2 = g_Self.kGodHandler:getGodSkillDesc(var_4_0, 1)

		arg_4_0.lbDesc:setString(a2u(var_4_2))
		arg_4_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_1.iconPath))
	end
end

function createTipCommonWndgodEquipSkill(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.new()

	var_5_0:init(arg_5_0, arg_5_1)

	return var_5_0
end
