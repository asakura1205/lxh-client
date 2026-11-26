zbHeroGoldSubEmitter = class("zbHeroGoldSubEmitter", CCNodeExtend)
zbHeroGoldSubEmitter.__index = zbHeroGoldSubEmitter

local var_0_0 = 10

function zbHeroGoldSubEmitter.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroGoldSubEmitter)

	return arg_1_0
end

function zbHeroGoldSubEmitter.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroGoldSubEmitter.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroGoldSubEmitter.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1
	arg_3_0.count = 0
	arg_3_0.srcPos = ccp(0, 0)
	arg_3_0.dstPos = ccp(0, 0)
	arg_3_0.spriteParticles = {}
	arg_3_0.emiting = false
	arg_3_0.lastEmitTime = os_timenow()
	arg_3_0.lastHpPercent = 100

	for iter_3_0 = 1, var_0_0 do
		local var_3_0 = CCSprite:create("image/common/money_gold.png")

		var_3_0:setVisible(false)
		var_3_0:setCascadeOpacityEnabled(true)
		arg_3_0:addChild(var_3_0)
		table.insert(arg_3_0.spriteParticles, var_3_0)
	end

	arg_3_1:addChild(arg_3_0)
	arg_3_0:setZOrder(ZORDER_TOP)
end

function zbHeroGoldSubEmitter.isEmiting(arg_4_0)
	return arg_4_0.emiting
end

function zbHeroGoldSubEmitter.emit(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.emiting = true
	arg_5_0.srcPos = arg_5_1
	arg_5_0.dstPos = arg_5_2
	arg_5_0.count = math.min(arg_5_3, var_0_0)

	for iter_5_0 = 1, var_0_0 do
		arg_5_0.spriteParticles[iter_5_0]:setVisible(false)
	end

	for iter_5_1 = 1, arg_5_0.count do
		arg_5_0:emitSingle(iter_5_1)
	end
end

function zbHeroGoldSubEmitter.emitEndAction(arg_6_0, arg_6_1)
	arg_6_0.emiting = false
	arg_6_0.lastEmitTime = os_timenow()
end

function zbHeroGoldSubEmitter.emitSingle(arg_7_0, arg_7_1)
	local var_7_0 = ccBezierConfig()
	local var_7_1 = zbUtil:random(1, 2)
	local var_7_2 = zbUtil:random(-100, 100)
	local var_7_3 = zbUtil:random(-100, 0)
	local var_7_4 = zbUtil:random(-100, 100)
	local var_7_5 = zbUtil:random(-100, 50)

	if var_7_1 == 1 then
		var_7_0.controlPoint_1.x = arg_7_0.srcPos.x + var_7_2
		var_7_0.controlPoint_1.y = arg_7_0.srcPos.y + var_7_4
		var_7_0.controlPoint_2.x = arg_7_0.dstPos.x + var_7_3
		var_7_0.controlPoint_2.y = arg_7_0.dstPos.y + var_7_5
	else
		var_7_0.controlPoint_1.x = arg_7_0.srcPos.x + var_7_2
		var_7_0.controlPoint_1.y = arg_7_0.srcPos.y + var_7_4
		var_7_0.controlPoint_2.x = arg_7_0.dstPos.x + var_7_3
		var_7_0.controlPoint_2.y = arg_7_0.dstPos.y + var_7_5
	end

	var_7_0.endPosition = arg_7_0.dstPos

	local var_7_6 = ccpDistanceSQ(arg_7_0.srcPos, arg_7_0.dstPos) / 250000 * 2
	local var_7_7 = ccpDistanceSQ(arg_7_0.srcPos, arg_7_0.dstPos) / 250000 * 2

	if var_7_7 > 1 then
		var_7_7 = 2 * var_7_7
	else
		var_7_7 = 2
	end

	local var_7_8 = CCArray:create()

	var_7_8:addObject(CCDelayTime:create(arg_7_1 * 0.1))
	var_7_8:addObject(CCFadeIn:create(0.125))

	local var_7_9 = CCArray:create()

	var_7_9:addObject(CCEaseIn:create(CCBezierTo:create(var_7_6, var_7_0), var_7_7))
	var_7_9:addObject(CCRotateBy:create(1.5, 360))

	local var_7_10 = CCSpawn:create(var_7_9)

	var_7_8:addObject(var_7_10)

	if arg_7_1 >= arg_7_0.count then
		var_7_8:addObject(CCCallFuncN:create(function()
			arg_7_0:emitEndAction()
		end))
	end

	local var_7_11 = CCSequence:create(var_7_8)
	local var_7_12 = arg_7_0.spriteParticles[arg_7_1]

	var_7_12:setVisible(true)
	var_7_12:setOpacity(0)
	var_7_12:setPositionX(arg_7_0.srcPos.x + zbUtil:random(-50, 50))
	var_7_12:setPositionY(arg_7_0.srcPos.y + zbUtil:random(-30, 30))
	var_7_12:stopAllActions()
	var_7_12:runAction(var_7_11)
end

function zbHeroGoldSubEmitter.emitGold(arg_9_0)
	local var_9_0 = ccp(zbUtil:random(-30, 0), zbUtil:random(430, 450))
	local var_9_1 = zbUtil:random(var_0_0 - 5, var_0_0)

	arg_9_0:emit(arg_9_0.hero.avatarRecord.focusOffset, var_9_0, var_9_1)
	g_Audio:playSound("audio/sound/effect_gold.mp3")
end

function zbHeroGoldSubEmitter.update(arg_10_0, arg_10_1)
	return
end
