zbHeroShowItem = class("zbHeroShowItem")
zbHeroShowItem.__index = zbHeroShowItem

function zbHeroShowItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroShowItem)

	return arg_1_0
end

function zbHeroShowItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHeroShowItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHeroShowItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.heroTemplateId = 0
		arg_3_0.parentWnd = arg_3_1
	end

	local function var_3_1()
		arg_3_0.heroLayer = tolua.cast(arg_3_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnTouch = tolua.cast(arg_3_0.heroLayer:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteFrame = tolua.cast(arg_3_0.heroLayer:getChildByTag(2), "CCSprite")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.heroLayer:getChildByTag(3), "CCSprite")

		arg_3_0:setContentSize(CCSizeMake(110, 110))
		arg_3_0:addChild(arg_3_2)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function zbHeroShowItem.refresh(arg_7_0, arg_7_1)
	arg_7_0.heroTemplateId = arg_7_1

	local var_7_0 = ""
	local var_7_1 = arg_7_1 == HEROSHOW_UNOPEN_ID and "image/common/unknown_head.png" or zbIconHelper:getHeroIconPath(arg_7_1)

	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))

	local var_7_2 = not g_MyHome:isHeroHired(arg_7_0.heroTemplateId)

	arg_7_0.spriteIcon:setGray(var_7_2)
end

function zbHeroShowItem.onTouch(arg_8_0)
	if arg_8_0.heroTemplateId == HEROSHOW_UNOPEN_ID then
		g_Bubble:bubbleInfo("\xBE\xB4\xC7\xEB\xC6ڴ\xFD")
	else
		local var_8_0 = g_MyHome:getHero(arg_8_0.heroTemplateId)

		if var_8_0 ~= nil then
			g_MainScene:showHeroDetailWnd(var_8_0):setPrevWnd(arg_8_0.parentWnd)
		else
			g_Bubble:bubbleInfo("δ\xC4ܻ\xF1ȡӶ\xB1\xF8\xD0\xC5Ϣ:" .. arg_8_0.heroTemplateId)
		end
	end
end
