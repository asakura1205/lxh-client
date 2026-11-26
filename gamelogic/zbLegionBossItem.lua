require("gamebase.zbFunctions")

zbLegionBossItem = class("zbLegionBossItem", CCNodeExtend)
zbLegionBossItem.__index = zbLegionBossItem

function zbLegionBossItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionBossItem)

	return arg_1_0
end

function zbLegionBossItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbLegionBossItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbLegionBossItem.init(arg_3_0, arg_3_1)
	function initMember()
		arg_3_0.data = nil
		arg_3_0.lefttime = 0
		arg_3_0.lastTime = os_timenow()
	end

	function initCCB()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.layerContent = var_5_0
		arg_3_0.spriteSel = tolua.cast(var_5_0:getChildByTag(100), "CCSprite")
		arg_3_0.spriteBoss = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spritePass = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.nodeProgress = tolua.cast(var_5_0:getChildByTag(3), "CCNode")
		arg_3_0.spriteProgressBg = tolua.cast(arg_3_0.nodeProgress:getChildByTag(3), "CCSprite")
		arg_3_0.lbProgress = tolua.cast(arg_3_0.nodeProgress:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)

		local function var_5_1(arg_7_0, arg_7_1)
			local var_7_0 = CCSprite:create(arg_7_1)

			var_7_0:setAnchorPoint(ccp(0, 0))

			local var_7_1 = CCProgressTimer:create(var_7_0)

			var_7_1:setAnchorPoint(ccp(0, 0))
			var_7_1:setMidpoint(ccp(0, 1))
			var_7_1:setBarChangeRate(ccp(1, 0))
			var_7_1:setType(kCCProgressTimerTypeBar)
			var_7_1:retain()
			arg_7_0:addChild(var_7_1)

			return var_7_1
		end

		arg_3_0.spriteProgress = var_5_1(arg_3_0.spriteProgressBg, "image/legion/boss/boss_progress.png")
		arg_3_0.notifyGet = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")

		zbUIEffect:createNotifyTagScaleAction(arg_3_0.notifyGet)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	initMember()
	initCCB()
end

function zbLegionBossItem.refresh(arg_8_0, arg_8_1)
	arg_8_0.data = arg_8_1

	arg_8_0.notifyGet:setVisible(false)

	if arg_8_1 then
		local var_8_0 = zbLegionBossTable:getRecord(arg_8_1.BossId)
		local var_8_1 = var_8_0.icon

		if var_8_0 and arg_8_1.State ~= ELegionBossState.Locked then
			arg_8_0.spriteBoss:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))
		else
			local var_8_2 = "image/legion/boss/boss_0.png"

			arg_8_0.spriteBoss:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_2))
		end

		arg_8_0.nodeProgress:setVisible(arg_8_1.State == ELegionBossState.Fighting)
		arg_8_0.spriteProgress:setPercentage(math.max(0, math.min(100, arg_8_1.LeftHp)))

		local var_8_3 = string.format("%.3f", math.max(0, math.min(100, arg_8_1.LeftHp))) .. "%"

		arg_8_0.lbProgress:setString(var_8_3)
		arg_8_0.spritePass:setVisible(arg_8_1.State == ELegionBossState.PassNotGetAward or arg_8_1.State == ELegionBossState.PassHasGetAward)
		arg_8_0.notifyGet:setVisible(arg_8_1.State == ELegionBossState.PassNotGetAward)
	end
end

function zbLegionBossItem.onTouch(arg_9_0)
	if arg_9_0.data and arg_9_0.data.State ~= ELegionBossState.Locked and g_MainScene.wndLegionBoss then
		g_MainScene.wndLegionBoss.curBoss = arg_9_0.data

		g_MainScene.wndLegionBoss:setSelBoss()
		g_MainScene.wndLegionBoss:refreshAward()
	end
end

function zbLegionBossItem.setCurSel(arg_10_0, arg_10_1)
	arg_10_0.spriteSel:setVisible(arg_10_0.data and arg_10_0.data.BossId == arg_10_1)
end
