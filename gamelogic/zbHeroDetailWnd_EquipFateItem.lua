zbHeroDetailWnd_EquipFateItem = class("zbHeroDetailWnd_EquipFateItem", CCNodeExtend)
zbHeroDetailWnd_EquipFateItem.__index = zbHeroDetailWnd_EquipFateItem

function zbHeroDetailWnd_EquipFateItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_EquipFateItem)

	return arg_1_0
end

function zbHeroDetailWnd_EquipFateItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHeroDetailWnd_EquipFateItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHeroDetailWnd_EquipFateItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.ccNode = arg_3_1
		arg_3_0.parent = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteFrame = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCSprite")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbAtrr = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCLabelTTF")
		arg_3_0.nodeChange = tolua.cast(var_5_0:getChildByTag(2), "CCNode")
		arg_3_0.lbForma = tolua.cast(arg_3_0.nodeChange:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnChange = tolua.cast(arg_3_0.nodeChange:getChildByTag(3), "CCControlButton")
		arg_3_0.lbUsing = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLevelLimit = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		arg_3_0.btnChange:addHandleOfControlEvent(function()
			arg_3_0:onChange()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnChange:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnChange:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(160, 250))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_EquipFateItem.free(arg_7_0)
	return
end

function zbHeroDetailWnd_EquipFateItem.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.currHero = arg_8_1
	arg_8_0.record = arg_8_2

	if arg_8_2.growthPercent == 0 then
		arg_8_0.lbAtrr:setString(a2u(getItemPropStr(arg_8_2.fateAttr) .. "+" .. arg_8_2.growthValue))
	else
		arg_8_0.lbAtrr:setString(a2u(getItemPropStr(arg_8_2.fateAttr) .. "+" .. arg_8_2.growthPercent * 100 .. "%"))
	end

	arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_8_2.fateCondition[1])))

	local var_8_0 = zbItemTable:getRecord(arg_8_2.fateCondition[1])

	if var_8_0 then
		arg_8_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(var_8_0.quality)))

		local var_8_1, var_8_2 = zbColor:getItemColor(var_8_0.quality)

		arg_8_0.lbName:setString(var_8_0.name)
		arg_8_0.lbName:setColor(var_8_1)
	end

	arg_8_0.lbForma:setString(arg_8_2.changeGold)

	if arg_8_2.unlockLvl > arg_8_1.HeroBaseInfo.Level then
		arg_8_0.nodeChange:setVisible(false)
		arg_8_0.lbUsing:setVisible(false)
		arg_8_0.lbLevelLimit:setVisible(true)
		arg_8_0.lbLevelLimit:setString(a2u("\xBB\xEF\xB0\xE9\xB4ﵽ") .. arg_8_2.unlockLvl .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8"))
		arg_8_0.spriteBg:setGray(true)
	else
		arg_8_0.spriteBg:setGray(false)

		for iter_8_0, iter_8_1 in pairs(arg_8_1.FateEquipList) do
			if iter_8_1.EquipType == arg_8_2.fateType then
				if iter_8_1.FateId == arg_8_2.id then
					arg_8_0.nodeChange:setVisible(false)
					arg_8_0.lbUsing:setVisible(true)
					arg_8_0.lbLevelLimit:setVisible(false)

					break
				end

				arg_8_0.nodeChange:setVisible(true)
				arg_8_0.lbUsing:setVisible(false)
				arg_8_0.lbLevelLimit:setVisible(false)

				break
			end
		end
	end
end

function zbHeroDetailWnd_EquipFateItem.onChange(arg_9_0)
	if arg_9_0.record.unlockLvl > arg_9_0.currHero.HeroBaseInfo.Level then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return
	end

	local var_9_0 = tonumber(arg_9_0.lbForma:getString())

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_9_0) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.currHero.FateEquipList) do
		if iter_9_1.EquipType == arg_9_0.record.fateType then
			var_9_1 = iter_9_1.FateId
		end
	end

	local function var_9_2()
		g_WsMsgHandler:WS_Hero_ExchangeFate_Req(arg_9_0.currHero.HeroBaseInfo.TemplateId, var_9_1, arg_9_0.record.id)
	end

	g_MessageBox:showYesNo(a2u("ȷ\xC8ϻ\xA8\xB7\xD1") .. var_9_0 .. a2u("\xCC滻\xB5\xB1ǰ\xED\xC2\xF0"), var_9_2)
end
