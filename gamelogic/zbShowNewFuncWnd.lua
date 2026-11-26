require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowNewFuncWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowNewFuncWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/show_newfunc.ccbi", var_5_0, true, "")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCNode")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteFunc = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCSprite")
		arg_3_0.lbGoTip = tolua.cast(arg_3_0.spriteBg:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnFinish = tolua.cast(arg_3_0.spriteBg:getChildByTag(6), "CCControlButton")
		arg_3_0.btnGo = tolua.cast(arg_3_0.spriteBg:getChildByTag(7), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(arg_3_0.spriteBg:getChildByTag(31), "CCControlButton")

		arg_3_0.btnFinish:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGo:addHandleOfControlEvent(function()
			arg_3_0:onGoto()
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

function var_0_0.refresh(arg_10_0, arg_10_1)
	local var_10_0 = zbFunctionUnlockTable:getCurNewFunction(arg_10_1)

	if var_10_0 == nil then
		return false
	end

	if var_10_0.showTime == EFunShowTime.NoTip then
		return
	end

	if var_10_0.showTime == EFunShowTime.Home and g_MainScene:isOnlyMainVisible() == false then
		g_MainScene:pushHomeFunShow(var_10_0)

		return false
	end

	return arg_10_0:refreshFunRecord(var_10_0)
end

function var_0_0.refreshFunRecord(arg_11_0, arg_11_1)
	arg_11_0.funRecord = arg_11_1

	g_MainScene:popHomeFunShow(arg_11_0.funRecord)
	arg_11_0:setModel(true)
	arg_11_0:show(g_MainScene)
	arg_11_0.lbName:setString(arg_11_0.funRecord.name)
	arg_11_0.spriteFunc:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_11_0.funRecord.linkIcon))
	g_Self:setFirstPassForce(false)
	g_Audio:playSound(AudioDefine.UI_NEWHERO)
	arg_11_0:playEffect()

	if EFuncType.EliteLevel == arg_11_0.funRecord.id then
		g_Guide:execGuide(GUIDE_STEP_ELITELEVEL)
		arg_11_0:hide()

		return
	end

	arg_11_0:onGuide()

	return true
end

local var_0_1 = {
	[EFuncType.God] = GUIDE_STEP_GOD,
	[EFuncType.DailyTask] = GUIDE_STEP_DAILYTASK,
	[EFuncType.Trial] = GUIDE_STEP_HEROTRAIL,
	[EFuncType.Tech] = GUIDE_STEP_TECH,
	[EFuncType.HeroRefresh] = GUIDE_STEP_HEROXIULIAN,
	[EFuncType.World] = GUIDE_STEP_WORLD,
	[EFuncType.Arena] = GUIDE_STEP_ARENA,
	[EFuncType.Pata] = GUIDE_STEP_PATA,
	[EFuncType.Bgz] = GUIDE_STEP_TUANSHU
}

function var_0_0.onGuide(arg_12_0)
	g_Guide:execGuide(var_0_1[arg_12_0.funRecord.id])
end

function var_0_0.onGoto(arg_13_0)
	if arg_13_0.btnClose:isVisible() == false then
		return
	end

	arg_13_0:hide()
	zbLinkHelper:execLink(arg_13_0.funRecord.linkUrl)
end

function var_0_0.onFinish(arg_14_0)
	if arg_14_0.btnClose:isVisible() == false then
		return
	end

	arg_14_0:hide()
end

function var_0_0.playEffect(arg_15_0)
	local var_15_0 = 0

	local function var_15_1(arg_16_0, arg_16_1)
		local function var_16_0(arg_17_0)
			arg_17_0:setVisible(true)
		end

		local var_16_1 = CCArray:create()

		var_16_1:addObject(CCDelayTime:create(var_15_0))
		var_16_1:addObject(CCCallFuncN:create(var_16_0))
		arg_16_0:setVisible(false)
		arg_16_0:stopAllActions()
		arg_16_0:runAction(CCSequence:create(var_16_1))

		var_15_0 = var_15_0 + arg_16_1
	end

	arg_15_0.effect:playAnimationOnce("newfunc_1", "newfunc_2", 0.125)

	var_15_0 = var_15_0 + 0.5

	var_15_1(arg_15_0.spriteTitle, 0.125)
	var_15_1(arg_15_0.lbName, 0.125)
	var_15_1(arg_15_0.spriteFunc, 0.125)

	if arg_15_0.lbGoTip:isVisible() then
		var_15_1(arg_15_0.lbGoTip, 0.125)
	end

	var_15_1(arg_15_0.btnFinish, 0.125)
	var_15_1(arg_15_0.btnClose, 0.125)
end
