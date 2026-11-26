zbHeroQte = class("zbHeroQte", CCNodeExtend)
zbHeroQte.__index = zbHeroQte

function zbHeroQte.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroQte)

	return arg_1_0
end

function zbHeroQte.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroQte.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroQte.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1

	arg_3_1:addChild(arg_3_0)
	arg_3_0:setZOrder(ZORDER_TOP)
end

function zbHeroQte.update(arg_4_0, arg_4_1)
	return
end
