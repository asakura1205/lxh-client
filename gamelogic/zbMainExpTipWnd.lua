local var_0_0 = class("zbMainExpTipWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createMainExpTipWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/main_exptip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:setVisible(true)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.progressTxt = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.progress = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.progressTxt, arg_3_0.progress)
		arg_3_0.progress:setScale(0.48)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0)
	local var_7_0 = g_GameData.BaseInfo.Exp
	local var_7_1 = zbPlayerUpgradeTable:getExpNeed(g_GameData.BaseInfo.Level)

	arg_7_0.progress:setString(var_7_0 .. "/" .. var_7_1)
end
