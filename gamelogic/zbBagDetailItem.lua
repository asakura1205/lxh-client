require("gamebase.zbFunctions")

local var_0_0 = class("zbBagDetailItem", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = {}

var_0_1[1] = "image/icon/gemstone/shengMingMark.jpg"
var_0_1[2] = "image/icon/gemstone/faGongMark.jpg"
var_0_1[3] = "image/icon/gemstone/wuGongMark.jpg"
var_0_1[4] = "image/icon/gemstone/wuFangMark.jpg"
var_0_1[5] = "image/icon/gemstone/faFangMark.jpg"

local var_0_2 = {}

var_0_2[1] = "shengMingFrame0"
var_0_2[2] = "faGongFrame0"
var_0_2[3] = "wuGongFrame0"
var_0_2[4] = "wuFangFrame0"
var_0_2[5] = "faFangFrame0"

local var_0_3 = CCSizeMake(110, 110)

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createBagDetailItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	function initMember()
		arg_3_0.equip = nil
		arg_3_0.awardType = -1
		arg_3_0.showTips = false
		arg_3_0.isItem = false
		arg_3_0.TemplateId = -1
	end

	function initCCB()
		arg_3_0.layerContent = arg_3_1
		arg_3_0.btnFrame = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbCount = tolua.cast(arg_3_1:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbLevel = tolua.cast(arg_3_1:getChildByTag(6), "CCLabelTTF")

		arg_3_0:setContentSize(arg_3_1:getContentSize())
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0.lbCount:setVisible(false)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
	end

	initMember()
	initCCB()
end

function var_0_0.refreshItemData(arg_8_0, arg_8_1)
	local var_8_0 = zbItemTable:getRecord(arg_8_1.TemplateId)

	arg_8_0.TemplateId = arg_8_1.TemplateId

	local var_8_1 = zbIconHelper:getItemIconPath(arg_8_1.TemplateId)

	arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))

	local var_8_2 = zbColor:getEquipFrameTex(var_8_0.quality)

	ui:setButtonPic(arg_8_0.btnFrame, var_8_2, var_8_2, var_8_2)
end

function var_0_0.onTouchDown(arg_9_0)
	arg_9_0.lastDownTouch = arg_9_0.btnFrame:getTouch():getLocation()

	arg_9_0:onShowTips()
end

function var_0_0.onShowTips(arg_10_0)
	local var_10_0 = arg_10_0.layerContent

	while var_10_0:getParent() ~= nil do
		var_10_0 = var_10_0:getParent()
	end

	arg_10_0.showTips = true

	local var_10_1 = var_10_0:convertToNodeSpace(arg_10_0.lastDownTouch)

	g_MainScene:showAwardTip(ECommonAwardType.Item, arg_10_0.TemplateId)
	g_MainScene.wndCommomTip:refreshPos(var_10_1)
end

function var_0_0.onTouchEnd(arg_11_0)
	arg_11_0.showTips = false

	arg_11_0:stopAllActions()

	if g_MainScene.wndCommomTip ~= nil then
		g_MainScene.wndCommomTip:hideTips()
	end
end
