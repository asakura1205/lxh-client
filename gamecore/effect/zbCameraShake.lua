zbCameraShake = class("zbCameraShake")
zbCameraShake.__index = zbCameraShake

function zbCameraShake.create(arg_1_0)
	local var_1_0 = zbCameraShake.new()

	var_1_0:init()

	return var_1_0
end

function zbCameraShake.init(arg_2_0)
	arg_2_0.anim = createUIAnimation()

	arg_2_0.anim:refresh("effect/spine/doudong/doudong.json", "effect/spine/doudong/doudong.atlas")
	arg_2_0.anim:retain()

	arg_2_0.duration = 0.6666666666666666
	arg_2_0.accumTime = 0
	arg_2_0.bone = arg_2_0.anim.skeleton:findBone("bone")
	arg_2_0.watchNodeList = {}
	arg_2_0.sectionKey = g_Login.account .. "_" .. g_Login.lastServerId .. "_shake"
	arg_2_0.enable = tonumber(zbGameCore:Instance():getConfigValue(arg_2_0.sectionKey)) == 0
end

function zbCameraShake.free(arg_3_0)
	return
end

function zbCameraShake.setEnable(arg_4_0, arg_4_1)
	arg_4_0.enable = arg_4_1

	local var_4_0 = 0
	local var_4_1 = arg_4_0.enable and 0 or 1

	zbGameCore:Instance():setConfigValue(arg_4_0.sectionKey, var_4_1)
end

function zbCameraShake.isEnable(arg_5_0)
	return arg_5_0.enable
end

function zbCameraShake.setWatchNode(arg_6_0, arg_6_1)
	if arg_6_0.anim:getParent() ~= nil then
		arg_6_0.anim:removeFromParentAndCleanup(false)
	end

	g_MainScene:addChild(arg_6_0.anim)

	arg_6_0.watchNodeList = arg_6_1
end

function zbCameraShake.update(arg_7_0, arg_7_1)
	if arg_7_0.bone == nil then
		return
	end

	if arg_7_0.enable == false then
		return
	end

	arg_7_0.accumTime = arg_7_0.accumTime + arg_7_1

	if arg_7_0.accumTime > arg_7_0.duration then
		return
	end

	local var_7_0 = spBone_getWorldX(arg_7_0.bone) * 1.15
	local var_7_1 = spBone_getWorldY(arg_7_0.bone) * 1.15

	for iter_7_0, iter_7_1 in pairs(arg_7_0.watchNodeList) do
		iter_7_1.node:setPosition(iter_7_1.initPos.x + var_7_0, iter_7_1.initPos.y + var_7_1)
	end
end

function zbCameraShake.shake(arg_8_0)
	arg_8_0.anim:setAnimation("animation", false, 1.2)

	arg_8_0.accumTime = 0
end
