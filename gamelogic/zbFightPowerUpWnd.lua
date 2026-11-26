require("gamelogic.zbBaseWnd")

zbFightPowerUpWnd = class("zbFightPowerUpWnd", zbBaseWnd)
zbFightPowerUpWnd.__index = zbFightPowerUpWnd

function zbFightPowerUpWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFightPowerUpWnd)

	return arg_1_0
end

function createFightPowerUpWnd()
	local var_2_0 = zbFightPowerUpWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbFightPowerUpWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.initPos = nil
		arg_3_0.maxPower = 0
		arg_3_0.curPower = 0
		arg_3_0.step = 1
		arg_3_0.gotoEnd = true
		arg_3_0.isMainLayer = true
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/fightpower_up.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCLayer")

		arg_3_0.layerPower = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.lbPower = tolua.cast(arg_3_0.layerPower:getChildByTag(1), "CCLabelTTF")
		arg_3_0.initPos = ccp(arg_3_0.layerPower:getPosition())

		arg_3_0.lbPower:setVisible(false)

		arg_3_0.lbPowerAtl = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		arg_3_0.lbPowerAtl:setPosition(arg_3_0.lbPower:getPosition())
		arg_3_0.lbPowerAtl:setAnchorPoint(ccp(0, 0.5))
		arg_3_0.lbPowerAtl:setScale(0.95)
		arg_3_0.layerPower:addChild(arg_3_0.lbPowerAtl)
		arg_3_0:setZOrder(ZORDER_TOP)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
end

function zbFightPowerUpWnd.refresh(arg_6_0)
	arg_6_0.gotoEnd = true
	arg_6_0.maxPower = g_Self:getFightValue()

	if arg_6_0.curPower == 0 then
		arg_6_0.curPower = g_Self.initFightPower
	end

	if arg_6_0.curPower >= arg_6_0.maxPower then
		arg_6_0.curPower = arg_6_0.maxPower

		arg_6_0:hide()

		return
	end

	arg_6_0.lbPowerAtl:setString(arg_6_0.curPower)
	arg_6_0.layerPower:setPosition(arg_6_0.initPos.x, arg_6_0.initPos.y + 120)

	local var_6_0 = CCArray:create()

	var_6_0:addObject(CCMoveTo:create(0.15, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y + 90)))
	var_6_0:addObject(CCMoveTo:create(0.12, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y + 70)))
	var_6_0:addObject(CCMoveTo:create(0.1, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y + 40)))
	var_6_0:addObject(CCMoveTo:create(0.08, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y - 40)))
	var_6_0:addObject(CCMoveTo:create(0.1, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y - 20)))
	var_6_0:addObject(CCDelayTime:create(0.2))
	var_6_0:addObject(CCCallFuncN:create(function()
		arg_6_0:doShowPower()
	end))

	local var_6_1 = CCSequence:create(var_6_0)

	arg_6_0.layerPower:stopAllActions()
	arg_6_0.layerPower:runAction(var_6_1)
end

function zbFightPowerUpWnd.doShowPower(arg_8_0)
	arg_8_0.step = math.ceil((arg_8_0.maxPower - arg_8_0.curPower) * 0.025)

	if arg_8_0.step < 1 then
		arg_8_0.step = 1
	end

	arg_8_0.gotoEnd = false
end

function zbFightPowerUpWnd.onFrameUpdate(arg_9_0, arg_9_1)
	if arg_9_0.gotoEnd then
		return
	end

	if arg_9_0.curPower ~= arg_9_0.maxPower then
		arg_9_0.curPower = arg_9_0.curPower + arg_9_0.step

		if arg_9_0.curPower >= arg_9_0.maxPower then
			arg_9_0.curPower = arg_9_0.maxPower
		end

		arg_9_0.lbPowerAtl:setString(arg_9_0.curPower)
	else
		arg_9_0.gotoEnd = true

		local var_9_0 = CCArray:create()

		var_9_0:addObject(CCDelayTime:create(0.6))
		var_9_0:addObject(CCMoveTo:create(0.15, ccp(arg_9_0.initPos.x, arg_9_0.initPos.y - 50)))
		var_9_0:addObject(CCMoveTo:create(0.12, ccp(arg_9_0.initPos.x, arg_9_0.initPos.y - 10)))
		var_9_0:addObject(CCMoveTo:create(0.1, ccp(arg_9_0.initPos.x, arg_9_0.initPos.y + 40)))
		var_9_0:addObject(CCMoveTo:create(0.05, ccp(arg_9_0.initPos.x, arg_9_0.initPos.y + 100)))
		var_9_0:addObject(CCCallFuncN:create(function()
			arg_9_0:hide()
		end))

		local var_9_1 = CCSequence:create(var_9_0)

		arg_9_0.layerPower:stopAllActions()
		arg_9_0.layerPower:runAction(var_9_1)
	end
end
