require("gamecore.zbUIAnimation")
require("gamecore.zbCombatDefine")

zbHeroAvatar = class("zbHeroAvatar", CCNodeExtend)
zbHeroAvatar.__index = zbHeroAvatar

function zbHeroAvatar.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroAvatar)

	return arg_1_0
end

function createHeroAvatar()
	local var_2_0 = zbHeroAvatar.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbHeroAvatar.init(arg_3_0)
	arg_3_0.spriteShadow = CCSprite:create("image/combat/yingzi.png")

	arg_3_0.spriteShadow:setPosition(0, 0)

	arg_3_0.anim = createUIAnimation()

	arg_3_0:addChild(arg_3_0.anim)

	arg_3_0.heroTemplateId = -1
	arg_3_0.heroAnimMap = {}
	arg_3_0.nodeSound = CCNode:create()

	arg_3_0:addChild(arg_3_0.nodeSound)
end

function zbHeroAvatar.free(arg_4_0)
	arg_4_0.anim:free()
end

function zbHeroAvatar.refresh(arg_5_0, arg_5_1)
	if arg_5_0.heroTemplateId == arg_5_1 then
		return
	end

	arg_5_0.heroTemplateId = arg_5_1

	arg_5_0.anim:refreshHeroTemplateId(arg_5_1)
	arg_5_0:checkAnimDuration(arg_5_1)
	arg_5_0:playIdleAnimation()

	local var_5_0 = zbHeroTable:getRecord(arg_5_1)

	if var_5_0 ~= nil then
		local var_5_1 = zbAvatarTable:getRecord(var_5_0.avatarId)

		if var_5_1 ~= nil then
			local var_5_2 = math.min(210 / var_5_1.hudOffset.y, 1.3)

			arg_5_0:setScale(var_5_2)
		end
	end
end

function zbHeroAvatar.playRandomAnimation(arg_6_0)
	local var_6_0 = arg_6_0.heroAnimMap[arg_6_0.heroTemplateId]

	if var_6_0 == nil then
		return
	end

	local var_6_1 = var_6_0[math.ceil(zbUtil:random(1, table.getn(var_6_0)))]

	if var_6_1 == nil then
		return
	end

	if var_6_1.loop then
		arg_6_0.anim:setAnimation(var_6_1.sequenceName, true)
	else
		arg_6_0.anim:playAnimationOnce(var_6_1.sequenceName, ANIMATION_SEQUENCE_IDLE, 0.2)
	end

	local function var_6_2()
		g_Audio:playSound(var_6_1.sound)
	end

	local var_6_3 = CCArray:create()

	var_6_3:addObject(CCDelayTime:create(var_6_1.soundFrame))
	var_6_3:addObject(CCCallFuncN:create(var_6_2))
	arg_6_0.nodeSound:stopAllActions()
	arg_6_0.nodeSound:runAction(CCSequence:create(var_6_3))
end

function zbHeroAvatar.playIdleAnimation(arg_8_0)
	arg_8_0.nodeSound:stopAllActions()
	arg_8_0.anim:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
end

function zbHeroAvatar.playWinAnimation(arg_9_0)
	arg_9_0.nodeSound:stopAllActions()
	arg_9_0.anim:playAnimationOnce(ANIMATION_SEQUENCE_WIN, ANIMATION_SEQUENCE_IDLE, 0.2)
end

function zbHeroAvatar.playAnimationOnce(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.nodeSound:stopAllActions()
	arg_10_0.anim:playAnimationOnce(arg_10_1, arg_10_2, arg_10_3)
end

function zbHeroAvatar.checkAnimDuration(arg_11_0, arg_11_1)
	if arg_11_0.heroAnimMap[arg_11_1] ~= nil then
		return
	end

	local var_11_0 = zbHeroTable:getRecord(arg_11_1)

	if var_11_0 == nil then
		echoInfo("warning: hero templateId not exist" .. arg_11_1)

		return
	end

	local var_11_1 = zbAvatarTable:getRecord(var_11_0.avatarId)

	if var_11_1 == nil then
		echoInfo("warning: hero avatar not exist: " .. var_11_0.avatarId)

		return
	end

	local var_11_2 = {}

	local function var_11_3(arg_12_0)
		if arg_11_0.anim:getAnimDuration(arg_12_0) > 0.5 then
			local var_12_0 = {
				loop = arg_12_0 == ANIMATION_SEQUENCE_MOVE,
				sequenceName = arg_12_0
			}

			var_12_0.effect = ""
			var_12_0.sound, var_12_0.soundFrame = zbAvatarSoundTable:getSound(var_11_1.templateId, arg_12_0)

			table.insert(var_11_2, var_12_0)
		end
	end

	arg_11_0.animDurations = {}
	arg_11_0.animDurations[ANIMATION_SEQUENCE_PHYATTACK] = var_11_3(ANIMATION_SEQUENCE_PHYATTACK)

	if arg_11_0.heroTemplateId ~= 1001 then
		arg_11_0.animDurations[ANIMATION_SEQUENCE_SKILL1] = var_11_3(ANIMATION_SEQUENCE_SKILL1)
		arg_11_0.animDurations[ANIMATION_SEQUENCE_SKILL2] = var_11_3(ANIMATION_SEQUENCE_SKILL2)
	end

	arg_11_0.heroAnimMap[arg_11_1] = var_11_2
end
