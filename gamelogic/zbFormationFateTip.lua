zbFormationFateTip = class("zbFormationFateTip")
zbFormationFateTip.__index = zbFormationFateTip

function zbFormationFateTip.create(arg_1_0, arg_1_1)
	local var_1_0 = zbFormationFateTip.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbFormationFateTip.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.fateTitle = {}
		arg_2_0.fateHeroRich = {}
		arg_2_0.fateNode = {}
		arg_2_0.fateName = {}
	end

	local function var_2_1()
		arg_2_0.uiNode = arg_2_1
		arg_2_0.spriteBg = tolua.cast(arg_2_1:getChildByTag(0), "CCScale9Sprite")

		for iter_4_0 = 1, 5 do
			arg_2_0.fateNode[iter_4_0] = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCNode")
			arg_2_0.fateTitle[iter_4_0] = tolua.cast(arg_2_0.fateNode[iter_4_0]:getChildByTag(1), "CCLabelTTF")

			arg_2_0.fateTitle[iter_4_0]:setVisible(false)
		end
	end

	var_2_0()
	var_2_1()
end

function zbFormationFateTip.show(arg_5_0)
	arg_5_0.fateNum = 0
	arg_5_0.fateName = {}
	arg_5_0.maxWidth = 0

	for iter_5_0 = 1, 5 do
		arg_5_0.fateNode[iter_5_0]:setVisible(false)
	end

	for iter_5_1, iter_5_2 in pairs(g_Self.kFormation.slots) do
		if iter_5_1 <= 9 and iter_5_2 ~= 0 then
			arg_5_0:freshFate(iter_5_2)
		end
	end

	arg_5_0.uiNode:setVisible(true)

	local var_5_0 = 70

	arg_5_0.spriteBg:setContentSize(CCSizeMake(arg_5_0.maxWidth + 70, var_5_0 + 30 * arg_5_0.fateNum))
end

function zbFormationFateTip.freshFate(arg_6_0, arg_6_1)
	if arg_6_0.fateNum >= 5 then
		return
	end

	local var_6_0 = zbFateTable:getHeroFateRecord(arg_6_1, EFateType.Hero)

	if var_6_0 == nil then
		return
	end

	local var_6_1 = ""
	local var_6_2 = ""

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1 and iter_6_1.fateType == EFateType.Hero then
			local var_6_3 = true
			local var_6_4 = ""

			for iter_6_2, iter_6_3 in pairs(iter_6_1.fateCondition) do
				arg_6_0.haveHero = false

				for iter_6_4, iter_6_5 in pairs(g_GameData.HeroList) do
					if iter_6_5.HeroBaseInfo.TemplateId == iter_6_3 then
						arg_6_0.haveHero = true

						break
					end
				end

				if arg_6_0.haveHero == false then
					var_6_3 = false

					break
				end

				if arg_6_0.haveHero then
					local var_6_5 = zbHeroTable:getRecord(iter_6_3)

					if var_6_5 then
						local var_6_6 = var_6_5.name

						if iter_6_2 == 1 then
							var_6_4 = var_6_6
						else
							var_6_4 = var_6_4 .. "+" .. var_6_6
						end
					end
				end
			end

			if var_6_3 then
				local var_6_7 = zbUtil:getRichColorString(" (" .. var_6_4 .. ")", HEX_FONT_COLOR_PURPLE)

				var_6_1 = var_6_1 .. " " .. a2u(getItemPropStr(iter_6_1.fateAttr)) .. "+" .. iter_6_1.growthPercent * 100 .. "%" .. var_6_7
				var_6_2 = var_6_2 .. " " .. a2u(getItemPropStr(iter_6_1.fateAttr)) .. "+" .. iter_6_1.growthPercent * 100 .. "%(" .. var_6_4 .. ")"
			end
		end
	end

	local var_6_8 = zbHeroTable:getRecord(arg_6_1)

	if var_6_8 == nil then
		return
	end

	local var_6_9 = zbUtil:getRichColorString(var_6_8.name, HEX_FONT_COLOR_GREEN)

	if var_6_1 == "" then
		var_6_1 = var_6_9 .. ": " .. a2u("\xCE\xDE")
		var_6_2 = var_6_8.name .. ": " .. a2u("\xCE\xDE")
	else
		var_6_1 = var_6_9 .. ":" .. var_6_1
		var_6_2 = var_6_8.name .. ":" .. var_6_2
	end

	arg_6_0.fateTitle[arg_6_0.fateNum + 1]:setString(var_6_2)

	arg_6_0.fateHeroRich[arg_6_0.fateNum + 1] = arg_6_0:refreshRichText(arg_6_0.fateTitle[arg_6_0.fateNum + 1], arg_6_0.fateHeroRich[arg_6_0.fateNum + 1])

	arg_6_0.fateNode[arg_6_0.fateNum + 1]:addChild(arg_6_0.fateHeroRich[arg_6_0.fateNum + 1])
	arg_6_0.fateHeroRich[arg_6_0.fateNum + 1]:setRichString(var_6_1)
	arg_6_0.fateNode[arg_6_0.fateNum + 1]:setVisible(true)

	arg_6_0.fateNum = arg_6_0.fateNum + 1
end

function zbFormationFateTip.hide(arg_7_0)
	arg_7_0.uiNode:setVisible(false)
end

function zbFormationFateTip.refreshRichText(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 ~= nil then
		arg_8_2:removeFromParentAndCleanup(true)

		arg_8_2 = nil
	end

	local var_8_0 = arg_8_1:getTxtBound().width
	local var_8_1 = arg_8_1:getContentSize()

	if arg_8_0.maxWidth < var_8_1.width then
		arg_8_0.maxWidth = var_8_1.width
	end

	arg_8_2 = CCRichLabelTTF:create(var_8_1.width + 50, var_8_1.height, arg_8_1:getFontSize(), arg_8_1:getFontName(), ccc3(255, 255, 255), false)

	arg_8_2:setVisible(true)

	local var_8_2 = ccp(arg_8_1:getPosition())

	arg_8_2:setPosition(var_8_2.x, var_8_2.y)

	return arg_8_2
end

function zbFormationFateTip.getHaveFateName(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.fateName) do
		if arg_9_1 == iter_9_1 then
			return true
		end
	end

	table.insert(arg_9_0.fateName, arg_9_1)

	return false
end
