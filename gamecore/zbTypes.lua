require("gamecore.zbBuildingDefine")

kCCTableViewFillTopDown = 0
kCCTableViewFillBottomUp = 1
NET_TIMEOUT = 10
ZORDER_TOP = 10000000
ZORDER_BOTTOM = -1000000
TOUCHPRIORITY_MAX = 1000000
TOUCHPRIORITY_MIN = -1000000
TIME_DELT = 28800
MOVE_DIST_TEST = 225
MOVE_TIME_TEST = 0.23
OPEN_FRIENDS_LEVEL = 7
OPEN_LEGION_LEVEL = 18
MAX_VIPLEVEL = 15
EFunShowTime = {
	NoTip = 2,
	Imm = 0,
	Home = 1
}
g_AwardShowDelayTime = 0
MOVE_TEST_DELTA = 2500
CHAT_MAX_LINE = 30
CHAT_MAX_OBJECT = 10
GMTAB_COUNT = 0
GMTAB_LIMITHERO = 0
GMTAB_RECHARGESUM = 0
GMTAB_RECHARGEDAILY = 0
GMTAB_RECHARGESINGLE = 0
GMTAB_FUND = 0
GMTAB_LIMITSHOP = 0
GMTAB_CONSUMSUM = 0
E_ZB_MSG_REG = 10001
E_ZB_MSG_LOGIN = 10002
E_ZB_MSG_VISITOR = 10003
E_ZB_MSG_AC_CHECK = 10004
E_ZB_MSG_VERIFY = 10005
E_ZB_MSG_VISITORBIND = 10006
E_ZB_MSG_FINDBACKPWD = 10007
E_ZB_MSG_BINDPHONE = 10008
E_ZB_MSG_REFRESH_TOKEN = 10009
E_ZB_MSG_AC_UP = 10010
E_ZB_ADVICE = 10011
E_ZB_REPORT = 10012
RuleType_Arena = 1
RuleType_World = 2
RuleType_Yuanzheng = 3
RuleType_Reward = 4
RuleType_Tech = 5
RuleType_DailyFuben_Pata = 7
RuleType_EquipDecompose = 8
RuleType_HeroDecompose = 9
RuleType_GemsDecompose = 10
RuleType_HeroTrain = 11
RuleType_LegionDonate = 12
RuleType_LegionBoss = 13
RuleType_LegionGame = 14
RuleType_LegionParty = 15
RuleType_LegionTrain = 16
RuleType_LegionBless = 17
RuleType_LegionWar = 18
RuleType_HeroReset = 19
RuleType_CSXiuluo = 20
RuleType_CSDaluandou = 21
RuleType_ServiceLeague = 22
RuleType_HeroSoul = 23
RuleType_Pub = 24
RuleType_TreaSure = 25
RuleType_WorldBoss = 26
UI_EFFECT_CUILIAN_SUC = "cuilian"
UI_EFFECT_FULING_SUC = "fuling"
UI_EFFECT_JIEYIN_SUC = "jieyin"
UI_EFFECT_JIHUO_SUC = "jihuo"
UI_EFFECT_JINJIE_SUC = "jinjie"
UI_EFFECT_QIANGHUA_SUC = "qianghua"
UI_EFFECT_RONGLIAN_SUC = "ronglian"
UI_EFFECT_SHENGJI_SUC = "shengji"
UI_EFFECT_SHENGXING_SUC = "shengxing"
UI_EFFECT_TUPO_SUC = "tupo"
UI_EFFECT_ZHUZAO_SUC = "zhuzao"
E_AccountType = {
	E_MAIL = 2,
	E_PHONE = 3,
	E_VISITOR = 4,
	E_USER_NAME = 1
}
E_AccountCheckType = {
	E_MOBILE_UP = 4,
	E_MOBILE_REG = 3,
	E_FINDBACK_PWD = 5,
	E_NONE = 1,
	E_NORMAL_BIND = 2
}
E_AccountUpPhone = {
	E_NAME = 2,
	E_Visitor = 1
}
EServerState = {
	Full = 3,
	New = 1,
	Normal = 2
}
EServerStateTex = {
	"ui/image/login/serverlist/serverlist_state1.png",
	"ui/image/login/serverlist/serverlist_state2.png",
	"ui/image/login/serverlist/serverlist_state3.png",
	"ui/image/login/serverlist/serverlist_state4.png"
}
EServerStateColor = {
	ccc3(0, 255, 0),
	ccc3(0, 255, 0),
	ccc3(255, 0, 0),
	ccc3(255, 255, 80)
}
ITEM_ID_SKILLBOOK = 2040201
ITEM_ID_RESET = 2050701
EMoneyPanelResType = {
	Gold = 1,
	Tili = 4,
	Bgz = 9,
	Horn = 11,
	Food = 3,
	Legion = 10,
	DollsMoney = 13,
	EquipSoul = 7,
	BarMoney = 12,
	Diamond = 2,
	Reset = 15,
	BarCard = 5,
	Arena = 8,
	SkillBook = 14,
	GemOpen = 16,
	Soul = 6
}
EListType = {
	HeroBook = 8,
	vipShop = 10,
	FurnitureList = 3,
	craftList = 9,
	HeroList = 2,
	WorkerList = 5,
	RankList = 6,
	CitizenList = 4,
	ResourceBag = 11,
	BagList = 1,
	BattleLevel = 7
}
ELoginmoudle = {
	SetPwd = 7,
	InputVery = 6,
	BindMobile = 4,
	FindbackPwd = 5,
	AcCode = 10,
	NormalReg = 2,
	Login = 1,
	MobileReg = 3,
	AcUp = 8,
	AcUpNormal = 9
}
ESettingTab = {
	Advice = 3,
	Self = 1,
	Select = 2,
	Social = 4
}
ETechTab = {
	Parter = 4,
	Hero = 1,
	Formation = 3,
	Func = 2
}
ERankTab = {
	FV = 2,
	Arena = 1,
	Legion = 6,
	Bgz = 4,
	HeroBestFV = 3,
	Pata = 5
}
EShopTab = {
	Arena = 3,
	Mystery = 2,
	Normal = 1
}
EHeroTab = {
	All = 1,
	Intelligence = 3,
	Force = 2,
	Tili = 4
}
ERoleTab = {
	Information = 1,
	Dynamic = 3,
	Gift = 2
}
EFriendTab = {
	Tuijian = 5,
	Add = 4,
	Request = 3,
	Jiaohu = 2,
	FriendList = 1
}
EBagTab = {
	Gemstone = 2,
	Consumables = 1,
	GiftBag = 3
}
EBagDetailTab = {
	Information = 1,
	Count = 3,
	Progress = 2
}
EItemDetailType = {
	Bag = 1,
	Craft = 2
}
ESortType = {
	Level = 2,
	Quality = 1,
	Variety = 3,
	Power = 4
}
ESuccessTab = {
	Information = 2,
	Success = 1
}
EChatURLTab = {
	Hero = 2,
	Equip = 1
}
ESocialType = {
	WeiXin = 3,
	WeiBo = 2,
	BaiDu = 1,
	Magic = 4
}
g_IOSTSCheck = false and zbGlobalUtil:getTargetPlatform() == "ios"
ETipType = {
	Equip = 3,
	Skill = 4,
	GodEquipSkill = 5,
	Hero = 1,
	Award = 2
}
EVipRechargeType = {
	E_DIMOND = 2,
	E_GIFT = 1,
	E_GOLD = 3
}
EChangeBaseInfoType = {
	E_NAME = 1,
	E_CODE = 4,
	E_SEX = 2,
	E_SIGN = 3
}
EPushType = {
	E_MAX = 4,
	E_TILI_GET3 = 3,
	E_PUB_FREE = 4,
	E_TILI_GET2 = 2,
	E_TILI_GET1 = 1
}
E_DESC = {}
E_DESC[EPushType.E_TILI_GET1] = "\xBF\xAA\xB7\xB9ʱ\xBC䵽\xC0\xB2!\xC2\xDEС\xBA\xDA\xD7\xB5\xC4\xD3\xE3\xB8\xC9\xD5\xFD\xD4ڷ\xA2\xB7\xC5,\xCFȵ\xBD\xCFȵ\xC3!"
E_DESC[EPushType.E_TILI_GET2] = "\xBF\xAA\xB7\xB9ʱ\xBC䵽\xC0\xB2!\xC2\xDEС\xBA\xDA\xD7\xB5\xC4\xD3\xE3\xB8\xC9\xD5\xFD\xD4ڷ\xA2\xB7\xC5,\xCFȵ\xBD\xCFȵ\xC3!"
E_DESC[EPushType.E_TILI_GET3] = "\xBF\xAA\xB7\xB9ʱ\xBC䵽\xC0\xB2!\xC2\xDEС\xBA\xDA\xD7\xB5\xC4\xD3\xE3\xB8\xC9\xD5\xFD\xD4ڷ\xA2\xB7\xC5,\xCFȵ\xBD\xCFȵ\xC3!"
E_DESC[EPushType.E_PUB_FREE] = "С\xBA\xDA\xCE\xDD\xD3\xD6\xD3\xD0\xC3\xE2\xB7\xD1\xC0\xB2,\xBF\xEC\xC0\xB4\xBF\xB4\xBF\xB4ľͷ\xD3ֻ\xAD\xC1\xCB\xC4\xC4Щ\xBB\xEF\xB0\xE9\xB8\xF8\xC4\xE3!"
E_TITLE = {}
E_TITLE[EPushType.E_TILI_GET1] = "\xD5\xFB\xB5\xE3\xC1\xECȡ\xD3\xE3\xB8\xC9"
E_TITLE[EPushType.E_TILI_GET2] = "\xD5\xFB\xB5\xE3\xC1\xECȡ\xD3\xE3\xB8\xC9"
E_TITLE[EPushType.E_TILI_GET3] = "\xD5\xFB\xB5\xE3\xC1\xECȡ\xD3\xE3\xB8\xC9"
E_TITLE[EPushType.E_PUB_FREE] = "С\xBA\xDA\xCE\xDD\xC3\xE2\xB7\xD1"
NOTIFY_TAG_PATH = "image/common/notifytag.png"
ERedPointType = {
	World = 12,
	Tech = 10,
	Formation = 15,
	Task = 7,
	Mail = 6,
	GodLevelUp = 16,
	Legion = 5,
	E_MAX = 19,
	Chat = 8,
	Arena = 9,
	Hero = 1,
	Equip = 3,
	Bgz = 19,
	Friend = 4,
	Bag = 2,
	HeroTrial = 11,
	GodStarUp = 17,
	Pub = 14,
	GodSkillUp = 18,
	GameLevel = 13
}
REDPOINT_STATE_CLOSE = 0
REDPOINT_STATE_OPEN = 1
EForceEnterWay = {
	FragWay = 2,
	Normal = 1
}
EParterTechId = {
	DefendTech = 4002,
	HpTech = 4003,
	AttackTech = 4001
}
ELevelTypeDesc = {
	"\xD6\xF7\xCF߾\xE7\xC7\xE9",
	"\xBE\xABӢ\xC4Ѷ\xC8",
	"\xC9\xF1\xBB\xB0ģʽ"
}
EHeroTabType = {
	Entourage = 2,
	UnUse = 3,
	UnObtain = 4,
	Battle = 1
}
EHeroDetailTab = {
	XiLian = 6,
	Skill = 2,
	StarUp = 4,
	Fate = 5,
	Phase = 3,
	Partner = 7,
	Max = 7,
	Detail = 1
}
E_SKILL_CLASS = {
	E_INITIATIVE = 1,
	E_AUTO = 3,
	E_NORMAL = 2,
	E_PASSI = 4
}
EEquipBagTab = {
	Weapon = 1,
	Cloak = 4,
	Book = 5,
	Magic = 6,
	Armor = 2,
	Mount = 3
}
EEquipForgeTab = {
	Emchant = 2,
	Upgrade = 1,
	StarUp = 4,
	Cuilian = 3
}
EDecomposeBagTab = {
	Equip = 2,
	EquipFrag = 1
}
E_HeroSelWnd_usefor = {
	E_SelHero = 3,
	E_SwapEquip = 1,
	E_Partner = 2
}
EItemGetWayType = {
	GetWay_Trial = 8,
	GetWay_ShopNormal = 2,
	GetWay_Pata = 9,
	GetWay_Pub = 1,
	GetWay_PataJiFen = 10,
	GetWay_WorldTask = 11,
	GetWay_WorldNode = 12,
	GetWay_YuanzhengJiFen = 7,
	GetWay_ShopShenMi = 3,
	GetWay_VipGift = 13,
	GetWay_ForceAward = 5,
	GetWay_Yuanzheng = 6,
	GetWay_ShopHonor = 4
}
ELegionTabNo = {
	LegionSearch = 3,
	LegionCreate = 2,
	LegionJoin = 1
}
ELegionTab = {
	LegionLog = 3,
	LegionInfo = 1,
	LegionShenHe = 2
}
ELegionFunctionType = {
	E_LEGIONVS = 6,
	E_TRAIN = 4,
	E_SHENSHE = 3,
	E_DASHITANG = 5,
	E_TOUZI = 2,
	E_YISHITING = 1,
	E_BAOZANG = 8,
	E_CHANLENGE = 7
}
ELegionRedTab = {
	Send = 1,
	Gain = 2
}
EWorldNodeOccupyType = {
	E_LOSE = 2,
	E_HOLD = 1
}
EActivityType = {
	Tili = 5,
	Sign = 3,
	Vip = 2,
	Upgrade = 6,
	Card = 1,
	Desire = 4,
	LuckCat = 7,
	BottomNull = 7
}
EGetWayType = {
	Hero = 2,
	NormalItem = 1
}
ESevenType = {
	Half = 2,
	Sign = 1,
	Star = 7,
	Arena = 4,
	Level = 5,
	Pata = 6,
	Power = 3
}
EGmActivityType = {
	Fund = 7,
	LimitTimeShop = 6,
	Notice = 1,
	FundWelfare = 8,
	RechargeDailySingle = 11,
	DoubleDrop = 2,
	RechargeSingle = 12,
	RechargeDailySum = 10,
	ItemExchange = 4,
	ConsumDailySum = 15,
	ConsumSum = 14,
	RechargeDaily = 9,
	DailyActive = 3,
	RechargeSum = 13,
	LimitTimeHero = 5
}
ETaskType = {
	Daily = 2,
	Success = 1
}
ELegionPartLogType = {
	LegionWar = 3,
	Party = 1,
	Bless = 2
}
EBagItemOption = {
	E_SALE = 1,
	E_OPEN = 2
}
ELgionWarHero = {
	E_NodeAdd = 1,
	E_EliteSet = 2
}
ELgionWarFight = {
	E_NodePlay = 2,
	E_NodeNPC = 1
}
ESubRoleInfoType = {
	E_LVUP = 2,
	E_EXIT_GAME = 4,
	E_ENTER_GAME = 3,
	E_CREATE = 1
}
ESoundType = {
	E_DIE = 5,
	E_CLICK = 2,
	E_GET = 1,
	E_PROVOKE = 4,
	E_BIGSKILL = 3
}
