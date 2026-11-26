local var_0_0 = class("zbWawajiItem", CCNodeExtend)

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

wawajiDistance = 250

function createWawajiItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.ccNode = arg_3_1
	end

	local function var_3_1()
		local function var_5_0()
			local var_6_0 = createUIPoolAnimation()

			var_6_0:setAnchorPoint(ccp(0.5, 0))
			var_6_0:setScale(0.8)

			return var_6_0
		end

		arg_3_0.intHero = var_5_0()

		arg_3_0.intHero:setPosition(0, 15)
		arg_3_1:addChild(arg_3_0.intHero)
		arg_3_1:setPosition(1200, 0)

		arg_3_0.intItemPoint = ccp(1200 + (arg_3_2 - 1) * wawajiDistance, 0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.dollsItem = arg_7_1
	arg_7_0.hudOffset = 70

	if arg_7_0.dollsItem == nil then
		return
	end

	if arg_7_0.dollsItem.Index == 0 then
		arg_7_0.intHero:refresh("effect/spine/zhadan/zhadan.json", "effect/spine/zhadan/zhadan.atlas")
		arg_7_0.intHero:setAnimation("animation", true)
	else
		arg_7_0.intHero:refreshHeroTemplateId(arg_7_0.dollsItem.Item.Id)
		arg_7_0.intHero:setAnimation(ANIMATION_SEQUENCE_IDLE, true)

		local var_7_0 = zbHeroTable:getRecord(arg_7_0.dollsItem.Item.Id)

		if var_7_0 == nil then
			echoInfo("zbHero:init: monster == nil")

			return
		end

		local var_7_1 = zbAvatarTable:getRecord(var_7_0.avatarId)

		if var_7_1 == nil then
			echoInfo("zbHero:init: monster == nil")

			return
		end

		arg_7_0.hudOffset = (var_7_1.hudOffset.y - 10) * 0.8
	end
end

function var_0_0.updateZhuaqu(arg_8_0, arg_8_1)
	local var_8_0 = ccp(arg_8_0.ccNode:getPosition())

	return zbUtil:PointInRect2(arg_8_1.x, arg_8_1.y, var_8_0.x - 30, arg_8_0.hudOffset - 40, 60, arg_8_0.hudOffset)
end

function var_0_0.onZhuaqi(arg_9_0)
	local var_9_0 = CCArray:create()

	if arg_9_0.dollsItem.Index == 0 then
		arg_9_0.intHero:refresh("effect/spine/chouchou_skill1/003/chouchou_skill1_03.json", "effect/spine/chouchou_skill1/003/chouchou_skill1_03.atlas")
		var_9_0:addObject(CCCallFuncN:create(function()
			arg_9_0.intHero:setAnimation("animation", false)
		end))
		g_Audio:playSound("audio/sound/bomb_3.mp3")
		var_9_0:addObject(CCDelayTime:create(1))
	end

	var_9_0:addObject(CCCallFuncN:create(function()
		arg_9_0.ccNode:setVisible(false)
	end))

	local var_9_1 = CCSequence:create(var_9_0)

	arg_9_0.ccNode:stopAllActions()
	arg_9_0.ccNode:runAction(var_9_1)
end

function var_0_0.free(arg_12_0)
	if arg_12_0.intHero then
		arg_12_0.intHero:free()
	end
end
