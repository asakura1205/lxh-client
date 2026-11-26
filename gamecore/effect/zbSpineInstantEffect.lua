require("gamecore.effect.zbBaseEffect")

zbSpineInstantEffect = class("zbSpineInstantEffect", zbBaseEffect)
zbSpineInstantEffect.__index = zbSpineInstantEffect

function zbSpineInstantEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineInstantEffect)

	return arg_1_0
end

function zbSpineInstantEffect.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = zbSpineInstantEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function zbSpineInstantEffect.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_5 == nil then
		arg_3_5 = 0
	end

	local function var_3_0()
		arg_3_0.skeleton:clearTracks()

		local var_4_0 = arg_3_0.skeleton:setAnimation(0, arg_3_4.sequenceName, false)

		if var_4_0 ~= nil then
			arg_3_0.durationTime = var_4_0.endTime

			if arg_3_0.effectRecord.durationTime > 10000 then
				arg_3_0.durationTime = arg_3_0.effectRecord.durationTime
			end

			if arg_3_0.effectRecord.id == 1024012 or arg_3_0.effectRecord.id == 1024013 then
				var_4_0.timeScale = 0.8
			end

			arg_3_0.entry = var_4_0
		end

		g_Audio:playSound(arg_3_0.effectRecord.sound)
	end

	arg_3_0.effectRecord = arg_3_4
	arg_3_0.accumTime = 0
	arg_3_0.durationTime = 0
	arg_3_0.delayTime = arg_3_5
	arg_3_0.hero = arg_3_1
	arg_3_0.entry = nil
	arg_3_0.skeleton = createSpineAnimation(arg_3_2, arg_3_3, 1, true)

	if arg_3_0.skeleton ~= nil then
		local var_3_1 = arg_3_0:getEffectPos()

		arg_3_0:setScale(arg_3_0.effectRecord.scale)
		arg_3_0:setPosition(var_3_1)
		arg_3_0:addChild(arg_3_0.skeleton)

		if arg_3_0.effectRecord.parentNode == 0 then
			arg_3_0.hero:getParent():addChild(arg_3_0)

			if arg_3_0.effectRecord.rotateY then
				arg_3_0.skeleton:setRotationY(arg_3_0.hero:getRotationY())

				if arg_3_0.effectRecord.id == 1011002 then
					arg_3_0.skeleton:setRotationY(arg_3_0.hero:getRotationY() + 180)
				end
			end
		else
			arg_3_1:addChild(arg_3_0)
			arg_3_0.skeleton:setRotationY(arg_3_0.hero.anim:getRotationY())
		end

		if arg_3_0.effectRecord.heroBehide then
			arg_3_0:setZOrder(ZORDER_BOTTOM + 100)
		else
			arg_3_0:setZOrder(ZORDER_TOP + 100000)
		end

		if arg_3_0.delayTime > 0 then
			arg_3_0.durationTime = 3

			local var_3_2 = CCArray:create()

			var_3_2:addObject(CCDelayTime:create(arg_3_0.delayTime))
			var_3_2:addObject(CCCallFuncN:create(var_3_0))

			local var_3_3 = CCSequence:create(var_3_2)

			arg_3_0:stopAllActions()
			arg_3_0:runAction(var_3_3)
		else
			var_3_0()
		end
	else
		echo(string.format("warning spine effect animation not exist: %s", arg_3_2))
	end
end

function zbSpineInstantEffect.getEffectPos(arg_5_0)
	local var_5_0 = findBonePosition(arg_5_0.hero.avatarRecord.templateId, arg_5_0.hero.heroRecord.name, arg_5_0.hero.anim.skeleton, arg_5_0.effectRecord.dummy, arg_5_0.hero.forceType)

	if arg_5_0.effectRecord.parentNode == 0 then
		var_5_0.x = arg_5_0.hero:getPositionX() + var_5_0.x * arg_5_0.hero:getScaleX()
		var_5_0.y = arg_5_0.hero:getPositionY() + var_5_0.y * arg_5_0.hero:getScaleY()
	end

	if arg_5_0.hero:isMeihuo() then
		if arg_5_0.hero.forceType == ForceType.Left then
			var_5_0.x = var_5_0.x - arg_5_0.effectRecord.attackEffectPosX
			var_5_0.y = var_5_0.y + arg_5_0.effectRecord.attackEffectPosY
		else
			var_5_0.x = var_5_0.x + arg_5_0.effectRecord.attackEffectPosX
			var_5_0.y = var_5_0.y + arg_5_0.effectRecord.attackEffectPosY
		end
	elseif arg_5_0.hero.forceType == ForceType.Left then
		var_5_0.x = var_5_0.x + arg_5_0.effectRecord.attackEffectPosX
		var_5_0.y = var_5_0.y + arg_5_0.effectRecord.attackEffectPosY
	else
		var_5_0.x = var_5_0.x - arg_5_0.effectRecord.attackEffectPosX
		var_5_0.y = var_5_0.y + arg_5_0.effectRecord.attackEffectPosY
	end

	if arg_5_0.effectRecord.id == 101600012 then
		var_5_0.x = var_5_0.x - 35
		var_5_0.y = var_5_0.y + 30
	end

	if arg_5_0.effectRecord.id == 101500012 then
		var_5_0 = arg_5_0.hero:getFixPosition()
	end

	return var_5_0
end

function zbSpineInstantEffect.free(arg_6_0)
	if arg_6_0.skeleton ~= nil then
		arg_6_0.skeleton:removeFromParentAndCleanup(true)

		arg_6_0.skeleton = nil
	end

	arg_6_0:removeFromParentAndCleanup(true)
end

function zbSpineInstantEffect.update(arg_7_0, arg_7_1)
	arg_7_0.accumTime = arg_7_0.accumTime + arg_7_1
end

function zbSpineInstantEffect.isEnd(arg_8_0)
	return arg_8_0.accumTime >= arg_8_0.durationTime
end
