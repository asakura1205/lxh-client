zbHeroDetailWnd_Fate_Sub = class("zbHeroDetailWnd_Fate_Sub", CCNodeExtend)
zbHeroDetailWnd_Fate_Sub.__index = zbHeroDetailWnd_Fate_Sub

function zbHeroDetailWnd_Fate_Sub.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Fate_Sub)

	return arg_1_0
end

function zbHeroDetailWnd_Fate_Sub.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroDetailWnd_Fate_Sub.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroDetailWnd_Fate_Sub.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.ccNode = arg_3_1
		arg_3_0.items = {}
		arg_3_0.fateItem = {}
		arg_3_0.touchCount = 1
	end

	local function var_3_1()
		arg_3_0.spriteBg = tolua.cast(arg_3_1:getChildByTag(1), "CCSprite")
		arg_3_0.spriteFrame = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCSprite")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbAtrr = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbForma = tolua.cast(arg_3_0.spriteBg:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnGoto = tolua.cast(arg_3_0.spriteBg:getChildByTag(100), "CCControlButton")

		arg_3_0.lbForma:setVisible(false)
		arg_3_0.btnGoto:addHandleOfControlEvent(function()
			arg_3_0:onGoto()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGoto:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGoto:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(564, 100))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_Fate_Sub.free(arg_7_0)
	return
end

function zbHeroDetailWnd_Fate_Sub.refreshHero(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.fateItem = {}
	arg_8_0.touchCount = 1
	arg_8_0.record = arg_8_2

	arg_8_0.lbName:setString(a2u(arg_8_2.fateName))

	if arg_8_2.growthPercent == 0 then
		arg_8_0.lbAtrr:setString(a2u(getItemPropStr(arg_8_2.fateAttr) .. "+" .. arg_8_2.growthValue))
	else
		arg_8_0.lbAtrr:setString(a2u(getItemPropStr(arg_8_2.fateAttr) .. "+" .. arg_8_2.growthPercent * 100 .. "%"))
	end

	arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_fatehero.png"))
	arg_8_0.btnGoto:setVisible(false)

	local var_8_0 = ""
	local var_8_1 = true

	for iter_8_0, iter_8_1 in pairs(arg_8_2.fateCondition) do
		local var_8_2 = false

		for iter_8_2, iter_8_3 in pairs(g_GameData.HeroList) do
			if iter_8_3.HeroBaseInfo.TemplateId == iter_8_1 then
				var_8_2 = true

				break
			end
		end

		local var_8_3 = zbHeroTable:getRecord(iter_8_1)

		if var_8_3 then
			table.insert(arg_8_0.fateItem, iter_8_1)

			local var_8_4 = ""

			if var_8_2 then
				var_8_4 = zbUtil:getRichColorString(var_8_3.name, HEX_FONT_COLOR_GREEN)
			else
				var_8_1 = false
				var_8_4 = zbUtil:getRichColorString(var_8_3.name, HEX_FONT_COLOR_BLACK)
			end

			if iter_8_0 == 1 then
				var_8_0 = var_8_4
			else
				var_8_0 = var_8_0 .. "," .. var_8_4
			end

			arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroIconPath(iter_8_1)))
		end
	end

	if var_8_1 == false then
		arg_8_0.lbName:setColor(FONT_COLOR_RED)
	else
		arg_8_0.lbName:setColor(FONT_COLOR_GREEN)
	end

	arg_8_0.spriteBg:setGray(not var_8_1)

	arg_8_0.lbFormaGrowth = arg_8_0:refreshRichText(arg_8_0.lbForma, arg_8_0.lbFormaGrowth)

	arg_8_0.lbFormaGrowth:setRichString(a2u("ӵ\xD3\xD0 ") .. var_8_0)
	arg_8_0.ccNode:addChild(arg_8_0.lbFormaGrowth)
end

function zbHeroDetailWnd_Fate_Sub.refreshEquip(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.currHero = arg_9_1
	arg_9_0.fateEquip = arg_9_2
	arg_9_0.fateItem = {}
	arg_9_0.touchCount = 1

	arg_9_0.btnGoto:setVisible(true)

	local var_9_0 = zbFateTable:getRecord(arg_9_2.FateId)

	arg_9_0.lbName:setString(var_9_0.fateName)

	if var_9_0.growthPercent == 0 then
		arg_9_0.lbAtrr:setString(a2u(getItemPropStr(var_9_0.fateAttr) .. "+" .. var_9_0.growthValue))
	else
		arg_9_0.lbAtrr:setString(a2u(getItemPropStr(var_9_0.fateAttr) .. "+" .. var_9_0.growthPercent * 100 .. "%"))
	end

	arg_9_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_fateequip.png"))

	local var_9_1 = ""
	local var_9_2 = false

	for iter_9_0, iter_9_1 in pairs(var_9_0.fateCondition) do
		arg_9_0.equipTemplateId = iter_9_1

		local var_9_3 = false

		for iter_9_2, iter_9_3 in pairs(g_GameData.HeroList) do
			if iter_9_3.HeroBaseInfo.TemplateId == arg_9_1.HeroBaseInfo.TemplateId then
				local var_9_4 = iter_9_3.EquipList

				for iter_9_4, iter_9_5 in pairs(var_9_4) do
					if iter_9_5.Equip.TemplateId == iter_9_1 then
						var_9_3 = true
						var_9_2 = true

						break
					end
				end

				break
			end
		end

		if var_9_3 == false then
			for iter_9_6, iter_9_7 in pairs(g_GameData.BagEquipList) do
				if iter_9_7.TemplateId == iter_9_1 then
					var_9_3 = true

					break
				end
			end
		end

		local var_9_5 = zbItemTable:getRecord(iter_9_1)

		if var_9_5 then
			local var_9_6 = ""

			if var_9_3 then
				var_9_6 = zbUtil:getRichColorString(var_9_5.name, HEX_FONT_COLOR_GREEN)
			else
				var_9_6 = zbUtil:getRichColorString(var_9_5.name, HEX_FONT_COLOR_BLACK)
			end

			if iter_9_0 == 1 then
				var_9_1 = var_9_6
			else
				var_9_1 = var_9_1 .. "," .. var_9_6
			end
		end

		arg_9_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(iter_9_1)))
	end

	if var_9_2 == false then
		arg_9_0.lbName:setColor(FONT_COLOR_RED)
	else
		arg_9_0.lbName:setColor(FONT_COLOR_GREEN)
	end

	arg_9_0.lbFormaGrowth = arg_9_0:refreshRichText(arg_9_0.lbForma, arg_9_0.lbFormaGrowth)

	arg_9_0.lbFormaGrowth:setRichString(a2u("\xB4\xA9\xB4\xF7 ") .. var_9_1)
	arg_9_0.ccNode:addChild(arg_9_0.lbFormaGrowth)
end

function zbHeroDetailWnd_Fate_Sub.onGoto(arg_10_0)
	g_MainScene:showEquipFateListWnd(arg_10_0.currHero, arg_10_0.fateEquip.EquipType)
end

function zbHeroDetailWnd_Fate_Sub.refreshRichText(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 ~= nil then
		arg_11_2:removeFromParentAndCleanup(true)

		arg_11_2 = nil
	end

	local var_11_0 = arg_11_1:getTxtBound().width
	local var_11_1 = arg_11_1:getContentSize()

	arg_11_2 = CCRichLabelTTF:create(var_11_1.width + 50, var_11_1.height, arg_11_1:getFontSize(), arg_11_1:getFontName(), ccc3(255, 255, 255), false)

	arg_11_2:setVisible(true)

	local var_11_2 = ccp(arg_11_1:getPosition())

	arg_11_2:setPosition(var_11_2.x, var_11_2.y)

	return arg_11_2
end
