require("gamecore.effect.zbSpineBaseMissileEffect")

zbSpineMissileEffectPos = class("zbSpineMissileEffectPos", zbSpineBaseMissileEffect)
zbSpineMissileEffectPos.__index = zbSpineMissileEffectPos

function zbSpineMissileEffectPos.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineMissileEffectPos)

	return arg_1_0
end

function zbSpineMissileEffectPos.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9, arg_2_10)
	local var_2_0 = zbSpineMissileEffectPos.extend(zbSpineBaseMissileEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9, arg_2_10)

	return var_2_0
end

function zbSpineMissileEffectPos.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9, arg_3_10)
	arg_3_0.attacker = arg_3_1
	arg_3_0.skill = arg_3_2
	arg_3_0.startPos = arg_3_4
	arg_3_0.endPos = arg_3_5
	arg_3_0.bombPos = arg_3_6
	arg_3_0.missilePathType = arg_3_3
	arg_3_0.effectRecord = arg_3_7
	arg_3_0.bombEffectId = arg_3_10

	arg_3_0:setAnchorPoint(ccp(0.5, 0.5))

	arg_3_0.lastPos = ccp(0, 0)
	arg_3_0.hited = true
	arg_3_0.initPosition = ccp(0, 0)
	arg_3_0.missleDuration = 0
	arg_3_0.missleAccumTime = 0
	arg_3_0.skeleton = createSpineAnimation(arg_3_8, arg_3_9, 1, true)

	if arg_3_0.skeleton ~= nil then
		arg_3_0.hited = false

		if arg_3_0.effectRecord.id == 1012042 then
			arg_3_0.skeleton:setRotationX(180)
		end

		arg_3_0.skeleton:clearTracks()
		arg_3_0.skeleton:setAnimation(0, "animation", true)

		if arg_3_0.effectRecord.rotateY then
			arg_3_0.skeleton:setRotationY(arg_3_0.attacker:getRotationY())
		end

		if arg_3_3 == EPathType.Line then
			arg_3_0:createLinePathEffect()
		else
			arg_3_0:createBezierPathEffect()
		end

		g_Audio:playSound(arg_3_7.sound)
		arg_3_0:addChild(arg_3_0.skeleton)
		arg_3_0:setScale(arg_3_0.effectRecord.scale)
		arg_3_0:setZOrder(ZORDER_TOP + 100000)
		arg_3_1:getParent():addChild(arg_3_0)

		arg_3_0.lastPos = ccp(arg_3_0:getPosition())
	end
end

function zbSpineMissileEffectPos.free(arg_4_0)
	if arg_4_0.skeleton ~= nil then
		arg_4_0.skeleton:removeFromParentAndCleanup(true)

		arg_4_0.skeleton = nil
	end

	arg_4_0:removeFromParentAndCleanup(true)
end

function zbSpineMissileEffectPos.isEnd(arg_5_0)
	return arg_5_0.hited
end

function zbSpineMissileEffectPos.createLinePathEffect(arg_6_0)
	local var_6_0 = ccpDistance(arg_6_0.startPos, arg_6_0.endPos) / MISSILE_SPEED
	local var_6_1 = math.min(var_6_0, 0.6)

	if arg_6_0.effectRecord.id == 1012002 then
		var_6_1 = math.min(var_6_1, 0.5)
	end

	local var_6_2 = arg_6_0:getDegree(arg_6_0.startPos, arg_6_0.endPos)

	arg_6_0:setRotation(var_6_2)

	local var_6_3 = CCArray:create()

	var_6_3:addObject(CCFadeIn:create(0.125))
	var_6_3:addObject(CCMoveTo:create(var_6_1, arg_6_0.endPos))
	var_6_3:addObject(CCCallFuncN:create(function()
		arg_6_0:hitAction()
	end))
	var_6_3:addObject(CCDelayTime:create(FIGHT_RANGEWAIT_TIME))
	var_6_3:addObject(CCCallFuncN:create(function()
		arg_6_0:hitEndAction()
	end))

	local var_6_4 = CCSequence:create(var_6_3)

	arg_6_0:setPosition(arg_6_0.startPos)
	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_4)
end

function zbSpineMissileEffectPos.createBezierPathEffect(arg_9_0)
	arg_9_0.vx0, arg_9_0.vy0, arg_9_0.missleDuration = arg_9_0:getSpeedAndDuration(arg_9_0.startPos, arg_9_0.endPos, zbUtil:random(40, 45))
	arg_9_0.initPosition = arg_9_0.startPos

	local var_9_0 = CCArray:create()

	var_9_0:addObject(CCDelayTime:create(arg_9_0.missleDuration))
	var_9_0:addObject(CCCallFuncN:create(function()
		arg_9_0:hitAction()
	end))
	var_9_0:addObject(CCDelayTime:create(FIGHT_RANGEWAIT_TIME))
	var_9_0:addObject(CCCallFuncN:create(function()
		arg_9_0:hitEndAction()
	end))

	local var_9_1 = CCSequence:create(var_9_0)

	arg_9_0:setPosition(arg_9_0.startPos)
	arg_9_0:stopAllActions()
	arg_9_0:runAction(var_9_1)
end

function zbSpineMissileEffectPos.hitAction(arg_12_0)
	local var_12_0 = g_EffectSystem:createBombEffect(arg_12_0.attacker, getFlipForceType(arg_12_0.attacker.forceType), arg_12_0.bombPos, arg_12_0.bombEffectId, 0)

	if var_12_0 ~= nil and arg_12_0.bombEffectId == 1094013 then
		if arg_12_0.attacker == ForceType.Left then
			var_12_0:setRotationY(0)
		else
			var_12_0:setRotationY(180)
		end
	end

	if arg_12_0.skill.hitTarget ~= nil then
		arg_12_0.skill:hitTarget()
	end

	arg_12_0:setVisible(false)
end

function zbSpineMissileEffectPos.hitEndAction(arg_13_0)
	arg_13_0.hited = true

	if arg_13_0.skill.hitEnd ~= nil then
		arg_13_0.skill:hitEnd()
	end
end

function zbSpineMissileEffectPos.update(arg_14_0, arg_14_1)
	arg_14_0:updateBezier(arg_14_1)
end
