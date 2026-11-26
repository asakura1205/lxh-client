local var_0_0 = class("zbHeroDecomposeHeroCard")

var_0_0.__index = var_0_0

local var_0_1 = 5

function createHeroDecomposeHeroCard(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.selectCallback = nil
	arg_2_0.layerContent = arg_2_1
	arg_2_0.spriteStars = {}
	arg_2_0.headRoot = tolua.cast(arg_2_1:getChildByTag(1), "CCLayerColor")
	arg_2_0.spriteFrame = tolua.cast(arg_2_0.headRoot:getChildByTag(2), "CCSprite")
	arg_2_0.spriteHead = tolua.cast(arg_2_0.headRoot:getChildByTag(3), "CCSprite")
	arg_2_0.lbName = tolua.cast(arg_2_1:getChildByTag(2), "CCLabelTTF")
	arg_2_0.hunyu = tolua.cast(arg_2_1:getChildByTag(3), "CCLabelTTF")
	arg_2_0.checkBoxOk = tolua.cast(arg_2_1:getChildByTag(4), "CCSprite")
	arg_2_0.qualityRoot = tolua.cast(arg_2_1:getChildByTag(5), "CCNode")

	for iter_2_0 = 1, 8 do
		arg_2_0.spriteStars[iter_2_0] = arg_2_0.qualityRoot:getChildByTag(iter_2_0)
	end

	arg_2_0.btnTouch = tolua.cast(arg_2_1:getChildByTag(0), "CCControlButton")

	arg_2_0.btnTouch:addHandleOfControlEvent(function()
		arg_2_0:onTouchCallback()
	end, CCControlEventTouchUpInside)
	arg_2_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
	arg_2_0.btnTouch:setSwallowsTouches(false)
	arg_2_0.btnTouch:setZoomScaleInner(false)
	arg_2_0.btnTouch:setZoomOnTouchDown(false)
	arg_2_0.layerContent:setVisible(false)
	arg_2_0:onSelect(false)
end

function var_0_0.setVisible(arg_4_0, arg_4_1)
	arg_4_0.layerContent:setVisible(b)
end

function var_0_0.refresh(arg_5_0, arg_5_1)
	local var_5_0 = {
		heroDesc = arg_5_1,
		TemplateId = arg_5_1.heroTemplateId
	}

	var_5_0.count = 1
	arg_5_0.data = var_5_0
	arg_5_0.selectCallback = nil

	arg_5_0.layerContent:setVisible(true)
	arg_5_0.checkBoxOk:setVisible(false)
	arg_5_0.btnTouch:setTag(0)

	if arg_5_0.data.heroDesc.isEmpty then
		arg_5_0.layerContent:setVisible(false)

		return
	end

	if arg_5_0.data.heroDesc.heroTemplateId == -1 then
		arg_5_0.layerContent:setVisible(false)

		return
	end

	local var_5_1 = g_Self.kHeroHandler:getHeroByTemplateId(var_5_0.TemplateId)
	local var_5_2 = zbHeroTable:getRecord(var_5_0.TemplateId)

	if var_5_2 == nil then
		return
	end

	zbUIEffect:centerHeroStar(arg_5_0.spriteStars, var_5_2.star)

	local var_5_3 = zbColor:getHeroFragFrameTex(var_5_2.quality)

	arg_5_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_3))

	local var_5_4 = zbIconHelper:getHeroIconPath(var_5_0.TemplateId)

	arg_5_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_4))

	local var_5_5 = zbHeroFragTable:getHunyunNum(var_5_2.rarity)

	arg_5_0.hunyu:setString(" " .. var_5_5)
	arg_5_0.lbName:setString(var_5_2.name .. a2u(" X") .. arg_5_0.data.heroDesc.fragCount)
	arg_5_0:onSelect(g_MainScene.wndHeroDecomposeHeroSelect:isSelect(arg_5_0.data))
end

function var_0_0.setSelectCallback(arg_6_0, arg_6_1)
	arg_6_0.selectCallback = arg_6_1
end

function var_0_0.onTouchCallback(arg_7_0)
	local var_7_0 = arg_7_0.btnTouch:getTag()

	if table.getn(g_MainScene.wndHeroDecomposeHeroSelect.selectHeroDescList) >= var_0_1 and var_7_0 == 0 then
		g_Bubble:bubbleInfo("\xC8\xDB\xC1\xB6λ\xD2\xD1\xC2\xFA")

		return
	end

	local var_7_1 = true

	if var_7_0 == 1 then
		var_7_1 = false
	end

	arg_7_0:onSelect(var_7_1)

	if var_7_1 then
		if arg_7_0.data.heroDesc.isFrag then
			if arg_7_0.data.heroDesc.fragCount > 1 then
				local function var_7_2()
					g_MainScene.wndHeroDecomposeHeroSelect:selectHero(arg_7_0.data)
				end

				g_MainScene:showDecomposeHeroCountSelcetWnd(arg_7_0.data, var_7_2):setPrevWnd(g_MainScene.wndHeroDecomposeHeroSelect)
			else
				arg_7_0.data.count = 1

				g_MainScene.wndHeroDecomposeHeroSelect:selectHero(arg_7_0.data)
			end
		end
	else
		g_MainScene.wndHeroDecomposeHeroSelect:unSelectHero(arg_7_0.data)
	end
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if arg_9_1 then
		var_9_0 = 1
	end

	arg_9_0.btnTouch:setTag(var_9_0)
	arg_9_0.checkBoxOk:setVisible(arg_9_1)
end
