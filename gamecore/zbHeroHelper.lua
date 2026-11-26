zbHeroHelper = {}

function zbHeroHelper.getHeroAttributeTable(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_1.HeroAttr) do
		if iter_1_1[2] == EAttrAdditionType.Fixed then
			var_1_0[iter_1_1[1]] = math.round(iter_1_1[3])
		else
			var_1_0[iter_1_1[1]] = iter_1_1[3]
		end
	end

	return var_1_0
end
