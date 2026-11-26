zbHeroState_Enter = class("zbHeroState_Enter")
zbHeroState_Enter.__index = zbHeroState_Enter

function zbHeroState_Enter.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeroState_Enter.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbHeroState_Enter.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.hero = arg_2_2
	arg_2_0.stateId = arg_2_1
end

function zbHeroState_Enter.enter(arg_3_0)
	local var_3_0 = arg_3_0.hero:getFixPosition()
	local var_3_1 = arg_3_0.hero:getFixPosition()

	local function var_3_2()
		arg_3_0.hero:setCurrState(HeroState_Show)
	end

	if arg_3_0.hero.avatarRecord.templateId == 601 then
		arg_3_0.hero:setPosition(var_3_1)

		local var_3_3 = CCArray:create()

		var_3_3:addObject(CCDelayTime:create(0.2))
		var_3_3:addObject(CCCallFuncN:create(var_3_2))
		arg_3_0.hero:stopAllActions()
		arg_3_0.hero:runAction(CCSequence:create(var_3_3))
		arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	else
		local var_3_4 = 438 * zbUtil:random(9, 11) / 10

		if arg_3_0.hero.forceType == ForceType.Left then
			var_3_1.x = var_3_1.x - var_3_4
		else
			var_3_1.x = var_3_1.x + var_3_4
		end

		arg_3_0.hero:setPosition(var_3_1)

		local var_3_5 = 1.1 + zbUtil:random(0, 6) / 10
		local var_3_6 = CCArray:create()

		var_3_6:addObject(CCMoveTo:create(var_3_5, var_3_0))
		var_3_6:addObject(CCCallFuncN:create(var_3_2))
		arg_3_0.hero:stopAllActions()
		arg_3_0.hero:runAction(CCSequence:create(var_3_6))

		arg_3_0.hero.anim.skeleton.timeScale = 1

		arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_RUN, true)
		arg_3_0.hero.anim.skeleton:setMix(ANIMATION_SEQUENCE_RUN, ANIMATION_SEQUENCE_SHOW, 0.2)
	end
end

function zbHeroState_Enter.exit(arg_5_0)
	return
end

function zbHeroState_Enter.update(arg_6_0, arg_6_1)
	return
end
