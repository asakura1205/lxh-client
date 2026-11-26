require("gamelogic.zbBaseWnd")

zbEffectUIPlayWnd = class("zbEffectUIPlayWnd", zbBaseWnd)
zbEffectUIPlayWnd.__index = zbEffectUIPlayWnd

function zbEffectUIPlayWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEffectUIPlayWnd)

	return arg_1_0
end

function createEffectUIPlayWnd()
	local var_2_0 = zbEffectUIPlayWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbEffectUIPlayWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.effect = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/effectplay.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.effectRoot = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		arg_3_0.effect = createUIAnimation()

		arg_3_0.effect:refresh("effect/spine/ui_chenggong/ui_chenggong.json", "effect/spine/ui_chenggong/ui_chenggong.atlas")
		arg_3_0.effect:setPosition(0, 0)
		arg_3_0.effect:setAnchorPoint(ccp(0.5, 0))
		arg_3_0.effectRoot:addChild(arg_3_0.effect)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setZOrder(ZORDER_TOP)
end

function zbEffectUIPlayWnd.endAction(arg_6_0, arg_6_1)
	arg_6_0:hide()
end

function zbEffectUIPlayWnd.playEffect(arg_7_0, arg_7_1)
	if arg_7_1 ~= nil then
		g_Audio:playSound(AudioDefine.UI_EQUIP_UPGRADE)
		arg_7_0.effect:setAnimation(arg_7_1, false)

		local var_7_0 = CCArray:create()

		var_7_0:addObject(CCDelayTime:create(2.5))
		var_7_0:addObject(CCCallFuncN:create(function()
			arg_7_0:endAction()
		end))

		local var_7_1 = CCSequence:create(var_7_0)

		arg_7_0:stopAllActions()
		arg_7_0:runAction(var_7_1)
	end
end
