require("gamecore.effect.zbSpineBaseMissileEffect")

zbSpineMissileEffectPos2 = class("zbSpineMissileEffectPos2", zbSpineBaseMissileEffect)
zbSpineMissileEffectPos2.__index = zbSpineMissileEffectPos2

function zbSpineMissileEffectPos2.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineMissileEffectPos2)

	return arg_1_0
end

function zbSpineMissileEffectPos2.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	local var_2_0 = zbSpineMissileEffectPos2.extend(zbSpineBaseMissileEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)

	return var_2_0
end

function zbSpineMissileEffectPos2.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	arg_3_0.attacker = arg_3_1
	arg_3_0.skill = arg_3_2
	arg_3_0.startPos = arg_3_4
	arg_3_0.endPos = arg_3_5
	arg_3_0.missilePathType = arg_3_3
	arg_3_0.effectRecord = arg_3_6

	arg_3_0:setAnchorPoint(ccp(0.5, 0.5))

	arg_3_0.lastPos = ccp(0, 0)
	arg_3_0.arrived = false
	arg_3_0.initPosition = ccp(0, 0)
	arg_3_0.missleDuration = 0
	arg_3_0.missleAccumTime = 0
	arg_3_0.skeleton = createSpineAnimation(arg_3_7, arg_3_8, 1, true)

	if arg_3_0.skeleton ~= nil then
		arg_3_0.skeleton:setRotationX(180)
		arg_3_0.skeleton:clearTracks()
		arg_3_0.skeleton:setAnimation(0, "animation", true)

		if arg_3_0.effectRecord.rotateY then
			arg_3_0.skeleton:setRotationY(arg_3_0.attacker:getRotationY())
		end

		arg_3_0:createLinePathEffect()
		arg_3_0:addChild(arg_3_0.skeleton)
		arg_3_0:setScale(arg_3_0.effectRecord.scale)
		arg_3_0:setZOrder(ZORDER_TOP + 100000)
		arg_3_1:getParent():addChild(arg_3_0)

		arg_3_0.lastPos = ccp(arg_3_0:getPosition())
	end
end

function zbSpineMissileEffectPos2.free(arg_4_0)
	if arg_4_0.skeleton ~= nil then
		arg_4_0.skeleton:removeFromParentAndCleanup(true)

		arg_4_0.skeleton = nil
	end

	arg_4_0:removeFromParentAndCleanup(true)
end

function zbSpineMissileEffectPos2.isEnd(arg_5_0)
	return arg_5_0.arrived
end

function zbSpineMissileEffectPos2.createLinePathEffect(arg_6_0)
	local function var_6_0()
		arg_6_0.arrived = true
	end

	local var_6_1 = ccpDistance(arg_6_0.startPos, arg_6_0.endPos) / MISSILE_SPEED
	local var_6_2 = math.min(var_6_1, 0.5)
	local var_6_3 = arg_6_0:getDegree(arg_6_0.startPos, arg_6_0.endPos)

	arg_6_0:setRotation(var_6_3)

	local var_6_4 = CCArray:create()

	var_6_4:addObject(CCFadeIn:create(0.125))
	var_6_4:addObject(CCMoveTo:create(var_6_2, arg_6_0.endPos))
	var_6_4:addObject(CCCallFuncN:create(var_6_0))

	local var_6_5 = CCSequence:create(var_6_4)

	arg_6_0:setPosition(arg_6_0.startPos)
	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_5)
end

function zbSpineMissileEffectPos2.update(arg_8_0, arg_8_1)
	return
end
