SP_EVENT_START = "start"
SP_EVENT_END = "end"
SP_EVENT_COMPLEMENT = "complete"
SP_EVENT_EVENT_HIT = "event_hit"
ANIMATION_SEQUENCE_IDLE = "idle"
ANIMATION_SEQUENCE_MOVE = "move"
ANIMATION_SEQUENCE_RUN = "move"
ANIMATION_SEQUENCE_PICKUP = "pickup"
ANIMATION_SEQUENCE_SHOW = "show"
ANIMATION_SEQUENCE_PHYATTACK = "phyattack"
ANIMATION_SEQUENCE_SKILL1 = "skill1"
ANIMATION_SEQUENCE_SKILL2 = "skill2"
ANIMATION_SEQUENCE_SKILL3 = "skill3"
ANIMATION_SEQUENCE_SKILL4 = "skill4"
ANIMATION_SEQUENCE_BLOCK = "block"
ANIMATION_SEQUENCE_DODGE = "dodge"
ANIMATION_SEQUENCE_WEAK = "weak"
ANIMATION_SEQUENCE_WIN = "win"
ANIMATION_SEQUENCE_DIE = "die"
ANIMATION_SEQUENCE_BEHIT = "behit"
ANIMATION_FXDUMMY_HEADHUD = "fxdummy_headhud"
ANIMATION_FXDUMMY_HEADBUFF = "fxdummy_headbuff"
ANIMATION_FXDUMMY_ATTACK = "fxdummy_attack"
ANIMATION_FXDUMMY_BEHIT = "fxdummy_behit"
BUFF_SEQUENCE_CHENMO = "buff_chenmo"
BUFF_SEQUENCE_HUNMI = "buff_hunmi"
BUFF_SEQUENCE_MEIHUO = "buff_meihuo"
BUFF_SEQUENCE_CHAOFENG = "buff_chaofeng"
BUFF_SEQUENCE_ZHONGSHANG = "buff_zhongshang"
BUFF_SEQUENCE_IMMUNE_PHYSIC = "dun_mianyiwuli"
BUFF_SEQUENCE_IMMUNE_MAGIC = "dun_mianyifashu"
BUFF_SEQUENCE_IMMUNE_PM = "dun_mianyiwuli"
BUFF_SEQUENCE_SHIELD_PHYSIC = "dun_xishouwuli"
BUFF_SEQUENCE_SHIELD_MAGIC = "dun_xishoufashu"
BUFF_SEQUENCE_SHIELD_PM = "dun_gudingzhi"
BUFF_SEQUENCE_SHIELD_PM_HEIXIU = "heixiu1_skill1_03"
BUFF_SEQUENCE_SHIELD_PM_BANGQIU_BOTTOM = "luoxiaohei4_skill1_05"
BUFF_SEQUENCE_SHIELD_PM_BANGQIU_FRONT = "luoxiaohei4_skill1_06"
BUFF_SEQUENCE_SHIELD_PM_FANGCUNHE = "fangcunhe_03"
BUFF_SEQUENCE_MISC_SUOLIAN = "qiguo_skill2_03"
BUFF_SEQUENCE_MISC_ZHONGZI = "buff_zhongzi"
BUFF_SEQUENCE_SHIELD_ROUND_REDUCE = "dun_xixue"
BUFF_SEQUENCE_SHIELD_ROUND_REDUCE_HUAXIANZI = "huaxianzi_skill2_03"
BUFF_SEQUENCE_XIXUE = "dun_xixue"
BUFF_SEQUENCE_ZHONGDU = "buff_zhongdu"
BUFF_SEQUENCE_FIRE = "buff_zd_jiuqi"
BUFF_SEQUENCE_LIUXUE = "buff_zhongshang"
BUFF_SEQUENCE_LAOLONG = "luoxiaohei6_skill3_03"
BUFF_SEQUENCE_CAIWENJI_QINYIN = "luoxiaohei6_skill4_03"
g_UseHeixiuShield = false
g_UseBangqiuShield = false
g_UseFangcunheShield = false
g_UsePangtongJiuxiang = false
g_UseSimayiGuLang = false
g_UseDingfengShield = false
g_UseCaorenShield = false
g_UseHuaxianziShield = false
g_UseLoalong = false
EDamageResult = {
	Hit = 3,
	Unhit = 2,
	Violent = 4,
	Immune = 1
}
BUFF_POS_HEAD = 1
BUFF_POS_FRONT = 2
BUFF_POS_GROUND = 3
COMBAT_SPEED_10 = 1.2
COMBAT_SPEED_15 = 1.4
COMBAT_SPEED_20 = 1.6
COMBAT_SPEED_DIE = 0.35
FX_DAZHAO_SCREEN_TIMESCALE = 1 / COMBAT_SPEED_10
FX_DAZHAO_SCREEN_DURATION = 1 / FX_DAZHAO_SCREEN_TIMESCALE
FIGHT_TOTAL_ROUND = 20
FIGHT_CHARGE_TIME = 0.06
FIGHT_RETREAT_TIME = 0.06
FIGHT_NORMALWAIT_TIME = 0.06
FIGHT_RANGEWAIT_TIME = 0.4
COMBAT_TYPE_UNKNOWN = 0
COMBAT_TYPE_LEVEL = 1
COMBAT_TYPE_ARENA = 2
COMBAT_TYPE_YUANZHENG = 3
COMBAT_TYPE_OCCUPY_RES = 4
COMBAT_TYPE_ARENARECORD = 6
COMBAT_TYPE_CHAT = 5
COMBAT_TYPE_PATA = 7
COMBAT_TYPE_LOCALTEST = 8
COMBAT_TYPE_OCCUPY_PLAYER = 9
COMBAT_TYPE_YUANZHENG_TASK = 10
COMBAT_TYPE_TRIAL = 12
COMBAT_TYPE_OCCUPY_CITY = 13
COMBAT_TYPE_FRIEND = 14
COMBAT_TYPE_RANDROB = 15
COMBAT_TYPE_LEGIONBATTLE = 16
COMBAT_TYPE_LEGIONBOSS = 17
COMBAT_TYPE_CS_LIANSAI = 18
COMBAT_TYPE_CS_XIULUO = 19
COMBAT_TYPE_CS_DALUANDOU = 20
COMBAT_TYPE_WORLDBOSS = 21
COMBAT_TYPE_FRIENDBOSS = 22
COMBAT_TYPE_LEGIONWAR = 23
COMBAT_SCENE_LOGIN = 1001
COMBAT_SCENE_ARENA = 12
COMBAT_SCENE_YUANZHENG = 13
COMBAT_SCENE_PATA_BIDIU = 3
COMBAT_SCENE_PATA_MIANMO = 10
COMBAT_SCENE_PATA_MIRROR = 14
COMBAT_SCENE_PATA_BRIDGE = 6
COMBAT_SCENE_PATA_LAOJUN = 7
EMBATTLE_TYPE_LEVEL = 1
EMBATTLE_TYPE_ARENA = 2
EMBATTLE_TYPE_FRIEND = 3
EMBATTLE_TYPE_TRIAL = 4
EMBATTLE_TYPE_PATA = 5
EMBATTLE_TYPE_YUANZHENG = 6
EMBATTLE_TYPE_LEGIONMEM = 7
EMBATTLE_TYPE_WORLDRES = 8
EMBATTLE_TYPE_WORLDHORSE = 9
EMBATTLE_TYPE_CHAT = 10
EMBATTLE_TYPE_FRIENDBOSS = 11
EMBATTLE_TYPE_LEGIONBOSS = 12
EMBATTLE_TYPE_WORLDBOSS = 13
EMBATTLE_TYPE_LEGIONWAR = 14
EFFECT_SG_WHITE = 123001
EFFECT_SG_BLACK = 123002
EFFECT_SG_RED = 123003
EFFECT_SG_YELLOW = 123004
EFFECT_SG_GREEN = 123005
EFFECT_SG_PURPLE = 123006
ForceType = {
	Left = 1,
	Right = 2
}
ForceTypeDesc = {
	"我方",
	"敌方"
}
g_CombatSpeed = 1
HeroRotateY = {
	180,
	0
}
g_ShowBubble = true
g_ShowHp = true
g_curFragLevelMode = 0
g_curFragForceId = 0
g_curFragLevelId = 0
FormationSlots = {}
FormationSlots[2001] = {
	0,
	1,
	0,
	1,
	1,
	1,
	0,
	1,
	0
}
FormationSlots[2002] = {
	1,
	0,
	0,
	1,
	1,
	0,
	0,
	1,
	1
}
FormationSlots[2003] = {
	1,
	1,
	1,
	0,
	1,
	0,
	0,
	1,
	0
}
FormationSlots[2004] = {
	0,
	1,
	1,
	1,
	0,
	1,
	1,
	0,
	0
}
FormationSlots[2005] = {
	0,
	1,
	0,
	1,
	0,
	1,
	1,
	0,
	1
}
FormationSlots[2008] = {
	1,
	0,
	0,
	1,
	1,
	1,
	0,
	0,
	1
}
FormationSlots[2006] = {
	1,
	0,
	1,
	0,
	1,
	0,
	1,
	0,
	1
}
FormationSlots[2007] = {
	1,
	0,
	1,
	1,
	0,
	1,
	0,
	1,
	0
}

function hasFormationSlot(arg_1_0, arg_1_1)
	local var_1_0 = FormationSlots[arg_1_0]

	if var_1_0 ~= nil and var_1_0[arg_1_1] == 1 then
		return true
	end

	return false
end

local var_0_0 = 314
local var_0_1 = 174
local var_0_2 = 68
local var_0_3 = 28
local var_0_4 = 145
local var_0_5 = var_0_4 + var_0_1 - var_0_3 / 2
local var_0_6 = var_0_4 + var_0_1 / 2
local var_0_7 = var_0_4 + var_0_3 / 2
local var_0_8 = 125
local var_0_9 = var_0_8 + var_0_2 / 2
local var_0_10 = var_0_8 + var_0_0 / 2
local var_0_11 = var_0_8 + var_0_0 - var_0_2 / 2
local var_0_12 = 100
local var_0_13 = var_0_12 + var_0_2 / 2
local var_0_14 = var_0_12 + var_0_0 / 2
local var_0_15 = var_0_12 + var_0_0 - var_0_2 / 2
local var_0_16 = 75
local var_0_17 = var_0_16 + var_0_2 / 2
local var_0_18 = var_0_16 + var_0_0 / 2
local var_0_19 = var_0_16 + var_0_0 - var_0_2 / 2
local var_0_20 = 700
local var_0_21 = var_0_20 + var_0_2 / 2
local var_0_22 = var_0_20 + var_0_0 / 2
local var_0_23 = var_0_20 + var_0_0 - var_0_2 / 2
local var_0_24 = 725
local var_0_25 = var_0_24 + var_0_2 / 2
local var_0_26 = var_0_24 + var_0_0 / 2
local var_0_27 = var_0_24 + var_0_0 - var_0_2 / 2
local var_0_28 = 750
local var_0_29 = var_0_28 + var_0_2 / 2
local var_0_30 = var_0_28 + var_0_0 / 2
local var_0_31 = var_0_28 + var_0_0 - var_0_2 / 2

FormationPos = {}
FormationPos[ForceType.Left] = {}
FormationPos[ForceType.Left][1] = ccp(var_0_11, var_0_5)
FormationPos[ForceType.Left][2] = ccp(var_0_15, var_0_6)
FormationPos[ForceType.Left][3] = ccp(var_0_19, var_0_7)
FormationPos[ForceType.Left][4] = ccp(var_0_10, var_0_5)
FormationPos[ForceType.Left][5] = ccp(var_0_14, var_0_6)
FormationPos[ForceType.Left][6] = ccp(var_0_18, var_0_7)
FormationPos[ForceType.Left][7] = ccp(var_0_9, var_0_5)
FormationPos[ForceType.Left][8] = ccp(var_0_13, var_0_6)
FormationPos[ForceType.Left][9] = ccp(var_0_17, var_0_7)
FormationPos[ForceType.Right] = {}
FormationPos[ForceType.Right][1] = ccp(var_0_21, var_0_5)
FormationPos[ForceType.Right][2] = ccp(var_0_25, var_0_6)
FormationPos[ForceType.Right][3] = ccp(var_0_29, var_0_7)
FormationPos[ForceType.Right][4] = ccp(var_0_22, var_0_5)
FormationPos[ForceType.Right][5] = ccp(var_0_26, var_0_6)
FormationPos[ForceType.Right][6] = ccp(var_0_30, var_0_7)
FormationPos[ForceType.Right][7] = ccp(var_0_23, var_0_5)
FormationPos[ForceType.Right][8] = ccp(var_0_27, var_0_6)
FormationPos[ForceType.Right][9] = ccp(var_0_31, var_0_7)

function getCombatHeroPos(arg_2_0, arg_2_1)
	local var_2_0 = FormationPos[arg_2_0][arg_2_1]

	return ccp(var_2_0.x, var_2_0.y)
end

function getCombatHeroPosX(arg_3_0, arg_3_1)
	return FormationPos[arg_3_0][arg_3_1].x
end

function getCombatHeroPosY(arg_4_0, arg_4_1)
	return FormationPos[arg_4_0][arg_4_1].x
end

function getCombatGridOffset()
	return var_0_0 / 2 - var_0_2 / 2
end

function getCombatFormationLine(arg_6_0)
	if arg_6_0 >= var_0_5 then
		return 1
	elseif arg_6_0 >= var_0_6 then
		return 2
	else
		return 3
	end
end

function getLineZOrder(arg_7_0)
	local var_7_0 = getCombatFormationLine(arg_7_0)

	if var_7_0 == 1 then
		return 4
	elseif var_7_0 == 2 then
		return 14
	elseif var_7_0 == 3 then
		return 24
	end

	return 0
end

function getFormationRowCenterPos(arg_8_0, arg_8_1)
	if arg_8_1 == 1 or arg_8_1 == 2 or arg_8_1 == 3 then
		return getCombatHeroPos(arg_8_0, 2)
	elseif arg_8_1 == 4 or arg_8_1 == 5 or arg_8_1 == 6 then
		return getCombatHeroPos(arg_8_0, 5)
	elseif arg_8_1 == 7 or arg_8_1 == 8 or arg_8_1 == 9 then
		return getCombatHeroPos(arg_8_0, 8)
	end

	return ccp(0, 0)
end

function getFormationLineCenterPos(arg_9_0, arg_9_1)
	if arg_9_1 == 1 or arg_9_1 == 4 or arg_9_1 == 7 then
		return getCombatHeroPos(arg_9_0, 4)
	elseif arg_9_1 == 2 or arg_9_1 == 5 or arg_9_1 == 8 then
		return getCombatHeroPos(arg_9_0, 5)
	elseif arg_9_1 == 3 or arg_9_1 == 6 or arg_9_1 == 9 then
		return getCombatHeroPos(arg_9_0, 6)
	end

	return ccp(0, 0)
end

function getFormationLineFristPos(arg_10_0, arg_10_1)
	local var_10_0 = ccp(0, 0)

	if arg_10_1 == 1 or arg_10_1 == 4 or arg_10_1 == 7 then
		var_10_0 = getCombatHeroPos(arg_10_0, 1)
	elseif arg_10_1 == 2 or arg_10_1 == 5 or arg_10_1 == 8 then
		var_10_0 = getCombatHeroPos(arg_10_0, 2)
	elseif arg_10_1 == 3 or arg_10_1 == 6 or arg_10_1 == 9 then
		var_10_0 = getCombatHeroPos(arg_10_0, 3)
	end

	return var_10_0
end

function getFormationLineFristFrontPos(arg_11_0, arg_11_1)
	local var_11_0 = ccp(0, 0)

	if arg_11_1 == 1 or arg_11_1 == 4 or arg_11_1 == 7 then
		var_11_0 = getCombatHeroPos(arg_11_0, 1)
	elseif arg_11_1 == 2 or arg_11_1 == 5 or arg_11_1 == 8 then
		var_11_0 = getCombatHeroPos(arg_11_0, 2)
	elseif arg_11_1 == 3 or arg_11_1 == 6 or arg_11_1 == 9 then
		var_11_0 = getCombatHeroPos(arg_11_0, 3)
	end

	local var_11_1 = 80

	if arg_11_0 == ForceType.Left then
		var_11_0.x = var_11_0.x + var_11_1
	else
		var_11_0.x = var_11_0.x - var_11_1
	end

	return var_11_0
end

function getFormationCenterFrontPos(arg_12_0)
	local var_12_0 = getCombatHeroPos(arg_12_0, 2)
	local var_12_1 = 80

	if arg_12_0 == ForceType.Left then
		return ccp(var_12_0.x + var_12_1, var_12_0.y)
	else
		return ccp(var_12_0.x - var_12_1, var_12_0.y)
	end
end

function getFormationRowFrontPos(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_1 == 1 or arg_13_1 == 4 or arg_13_1 == 7 then
		var_13_0 = getCombatHeroPos(arg_13_0, 1)
	elseif arg_13_1 == 2 or arg_13_1 == 5 or arg_13_1 == 8 then
		var_13_0 = getCombatHeroPos(arg_13_0, 2)
	elseif arg_13_1 == 3 or arg_13_1 == 6 or arg_13_1 == 9 then
		var_13_0 = getCombatHeroPos(arg_13_0, 3)
	end

	local var_13_1 = 100

	if arg_13_0 == ForceType.Left then
		return ccp(var_13_0.x + var_13_1, var_13_0.y)
	else
		return ccp(var_13_0.x - var_13_1, var_13_0.y)
	end
end

function getFlipForceType(arg_14_0)
	if arg_14_0 == ForceType.Left then
		return ForceType.Right
	else
		return ForceType.Left
	end
end
