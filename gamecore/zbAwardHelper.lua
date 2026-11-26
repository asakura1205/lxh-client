zbAwardHelper = {}

function zbAwardHelper.refreshAwardItem(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0, var_1_1 = zbIconHelper:getAwardIconPath(arg_1_1, arg_1_2)
	local var_1_2 = zbColor:getEquipFrameTex(5)

	if arg_1_4 ~= nil then
		local var_1_3 = 5

		if arg_1_1 == ECommonAwardType.Hero or arg_1_1 == ECommonAwardType.HeroFrag then
			local var_1_4 = zbHeroTable:getRecord(arg_1_2)

			if var_1_4 ~= nil and var_1_4.quality ~= nil then
				var_1_3 = var_1_4.quality
			end
		elseif arg_1_1 == ECommonAwardType.Item or arg_1_1 == ECommonAwardType.EquipFrag then
			local var_1_5 = zbItemTable:getRecord(arg_1_2)

			if var_1_5 ~= nil and var_1_5.quality ~= nil then
				var_1_3 = var_1_5.quality
			end
		end

		if arg_1_1 == ECommonAwardType.Hero then
			var_1_2 = zbColor:getHeroFrameTex(var_1_3)
		elseif arg_1_1 == ECommonAwardType.HeroFrag then
			var_1_2 = zbColor:getHeroFragFrameTex(var_1_3)
		elseif arg_1_1 == ECommonAwardType.Item then
			var_1_2 = zbColor:getEquipFrameTex(var_1_3)
		elseif arg_1_1 == ECommonAwardType.EquipFrag then
			var_1_2 = zbColor:getEquipFragFrameTex(var_1_3)
		else
			var_1_2 = zbColor:getEquipFrameTex(var_1_3)
		end

		if var_1_2 ~= "" then
			require("gamebase.zbUI"):setButtonPic(arg_1_4, var_1_2, var_1_2, var_1_2)
		end
	end

	if arg_1_5 ~= nil then
		arg_1_5:setTexture(CCTextureCache:sharedTextureCache():addImage(var_1_0))
	end

	if arg_1_6 ~= nil then
		if arg_1_7 ~= nil and arg_1_7 == false then
			arg_1_6:setVisible(false)

			return
		else
			arg_1_6:setVisible(true)
		end

		arg_1_6:setString(var_1_1)
	end
end

function zbAwardHelper.refreshHeroIcon(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = ""
	local var_2_1 = zbColor:getEquipFrameTex(1)
	local var_2_2 = 1
	local var_2_3 = 0

	if arg_2_1 ~= nil then
		var_2_0 = zbIconHelper:getHeroIconPath(arg_2_1.TemplateId)
		var_2_1 = zbColor:getHeroFrameTex(arg_2_1.Quality)
		var_2_2 = arg_2_1.Level
		var_2_3 = arg_2_1.Star
	end

	if var_2_1 ~= "" and arg_2_2 ~= nil then
		require("gamebase.zbUI"):setButtonPic(arg_2_2, var_2_1, var_2_1, var_2_1)
	end

	if var_2_0 ~= "" and arg_2_3 ~= nil then
		arg_2_3:setTexture(CCTextureCache:sharedTextureCache():addImage(var_2_0))
	end

	if arg_2_4 ~= nil then
		arg_2_4:setString(var_2_2)
	end

	zbUIEffect:centerHeroStar(arg_2_5, var_2_3, starMax)
end

function zbAwardHelper.refreshBalanceHeroIcon(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = ""
	local var_3_1 = zbColor:getEquipFrameTex(1)
	local var_3_2 = 1
	local var_3_3 = 0

	if arg_3_1 ~= nil then
		var_3_0 = zbIconHelper:getHeroIconPath(arg_3_1:getTemplateId())
		var_3_1 = zbColor:getHeroFrameTex(arg_3_1:getQuality())
		var_3_2 = arg_3_1:getLevel()
		var_3_3 = arg_3_1:getStar()
	end

	if var_3_1 ~= "" and arg_3_2 ~= nil then
		require("gamebase.zbUI"):setButtonPic(arg_3_2, var_3_1, var_3_1, var_3_1)
	end

	if var_3_0 ~= "" and arg_3_3 ~= nil then
		arg_3_3:setTexture(CCTextureCache:sharedTextureCache():addImage(var_3_0))
	end

	if arg_3_4 ~= nil then
		arg_3_4:setString(var_3_2)
	end

	zbUIEffect:centerHeroStar(arg_3_5, var_3_3, starMax)
end

function zbAwardHelper.refreshNpcIconAndLevel(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = ""
	local var_4_1 = zbColor:getEquipFrameTex(1)
	local var_4_2 = 1

	if arg_4_1 ~= nil then
		var_4_0 = zbIconHelper:getHeroIconPath(arg_4_1.templateId)
		var_4_1 = zbColor:getHeroFrameTex(arg_4_1.quality)
	end

	if arg_4_2 ~= nil then
		var_4_2 = arg_4_2
	end

	if var_4_1 ~= "" and arg_4_3 ~= nil then
		require("gamebase.zbUI"):setButtonPic(arg_4_3, var_4_1, var_4_1, var_4_1)
	end

	if var_4_0 ~= "" and arg_4_4 ~= nil then
		arg_4_4:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_0))
	end

	if arg_4_5 ~= nil then
		arg_4_5:setString(var_4_2)
	end
end

function zbAwardHelper.refreshEquipIcon(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = ""
	local var_5_1 = zbColor:getEquipFrameTex(1)
	local var_5_2 = 1

	if arg_5_1 ~= nil then
		var_5_0 = zbIconHelper:getItemIconPath(arg_5_1.TemplateId)
		var_5_1 = zbColor:getEquipFrameTex(arg_5_1.Quality)
		var_5_2 = arg_5_1.Level
	end

	if var_5_1 ~= "" and arg_5_2 ~= nil then
		require("gamebase.zbUI"):setButtonPic(arg_5_2, var_5_1, var_5_1, var_5_1)
	end

	if var_5_0 ~= "" and arg_5_3 ~= nil then
		arg_5_3:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_0))
	end

	if arg_5_4 ~= nil then
		arg_5_4:setString(var_5_2)
	end
end

function zbAwardHelper.refreshSkillIcon(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ""

	if arg_6_1 ~= nil then
		var_6_0 = zbIconHelper:getSkillIconPath(arg_6_1.SkillId)
	end

	if var_6_0 ~= "" and arg_6_2 ~= nil then
		arg_6_2:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))
		arg_6_2:setMaskTexture(MASK_NOMRML_TEX)
	end
end
