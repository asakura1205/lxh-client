HudType_Hp = 1
HudType_Mp = 2
HudType_Ms = 3
zbHeroHud = class("zbHeroHud", CCNodeExtend)
zbHeroHud.__index = zbHeroHud

function zbHeroHud.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroHud)

	return arg_1_0
end

function zbHeroHud.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroHud.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroHud.init(arg_3_0, arg_3_1)
	arg_3_0.hero = arg_3_1

	local var_3_0, var_3_1 = arg_3_0:createNode(HudType_Ms)

	arg_3_0.msBg = var_3_0
	arg_3_0.msFg = var_3_1

	arg_3_0.msBg:setVisible(false)
	arg_3_0.msFg:setVisible(false)

	local var_3_2, var_3_3 = arg_3_0:createNode(HudType_Hp)

	arg_3_0.hpBg = var_3_2
	arg_3_0.hpFg = var_3_3

	arg_3_0.hpBg:setVisible(false)
	arg_3_0.hpFg:setVisible(false)

	local var_3_4, var_3_5 = arg_3_0:createNode(HudType_Mp)

	arg_3_0.mpBg = var_3_4
	arg_3_0.mpFg = var_3_5

	arg_3_0.mpBg:setVisible(false)
	arg_3_0.mpFg:setVisible(false)
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setZOrder(ZORDER_TOP)
	arg_3_0.hero:addChild(arg_3_0)

	arg_3_0.lastHpPercent = 0
	arg_3_0.lastMpPercent = 0
	arg_3_0.lastMsPercent = 0
	arg_3_0.hpBgWidth = arg_3_0.hpBg:getContentSize().width
end

function zbHeroHud.createNode(arg_4_0, arg_4_1)
	local var_4_0 = ""
	local var_4_1 = ""
	local var_4_2 = 0

	if arg_4_1 == HudType_Hp then
		var_4_0 = "image/combat/battleui/progress_bg.png"
		var_4_1 = arg_4_0.hero.forceType == ForceType.Left and "image/combat/battleui/progress_green_pure.png" or "image/combat/battleui/progress_red_pure.png"
		var_4_2 = 0
	elseif arg_4_1 == HudType_Mp then
		var_4_0 = "image/combat/battleui/progress_bg.png"
		var_4_1 = "image/combat/battleui/progress_red_pure.png"
		var_4_2 = -12
	elseif arg_4_1 == HudType_Ms then
		var_4_0 = "image/combat/battleui/progress_bg.png"
		var_4_1 = "image/combat/battleui/progress_yellow_pure.png"
		var_4_2 = 18
	end

	local function var_4_3(arg_5_0, arg_5_1)
		local var_5_0 = CCSprite:create(arg_5_1)

		var_5_0:setAnchorPoint(ccp(0, 0))

		local var_5_1 = CCProgressTimer:create(var_5_0)

		var_5_1:setAnchorPoint(ccp(0, 0))
		var_5_1:setPercentage(100)
		var_5_1:setBarChangeRate(ccp(1, 0))
		var_5_1:setType(kCCProgressTimerTypeBar)
		var_5_1:retain()

		if arg_4_0.hero.forceType == ForceType.Left then
			var_5_1:setMidpoint(ccp(0, 1))
		else
			var_5_1:setMidpoint(ccp(1, 0))
		end

		return var_5_1
	end

	local var_4_4 = CCSprite:create(var_4_0)
	local var_4_5 = var_4_3(var_4_4, var_4_1)

	var_4_4:setAnchorPoint(ccp(0, 0))
	var_4_4:setPosition(0, var_4_2)
	var_4_4:addChild(var_4_5)
	arg_4_0:addChild(var_4_4)

	return var_4_4, var_4_5
end

function zbHeroHud.triggerVisible(arg_6_0)
	if arg_6_0.hero:isDie() then
		arg_6_0.hpBg:setVisible(false)
		arg_6_0.hpFg:setVisible(false)

		return
	end

	local function var_6_0()
		arg_6_0.hpBg:setVisible(false)
		arg_6_0.hpFg:setVisible(false)
	end

	local var_6_1 = CCArray:create()

	var_6_1:addObject(CCDelayTime:create(2))
	var_6_1:addObject(CCCallFuncN:create(var_6_0))

	local var_6_2 = CCSequence:create(var_6_1)

	arg_6_0:stopAllActions()
	arg_6_0:runAction(var_6_2)
	arg_6_0:update(0)
	arg_6_0.hpBg:setVisible(g_ShowHp)
	arg_6_0.hpFg:setVisible(g_ShowHp)
end

function zbHeroHud.update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.hero:getHpPercent()
	local var_8_1 = arg_8_0.hero:getMpPercent()
	local var_8_2 = arg_8_0.hero:getMsPercent()

	if arg_8_0.lastHpPercent ~= var_8_0 then
		arg_8_0.hpFg:runAction(CCProgressFromTo:create(0.2, arg_8_0.lastHpPercent, arg_8_0.hero:getHpPercent()))

		arg_8_0.lastHpPercent = var_8_0
	end

	if arg_8_0.lastMpPercent ~= var_8_1 then
		arg_8_0.mpFg:runAction(CCProgressFromTo:create(0.2, arg_8_0.lastMpPercent, arg_8_0.hero:getMpPercent()))

		arg_8_0.lastMpPercent = var_8_1
	end

	if arg_8_0.lastMsPercent ~= var_8_2 then
		arg_8_0.msFg:runAction(CCProgressFromTo:create(0.2, arg_8_0.lastMsPercent, arg_8_0.hero:getMsPercent()))

		arg_8_0.lastMsPercent = var_8_2
	end

	local var_8_3 = var_8_2 > 0

	arg_8_0.msBg:setVisible(var_8_3 and g_ShowHp)
	arg_8_0.msFg:setVisible(var_8_3 and g_ShowHp)
	arg_8_0:setPosition(-arg_8_0.hpBgWidth / 2, arg_8_0.hero:getHudHpHeight())

	if arg_8_0.hero.avatarRecord.parentAvatarId == 1082 then
		arg_8_0:setVisible(arg_8_0.hero.movingPos == false)
	end
end
