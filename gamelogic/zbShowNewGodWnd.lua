require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowNewGodWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowNewGodWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.funRecord = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/show_newgod.ccbi", var_5_0, true, "")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCNode")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteFunc = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCSprite")
		arg_3_0.lbGoTip = tolua.cast(arg_3_0.spriteBg:getChildByTag(5), "CCLabelTTF")

		arg_3_0.lbGoTip:setVisible(false)

		arg_3_0.btnFinish = tolua.cast(arg_3_0.spriteBg:getChildByTag(6), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(arg_3_0.spriteBg:getChildByTag(31), "CCControlButton")

		arg_3_0.btnFinish:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	local function var_3_2()
		arg_3_0.effect = createUIAnimation()

		arg_3_0.effect:refresh("effect/spine/zhanshi/zhanshi.json", "effect/spine/zhanshi/zhanshi.atlas")
		arg_3_0.effect:setPosition(0, 85)
		arg_3_0.nodeEffect:addChild(arg_3_0.effect)
	end

	var_3_0()
	var_3_1()
	var_3_2()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	g_Audio:playSound(AudioDefine.UI_NEWHERO)

	if arg_9_1 then
		local var_9_0 = zbGodBaseTable:getRecord(arg_9_1)

		if var_9_0 then
			arg_9_0.lbName:setString(a2u(var_9_0.name))
			arg_9_0.spriteFunc:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_0.iconPath))
		end
	end

	arg_9_0:playEffect()
end

function var_0_0.onGoto(arg_10_0)
	if arg_10_0.btnClose:isVisible() == false then
		return
	end

	arg_10_0:hide()
	g_MainScene:showGodWnd()
end

function var_0_0.onFinish(arg_11_0)
	if arg_11_0.btnClose:isVisible() == false then
		return
	end

	g_Self.kGodHandler.getnewGodId = nil

	arg_11_0:hide()
end

function var_0_0.playEffect(arg_12_0)
	local var_12_0 = 0

	local function var_12_1(arg_13_0, arg_13_1)
		local function var_13_0(arg_14_0)
			arg_14_0:setVisible(true)
		end

		local var_13_1 = CCArray:create()

		var_13_1:addObject(CCDelayTime:create(var_12_0))
		var_13_1:addObject(CCCallFuncN:create(var_13_0))
		arg_13_0:setVisible(false)
		arg_13_0:stopAllActions()
		arg_13_0:runAction(CCSequence:create(var_13_1))

		var_12_0 = var_12_0 + arg_13_1
	end

	arg_12_0.effect:playAnimationOnce("newfunc_1", "newfunc_2", 0.125)

	var_12_0 = var_12_0 + 0.5

	var_12_1(arg_12_0.spriteTitle, 0.125)
	var_12_1(arg_12_0.lbName, 0.125)
	var_12_1(arg_12_0.spriteFunc, 0.125)

	if arg_12_0.lbGoTip:isVisible() then
		var_12_1(arg_12_0.lbGoTip, 0.125)
	end

	var_12_1(arg_12_0.btnFinish, 0.125)
	var_12_1(arg_12_0.btnClose, 0.125)
end
