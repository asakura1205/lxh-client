zbHeroExtraAttrItem = class("zbHeroExtraAttrItem", CCNodeExtend)
zbHeroExtraAttrItem.__index = zbHeroExtraAttrItem

function zbHeroExtraAttrItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroExtraAttrItem)

	return arg_1_0
end

function zbHeroExtraAttrItem.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbHeroExtraAttrItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbHeroExtraAttrItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.node = arg_3_1
		arg_3_0.parent = arg_3_3
	end

	local function var_3_1()
		arg_3_0.layer = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCSprite")
		arg_3_0.skillDescLayer = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCLayer")
		arg_3_0.skillframe = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(1), "CCSprite")
		arg_3_0.skillIcon = tolua.cast(arg_3_0.skillframe:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbZiDongDummy = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.spriteLevel = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(5), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbNumDummy = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(1008), "CCLabelTTF")
		arg_3_0.btnAddUp = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnAddUp:addHandleOfControlEvent(function()
			arg_3_0:onUpgrade()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAddUp:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnAddUp:setSwallowsTouches(false)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		arg_3_0.lbZiDong = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbZiDongDummy, arg_3_0.lbZiDong)
		arg_3_0.lbZiDong:setScale(0.65)

		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumDummy, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.55)
		arg_3_0.skillIcon:setMaskTexture(MASK_NOMRML_TEX)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(CCSizeMake(564, 85))
	end

	var_3_0()
	var_3_1()
end

function zbHeroExtraAttrItem.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.value = arg_7_1
	arg_7_0.extraAttrRecord = arg_7_2
	arg_7_0.TemplateId = arg_7_3

	arg_7_0.lbLevel:setString(arg_7_0.value.Level)
	arg_7_0.lbNum:setString(arg_7_2[arg_7_0.value.Level].costFrag)
	arg_7_0.lbZiDong:setString("+" .. arg_7_1.AttrInfo[3])

	local var_7_0 = a2u(getItemPropStr(arg_7_1.AttrInfo[1]))

	arg_7_0.lbName:setString(var_7_0)
	arg_7_0.skillIcon:setTexture(CCTextureCache:sharedTextureCache():addImage("image/icon/attrtype/attrtype_" .. arg_7_1.AttrInfo[1] .. ".jpg"))
end

function zbHeroExtraAttrItem.onUpgrade(arg_8_0)
	g_WsMsgHandler:WS_Hero_Cast_Req(arg_8_0.TemplateId, arg_8_0.value.Index)
end
