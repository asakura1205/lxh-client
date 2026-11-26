zbHeroShadow = class("zbHeroShadow", CCNodeExtend)
zbHeroShadow.__index = zbHeroShadow

function zbHeroShadow.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroShadow)

	return arg_1_0
end

function zbHeroShadow.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroShadow.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroShadow.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1
	arg_3_0.spriteShadow = CCSprite:create("image/combat/yingzi.png")

	arg_3_0.spriteShadow:setScale(0.75)
	arg_3_0.spriteShadow:setPosition(0, 0)

	local var_3_0 = CCScaleBy:create(1, 0.9)
	local var_3_1 = CCSequence:createWithTwoActions(var_3_0, var_3_0:reverse())

	arg_3_0.spriteShadow:runAction(CCRepeatForever:create(var_3_1))
	arg_3_0:addChild(arg_3_0.spriteShadow)
	arg_3_1:addChild(arg_3_0, -1)
end

function zbHeroShadow.update(arg_4_0, arg_4_1)
	arg_4_0:setVisible(arg_4_0.hero.buffGround:isVisible() == false)

	if arg_4_0.hero.avatarRecord.parentAvatarId == 1082 then
		arg_4_0:setVisible(arg_4_0.hero.movingPos == false)
	elseif arg_4_0.hero.avatarRecord.parentAvatarId == 602 then
		arg_4_0:setVisible(false)
	end
end
