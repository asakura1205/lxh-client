zbChatURLItem = class("zbChatURLItem")
zbChatURLItem.__index = zbChatURLItem

function zbChatURLItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbChatURLItem)

	return arg_1_0
end

function zbChatURLItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbChatURLItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbChatURLItem.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.urlId = -1
		arg_3_0.urlType = EChatURLTab.Hero
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteFrame = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbChatURLItem.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:setVisible(arg_7_2 ~= nil)

	arg_7_0.urlType = arg_7_1

	local var_7_0 = ""
	local var_7_1 = ""

	if arg_7_1 == EChatURLTab.Equip then
		arg_7_0.urlId = arg_7_2.EquipId
		var_7_0 = zbIconHelper:getItemIconPath(arg_7_2.TemplateId)
		var_7_1 = zbColor:getEquipFrameTex(arg_7_2.Quality)
	elseif arg_7_1 == EChatURLTab.Hero then
		arg_7_0.urlId = arg_7_2.TemplateId
		var_7_0 = zbIconHelper:getHeroIconPath(arg_7_2.TemplateId)
		var_7_1 = zbColor:getHeroFrameTex(arg_7_2.Quality)
	end

	arg_7_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
end

function zbChatURLItem.onTouch(arg_8_0)
	if g_MainScene.wndChat then
		g_MainScene.wndChat:setInputBoxStr(arg_8_0.urlId, arg_8_0.urlType)
		g_MainScene.wndChatURL:setVisible(false)
	end
end
