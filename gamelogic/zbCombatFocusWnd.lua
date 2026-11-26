local var_0_0 = class("zbCombatFocusWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createCombatFocusWnd()
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
		arg_3_0.btnTouchs = {}
	end

	local function var_3_1()
		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0.layerScene:adapter()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/combat_focus.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		for iter_5_0 = 1, 5 do
			local var_5_2 = tolua.cast(var_5_1:getChildByTag(iter_5_0), "CCControlButton")

			var_5_2:removeFromParentAndCleanup(false)
			arg_3_0.layerScene:addChild(var_5_2)

			arg_3_0.btnTouchs[iter_5_0] = var_5_2

			var_5_2:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpInside)

			local var_5_3 = createUIAnimation()

			var_5_3:refreshBone("effect/spine/ui_jihuoguangquan/ui_jihuoguangquan")
			var_5_3:setAnimation("animation", true)
			var_5_3:setPosition(var_5_2:getContentSize().width / 2, var_5_2:getContentSize().height / 2)
			var_5_2:addChild(var_5_3)
		end

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(11), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_1:getChildByTag(12), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:addChild(arg_3_0.layerScene)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.onShow(arg_11_0)
	g_CombatSystem:pause()
end

function var_0_0.onHide(arg_12_0)
	g_CombatSystem:resume()
end

function var_0_0.refresh(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.btnTouchs) do
		iter_13_1:setVisible(false)
	end

	local var_13_0 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		if iter_13_3:isDie() == false then
			arg_13_0.btnTouchs[iter_13_2]:setPosition(iter_13_3:getPositionX() + iter_13_3.avatarRecord.focusOffset.x, iter_13_3:getPositionY() + iter_13_3.avatarRecord.focusOffset.y)
			arg_13_0.btnTouchs[iter_13_2]:setVisible(true)
		end
	end
end

function var_0_0.onTouch(arg_14_0, arg_14_1)
	local var_14_0 = g_CombatSystem:getHeros(ForceType.Right)[arg_14_1]

	if var_14_0 ~= nil then
		g_CombatSystem.combatData.combatFocus:setTarget(var_14_0)
		arg_14_0:hide()
	end
end

function var_0_0.onTouchTest(arg_15_0)
	arg_15_0:hide()
end
