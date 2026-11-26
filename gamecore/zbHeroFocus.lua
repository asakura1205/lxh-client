zbHeroFocus = class("zbHeroFocus", CCNodeExtend)
zbHeroFocus.__index = zbHeroFocus

function zbHeroFocus.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroFocus)

	return arg_1_0
end

function zbHeroFocus.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroFocus.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroFocus.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1
	arg_3_0.fxFocus = createUIAnimation()

	arg_3_0.fxFocus:refreshBone("effect/spine/ui_jihuoguangquan/ui_jihuoguangquan")
	arg_3_0.fxFocus:setAnimation("animation", true)
	arg_3_0:setPosition(arg_3_0.hero.avatarRecord.focusOffset)
	arg_3_0:addChild(arg_3_0.fxFocus)
	arg_3_1:addChild(arg_3_0)
	arg_3_0:setVisible(false)
end

function zbHeroFocus.update(arg_4_0, arg_4_1)
	local var_4_0 = false
	local var_4_1 = g_CombatSystem.combatData.combatFocus:getTarget()

	if var_4_1 ~= nil and var_4_1:isSame(arg_4_0.hero) then
		var_4_0 = true
	end

	arg_4_0:setVisible(var_4_0)
end
