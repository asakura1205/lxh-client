zbHeroBuff = class("zbHeroBuff", CCNodeExtend)
zbHeroBuff.__index = zbHeroBuff

function zbHeroBuff.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroBuff)

	return arg_1_0
end

function zbHeroBuff.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHeroBuff.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHeroBuff.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:free()

	arg_3_0.lastBuffId = -1
	arg_3_0.lastSequenceName = ""
	arg_3_0.buffId = -1
	arg_3_0.hero = arg_3_1
	arg_3_0.posType = arg_3_2
	arg_3_0.curSequenceName = ""
	arg_3_0.curJsonFile = ""

	arg_3_0:setZOrder(ZORDER_TOP - 1)
	arg_3_0:setVisible(false)
	arg_3_0:setAnchorPoint(ccp(0.5, 0.5))
	arg_3_1:addChild(arg_3_0)

	if arg_3_0.posType == BUFF_POS_FRONT then
		arg_3_0:setRotationY(arg_3_0.hero:getRotationY())
		arg_3_0:setPositionY(arg_3_0.hero.avatarRecord.hudOffset.y / 2)
	end

	if arg_3_0.posType == BUFF_POS_GROUND then
		arg_3_0:setZOrder(ZORDER_BOTTOM)
	end

	arg_3_0.animAccumTime = 0
end

function zbHeroBuff.free(arg_4_0)
	if arg_4_0.skeleton ~= nil then
		arg_4_0.skeleton:removeFromParentAndCleanup(true)

		arg_4_0.skeleton = nil
	end
end

function zbHeroBuff.confirmSkeleton(arg_5_0, arg_5_1)
	local var_5_0 = "effect/spine/buff/" .. arg_5_1 .. "/" .. arg_5_1 .. ".json"
	local var_5_1 = "effect/spine/buff/" .. arg_5_1 .. "/" .. arg_5_1 .. ".atlas"

	if arg_5_0.curJsonFile == var_5_0 then
		return
	end

	if arg_5_0.skeleton ~= nil and arg_5_0.skeleton:getParent() ~= nil then
		arg_5_0.skeleton:removeFromParentAndCleanup(false)
	end

	arg_5_0.curJsonFile = var_5_0
	arg_5_0.skeleton = createSpineAnimation(var_5_0, var_5_1, 1, true)

	if arg_5_0.skeleton ~= nil then
		arg_5_0.skeleton:setCascadeOpacityEnabled(true)
		arg_5_0:addChild(arg_5_0.skeleton)
	end
end

function zbHeroBuff.update(arg_6_0, arg_6_1)
	if arg_6_0:isVisible() then
		if g_BuffSystem:heroHasBuff(arg_6_0.hero, arg_6_0.buffId) == false then
			arg_6_0:showPreBuffEffect()

			return
		end

		arg_6_0.animAccumTime = arg_6_0.animAccumTime + arg_6_1

		if arg_6_0.animAccumTime > 0.1 and arg_6_0.skeleton ~= nil then
			arg_6_0.skeleton:setVisible(true)
		end

		if arg_6_0.posType == BUFF_POS_FRONT then
			arg_6_0:setRotationY(arg_6_0.hero:getRotationY())

			local var_6_0 = 30

			if arg_6_0.hero.forceType == ForceType.Right then
				var_6_0 = -var_6_0
			end

			if arg_6_0.curSequenceName == BUFF_SEQUENCE_LAOLONG or arg_6_0.curSequenceName == BUFF_SEQUENCE_CAIWENJI_QINYIN or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_ROUND_REDUCE or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_PM_HEIXIU or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_PM_BANGQIU_FRONT or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE then
				var_6_0 = 0
			end

			arg_6_0:setPositionX(var_6_0)

			if arg_6_0.curSequenceName == BUFF_SEQUENCE_LAOLONG or arg_6_0.curSequenceName == BUFF_SEQUENCE_CAIWENJI_QINYIN or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_PM_BANGQIU_FRONT or arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE then
				arg_6_0:setPositionY(0)
			end

			if arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_ROUND_REDUCE then
				-- block empty
			end

			if arg_6_0.curSequenceName == BUFF_SEQUENCE_SHIELD_ROUND_REDUCE_HUAXIANZI then
				arg_6_0:setPosition(0, 0)
			end
		elseif arg_6_0.posType == BUFF_POS_HEAD then
			local var_6_1 = arg_6_0.hero:getHudHpHeight() + 40

			if arg_6_0.buffId == BUFF_TYPE_PROPERTY_HP_FIRE then
				var_6_1 = var_6_1 - 150
			end

			arg_6_0:setPositionY(var_6_1)
			arg_6_0:setZOrder(ZORDER_TOP - 1)
		elseif arg_6_0.posType == BUFF_POS_GROUND then
			if arg_6_0.curSequenceName == BUFF_SEQUENCE_MISC_SUOLIAN then
				arg_6_0:setZOrder(ZORDER_TOP)
			else
				arg_6_0:setZOrder(ZORDER_BOTTOM)
			end
		end
	end
end

function zbHeroBuff.showBuffEffect(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.buffId == arg_7_1 and arg_7_0.curSequenceName == arg_7_2 and arg_7_0:isVisible() then
		return
	end

	arg_7_0:confirmSkeleton(arg_7_2)

	arg_7_0.lastBuffId = arg_7_0.buffId
	arg_7_0.lastSequenceName = arg_7_0.curSequenceName
	arg_7_0.buffId = arg_7_1
	arg_7_0.curSequenceName = arg_7_2

	arg_7_0:setVisible(true)

	if arg_7_0.skeleton ~= nil then
		arg_7_0.skeleton:clearTracks()

		local var_7_0 = arg_7_0.skeleton:setAnimation(0, "animation", true)

		arg_7_0.skeleton:setVisible(false)
		arg_7_0.skeleton:runAction(CCFadeIn:create(0.2))

		if arg_7_2 == BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE then
			arg_7_0.skeleton:setScale(1.2)

			if var_7_0 ~= nil then
				var_7_0.timeScale = 0.6
			end
		elseif arg_7_2 == BUFF_SEQUENCE_CAIWENJI_QINYIN then
			arg_7_0.skeleton:setScale(0.65)
		end
	end

	arg_7_0.animAccumTime = 0
end

function zbHeroBuff.showPreBuffEffect(arg_8_0)
	if g_BuffSystem:heroHasBuff(arg_8_0.hero, arg_8_0.lastBuffId) == false then
		arg_8_0:setVisible(false)

		return
	end

	arg_8_0:confirmSkeleton(arg_8_0.lastSequenceName)

	arg_8_0.buffId = arg_8_0.lastBuffId
	arg_8_0.curSequenceName = arg_8_0.lastSequenceName

	arg_8_0:setVisible(true)

	if arg_8_0.skeleton ~= nil then
		arg_8_0.skeleton:clearTracks()

		local var_8_0 = arg_8_0.skeleton:setAnimation(0, "animation", true)

		arg_8_0.skeleton:setVisible(false)
		arg_8_0.skeleton:runAction(CCFadeIn:create(0.2))

		if sequenceName == BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE then
			arg_8_0.skeleton:setScale(1.2)

			if var_8_0 ~= nil then
				var_8_0.timeScale = 0.6
			end
		elseif sequenceName == BUFF_SEQUENCE_CAIWENJI_QINYIN then
			arg_8_0.skeleton:setScale(0.65)
		end
	end

	arg_8_0.animAccumTime = 0
	arg_8_0.lastBuffId = -1
	arg_8_0.lastSequenceName = ""
end
