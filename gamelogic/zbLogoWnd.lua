require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLogoWnd", zbBaseWnd)

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

function var_0_0.init(arg_2_0)
	local function var_2_0()
		arg_2_0.animMgr = nil
	end

	local function var_2_1()
		local var_4_0 = CCBProxy:create()
		local var_4_1, var_4_2 = CCBReaderLoad("ccbi/logo.ccbi", var_4_0, false, "")
		local var_4_3 = tolua.cast(var_4_1, "CCLayer")

		arg_2_0.layerAlpha = tolua.cast(var_4_3:getChildByTag(1), "CCSprite")

		arg_2_0.layerAlpha:setCascadeOpacityEnabled(true)

		local var_4_4 = tolua.cast(var_4_2:getAnimationManagersForNodes(), "CCArray")

		arg_2_0.animMgr = tolua.cast(var_4_4:objectAtIndex(0), "CCBAnimationManager")

		arg_2_0:addChild(var_4_3)
	end

	var_2_0()
	var_2_1()
	arg_2_0.animMgr:runAnimationsForSequenceNamed("Default Timeline")
end

function var_0_0.isFadeOver(arg_5_0)
	return arg_5_0.layerAlpha:getScaleX() < 1
end

function createLogoWnd()
	local var_6_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_6_0:initBase()
	var_6_0:init()

	return var_6_0
end
