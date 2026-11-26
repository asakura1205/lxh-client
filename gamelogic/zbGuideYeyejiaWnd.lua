require("gamelogic.zbBaseWnd")
require("gamecore.zbCombatScene")

local var_0_0 = class("zbGuideYeyeWnd", zbBaseWnd)

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

function createGuideYeyeWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local function var_5_0()
			local var_6_0 = zbAvatarTable:getRecord(g_Self:getAvatarId())

			if var_6_0 ~= nil then
				return var_6_0.bone
			else
				return "animation/hero/character_agen/character_agen"
			end
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/guide_yeyejia.ccbi", var_5_1, true, "")

		arg_3_0.nodeEye = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0.layerScene:load(3)
		arg_3_0:addChild(arg_3_0.layerScene)

		arg_3_0.fxs = arg_3_0:createAnim("animation/hero/character_fuxiansheng/character_fuxiansheng", ForceType.Left, 2, false)
		arg_3_0.player = arg_3_0:createAnim(var_5_0(), ForceType.Left, 2, true)
		arg_3_0.mtjj = arg_3_0:createAnim("animation/hero/charecter_mtjj/charecter_mtjj", ForceType.Right, 2, false)
		arg_3_0.lxhRX = arg_3_0:createAnim("animation/hero/character_luoxiaoheirenxing1/character_luoxiaoheirenxing1", ForceType.Right, 2, true)
		arg_3_0.lxh = arg_3_0:createAnim("animation/hero/character_luoxiaohei1/character_luoxiaohei1", ForceType.Left, 2, false)

		arg_3_0.lxh:setAnimation(ANIMATION_SEQUENCE_DIE, false)
		arg_3_0.lxh:setVisible(false)
		arg_3_0.mtjj:setVisible(false)
		arg_3_0.fxs:setVisible(false)

		arg_3_0.animYanwu = createUIAnimation()

		arg_3_0.animYanwu:refreshBone("effect/spine/ui_yanwu/ui_yanwu")
		arg_3_0.animYanwu:setVisible(false)
		arg_3_0.layerScene:addChild(arg_3_0.animYanwu)

		arg_3_0.animEye = createUIAnimation()

		arg_3_0.animEye:refreshBone("effect/spine/ui_yanjing/ui_yanjing")
		arg_3_0.animEye:setVisible(false)
		arg_3_0.nodeEye:addChild(arg_3_0.animEye)

		arg_3_0.nodeStepYanwu = CCNode:create()

		arg_3_0:addChild(arg_3_0.nodeStepYanwu)

		arg_3_0.nodeUI = var_5_2

		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.createAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = createUIAnimation()

	var_7_0:refreshBone(arg_7_1)
	var_7_0:setRotationY(180)
	var_7_0:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	arg_7_0.layerScene:addChild(var_7_0)

	local var_7_1 = CCSprite:create("image/combat/yingzi.png")

	var_7_1:setScale(0.7)
	var_7_1:setPosition(0, 0)

	local var_7_2 = CCScaleBy:create(1, 0.9)
	local var_7_3 = CCSequence:createWithTwoActions(var_7_2, var_7_2:reverse())

	var_7_1:runAction(CCRepeatForever:create(var_7_3))
	var_7_0:addChild(var_7_1, -1)
	var_7_1:setZOrder(-1)

	local var_7_4 = getCombatHeroPos(arg_7_2, arg_7_3)
	local var_7_5 = getCombatHeroPos(ForceType.Left, arg_7_3)

	var_7_0:setPosition(var_7_5)

	var_7_0.enterOk = false

	var_7_0.skeleton:setMix(ANIMATION_SEQUENCE_RUN, ANIMATION_SEQUENCE_IDLE, 0.25)
	var_7_0.skeleton:setMix(ANIMATION_SEQUENCE_IDLE, ANIMATION_SEQUENCE_RUN, 0.25)
	var_7_0.skeleton:setMix(ANIMATION_SEQUENCE_IDLE, ANIMATION_SEQUENCE_WEAK, 0.25)
	var_7_0.skeleton:setMix(ANIMATION_SEQUENCE_WEAK, ANIMATION_SEQUENCE_IDLE, 0.25)

	if arg_7_4 then
		local var_7_6 = 876

		var_7_5.x = var_7_5.x - var_7_6

		var_7_0:setPosition(var_7_5)
		var_7_0:setAnimation(ANIMATION_SEQUENCE_RUN, true)

		local function var_7_7()
			var_7_0:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
		end

		local function var_7_8()
			var_7_0:setAnimation(ANIMATION_SEQUENCE_WEAK, true)
		end

		local function var_7_9()
			var_7_0.enterOk = true
		end

		local var_7_10 = 2
		local var_7_11 = CCArray:create()

		var_7_11:addObject(CCMoveTo:create(var_7_10, var_7_4))
		var_7_11:addObject(CCCallFuncN:create(var_7_7))
		var_7_11:addObject(CCDelayTime:create(0.5))
		var_7_11:addObject(CCCallFuncN:create(var_7_8))
		var_7_11:addObject(CCDelayTime:create(1.5))
		var_7_11:addObject(CCCallFuncN:create(var_7_9))
		var_7_0:stopAllActions()
		var_7_0:runAction(CCSequence:create(var_7_11))
		var_7_0:setAnimation(ANIMATION_SEQUENCE_RUN, true)
	end

	return var_7_0
end

function var_0_0.doDestroy(arg_11_0)
	arg_11_0.layerScene:free()
end

function var_0_0.onFrameUpdate(arg_12_0, arg_12_1)
	if arg_12_0.lxh.enterOk == false and arg_12_0.player.enterOk and arg_12_0.lxhRX.enterOk then
		local function var_12_0()
			arg_12_0.animYanwu:setVisible(true)
			arg_12_0.animYanwu:setPosition(arg_12_0.lxhRX:getPositionX(), arg_12_0.lxhRX:getPositionY())
			arg_12_0.animYanwu:setAnimation("animation", false)
		end

		local function var_12_1()
			arg_12_0.lxhRX:setVisible(false)
		end

		local function var_12_2()
			arg_12_0.lxh:setVisible(true)
			arg_12_0.lxh:setPosition(ccp(arg_12_0.lxhRX:getPosition()))
		end

		local function var_12_3()
			g_MainScene:showGuideTalkWnd(502, function()
				arg_12_0:onTalkOver_502()
			end)
		end

		local function var_12_4()
			return
		end

		local var_12_5 = 0.6666666666666666
		local var_12_6 = CCArray:create()

		var_12_6:addObject(CCCallFuncN:create(var_12_0))
		var_12_6:addObject(CCDelayTime:create(var_12_5 / 2))
		var_12_6:addObject(CCCallFuncN:create(var_12_1))
		var_12_6:addObject(CCDelayTime:create(var_12_5 / 2))
		var_12_6:addObject(CCCallFuncN:create(var_12_2))
		var_12_6:addObject(CCDelayTime:create(1))
		var_12_6:addObject(CCCallFuncN:create(var_12_3))
		var_12_6:addObject(CCCallFuncN:create(var_12_4))
		arg_12_0.nodeStepYanwu:stopAllActions()
		arg_12_0.nodeStepYanwu:runAction(CCSequence:create(var_12_6))

		arg_12_0.lxh.enterOk = true
	end
end

function var_0_0.onTalkOver_502(arg_19_0)
	local function var_19_0()
		arg_19_0:closeEyeAnim()
	end

	local var_19_1 = CCArray:create()

	var_19_1:addObject(CCDelayTime:create(1.5))
	var_19_1:addObject(CCCallFuncN:create(var_19_0))
	arg_19_0.player:stopAllActions()
	arg_19_0.player:runAction(CCSequence:create(var_19_1))
	arg_19_0.player:setAnimation(ANIMATION_SEQUENCE_DIE, false)
end

function var_0_0.closeEyeAnim(arg_21_0)
	local function var_21_0()
		arg_21_0.lxh:setVisible(false)
		arg_21_0.mtjj:setVisible(true)
		arg_21_0.mtjj:setRotationY(0)
		arg_21_0.mtjj:setPosition(ccp(arg_21_0.lxhRX:getPosition()))
		arg_21_0.mtjj:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
		g_MainScene:showGuideTitleWnd(1, function()
			arg_21_0:openEyeAnim()
		end)
	end

	local var_21_1 = CCArray:create()

	var_21_1:addObject(CCDelayTime:create(3.5833333333333335))
	var_21_1:addObject(CCCallFuncN:create(var_21_0))
	arg_21_0.animEye:stopAllActions()
	arg_21_0.animEye:runAction(CCSequence:create(var_21_1))
	arg_21_0.animEye:setVisible(true)
	arg_21_0.animEye:setAnimation("animation_2", false)
end

function var_0_0.openEyeAnim(arg_24_0)
	local function var_24_0()
		g_MainScene:showGuideTalkWnd(503, function()
			arg_24_0:onTalkOver_503()
		end)
	end

	local var_24_1 = CCArray:create()

	var_24_1:addObject(CCDelayTime:create(3.5833333333333335))
	var_24_1:addObject(CCCallFuncN:create(var_24_0))
	arg_24_0.animEye:stopAllActions()
	arg_24_0.animEye:runAction(CCSequence:create(var_24_1))
	arg_24_0.animEye:setVisible(true)
	arg_24_0.animEye:setAnimation("animation_1", false)
	arg_24_0.player:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
end

function var_0_0.onTalkOver_503(arg_27_0)
	local var_27_0 = {}

	var_27_0.Id = 1041
	var_27_0.bHave = false

	g_MainScene:showPubGetHeroWnd(var_27_0, false, false, function()
		arg_27_0:onFxsEnter()
	end)
end

function var_0_0.onFxsEnter(arg_29_0)
	local var_29_0 = getCombatHeroPos(ForceType.Right, 4)
	local var_29_1 = getCombatHeroPos(ForceType.Right, 4)

	arg_29_0.fxs:setRotationY(0)
	arg_29_0.fxs:setPosition(var_29_1)
	arg_29_0.fxs:setVisible(true)

	arg_29_0.fxs.enterOk = false

	arg_29_0.fxs.skeleton:setMix(ANIMATION_SEQUENCE_RUN, ANIMATION_SEQUENCE_IDLE, 0.25)
	arg_29_0.fxs.skeleton:setMix(ANIMATION_SEQUENCE_IDLE, ANIMATION_SEQUENCE_RUN, 0.25)
	arg_29_0.fxs.skeleton:setMix(ANIMATION_SEQUENCE_IDLE, ANIMATION_SEQUENCE_WEAK, 0.25)
	arg_29_0.fxs.skeleton:setMix(ANIMATION_SEQUENCE_WEAK, ANIMATION_SEQUENCE_IDLE, 0.25)

	local var_29_2 = 438 * zbUtil:random(9, 11) / 10

	var_29_1.x = var_29_1.x + var_29_2

	arg_29_0.fxs:setPosition(var_29_1)
	arg_29_0.fxs:setAnimation(ANIMATION_SEQUENCE_RUN, true)

	local function var_29_3()
		arg_29_0.fxs:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	end

	local function var_29_4()
		arg_29_0.fxs:playAnimationOnce(ANIMATION_SEQUENCE_SHOW, ANIMATION_SEQUENCE_IDLE, 0.125)
	end

	local function var_29_5()
		arg_29_0.fxs.enterOk = true

		g_MainScene:showGuideTalkWnd(504, function()
			arg_29_0:onTalkOver_504()
		end)
	end

	local var_29_6 = 1.1 + zbUtil:random(0, 6) / 10
	local var_29_7 = CCArray:create()

	var_29_7:addObject(CCMoveTo:create(var_29_6, var_29_0))
	var_29_7:addObject(CCCallFuncN:create(var_29_3))
	var_29_7:addObject(CCDelayTime:create(0.5))
	var_29_7:addObject(CCCallFuncN:create(var_29_4))
	var_29_7:addObject(CCDelayTime:create(1))
	var_29_7:addObject(CCCallFuncN:create(var_29_5))
	arg_29_0.fxs:stopAllActions()
	arg_29_0.fxs:runAction(CCSequence:create(var_29_7))
	arg_29_0.fxs:setAnimation(ANIMATION_SEQUENCE_RUN, true)
end

function var_0_0.onTalkOver_504(arg_34_0)
	arg_34_0:hide()
	g_MainScene:showGuideWorldVideoWnd()
end

function var_0_0.refresh(arg_35_0)
	return
end
