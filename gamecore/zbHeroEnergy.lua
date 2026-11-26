zbHeroEnergy = class("zbHeroEnergy")
zbHeroEnergy.__index = zbHeroEnergy

function zbHeroEnergy.create(arg_1_0, arg_1_1)
	local var_1_0 = zbHeroEnergy.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbHeroEnergy.init(arg_2_0, arg_2_1)
	arg_2_0.hero = arg_2_1
	arg_2_0.visible = false
	arg_2_0.count = 0
	arg_2_0.maxCount = 1000
	arg_2_0.texturePath = "image/common/failed.png"
	arg_2_0.textureHaloPath = "image/common/failed.png"

	if arg_2_1.avatarRecord.parentAvatarId == 1022 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_heixiu.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_heixiu_halo.png"
		arg_2_0.visible = true
	elseif arg_2_1.avatarRecord.parentAvatarId == 1031 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_zhadan.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_zhadan_halo.png"
		arg_2_0.visible = true
	elseif arg_2_1.avatarRecord.parentAvatarId == 1202 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_xunzhang.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_xunzhang_halo.png"
		arg_2_0.visible = true
		arg_2_0.maxCount = 3
	elseif arg_2_1.avatarRecord.parentAvatarId == 1203 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_bangqiu.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_bangqiu_halo.png"
		arg_2_0.visible = true
		arg_2_0.maxCount = 5
	elseif arg_2_1.avatarRecord.parentAvatarId == 1014 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_qizi.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_qizi_halo.png"
		arg_2_0.visible = true
		arg_2_0.maxCount = 5
	elseif arg_2_1.avatarRecord.parentAvatarId == 1204 then
		arg_2_0.texturePath = "image/combat/battleui/console/energy_zidan.png"
		arg_2_0.textureHaloPath = "image/combat/battleui/console/energy_zidan_halo.png"
		arg_2_0.visible = true
		arg_2_0.maxCount = 5
	end
end

function zbHeroEnergy.addCount(arg_3_0)
	arg_3_0.count = math.min(arg_3_0.count + 1, arg_3_0.maxCount)
end

function zbHeroEnergy.decCount(arg_4_0)
	arg_4_0.count = math.max(arg_4_0.count - 1, 0)
end

function zbHeroEnergy.getCount(arg_5_0)
	return arg_5_0.count
end

function zbHeroEnergy.clearCount(arg_6_0)
	arg_6_0.count = 0
end
