zbCombatEnergyBall = class("zbCombatEnergyBall", CCNodeExtend)
zbCombatEnergyBall.__index = zbCombatEnergyBall

function zbCombatEnergyBall.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCombatEnergyBall)

	return arg_1_0
end

function zbCombatEnergyBall.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbCombatEnergyBall.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbCombatEnergyBall.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.forceType = arg_3_1
		arg_3_0.energy = arg_3_3
		arg_3_0.ended = false
		arg_3_0.gathering = false
		arg_3_0.gathered = false
		arg_3_0.appearTime = 0
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = createUIAnimation()

			var_6_0:refresh(arg_6_1, arg_6_2)
			var_6_0:setPosition(arg_6_0:getContentSize().width / 2, arg_6_0:getContentSize().height / 2)
			arg_6_0:addChild(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/combat_energyball.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner", true, true)
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.btnTouch = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setTouchPriority(g_MainScene.wndCombat.btnPause:getTouchPriority())

		arg_3_0.fxAppear = var_5_0(var_5_3, "effect/spine/ui_shenbing2/001/ui_shenbing2_1.json", "effect/spine/ui_shenbing2/001/ui_shenbing2_1.atlas")
		arg_3_0.fxLoop = var_5_0(var_5_3, "effect/spine/ui_shenbing2/002/ui_shenbing2_2.json", "effect/spine/ui_shenbing2/002/ui_shenbing2_2.atlas")
		arg_3_0.fxDisapper = var_5_0(var_5_3, "effect/spine/ui_shenbing2/003/ui_shenbing2_3.json", "effect/spine/ui_shenbing2/003/ui_shenbing2_3.atlas")

		arg_3_0:addChild(var_5_2)
		arg_3_0:setPosition(arg_3_2)
		arg_3_0:setZOrder(ZORDER_TOP + 100000)

		arg_3_0.layer = var_5_3

		g_MainScene.wndCombat.layerScene:addChild(arg_3_0)
	end

	var_3_0()
	var_3_1()
	arg_3_0:appear()
end

function zbCombatEnergyBall.free(arg_8_0)
	arg_8_0:removeFromParentAndCleanup(true)
end

function zbCombatEnergyBall.update(arg_9_0)
	return
end

function zbCombatEnergyBall.isEnd(arg_10_0)
	return arg_10_0.ended
end

function zbCombatEnergyBall.onTouch(arg_11_0)
	if arg_11_0.gathering then
		return
	end

	arg_11_0:gather()
end

function zbCombatEnergyBall.appear(arg_12_0)
	local function var_12_0()
		arg_12_0.fxAppear:setVisible(true)
		arg_12_0.fxLoop:setVisible(false)
		arg_12_0.fxDisapper:setVisible(false)
		arg_12_0.fxAppear:setAnimation("animation", false)
	end

	local function var_12_1()
		arg_12_0.fxAppear:setVisible(false)
		arg_12_0.fxLoop:setVisible(true)
		arg_12_0.fxDisapper:setVisible(false)
		arg_12_0.fxLoop:setAnimation("animation", true)
	end

	local var_12_2 = CCArray:create()

	var_12_2:addObject(CCCallFuncN:create(var_12_0))
	var_12_2:addObject(CCDelayTime:create(0.5333333333333333))
	var_12_2:addObject(CCCallFuncN:create(var_12_1))

	local var_12_3 = CCSequence:create(var_12_2)

	arg_12_0:stopAllActions()
	arg_12_0:runAction(var_12_3)

	arg_12_0.appearTime = os_timenow()

	g_Audio:playSound("audio/sound/rise_normal.mp3")
end

function zbCombatEnergyBall.gather(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0.gathered == false then
		if arg_15_0.forceType == g_CombatSystem:getMyForceType() then
			g_CombatSystem:getEnemyLegend():addEnergy(arg_15_0.energy)
		else
			g_CombatSystem:getLegend():addEnergy(arg_15_0.energy)
		end

		arg_15_0.gathered = true
	end

	if arg_15_0.gathering then
		return
	end

	arg_15_0.gathering = true

	local function var_15_0()
		arg_15_0.fxAppear:setVisible(false)
		arg_15_0.fxLoop:setVisible(false)
		arg_15_0.fxDisapper:setVisible(true)
		arg_15_0.fxDisapper:setAnimation("animation", false)
		g_CombatBubble:showEnergyBubble(ccp(arg_15_0:getPosition()), arg_15_0.energy, 0)

		if arg_15_1 ~= true and arg_15_0.gathered == false then
			if arg_15_0.forceType == g_CombatSystem:getMyForceType() then
				g_CombatSystem:getEnemyLegend():addEnergy(arg_15_0.energy)
			else
				g_CombatSystem:getLegend():addEnergy(arg_15_0.energy)
			end

			arg_15_0.gathered = true
		end
	end

	local function var_15_1()
		arg_15_0.ended = true
	end

	local var_15_2 = CCArray:create()
	local var_15_3 = os_timenow() - arg_15_0.appearTime

	if var_15_3 < 1.3333333333333333 then
		var_15_2:addObject(CCDelayTime:create(1.3333333333333333 - var_15_3))
	end

	var_15_2:addObject(CCCallFuncN:create(var_15_0))
	var_15_2:addObject(CCDelayTime:create(0.5333333333333333))
	var_15_2:addObject(CCCallFuncN:create(var_15_1))

	local var_15_4 = CCSequence:create(var_15_2)

	arg_15_0.layer:stopAllActions()
	arg_15_0.layer:runAction(var_15_4)
	g_Audio:playSound("audio/sound/rise_normal.mp3")
end

function zbCombatEnergyBall.checkAutoGatherEnergyBall(arg_18_0)
	if g_CombatSystem:isAutoCombat() and arg_18_0.forceType ~= g_CombatSystem:getMyForceType() then
		arg_18_0:gather(false)

		return
	end

	if arg_18_0.forceType == g_CombatSystem:getMyForceType() then
		arg_18_0:gather(false)
	end
end
