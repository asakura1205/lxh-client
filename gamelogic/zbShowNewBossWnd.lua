require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowNewBossWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowNewBossWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lastSection = 0
		arg_3_0.lastRound = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/show_newboss.ccbi", var_5_0, true, "")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteAvatar = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteType = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.lbLocation = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.skillframe = tolua.cast(var_5_2:getChildByTag(6), "CCSprite")
		arg_3_0.spriteSkill = tolua.cast(arg_3_0.skillframe:getChildByTag(1), "CCSprite")
		arg_3_0.lbSkill = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbSkillDesc = tolua.cast(var_5_2:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lbNotice = tolua.cast(var_5_2:getChildByTag(9), "CCLabelTTF")

		arg_3_0.spriteSkill:setMaskTexture(MASK_NOMRML_TEX)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.onShow(arg_9_0)
	g_CombatSystem:pause()
	g_MainScene.wndCombat:hideUI()
end

function var_0_0.onHide(arg_10_0)
	g_MainScene:roundCombatTalk(arg_10_0.lastSection, arg_10_0.lastRound)
end

function var_0_0.refresh(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.lastSection = arg_11_2
	arg_11_0.lastRound = arg_11_3

	local var_11_0 = zbHeroTable:getRecord(arg_11_1)

	if var_11_0 == nil then
		arg_11_0:hide()

		return
	end

	local var_11_1 = zbIconHelper:getHeroCardIconPath(arg_11_1)

	arg_11_0.spriteAvatar:setTexture(CCTextureCache:sharedTextureCache():addImage(var_11_1))
	arg_11_0.lbName:setString(var_11_0.name)
	arg_11_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_11_0.rarity .. ".png"))
	arg_11_0.lbLocation:setString(var_11_0.description0)
	arg_11_0.lbDesc:setString(var_11_0.description)

	local var_11_2 = zbIconHelper:getSkillIconPath(var_11_0.skillId1)

	arg_11_0.spriteSkill:setTexture(CCTextureCache:sharedTextureCache():addImage(var_11_2))

	local var_11_3 = zbHeroSkillTable:getRecord(var_11_0.skillId1)

	if var_11_3 ~= nil then
		arg_11_0.lbSkill:setString(var_11_3.name)
		arg_11_0.lbSkillDesc:setString(var_11_3.descBase)
	end

	arg_11_0:playEffect(var_11_0)
	arg_11_0:playFadeNode()
end

function var_0_0.playEffect(arg_12_0, arg_12_1)
	local function var_12_0()
		if arg_12_1.avatarId then
			local var_13_0 = zbAvatarTable:getAvatarSoundPath(arg_12_1.avatarId, ESoundType.E_PROVOKE)

			g_Audio:playSound(var_13_0)
		end
	end

	local var_12_1 = CCScaleTo:create(0.15, 1.3)
	local var_12_2 = CCScaleTo:create(0.15, 0.8)
	local var_12_3 = CCScaleTo:create(0.3, 1.2)
	local var_12_4 = CCScaleTo:create(0.2, 0.9)
	local var_12_5 = CCCallFuncN:create(var_12_0)
	local var_12_6 = CCArray:create()

	var_12_6:addObject(var_12_1)
	var_12_6:addObject(var_12_2)
	var_12_6:addObject(var_12_5)
	var_12_6:addObject(var_12_3)
	var_12_6:addObject(var_12_4)
	var_12_6:addObject(CCDelayTime:create(1))

	local var_12_7 = CCSequence:create(var_12_6)

	arg_12_0.spriteAvatar:stopAllActions()
	arg_12_0.spriteAvatar:runAction(var_12_7)
end

function var_0_0.playFadeNode(arg_14_0)
	local var_14_0 = 0.4

	local function var_14_1(arg_15_0, arg_15_1)
		local function var_15_0(arg_16_0)
			arg_16_0:setVisible(true)
		end

		local var_15_1 = CCArray:create()

		var_15_1:addObject(CCDelayTime:create(var_14_0))
		var_15_1:addObject(CCCallFuncN:create(var_15_0))
		arg_15_0:setVisible(false)
		arg_15_0:stopAllActions()
		arg_15_0:runAction(CCSequence:create(var_15_1))

		var_14_0 = var_14_0 + arg_15_1
	end

	var_14_1(arg_14_0.lbName, 0)
	var_14_1(arg_14_0.spriteType, 0)
	var_14_1(arg_14_0.lbLocation, 0.4)
	var_14_1(arg_14_0.lbDesc, 0)
	var_14_1(arg_14_0.skillframe, 0)
	var_14_1(arg_14_0.spriteSkill, 0)
	var_14_1(arg_14_0.lbSkill, 0)
	var_14_1(arg_14_0.lbSkillDesc, 0.4)
	var_14_1(arg_14_0.lbNotice, 0)
end

function var_0_0.onTouchTest(arg_17_0)
	if arg_17_0.lbNotice:isVisible() == false then
		return
	end

	if arg_17_0.spriteAvatar:numberOfRunningActions() > 0 then
		return
	end

	arg_17_0:hide()
end
