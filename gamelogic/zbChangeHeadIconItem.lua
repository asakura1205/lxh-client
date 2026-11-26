zbChangeHeadIconItem = class("zbChangeHeadIconItem", CCNodeExtend)
zbChangeHeadIconItem.__index = zbChangeHeadIconItem

function zbChangeHeadIconItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbChangeHeadIconItem)

	return arg_1_0
end

function zbChangeHeadIconItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbChangeHeadIconItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbChangeHeadIconItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.heroBaseInfo = nil
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.spriteSelect = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCSprite")
		arg_3_0.btnFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		arg_3_0.qualityRoot = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCNode")
		arg_3_0.spriteStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.spriteStars[iter_5_0] = arg_3_0.qualityRoot:getChildByTag(iter_5_0)
		end

		arg_3_0.centerPos = arg_3_0.spriteStars[3]:getPositionX()

		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbChangeHeadIconItem.refresh(arg_7_0, arg_7_1)
	arg_7_0.heroBaseInfo = arg_7_1

	if arg_7_1 == nil then
		return
	end

	arg_7_0:setVisible(true)

	local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.TemplateId)

	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))

	local var_7_1 = arg_7_1.Star

	zbUIEffect:centerHeroStar(arg_7_0.spriteStars, var_7_1)

	if arg_7_1.TemplateId == g_GameData.BaseInfo.HeadId then
		arg_7_0.spriteSelect:setVisible(true)
		arg_7_0.btnFrame:setEnabled(false)
	else
		arg_7_0.spriteSelect:setVisible(false)
		arg_7_0.btnFrame:setEnabled(true)
	end

	arg_7_0.layerContent:setVisible(true)
end

function zbChangeHeadIconItem.onTouch(arg_8_0)
	if arg_8_0.heroBaseInfo.Star < 3 then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xC9\xFD\xB5\xBD3\xD0ǽ\xE2\xCB\xF8ͷ\xCF\xF1"))

		return
	end

	g_WsMsgHandler:WS_Common_SetHeadId_Req(arg_8_0.heroBaseInfo.TemplateId)
	g_MainScene.wndChangHeadIcon:hide()
end
