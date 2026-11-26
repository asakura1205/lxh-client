require("gamelogic.zbItem")

zbDamageStatItem = class("zbDamageStatItem")
zbDamageStatItem.__index = zbDamageStatItem

function zbDamageStatItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbDamageStatItem)

	return arg_1_0
end

function zbDamageStatItem.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbDamageStatItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbDamageStatItem.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local function var_3_0()
		arg_3_0.headDummy = nil
		arg_3_0.maxDamage = 0
		arg_3_0.myDamage = 0
		arg_3_0.progressDamage = 0
		arg_3_0.progressTime = 0
		arg_3_0.dir = arg_3_2
		arg_3_0.index = arg_3_3
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.spriteProgress = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbDamageDummy = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbDamage = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbDamageDummy, arg_3_0.lbDamage)
		arg_3_0.lbDamage:setScale(0.55)

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(3), "CCLayerColor")
		local var_5_2 = createItem()

		var_5_2:setPosition(var_5_1:getPosition())
		var_5_2:setNeedTip(false)
		var_5_2:setScale(0.8)

		arg_3_0.headDummy = var_5_2

		var_5_0:addChild(arg_3_0.headDummy)
		var_5_1:removeFromParentAndCleanup(true)
		arg_3_0:addChild(arg_3_1)

		arg_3_0.initProgressX = arg_3_0.spriteProgress:getPositionX()
		arg_3_0.initProgressWidth = arg_3_0.spriteProgress:getContentSize().width
	end

	var_3_0()
	var_3_1()
	arg_3_0:scheduleUpdateWithPriorityLua(function()
		arg_3_0:onUpdate()
	end, 0)
end

function zbDamageStatItem.refresh(arg_7_0)
	local var_7_0 = g_CombatSystem:getHero(arg_7_0.dir, arg_7_0.index)

	if var_7_0 == nil then
		arg_7_0:setVisible(false)

		return
	end

	arg_7_0.headDummy:refreshBalanceHero(var_7_0)

	arg_7_0.maxDamage = arg_7_0:getMaxDamageOut()
	arg_7_0.myDamage = var_7_0:getDamageStat()
	arg_7_0.progressDamage = 0
	arg_7_0.progressTime = os_timenow()

	arg_7_0:setVisible(true)
end

function zbDamageStatItem.onUpdate(arg_8_0)
	if arg_8_0:isVisible() == false then
		return
	end

	if arg_8_0.myDamage == 0 then
		arg_8_0.lbDamage:setString("0")
		arg_8_0.spriteProgress:setScaleX(0)

		return
	end

	if arg_8_0.maxDamage <= 0 then
		return
	end

	if arg_8_0.progressDamage >= arg_8_0.myDamage then
		return
	end

	local var_8_0 = 1.3 * (arg_8_0.myDamage / arg_8_0.maxDamage)
	local var_8_1 = (os_timenow() - arg_8_0.progressTime) / var_8_0
	local var_8_2 = math.ceil(math.min(arg_8_0.myDamage * var_8_1, arg_8_0.myDamage))
	local var_8_3 = var_8_2 / arg_8_0.maxDamage
	local var_8_4 = zbUtil:foramatCurrency(var_8_2)

	arg_8_0.lbDamage:setString(var_8_4)
	arg_8_0.spriteProgress:setScaleX(var_8_3)

	arg_8_0.progressDamage = var_8_2
end

function zbDamageStatItem.getMaxDamageOut(arg_9_0)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs(g_CombatSystem.combatData.leftPlayer.heros) do
		var_9_0 = math.max(var_9_0, iter_9_1:getDamageStat())
	end

	for iter_9_2, iter_9_3 in pairs(g_CombatSystem.combatData.rightPlayer.heros) do
		var_9_0 = math.max(var_9_0, iter_9_3:getDamageStat())
	end

	return var_9_0
end

function zbDamageStatItem.getTotalDamageOut(arg_10_0)
	if arg_10_0.dir == ForceType.Left then
		return g_CombatSystem.combatData.leftPlayer:getTotalDamageOut()
	elseif arg_10_0.dir == ForceType.Right then
		return g_CombatSystem.combatData.rightPlayer:getTotalDamageOut()
	else
		return 0
	end
end
