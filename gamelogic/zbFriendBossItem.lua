local var_0_0 = class("zbFriendBossItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createFriendBossItem(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0, arg_1_1)

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

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.mailInfo = nil
		arg_3_0.parentWnd = arg_3_2
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(100)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			var_6_1:setPosition(0, 0)
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteHeadBoss = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.spriteBossType = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLevelDummy = tolua.cast(var_5_2:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		local var_5_3 = tolua.cast(var_5_1:getChildByTag(2), "CCLayer")

		arg_3_0.spriteProgress = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.lbHPProcent = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")
		arg_3_0.progressHP = var_5_0(arg_3_0.spriteProgress, "image/world/boss/boss_progress.png")

		local var_5_4 = tolua.cast(var_5_1:getChildByTag(3), "CCLayer")

		arg_3_0.spriteHeadRole = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.lbRoleName = tolua.cast(var_5_4:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbRoleLevelDummy = tolua.cast(var_5_4:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbRoleLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbRoleLevelDummy, arg_3_0.lbRoleLevel)
		arg_3_0.lbRoleLevel:setScale(0.43)

		arg_3_0.lbTimeDummy = tolua.cast(var_5_1:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbNumberDummy = tolua.cast(var_5_1:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.btnDetail = tolua.cast(var_5_1:getChildByTag(7), "CCControlButton")
		arg_3_0.lbTime = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbTimeDummy, arg_3_0.lbTime)
		arg_3_0.lbTime:setScale(0.55)

		arg_3_0.lbRefreshTime = zbTimeLabel:create(arg_3_0.lbTime, "", "")
		arg_3_0.lbNumber = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumberDummy, arg_3_0.lbNumber)
		arg_3_0.lbNumber:setScale(0.55)
		arg_3_0.btnDetail:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnDetail:setSwallowsTouches(false)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(CCSizeMake(785, 105))
		arg_3_0.btnDetail:addHandleOfControlEvent(function()
			arg_3_0:onSelectedMail()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.bossInfo = arg_8_1

	arg_8_0.lbRoleName:setString(a2u(arg_8_1.RoleName))
	arg_8_0.lbRoleLevel:setString(a2u(arg_8_1.RoleLevel))

	local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.RoleHeadIcon)

	arg_8_0.spriteHeadRole:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	arg_8_0.spriteBossType:setVisible(arg_8_1.BossDegree == 2)

	local var_8_1 = zbHeroTable:getRecord(arg_8_1.BossTid)

	if var_8_1 then
		arg_8_0.lbName:setString(a2u(var_8_1.name))
	end

	local var_8_2 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.BossTid)

	arg_8_0.spriteHeadBoss:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_2))
	arg_8_0.lbLevel:setString(a2u(arg_8_1.Level))
	arg_8_0.lbHPProcent:setString(arg_8_1.HpPercent .. "%")
	arg_8_0.progressHP:setPercentage(math.min(arg_8_1.HpPercent, 99))
	arg_8_0.lbNumber:setString(arg_8_1.TotalFightCount - arg_8_1.FightCount .. "/" .. arg_8_1.TotalFightCount)
	arg_8_0.lbRefreshTime:start(arg_8_1.EndTm - g_Self.kTimeHandler:getServerTime())
end

function var_0_0.onSelectedMail(arg_9_0)
	g_MainScene:showFriendBossWnd(arg_9_0.bossInfo)
end
