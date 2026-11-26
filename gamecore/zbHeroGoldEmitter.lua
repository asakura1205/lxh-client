require("gamecore.zbHeroGoldSubEmitter")

zbHeroGoldEmitter = class("zbHeroGoldEmitter", CCNodeExtend)
zbHeroGoldEmitter.__index = zbHeroGoldEmitter

local var_0_0 = 4

function zbHeroGoldEmitter.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroGoldEmitter)

	return arg_1_0
end

function zbHeroGoldEmitter.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroGoldEmitter.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroGoldEmitter.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1
	arg_3_0.emiterList = {}

	for iter_3_0 = 1, var_0_0 do
		arg_3_0.emiterList[iter_3_0] = zbHeroGoldSubEmitter:create(arg_3_1)
	end

	arg_3_1:addChild(arg_3_0)
end

function zbHeroGoldEmitter.update(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.emiterList) do
		iter_4_1:update(arg_4_1)
	end
end

function zbHeroGoldEmitter.emitGlod(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.emiterList) do
		if iter_5_1:isEmiting() == false then
			iter_5_1:emitGold()

			break
		end
	end
end
