require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRoleWnd", zbBaseWnd)

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

function createRoleWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.btnRoles = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/role.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteBg = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbStartDesc = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		for iter_5_0 = 1, 4 do
			arg_3_0.btnRoles[iter_5_0] = tolua.cast(var_5_2:getChildByTag(iter_5_0 + 10), "CCControlButton")

			arg_3_0.btnRoles[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onRole(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0)
	return
end

function var_0_0.onRole(arg_8_0, arg_8_1)
	g_MainScene:showRoleCreateWnd(arg_8_1)
end
