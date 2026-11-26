require("gamecore.effect.zbSpineBaseMissileEffect")

zbSpineMissileEffect = class("zbSpineMissileEffect", zbSpineBaseMissileEffect)
zbSpineMissileEffect.__index = zbSpineMissileEffect

function zbSpineMissileEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineMissileEffect)

	return arg_1_0
end

function zbSpineMissileEffect.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = zbSpineMissileEffect.extend(zbSpineBaseMissileEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)

	return var_2_0
end

function zbSpineMissileEffect.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0.effectRecord = arg_3_4
	arg_3_0.attacker = arg_3_1
	arg_3_0.target = arg_3_2
	arg_3_0.skill = arg_3_3

	arg_3_0:setAnchorPoint(ccp(0.5, 0.5))

	arg_3_0.lastPos = ccp(0, 0)
	arg_3_0.missilePathType = arg_3_3.missilePathType
	arg_3_0.hitEffectId = arg_3_3.skillRecord.hitEffectId
	arg_3_0.hited = true
	arg_3_0.customHitAction = nil
	arg_3_0.killTargeted = false
	arg_3_0.missleDuration = 0
	arg_3_0.initPosition = ccp(0, 0)
	arg_3_0.missleAccumTime = 0
	arg_3_0.damageValue = 0
	arg_3_0.skeleton = createSpineAnimation(arg_3_5, arg_3_6, 1, true)

	if arg_3_0.skeleton ~= nil then
		arg_3_0.hited = false

		arg_3_0.skeleton:clearTracks()
		arg_3_0.skeleton:setAnimation(0, arg_3_4.sequenceName, true)

		if arg_3_0.effectRecord.rotateY then
			arg_3_0.skeleton:setRotationY(arg_3_0.attacker:getRotationY())

			if arg_3_0.effectRecord.id == 1012002 then
				-- block empty
			end
		end

		if arg_3_0.missilePathType == EPathType.Line then
			arg_3_0:createLinePathEffect()
		else
			arg_3_0:createBezierPathEffect()
		end

		g_Audio:playSound(arg_3_4.sound)
		arg_3_0:addChild(arg_3_0.skeleton)
		arg_3_0:setScale(arg_3_0.effectRecord.scale)
		arg_3_0:setZOrder(ZORDER_TOP + 100000)
		arg_3_1:getParent():addChild(arg_3_0)

		arg_3_0.lastPos = ccp(arg_3_0:getPosition())
	end
end

function zbSpineMissileEffect.free(arg_4_0)
	if arg_4_0.skeleton ~= nil then
		arg_4_0.skeleton:removeFromParentAndCleanup(true)

		arg_4_0.skeleton = nil
	end

	arg_4_0:removeFromParentAndCleanup(true)
end

function zbSpineMissileEffect.isEnd(arg_5_0)
	return arg_5_0.hited
end

function zbSpineMissileEffect.createLinePathEffect(arg_6_0)
	local var_6_0 = findBonePosition(arg_6_0.target.avatarRecord.templateId, arg_6_0.target.heroRecord.name, arg_6_0.target.anim.skeleton, arg_6_0.effectRecord.dummy)
	local var_6_1 = ccp(0, 0)

	var_6_1.x = arg_6_0.target:getPositionX() + var_6_0.x * arg_6_0.target:getScaleX()
	var_6_1.y = arg_6_0.target:getPositionY() + var_6_0.y * arg_6_0.target:getScaleY()

	local var_6_2 = ccp(arg_6_0.attacker:getPosition())

	if arg_6_0.attacker.forceType == ForceType.Left then
		var_6_2.x = var_6_2.x + arg_6_0.effectRecord.attackEffectPosX
		var_6_2.y = var_6_2.y + arg_6_0.effectRecord.attackEffectPosY
	else
		var_6_2.x = var_6_2.x - arg_6_0.effectRecord.attackEffectPosX
		var_6_2.y = var_6_2.y + arg_6_0.effectRecord.attackEffectPosY
	end

	if arg_6_0.attacker.avatarRecord.parentAvatarId == 1204 then
		local var_6_3 = findBonePosition(arg_6_0.attacker.avatarRecord.templateId, arg_6_0.attacker.heroRecord.name, arg_6_0.attacker.anim.skeleton, "bone2")

		if arg_6_0.attacker.forceType == ForceType.Left then
			var_6_2.x = arg_6_0.attacker:getPositionX() - 60 * arg_6_0.attacker:getScaleX()
		else
			var_6_2.x = arg_6_0.attacker:getPositionX() + 60 * arg_6_0.attacker:getScaleX()
		end

		var_6_2.y = arg_6_0.attacker:getPositionY() + var_6_3.y + 90 * arg_6_0.attacker:getScaleY()
	end

	if arg_6_0.effectRecord.id == 1015022 then
		var_6_2.y = var_6_2.y + zbUtil:random(-10, 10)
		var_6_1.y = var_6_1.y + zbUtil:random(-40, 50)
	end

	local var_6_4 = true
	local var_6_5 = ccpDistance(var_6_1, var_6_2)
	local var_6_6 = var_6_5 / MISSILE_SPEED
	local var_6_7 = math.min(var_6_6, 0.6)

	if arg_6_0.effectRecord.id == 104300012 then
		var_6_7 = var_6_5 / 1500
		var_6_7 = math.min(var_6_7, 0.25)
	end

	if arg_6_0.effectRecord.id == 103100012 then
		var_6_7 = var_6_5 / 1500
		var_6_7 = math.min(var_6_7, 0.25)
	end

	if arg_6_0.effectRecord.id ~= 230000 and arg_6_0.effectRecord.id ~= 103900022 and arg_6_0.effectRecord.id ~= 102700002 and arg_6_0.effectRecord.id ~= 103300012 and arg_6_0.effectRecord.id ~= 100700012 and degree ~= 180 then
		local var_6_8 = arg_6_0:getDegree(var_6_2, var_6_1)

		arg_6_0:setRotation(var_6_8)

		if arg_6_0.effectRecord.id == 1012002 then
			if arg_6_0.attacker.forceType == ForceType.Left then
				arg_6_0:setRotation(var_6_8 + 90)
			else
				arg_6_0:setRotation(var_6_8 - 90)
			end
		end
	end

	local var_6_9 = CCArray:create()

	var_6_9:addObject(CCMoveTo:create(var_6_7, var_6_1))
	var_6_9:addObject(CCCallFuncN:create(function()
		arg_6_0:hitAction()
	end))
	var_6_9:addObject(CCDelayTime:create(FIGHT_RANGEWAIT_TIME))
	var_6_9:addObject(CCCallFuncN:create(function()
		arg_6_0:hitEndAction()
	end))

	local var_6_10 = CCSequence:create(var_6_9)

	arg_6_0:setPosition(var_6_2)
	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_10)
end

function zbSpineMissileEffect.createBezierPathEffect(arg_9_0)
	local var_9_0 = findBonePosition(arg_9_0.target.avatarRecord.templateId, arg_9_0.target.heroRecord.name, arg_9_0.target.anim.skeleton, ANIMATION_FXDUMMY_BEHIT)
	local var_9_1 = ccp(0, 0)

	var_9_1.x = arg_9_0.target:getPositionX() + var_9_0.x * arg_9_0.target:getScaleX()
	var_9_1.y = arg_9_0.target:getPositionY() + var_9_0.y * arg_9_0.target:getScaleY()

	local var_9_2 = ccp(arg_9_0.attacker:getPosition())

	if arg_9_0.attacker.forceType == ForceType.Left then
		var_9_2.x = var_9_2.x + arg_9_0.effectRecord.attackEffectPosX
		var_9_2.y = var_9_2.y + arg_9_0.effectRecord.attackEffectPosY
	else
		var_9_2.x = var_9_2.x - arg_9_0.effectRecord.attackEffectPosX
		var_9_2.y = var_9_2.y + arg_9_0.effectRecord.attackEffectPosY
	end

	local var_9_3 = zbUtil:random(40, 45)

	arg_9_0.vx0, arg_9_0.vy0, arg_9_0.missleDuration = arg_9_0:getSpeedAndDuration(var_9_2, var_9_1, var_9_3)
	arg_9_0.initPosition = var_9_2

	local var_9_4 = CCArray:create()

	var_9_4:addObject(CCDelayTime:create(arg_9_0.missleDuration))
	var_9_4:addObject(CCCallFuncN:create(function()
		arg_9_0:hitAction()
	end))
	var_9_4:addObject(CCDelayTime:create(FIGHT_RANGEWAIT_TIME))
	var_9_4:addObject(CCCallFuncN:create(function()
		arg_9_0:hitEndAction()
	end))

	local var_9_5 = CCSequence:create(var_9_4)

	arg_9_0:setPosition(var_9_2)
	arg_9_0:stopAllActions()
	arg_9_0:runAction(var_9_5)
end

function zbSpineMissileEffect.hitAction(arg_12_0)
	arg_12_0:setVisible(false)
	arg_12_0.target:resume()

	if arg_12_0.customHitAction ~= nil then
		arg_12_0.customHitAction(arg_12_0.target)
	else
		if arg_12_0.effectRecord.id == 1015022 then
			g_CombatBubble:setNumOffsetRandomRangeX(25)
		end

		local var_12_0, var_12_1, var_12_2 = g_CombatFormula:calcDamage(arg_12_0.attacker, arg_12_0.target, arg_12_0.skill)

		if var_12_1 > 0 then
			arg_12_0.target:playBehitAnimation(arg_12_0.hitEffectId, arg_12_0.skill)
		end

		if var_12_2 == true then
			g_CombatBubble:showBubble(arg_12_0.attacker, ECombatBubble.KillMpBack, 0, 0, 1)

			arg_12_0.killTargeted = true
		end

		arg_12_0.damageValue = var_12_1

		if arg_12_0.effectRecord.id == 1015022 then
			g_CombatBubble:setNumOffsetRandomRangeX(0)
		end
	end
end

function zbSpineMissileEffect.hitEndAction(arg_13_0)
	arg_13_0.skill:hited(arg_13_0.target, arg_13_0.killTargeted, arg_13_0.damageValue)

	arg_13_0.hited = true
end

function zbSpineMissileEffect.update(arg_14_0, arg_14_1)
	arg_14_0:updateBezier(arg_14_1)
end

function zbSpineMissileEffect.setCustomHitAction(arg_15_0, arg_15_1)
	arg_15_0.customHitAction = arg_15_1
end
