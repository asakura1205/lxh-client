require("gamecore.effect.zbBaseEffect")

zbSpineDazhaoScreenEffect = class("zbSpineDazhaoScreenEffect", zbBaseEffect)
zbSpineDazhaoScreenEffect.__index = zbSpineDazhaoScreenEffect

function zbSpineDazhaoScreenEffect.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbSpineDazhaoScreenEffect)

	return arg_1_0
end

function zbSpineDazhaoScreenEffect.create(arg_2_0, arg_2_1)
	local var_2_0 = zbSpineDazhaoScreenEffect.extend(zbBaseEffect.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbSpineDazhaoScreenEffect.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.skeleton:clearTracks()

		local var_4_0 = arg_3_0.skeleton:setAnimation(0, "animation", false)

		if var_4_0 ~= nil then
			var_4_0.timeScale = FX_DAZHAO_SCREEN_TIMESCALE
			arg_3_0.durationTime = var_4_0.endTime / var_4_0.timeScale
		end

		g_Audio:playSound("audio/sound/legend_jinguangxuanmu.mp3")
	end

	arg_3_0.accumTime = 0
	arg_3_0.durationTime = 0
	arg_3_0.hero = arg_3_1
	arg_3_0.skeleton = createSpineAnimation("effect/spine/ui_jusedazhao/ui_jusedazhao.json", "effect/spine/ui_jusedazhao/ui_jusedazhao.atlas", 1, true)

	if arg_3_0.skeleton ~= nil then
		var_3_0()
		arg_3_0:setPosition(568, 320)
		arg_3_0:addChild(arg_3_0.skeleton)
		arg_3_0.hero:getParent():addChild(arg_3_0)
		arg_3_0:setZOrder(ZORDER_TOP + 100000)

		arg_3_0.posBone = arg_3_0.skeleton:findBone("db")
		arg_3_0.posBone2 = arg_3_0.skeleton:findBone("guanxian2")

		if arg_3_0.posBone ~= nil and arg_3_0.posBone2 ~= nil then
			arg_3_0.spriteHead = CCSprite:create(string.format("ui/image/icon/herotalk/%d.png", arg_3_1.avatarRecord.parentAvatarId))

			arg_3_0.spriteHead:setAnchorPoint(ccp(0.5, 0))
			arg_3_0.spriteHead:setScale(0.7)
			arg_3_0:addChild(arg_3_0.spriteHead)
			arg_3_0:updateHeadPos()
		end

		if arg_3_1.forceType == ForceType.Right then
			arg_3_0:setRotationY(180)
			arg_3_0:setPositionY(arg_3_0:getPositionY() - 150)
		end
	end
end

function zbSpineDazhaoScreenEffect.free(arg_5_0)
	if arg_5_0.skeleton ~= nil then
		arg_5_0.skeleton:removeFromParentAndCleanup(true)

		arg_5_0.skeleton = nil
	end

	arg_5_0:removeFromParentAndCleanup(true)
end

function zbSpineDazhaoScreenEffect.update(arg_6_0, arg_6_1)
	arg_6_0.accumTime = arg_6_0.accumTime + arg_6_1

	arg_6_0:updateHeadPos()
end

function zbSpineDazhaoScreenEffect.updateHeadPos(arg_7_0)
	if arg_7_0.posBone == nil or arg_7_0.posBone2 == nil or arg_7_0.spriteHead == nil then
		return
	end

	arg_7_0.spriteHead:setPosition(arg_7_0.posBone.x + 170, arg_7_0.posBone2.y + 5)
end

function zbSpineDazhaoScreenEffect.isEnd(arg_8_0)
	return arg_8_0.accumTime >= arg_8_0.durationTime
end
