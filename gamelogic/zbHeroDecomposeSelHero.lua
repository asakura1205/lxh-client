local var_0_0 = class("zbHeroDecomposeSelHero", CCNodeExtend)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroDecomposeSelWnd(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.showTipsWnd = false
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbl_num = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		arg_3_0.lbl_num:setVisible(true)

		arg_3_0.spriteFrag = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")

		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.data = arg_10_1

		arg_10_0.lbl_num:setString(arg_10_1.awardCount)
	end

	local var_10_0 = zbHeroTable:getRecord(arg_10_1.awardId)

	if var_10_0 then
		local var_10_1 = zbColor:getHeroFragFrameTex(var_10_0.quality)

		ui:setButtonPic(arg_10_0.btnFrame, var_10_1, var_10_1, var_10_1)

		local var_10_2 = zbIconHelper:getHeroIconPath(arg_10_1.awardId)

		arg_10_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_2))
	end
end

function var_0_0.onTouch(arg_11_0)
	if arg_11_0.showTipsWnd == false and g_MainScene.wndEquipDecompose then
		g_MainScene.wndEquipDecompose:removeItem(arg_11_0.data, arg_11_0.index)
	end
end

function var_0_0.onTouchDown(arg_12_0)
	arg_12_0.showTipsWnd = false
	arg_12_0.lastDownTouch = arg_12_0.btnFrame:getTouch():getLocation()

	local var_12_0 = CCArray:create()

	var_12_0:addObject(CCDelayTime:create(0.3))
	var_12_0:addObject(CCCallFuncN:create(function()
		arg_12_0:onShowTips()
	end))

	local var_12_1 = CCSequence:create(var_12_0)

	arg_12_0:stopAllActions()
	arg_12_0:runAction(var_12_1)
end

function var_0_0.onTouchMove(arg_14_0)
	return
end

function var_0_0.onTouchEnd(arg_15_0)
	arg_15_0:stopAllActions()

	if g_MainScene.wndCommomTip ~= nil then
		g_MainScene.wndCommomTip:hideTips()
	end
end

function var_0_0.onShowTips(arg_16_0)
	local var_16_0 = arg_16_0.layerDetail

	while var_16_0:getParent() ~= nil do
		var_16_0 = var_16_0:getParent()
	end

	if arg_16_0.data.equip ~= nil then
		arg_16_0.showTipsWnd = true

		local var_16_1 = var_16_0:convertToNodeSpace(arg_16_0.lastDownTouch)

		if arg_16_0.data.isFrag then
			g_MainScene:showAwardTip(ECommonAwardType.HeroFrag, arg_16_0.data.equip.TemplateId)
		end

		g_MainScene.wndCommomTip:refreshPos(var_16_1)
	end
end
