zbTipEventCompleteWnd = class("zbTipEventCompleteWnd", zbBaseWnd)
zbTipEventCompleteWnd.__index = zbTipEventCompleteWnd

function zbTipEventCompleteWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbTipEventCompleteWnd)

	return arg_1_0
end

function createTipEventCompleteWnd()
	local var_2_0 = zbTipEventCompleteWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbTipEventCompleteWnd.init(arg_3_0)
	local var_3_0 = CCBProxy:create()
	local var_3_1, var_3_2 = CCBReaderLoad("ccbi/tip_eventcomplete.ccbi", var_3_0, true, "HelloCocosBuilderLayerOwner")

	arg_3_0.spriteBg = tolua.cast(var_3_1:getChildByTag(1), "CCSprite")

	arg_3_0.spriteBg:setCascadeOpacityEnabled(true)

	arg_3_0.lbTip = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCLabelTTF")

	arg_3_0:addChild(var_3_1)
	arg_3_0:setZOrder(ZORDER_TOP)

	local var_3_3 = tolua.cast(var_3_2:getAnimationManagersForNodes(), "CCArray")

	arg_3_0.animMgr = tolua.cast(var_3_3:objectAtIndex(0), "CCBAnimationManager")

	arg_3_0:setZOrder(ZORDER_TOP)
end

function zbTipEventCompleteWnd.popup(arg_4_0, arg_4_1)
	arg_4_0:show(g_MainScene)
	arg_4_0.lbTip:setString(arg_4_1)
	arg_4_0.animMgr:runAnimationsForSequenceNamed("Default Timeline")
	g_Audio:playSound(AudioDefine.UI_BUILDING_UPGRADE_FINISH)
end
