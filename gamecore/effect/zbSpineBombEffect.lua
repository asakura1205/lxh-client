require("gamecore.effect.zbBaseEffect")

zbSpineBombEffect = class("zbSpineBombEffect", zbBaseEffect)
zbSpineBombEffect.__index = zbSpineBombEffect

function zbSpineBombEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineBombEffect)

	return arg_1_0
end

function zbSpineBombEffect.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	local var_2_0 = zbSpineBombEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)

	return var_2_0
end

function zbSpineBombEffect.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9)
	local function var_3_0()
		arg_3_0.skeleton:clearTracks()

		local var_4_0 = arg_3_0.skeleton:setAnimation(0, arg_3_0.effectRecord.sequenceName, arg_3_0.effectRecord.id == 1012044)

		if var_4_0 ~= nil then
			arg_3_0.durationTime = var_4_0.endTime

			if arg_3_0.effectRecord.durationTime > 10000 then
				arg_3_0.durationTime = arg_3_0.effectRecord.durationTime
			end

			if arg_3_0.effectRecord.id == 1042013 then
				var_4_0.timeScale = 1.05
			end

			if arg_3_0.effectRecord.id == 1012044 then
				arg_3_0.durationTime = 10000000
			end
		end

		g_Audio:playSound(arg_3_0.effectRecord.sound)
	end

	arg_3_0.attacker = arg_3_1
	arg_3_0.forceType = arg_3_2
	arg_3_0.effectRecord = arg_3_6
	arg_3_0.accumTime = 0
	arg_3_0.durationTime = 0
	arg_3_0.delayTime = arg_3_7
	arg_3_0.hitTime = arg_3_8
	arg_3_0.customHitAction = arg_3_9
	arg_3_0.skeleton = createSpineAnimation(arg_3_4, arg_3_5, 1, true)

	if arg_3_0.skeleton ~= nil then
		arg_3_0:setPosition(arg_3_3)
		arg_3_0:addChild(arg_3_0.skeleton)
		arg_3_1:getParent():addChild(arg_3_0)

		if arg_3_0.effectRecord.rotateY then
			arg_3_0.skeleton:setRotationY(HeroRotateY[arg_3_2])

			if arg_3_0.effectRecord.id == 1011012 or arg_3_0.effectRecord.id == 1061013 then
				arg_3_0.skeleton:setRotationY(HeroRotateY[arg_3_2] + 180)
			end
		end

		if arg_3_0.effectRecord.heroBehide then
			arg_3_0:setZOrder(ZORDER_BOTTOM + 100)
		else
			arg_3_0:setZOrder(ZORDER_TOP + 100000)
		end

		if arg_3_0.delayTime > 0 then
			arg_3_0.durationTime = 3

			local var_3_1 = CCArray:create()

			var_3_1:addObject(CCDelayTime:create(arg_3_0.delayTime))
			var_3_1:addObject(CCCallFuncN:create(var_3_0))

			if arg_3_0.hitTime ~= nil and arg_3_0.customHitAction ~= nil then
				var_3_1:addObject(CCDelayTime:create(arg_3_0.hitTime))
				var_3_1:addObject(CCCallFuncN:create(function()
					arg_3_0.customHitAction()
				end))
			end

			local var_3_2 = CCSequence:create(var_3_1)

			arg_3_0:stopAllActions()
			arg_3_0:runAction(var_3_2)
		else
			var_3_0()
		end
	end
end

function zbSpineBombEffect.free(arg_6_0)
	if arg_6_0.skeleton ~= nil then
		arg_6_0.skeleton:removeFromParentAndCleanup(true)

		arg_6_0.skeleton = nil
	end

	arg_6_0:removeFromParentAndCleanup(true)
end

function zbSpineBombEffect.update(arg_7_0, arg_7_1)
	if arg_7_0.effectRecord.id == 1012044 and arg_7_0.attacker.avatarRecord.parentAvatarId == 1012 and arg_7_0.attacker.yandiYunEnable == false then
		arg_7_0.durationTime = 0
	end

	arg_7_0.accumTime = arg_7_0.accumTime + arg_7_1
end

function zbSpineBombEffect.isEnd(arg_8_0)
	return arg_8_0.accumTime >= arg_8_0.durationTime + arg_8_0.delayTime
end
