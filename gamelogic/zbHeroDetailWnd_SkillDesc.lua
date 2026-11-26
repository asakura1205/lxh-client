zbHeroDetailWnd_SkillDesc = class("zbHeroDetailWnd_SkillDesc", CCNodeExtend)
zbHeroDetailWnd_SkillDesc.__index = zbHeroDetailWnd_SkillDesc

local var_0_0 = {}

var_0_0[1] = "\xC6չ\xA5"
var_0_0[2] = "\xD6\xF7\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[3] = "\xD7Զ\xAF\xBC\xBC\xC4\xDC"
var_0_0[4] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"
var_0_0[5] = "\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"

function zbHeroDetailWnd_SkillDesc.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_SkillDesc)

	return arg_1_0
end

function zbHeroDetailWnd_SkillDesc.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbHeroDetailWnd_SkillDesc.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbHeroDetailWnd_SkillDesc.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.node = arg_3_1
		arg_3_0.parent = arg_3_3
		arg_3_0.touchFlag = false
	end

	local function var_3_1()
		arg_3_0.layer = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")
		arg_3_0.spriteBg = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.skillDescLayer = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCLayer")
		arg_3_0.skillframe = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(1), "CCSprite")
		arg_3_0.skillIcon = tolua.cast(arg_3_0.skillframe:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbZiDong = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteLevel = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(5), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteUnActive = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(6), "CCSprite")
		arg_3_0.lbSkillTemp = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbSkillNum = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lbNeedLevel = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(10), "CCLabelTTF")
		arg_3_0.btnAddUp = tolua.cast(arg_3_0.skillDescLayer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnAddUp:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnAddUp:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnAddUp:addHandleOfControlEvent(function()
			arg_3_0:onUpgrade()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAddUp:addHandleOfControlEvent(function()
			arg_3_0:onUpgrade()
		end, CCControlEventTouchUpOutside)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)
		arg_3_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_skillbg0" .. arg_3_2 .. ".png"))
		arg_3_0.skillIcon:setMaskTexture(CCTextureCache:sharedTextureCache():addImage("image/icon/heroskill/heroskill_mask.jpg"))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_SkillDesc.getSkill(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_1.SkillList) do
		if arg_11_0.index == iter_11_1.Index then
			return iter_11_1
		end
	end
end

function zbHeroDetailWnd_SkillDesc.refresh(arg_12_0, arg_12_1)
	arg_12_0.hero = arg_12_1
	arg_12_0.skill = arg_12_0:getSkill(arg_12_0.hero)
	arg_12_0.currLevel = arg_12_0.skill.Level
	arg_12_0.skillLevel = arg_12_0.skill.Level
	arg_12_0.SkillId = arg_12_0.skill.SkillId

	if arg_12_0.skill.SkillId > 0 then
		arg_12_0.node:setVisible(true)

		arg_12_0.skillRecord = zbHeroSkillTable:getRecord(arg_12_0.skill.SkillId)

		if arg_12_0.skill.Level == 0 then
			arg_12_0.spriteUnActive:setVisible(true)
			arg_12_0.spriteLevel:setVisible(false)
			arg_12_0.spriteBg:setGray(true)

			local var_12_0 = zbHeroTable:getHeroSkillLockLevel(arg_12_0.hero.HeroBaseInfo.TemplateId, arg_12_0.index)

			if var_12_0 > arg_12_0.hero.HeroBaseInfo.Quality then
				arg_12_0.spriteUnActive:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_unactivity.png"))
				arg_12_0.btnAddUp:setVisible(false)
				arg_12_0.lbSkillNum:setVisible(false)
				arg_12_0.lbSkillTemp:setVisible(false)
				arg_12_0.lbNeedLevel:setVisible(true)

				exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(var_12_0)

				arg_12_0.lbNeedLevel:setString(a2u(zbColor:getItemColorDesc(exchQuality)) .. a2u("Ʒ\xD6ʽ\xE2\xCB\xF8"))

				if exchAdd ~= 0 then
					arg_12_0.lbNeedLevel:setString(a2u(zbColor:getItemColorDesc(exchQuality)) .. "+" .. exchAdd .. a2u("Ʒ\xD6ʽ\xE2\xCB\xF8"))
				end
			else
				arg_12_0.spriteUnActive:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_activity.png"))
				arg_12_0.btnAddUp:setVisible(true)
				arg_12_0.lbSkillNum:setVisible(true)
				arg_12_0.lbSkillTemp:setVisible(true)
				arg_12_0.lbNeedLevel:setVisible(false)
			end
		else
			arg_12_0.lbNeedLevel:setVisible(false)
			arg_12_0.spriteUnActive:setVisible(false)
			arg_12_0.spriteLevel:setVisible(true)
			arg_12_0.spriteBg:setGray(false)

			local var_12_1 = arg_12_0.hero.HeroBaseInfo.Level

			if var_12_1 <= arg_12_0.skill.Level then
				arg_12_0.btnAddUp:setVisible(false)
				arg_12_0.lbSkillNum:setVisible(false)
				arg_12_0.lbSkillTemp:setVisible(false)
				arg_12_0.lbNeedLevel:setVisible(true)
				arg_12_0.lbNeedLevel:setString(a2u("(\xD0\xE8Ҫ\xBB\xEF\xB0\xE9") .. var_12_1 + 1 .. a2u("\xBC\xB6)"))
			else
				arg_12_0.btnAddUp:setVisible(true)
				arg_12_0.lbSkillNum:setVisible(true)
				arg_12_0.lbSkillTemp:setVisible(true)
				arg_12_0.lbNeedLevel:setVisible(false)
			end
		end

		arg_12_0.skillIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getSkillIconPath(arg_12_0.SkillId)))
		arg_12_0.lbZiDong:setString(a2u(var_0_0[arg_12_0.index]))
		arg_12_0.lbName:setString(arg_12_0.skillRecord.name)
		arg_12_0.lbLevel:setString(arg_12_0.skill.Level)

		arg_12_0.needPoint = zbHeroSkillUpgradeTable:getHeroSkillLevelUpNeed(arg_12_0.skillRecord.upgradeId, arg_12_0.skill.Level)

		arg_12_0.lbSkillNum:setString(arg_12_0.needPoint)
	else
		arg_12_0.node:setVisible(false)
	end
end

function zbHeroDetailWnd_SkillDesc.onUpgrade(arg_13_0, arg_13_1)
	if arg_13_0.touchFlag == false then
		g_WsMsgHandler:WS_Hero_UpgradeSkill_Req(arg_13_0.hero.HeroBaseInfo.TemplateId, arg_13_0.index, arg_13_0.currLevel)
	end
end

function zbHeroDetailWnd_SkillDesc.onTouchDown(arg_14_0)
	local var_14_0 = zbItemTable:getRecord(2040201)
	local var_14_1 = g_Self.kBagItemHandler:getItemCountByTemplateId(2040201)

	arg_14_0.maxPoint = arg_14_0.hero.HeroSubInfo.SkillPoint + var_14_0.virtual * var_14_1

	if arg_14_0.maxPoint < arg_14_0.needPoint then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0鼼\xC4ܵ㲻\xD7\xE3"))

		arg_14_0.touchFlag = true

		return
	end

	if arg_14_0.skill.Level >= arg_14_0.hero.HeroBaseInfo.Level then
		arg_14_0.touchFlag = true

		g_Bubble:bubbleInfo(a2u("\xBC\xBC\xC4ܵȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xBB\xEF\xB0\xE9"))

		return
	end

	arg_14_0.currLevel = arg_14_0.skill.Level

	local var_14_2 = CCArray:create()

	var_14_2:addObject(CCDelayTime:create(0.5))
	var_14_2:addObject(CCCallFuncN:create(function()
		arg_14_0:onAddExp(var_14_0, var_14_1)
	end))

	local var_14_3 = CCSequence:create(var_14_2)

	arg_14_0:stopAllActions()
	arg_14_0:runAction(var_14_3)
end

function zbHeroDetailWnd_SkillDesc.onAddExp(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0
	local var_16_1 = 0

	local function var_16_2()
		arg_16_0.parent.layerTips.layer:setVisible(false)

		arg_16_0.currLevel = arg_16_0.currLevel + 1

		if arg_16_0.currLevel > arg_16_0.hero.HeroBaseInfo.Level then
			g_Bubble:bubbleInfo(a2u("\xBC\xBC\xC4ܵȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xBB\xEF\xB0\xE9"))

			arg_16_0.currLevel = arg_16_0.currLevel - 1

			arg_16_0.btnAddUp:stopAllActions()

			return
		end

		local var_17_0 = zbHeroSkillUpgradeTable:getHeroSkillNeedPoint(arg_16_0.skillRecord.upgradeId, arg_16_0.skill.Level, arg_16_0.currLevel)

		if var_17_0 > arg_16_0.maxPoint then
			g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0鼼\xC4ܵ㲻\xD7\xE3"))

			arg_16_0.currLevel = arg_16_0.currLevel - 1

			arg_16_0.btnAddUp:stopAllActions()

			return
		end

		arg_16_0.lbLevel:setString(arg_16_0.currLevel)

		arg_16_0.needPoint = zbHeroSkillUpgradeTable:getHeroSkillLevelUpNeed(arg_16_0.skillRecord.upgradeId, arg_16_0.currLevel)

		arg_16_0.lbSkillNum:setString(arg_16_0.needPoint)

		if g_MainScene.wndHeroDetail then
			if arg_16_0.hero.HeroSubInfo.SkillPoint - var_17_0 > 0 then
				g_MainScene.wndHeroDetail.module[EHeroDetailTab.Skill].lbHeroSkillPoint:setString(arg_16_0.hero.HeroSubInfo.SkillPoint - var_17_0)
			else
				local var_17_1 = math.ceil((var_17_0 - arg_16_0.hero.HeroSubInfo.SkillPoint) / 5)

				g_MainScene.wndHeroDetail.module[EHeroDetailTab.Skill].lbAddSkillPoint:setString(arg_16_1.virtual * (arg_16_2 - var_17_1))
				g_MainScene.wndHeroDetail.module[EHeroDetailTab.Skill].lbHeroSkillPoint:setString(var_17_1 * arg_16_1.virtual + arg_16_0.hero.HeroSubInfo.SkillPoint - var_17_0)
			end
		end
	end

	local var_16_3 = CCArray:create()

	var_16_3:addObject(CCScaleTo:create(0.05, 1.1))
	var_16_3:addObject(CCScaleTo:create(0.05, 1))
	var_16_3:addObject(CCCallFuncN:create(function()
		var_16_2()
	end))
	var_16_3:addObject(CCDelayTime:create(0.1))

	local var_16_4 = CCSequence:create(var_16_3)

	arg_16_0.btnAddUp:stopAllActions()
	arg_16_0.btnAddUp:runAction(CCRepeatForever:create(var_16_4))
end

function zbHeroDetailWnd_SkillDesc.onTouchEnd(arg_19_0)
	arg_19_0.touchFlag = false

	arg_19_0.btnAddUp:stopAllActions()
	arg_19_0.btnAddUp:setScale(1)
	arg_19_0:stopAllActions()
end

function zbHeroDetailWnd_SkillDesc.onTouch(arg_20_0)
	arg_20_0.parent.layerTips:refresh(arg_20_0.skillLevel, arg_20_0.skillRecord, arg_20_0.index)
end
