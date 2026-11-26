require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGuideTalkWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 1
local var_0_2 = 2

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createGuideTalkWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.talkData = nil
		arg_3_0.curStep = 0
		arg_3_0.talkOverCallback = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/guide_talk.ccbi", var_5_0, true, "")

		arg_3_0.layerBlack = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		arg_3_0.layerLeft = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.layerRight = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(4), "CCControlButton")
		arg_3_0.leftHero = tolua.cast(arg_3_0.layerLeft:getChildByTag(1), "CCSprite")
		arg_3_0.leftDescBg = tolua.cast(arg_3_0.layerLeft:getChildByTag(2), "CCSprite")
		arg_3_0.leftDesc = tolua.cast(arg_3_0.layerLeft:getChildByTag(3), "CCLabelTTF")
		arg_3_0.leftName = tolua.cast(arg_3_0.layerLeft:getChildByTag(4), "CCLabelTTF")
		arg_3_0.rightHero = tolua.cast(arg_3_0.layerRight:getChildByTag(1), "CCSprite")
		arg_3_0.rightDescBg = tolua.cast(arg_3_0.layerRight:getChildByTag(2), "CCSprite")
		arg_3_0.rightDesc = tolua.cast(arg_3_0.layerRight:getChildByTag(3), "CCLabelTTF")
		arg_3_0.rightName = tolua.cast(arg_3_0.layerRight:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnTouch:setSoundTag(SOUNDTAG_GUIDE)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.layerBlack:setVisible(false)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.onHide(arg_8_0)
	if arg_8_0.talkOverCallback ~= nil then
		arg_8_0.talkOverCallback()
	end
end

function var_0_0.refresh(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 ~= nil then
		arg_9_0.layerBlack:setVisible(arg_9_3)
	else
		arg_9_0.layerBlack:setVisible(false)
	end

	arg_9_0.talkOverCallback = arg_9_2
	arg_9_0.talkData = g_DataConfig:getGuideTalk(arg_9_1)

	if arg_9_0.talkData == nil then
		echo("warning: invalid guide talkId: " .. arg_9_1)

		return
	end

	arg_9_0:setModel(true)
	arg_9_0:show(g_MainScene)
	arg_9_0:goto(1)
end

function var_0_0.goto(arg_10_0, arg_10_1)
	local function var_10_0(arg_11_0)
		if a2u(arg_11_0) == a2u("\xCD\xE6\xBC\xD2") or a2u(arg_11_0) == a2u("\xD6\xF7\xBD\xC7") then
			return g_Self:getName()
		else
			return arg_11_0
		end
	end

	local function var_10_1(arg_12_0)
		if arg_12_0 == 0 then
			return g_Self:getAvatarId()
		else
			return arg_12_0
		end
	end

	arg_10_0.curStep = arg_10_1

	local var_10_2 = arg_10_0.talkData[arg_10_0.curStep]

	if var_10_2 == nil then
		arg_10_0:hide()

		return
	end

	local function var_10_3(arg_13_0)
		local var_13_0 = string.gsub(arg_13_0, "%[color=0x[%a%d]+%]", "")
		local var_13_1 = string.gsub(var_13_0, "%[/color%]", "")

		return (string.gsub(var_13_1, a2u("\xCD\xE6\xBC\xD2"), a2u(g_Self:getName())))
	end

	if var_10_2.dir == var_0_1 then
		arg_10_0.layerRight:setZOrder(101)
		arg_10_0.layerBlack:setZOrder(100)
		arg_10_0.layerLeft:setZOrder(102)
		arg_10_0.layerLeft:setVisible(true)
		arg_10_0.leftDescBg:setVisible(true)
		arg_10_0.leftName:setVisible(true)
		arg_10_0.leftDesc:setVisible(true)
		arg_10_0.leftHero:setVisible(true)
		arg_10_0.layerRight:setVisible(false)
		arg_10_0.rightDescBg:setVisible(false)
		arg_10_0.rightDesc:setVisible(false)

		local var_10_4 = var_10_1(var_10_2.avatarId)
		local var_10_5 = zbIconHelper:getHeroTalkIconPath(var_10_4)

		arg_10_0.leftHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_5))
		arg_10_0.leftName:setString((var_10_0(var_10_2.name)))

		local var_10_6 = var_10_3(var_10_2.desc)

		arg_10_0.leftDesc:setString(a2u(var_10_6))
	else
		arg_10_0.layerLeft:setZOrder(101)
		arg_10_0.layerBlack:setZOrder(100)
		arg_10_0.layerRight:setZOrder(102)
		arg_10_0.layerRight:setVisible(true)
		arg_10_0.rightDescBg:setVisible(true)
		arg_10_0.rightName:setVisible(true)
		arg_10_0.rightDesc:setVisible(true)
		arg_10_0.rightHero:setVisible(true)
		arg_10_0.layerLeft:setVisible(false)
		arg_10_0.leftDescBg:setVisible(false)
		arg_10_0.leftDesc:setVisible(false)

		local var_10_7 = var_10_1(var_10_2.avatarId)
		local var_10_8 = zbIconHelper:getHeroTalkIconPath(var_10_7)

		arg_10_0.rightHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_8))
		arg_10_0.rightName:setString((var_10_0(var_10_2.name)))

		local var_10_9 = var_10_3(var_10_2.desc)

		arg_10_0.rightDesc:setString(a2u(var_10_9))
	end
end

function var_0_0.onTouch(arg_14_0)
	arg_14_0:goto(arg_14_0.curStep + 1)
end
