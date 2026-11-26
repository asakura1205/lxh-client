require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLockTipWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLockTipWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/locktip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.spriteIcon = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbCondition = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark_NoHide)
		arg_3_0:addChild(var_5_1)
		arg_3_0:retain()
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	local var_7_0 = zbIconHelper:getLockIconPath(arg_7_1)

	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))

	local var_7_1 = zbFunctionUnlockTable:getRecord(arg_7_1)

	if var_7_1 ~= nil then
		arg_7_0.lbName:setString(var_7_1.name)
		arg_7_0.lbDesc:setString(var_7_1.functionDesc)
		arg_7_0.lbCondition:setString(var_7_1.unlockDesc)
	end
end

function var_0_0.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layer, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()
	end
end
