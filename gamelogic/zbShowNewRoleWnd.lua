require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbShowNewRoleWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowNewRoleWnd()
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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/role_show.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.effectRoot = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeView = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		arg_3_0.viewEffectNode1 = tolua.cast(arg_3_0.nodeView:getChildByTag(200), "CCNode")
		arg_3_0.viewEffectNode2 = tolua.cast(arg_3_0.nodeView:getChildByTag(100), "CCNode")
		arg_3_0.spriteHero = tolua.cast(arg_3_0.nodeView:getChildByTag(1), "CCSprite")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.createHeroViewEffect(arg_7_0)
	g_Audio:playSound(AudioDefine.UI_NEWHERO)
	arg_7_0.viewEffectNode1:removeAllChildrenWithCleanup(true)

	local var_7_0 = createUIAnimation()

	var_7_0:refresh("effect/spine/ui_chouka/chouka_06_1/chouka_06_1.json", "effect/spine/ui_chouka/chouka_06_1/chouka_06_1.atlas")
	var_7_0:setPosition(0, 0)
	arg_7_0.viewEffectNode1:addChild(var_7_0)
	var_7_0:playAnimationOnce("animation_05", "animation_06", 0.12)
	arg_7_0.viewEffectNode2:removeAllChildrenWithCleanup(true)

	local var_7_1 = createUIAnimation()

	var_7_1:refresh("effect/spine/ui_chouka/chouka_06_2/chouka_06_2.json", "effect/spine/ui_chouka/chouka_06_2/chouka_06_2.atlas")
	var_7_1:setPosition(0, 0)
	arg_7_0.viewEffectNode2:addChild(var_7_1)
	var_7_1:playAnimationOnce("animation_01", "animation_02", 0.12)
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.avatarId = arg_8_1

	local var_8_0 = zbAvatarTable:getRecord(arg_8_1)

	arg_8_0.spriteHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0.iconPath))
	arg_8_0:createHeroViewEffect()

	local function var_8_1()
		if arg_8_1 then
			local var_9_0 = zbAvatarTable:getAvatarSoundPath(arg_8_1, ESoundType.E_GET)

			g_Audio:playSound(var_9_0)
		end
	end

	local var_8_2 = CCScaleTo:create(0.15, 1.4)
	local var_8_3 = CCScaleTo:create(0.15, 0.9)
	local var_8_4 = CCScaleTo:create(0.3, 1.3)
	local var_8_5 = CCScaleTo:create(0.2, 1)
	local var_8_6 = CCCallFuncN:create(var_8_1)
	local var_8_7 = CCArray:create()

	var_8_7:addObject(var_8_2)
	var_8_7:addObject(var_8_3)
	var_8_7:addObject(var_8_4)
	var_8_7:addObject(var_8_5)
	var_8_7:addObject(CCDelayTime:create(1))
	var_8_7:addObject(var_8_6)

	local var_8_8 = CCSequence:create(var_8_7)

	arg_8_0.spriteHero:stopAllActions()
	arg_8_0.spriteHero:runAction(var_8_8)
end

function var_0_0.onTouchTest(arg_10_0)
	if arg_10_0.spriteHero:numberOfRunningActions() > 0 then
		return
	end

	arg_10_0:hide()

	if g_MainScene.wndRole then
		g_MainScene.wndRole:hide()
	end

	if g_FirstCombat:isActive() then
		g_FirstCombat:onRoleCreated()
	end
end
