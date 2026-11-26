ECombatBubble = {
	MagicDefendUp = 20,
	EnemyViolentAddHp = 7,
	EnemyAddHp = 5,
	PhysicMagicDefendUp = 24,
	MagicAttackDown = 19,
	ViolentUp = 30,
	PhysicDefendUp = 16,
	EnemyViolentDecHp = 8,
	PierceDown = 37,
	PhysicDamageDown = 59,
	PhysicMagicAttackDown = 23,
	HitUp = 26,
	Unknown = 0,
	ResistUp = 34,
	CtrlChaofeng = 12,
	MpUp = 46,
	Redo = 57,
	ToughUp = 32,
	PhysicAttackUp = 14,
	MaxHpUp = 40,
	BlockUp = 38,
	SelfAddHp = 1,
	Unhit = 42,
	SelfViolentAddHp = 3,
	ZhuanYi = 52,
	ImmuneMagic = 44,
	CtrlMeihuo = 10,
	SelfViolentDecHp = 4,
	KillMpBack = 48,
	ToughDown = 33,
	EnemyDecHp = 6,
	XiShou = 51,
	ImmunePhysic = 43,
	PhysicMagicDefendDown = 25,
	MagicDamageDown = 61,
	JianMian = 54,
	DodgeUp = 28,
	MagicAttackUp = 18,
	Relived = 50,
	ZhongDu = 55,
	MagicDefendDown = 21,
	PhysicAttackDown = 15,
	HitDown = 27,
	ImmuneAll = 45,
	SelfDecHp = 2,
	CtrlChenmo = 11,
	Focus = 56,
	BlockDown = 39,
	ViolentDown = 31,
	PhysicDamageUp = 58,
	CtrlZhongshang = 13,
	MaxHpDown = 41,
	MagicDamageUp = 60,
	ResistDown = 35,
	MpDown = 47,
	FanTan = 53,
	PhysicMagicDamageUp = 62,
	PhysicMagicAttackUp = 22,
	Died = 49,
	DodgeDown = 29,
	PhysicMagicDamageDown = 63,
	PhysicDefendDown = 17,
	PierceUp = 36,
	CtrlHunmi = 9
}
ECombatBubbleTex = {
	"image/combat/bubble/self_pj_green.png",
	"image/combat/bubble/self_pj_red.png",
	"image/combat/bubble/self_bj_green.png",
	"image/combat/bubble/self_bj_red.png",
	"image/combat/bubble/self_pj_green.png",
	"image/combat/bubble/enemy_pj_orange.png",
	"image/combat/bubble/self_bj_green.png",
	"image/combat/bubble/enemy_bj_orange.png",
	"image/combat/bubble/ctrl_hunmi.png",
	"image/combat/bubble/ctrl_meihuo.png",
	"image/combat/bubble/ctrl_chenmo.png",
	"image/combat/bubble/ctrl_chaofeng.png",
	"image/combat/bubble/buff_zhongshang.png",
	"image/combat/bubble/attack_up_physic.png",
	"image/combat/bubble/attack_down_physic.png",
	"image/combat/bubble/defend_up_physic.png",
	"image/combat/bubble/defend_down_physic.png",
	"image/combat/bubble/attack_up_magic.png",
	"image/combat/bubble/attack_down_magic.png",
	"image/combat/bubble/defend_up_magic.png",
	"image/combat/bubble/defend_down_magic.png",
	"image/combat/bubble/attack_up.png",
	"image/combat/bubble/attack_down.png",
	"image/combat/bubble/defend_up.png",
	"image/combat/bubble/defend_down.png",
	"image/combat/bubble/hit_up.png",
	"image/combat/bubble/hit_down.png",
	"image/combat/bubble/dodge_up.png",
	"image/combat/bubble/dodge_down.png",
	"image/combat/bubble/violent_up.png",
	"image/combat/bubble/violent_down.png",
	"image/combat/bubble/tough_up.png",
	"image/combat/bubble/tough_down.png",
	"image/combat/bubble/resist_up.png",
	"image/combat/bubble/resist_down.png",
	"image/combat/bubble/pierce_up.png",
	"image/combat/bubble/pierce_down.png",
	"image/combat/bubble/block_up.png",
	"image/combat/bubble/block_down.png",
	"image/combat/bubble/maxhpup.png",
	"image/combat/bubble/maxhpdown.png",
	"image/combat/bubble/unhit.png",
	"image/combat/bubble/immune_physic.png",
	"image/combat/bubble/immune_magic.png",
	"image/combat/bubble/immune_all.png",
	"image/combat/bubble/mp_up.png",
	"image/combat/bubble/mp_down.png",
	"image/combat/bubble/killmpback.png",
	"image/combat/bubble/died.png",
	"image/combat/bubble/relived.png",
	"image/combat/bubble/xishou.png",
	"image/combat/bubble/zhuanyi.png",
	"image/combat/bubble/fantan.png",
	"image/combat/bubble/jianmian.png",
	"image/combat/bubble/buff_zhongdu.png",
	"image/combat/bubble/focus.png",
	"image/combat/bubble/redo.png",
	"image/combat/bubble/damage_up_physic.png",
	"image/combat/bubble/damage_down_physic.png",
	"image/combat/bubble/damage_up_magic.png",
	"image/combat/bubble/damage_down_magic.png",
	"image/combat/bubble/damage_up.png",
	"image/combat/bubble/damage_down.png"
}
zbCombatBubble = class("zbCombatBubble")
zbCombatBubble.__index = zbCombatBubble

function zbCombatBubble.create(arg_1_0)
	local var_1_0 = zbCombatBubble.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatBubble.init(arg_2_0)
	arg_2_0.bubbleLayer = CCNode:create()

	arg_2_0.bubbleLayer:setPosition(0, 0)
	arg_2_0.bubbleLayer:setAnchorPoint(ccp(0, 0))
	arg_2_0.bubbleLayer:retain()

	arg_2_0.numOffsetRandomRangeX = 0
end

function zbCombatBubble.free(arg_3_0)
	arg_3_0.bubbleLayer:removeAllChildrenWithCleanup(true)
end

function zbCombatBubble.clear(arg_4_0)
	arg_4_0.bubbleLayer:removeAllChildrenWithCleanup(true)
end

function zbCombatBubble.updateHeroTextBubblePos(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1.bubbleNodes) do
		if arg_5_1.avatarRecord.parentAvatarId == 1082 then
			iter_5_1.nodeBubble:setPosition(arg_5_1:getFixPositionX() + iter_5_1.offsetX, arg_5_1:getPositionY() + iter_5_1.offsetY)
		else
			iter_5_1.nodeBubble:setPosition(arg_5_1:getPositionX() + iter_5_1.offsetX, arg_5_1:getPositionY() + iter_5_1.offsetY)
		end
	end
end

function zbCombatBubble.update(arg_6_0, arg_6_1)
	local var_6_0 = g_CombatSystem:getHerosNoLocal(ForceType.Left)

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		arg_6_0:updateHeroTextBubblePos(iter_6_1)
	end

	local var_6_1 = g_CombatSystem:getHerosNoLocal(ForceType.Right)

	for iter_6_2, iter_6_3 in pairs(var_6_1) do
		arg_6_0:updateHeroTextBubblePos(iter_6_3)
	end

	arg_6_0:setNumOffsetRandomRangeX(0)
end

function zbCombatBubble.showBubble(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	if g_ShowBubble == false then
		return
	end

	local var_7_0 = CCTextureCache:sharedTextureCache():addImage(ECombatBubbleTex[arg_7_2])
	local var_7_1 = ECombatBubbleTex[arg_7_2]

	if var_7_0 == nil or var_7_1 == nil then
		return
	end

	if arg_7_2 == ECombatBubble.SelfAddHp or arg_7_2 == ECombatBubble.SelfDecHp or arg_7_2 == ECombatBubble.EnemyAddHp or arg_7_2 == ECombatBubble.EnemyDecHp then
		arg_7_0:showNumBubble(arg_7_1, var_7_0, var_7_1, arg_7_3, arg_7_4)
	elseif arg_7_2 == ECombatBubble.SelfViolentAddHp or arg_7_2 == ECombatBubble.SelfViolentDecHp or arg_7_2 == ECombatBubble.EnemyViolentAddHp or arg_7_2 == ECombatBubble.EnemyViolentDecHp then
		arg_7_0:showViolentBubble(arg_7_1, var_7_0, var_7_1, arg_7_3, arg_7_4, arg_7_2)
	else
		arg_7_0:showTextBubble(arg_7_1, arg_7_2, var_7_1, arg_7_4, arg_7_5)
	end
end

function zbCombatBubble.getNumTexSize(arg_8_0, arg_8_1)
	if arg_8_1 == "image/combat/bubble/self_pj_green.png" or arg_8_1 == "image/combat/bubble/self_pj_green.png" or arg_8_1 == "image/combat/bubble/enemy_pj_blue.png" or arg_8_1 == "image/combat/bubble/enemy_pj_orange.png" then
		return 300, 32
	elseif arg_8_1 == "image/combat/bubble/self_bj_green.png" or arg_8_1 == "image/combat/bubble/self_bj_red.png" or arg_8_1 == "image/combat/bubble/enemy_bj_blue.png" or arg_8_1 == "image/combat/bubble/enemy_bj_orange.png" then
		return 390, 42
	end

	return 300, 32
end

function zbCombatBubble.getVolientTexPath(arg_9_0, arg_9_1)
	local var_9_0 = ""

	if arg_9_1 == ECombatBubble.SelfViolentAddHp then
		var_9_0 = "image/combat/bubble/bj_selfaddhp.png"
	elseif arg_9_1 == ECombatBubble.SelfViolentDecHp then
		var_9_0 = "image/combat/bubble/bj_selfdechp.png"
	elseif arg_9_1 == ECombatBubble.EnemyViolentAddHp then
		var_9_0 = "image/combat/bubble/bj_enemyaddhp.png"
	elseif arg_9_1 == ECombatBubble.EnemyViolentDecHp then
		var_9_0 = "image/combat/bubble/bj_enemydechp.png"
	end

	return var_9_0
end

function zbCombatBubble.showNumBubble(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = tostring(arg_10_4)

	if arg_10_4 > 0 then
		var_10_0 = "+" .. var_10_0
	end

	local var_10_1, var_10_2 = arg_10_0:getNumTexSize(arg_10_3)
	local var_10_3 = CCLabelAtlas:create(var_10_0, arg_10_3, var_10_1 / 15, var_10_2, string.byte("+"))
	local var_10_4 = ccp(arg_10_1:getPosition())

	var_10_4.y = var_10_4.y + arg_10_1:getCombatBubbleNumHeight()

	if arg_10_0.numOffsetRandomRangeX > 0 then
		var_10_4.x = math.random(var_10_4.x - arg_10_0.numOffsetRandomRangeX, var_10_4.x + arg_10_0.numOffsetRandomRangeX)
	end

	var_10_3:setAnchorPoint(ccp(0.5, 0))
	var_10_3:setPosition(var_10_4)
	var_10_3:setCascadeOpacityEnabled(true)
	var_10_3:setOpacity(0)
	arg_10_0.bubbleLayer:addChild(var_10_3)

	local var_10_5 = CCArray:create()

	var_10_5:addObject(CCFadeIn:create(0.125))
	var_10_5:addObject(CCMoveTo:create(0.6, ccp(var_10_4.x, var_10_4.y + 70)))

	local var_10_6 = CCSpawn:create(var_10_5)
	local var_10_7 = CCArray:create()

	var_10_7:addObject(CCMoveTo:create(0.25, ccp(var_10_4.x, var_10_4.y + 90)))
	var_10_7:addObject(CCFadeOut:create(0.2))

	local var_10_8 = CCSpawn:create(var_10_7)
	local var_10_9 = CCArray:create()

	var_10_9:addObject(CCDelayTime:create(arg_10_5))
	var_10_9:addObject(var_10_6)
	var_10_9:addObject(var_10_8)
	var_10_9:addObject(CCCallFuncN:create(handler(arg_10_0, arg_10_0.removeBubble)))
	var_10_3:stopAllActions()
	var_10_3:runAction(CCSequence:create(var_10_9))
end

function zbCombatBubble.showTextAndNumBubble(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = tostring(arg_11_4)

	if arg_11_4 > 0 then
		var_11_0 = "+" .. var_11_0
	end

	local var_11_1, var_11_2 = arg_11_0:getNumTexSize(arg_11_3)
	local var_11_3 = CCNodeRGBA:create()
	local var_11_4 = CCSprite:create(arg_11_2)
	local var_11_5 = CCLabelAtlas:create(var_11_0, arg_11_3, var_11_1 / 15, var_11_2, string.byte("+"))
	local var_11_6 = 3
	local var_11_7 = var_11_4:getContentSize().width + var_11_6 + var_11_5:getContentSize().width

	var_11_4:setAnchorPoint(ccp(0, 0))
	var_11_4:setPosition(0, 0)
	var_11_5:setAnchorPoint(ccp(0, 0))
	var_11_5:setPosition(var_11_4:getContentSize().width + var_11_6, 0)
	var_11_3:addChild(var_11_4)
	var_11_3:addChild(var_11_5)

	arg_11_1.x = arg_11_1.x - var_11_7 / 2

	var_11_3:setAnchorPoint(ccp(0.5, 0))
	var_11_3:setPosition(arg_11_1)
	var_11_3:setCascadeOpacityEnabled(true)
	var_11_3:setOpacity(0)
	arg_11_0.bubbleLayer:addChild(var_11_3)

	local var_11_8 = CCArray:create()

	var_11_8:addObject(CCFadeIn:create(0.125))
	var_11_8:addObject(CCMoveTo:create(0.6, ccp(arg_11_1.x, arg_11_1.y + 70)))

	local var_11_9 = CCSpawn:create(var_11_8)
	local var_11_10 = CCArray:create()

	var_11_10:addObject(CCMoveTo:create(0.25, ccp(arg_11_1.x, arg_11_1.y + 90)))
	var_11_10:addObject(CCFadeOut:create(0.2))

	local var_11_11 = CCSpawn:create(var_11_10)
	local var_11_12 = CCArray:create()

	var_11_12:addObject(CCDelayTime:create(arg_11_5))
	var_11_12:addObject(var_11_9)
	var_11_12:addObject(var_11_11)
	var_11_12:addObject(CCCallFuncN:create(handler(arg_11_0, arg_11_0.removeBubble)))
	var_11_3:stopAllActions()
	var_11_3:runAction(CCSequence:create(var_11_12))
end

function zbCombatBubble.showTextAndViolentNumBubble(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = tostring(arg_12_4)

	if arg_12_4 > 0 then
		var_12_0 = "+" .. var_12_0
	end

	local var_12_1, var_12_2 = arg_12_0:getNumTexSize(arg_12_3)
	local var_12_3 = CCNodeRGBA:create()
	local var_12_4 = CCSprite:create(arg_12_2)
	local var_12_5 = CCLabelAtlas:create(var_12_0, arg_12_3, var_12_1 / 15, var_12_2, string.byte("+"))
	local var_12_6 = 3
	local var_12_7 = var_12_4:getContentSize().width + var_12_6 + var_12_5:getContentSize().width

	var_12_4:setAnchorPoint(ccp(0, 0))
	var_12_4:setPosition(0 - var_12_7 / 2, 0)
	var_12_5:setAnchorPoint(ccp(0, 0))
	var_12_5:setPosition(var_12_4:getContentSize().width + var_12_6 - var_12_7 / 2, 0)
	var_12_3:addChild(var_12_4)
	var_12_3:addChild(var_12_5)
	var_12_3:setAnchorPoint(ccp(0.5, 0.5))
	var_12_3:setPosition(arg_12_1.x, arg_12_1.y)
	var_12_3:setCascadeOpacityEnabled(true)
	var_12_3:setOpacity(0)
	var_12_3:setScale(0)
	arg_12_0.bubbleLayer:addChild(var_12_3)

	local var_12_8 = CCArray:create()

	var_12_8:addObject(CCFadeIn:create(0.1))
	var_12_8:addObject(CCScaleTo:create(0.1, 1))

	local var_12_9 = CCSpawn:create(var_12_8)
	local var_12_10 = CCArray:create()

	var_12_10:addObject(CCMoveTo:create(0.125, ccp(arg_12_1.x, arg_12_1.y + 90)))
	var_12_10:addObject(CCFadeOut:create(0.125))

	local var_12_11 = CCSpawn:create(var_12_10)
	local var_12_12 = CCArray:create()

	var_12_12:addObject(CCDelayTime:create(arg_12_5))
	var_12_12:addObject(var_12_9)
	var_12_12:addObject(CCDelayTime:create(0.4))
	var_12_12:addObject(CCMoveTo:create(0.2, ccp(arg_12_1.x, arg_12_1.y + 70)))
	var_12_12:addObject(var_12_11)
	var_12_12:addObject(CCCallFuncN:create(handler(arg_12_0, arg_12_0.removeBubble)))
	var_12_3:stopAllActions()
	var_12_3:runAction(CCSequence:create(var_12_12))
end

function zbCombatBubble.showViolentBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_0 = ccp(arg_13_1:getPosition())

	var_13_0.y = var_13_0.y + arg_13_1:getCombatBubbleNumHeight()

	local var_13_1 = arg_13_0:getVolientTexPath(arg_13_6)

	if var_13_1 ~= "" then
		arg_13_0:showTextAndViolentNumBubble(var_13_0, var_13_1, arg_13_3, arg_13_4, arg_13_5)
	else
		echo("11111111111111111122222: " .. bubbleType)
	end
end

function zbCombatBubble.showTextBubble(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	arg_14_0:clearHeroTextBubble(arg_14_1)

	local var_14_0 = CCSprite:create(arg_14_3)

	var_14_0:setScale(0.7)
	var_14_0:setOpacity(0)

	local var_14_1 = ccp(arg_14_1:getPosition())

	var_14_1.y = var_14_1.y + arg_14_1:getCombatBubbleTextHeight()

	var_14_0:setAnchorPoint(ccp(0.5, 0))
	var_14_0:setPosition(var_14_1)
	arg_14_0.bubbleLayer:addChild(var_14_0)

	local var_14_2 = CCArray:create()

	var_14_2:addObject(CCDelayTime:create(arg_14_4))
	var_14_2:addObject(CCFadeIn:create(0.2))
	var_14_2:addObject(CCDelayTime:create(arg_14_5))
	var_14_2:addObject(CCFadeOut:create(0.3))
	var_14_2:addObject(CCCallFuncN:create(handler(arg_14_0, arg_14_0.removeBubble)))
	var_14_0:stopAllActions()
	var_14_0:runAction(CCSequence:create(var_14_2))
	var_14_0:retain()

	local var_14_3 = {
		nodeBubble = var_14_0,
		bubbleType = arg_14_2,
		offsetX = var_14_0:getPositionX() - arg_14_1:getPositionX(),
		offsetY = var_14_0:getPositionY() - arg_14_1:getPositionY()
	}

	table.insert(arg_14_1.bubbleNodes, var_14_3)
end

function zbCombatBubble.showEnergyBubble(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:showTextAndNumBubble(arg_15_1, "image/combat/bubble/energy.png", "image/combat/bubble/self_pj_green.png", arg_15_2, arg_15_3)
end

function zbCombatBubble.showDiedBubble(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:clearHeroTextBubble(arg_16_1)

	local var_16_0 = ECombatBubble.Died
	local var_16_1 = CCTextureCache:sharedTextureCache():addImage(ECombatBubbleTex[var_16_0])
	local var_16_2 = ECombatBubbleTex[var_16_0]
	local var_16_3 = CCSprite:create(var_16_2)

	var_16_3:setScale(0.7)
	var_16_3:setOpacity(0)

	local var_16_4 = ccp(arg_16_1:getPosition())

	var_16_4.y = var_16_4.y + arg_16_1:getCombatBubbleTextHeight()

	var_16_3:setAnchorPoint(ccp(0.5, 0))
	var_16_3:setPosition(var_16_4)
	var_16_3:setOpacity(0)
	arg_16_0.bubbleLayer:addChild(var_16_3)

	local var_16_5 = CCArray:create()

	var_16_5:addObject(CCFadeIn:create(0.125))
	var_16_5:addObject(CCMoveTo:create(2, ccp(var_16_4.x, var_16_4.y + 60)))

	local var_16_6 = CCSpawn:create(var_16_5)
	local var_16_7 = CCArray:create()

	var_16_7:addObject(CCMoveTo:create(0.3, ccp(var_16_4.x, var_16_4.y + 90)))
	var_16_7:addObject(CCFadeOut:create(0.3))

	local var_16_8 = CCSpawn:create(var_16_7)
	local var_16_9 = CCArray:create()

	var_16_9:addObject(CCDelayTime:create(arg_16_2))
	var_16_9:addObject(var_16_6)
	var_16_9:addObject(var_16_8)
	var_16_9:addObject(CCCallFuncN:create(handler(arg_16_0, arg_16_0.removeBubble)))
	var_16_3:stopAllActions()
	var_16_3:runAction(CCSequence:create(var_16_9))
end

function zbCombatBubble.showReviveBubble(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:clearHeroTextBubble(arg_17_1)

	local var_17_0 = ECombatBubble.Relived
	local var_17_1 = CCTextureCache:sharedTextureCache():addImage(ECombatBubbleTex[var_17_0])
	local var_17_2 = ECombatBubbleTex[var_17_0]
	local var_17_3 = CCSprite:create(var_17_2)

	var_17_3:setScale(0.7)
	var_17_3:setOpacity(0)

	local var_17_4 = ccp(arg_17_1:getPosition())

	var_17_4.y = var_17_4.y + arg_17_1:getCombatBubbleTextHeight()

	var_17_3:setAnchorPoint(ccp(0.5, 0))
	var_17_3:setPosition(var_17_4)
	var_17_3:setOpacity(0)
	arg_17_0.bubbleLayer:addChild(var_17_3)

	local var_17_5 = CCArray:create()

	var_17_5:addObject(CCFadeIn:create(0.125))
	var_17_5:addObject(CCMoveTo:create(2, ccp(var_17_4.x, var_17_4.y + 60)))

	local var_17_6 = CCSpawn:create(var_17_5)
	local var_17_7 = CCArray:create()

	var_17_7:addObject(CCMoveTo:create(0.3, ccp(var_17_4.x, var_17_4.y + 90)))
	var_17_7:addObject(CCFadeOut:create(0.3))

	local var_17_8 = CCSpawn:create(var_17_7)
	local var_17_9 = CCArray:create()

	var_17_9:addObject(CCDelayTime:create(arg_17_2))
	var_17_9:addObject(var_17_6)
	var_17_9:addObject(var_17_8)
	var_17_9:addObject(CCCallFuncN:create(handler(arg_17_0, arg_17_0.removeBubble)))
	var_17_3:stopAllActions()
	var_17_3:runAction(CCSequence:create(var_17_9))
end

function zbCombatBubble.removeBubble(arg_18_0, arg_18_1)
	arg_18_0.bubbleLayer:removeChild(arg_18_1, true)
end

function zbCombatBubble.clearHeroTextBubble(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_1.bubbleNodes) do
		if iter_19_1.nodeBubble:getParent() ~= nil then
			iter_19_1.nodeBubble:removeFromParentAndCleanup(true)
		end
	end

	arg_19_1.bubbleNodes = {}
end

function zbCombatBubble.setNumOffsetRandomRangeX(arg_20_0, arg_20_1)
	arg_20_0.numOffsetRandomRangeX = arg_20_1
end
