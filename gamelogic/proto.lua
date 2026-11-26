NodMsg = {
	Header = {},
	Msg
}
ServPacketHeader = {
	MsgID,
	ProtoVersion
}
ProtoMsg = {
	Header = {},
	Msg
}
PacketHeader = {
	MsgID,
	ProtoVersion
}
SelfGameInfo = {
	GameEnvInfo = {},
	BaseInfo = {},
	VipInfo = {},
	Wealth = {},
	CapacityInfo = {},
	Exchange = {},
	BuildingList = {},
	TechList = {},
	BagItemList = {},
	BagEquipList = {},
	EquipFragList = {},
	HeroFragList = {},
	HeroList = {},
	GodInfo = {},
	Formation = {},
	ForceSection = {},
	SelfArenaInfo = {},
	MainTask = {},
	DailyTask = {},
	TrialInfo = {},
	CDInfo = {},
	DailyRefresh,
	CreateTime,
	BarInfo = {},
	LegionInfo = {},
	LegionWarBaseInfo = {},
	PataInfo = {},
	BgzInfo = {},
	TeamHire = {},
	TreasureInfo = {},
	HeroSoulHallInfo = {}
}
SelfGameCompleteInfo = {
	ActivityAct = {},
	ActivityOs = {},
	ActivityGm = {}
}
DataChange = {
	Hero = {},
	BagItem = {},
	BagEquip = {},
	HeroFrag = {},
	EquipFrag = {}
}
HeroChange = {
	New = {},
	Update = {},
	Del
}
BagItemChange = {
	New = {},
	Update = {},
	Del
}
BagEquipChange = {
	New = {},
	Update = {},
	Del
}
HeroFragChange = {
	New = {},
	Update = {},
	Del
}
EquipFragChange = {
	New = {},
	Update = {},
	Del
}
GameEnvInfo = {
	ServTime,
	TimeZone
}
AwardItem = {
	Type,
	Id,
	Count
}
LevelAwardList = {
	AwardList = {}
}
AttrDetail = {
	AttrType,
	AddType,
	Value
}
EquipSlot = {
	SlotType,
	EquipId,
	HeroTid
}
PlayerBaseInfo = {
	PlayerId,
	RoleName,
	Level,
	VipLevel,
	HeadId,
	FV,
	LastTm,
	Online
}
PlayerTipsInfo = {
	PlayerId,
	RoleName,
	Level,
	VipLevel,
	HeadId,
	FV,
	BestFV,
	Rank,
	BestRank,
	WinCount,
	LegionId,
	LegionName,
	LastTm,
	Online
}
PlayerBaseFormationInfo = {
	PlayerBaseInfo = {},
	HeroList = {}
}
PlayerFormationInfo = {
	PlayerTipsInfo = {},
	HeroList = {}
}
PlayerGameInfo = {
	BaseInfo = {},
	Wealth = {}
}
BaseInfo = {
	PlayerId,
	RoleName,
	Level,
	Exp,
	VipLevel,
	AvatarId,
	HeadId,
	LastTm
}
VipInfo = {
	VipBaseInfo = {},
	VipGift = {},
	VipShop = {},
	MonthCard = {},
	QuarterCard = {},
	ForeverCard = {},
	TwoCard = {},
	FirstBuy = {},
	VipSign = {}
}
VipBaseInfo = {
	Exp,
	NextExp,
	NextTotalExp
}
VipGiftDetail = {
	Level,
	State,
	ShowDiamond,
	SaleDiamond,
	AwardList = {}
}
VipShopDetail = {
	GoodsId,
	GoodsType,
	Price,
	CCY,
	Diamond,
	FirstDiamond,
	FollowDiamond,
	DailyAwardList = {},
	BuyState,
	IsHot,
	Icon
}
VipCardInfo = {
	LeftDay,
	EmdTm,
	DailyAward,
	AwardList = {}
}
TwoCardInfo = {
	DailyAward,
	AwardList = {}
}
FirstBuyInfo = {
	State,
	Value,
	AwardList = {}
}
VipSignInfo = {
	State,
	AwardList = {}
}
WealthInfo = {
	Gold,
	Diamond,
	Food,
	Tili,
	BarCard,
	Soul,
	EquipSoul,
	Arena,
	Bgz,
	Legion,
	Horn,
	BarMoney,
	DollsMoney
}
ExchangeInfo = {
	GoldCount,
	FoodCount,
	TiliCount,
	SkillBookCount,
	GemOpenHoleCount,
	DollsMoneyCount
}
BuildingDetail = {
	BuildingId,
	Level,
	UpgradeStartTm,
	UpgradeEndTm,
	NextIncomeTm
}
TechDetail = {
	TechId,
	Level,
	FV
}
HeroDetail = {
	HeroBaseInfo = {},
	HeroSubInfo = {},
	EquipList = {},
	SkillList = {},
	HeroAttr,
	FateEquipList = {},
	WashInfo = {},
	CastList = {},
	PartnerInfo = {}
}
HeroBaseInfo = {
	TemplateId,
	Level,
	Exp,
	Quality,
	Star,
	Satisfy,
	FV
}
HeroSubInfo = {
	SkillPoint
}
EquipData = {
	EEquipType,
	Equip = {}
}
FateEquipDetail = {
	EquipType,
	FateId
}
HeroSkill = {
	Index,
	SkillId,
	Level
}
HeroWashInfo = {
	Level,
	MAttr
}
HeroCastExtraAttr = {
	Index,
	Level,
	AttrInfo
}
PartnerInfo = {
	MasterTid,
	PartnerList,
	PartnerAttr
}
GodInfo = {
	Level,
	Exp,
	Star,
	Energy,
	SkillList = {},
	GodList,
	GodId,
	Power,
	FV
}
GodSkillSlot = {
	Index,
	SkillId,
	Level,
	Bless
}
CapacityInfo = {
	Bag,
	Tili
}
ItemDetail = {
	TemplateId,
	Count
}
EquipDetail = {
	EquipId,
	TemplateId,
	Quality,
	Star,
	SLucky,
	Level,
	CLevel,
	CExp,
	GemList = {},
	AttrInfo = {},
	FV
}
EquipFragDetail = {
	TemplateId,
	Count
}
HeroFragDetail = {
	TemplateId,
	Count
}
GemSlotDetail = {
	Index,
	GemShape,
	TemplateId
}
EquipAttrInfo = {
	MAttr,
	SAttr,
	GemAttr = {},
	Addition
}
GemAttrDetail = {
	TemplateId,
	AttrList
}
GemAdditionDetail = {
	AdditionType,
	AttrInfo
}
MainTaskDetail = {
	TaskType,
	TaskId,
	State,
	AwardList = {}
}
DailyTaskInfo = {
	ActiveCount,
	TaskList = {},
	AwardList = {}
}
DailyTaskDetail = {
	TaskType,
	NeedCount,
	CompleteCount,
	State,
	AwardList = {}
}
ActiveAwardDetail = {
	Active,
	State,
	AwardList = {}
}
ForceSection = {
	ForceId,
	ForceList = {}
}
ForceDetail = {
	LevelType,
	Passed,
	StarCount,
	LevelList = {},
	StarAwardList
}
ForceLevelDetail = {
	LevelId,
	StarCount,
	FightCount,
	RefreshCount
}
TeamHireInfo = {
	HireList,
	ResetList
}
BattleInfo = {
	RandomSeed,
	MaxRound,
	Sign,
	SelfBaseInfo = {},
	SelfFormation = {},
	EnemyBaseInfo = {},
	EnemyFormation = {}
}
BattleFormation = {
	TechDetail = {},
	BattleGod = {},
	HeroList = {},
	BuffList
}
BattleHeroInfo = {
	HeroBaseInfo = {},
	SkillList = {},
	HeroAttr
}
BattleHeroBaseInfo = {
	Index,
	TemplateId,
	Level,
	Quality,
	Star,
	Satisfy,
	FV,
	Boss
}
BattleGod = {
	Level,
	Star,
	Energy,
	SkillList = {},
	GodId,
	Power,
	FV
}
BattleGodSkill = {
	Index,
	SkillId,
	Level
}
Formation = {
	TechId,
	Layout,
	FV,
	BestFV
}
HeroSoulHallInfo = {
	HeroSoulHallList = {}
}
HeroSoulHallDetail = {
	HallId,
	HeroSoulList = {},
	HeroAddAttrList = {}
}
HeroSoulAddAttrDetail = {
	AttrType,
	AttrValue,
	Position
}
HeroSoulDetail = {
	Position,
	SoulList = {}
}
SoulDetail = {
	HeroSoulId,
	Status,
	HeroAddAttr = {}
}
ChatDetail = {
	ChatType,
	SenderId,
	SenderName,
	SenderLevel,
	SenderVipLevel,
	SenderHeadId,
	IsHorn,
	ChatTm,
	ChatMsg
}
CDInfo = {
	ChatWorldCD,
	ChatLegionCD,
	ChatPrivateCD,
	TiliCD
}
LinkDetail = {
	LinkType,
	Id
}
HeroFragComposeAckData = {
	Wealth = {},
	DataChange = {}
}
HeroFragDecomposeAckData = {
	Wealth = {},
	DataChange = {}
}
HeroFragExchangeSoulAckData = {
	Wealth = {},
	DataChange = {}
}
HeroUpgradeAckData = {
	UpLevel,
	DataChange = {}
}
HeroUpgradeQualityAckData = {
	Wealth = {},
	DataChange = {}
}
HeroUpgradeStarAckData = {
	Wealth = {},
	DataChange = {}
}
HeroWearEquipAckData = {
	DataChange = {}
}
HeroSwapEquipAckData = {
	DataChange = {}
}
HeroFastUpgradeEquipAckData = {
	Wealth = {},
	DataChange = {}
}
HeroUpgradeSkillAckData = {
	DataChange = {}
}
HeroXilianAckData = {
	Wealth = {},
	DataChange = {}
}
HeroTupoAckData = {
	DataChange = {}
}
HeroCastAckData = {
	DataChange = {}
}
HeroExchangeFateAckData = {
	Wealth = {},
	DataChange = {}
}
HeroSoulBuyAckData = {
	Wealth = {},
	HeroSoulHallInfo = {},
	DataChange = {}
}
HeroSoulExchangeAckData = {
	HeroSoulHallInfo = {},
	DataChange = {}
}
HeroPutOnPartnerAckData = {
	DataChange = {}
}
HeroPutDownPartnerAckData = {
	DataChange = {}
}
HeroUpgradeSatisfyAckData = {
	DataChange = {}
}
HeroCalcResetAckData = {
	AwardList = {}
}
HeroConfirmResetAckData = {
	Wealth = {},
	DataChange = {}
}
BagGemComposeAckData = {
	DataChange = {}
}
BagSaleItemAckData = {
	DataChange = {},
	Wealth = {}
}
BagOpenBoxAckData = {
	DataChange = {},
	Wealth = {},
	AwardList = {}
}
EquipUpgradeAckData = {
	Wealth = {},
	DataChange = {}
}
EquipCuilianAckData = {
	UpLevel,
	Wealth = {},
	DataChange = {}
}
EquipComposeAckData = {
	Wealth = {},
	DataChange = {}
}
EquipDecomposeAckData = {
	Wealth = {},
	DataChange = {}
}
EquipOpenHoleAckData = {
	DataChange = {}
}
EquipRefreshHoleAckData = {
	DataChange = {}
}
EquipGemSetAckData = {
	DataChange = {}
}
EquipGemRemoveAckData = {
	DataChange = {}
}
EquipUpStarAckData = {
	Wealth = {},
	DataChange = {},
	Result
}
BuildingGetDataAckData = {
	BuildingList = {}
}
BuildingUpgradeAckData = {
	Wealth = {},
	BuildingList = {}
}
BuildingImmCompleteAckData = {
	Wealth = {},
	BuildingList = {}
}
BuildingIncomeAckData = {
	Wealth = {},
	BuildingList = {}
}
TechUpgradeAckData = {
	Wealth = {},
	TechList = {}
}
TechFastUpgradeAckData = {
	Wealth = {},
	TechList = {}
}
TechGetDataAckData = {
	TechList = {}
}
FormationSaveAckData = {
	Formation = {},
	GodInfo = {}
}
MainTaskGetDataAckData = {
	MainTask = {}
}
MainTaskAwardAckData = {
	MainTask = {},
	Wealth = {},
	DataChange = {}
}
DailyTaskGetDataAckData = {
	DailyTask = {}
}
DailyTaskCompleteAckData = {
	DailyTask = {},
	BaseInfo = {},
	Wealth = {},
	DataChange = {}
}
DailyTaskAwardAckData = {
	DailyTask = {},
	Wealth = {},
	DataChange = {}
}
GodUpgradeAckData = {
	GodInfo = {},
	DataChange = {}
}
GodUpgradeStarAckData = {
	GodInfo = {},
	Wealth = {},
	DataChange = {}
}
GodUpgradeSkillAckData = {
	UpgradeState = {},
	GodInfo = {},
	Wealth = {},
	DataChange = {}
}
GameLevelFightStartAckData = {
	ForceId,
	LevelId,
	LevelType,
	BattleInfo = {},
	Wealth = {}
}
GameLevelFightResultAckData = {
	ForceId,
	LevelId,
	LevelType,
	Result,
	ForceDetail = {},
	RoleExp,
	AwardList = {},
	Wealth = {},
	DataChange = {},
	GodInfo = {},
	BaseInfo = {},
	TeamHire = {}
}
GameLevelSaoDangAckData = {
	ForceId,
	LevelId,
	LevelType,
	ForceDetail = {},
	RoleExp,
	LevelAwardList = {},
	ExtraAwardList = {},
	Wealth = {},
	DataChange = {},
	BaseInfo = {}
}
GameLevelStarAwardAckData = {
	ForceId,
	LevelType,
	ForceDetail = {},
	Wealth = {},
	DataChange = {}
}
GameLevelResetAckData = {
	ForceId,
	LevelId,
	LevelType,
	ForceDetail = {},
	Wealth = {}
}
GameLevelGetDataAckData = {
	ForceSection = {}
}
TeamResetHireAckData = {
	TeamHire = {},
	Wealth = {}
}
ArenaInfo = {
	ArenaBaseInfo = {},
	ArenaCombatInfo = {},
	PlayerList = {}
}
ArenaBaseInfo = {
	Rank,
	BestRank,
	WinCount,
	Signature
}
ArenaCombatInfo = {
	CombatCount,
	MaxCombatCount,
	ResetCount
}
ArenaPlayerInfo = {
	PlayerFormationInfo = {},
	Signature
}
SelfArenaInfo = {
	ArenaBaseInfo = {},
	ArenaCombatInfo = {}
}
ArenaFightStartAckData = {
	ArenaBaseInfo = {},
	ArenaCombatInfo = {},
	BattleInfo = {}
}
ArenaFightResultAckData = {
	Result,
	IsBestRank,
	AwardList = {},
	Wealth = {},
	ArenaInfo = {}
}
ArenaRecordListAckData = {
	RecordList = {}
}
ArenaRecord = {
	UUID,
	FightType,
	Result,
	ChangeRank,
	RecordTm,
	PlayerBaseInfo = {}
}
ArenaResetAckData = {
	ArenaCombatInfo = {},
	Wealth = {}
}
ArenaSignatureAckData = {
	ArenaBaseInfo = {}
}
SyncDataGameInfoAckData = {
	GameEnvInfo = {},
	VipInfo = {},
	Wealth = {},
	Exchange = {},
	ForceSection = {},
	SelfArenaInfo = {},
	DailyTask = {},
	TrialInfo = {},
	CDInfo = {},
	DailyRefresh,
	BarInfo = {},
	LegionInfo = {},
	PataInfo = {},
	BgzInfo = {},
	TeamHire = {},
	ActivityAct = {},
	ActivityOs = {},
	ActivityGm = {}
}
SyncDataUpgradeInfoAckData = {
	BaseInfo = {},
	Wealth = {},
	CapacityInfo = {}
}
SyncDataHeroListAckData = {
	HeroList = {}
}
CommonSetFirstAckData = {
	BaseInfo = {}
}
CommonSetRoleNameAckData = {
	BaseInfo = {},
	Wealth = {}
}
CommonSetHeadIdAckData = {
	BaseInfo = {}
}
CommonDiamondExchangeAckData = {
	Exchange = {},
	Wealth = {},
	DataChange = {}
}
CommonBuyHornAckData = {
	Wealth = {}
}
CommonBattleRecordAckData = {
	Result,
	BattleInfo = {}
}
CommonHeartBeatAckData = {
	CDInfo = {},
	Wealth = {}
}
CommonFightStartAckData = {
	BattleInfo = {}
}
CommonFightResultAckData = {
	Result
}
FriendsGetDataAckData = {
	FriendsBaseInfo = {},
	FriendsApplyList = {},
	FriendsList = {}
}
FriendsBaseInfo = {
	TiliCount,
	TiliMax,
	DelCount
}
FriendsApplyDetail = {
	ApplyTm,
	PlayerBaseInfo = {}
}
FriendsDetail = {
	FriendsBaseData = {},
	ActionList = {},
	PlayerBaseInfo = {}
}
FriendsBaseData = {
	Level,
	Friendly,
	ActionCount,
	GiveTili,
	GetTili
}
FriendsActionDetail = {
	PlayerId,
	ActionType,
	ActionValue,
	ActionTm
}
FriendsApplyPassAckData = {
	FriendsDetail = {}
}
FriendsDeleteAckData = {
	PlayerId,
	FriendsBaseInfo = {}
}
FriendsActionAckData = {
	FriendsDetail = {},
	Wealth = {}
}
FriendsSearchAckData = {
	SearchList = {}
}
FriendsRecommendAckData = {
	RecommendList = {}
}
FriendsFightStartAckData = {
	BattleInfo = {}
}
FriendsFightResultAckData = {
	Result
}
FriendsGiveTiliAckData = {
	FriendsDetail = {}
}
FriendsGiveTiliAllAckData = {
	FriendsList = {}
}
FriendsGetTiliAckData = {
	FriendsBaseInfo = {},
	FriendsDetail = {},
	Wealth = {}
}
FriendsGetTiliAllAckData = {
	FriendsBaseInfo = {},
	FriendsList = {},
	Wealth = {}
}
FriendsBossInfo = {
	BossList = {}
}
FriendsBossDetail = {
	BossRoleId,
	RoleName,
	RoleLevel,
	RoleVipLevel,
	RoleHeadIcon,
	Level,
	HpPercent,
	BossTid,
	BossDegree,
	StartTm,
	EndTm,
	Killed,
	KillerName,
	KillerId,
	TotalHurt,
	TotalFightCount,
	FightCount
}
FriendsBossFightStartAckData = {
	BattleInfo = {},
	TotalFightCount,
	FightCount,
	BossDegree,
	BossRoleId
}
FriendsBossFightResultAckData = {
	BossInfo = {},
	Wealth = {},
	DataChange = {},
	AwardList = {}
}
FriendsBossGetInfoAckData = {
	BossInfo = {}
}
FriendsBossGetBossInfoAckData = {
	BossInfo = {}
}
ChatSendAckData = {
	Wealth = {},
	CDInfo = {}
}
ChatRecordNtfData = {
	ChatWorldRecord = {},
	ChatLegionRecord = {},
	ChatSystemRecord = {},
	ChatPrivateRecord = {}
}
ChatPrivateDetail = {
	SenderId,
	SenderName,
	SenderLevel,
	SenderVipLevel,
	SenderHeadId,
	RecordList = {}
}
ScrollNtfData = {
	ScrollType,
	Priority,
	Repeat,
	Interval,
	SysChat,
	Content,
	Tm
}
BarrageSendAckData = {
	Result
}
BarragePullAckData = {
	BarrageList = {}
}
BarrageDetail = {
	SMsg,
	FontColor,
	FontPos
}
RankArenaAckData = {
	RankList = {}
}
RankCommAckData = {
	RankList = {},
	SelfRankInfo = {},
	HistoryInfo = {}
}
PlayerRankInfo = {
	PlayerBaseInfo = {},
	RankInfo = {}
}
RankInfo = {
	Rank,
	RankValue,
	ExtraValue
}
RankLegionAckData = {
	RankList = {}
}
RankHeroAckData = {
	RankList = {}
}
BestHeroRankInfo = {
	Rank,
	RankValue,
	PlayerBaseInfo = {},
	HeroDetail = {}
}
VipCreateOrderAckData = {
	GameOrderId,
	GoodsId,
	Price,
	CCY,
	Extra,
	Sign
}
VipSuccessOrderAckData = {
	BaseInfo = {},
	VipInfo = {},
	Wealth = {},
	DataChange = {}
}
VipVipGiftBuyAckData = {
	VipInfo = {},
	Wealth = {},
	DataChange = {}
}
MailGetListData = {
	MailList = {}
}
MailDetail = {
	MailId,
	SenderId,
	SenderName,
	Title,
	Content,
	SenderTm,
	ExpireTm,
	ReadState,
	AwardState,
	AwardList = {}
}
MailGetAwardAckData = {
	MailDetail = {},
	Wealth = {},
	DataChange = {}
}
MailGetAllAwardAckData = {
	MailList = {},
	Wealth = {},
	DataChange = {}
}
ShopItemDetail = {
	ShopIndex,
	ItemType,
	TemplateId,
	Count,
	MoneyType,
	Price,
	DiscountPrice,
	SaleState
}
ShopInfo = {
	ShopType,
	FlushCount,
	MaxFlushCount,
	ItemList = {}
}
AllShopInfo = {
	AllShopList = {}
}
ShopGetShopItemsAckData = {
	AllShopInfo = {}
}
ShopRefreshAckData = {
	ShopInfo = {},
	Wealth = {}
}
ShopBuyAckData = {
	ShopInfo = {},
	DataChange = {},
	Wealth = {}
}
HeroCommentAddCommentAckData = {
	Result,
	Comment = {}
}
HeroCommentThumbAckData = {
	Result
}
HeroCommentPullCommentAckData = {
	CommentList = {}
}
CommentDetail = {
	Content,
	UUID,
	RoleName,
	Tm,
	ThumbCnt,
	hasThumb
}
TreasureInfo = {
	RecordList = {}
}
TreasureRecordDetail = {
	ForceId,
	MagnifierCount,
	Box1State,
	Box2State,
	Box3State
}
TreasureStartAckData = {
	DataChange = {},
	Wealth = {},
	TreasureInfo = {},
	AwardList = {}
}
TreasureFastStartAckData = {
	DataChange = {},
	Wealth = {},
	TreasureInfo = {},
	AwardList = {}
}
TreasureGetBoxAwardAckData = {
	DataChange = {},
	Wealth = {},
	TreasureInfo = {},
	AwardList = {}
}
TreasureGetInfoAckData = {
	TreasureInfo = {}
}
DollsInfo = {
	PutCoinTm,
	ItemList = {}
}
DollsDetail = {
	Item = {},
	Index
}
DollsPutCoinAckData = {
	Wealth = {},
	DollsInfo = {}
}
DollsGrabAckData = {
	Result,
	Wealth = {},
	DataChange = {},
	DollsInfo = {}
}
DollsGetInfoAckData = {
	DollsInfo = {}
}
AllTrialInfo = {
	TrialList = {}
}
TrialLevelDetail = {
	TrailLevel,
	MaxStar
}
TrialInfo = {
	TrialType,
	FightCount,
	LimitCount,
	LevelList = {}
}
TrialFightStartAckData = {
	TrialInfo = {},
	BattleInfo = {},
	TrialType,
	Level
}
TrialFightResultAckData = {
	TrialInfo = {},
	AwardList = {},
	Wealth = {},
	DataChange = {},
	GodInfo = {},
	Result
}
TrialGetInfoAckData = {
	AllTrialInfo = {}
}
TrialSaoDangAckData = {
	TrialInfo = {},
	Wealth = {},
	DataChange = {},
	AwardList = {},
	TrialType,
	Level
}
PataInfo = {
	BaseInfo = {},
	ScoreAwardInfo = {},
	BuffLayerInfo = {},
	SaoDangInfo = {},
	FightLayerInfo = {},
	AwardLayerInfo = {}
}
PataBaseInfo = {
	Layer,
	BestLayer,
	TodaySaoDangLayer,
	TotalScore,
	DayScore,
	Mode,
	BuffList = {}
}
PataScoreAwardInfo = {
	IndexList = {}
}
PataBuffLayerInfo = {
	BuffBuyList = {}
}
PataSaoDangInfo = {
	SaoDangInfo = {}
}
PataFightLayerInfo = {
	PlayerInfo = {},
	FightResultState
}
PataAwardLayerInfo = {
	AwardLayerInfo = {}
}
PataPlayerBaseInfo = {
	RoleName,
	Level,
	FV,
	HeadId
}
PataPlayerInfo = {
	PlayerBaseInfo = {},
	HeroList = {}
}
ImmBuffDetail = {
	BuffId,
	Count
}
PataSaoDangDetail = {
	Index,
	TurnBrandInfo = {},
	BuffLayerInfo = {},
	AwardList = {}
}
PataSaoDangAwardLayerDetail = {
	Layer,
	BrandList = {},
	AwardList = {}
}
PataSaoDangAwardDetail = {
	Layer,
	AwardList = {}
}
PataSaoDangBuffLayerDetail = {
	Layer,
	BuyList = {}
}
PataSaoDangBoxLayerDetail = {
	Layer,
	Times
}
PataBuffDetail = {
	BuffId,
	State,
	Count,
	SkillIndex,
	CostItem = {}
}
PataAwardLayerDetail = {
	AwardType,
	AwardList = {},
	BrandList = {}
}
PataTurnBrandDetail = {
	Index,
	AwardList = {}
}
PataScoreAwardDetail = {
	Score
}
PataFightStartAckData = {
	BattleInfo = {},
	FightLayerInfo = {}
}
PataBuyBuffAckData = {
	BuffLayerInfo = {},
	Wealth = {},
	BaseInfo = {}
}
PataGetAwardAckData = {
	AwardLayerInfo = {},
	Wealth = {},
	DataChange = {}
}
PataNextLayerAckData = {
	PataInfo = {}
}
PataFightResultAckData = {
	Result,
	GodInfo = {},
	FightLayerInfo = {},
	BaseInfo = {},
	Wealth = {},
	DataChange = {},
	AwardList = {}
}
PataTurnBrandAckData = {
	BaseInfo = {},
	AwardLayerInfo = {},
	Wealth = {},
	DataChange = {}
}
PataSaoDangTurnBrandAckData = {
	BaseInfo = {},
	SaoDangInfo = {},
	Wealth = {},
	DataChange = {}
}
PataSaoDangNextAckData = {
	PataInfo = {}
}
PataSaoDangBuyBuffAckData = {
	BaseInfo = {},
	SaoDangInfo = {},
	Wealth = {}
}
PataGetScoreAwardAckData = {
	BaseInfo = {},
	ScoreAwardInfo = {},
	Wealth = {},
	DataChange = {}
}
PataSaoDangTurnBrandNextAckData = {
	PataInfo = {}
}
PataSaoDangBuyBuffNextAckData = {
	BaseInfo = {},
	SaoDangInfo = {}
}
PataGetInfoAckData = {
	PataInfo = {}
}
PataStartSaoDangAckData = {
	PataInfo = {},
	Wealth = {},
	DataChange = {}
}
BarInfo = {
	BarList = {}
}
BarDetail = {
	BarType,
	FreeCount,
	FreeTotalCount,
	NextFreeTm,
	IsFreeFirst,
	IsMoneyFirst,
	SinglePrice,
	TenPrice,
	BarMoneyPrice
}
BarDrawAckData = {
	Wealth = {},
	DataChange = {},
	BarInfo = {},
	AwardList = {}
}
BgzInfo = {
	TotalFightCnt,
	DayFightCnt,
	TotalScore,
	DayScore,
	CurLevel,
	TotalResetCount,
	ResetCount,
	State,
	AwardList = {},
	ScoreAwardList = {},
	LayerList = {},
	LineList = {}
}
BgzLineDetail = {
	Level,
	Index
}
BgzLayerDetail = {
	Index,
	PlayerId,
	State
}
BgzScoreAwardDetail = {
	Score
}
BgzFightStartAckData = {
	BattleInfo = {}
}
BgzFightResultAckData = {
	BgzInfo = {},
	Wealth = {},
	DataChange = {},
	Result,
	AwardList = {}
}
BgzGetAwardAckData = {
	BgzInfo = {},
	Wealth = {},
	DataChange = {}
}
BgzGetScoreAwardAckData = {
	BgzInfo = {},
	Wealth = {},
	DataChange = {}
}
BgzGetInfoAckData = {
	BgzInfo = {}
}
BgzResetAckData = {
	BgzInfo = {}
}
BgzGetBossInfoAckData = {
	PlayerTipsInfo = {}
}
ActivityActInfo = {
	DailySign = {},
	Tili = {},
	CrazyUpgrade,
	LoginVip = {},
	WishTurntable = {},
	OnlineAward = {},
	LuckyDiamond = {},
	InviteAward = {},
	RebateAward = {}
}
ActDailySign = {
	SignCount,
	SignMax,
	LeftDays,
	SignToday,
	HeroTid,
	SignAward = {}
}
ActDailySignAward = {
	Day,
	Vip,
	Rate,
	AwardItem = {}
}
ActTiliDetail = {
	Index,
	StartHour,
	EndHour,
	Num,
	AddedCost,
	State
}
ActLoginVip = {
	Day,
	State,
	AwardList = {}
}
ActWishTurntable = {
	RunCount,
	RefreshCount,
	RunMax,
	RefreshMax,
	RunCost,
	RefreshCost,
	SlotList = {}
}
WishTurntableSlot = {
	Index,
	State,
	AwardItem = {}
}
ActOnlineAward = {
	NextTm,
	AwardList = {}
}
ActLuckyDiamond = {
	Diamond,
	NeedVip,
	MaxIncome
}
ActLuckyDiamondRecord = {
	RoleName,
	Diamond
}
ActInviteAward = {
	InviteCode,
	InviteCount,
	BeInvite = {},
	Invite = {}
}
ActBeInvite = {
	State,
	NeedLevel,
	AwardList = {}
}
ActInvite = {
	State,
	Count,
	AwardList = {}
}
RebateAward = {
	VipExp,
	Diamond,
	AwardList = {}
}
ActivityActDailySignAckData = {
	DailySign = {},
	Wealth = {},
	DataChange = {}
}
ActivityActTiliAckData = {
	Tili = {},
	Wealth = {},
	DataChange = {}
}
ActivityActTiliAddedAckData = {
	Tili = {},
	Wealth = {},
	DataChange = {}
}
ActivityActCrazyUpgradeAckData = {
	Rank,
	CrazyUpgrade,
	Wealth = {},
	DataChange = {}
}
ActivityActLoginVipAckData = {
	BaseInfo = {},
	VipInfo = {},
	LoginVip = {},
	Wealth = {}
}
ActivityActWishTabRunAckData = {
	Index,
	WishTurntable = {},
	Wealth = {},
	DataChange = {}
}
ActivityActWishTabRefreshAckData = {
	WishTurntable = {},
	Wealth = {},
	DataChange = {}
}
ActivityActOnlineAwardAckData = {
	OnlineAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityActVipCardAwardAckData = {
	MonthCard = {},
	QuarterCard = {},
	ForeverCard = {},
	Wealth = {}
}
ActivityActTwoCardAwardAckData = {
	TwoCard = {},
	Wealth = {},
	DataChange = {}
}
ActivityActFirstRechargeAckData = {
	FirstBuy = {},
	Wealth = {},
	DataChange = {}
}
ActivityActVipSignAckData = {
	VipSign = {},
	Wealth = {},
	DataChange = {}
}
ActivityActLuckyDiamondAckData = {
	HitDiamond,
	LuckyDiamond = {},
	RecordList = {},
	Wealth = {}
}
ActivityActLuckyDiamondLogAckData = {
	RecordList = {}
}
ActivityActBeInviteAckData = {
	BeInvite = {},
	Wealth = {},
	DataChange = {}
}
ActivityActInviteAwardAckData = {
	InviteAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityActRedeemCodeAckData = {
	Wealth = {},
	DataChange = {}
}
ActivityActRebateAwardAckData = {
	BaseInfo = {},
	VipInfo = {},
	Wealth = {},
	DataChange = {},
	RebateAward = {}
}
ActivityOsInfo = {
	OsBaseInfo = {},
	LevelAward = {},
	StarAward = {},
	PataAward = {},
	FVAward = {},
	ArenaAward = {},
	LoginAward = {},
	HalfPacks = {},
	RechargeAward = {}
}
OsBaseInfo = {
	RoleLevel,
	StarCount,
	PataLevel,
	FV,
	ArenaRank,
	Recharge,
	LeftTm
}
OsLevelAward = {
	Level,
	State,
	AwardList = {}
}
OsStarAward = {
	Star,
	State,
	AwardList = {}
}
OsPataAward = {
	Level,
	State,
	AwardList = {}
}
OsFVAward = {
	FV,
	State,
	AwardList = {}
}
OsArenaAward = {
	Rank,
	State,
	AwardList = {}
}
OsLoginAward = {
	LoginCount,
	HeroTid,
	LoginAwardList = {}
}
OsLoginAwardDetail = {
	Day,
	State,
	AwardList = {}
}
OsHalfPacks = {
	Day,
	Vip,
	ShowDiamond,
	SaleDiamond,
	State,
	AwardList = {}
}
OsRechargeAward = {
	Diamond,
	State,
	AwardList = {}
}
ActivityOsLevelAwardAckData = {
	LevelAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsStarAwardAckData = {
	StarAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsPataAwardAckData = {
	PataAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsFVAwardAckData = {
	FVAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsArenaAwardAckData = {
	ArenaAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsLoginAwardAckData = {
	LoginAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsHalfPacksAckData = {
	HalfPacks = {},
	Wealth = {},
	DataChange = {}
}
ActivityOsRechargeAwardAckData = {
	RechargeAward = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmInfo = {
	Notice = {},
	DoubleDrop = {},
	DailyActive = {},
	ItemExchange = {},
	LimitTimeHero = {},
	LimitTimeShop = {},
	Fund = {},
	FundWelfare = {},
	RechargeDaily = {},
	RechargeDailySum = {},
	RechargeDailySingle = {},
	RechargeSingle = {},
	RechargeSum = {},
	ConsumSum = {},
	ConsumDailySum = {},
	HeroReset = {}
}
GmBaseInfo = {
	Title,
	Content,
	ShowStart,
	ShowEnd,
	ActStart,
	ActEnd
}
GmDoubleDrop = {
	Type,
	GmBaseInfo = {}
}
GmDailyActive = {
	ActId,
	GmBaseInfo = {},
	State,
	AwardList = {}
}
GmItemExchange = {
	ActId,
	GmBaseInfo = {},
	TemplateId,
	ExchangeList = {}
}
GmExchangeDetail = {
	Index,
	CostNum,
	CostDiamond,
	LimitNum,
	ExchangeNum,
	AwardList = {}
}
GmLimitTimeHero = {
	ActId,
	GmBaseInfo = {},
	TemplateId,
	SingleCost,
	SingleScore,
	TotalScore,
	LeftScore,
	FreeTm,
	ScoreList = {}
}
GmScoreExchangeDetail = {
	Index,
	Score,
	LimitNum,
	ExchangeNum,
	AwardList = {}
}
GmLimitTimeShop = {
	ActId,
	GmBaseInfo = {},
	GoodsList = {}
}
GmGoodsDetail = {
	Index,
	ShowPrice,
	SalePrice,
	LimitNum,
	ExchangeNum,
	AwardList = {}
}
GmFund = {
	GmBaseInfo = {},
	NeedVip,
	DiamondCost,
	BuyState,
	IncomeList = {}
}
GmFundIncome = {
	State,
	Level,
	Diamond
}
GmFundWelfare = {
	GmBaseInfo = {},
	FundCount,
	WelfareList = {}
}
GmWelfareDetail = {
	State,
	Count,
	AwardList = {}
}
GmRechargeDaily = {
	ActId,
	GmBaseInfo = {},
	Count,
	DayList = {}
}
GmRechargeDailyDetail = {
	Day,
	State,
	AwardList = {}
}
GmRechargeDailySum = {
	ActId,
	GmBaseInfo = {},
	Count,
	RechargeList = {}
}
GmRechargeDailySumDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmRechargeDailySingle = {
	ActId,
	GmBaseInfo = {},
	RechargeList = {}
}
GmRechargeDailySingleDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmRechargeSingle = {
	ActId,
	GmBaseInfo = {},
	RechargeList = {}
}
GmRechargeSingleDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmRechargeSum = {
	ActId,
	GmBaseInfo = {},
	Count,
	RechargeList = {}
}
GmRechargeSumDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmConsumSum = {
	ActId,
	GmBaseInfo = {},
	Count,
	ConsumList = {}
}
GmConsumSumDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmConsumDailySum = {
	ActId,
	GmBaseInfo = {},
	Count,
	ConsumList = {}
}
GmConsumDailySumDetail = {
	Diamond,
	State,
	AwardList = {}
}
GmHeroReset = {
	ActId,
	GmBaseInfo = {},
	Diamond
}
ActivityGmDailyActiveAckData = {
	DailyActive = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmItemExchangeAckData = {
	ItemExchange = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmLimitTimeHeroAckData = {
	LimitTimeHero = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmLimitTimeScoreAckData = {
	LimitTimeHero = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmLimitTimeShopAckData = {
	LimitTimeShop = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmFundBuyAckData = {
	Fund = {},
	FundWelfare = {},
	Wealth = {}
}
ActivityGmFundAwardAckData = {
	Fund = {},
	Wealth = {}
}
ActivityGmFundWelfareAckData = {
	FundWelfare = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmRechargeDailyAckData = {
	RechargeDaily = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmRechargeDailySumAckData = {
	RechargeDailySum = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmRechargeDailySingleAckData = {
	RechargeDailySingle = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmRechargeSingleAckData = {
	RechargeSingle = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmRechargeSumAckData = {
	RechargeSum = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmConsumSumAckData = {
	ConsumSum = {},
	Wealth = {},
	DataChange = {}
}
ActivityGmConsumDailySumAckData = {
	ConsumDailySum = {},
	Wealth = {},
	DataChange = {}
}
WorldInfo = {
	NodeList,
	ViewNodeList = {},
	HoldNodeList = {},
	TaskList = {},
	SpecialList,
	HorseCarList = {},
	FaceList = {},
	AwardBoxList,
	BgzInfo = {},
	ShopInfo = {},
	SettleList = {},
	GodDomainList = {},
	LogList = {}
}
WorldViewNode = {
	NodeId,
	NpcLevel,
	PlayerName,
	HeadId,
	LegionId,
	LegionName,
	Taunt,
	RefreshTm
}
WorldHoldNode = {
	NodeId,
	FullTm,
	Output
}
WorldTaskNode = {
	NodeId,
	FV,
	AttrList,
	DailyCount,
	TeamList = {}
}
WorldTaskTeam = {
	Index,
	Rate,
	Result,
	EndTm,
	HeroList,
	AwardList = {}
}
WorldHorseCarDetail = {
	NodeId,
	PlayerId,
	AwardList = {}
}
WorldFaceDetail = {
	NodeId,
	State,
	Select
}
WorldBgzInfo = {
	NodeId,
	BribeCount,
	BgzClue
}
WorldShopInfo = {
	NodeId,
	EndTm
}
WorldGodDomainNode = {
	NodeId,
	AwardState
}
WorldLogDetail = {
	NodeId,
	LogType,
	LogData
}
WorldGetInfoAckData = {
	WorldInfo = {}
}
WorldUnlockAckData = {
	NodeId,
	NodeType,
	WorldViewNode = {},
	WorldTaskNode = {},
	SpecialNode,
	WorldGodDomainNode = {},
	Wealth = {}
}
WorldGetLogAckData = {
	LogList = {}
}
WorldResGetInfoAckData = {
	ViewNodeList = {},
	HoldNodeList = {},
	SettleList = {}
}
WorldResFightStartAckData = {
	NodeId,
	BattleInfo = {},
	Wealth = {}
}
WorldResFightResultAckData = {
	NodeId,
	Result,
	GodInfo = {},
	WorldHoldNode = {}
}
WorldResGainAckData = {
	NodeId,
	WorldHoldNode = {},
	Wealth = {},
	DataChange = {}
}
WorldResRefreshAckData = {
	NodeId,
	WorldViewNode = {}
}
WorldResClearCDAckData = {
	NodeId,
	WorldViewNode = {},
	Wealth = {}
}
WorldResSettleAckData = {
	SettleList = {},
	Wealth = {},
	DataChange = {}
}
WorldTaskStartAckData = {
	NodeId,
	WorldTaskNode = {},
	Wealth = {}
}
WorldTaskGainAckData = {
	NodeId,
	WorldTaskNode = {},
	Wealth = {},
	DataChange = {}
}
WorldSpeGetInfoAckData = {
	SpecialList,
	HorseCarList = {},
	FaceList = {},
	AwardBoxList,
	BgzInfo = {},
	ShopInfo = {}
}
WorldSpeOpenAckData = {
	NodeId,
	SpecialType,
	SpecialList,
	HorseCarList = {},
	FaceList = {},
	AwardBoxList,
	BgzInfo = {},
	ShopInfo = {}
}
WorldSpeHCFightStartAckData = {
	BattleInfo = {}
}
WorldSpeHCFightResultAckData = {
	NodeId,
	Result,
	GodInfo = {},
	HorseCarList = {},
	AwardList = {},
	Wealth = {},
	DataChange = {}
}
WorldSpeHCGiveUpAckData = {
	NodeId,
	HorseCarList = {}
}
WorldSpeBgzBribeAckData = {
	BgzInfo = {},
	Wealth = {}
}
WorldSpeFaceStartAckData = {
	NodeId,
	FaceList = {}
}
WorldSpeFaceEndAckData = {
	NodeId,
	FaceList = {},
	Wealth = {}
}
WorldSpeAwardBoxAckData = {
	NodeId,
	AwardBoxList,
	Wealth = {},
	DataChange = {}
}
WorldBossBaseInfo = {
	BossId,
	HpPercent,
	AwardTm,
	DeadTm
}
WorldBossSelfInfo = {
	HurtHp,
	Rank,
	AwardState,
	FightCD,
	FightCount
}
WorldBossRankDetail = {
	HurtHp,
	PlayerInfo = {}
}
WorldBossStartFightAckData = {
	BattleInfo = {},
	BossInfo = {},
	SelfInfo = {}
}
WorldBossFightResultAckData = {
	AwardList = {},
	Wealth = {},
	DataChange = {},
	BossInfo = {},
	SelfInfo = {},
	BuffList = {}
}
WorldBossClearCDAckData = {
	Wealth = {},
	SelfInfo = {}
}
WorldBossInspireAckData = {
	Wealth = {},
	BuffList = {}
}
WorldBossDamageRankAckData = {
	RankList = {},
	SelfHurtHp,
	SelfRank
}
WorldBossGetInfoAckData = {
	BossInfo = {},
	SelfInfo = {},
	BuffList = {}
}
WorldBossGetAwardAckData = {
	AwardList = {},
	Wealth = {},
	DataChange = {},
	SelfInfo = {}
}
LegionInfo = {
	LegionId,
	LeftTm,
	DailyDonate,
	MaxDonate,
	Welfare,
	Hongbao = {},
	LegionBoss = {}
}
LegionHongbao = {
	SendMax,
	SendCount,
	GainMax,
	GainCount
}
LegionBossBaseInfo = {
	FightMax,
	FightCount,
	BuffList = {}
}
LegionBaseInfo = {
	LegionId,
	IconId,
	LegionName,
	Level,
	Rank,
	MemberCount,
	MaxMemberCount,
	LimitLvl,
	Confirm,
	Signature,
	FV
}
LegionDetail = {
	LegionBaseInfo = {},
	ManagerInfo = {},
	DonateBaseInfo = {},
	LegionTech = {},
	LegionApply = {},
	Rolling = {},
	LegionDinner = {},
	Train = {},
	LegionBless = {},
	LegionHongbao = {},
	BossInfoList = {}
}
LegionManagerInfo = {
	LeaderId,
	Adviser
}
DonateBaseInfo = {
	DailyDonate,
	MaxDonate
}
LegionTechDetail = {
	LegionTechId,
	Level,
	Exp
}
LegionMemberDetail = {
	MemberBaseInfo = {},
	PlayerBaseInfo = {}
}
LegionMemberBaseInfo = {
	Donate
}
LegionLogDetail = {
	PlayerId,
	RoleName,
	Type,
	Target,
	Value,
	VType,
	Tm
}
LegionRolling = {
	OpenCount,
	ContinueCount,
	State,
	HeroTemplateId,
	LevelState
}
LegionTrainDetail = {
	Index,
	State,
	TemplateId,
	TrainMode,
	EndTm
}
LegionDinner = {
	OpenState,
	LeftTili,
	SelfState,
	DiamondCost
}
LegionBlessDetail = {
	AttrType,
	MaxLevel,
	Level,
	Addition,
	EndTm,
	Cost
}
LegionBlessLogDetail = {
	RoleName,
	Cost,
	AttrType,
	Addition
}
LegionHongbaoDetail = {
	UUID,
	Type,
	RoleName,
	SendCount,
	LeftCount,
	State
}
LegionHongbaoLogDetail = {
	RoleName,
	Gain
}
LegionPageListAckData = {
	Page,
	PageSize,
	LegionCount,
	LegionList = {}
}
LegionSearchAckData = {
	LegionList = {}
}
LegionCreateAckData = {
	LegionInfo = {},
	LegionDetail = {},
	Wealth = {}
}
LegionApplyAckData = {
	LegionInfo = {},
	LegionDetail = {}
}
LegionJoinQuickAckData = {
	LegionInfo = {},
	LegionDetail = {}
}
LegionClearJoinCDAckData = {
	LegionInfo = {},
	Wealth = {}
}
LegionQuitAckData = {
	LegionInfo = {}
}
LegionGetMembersAckData = {
	ManagerInfo = {},
	MemberList = {}
}
LegionGetApplyAckData = {
	LegionApply = {}
}
LegionGetLogAckData = {
	LogList = {}
}
LegionGetSelfInfoAckData = {
	LegionInfo = {}
}
LegionDonateAckData = {
	LegionInfo = {},
	LegionDetail = {},
	Wealth = {}
}
LegionManageOfficeSetAckData = {
	ManagerInfo = {}
}
LegionManageApplyPassAckData = {
	MemberList = {},
	LegionApply = {}
}
LegionManageKickAckData = {
	MemberList = {}
}
LegionGameRollingOpenAckData = {
	Rolling = {}
}
LegionGameRollingContinueAckData = {
	Rolling = {},
	Wealth = {}
}
LegionGameRollingGainAckData = {
	Rolling = {},
	Wealth = {},
	DataChange = {}
}
LegionGameDinnerOpenAckData = {
	LegionDinner = {}
}
LegionGameDinnerGainAckData = {
	LegionDinner = {},
	Wealth = {}
}
LegionGameGetDinnerAckData = {
	LegionDinner = {}
}
LegionGameGetDinnerLogAckData = {
	LogList = {}
}
LegionGameWelfareAckData = {
	LegionInfo = {},
	Wealth = {},
	DataChange = {}
}
LegionGameTrainStartAckData = {
	Train = {},
	Wealth = {}
}
LegionGameTrainCompleteAckData = {
	Train = {},
	DataChange = {}
}
LegionGameBuyBlessAckData = {
	LegionBless = {},
	Wealth = {}
}
LegionGameGetBlessAckData = {
	LegionBless = {}
}
LegionGameGetBlessLogAckData = {
	LogList = {}
}
LegionGameSendHongbaoAckData = {
	LegionInfo = {},
	LegionHongbao = {},
	Wealth = {},
	DataChange = {}
}
LegionGameGainHongbaoAckData = {
	LegionInfo = {},
	AwardList = {},
	HongbaoDetail = {},
	LogList = {},
	Wealth = {},
	DataChange = {}
}
LegionGameGetHongbaoAckData = {
	LegionHongbao = {}
}
LegionBossStartFightAckData = {
	BattleInfo = {},
	BossId
}
LegionBossDetail = {
	BossId,
	LeftHp,
	StartTm,
	EndTm,
	State
}
LegionBossFightResultAckData = {
	BossInfoList = {},
	AwardList = {},
	Wealth = {},
	DataChange = {},
	BaseInfo = {}
}
LegionBossGetHurtRankAckData = {
	BossId,
	RankList = {}
}
LegionBossRankDetail = {
	HurtHp,
	PlayerInfo = {}
}
LegionBossGetInfoAckData = {
	BossInfoList = {},
	BaseInfo = {}
}
LegionBossBuyBuffAckData = {
	BaseInfo = {},
	Wealth = {}
}
LegionBossGetAwardAckData = {
	BaseInfo = {},
	Wealth = {},
	DataChange = {},
	AwardList = {},
	BossInfo = {}
}
LegionWarBaseInfo = {
	State,
	ApplyStartTm,
	ApplyEndTm,
	FightStartTm,
	FightEndTm,
	DailyCombatMax,
	DailyCombatNum,
	DailyRepairMax,
	DailyRepairNum
}
LegionWarNodeInfo = {
	NodeId,
	NodeState,
	Legion = {},
	HpMax,
	LeftHp,
	DailyLeftHp,
	CD,
	CDState,
	BuildList = {},
	EliteList,
	AttackLegion
}
LegionWarBuildDetail = {
	BuildId,
	HpMax,
	LeftHp,
	DefendList
}
LegionWarLegion = {
	LegionId,
	LegionName,
	Level,
	IconId
}
LegionWarLogDetail = {
	Log,
	LogTm
}
LegionWarReportDetail = {
	Legion = {},
	Score,
	JoinCount
}
LegionWarDailyAwardAckData = {
	NodeId,
	WorldGodDomainNode = {},
	Wealth = {},
	DataChange = {}
}
LegionWarDailyFightStartAckData = {
	NodeId,
	PlayerId,
	NpcId,
	LegionWarBaseInfo = {},
	Wealth = {},
	BattleInfo = {}
}
LegionWarDailyFightResultAckData = {
	NodeId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	Result,
	AwardList = {},
	LossHp,
	Wealth = {},
	DataChange = {},
	GodInfo = {}
}
LegionWarDailyRepairAckData = {
	NodeId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	Wealth = {},
	DataChange = {},
	Donate
}
LegionWarApplyAckData = {
	NodeId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {}
}
LegionWarBuildFightStartAckData = {
	NodeId,
	BuildId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	BattleInfo = {}
}
LegionWarBuildFightResultAckData = {
	NodeId,
	BuildId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	Result,
	DefendCount,
	AwardList = {},
	Wealth = {},
	DataChange = {},
	GodInfo = {},
	Donate,
	Score
}
LegionWarPlayerFightStartAckData = {
	NodeId,
	PlayerId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	BattleInfo = {}
}
LegionWarPlayerFightResultAckData = {
	NodeId,
	PlayerId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	Result,
	AwardList = {},
	Wealth = {},
	DataChange = {},
	GodInfo = {},
	Donate,
	Score
}
LegionWarDefendSetAckData = {
	NodeId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {}
}
LegionWarEliteSetAckData = {
	NodeId,
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {}
}
LegionWarLogAckData = {
	NodeId,
	LogList = {}
}
LegionWarReportAckData = {
	NodeId,
	LegionWarReport = {}
}
LegionWarGetDailyNodeAckData = {
	NodeId,
	WorldGodDomainNode = {},
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	DefendFormation = {},
	NpcId
}
LegionWarGetFightNodeAckData = {
	NodeId,
	WorldGodDomainNode = {},
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	PlayerList = {}
}
LegionWarGetDataAckData = {
	GodDomainList = {},
	LegionWarBaseInfo = {},
	LegionWarNodeList = {}
}
LegionWarBuildDefendInfoAckData = {
	NodeId,
	BuildId,
	WorldGodDomainNode = {},
	LegionWarBaseInfo = {},
	LegionWarNodeInfo = {},
	DefendList = {},
	NpcId
}
ErrorCodeAck = {
	ReqMsgId,
	RetCode,
	SyncId
}
LS_LoginReq = {
	ChannelId,
	Token
}
LS_LoginAck = {
	AccountId,
	Account,
	Ticket
}
AS_AreaListReq = {
	Account,
	AccountId,
	Version,
	Channel,
	Platform
}
AS_AreaListAck = {
	Platform,
	DefaultSid,
	ServerList = {}
}
AS_ServerData = {
	SortId,
	ServerId,
	ServerName,
	WSIP,
	WSPort,
	ServerStatus
}
AS_NoticeListReq = {
	Channel,
	Platform,
	ServerId
}
AS_NoticeListAck = {
	NoticeList = {}
}
AS_NoticeData = {
	SortId,
	Title,
	SubTitle,
	Content,
	Status
}
AS_RoleInfoReq = {
	Platform,
	Channel,
	AccountId
}
AS_RoleInfoAck = {
	RoleList = {}
}
AS_RoleData = {
	ServerId,
	PlayerId,
	RoleName,
	Level,
	VipLevel,
	AvatarId,
	LastTime
}
AS_ClientAddressReq = {
	Version,
	Platform,
	Channel
}
AS_ClientAddressAck = {
	Package,
	Res,
	Dump,
	LoginServer,
	AreaServer,
	PayServer
}
AS_AccountCheckReq = {
	Platform,
	Channel,
	AccountId
}
AS_AccountCheckAck = {
	Ret
}
AS_AccountActivateReq = {
	Platform,
	Channel,
	AccountId,
	AcCode
}
AS_AccountActivateAck = {
	Ret
}
WS_Login_GameReq = {
	ServerId,
	ChannelId,
	AccountId,
	Account,
	IMEI,
	Version,
	Platform,
	Ticket
}
WS_Login_GameAck = {
	RetData = {}
}
WS_Login_GameCompleteReq = {}
WS_Login_GameCompleteAck = {
	RetData = {}
}
WS_Login_OutReq = {}
WS_Login_OutAck = {
	RetData
}
WS_Player_BaseFormationReq = {
	PlayerId
}
WS_Player_BaseFormationAck = {
	RetData = {}
}
WS_Player_FormationReq = {
	PlayerId
}
WS_Player_FormationAck = {
	RetData = {}
}
WS_Player_GameInfoReq = {
	PlayerId
}
WS_Player_GameInfoAck = {
	RetData = {}
}
WS_HeroFrag_ComposeReq = {
	TemplateId
}
WS_HeroFrag_ComposeAck = {
	RetData = {}
}
WS_HeroFrag_DecomposeReq = {
	FragList
}
WS_HeroFrag_DecomposeAck = {
	RetData = {}
}
WS_HeroFrag_ExchangeSoulReq = {
	FragList
}
WS_HeroFrag_ExchangeSoulAck = {
	RetData = {}
}
WS_Hero_UpgradeReq = {
	HeroTid,
	ItemTid,
	Count
}
WS_Hero_UpgradeAck = {
	RetData = {}
}
WS_Hero_UpgradeQualityReq = {
	TemplateId
}
WS_Hero_UpgradeQualityAck = {
	RetData = {}
}
WS_Hero_UpgradeStarReq = {
	TemplateId
}
WS_Hero_UpgradeStarAck = {
	RetData = {}
}
WS_Hero_WearEquipReq = {
	SrcSlot = {},
	DstSlot = {}
}
WS_Hero_WearEquipAck = {
	RetData = {}
}
WS_Hero_SwapEquipReq = {
	SrcHero,
	DstHero
}
WS_Hero_SwapEquipAck = {
	RetData = {}
}
WS_Hero_FastUpgradeEquipReq = {
	TemplateId
}
WS_Hero_FastUpgradeEquipAck = {
	RetData = {}
}
WS_Hero_UpgradeSkillReq = {
	TemplateId,
	Index,
	ToLevel
}
WS_Hero_UpgradeSkillAck = {
	RetData = {}
}
WS_Hero_XilianReq = {
	TemplateId,
	Type,
	Count
}
WS_Hero_XilianAck = {
	RetData = {}
}
WS_Hero_TupoReq = {
	TemplateId
}
WS_Hero_TupoAck = {
	RetData = {}
}
WS_Hero_CastReq = {
	TemplateId,
	Index
}
WS_Hero_CastAck = {
	RetData = {}
}
WS_Hero_ExchangeFateReq = {
	TemplateId,
	FateIdRes,
	FateIdDes
}
WS_Hero_ExchangeFateAck = {
	RetData = {}
}
WS_HeroSoul_BuyReq = {
	HeroSoulId,
	HallId,
	Position
}
WS_HeroSoul_BuyAck = {
	RetData = {}
}
WS_HeroSoul_ExchangeReq = {
	Position,
	HallId,
	ResHeroSoulId,
	DesHeroSoulId
}
WS_HeroSoul_ExchangeAck = {
	RetData = {}
}
WS_Hero_PutOnPartnerReq = {
	Index,
	HeroTemplateId,
	PartnerTemplateId
}
WS_Hero_PutOnPartnerAck = {
	RetData = {}
}
WS_Hero_PutDownPartnerReq = {
	Index,
	HeroTemplateId
}
WS_Hero_PutDownPartnerAck = {
	RetData = {}
}
WS_Hero_UpgradeSatisfyReq = {
	DessertTemplateId,
	HeroTemplateId,
	ActionType
}
WS_Hero_UpgradeSatisfyAck = {
	RetData = {}
}
WS_Hero_CalcResetReq = {
	TemplateId,
	Diamond
}
WS_Hero_CalcResetAck = {
	RetData = {}
}
WS_Hero_ConfirmResetReq = {
	TemplateId,
	Diamond
}
WS_Hero_ConfirmResetAck = {
	RetData = {}
}
WS_Bag_GemComposeReq = {
	ItemList
}
WS_Bag_GemComposeAck = {
	RetData = {}
}
WS_Bag_SaleItemReq = {
	ItemList
}
WS_Bag_SaleItemAck = {
	RetData = {}
}
WS_Bag_OpenBoxReq = {
	TemplateId,
	Count
}
WS_Bag_OpenBoxAck = {
	RetData = {}
}
WS_Equip_UpgradeReq = {
	SrcSlot = {},
	ToLevel
}
WS_Equip_UpgradeAck = {
	RetData = {}
}
WS_Equip_CuilianReq = {
	SrcSlot = {},
	ItemTid,
	Count
}
WS_Equip_CuilianAck = {
	RetData = {}
}
WS_Equip_ComposeReq = {
	TemplateId
}
WS_Equip_ComposeAck = {
	RetData = {}
}
WS_Equip_DecomposeReq = {
	EquipList,
	FragList
}
WS_Equip_DecomposeAck = {
	RetData = {}
}
WS_Equip_OpenHoleReq = {
	SrcSlot = {}
}
WS_Equip_OpenHoleAck = {
	RetData = {}
}
WS_Equip_RefreshHoleReq = {
	SrcSlot = {}
}
WS_Equip_RefreshHoleAck = {
	RetData = {}
}
WS_Equip_GemSetReq = {
	SrcSlot = {},
	Index,
	GemTid
}
WS_Equip_GemSetAck = {
	RetData = {}
}
WS_Equip_GemRemoveReq = {
	SrcSlot = {},
	Index
}
WS_Equip_GemRemoveAck = {
	RetData = {}
}
WS_Equip_UpStarReq = {
	SrcSlot = {}
}
WS_Equip_UpStarAck = {
	RetData = {}
}
WS_Building_GetDataReq = {}
WS_Building_GetDataAck = {
	RetData = {}
}
WS_Building_UpgradeReq = {
	BuildingId
}
WS_Building_UpgradeAck = {
	RetData = {}
}
WS_Building_ImmCompleteReq = {
	BuildingId
}
WS_Building_ImmCompleteAck = {
	RetData = {}
}
WS_Building_IncomeReq = {
	BuildingId
}
WS_Building_IncomeAck = {
	RetData = {}
}
WS_Tech_UpgradeReq = {
	TechId
}
WS_Tech_UpgradeAck = {
	RetData = {}
}
WS_Tech_FastUpgradeReq = {
	TechId
}
WS_Tech_FastUpgradeAck = {
	RetData = {}
}
WS_Tech_GetDataReq = {}
WS_Tech_GetDataAck = {
	RetData = {}
}
WS_God_UpgradeReq = {
	ItemTid,
	Count
}
WS_God_UpgradeAck = {
	RetData = {}
}
WS_God_UpgradeStarReq = {}
WS_God_UpgradeStarAck = {
	RetData = {}
}
WS_God_UpgradeSkillReq = {
	Index
}
WS_God_UpgradeSkillAck = {
	RetData = {}
}
WS_God_ChangeReq = {
	GodId
}
WS_God_ChangeAck = {
	RetData = {}
}
WS_Formation_SaveReq = {
	TechId,
	GodId,
	Layout
}
WS_Formation_SaveAck = {
	RetData = {}
}
WS_MainTask_GetDataReq = {}
WS_MainTask_GetDataAck = {
	RetData = {}
}
WS_MainTask_AwardReq = {
	TaskId
}
WS_MainTask_AwardAck = {
	RetData = {}
}
WS_DailyTask_GetDataReq = {}
WS_DailyTask_GetDataAck = {
	RetData = {}
}
WS_DailyTask_CompleteReq = {
	TaskType
}
WS_DailyTask_CompleteAck = {
	RetData = {}
}
WS_DailyTask_AwardReq = {
	Active
}
WS_DailyTask_AwardAck = {
	RetData = {}
}
WS_GameLevel_FightStartReq = {
	ForceId,
	LevelId,
	LevelType,
	TeamList
}
WS_GameLevel_FightStartAck = {
	RetData = {}
}
WS_GameLevel_FightResultReq = {
	ForceId,
	LevelId,
	LevelType,
	RandomSeed,
	Result,
	Energy,
	TeamList,
	Sign
}
WS_GameLevel_FightResultAck = {
	RetData = {}
}
WS_GameLevel_SaoDangReq = {
	ForceId,
	LevelId,
	LevelType,
	Count
}
WS_GameLevel_SaoDangAck = {
	RetData = {}
}
WS_GameLevel_StarAwardReq = {
	ForceId,
	LevelType,
	StarCount
}
WS_GameLevel_StarAwardAck = {
	RetData = {}
}
WS_GameLevel_ResetReq = {
	ForceId,
	LevelId,
	LevelType
}
WS_GameLevel_ResetAck = {
	RetData = {}
}
WS_GameLevel_GetDataReq = {}
WS_GameLevel_GetDataAck = {
	RetData = {}
}
WS_Team_ResetHireReq = {
	PlayerId
}
WS_Team_ResetHireAck = {
	RetData = {}
}
WS_Trial_FightStartReq = {
	TrialType,
	Level
}
WS_Trial_FightStartAck = {
	RetData = {}
}
WS_Trial_FightResultReq = {
	TrialType,
	Level,
	HpPercent,
	Result,
	Energy,
	RandomSeed,
	Sign
}
WS_Trial_FightResultAck = {
	RetData = {}
}
WS_Trial_GetInfoReq = {}
WS_Trial_GetInfoAck = {
	RetData = {}
}
WS_Trial_SaoDangReq = {
	TrialType,
	Level
}
WS_Trial_SaoDangAck = {
	RetData = {}
}
WS_Arena_GetDataReq = {}
WS_Arena_GetDataAck = {
	RetData = {}
}
WS_Arena_FightStartReq = {
	PlayerId
}
WS_Arena_FightStartAck = {
	RetData = {}
}
WS_Arena_FightResultReq = {
	PlayerId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_Arena_FightResultAck = {
	RetData = {}
}
WS_Arena_RecordListReq = {}
WS_Arena_RecordListAck = {
	RetData = {}
}
WS_Arena_ResetReq = {}
WS_Arena_ResetAck = {
	RetData = {}
}
WS_Arena_SignatureReq = {
	Content
}
WS_Arena_SignatureAck = {
	RetData = {}
}
WS_Pata_FightStartReq = {
	Layer
}
WS_Pata_FightStartAck = {
	RetData = {}
}
WS_Pata_BuyBuffReq = {
	BuffId
}
WS_Pata_BuyBuffAck = {
	RetData = {}
}
WS_Pata_GetAwardReq = {
	BrandIndex
}
WS_Pata_GetAwardAck = {
	RetData = {}
}
WS_Pata_NextLayerReq = {
	Layer
}
WS_Pata_NextLayerAck = {
	RetData = {}
}
WS_Pata_FightResultReq = {
	RandomSeed,
	Result,
	Energy,
	Sign,
	Layer
}
WS_Pata_FightResultAck = {
	RetData = {}
}
WS_Pata_TurnBrandReq = {
	Index
}
WS_Pata_TurnBrandAck = {
	RetData = {}
}
WS_Pata_SaoDangTurnBrandReq = {
	Layer,
	Index
}
WS_Pata_SaoDangTurnBrandAck = {
	RetData = {}
}
WS_Pata_SaoDangNextReq = {}
WS_Pata_SaoDangNextAck = {
	RetData = {}
}
WS_Pata_SaoDangBuyBuffReq = {
	BuffId
}
WS_Pata_SaoDangBuyBuffAck = {
	RetData = {}
}
WS_Pata_GetScoreAwardReq = {
	AwardScore
}
WS_Pata_GetScoreAwardAck = {
	RetData = {}
}
WS_Pata_SaoDangTurnBrandNextReq = {}
WS_Pata_SaoDangTurnBrandNextAck = {
	RetData = {}
}
WS_Pata_SaoDangBuyBuffNextReq = {}
WS_Pata_SaoDangBuyBuffNextAck = {
	RetData = {}
}
WS_Pata_GetInfoReq = {}
WS_Pata_GetInfoAck = {
	RetData = {}
}
WS_Pata_StartSaoDangReq = {}
WS_Pata_StartSaoDangAck = {
	RetData = {}
}
WS_Bgz_FightStartReq = {
	Index
}
WS_Bgz_FightStartAck = {
	RetData = {}
}
WS_Bgz_FightResultReq = {
	RandomSeed,
	Result,
	Energy,
	Sign,
	Index
}
WS_Bgz_FightResultAck = {
	RetData = {}
}
WS_Bgz_GetAwardReq = {}
WS_Bgz_GetAwardAck = {
	RetData = {}
}
WS_Bgz_GetScoreAwardReq = {
	Score
}
WS_Bgz_GetScoreAwardAck = {
	RetData = {}
}
WS_Bgz_GetInfoReq = {}
WS_Bgz_GetInfoAck = {
	RetData = {}
}
WS_Bgz_ResetReq = {}
WS_Bgz_ResetAck = {
	RetData = {}
}
WS_Bgz_GetBossInfoReq = {
	Index
}
WS_Bgz_GetBossInfoAck = {
	RetData = {}
}
WS_World_GetInfoReq = {}
WS_World_GetInfoAck = {
	RetData = {}
}
WS_World_UnlockReq = {
	NodeId
}
WS_World_UnlockAck = {
	RetData = {}
}
WS_World_GetLogReq = {}
WS_World_GetLogAck = {
	RetData = {}
}
WS_WorldRes_GetInfoReq = {}
WS_WorldRes_GetInfoAck = {
	RetData = {}
}
WS_WorldRes_FightStartReq = {
	NodeId
}
WS_WorldRes_FightStartAck = {
	RetData = {}
}
WS_WorldRes_FightResultReq = {
	NodeId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_WorldRes_FightResultAck = {
	RetData = {}
}
WS_WorldRes_GainReq = {
	NodeId
}
WS_WorldRes_GainAck = {
	RetData = {}
}
WS_WorldRes_RefreshReq = {
	NodeId
}
WS_WorldRes_RefreshAck = {
	RetData = {}
}
WS_WorldRes_ClearCDReq = {
	NodeId
}
WS_WorldRes_ClearCDAck = {
	RetData = {}
}
WS_WorldRes_SettleReq = {}
WS_WorldRes_SettleAck = {
	RetData = {}
}
WS_WorldRes_ChangeReq = {}
WS_WorldRes_ChangeAck = {
	RetData
}
WS_WorldRes_TauntReq = {
	NodeId,
	Content
}
WS_WorldRes_TauntAck = {
	Ret
}
WS_WorldTask_StartReq = {
	NodeId,
	Count,
	HeroList
}
WS_WorldTask_StartAck = {
	RetData = {}
}
WS_WorldTask_GainReq = {
	NodeId,
	Index
}
WS_WorldTask_GainAck = {
	RetData = {}
}
WS_WorldSpe_GetInfoReq = {}
WS_WorldSpe_GetInfoAck = {
	RetData = {}
}
WS_WorldSpe_OpenReq = {
	NodeId
}
WS_WorldSpe_OpenAck = {
	RetData = {}
}
WS_WorldSpe_HCFightStartReq = {
	NodeId
}
WS_WorldSpe_HCFightStartAck = {
	RetData = {}
}
WS_WorldSpe_HCFightResultReq = {
	NodeId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_WorldSpe_HCFightResultAck = {
	RetData = {}
}
WS_WorldSpe_HCGiveUpReq = {
	NodeId
}
WS_WorldSpe_HCGiveUpAck = {
	RetData = {}
}
WS_WorldSpe_BgzBribeReq = {
	NodeId
}
WS_WorldSpe_BgzBribeAck = {
	RetData = {}
}
WS_WorldSpe_FaceStartReq = {
	NodeId,
	Face
}
WS_WorldSpe_FaceStartAck = {
	RetData = {}
}
WS_WorldSpe_FaceEndReq = {
	NodeId
}
WS_WorldSpe_FaceEndAck = {
	RetData = {}
}
WS_WorldSpe_AwardBoxReq = {
	NodeId
}
WS_WorldSpe_AwardBoxAck = {
	RetData = {}
}
WS_WorldBoss_StartFightReq = {}
WS_WorldBoss_StartFightAck = {
	RetData = {}
}
WS_WorldBoss_FightResultReq = {
	HpPercent,
	HurtHp,
	RandomSeed,
	FightCount,
	Sign
}
WS_WorldBoss_FightResultAck = {
	RetData = {}
}
WS_WorldBoss_ClearCDReq = {}
WS_WorldBoss_ClearCDAck = {
	RetData = {}
}
WS_WorldBoss_InspireReq = {}
WS_WorldBoss_InspireAck = {
	RetData = {}
}
WS_WorldBoss_DamageRankReq = {}
WS_WorldBoss_DamageRankAck = {
	RetData = {}
}
WS_WorldBoss_GetInfoReq = {}
WS_WorldBoss_GetInfoAck = {
	RetData = {}
}
WS_WorldBoss_GetAwardReq = {}
WS_WorldBoss_GetAwardAck = {
	RetData = {}
}
WS_Legion_PageListReq = {
	Page
}
WS_Legion_PageListAck = {
	RetData = {}
}
WS_Legion_SearchReq = {
	LegionName
}
WS_Legion_SearchAck = {
	RetData = {}
}
WS_Legion_CreateReq = {
	IconId,
	LegionName
}
WS_Legion_CreateAck = {
	RetData = {}
}
WS_Legion_ApplyReq = {
	LegionId
}
WS_Legion_ApplyAck = {
	RetData = {}
}
WS_Legion_JoinQuickReq = {}
WS_Legion_JoinQuickAck = {
	RetData = {}
}
WS_Legion_ClearJoinCDReq = {}
WS_Legion_ClearJoinCDAck = {
	RetData = {}
}
WS_Legion_QuitReq = {}
WS_Legion_QuitAck = {
	RetData = {}
}
WS_Legion_GetDataReq = {}
WS_Legion_GetDataAck = {
	RetData = {}
}
WS_Legion_GetMembersReq = {}
WS_Legion_GetMembersAck = {
	RetData = {}
}
WS_Legion_GetApplyReq = {}
WS_Legion_GetApplyAck = {
	RetData = {}
}
WS_Legion_GetLogReq = {}
WS_Legion_GetLogAck = {
	RetData = {}
}
WS_Legion_GetSelfInfoReq = {}
WS_Legion_GetSelfInfoAck = {
	RetData = {}
}
WS_Legion_DonateReq = {
	LegionTechId,
	Type
}
WS_Legion_DonateAck = {
	RetData = {}
}
WS_LegionManage_SignatureReq = {
	Signature
}
WS_LegionManage_SignatureAck = {
	RetData = {}
}
WS_LegionManage_JoinSetReq = {
	LimitLvl,
	Confirm
}
WS_LegionManage_JoinSetAck = {
	RetData = {}
}
WS_LegionManage_OfficeSetReq = {
	PlayerId,
	Office
}
WS_LegionManage_OfficeSetAck = {
	RetData = {}
}
WS_LegionManage_ApplyPassReq = {
	PlayerId
}
WS_LegionManage_ApplyPassAck = {
	RetData = {}
}
WS_LegionManage_ApplyRefuseReq = {
	PlayerId
}
WS_LegionManage_ApplyRefuseAck = {
	RetData
}
WS_LegionManage_KickReq = {
	PlayerId
}
WS_LegionManage_KickAck = {
	RetData = {}
}
WS_LegionGame_RollingOpenReq = {}
WS_LegionGame_RollingOpenAck = {
	RetData = {}
}
WS_LegionGame_RollingContinueReq = {}
WS_LegionGame_RollingContinueAck = {
	RetData = {}
}
WS_LegionGame_RollingGainReq = {}
WS_LegionGame_RollingGainAck = {
	RetData = {}
}
WS_LegionGame_DinnerOpenReq = {}
WS_LegionGame_DinnerOpenAck = {
	RetData = {}
}
WS_LegionGame_DinnerGainReq = {
	Type
}
WS_LegionGame_DinnerGainAck = {
	RetData = {}
}
WS_LegionGame_GetDinnerReq = {}
WS_LegionGame_GetDinnerAck = {
	RetData = {}
}
WS_LegionGame_GetDinnerLogReq = {}
WS_LegionGame_GetDinnerLogAck = {
	RetData = {}
}
WS_LegionGame_WelfareReq = {}
WS_LegionGame_WelfareAck = {
	RetData = {}
}
WS_LegionGame_TrainStartReq = {
	Index,
	TemplateId,
	TrainMode
}
WS_LegionGame_TrainStartAck = {
	RetData = {}
}
WS_LegionGame_TrainCompleteReq = {
	Index
}
WS_LegionGame_TrainCompleteAck = {
	RetData = {}
}
WS_LegionGame_BuyBlessReq = {
	AttrType
}
WS_LegionGame_BuyBlessAck = {
	RetData = {}
}
WS_LegionGame_GetBlessReq = {}
WS_LegionGame_GetBlessAck = {
	RetData = {}
}
WS_LegionGame_GetBlessLogReq = {}
WS_LegionGame_GetBlessLogAck = {
	RetData = {}
}
WS_LegionGame_SendHongbaoReq = {
	Type
}
WS_LegionGame_SendHongbaoAck = {
	RetData = {}
}
WS_LegionGame_GainHongbaoReq = {
	UUID
}
WS_LegionGame_GainHongbaoAck = {
	RetData = {}
}
WS_LegionGame_GetHongbaoReq = {}
WS_LegionGame_GetHongbaoAck = {
	RetData = {}
}
WS_LegionBoss_StartFightReq = {
	BossId
}
WS_LegionBoss_StartFightAck = {
	RetData = {}
}
WS_LegionBoss_FightResultReq = {
	RandomSeed,
	Energy,
	Sign,
	HpPercent,
	HurtHp,
	BossId
}
WS_LegionBoss_FightResultAck = {
	RetData = {}
}
WS_LegionBoss_GetHurtRankReq = {
	BossId
}
WS_LegionBoss_GetHurtRankAck = {
	RetData = {}
}
WS_LegionBoss_GetInfoReq = {}
WS_LegionBoss_GetInfoAck = {
	RetData = {}
}
WS_LegionBoss_BuyBuffReq = {
	BuffId
}
WS_LegionBoss_BuyBuffAck = {
	RetData = {}
}
WS_LegionBoss_GetAwardReq = {
	BossId
}
WS_LegionBoss_GetAwardAck = {
	RetData = {}
}
WS_LegionWar_DailyAwardReq = {
	NodeId
}
WS_LegionWar_DailyAwardAck = {
	RetData = {}
}
WS_LegionWar_DailyFightStartReq = {
	NodeId,
	PlayerId,
	NpcId
}
WS_LegionWar_DailyFightStartAck = {
	RetData = {}
}
WS_LegionWar_DailyFightResultReq = {
	NodeId,
	PlayerId,
	NpcId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_LegionWar_DailyFightResultAck = {
	RetData = {}
}
WS_LegionWar_DailyRepairReq = {
	NodeId,
	RepairType
}
WS_LegionWar_DailyRepairAck = {
	RetData = {}
}
WS_LegionWar_ApplyReq = {
	NodeId
}
WS_LegionWar_ApplyAck = {
	RetData = {}
}
WS_LegionWar_BuildFightStartReq = {
	NodeId,
	BuildId
}
WS_LegionWar_BuildFightStartAck = {
	RetData = {}
}
WS_LegionWar_BuildFightResultReq = {
	NodeId,
	BuildId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_LegionWar_BuildFightResultAck = {
	RetData = {}
}
WS_LegionWar_PlayerFightStartReq = {
	NodeId,
	PlayerId
}
WS_LegionWar_PlayerFightStartAck = {
	RetData = {}
}
WS_LegionWar_PlayerFightResultReq = {
	NodeId,
	PlayerId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_LegionWar_PlayerFightResultAck = {
	RetData = {}
}
WS_LegionWar_DefendSetReq = {
	NodeId,
	PlayerList
}
WS_LegionWar_DefendSetAck = {
	RetData = {}
}
WS_LegionWar_EliteSetReq = {
	NodeId,
	PlayerList
}
WS_LegionWar_EliteSetAck = {
	RetData = {}
}
WS_LegionWar_LogReq = {
	NodeId
}
WS_LegionWar_LogAck = {
	RetData = {}
}
WS_LegionWar_ReportReq = {
	NodeId
}
WS_LegionWar_ReportAck = {
	RetData = {}
}
WS_LegionWar_GetDailyNodeReq = {
	NodeId
}
WS_LegionWar_GetDailyNodeAck = {
	RetData = {}
}
WS_LegionWar_GetFightNodeReq = {
	NodeId
}
WS_LegionWar_GetFightNodeAck = {
	RetData = {}
}
WS_LegionWar_GetDataReq = {}
WS_LegionWar_GetDataAck = {
	RetData = {}
}
WS_LegionWar_BuildDefendInfoReq = {
	NodeId,
	BuildId
}
WS_LegionWar_BuildDefendInfoAck = {
	RetData = {}
}
WS_Common_GetGameEnvReq = {}
WS_Common_GetGameEnvAck = {
	RetData = {}
}
WS_Common_SetFirstReq = {
	AvatarId,
	RoleName
}
WS_Common_SetFirstAck = {
	RetData = {}
}
WS_Common_SetRoleNameReq = {
	RoleName
}
WS_Common_SetRoleNameAck = {
	RetData = {}
}
WS_Common_SetHeadIdReq = {
	HeadId
}
WS_Common_SetHeadIdAck = {
	RetData = {}
}
WS_Common_DiamondExchangeReq = {
	ExchangeType
}
WS_Common_DiamondExchangeAck = {
	RetData = {}
}
WS_Common_BuyHornReq = {
	Count
}
WS_Common_BuyHornAck = {
	RetData = {}
}
WS_Common_BattleRecordReq = {
	UUID
}
WS_Common_BattleRecordAck = {
	RetData = {}
}
WS_Common_HeartBeatReq = {}
WS_Common_HeartBeatAck = {
	RetData = {}
}
WS_Common_FightStartReq = {
	PlayerId
}
WS_Common_FightStartAck = {
	RetData = {}
}
WS_Common_FightResultReq = {
	PlayerId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_Common_FightResultAck = {
	RetData = {}
}
WS_SyncDataNtf = {
	SyncId
}
WS_SyncData_GameInfoReq = {}
WS_SyncData_GameInfoAck = {
	RetData = {}
}
WS_SyncData_UpgradeInfoReq = {}
WS_SyncData_UpgradeInfoAck = {
	RetData = {}
}
WS_SyncData_FormationReq = {}
WS_SyncData_FormationAck = {
	RetData = {}
}
WS_SyncData_HeroListReq = {}
WS_SyncData_HeroListAck = {
	RetData = {}
}
WS_Friends_GetDataReq = {}
WS_Friends_GetDataAck = {
	RetData = {}
}
WS_Friends_ApplyReq = {
	PlayerId
}
WS_Friends_ApplyAck = {
	Ret
}
WS_Friends_ApplyPassReq = {
	PlayerId
}
WS_Friends_ApplyPassAck = {
	RetData = {}
}
WS_Friends_ApplyRefuseReq = {
	PlayerId
}
WS_Friends_ApplyRefuseAck = {
	RetData
}
WS_Friends_ApplyRefuseAllReq = {}
WS_Friends_ApplyRefuseAllAck = {
	Ret
}
WS_Friends_DeleteReq = {
	PlayerId
}
WS_Friends_DeleteAck = {
	RetData = {}
}
WS_Friends_ActionReq = {
	PlayerId,
	ActionType
}
WS_Friends_ActionAck = {
	RetData = {}
}
WS_Friends_SearchReq = {
	RoleName
}
WS_Friends_SearchAck = {
	RetData = {}
}
WS_Friends_RecommendReq = {}
WS_Friends_RecommendAck = {
	RetData = {}
}
WS_Friends_FightStartReq = {
	PlayerId
}
WS_Friends_FightStartAck = {
	RetData = {}
}
WS_Friends_FightResultReq = {
	PlayerId,
	RandomSeed,
	Result,
	Energy,
	Sign
}
WS_Friends_FightResultAck = {
	RetData = {}
}
WS_Friends_GiveTiliReq = {
	PlayerId
}
WS_Friends_GiveTiliAck = {
	RetData = {}
}
WS_Friends_GiveTiliAllReq = {}
WS_Friends_GiveTiliAllAck = {
	RetData = {}
}
WS_Friends_GetTiliReq = {
	PlayerId
}
WS_Friends_GetTiliAck = {
	RetData = {}
}
WS_Friends_GetTiliAllReq = {}
WS_Friends_GetTiliAllAck = {
	RetData = {}
}
WS_FriendsBoss_FightStartReq = {
	BossRoleId,
	LevelIndex
}
WS_FriendsBoss_FightStartAck = {
	RetData = {}
}
WS_FriendsBoss_FightResultReq = {
	HpPercent,
	HurtHp,
	BossRoleId,
	LevelIndex
}
WS_FriendsBoss_FightResultAck = {
	RetData = {}
}
WS_FriendsBoss_GetInfoReq = {}
WS_FriendsBoss_GetInfoAck = {
	RetData = {}
}
WS_FriendsBoss_GetBossInfoReq = {}
WS_FriendsBoss_GetBossInfoAck = {
	RetData = {}
}
WS_Chat_SendReq = {
	ChatType,
	SenderId,
	SenderName,
	TargetId,
	IsHorn,
	ChatMsg,
	LinkList = {}
}
WS_Chat_SendAck = {
	RetData = {}
}
WS_ChatNtf = {
	RetData = {}
}
WS_ChatRecordNtf = {
	RetData = {}
}
WS_ScrollNtf = {
	RetData = {}
}
WS_Barrage_SendReq = {
	SMsg,
	DungeonType,
	LevelId,
	LevelWave,
	FontColor,
	FontPos
}
WS_Barrage_SendAck = {
	RetData = {}
}
WS_Barrage_PullReq = {
	DungeonType,
	LevelId,
	LevelWave
}
WS_Barrage_PullAck = {
	RetData = {}
}
WS_Vip_CreateOrderReq = {
	GoodsId,
	Extra,
	Sign
}
WS_Vip_CreateOrderAck = {
	RetData = {}
}
WS_Vip_SuccessOrderReq = {}
WS_Vip_SuccessOrderAck = {
	RetData = {}
}
WS_Vip_VipGiftBuyReq = {
	VipLevel
}
WS_Vip_VipGiftBuyAck = {
	RetData = {}
}
WS_Rank_ArenaReq = {}
WS_Rank_ArenaAck = {
	RetData = {}
}
WS_Rank_CommReq = {
	RankType
}
WS_Rank_CommAck = {
	RetData = {}
}
WS_Rank_LegionReq = {}
WS_Rank_LegionAck = {
	RetData = {}
}
WS_Rank_HeroReq = {}
WS_Rank_HeroAck = {
	RetData = {}
}
WS_Mail_GetListReq = {}
WS_Mail_GetListAck = {
	RetData = {}
}
WS_Mail_ReadReq = {
	MailId
}
WS_Mail_ReadAck = {
	Ret
}
WS_Mail_GetAwardReq = {
	MailId
}
WS_Mail_GetAwardAck = {
	RetData = {}
}
WS_Mail_GetAllAwardReq = {}
WS_Mail_GetAllAwardAck = {
	RetData = {}
}
WS_Mail_DeleteReq = {
	DelList
}
WS_Mail_DeleteAck = {
	RetData
}
WS_Shop_GetShopItemsReq = {}
WS_Shop_GetShopItemsAck = {
	RetData = {}
}
WS_Shop_RefreshReq = {
	ShopType
}
WS_Shop_RefreshAck = {
	RetData = {}
}
WS_Shop_BuyReq = {
	ShopType,
	ShopItemIndex
}
WS_Shop_BuyAck = {
	RetData = {}
}
WS_HeroComment_AddCommentReq = {
	HeroTemplateId,
	Content
}
WS_HeroComment_AddCommentAck = {
	RetData = {}
}
WS_HeroComment_ThumbReq = {
	HeroTemplateId,
	UUID,
	ThumbCnt
}
WS_HeroComment_ThumbAck = {
	RetData = {}
}
WS_HeroComment_PullCommentReq = {
	HeroTemplateId,
	LastRecordTm
}
WS_HeroComment_PullCommentAck = {
	RetData = {}
}
WS_Treasure_StartReq = {
	ForceId,
	LevelType
}
WS_Treasure_StartAck = {
	RetData = {}
}
WS_Treasure_FastStartReq = {
	ForceId,
	LevelType
}
WS_Treasure_FastStartAck = {
	RetData = {}
}
WS_Treasure_GetBoxAwardReq = {
	ForceId,
	LevelType,
	BoxIndex
}
WS_Treasure_GetBoxAwardAck = {
	RetData = {}
}
WS_Treasure_GetInfoReq = {}
WS_Treasure_GetInfoAck = {
	RetData = {}
}
WS_Dolls_PutCoinReq = {}
WS_Dolls_PutCoinAck = {
	RetData = {}
}
WS_Dolls_GrabReq = {
	Index
}
WS_Dolls_GrabAck = {
	RetData = {}
}
WS_Dolls_GetInfoReq = {}
WS_Dolls_GetInfoAck = {
	RetData = {}
}
WS_Bar_DrawReq = {}
WS_Bar_DrawAck = {
	RetData = {}
}
WS_ActivityAct_DailySignReq = {}
WS_ActivityAct_DailySignAck = {
	RetData = {}
}
WS_ActivityAct_TiliReq = {}
WS_ActivityAct_TiliAck = {
	RetData = {}
}
WS_ActivityAct_TiliAddedReq = {
	Index
}
WS_ActivityAct_TiliAddedAck = {
	RetData = {}
}
WS_ActivityAct_CrazyUpgradeReq = {
	Level
}
WS_ActivityAct_CrazyUpgradeAck = {
	RetData = {}
}
WS_ActivityAct_LoginVipReq = {}
WS_ActivityAct_LoginVipAck = {
	RetData = {}
}
WS_ActivityAct_WishTabRunReq = {}
WS_ActivityAct_WishTabRunAck = {
	RetData = {}
}
WS_ActivityAct_WishTabRefreshReq = {}
WS_ActivityAct_WishTabRefreshAck = {
	RetData = {}
}
WS_ActivityAct_OnlineAwardReq = {}
WS_ActivityAct_OnlineAwardAck = {
	RetData = {}
}
WS_ActivityAct_VipCardAwardReq = {
	GoodsType
}
WS_ActivityAct_VipCardAwardAck = {
	RetData = {}
}
WS_ActivityAct_TwoCardAwardReq = {}
WS_ActivityAct_TwoCardAwardAck = {
	RetData = {}
}
WS_ActivityAct_FirstRechargeReq = {}
WS_ActivityAct_FirstRechargeAck = {
	RetData = {}
}
WS_ActivityAct_VipSignReq = {}
WS_ActivityAct_VipSignAck = {
	RetData = {}
}
WS_ActivityAct_LuckyDiamondReq = {}
WS_ActivityAct_LuckyDiamondAck = {
	RetData = {}
}
WS_ActivityAct_LuckyDiamondLogReq = {}
WS_ActivityAct_LuckyDiamondLogAck = {
	RetData = {}
}
WS_ActivityAct_BeInviteReq = {
	InviteCode
}
WS_ActivityAct_BeInviteAck = {
	RetData = {}
}
WS_ActivityAct_InviteAwardReq = {
	Count
}
WS_ActivityAct_InviteAwardAck = {
	RetData = {}
}
WS_ActivityAct_RedeemCodeReq = {
	RedeemCode
}
WS_ActivityAct_RedeemCodeAck = {
	RetData = {}
}
WS_ActivityAct_RebateAwardReq = {}
WS_ActivityAct_RebateAwardAck = {
	RetData = {}
}
WS_ActivityOs_GetDataReq = {}
WS_ActivityOs_GetDataAck = {
	RetData = {}
}
WS_ActivityOs_LevelAwardReq = {
	Level
}
WS_ActivityOs_LevelAwardAck = {
	RetData = {}
}
WS_ActivityOs_StarAwardReq = {
	Star
}
WS_ActivityOs_StarAwardAck = {
	RetData = {}
}
WS_ActivityOs_PataAwardReq = {
	Level
}
WS_ActivityOs_PataAwardAck = {
	RetData = {}
}
WS_ActivityOs_FVAwardReq = {
	FV
}
WS_ActivityOs_FVAwardAck = {
	RetData = {}
}
WS_ActivityOs_ArenaAwardReq = {
	Rank
}
WS_ActivityOs_ArenaAwardAck = {
	RetData = {}
}
WS_ActivityOs_LoginAwardReq = {
	Day
}
WS_ActivityOs_LoginAwardAck = {
	RetData = {}
}
WS_ActivityOs_HalfPacksReq = {
	Day
}
WS_ActivityOs_HalfPacksAck = {
	RetData = {}
}
WS_ActivityOs_RechargeAwardReq = {
	Diamond
}
WS_ActivityOs_RechargeAwardAck = {
	RetData = {}
}
WS_ActivityGm_GetDataReq = {}
WS_ActivityGm_GetDataAck = {
	RetData = {}
}
WS_ActivityGm_DailyActiveReq = {
	ActId
}
WS_ActivityGm_DailyActiveAck = {
	RetData = {}
}
WS_ActivityGm_ItemExchangeReq = {
	ActId,
	Index
}
WS_ActivityGm_ItemExchangeAck = {
	RetData = {}
}
WS_ActivityGm_LimitTimeHeroReq = {
	ActId
}
WS_ActivityGm_LimitTimeHeroAck = {
	RetData = {}
}
WS_ActivityGm_LimitTimeScoreReq = {
	ActId,
	Index
}
WS_ActivityGm_LimitTimeScoreAck = {
	RetData = {}
}
WS_ActivityGm_LimitTimeShopReq = {
	ActId,
	Index
}
WS_ActivityGm_LimitTimeShopAck = {
	RetData = {}
}
WS_ActivityGm_FundBuyReq = {}
WS_ActivityGm_FundBuyAck = {
	RetData = {}
}
WS_ActivityGm_FundAwardReq = {
	Level
}
WS_ActivityGm_FundAwardAck = {
	RetData = {}
}
WS_ActivityGm_FundWelfareReq = {
	Count
}
WS_ActivityGm_FundWelfareAck = {
	RetData = {}
}
WS_ActivityGm_RechargeDailyReq = {
	ActId,
	Day
}
WS_ActivityGm_RechargeDailyAck = {
	RetData = {}
}
WS_ActivityGm_RechargeDailySumReq = {
	ActId,
	Diamond
}
WS_ActivityGm_RechargeDailySumAck = {
	RetData = {}
}
WS_ActivityGm_RechargeDailySingleReq = {
	ActId,
	Diamond
}
WS_ActivityGm_RechargeDailySingleAck = {
	RetData = {}
}
WS_ActivityGm_RechargeSingleReq = {
	ActId,
	Diamond
}
WS_ActivityGm_RechargeSingleAck = {
	RetData = {}
}
WS_ActivityGm_RechargeSumReq = {
	ActId,
	Diamond
}
WS_ActivityGm_RechargeSumAck = {
	RetData = {}
}
WS_ActivityGm_ConsumSumReq = {
	ActId,
	Diamond
}
WS_ActivityGm_ConsumSumAck = {
	RetData = {}
}
WS_ActivityGm_ConsumDailySumReq = {
	ActId,
	Diamond
}
WS_ActivityGm_ConsumDailySumAck = {
	RetData = {}
}
MSG_ID = {
	WS_ActivityGm_ConsumSum_Req = 17429,
	WS_LegionWar_PlayerFightStart_Req = 15715,
	WS_ActivityAct_LoginVip_Req = 17111,
	WS_ActivityAct_TiliAdded_Ack = 17106,
	WS_LegionBoss_FightResult_Ack = 15654,
	WS_LegionWar_GetFightNode_Req = 15729,
	WS_ActivityAct_WishTabRefresh_Ack = 17116,
	WS_Vip_CreateOrder_Req = 16401,
	WS_Bgz_GetScoreAward_Req = 14707,
	WS_Rank_Legion_Ack = 16506,
	WS_LegionWar_BuildDefendInfo_Ack = 15734,
	WS_LegionGame_Welfare_Req = 15585,
	AS_AreaList_Ack = 40002,
	WS_LegionWar_EliteSet_Req = 15721,
	WS_WorldSpe_FaceEnd_Req = 15067,
	WS_Pata_NextLayer_Req = 14611,
	WS_FriendsBoss_FightResult_Req = 16243,
	WS_Friends_GetTili_Req = 16227,
	WS_Chat_Ntf = 16304,
	WS_Friends_GiveTili_Ack = 16224,
	WS_Pata_GetInfo_Ack = 14632,
	WS_Equip_GemRemove_Req = 12683,
	WS_LegionBoss_BuyBuff_Req = 15659,
	WS_LegionGame_GetBlessLog_Ack = 15600,
	WS_Friends_Delete_Ack = 16212,
	WS_Friends_GetData_Req = 16201,
	WS_LegionManage_OfficeSet_Req = 15545,
	WS_SyncData_GameInfo_Req = 16103,
	WS_LegionWar_DefendSet_Ack = 15720,
	WS_Common_HeartBeat_Ack = 16058,
	WS_Legion_GetSelfInfo_Req = 15523,
	WS_LegionBoss_GetInfo_Ack = 15658,
	WS_Common_SetFirst_Req = 16003,
	WS_ActivityAct_LuckyDiamond_Ack = 17128,
	WS_Common_BuyHorn_Ack = 16054,
	WS_Bar_Draw_Req = 17001,
	WS_Legion_Apply_Ack = 15508,
	WS_Barrage_Send_Req = 16351,
	WS_WorldBoss_GetAward_Req = 15113,
	ErrorCode_Ack = 20000,
	WS_ActivityOs_StarAward_Req = 17305,
	WS_LegionWar_BuildDefendInfo_Req = 15733,
	WS_FriendsBoss_FightResult_Ack = 16244,
	WS_LegionWar_PlayerFightResult_Req = 15717,
	WS_MainTask_Award_Req = 13603,
	WS_Legion_PageList_Ack = 15502,
	WS_ActivityOs_HalfPacks_Ack = 17316,
	WS_Login_Game_Req = 10001,
	AS_ClientAddress_Ack = 40008,
	WS_Mail_Read_Req = 16903,
	WS_Mail_Delete_Req = 16909,
	WS_WorldRes_ClearCD_Ack = 15032,
	WS_Bag_OpenBox_Req = 12605,
	WS_LegionWar_Apply_Req = 15709,
	WS_Equip_UpStar_Ack = 12686,
	WS_LegionBoss_BuyBuff_Ack = 15660,
	WS_Tech_FastUpgrade_Req = 13023,
	WS_LegionBoss_GetInfo_Req = 15657,
	WS_WorldSpe_HCFightResult_Req = 15057,
	WS_Bgz_FightResult_Ack = 14704,
	WS_LegionGame_GetBless_Ack = 15598,
	WS_Treasure_GetBoxAward_Ack = 18706,
	WS_LegionManage_Signature_Req = 15541,
	WS_LegionGame_Welfare_Ack = 15586,
	WS_HeroComment_Thumb_Req = 18653,
	WS_LegionGame_DinnerGain_Ack = 15580,
	WS_LegionGame_DinnerOpen_Ack = 15578,
	WS_LegionGame_RollingGain_Req = 15575,
	WS_LegionGame_RollingContinue_Ack = 15574,
	WS_Friends_FightStart_Req = 16219,
	WS_LegionManage_ApplyRefuse_Req = 15549,
	WS_LegionManage_ApplyPass_Ack = 15548,
	WS_LegionManage_ApplyPass_Req = 15547,
	WS_MainTask_Award_Ack = 13604,
	WS_WorldBoss_GetInfo_Ack = 15112,
	WS_Friends_GetTili_Ack = 16228,
	WS_LegionManage_JoinSet_Req = 15543,
	WS_Bgz_GetAward_Ack = 14706,
	WS_WorldRes_FightStart_Ack = 15024,
	WS_Legion_GetMembers_Ack = 15518,
	WS_GameLevel_Reset_Ack = 14010,
	WS_WorldBoss_Inspire_Ack = 15108,
	WS_LegionWar_GetDailyNode_Ack = 15728,
	WS_World_GetLog_Ack = 15006,
	WS_Bag_SaleItem_Ack = 12604,
	WS_God_UpgradeSkill_Req = 13205,
	WS_God_UpgradeStar_Req = 13203,
	WS_Legion_GetMembers_Req = 15517,
	WS_WorldBoss_ClearCD_Ack = 15106,
	WS_GameLevel_StarAward_Ack = 14008,
	WS_LegionWar_GetFightNode_Ack = 15730,
	WS_GameLevel_GetData_Ack = 14012,
	WS_Rank_Hero_Ack = 16508,
	WS_Hero_Cast_Ack = 12156,
	WS_Legion_Donate_Ack = 15526,
	AS_AreaList_Req = 40001,
	WS_Pata_SaoDangBuyBuffNext_Req = 14629,
	WS_Friends_GetData_Ack = 16202,
	WS_LegionManage_OfficeSet_Ack = 15546,
	WS_WorldRes_FightResult_Ack = 15026,
	WS_Bag_OpenBox_Ack = 12606,
	WS_Equip_Decompose_Ack = 12664,
	WS_LegionBoss_GetAward_Ack = 15672,
	WS_Common_DiamondExchange_Req = 16051,
	WS_Player_GameInfo_Req = 10105,
	WS_Hero_UpgradeQuality_Ack = 12024,
	WS_DailyTask_GetData_Ack = 13612,
	WS_Building_Income_Ack = 13008,
	WS_Hero_PutOnPartner_Req = 12159,
	WS_Equip_Cuilian_Req = 12653,
	WS_Hero_UpgradeQuality_Req = 12023,
	WS_Tech_FastUpgrade_Ack = 13024,
	WS_FriendsBoss_GetBossInfo_Req = 16247,
	WS_Hero_UpgradeSkill_Req = 12041,
	WS_Pata_SaoDangTurnBrandNext_Ack = 14628,
	WS_WorldBoss_DamageRank_Req = 15109,
	WS_Arena_Reset_Ack = 14510,
	AS_AccountActivate_Ack = 40012,
	WS_DailyTask_Complete_Req = 13613,
	WS_God_UpgradeSkill_Ack = 13206,
	WS_Legion_Search_Req = 15503,
	WS_Pata_FightStart_Ack = 14602,
	WS_Pata_StartSaoDang_Req = 14633,
	WS_HeroFrag_Decompose_Ack = 12004,
	WS_Common_FightResult_Req = 16061,
	WS_Hero_UpgradeSatisfy_Ack = 12164,
	WS_DailyTask_Award_Req = 13615,
	WS_Barrage_Send_Ack = 16352,
	WS_Legion_GetData_Ack = 15516,
	AS_AccountActivate_Req = 40011,
	WS_GameLevel_GetData_Req = 14011,
	WS_LegionWar_BuildFightStart_Req = 15711,
	WS_Bar_Draw_Ack = 17002,
	WS_Hero_UpgradeStar_Req = 12025,
	WS_DailyTask_Complete_Ack = 13614,
	WS_Tech_Upgrade_Ack = 13022,
	WS_ActivityOs_RechargeAward_Req = 17317,
	WS_Common_BuyHorn_Req = 16053,
	WS_Pata_BuyBuff_Req = 14605,
	WS_Hero_SwapEquip_Ack = 12030,
	WS_Bgz_Reset_Req = 14711,
	WS_LegionManage_Kick_Ack = 15552,
	WS_Equip_RefreshHole_Req = 12673,
	WS_Login_GameComplete_Ack = 10004,
	WS_ActivityAct_RebateAward_Ack = 17137,
	WS_Common_FightStart_Ack = 16060,
	WS_WorldSpe_FaceEnd_Ack = 15068,
	WS_Hero_Upgrade_Req = 12021,
	WS_LegionBoss_GetHurtRank_Req = 15655,
	WS_Hero_ExchangeFate_Ack = 12158,
	WS_Hero_Upgrade_Ack = 12022,
	WS_WorldRes_Taunt_Ack = 15038,
	WS_Hero_ConfirmReset_Req = 12167,
	WS_Bgz_FightResult_Req = 14703,
	WS_Bgz_FightStart_Ack = 14702,
	WS_LegionWar_BuildFightResult_Ack = 15714,
	WS_Mail_Delete_Ack = 16910,
	WS_Bgz_Reset_Ack = 14712,
	WS_LegionGame_RollingGain_Ack = 15576,
	WS_World_GetInfo_Req = 15001,
	WS_FriendsBoss_GetInfo_Ack = 16246,
	WS_Legion_Quit_Ack = 15514,
	WS_WorldRes_Gain_Req = 15027,
	WS_LegionGame_GetHongbao_Req = 15605,
	WS_Building_Income_Req = 13007,
	WS_Friends_Action_Req = 16213,
	WS_LegionWar_BuildFightStart_Ack = 15712,
	WS_Vip_SuccessOrder_Req = 16403,
	WS_Pata_GetScoreAward_Ack = 14626,
	WS_LegionGame_TrainStart_Ack = 15588,
	WS_Mail_GetAward_Req = 16905,
	WS_HeroSoul_Exchange_Ack = 12204,
	WS_ActivityGm_RechargeDailySingle_Ack = 17424,
	WS_God_UpgradeStar_Ack = 13204,
	WS_Shop_Buy_Req = 18605,
	WS_HeroComment_PullComment_Req = 18655,
	WS_DailyTask_GetData_Req = 13611,
	WS_LegionWar_Report_Ack = 15726,
	WS_ActivityAct_Tili_Ack = 17104,
	WS_WorldSpe_HCGiveUp_Req = 15059,
	WS_SyncData_GameInfo_Ack = 16104,
	WS_ActivityAct_LoginVip_Ack = 17112,
	WS_ActivityAct_LuckyDiamond_Req = 17127,
	WS_WorldTask_Gain_Req = 15043,
	WS_Common_HeartBeat_Req = 16057,
	WS_ActivityOs_GetData_Ack = 17302,
	WS_LegionGame_BuyBless_Ack = 15596,
	WS_ActivityOs_LevelAward_Req = 17303,
	WS_Building_GetData_Ack = 13002,
	WS_LegionWar_GetDailyNode_Req = 15727,
	WS_ActivityOs_StarAward_Ack = 17306,
	WS_Tech_GetData_Req = 13025,
	WS_LegionWar_PlayerFightResult_Ack = 15718,
	WS_Equip_UpStar_Req = 12685,
	WS_LegionWar_GetData_Req = 15731,
	WS_Friends_Recommend_Req = 16217,
	WS_ActivityOs_PataAward_Ack = 17308,
	WS_Dolls_GetInfo_Req = 18755,
	WS_ActivityOs_FVAward_Ack = 17310,
	WS_ActivityOs_ArenaAward_Req = 17311,
	WS_Treasure_GetInfo_Req = 18707,
	WS_ActivityAct_RedeemCode_Req = 17134,
	WS_Equip_OpenHole_Req = 12671,
	WS_ActivityOs_RechargeAward_Ack = 17318,
	WS_ActivityGm_DailyActive_Req = 17403,
	WS_Player_BaseFormation_Req = 10101,
	WS_ActivityGm_DailyActive_Ack = 17404,
	WS_Arena_FightStart_Req = 14503,
	WS_ActivityGm_ItemExchange_Req = 17405,
	WS_WorldSpe_AwardBox_Req = 15069,
	WS_ActivityGm_LimitTimeScore_Ack = 17410,
	WS_ActivityGm_LimitTimeShop_Req = 17411,
	WS_ActivityGm_LimitTimeShop_Ack = 17412,
	WS_ActivityGm_FundBuy_Req = 17413,
	WS_ActivityGm_FundBuy_Ack = 17414,
	WS_ActivityGm_FundAward_Req = 17415,
	WS_Player_GameInfo_Ack = 10106,
	WS_ActivityAct_VipCardAward_Req = 17119,
	WS_Friends_FightStart_Ack = 16220,
	WS_Mail_Read_Ack = 16904,
	WS_ActivityGm_FundAward_Ack = 17416,
	WS_ActivityGm_FundWelfare_Req = 17417,
	WS_Vip_CreateOrder_Ack = 16402,
	WS_ActivityGm_FundWelfare_Ack = 17418,
	WS_Player_Formation_Ack = 10104,
	WS_Equip_Upgrade_Req = 12651,
	WS_Rank_Arena_Req = 16501,
	WS_ActivityAct_OnlineAward_Ack = 17118,
	WS_ActivityGm_RechargeDaily_Req = 17419,
	WS_Friends_GiveTiliAll_Ack = 16226,
	WS_ActivityGm_RechargeDaily_Ack = 17420,
	WS_Hero_WearEquip_Req = 12027,
	WS_ActivityGm_RechargeDailySum_Ack = 17422,
	WS_Barrage_Pull_Ack = 16354,
	WS_World_GetLog_Req = 15005,
	WS_ActivityGm_RechargeSingle_Req = 17425,
	WS_God_Change_Req = 13207,
	WS_ActivityGm_RechargeSingle_Ack = 17426,
	WS_ActivityGm_RechargeSum_Req = 17427,
	WS_Arena_Signature_Ack = 14512,
	WS_WorldSpe_HCFightResult_Ack = 15058,
	WS_Shop_GetShopItems_Req = 18601,
	WS_Shop_GetShopItems_Ack = 18602,
	WS_Shop_Refresh_Ack = 18604,
	WS_Bag_SaleItem_Req = 12603,
	WS_HeroComment_AddComment_Req = 18651,
	WS_LegionGame_RollingOpen_Ack = 15572,
	WS_HeroComment_Thumb_Ack = 18654,
	WS_WorldRes_Change_Req = 15035,
	WS_GameLevel_FightStart_Req = 14001,
	WS_ActivityAct_LuckyDiamondLog_Req = 17129,
	WS_LegionGame_DinnerOpen_Req = 15577,
	WS_HeroComment_PullComment_Ack = 18656,
	WS_ActivityGm_LimitTimeHero_Req = 17407,
	WS_Treasure_Start_Req = 18701,
	WS_Treasure_Start_Ack = 18702,
	WS_Treasure_FastStart_Req = 18703,
	WS_Treasure_FastStart_Ack = 18704,
	WS_Treasure_GetBoxAward_Req = 18705,
	WS_LegionGame_GetBless_Req = 15597,
	WS_HeroFrag_Compose_Req = 12001,
	WS_ActivityAct_WishTabRun_Ack = 17114,
	WS_Dolls_PutCoin_Ack = 18752,
	WS_LegionGame_TrainStart_Req = 15587,
	WS_Dolls_Grab_Ack = 18754,
	WS_God_Upgrade_Req = 13201,
	WS_ActivityOs_FVAward_Req = 17309,
	WS_LegionWar_DefendSet_Req = 15719,
	WS_Pata_StartSaoDang_Ack = 14634,
	WS_Player_BaseFormation_Ack = 10102,
	WS_WorldRes_Refresh_Req = 15029,
	WS_Common_SetHeadId_Req = 16007,
	WS_World_Unlock_Ack = 15004,
	WS_ActivityGm_ConsumDailySum_Ack = 17432,
	WS_ActivityOs_GetData_Req = 17301,
	WS_LegionWar_EliteSet_Ack = 15722,
	WS_Hero_WearEquip_Ack = 12028,
	WS_Formation_Save_Ack = 13402,
	WS_Common_SetRoleName_Req = 16005,
	WS_LegionGame_GetDinner_Ack = 15582,
	WS_Hero_Cast_Req = 12155,
	WS_Pata_SaoDangTurnBrand_Ack = 14618,
	WS_Scroll_Ntf = 16308,
	WS_Legion_GetApply_Ack = 15520,
	WS_LegionWar_Log_Req = 15723,
	WS_Building_GetData_Req = 13001,
	WS_Arena_Reset_Req = 14509,
	WS_ActivityAct_WishTabRun_Req = 17113,
	WS_ActivityAct_Tili_Req = 17103,
	WS_ActivityAct_BeInvite_Req = 17131,
	WS_LegionGame_RollingOpen_Req = 15571,
	WS_GameLevel_SaoDang_Ack = 14006,
	WS_Rank_Hero_Req = 16507,
	WS_Legion_Create_Ack = 15506,
	WS_Hero_PutOnPartner_Ack = 12160,
	WS_Equip_Cuilian_Ack = 12654,
	WS_HeroSoul_Exchange_Req = 12203,
	WS_Bgz_GetInfo_Req = 14709,
	WS_Common_FightStart_Req = 16059,
	WS_HeroFrag_Compose_Ack = 12002,
	WS_Hero_PutDownPartner_Req = 12161,
	WS_WorldBoss_StartFight_Req = 15101,
	AS_RoleInfo_Ack = 40006,
	WS_Friends_Apply_Req = 16203,
	WS_Mail_GetList_Ack = 16902,
	WS_ActivityGm_GetData_Req = 17401,
	WS_Equip_OpenHole_Ack = 12672,
	WS_LegionWar_DailyFightStart_Ack = 15704,
	WS_LegionGame_GetHongbao_Ack = 15606,
	WS_ActivityAct_TwoCardAward_Req = 17121,
	WS_Friends_Action_Ack = 16214,
	WS_WorldBoss_ClearCD_Req = 15105,
	WS_WorldRes_FightResult_Req = 15025,
	WS_Friends_GetTiliAll_Ack = 16230,
	WS_WorldSpe_BgzBribe_Ack = 15062,
	WS_Pata_FightStart_Req = 14601,
	WS_GameLevel_FightStart_Ack = 14002,
	WS_Formation_Save_Req = 13401,
	WS_Pata_BuyBuff_Ack = 14606,
	WS_ActivityAct_VipSign_Ack = 17126,
	WS_ActivityAct_LuckyDiamondLog_Ack = 17130,
	WS_Pata_GetAward_Ack = 14608,
	WS_Trial_FightResult_Ack = 14104,
	WS_Friends_FightResult_Ack = 16222,
	WS_Common_SetHeadId_Ack = 16008,
	WS_Bgz_GetAward_Req = 14705,
	WS_Rank_Comm_Ack = 16504,
	WS_SyncData_HeroList_Req = 16109,
	WS_Hero_Tupo_Ack = 12154,
	WS_Vip_VipGiftBuy_Ack = 16406,
	AS_RoleInfo_Req = 40005,
	WS_Legion_GetLog_Req = 15521,
	WS_LegionBoss_FightResult_Req = 15653,
	WS_WorldBoss_FightResult_Ack = 15104,
	WS_Equip_Compose_Req = 12661,
	WS_Pata_SaoDangTurnBrandNext_Req = 14627,
	WS_FriendsBoss_GetInfo_Req = 16245,
	WS_Hero_Tupo_Req = 12153,
	WS_LegionWar_DailyFightStart_Req = 15703,
	WS_Trial_FightResult_Req = 14103,
	WS_Equip_GemSet_Ack = 12682,
	WS_Bgz_GetScoreAward_Ack = 14708,
	WS_ActivityGm_ConsumDailySum_Req = 17431,
	WS_WorldBoss_DamageRank_Ack = 15110,
	WS_ActivityGm_RechargeDailySum_Req = 17421,
	WS_GameLevel_Reset_Req = 14009,
	WS_ActivityAct_RedeemCode_Ack = 17135,
	WS_WorldBoss_Inspire_Req = 15107,
	WS_Login_Out_Req = 10005,
	WS_ActivityGm_ItemExchange_Ack = 17406,
	WS_WorldSpe_Open_Ack = 15054,
	WS_Player_Formation_Req = 10103,
	WS_ActivityAct_FirstRecharge_Ack = 17124,
	WS_HeroFrag_Decompose_Req = 12003,
	WS_Legion_GetApply_Req = 15519,
	WS_LegionGame_TrainComplete_Req = 15589,
	WS_MainTask_GetData_Ack = 13602,
	WS_WorldSpe_BgzBribe_Req = 15061,
	WS_Legion_Apply_Req = 15507,
	WS_Pata_SaoDangBuyBuff_Req = 14621,
	WS_LegionBoss_StartFight_Req = 15651,
	WS_WorldSpe_FaceStart_Ack = 15066,
	WS_Friends_Search_Ack = 16216,
	WS_LegionGame_GetDinnerLog_Req = 15583,
	WS_LegionBoss_GetAward_Req = 15671,
	WS_ActivityGm_RechargeSum_Ack = 17428,
	WS_God_Change_Ack = 13208,
	WS_World_GetInfo_Ack = 15002,
	WS_Arena_Signature_Req = 14511,
	WS_ActivityAct_RebateAward_Req = 17136,
	WS_LegionGame_DinnerGain_Req = 15579,
	AS_ErrorCode_Ack = 40000,
	WS_Rank_Comm_Req = 16503,
	WS_SyncData_Formation_Req = 16107,
	WS_Arena_RecordList_Ack = 14508,
	WS_Bag_GemCompose_Req = 12601,
	WS_ChatRecord_Ntf = 16306,
	WS_SyncData_Formation_Ack = 16108,
	WS_Team_ResetHire_Req = 14051,
	WS_Legion_ClearJoinCD_Ack = 15512,
	WS_ActivityAct_InviteAward_Req = 17133,
	WS_Friends_ApplyRefuse_Req = 16207,
	WS_Dolls_GetInfo_Ack = 18756,
	WS_Arena_GetData_Ack = 14502,
	WS_Chat_Send_Req = 16301,
	WS_Trial_SaoDang_Req = 14107,
	WS_ActivityOs_LoginAward_Req = 17313,
	WS_Shop_Refresh_Req = 18603,
	WS_HeroSoul_Buy_Ack = 12202,
	WS_WorldSpe_GetInfo_Ack = 15052,
	WS_Login_GameComplete_Req = 10003,
	WS_LegionWar_DailyAward_Ack = 15702,
	WS_WorldRes_Settle_Ack = 15034,
	WS_Tech_GetData_Ack = 13026,
	WS_WorldBoss_FightResult_Req = 15103,
	WS_Friends_Search_Req = 16215,
	WS_GameLevel_FightResult_Ack = 14004,
	WS_Arena_RecordList_Req = 14507,
	WS_ActivityGm_ConsumSum_Ack = 17430,
	WS_LegionGame_GetDinnerLog_Ack = 15584,
	WS_WorldBoss_GetAward_Ack = 15114,
	WS_WorldSpe_HCFightStart_Req = 15055,
	WS_LegionGame_GetBlessLog_Req = 15599,
	WS_Trial_FightStart_Ack = 14102,
	WS_WorldSpe_FaceStart_Req = 15065,
	WS_Dolls_Grab_Req = 18753,
	WS_LegionGame_RollingContinue_Req = 15573,
	WS_SyncData_HeroList_Ack = 16110,
	WS_LegionWar_DailyRepair_Ack = 15708,
	WS_WorldTask_Gain_Ack = 15044,
	WS_LegionWar_BuildFightResult_Req = 15713,
	WS_Common_GetGameEnv_Req = 16001,
	WS_Legion_ClearJoinCD_Req = 15511,
	WS_SyncData_Ntf = 16102,
	WS_Arena_FightStart_Ack = 14504,
	WS_Hero_FastUpgradeEquip_Ack = 12032,
	WS_Friends_Recommend_Ack = 16218,
	WS_Hero_FastUpgradeEquip_Req = 12031,
	WS_Legion_GetSelfInfo_Ack = 15524,
	WS_SyncData_UpgradeInfo_Ack = 16106,
	WS_Hero_ExchangeFate_Req = 12157,
	WS_Pata_NextLayer_Ack = 14612,
	WS_Pata_SaoDangNext_Ack = 14620,
	WS_WorldRes_Taunt_Req = 15037,
	WS_ActivityAct_DailySign_Ack = 17102,
	WS_Friends_FightResult_Req = 16221,
	WS_WorldTask_Start_Req = 15041,
	WS_Hero_PutDownPartner_Ack = 12162,
	WS_Common_BattleRecord_Ack = 16056,
	WS_Common_FightResult_Ack = 16062,
	WS_WorldSpe_GetInfo_Req = 15051,
	WS_Legion_GetLog_Ack = 15522,
	WS_Trial_SaoDang_Ack = 14108,
	WS_LegionGame_GainHongbao_Req = 15603,
	WS_LegionWar_Log_Ack = 15724,
	WS_Bag_GemCompose_Ack = 12602,
	WS_Legion_JoinQuick_Req = 15509,
	WS_ActivityOs_PataAward_Req = 17307,
	WS_Dolls_PutCoin_Req = 18751,
	WS_WorldRes_Gain_Ack = 15028,
	WS_MainTask_GetData_Req = 13601,
	WS_Pata_GetScoreAward_Req = 14625,
	WS_Hero_SwapEquip_Req = 12029,
	WS_ActivityOs_LoginAward_Ack = 17314,
	WS_Chat_Send_Ack = 16302,
	WS_WorldRes_Settle_Req = 15033,
	WS_Hero_UpgradeSkill_Ack = 12042,
	WS_Arena_GetData_Req = 14501,
	WS_HeroSoul_Buy_Req = 12201,
	WS_Legion_PageList_Req = 15501,
	WS_Friends_ApplyRefuseAll_Ack = 16210,
	WS_LegionManage_ApplyRefuse_Ack = 15550,
	WS_Pata_SaoDangTurnBrand_Req = 14617,
	WS_Common_DiamondExchange_Ack = 16052,
	WS_LegionWar_DailyAward_Req = 15701,
	WS_Pata_SaoDangBuyBuffNext_Ack = 14630,
	WS_Legion_Create_Req = 15505,
	WS_LegionWar_GetData_Ack = 15732,
	WS_WorldRes_ClearCD_Req = 15031,
	WS_Mail_GetAllAward_Ack = 16908,
	WS_LegionManage_Signature_Ack = 15542,
	WS_Building_Upgrade_Req = 13003,
	WS_Trial_GetInfo_Req = 14105,
	WS_Common_BattleRecord_Req = 16055,
	WS_GameLevel_StarAward_Req = 14007,
	WS_Hero_CalcReset_Ack = 12166,
	WS_Trial_FightStart_Req = 14101,
	WS_WorldBoss_GetInfo_Req = 15111,
	WS_ActivityAct_VipCardAward_Ack = 17120,
	WS_DailyTask_Award_Ack = 13616,
	WS_Friends_GiveTiliAll_Req = 16225,
	LS_Login_Req = 30001,
	WS_WorldRes_Refresh_Ack = 15030,
	WS_Legion_Search_Ack = 15504,
	WS_Bgz_FightStart_Req = 14701,
	WS_Vip_SuccessOrder_Ack = 16404,
	WS_LegionWar_DailyRepair_Req = 15707,
	AS_NoticeList_Req = 40003,
	WS_ActivityGm_LimitTimeHero_Ack = 17408,
	WS_ActivityAct_TwoCardAward_Ack = 17122,
	WS_WorldBoss_StartFight_Ack = 15102,
	WS_God_Upgrade_Ack = 13202,
	WS_LegionGame_BuyBless_Req = 15595,
	WS_GameLevel_FightResult_Req = 14003,
	WS_Barrage_Pull_Req = 16353,
	WS_Hero_ConfirmReset_Ack = 12168,
	WS_LegionManage_JoinSet_Ack = 15544,
	WS_Bgz_GetBossInfo_Req = 14713,
	WS_Pata_GetAward_Req = 14607,
	WS_Pata_SaoDangNext_Req = 14619,
	WS_ActivityAct_OnlineAward_Req = 17117,
	WS_Hero_CalcReset_Req = 12165,
	WS_Pata_FightResult_Ack = 14604,
	AS_AccountCheck_Req = 40009,
	WS_ActivityAct_VipSign_Req = 17125,
	WS_Equip_GemSet_Req = 12681,
	WS_ActivityAct_DailySign_Req = 17101,
	WS_LegionWar_Report_Req = 15725,
	WS_ActivityGm_RechargeDailySingle_Req = 17423,
	WS_Legion_Donate_Req = 15525,
	WS_Rank_Legion_Req = 16505,
	WS_LegionWar_PlayerFightStart_Ack = 15716,
	WS_ActivityOs_ArenaAward_Ack = 17312,
	WS_LegionWar_Apply_Ack = 15710,
	WS_ActivityOs_HalfPacks_Req = 17315,
	WS_Login_Game_Ack = 10002,
	WS_Rank_Arena_Ack = 16502,
	WS_Friends_ApplyPass_Req = 16205,
	WS_World_Unlock_Req = 15003,
	WS_WorldSpe_HCGiveUp_Ack = 15060,
	WS_Mail_GetAward_Ack = 16906,
	WS_Friends_GetTiliAll_Req = 16229,
	WS_Hero_UpgradeSatisfy_Req = 12163,
	WS_Legion_Quit_Req = 15513,
	WS_Bgz_GetBossInfo_Ack = 14714,
	WS_SyncData_UpgradeInfo_Req = 16105,
	WS_ActivityAct_CrazyUpgrade_Ack = 17110,
	WS_ActivityAct_CrazyUpgrade_Req = 17109,
	WS_ActivityAct_FirstRecharge_Req = 17123,
	WS_ActivityAct_BeInvite_Ack = 17132,
	WS_Building_Upgrade_Ack = 13004,
	WS_LegionWar_DailyFightResult_Ack = 15706,
	WS_Tech_Upgrade_Req = 13021,
	WS_Equip_GemRemove_Ack = 12684,
	WS_LegionManage_Kick_Req = 15551,
	WS_LegionBoss_StartFight_Ack = 15652,
	WS_GameLevel_SaoDang_Req = 14005,
	WS_LegionGame_GainHongbao_Ack = 15604,
	WS_LegionBoss_GetHurtRank_Ack = 15656,
	WS_Pata_FightResult_Req = 14603,
	WS_WorldTask_Start_Ack = 15042,
	WS_ActivityGm_LimitTimeScore_Req = 17409,
	WS_Arena_FightResult_Ack = 14506,
	WS_WorldSpe_Open_Req = 15053,
	WS_LegionGame_SendHongbao_Req = 15601,
	WS_Hero_Xilian_Req = 12151,
	WS_LegionGame_TrainComplete_Ack = 15590,
	WS_WorldSpe_HCFightStart_Ack = 15056,
	WS_ActivityGm_GetData_Ack = 17402,
	WS_LegionGame_GetDinner_Req = 15581,
	WS_WorldRes_FightStart_Req = 15023,
	WS_Common_SetFirst_Ack = 16004,
	WS_Building_ImmComplete_Req = 13005,
	WS_HeroComment_AddComment_Ack = 18652,
	WS_Legion_GetData_Req = 15515,
	WS_Friends_ApplyRefuse_Ack = 16208,
	WS_Mail_GetList_Req = 16901,
	WS_Friends_GiveTili_Req = 16223,
	WS_ActivityOs_LevelAward_Ack = 17304,
	WS_ActivityAct_WishTabRefresh_Req = 17115,
	WS_Pata_TurnBrand_Req = 14613,
	WS_Team_ResetHire_Ack = 14052,
	WS_LegionGame_SendHongbao_Ack = 15602,
	WS_Shop_Buy_Ack = 18606,
	WS_WorldSpe_AwardBox_Ack = 15070,
	WS_Friends_ApplyPass_Ack = 16206,
	WS_Equip_Decompose_Req = 12663,
	WS_LegionWar_DailyFightResult_Req = 15705,
	WS_Friends_ApplyRefuseAll_Req = 16209,
	WS_FriendsBoss_FightStart_Ack = 16242,
	WS_WorldRes_GetInfo_Req = 15021,
	WS_Friends_Apply_Ack = 16204,
	WS_WorldRes_Change_Ack = 15036,
	WS_Mail_GetAllAward_Req = 16907,
	WS_Friends_Delete_Req = 16211,
	WS_Pata_GetInfo_Req = 14631,
	WS_Vip_VipGiftBuy_Req = 16405,
	WS_Hero_UpgradeStar_Ack = 12026,
	WS_Equip_Compose_Ack = 12662,
	WS_Treasure_GetInfo_Ack = 18708,
	WS_FriendsBoss_GetBossInfo_Ack = 16248,
	AS_NoticeList_Ack = 40004,
	WS_Building_ImmComplete_Ack = 13006,
	WS_Hero_Xilian_Ack = 12152,
	WS_ActivityAct_TiliAdded_Req = 17105,
	WS_FriendsBoss_FightStart_Req = 16241,
	WS_Equip_RefreshHole_Ack = 12674,
	WS_Pata_TurnBrand_Ack = 14614,
	WS_Common_GetGameEnv_Ack = 16002,
	WS_WorldRes_GetInfo_Ack = 15022,
	WS_Pata_SaoDangBuyBuff_Ack = 14622,
	LS_Login_Ack = 30002,
	WS_Common_SetRoleName_Ack = 16006,
	WS_Legion_JoinQuick_Ack = 15510,
	WS_Login_Out_Ack = 10006,
	WS_Arena_FightResult_Req = 14505,
	LS_ErrorCode_Ack = 30000,
	WS_Equip_Upgrade_Ack = 12652,
	AS_AccountCheck_Ack = 40010,
	WS_ActivityAct_InviteAward_Ack = 17133,
	WS_Trial_GetInfo_Ack = 14106,
	AS_ClientAddress_Req = 40007,
	WS_Bgz_GetInfo_Ack = 14710
}
MESSAGE_MAP = {}
MESSAGE_MAP[MSG_ID.LS_ErrorCode_Ack] = ErrorCodeAck
MESSAGE_MAP[MSG_ID.LS_Login_Req] = LS_LoginReq
MESSAGE_MAP[MSG_ID.LS_Login_Ack] = LS_LoginAck
MESSAGE_MAP[MSG_ID.AS_ErrorCode_Ack] = ErrorCodeAck
MESSAGE_MAP[MSG_ID.AS_AreaList_Req] = AS_AreaListReq
MESSAGE_MAP[MSG_ID.AS_AreaList_Ack] = AS_AreaListAck
MESSAGE_MAP[MSG_ID.AS_NoticeList_Req] = AS_NoticeListReq
MESSAGE_MAP[MSG_ID.AS_NoticeList_Ack] = AS_NoticeListAck
MESSAGE_MAP[MSG_ID.AS_RoleInfo_Req] = AS_RoleInfoReq
MESSAGE_MAP[MSG_ID.AS_RoleInfo_Ack] = AS_RoleInfoAck
MESSAGE_MAP[MSG_ID.AS_ClientAddress_Req] = AS_ClientAddressReq
MESSAGE_MAP[MSG_ID.AS_ClientAddress_Ack] = AS_ClientAddressAck
MESSAGE_MAP[MSG_ID.AS_AccountCheck_Req] = AS_AccountCheckReq
MESSAGE_MAP[MSG_ID.AS_AccountCheck_Ack] = AS_AccountCheckAck
MESSAGE_MAP[MSG_ID.AS_AccountActivate_Req] = AS_AccountActivateReq
MESSAGE_MAP[MSG_ID.AS_AccountActivate_Ack] = AS_AccountActivateAck
MESSAGE_MAP[MSG_ID.ErrorCode_Ack] = ErrorCodeAck
MESSAGE_MAP[MSG_ID.WS_Login_Game_Req] = WS_Login_GameReq
MESSAGE_MAP[MSG_ID.WS_Login_Game_Ack] = WS_Login_GameAck
MESSAGE_MAP[MSG_ID.WS_Login_GameComplete_Req] = WS_Login_GameCompleteReq
MESSAGE_MAP[MSG_ID.WS_Login_GameComplete_Ack] = WS_Login_GameCompleteAck
MESSAGE_MAP[MSG_ID.WS_Login_Out_Req] = WS_Login_OutReq
MESSAGE_MAP[MSG_ID.WS_Login_Out_Ack] = WS_Login_OutAck
MESSAGE_MAP[MSG_ID.WS_Player_BaseFormation_Req] = WS_Player_BaseFormationReq
MESSAGE_MAP[MSG_ID.WS_Player_BaseFormation_Ack] = WS_Player_BaseFormationAck
MESSAGE_MAP[MSG_ID.WS_Player_Formation_Req] = WS_Player_FormationReq
MESSAGE_MAP[MSG_ID.WS_Player_Formation_Ack] = WS_Player_FormationAck
MESSAGE_MAP[MSG_ID.WS_Player_GameInfo_Req] = WS_Player_GameInfoReq
MESSAGE_MAP[MSG_ID.WS_Player_GameInfo_Ack] = WS_Player_GameInfoAck
MESSAGE_MAP[MSG_ID.WS_HeroFrag_Compose_Req] = WS_HeroFrag_ComposeReq
MESSAGE_MAP[MSG_ID.WS_HeroFrag_Compose_Ack] = WS_HeroFrag_ComposeAck
MESSAGE_MAP[MSG_ID.WS_HeroFrag_Decompose_Req] = WS_HeroFrag_DecomposeReq
MESSAGE_MAP[MSG_ID.WS_HeroFrag_Decompose_Ack] = WS_HeroFrag_DecomposeAck
MESSAGE_MAP[MSG_ID.WS_Hero_Upgrade_Req] = WS_Hero_UpgradeReq
MESSAGE_MAP[MSG_ID.WS_Hero_Upgrade_Ack] = WS_Hero_UpgradeAck
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeQuality_Req] = WS_Hero_UpgradeQualityReq
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeQuality_Ack] = WS_Hero_UpgradeQualityAck
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeStar_Req] = WS_Hero_UpgradeStarReq
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeStar_Ack] = WS_Hero_UpgradeStarAck
MESSAGE_MAP[MSG_ID.WS_Hero_WearEquip_Req] = WS_Hero_WearEquipReq
MESSAGE_MAP[MSG_ID.WS_Hero_WearEquip_Ack] = WS_Hero_WearEquipAck
MESSAGE_MAP[MSG_ID.WS_Hero_SwapEquip_Req] = WS_Hero_SwapEquipReq
MESSAGE_MAP[MSG_ID.WS_Hero_SwapEquip_Ack] = WS_Hero_SwapEquipAck
MESSAGE_MAP[MSG_ID.WS_Hero_FastUpgradeEquip_Req] = WS_Hero_FastUpgradeEquipReq
MESSAGE_MAP[MSG_ID.WS_Hero_FastUpgradeEquip_Ack] = WS_Hero_FastUpgradeEquipAck
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeSkill_Req] = WS_Hero_UpgradeSkillReq
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeSkill_Ack] = WS_Hero_UpgradeSkillAck
MESSAGE_MAP[MSG_ID.WS_Hero_Xilian_Req] = WS_Hero_XilianReq
MESSAGE_MAP[MSG_ID.WS_Hero_Xilian_Ack] = WS_Hero_XilianAck
MESSAGE_MAP[MSG_ID.WS_Hero_Tupo_Req] = WS_Hero_TupoReq
MESSAGE_MAP[MSG_ID.WS_Hero_Tupo_Ack] = WS_Hero_TupoAck
MESSAGE_MAP[MSG_ID.WS_Hero_Cast_Req] = WS_Hero_CastReq
MESSAGE_MAP[MSG_ID.WS_Hero_Cast_Ack] = WS_Hero_CastAck
MESSAGE_MAP[MSG_ID.WS_Hero_ExchangeFate_Req] = WS_Hero_ExchangeFateReq
MESSAGE_MAP[MSG_ID.WS_Hero_ExchangeFate_Ack] = WS_Hero_ExchangeFateAck
MESSAGE_MAP[MSG_ID.WS_Hero_PutOnPartner_Req] = WS_Hero_PutOnPartnerReq
MESSAGE_MAP[MSG_ID.WS_Hero_PutOnPartner_Ack] = WS_Hero_PutOnPartnerAck
MESSAGE_MAP[MSG_ID.WS_Hero_PutDownPartner_Req] = WS_Hero_PutDownPartnerReq
MESSAGE_MAP[MSG_ID.WS_Hero_PutDownPartner_Ack] = WS_Hero_PutDownPartnerAck
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeSatisfy_Req] = WS_Hero_UpgradeSatisfyReq
MESSAGE_MAP[MSG_ID.WS_Hero_UpgradeSatisfy_Ack] = WS_Hero_UpgradeSatisfyAck
MESSAGE_MAP[MSG_ID.WS_Hero_CalcReset_Req] = WS_Hero_CalcResetReq
MESSAGE_MAP[MSG_ID.WS_Hero_CalcReset_Ack] = WS_Hero_CalcResetAck
MESSAGE_MAP[MSG_ID.WS_Hero_ConfirmReset_Req] = WS_Hero_ConfirmResetReq
MESSAGE_MAP[MSG_ID.WS_Hero_ConfirmReset_Ack] = WS_Hero_ConfirmResetAck
MESSAGE_MAP[MSG_ID.WS_HeroSoul_Buy_Req] = WS_HeroSoul_BuyReq
MESSAGE_MAP[MSG_ID.WS_HeroSoul_Buy_Ack] = WS_HeroSoul_BuyAck
MESSAGE_MAP[MSG_ID.WS_HeroSoul_Exchange_Req] = WS_HeroSoul_ExchangeReq
MESSAGE_MAP[MSG_ID.WS_HeroSoul_Exchange_Ack] = WS_HeroSoul_ExchangeAck
MESSAGE_MAP[MSG_ID.WS_Bag_GemCompose_Req] = WS_Bag_GemComposeReq
MESSAGE_MAP[MSG_ID.WS_Bag_GemCompose_Ack] = WS_Bag_GemComposeAck
MESSAGE_MAP[MSG_ID.WS_Bag_SaleItem_Req] = WS_Bag_SaleItemReq
MESSAGE_MAP[MSG_ID.WS_Bag_SaleItem_Ack] = WS_Bag_SaleItemAck
MESSAGE_MAP[MSG_ID.WS_Bag_OpenBox_Req] = WS_Bag_OpenBoxReq
MESSAGE_MAP[MSG_ID.WS_Bag_OpenBox_Ack] = WS_Bag_OpenBoxAck
MESSAGE_MAP[MSG_ID.WS_Equip_Upgrade_Req] = WS_Equip_UpgradeReq
MESSAGE_MAP[MSG_ID.WS_Equip_Upgrade_Ack] = WS_Equip_UpgradeAck
MESSAGE_MAP[MSG_ID.WS_Equip_Cuilian_Req] = WS_Equip_CuilianReq
MESSAGE_MAP[MSG_ID.WS_Equip_Cuilian_Ack] = WS_Equip_CuilianAck
MESSAGE_MAP[MSG_ID.WS_Equip_Compose_Req] = WS_Equip_ComposeReq
MESSAGE_MAP[MSG_ID.WS_Equip_Compose_Ack] = WS_Equip_ComposeAck
MESSAGE_MAP[MSG_ID.WS_Equip_Decompose_Req] = WS_Equip_DecomposeReq
MESSAGE_MAP[MSG_ID.WS_Equip_Decompose_Ack] = WS_Equip_DecomposeAck
MESSAGE_MAP[MSG_ID.WS_Equip_OpenHole_Req] = WS_Equip_OpenHoleReq
MESSAGE_MAP[MSG_ID.WS_Equip_OpenHole_Ack] = WS_Equip_OpenHoleAck
MESSAGE_MAP[MSG_ID.WS_Equip_RefreshHole_Req] = WS_Equip_RefreshHoleReq
MESSAGE_MAP[MSG_ID.WS_Equip_RefreshHole_Ack] = WS_Equip_RefreshHoleAck
MESSAGE_MAP[MSG_ID.WS_Equip_GemSet_Req] = WS_Equip_GemSetReq
MESSAGE_MAP[MSG_ID.WS_Equip_GemSet_Ack] = WS_Equip_GemSetAck
MESSAGE_MAP[MSG_ID.WS_Equip_GemRemove_Req] = WS_Equip_GemRemoveReq
MESSAGE_MAP[MSG_ID.WS_Equip_GemRemove_Ack] = WS_Equip_GemRemoveAck
MESSAGE_MAP[MSG_ID.WS_Equip_UpStar_Req] = WS_Equip_UpStarReq
MESSAGE_MAP[MSG_ID.WS_Equip_UpStar_Ack] = WS_Equip_UpStarAck
MESSAGE_MAP[MSG_ID.WS_Building_GetData_Req] = WS_Building_GetDataReq
MESSAGE_MAP[MSG_ID.WS_Building_GetData_Ack] = WS_Building_GetDataAck
MESSAGE_MAP[MSG_ID.WS_Building_Upgrade_Req] = WS_Building_UpgradeReq
MESSAGE_MAP[MSG_ID.WS_Building_Upgrade_Ack] = WS_Building_UpgradeAck
MESSAGE_MAP[MSG_ID.WS_Building_ImmComplete_Req] = WS_Building_ImmCompleteReq
MESSAGE_MAP[MSG_ID.WS_Building_ImmComplete_Ack] = WS_Building_ImmCompleteAck
MESSAGE_MAP[MSG_ID.WS_Building_Income_Req] = WS_Building_IncomeReq
MESSAGE_MAP[MSG_ID.WS_Building_Income_Ack] = WS_Building_IncomeAck
MESSAGE_MAP[MSG_ID.WS_Tech_Upgrade_Req] = WS_Tech_UpgradeReq
MESSAGE_MAP[MSG_ID.WS_Tech_Upgrade_Ack] = WS_Tech_UpgradeAck
MESSAGE_MAP[MSG_ID.WS_Tech_FastUpgrade_Req] = WS_Tech_FastUpgradeReq
MESSAGE_MAP[MSG_ID.WS_Tech_FastUpgrade_Ack] = WS_Tech_FastUpgradeAck
MESSAGE_MAP[MSG_ID.WS_Tech_GetData_Req] = WS_Tech_GetDataReq
MESSAGE_MAP[MSG_ID.WS_Tech_GetData_Ack] = WS_Tech_GetDataAck
MESSAGE_MAP[MSG_ID.WS_God_Upgrade_Req] = WS_God_UpgradeReq
MESSAGE_MAP[MSG_ID.WS_God_Upgrade_Ack] = WS_God_UpgradeAck
MESSAGE_MAP[MSG_ID.WS_God_UpgradeStar_Req] = WS_God_UpgradeStarReq
MESSAGE_MAP[MSG_ID.WS_God_UpgradeStar_Ack] = WS_God_UpgradeStarAck
MESSAGE_MAP[MSG_ID.WS_God_UpgradeSkill_Req] = WS_God_UpgradeSkillReq
MESSAGE_MAP[MSG_ID.WS_God_UpgradeSkill_Ack] = WS_God_UpgradeSkillAck
MESSAGE_MAP[MSG_ID.WS_God_Change_Req] = WS_God_ChangeReq
MESSAGE_MAP[MSG_ID.WS_God_Change_Ack] = WS_God_ChangeAck
MESSAGE_MAP[MSG_ID.WS_Formation_Save_Req] = WS_Formation_SaveReq
MESSAGE_MAP[MSG_ID.WS_Formation_Save_Ack] = WS_Formation_SaveAck
MESSAGE_MAP[MSG_ID.WS_MainTask_GetData_Req] = WS_MainTask_GetDataReq
MESSAGE_MAP[MSG_ID.WS_MainTask_GetData_Ack] = WS_MainTask_GetDataAck
MESSAGE_MAP[MSG_ID.WS_MainTask_Award_Req] = WS_MainTask_AwardReq
MESSAGE_MAP[MSG_ID.WS_MainTask_Award_Ack] = WS_MainTask_AwardAck
MESSAGE_MAP[MSG_ID.WS_DailyTask_GetData_Req] = WS_DailyTask_GetDataReq
MESSAGE_MAP[MSG_ID.WS_DailyTask_GetData_Ack] = WS_DailyTask_GetDataAck
MESSAGE_MAP[MSG_ID.WS_DailyTask_Complete_Req] = WS_DailyTask_CompleteReq
MESSAGE_MAP[MSG_ID.WS_DailyTask_Complete_Ack] = WS_DailyTask_CompleteAck
MESSAGE_MAP[MSG_ID.WS_DailyTask_Award_Req] = WS_DailyTask_AwardReq
MESSAGE_MAP[MSG_ID.WS_DailyTask_Award_Ack] = WS_DailyTask_AwardAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_FightStart_Req] = WS_GameLevel_FightStartReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_FightStart_Ack] = WS_GameLevel_FightStartAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_FightResult_Req] = WS_GameLevel_FightResultReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_FightResult_Ack] = WS_GameLevel_FightResultAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_SaoDang_Req] = WS_GameLevel_SaoDangReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_SaoDang_Ack] = WS_GameLevel_SaoDangAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_StarAward_Req] = WS_GameLevel_StarAwardReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_StarAward_Ack] = WS_GameLevel_StarAwardAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_Reset_Req] = WS_GameLevel_ResetReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_Reset_Ack] = WS_GameLevel_ResetAck
MESSAGE_MAP[MSG_ID.WS_GameLevel_GetData_Req] = WS_GameLevel_GetDataReq
MESSAGE_MAP[MSG_ID.WS_GameLevel_GetData_Ack] = WS_GameLevel_GetDataAck
MESSAGE_MAP[MSG_ID.WS_Team_ResetHire_Req] = WS_Team_ResetHireReq
MESSAGE_MAP[MSG_ID.WS_Team_ResetHire_Ack] = WS_Team_ResetHireAck
MESSAGE_MAP[MSG_ID.WS_Trial_FightStart_Req] = WS_Trial_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Trial_FightStart_Ack] = WS_Trial_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Trial_FightResult_Req] = WS_Trial_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Trial_FightResult_Ack] = WS_Trial_FightResultAck
MESSAGE_MAP[MSG_ID.WS_Trial_GetInfo_Req] = WS_Trial_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_Trial_GetInfo_Ack] = WS_Trial_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_Trial_SaoDang_Req] = WS_Trial_SaoDangReq
MESSAGE_MAP[MSG_ID.WS_Trial_SaoDang_Ack] = WS_Trial_SaoDangAck
MESSAGE_MAP[MSG_ID.WS_Arena_GetData_Req] = WS_Arena_GetDataReq
MESSAGE_MAP[MSG_ID.WS_Arena_GetData_Ack] = WS_Arena_GetDataAck
MESSAGE_MAP[MSG_ID.WS_Arena_FightStart_Req] = WS_Arena_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Arena_FightStart_Ack] = WS_Arena_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Arena_FightResult_Req] = WS_Arena_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Arena_FightResult_Ack] = WS_Arena_FightResultAck
MESSAGE_MAP[MSG_ID.WS_Arena_RecordList_Req] = WS_Arena_RecordListReq
MESSAGE_MAP[MSG_ID.WS_Arena_RecordList_Ack] = WS_Arena_RecordListAck
MESSAGE_MAP[MSG_ID.WS_Arena_Reset_Req] = WS_Arena_ResetReq
MESSAGE_MAP[MSG_ID.WS_Arena_Reset_Ack] = WS_Arena_ResetAck
MESSAGE_MAP[MSG_ID.WS_Arena_Signature_Req] = WS_Arena_SignatureReq
MESSAGE_MAP[MSG_ID.WS_Arena_Signature_Ack] = WS_Arena_SignatureAck
MESSAGE_MAP[MSG_ID.WS_Pata_FightStart_Req] = WS_Pata_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Pata_FightStart_Ack] = WS_Pata_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Pata_FightResult_Req] = WS_Pata_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Pata_FightResult_Ack] = WS_Pata_FightResultAck
MESSAGE_MAP[MSG_ID.WS_Pata_BuyBuff_Req] = WS_Pata_BuyBuffReq
MESSAGE_MAP[MSG_ID.WS_Pata_BuyBuff_Ack] = WS_Pata_BuyBuffAck
MESSAGE_MAP[MSG_ID.WS_Pata_GetAward_Req] = WS_Pata_GetAwardReq
MESSAGE_MAP[MSG_ID.WS_Pata_GetAward_Ack] = WS_Pata_GetAwardAck
MESSAGE_MAP[MSG_ID.WS_Pata_NextLayer_Req] = WS_Pata_NextLayerReq
MESSAGE_MAP[MSG_ID.WS_Pata_NextLayer_Ack] = WS_Pata_NextLayerAck
MESSAGE_MAP[MSG_ID.WS_Pata_TurnBrand_Req] = WS_Pata_TurnBrandReq
MESSAGE_MAP[MSG_ID.WS_Pata_TurnBrand_Ack] = WS_Pata_TurnBrandAck
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangTurnBrand_Req] = WS_Pata_SaoDangTurnBrandReq
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangTurnBrand_Ack] = WS_Pata_SaoDangTurnBrandAck
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangNext_Req] = WS_Pata_SaoDangNextReq
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangNext_Ack] = WS_Pata_SaoDangNextAck
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangBuyBuff_Req] = WS_Pata_SaoDangBuyBuffReq
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangBuyBuff_Ack] = WS_Pata_SaoDangBuyBuffAck
MESSAGE_MAP[MSG_ID.WS_Pata_GetScoreAward_Req] = WS_Pata_GetScoreAwardReq
MESSAGE_MAP[MSG_ID.WS_Pata_GetScoreAward_Ack] = WS_Pata_GetScoreAwardAck
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangTurnBrandNext_Req] = WS_Pata_SaoDangTurnBrandNextReq
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangTurnBrandNext_Ack] = WS_Pata_SaoDangTurnBrandNextAck
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangBuyBuffNext_Req] = WS_Pata_SaoDangBuyBuffNextReq
MESSAGE_MAP[MSG_ID.WS_Pata_SaoDangBuyBuffNext_Ack] = WS_Pata_SaoDangBuyBuffNextAck
MESSAGE_MAP[MSG_ID.WS_Pata_GetInfo_Req] = WS_Pata_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_Pata_GetInfo_Ack] = WS_Pata_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_Pata_StartSaoDang_Req] = WS_Pata_StartSaoDangReq
MESSAGE_MAP[MSG_ID.WS_Pata_StartSaoDang_Ack] = WS_Pata_StartSaoDangAck
MESSAGE_MAP[MSG_ID.WS_Bgz_FightStart_Req] = WS_Bgz_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Bgz_FightStart_Ack] = WS_Bgz_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Bgz_FightResult_Req] = WS_Bgz_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Bgz_FightResult_Ack] = WS_Bgz_FightResultAck
MESSAGE_MAP[MSG_ID.WS_Bgz_GetAward_Req] = WS_Bgz_GetAwardReq
MESSAGE_MAP[MSG_ID.WS_Bgz_GetAward_Ack] = WS_Bgz_GetAwardAck
MESSAGE_MAP[MSG_ID.WS_Bgz_GetScoreAward_Req] = WS_Bgz_GetScoreAwardReq
MESSAGE_MAP[MSG_ID.WS_Bgz_GetScoreAward_Ack] = WS_Bgz_GetScoreAwardAck
MESSAGE_MAP[MSG_ID.WS_Bgz_GetInfo_Req] = WS_Bgz_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_Bgz_GetInfo_Ack] = WS_Bgz_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_Bgz_Reset_Req] = WS_Bgz_ResetReq
MESSAGE_MAP[MSG_ID.WS_Bgz_Reset_Ack] = WS_Bgz_ResetAck
MESSAGE_MAP[MSG_ID.WS_Bgz_GetBossInfo_Req] = WS_Bgz_GetBossInfoReq
MESSAGE_MAP[MSG_ID.WS_Bgz_GetBossInfo_Ack] = WS_Bgz_GetBossInfoAck
MESSAGE_MAP[MSG_ID.WS_World_GetInfo_Req] = WS_World_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_World_GetInfo_Ack] = WS_World_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_World_Unlock_Req] = WS_World_UnlockReq
MESSAGE_MAP[MSG_ID.WS_World_Unlock_Ack] = WS_World_UnlockAck
MESSAGE_MAP[MSG_ID.WS_World_GetLog_Req] = WS_World_GetLogReq
MESSAGE_MAP[MSG_ID.WS_World_GetLog_Ack] = WS_World_GetLogAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_GetInfo_Req] = WS_WorldRes_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_GetInfo_Ack] = WS_WorldRes_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_FightStart_Req] = WS_WorldRes_FightStartReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_FightStart_Ack] = WS_WorldRes_FightStartAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_FightResult_Req] = WS_WorldRes_FightResultReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_FightResult_Ack] = WS_WorldRes_FightResultAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_Gain_Req] = WS_WorldRes_GainReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_Gain_Ack] = WS_WorldRes_GainAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_Refresh_Req] = WS_WorldRes_RefreshReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_Refresh_Ack] = WS_WorldRes_RefreshAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_ClearCD_Req] = WS_WorldRes_ClearCDReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_ClearCD_Ack] = WS_WorldRes_ClearCDAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_Settle_Req] = WS_WorldRes_SettleReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_Settle_Ack] = WS_WorldRes_SettleAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_Change_Req] = WS_WorldRes_ChangeReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_Change_Ack] = WS_WorldRes_ChangeAck
MESSAGE_MAP[MSG_ID.WS_WorldRes_Taunt_Req] = WS_WorldRes_TauntReq
MESSAGE_MAP[MSG_ID.WS_WorldRes_Taunt_Ack] = WS_WorldRes_TauntAck
MESSAGE_MAP[MSG_ID.WS_WorldTask_Start_Req] = WS_WorldTask_StartReq
MESSAGE_MAP[MSG_ID.WS_WorldTask_Start_Ack] = WS_WorldTask_StartAck
MESSAGE_MAP[MSG_ID.WS_WorldTask_Gain_Req] = WS_WorldTask_GainReq
MESSAGE_MAP[MSG_ID.WS_WorldTask_Gain_Ack] = WS_WorldTask_GainAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_GetInfo_Req] = WS_WorldSpe_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_GetInfo_Ack] = WS_WorldSpe_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_Open_Req] = WS_WorldSpe_OpenReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_Open_Ack] = WS_WorldSpe_OpenAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCFightStart_Req] = WS_WorldSpe_HCFightStartReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCFightStart_Ack] = WS_WorldSpe_HCFightStartAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCFightResult_Req] = WS_WorldSpe_HCFightResultReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCFightResult_Ack] = WS_WorldSpe_HCFightResultAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCGiveUp_Req] = WS_WorldSpe_HCGiveUpReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_HCGiveUp_Ack] = WS_WorldSpe_HCGiveUpAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_BgzBribe_Req] = WS_WorldSpe_BgzBribeReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_BgzBribe_Ack] = WS_WorldSpe_BgzBribeAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_FaceStart_Req] = WS_WorldSpe_FaceStartReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_FaceStart_Ack] = WS_WorldSpe_FaceStartAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_FaceEnd_Req] = WS_WorldSpe_FaceEndReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_FaceEnd_Ack] = WS_WorldSpe_FaceEndAck
MESSAGE_MAP[MSG_ID.WS_WorldSpe_AwardBox_Req] = WS_WorldSpe_AwardBoxReq
MESSAGE_MAP[MSG_ID.WS_WorldSpe_AwardBox_Ack] = WS_WorldSpe_AwardBoxAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_StartFight_Req] = WS_WorldBoss_StartFightReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_StartFight_Ack] = WS_WorldBoss_StartFightAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_FightResult_Req] = WS_WorldBoss_FightResultReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_FightResult_Ack] = WS_WorldBoss_FightResultAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_ClearCD_Req] = WS_WorldBoss_ClearCDReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_ClearCD_Ack] = WS_WorldBoss_ClearCDAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_Inspire_Req] = WS_WorldBoss_InspireReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_Inspire_Ack] = WS_WorldBoss_InspireAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_DamageRank_Req] = WS_WorldBoss_DamageRankReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_DamageRank_Ack] = WS_WorldBoss_DamageRankAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_GetInfo_Req] = WS_WorldBoss_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_GetInfo_Ack] = WS_WorldBoss_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_WorldBoss_GetAward_Req] = WS_WorldBoss_GetAwardReq
MESSAGE_MAP[MSG_ID.WS_WorldBoss_GetAward_Ack] = WS_WorldBoss_GetAwardAck
MESSAGE_MAP[MSG_ID.WS_Legion_PageList_Req] = WS_Legion_PageListReq
MESSAGE_MAP[MSG_ID.WS_Legion_PageList_Ack] = WS_Legion_PageListAck
MESSAGE_MAP[MSG_ID.WS_Legion_Search_Req] = WS_Legion_SearchReq
MESSAGE_MAP[MSG_ID.WS_Legion_Search_Ack] = WS_Legion_SearchAck
MESSAGE_MAP[MSG_ID.WS_Legion_Create_Req] = WS_Legion_CreateReq
MESSAGE_MAP[MSG_ID.WS_Legion_Create_Ack] = WS_Legion_CreateAck
MESSAGE_MAP[MSG_ID.WS_Legion_Apply_Req] = WS_Legion_ApplyReq
MESSAGE_MAP[MSG_ID.WS_Legion_Apply_Ack] = WS_Legion_ApplyAck
MESSAGE_MAP[MSG_ID.WS_Legion_JoinQuick_Req] = WS_Legion_JoinQuickReq
MESSAGE_MAP[MSG_ID.WS_Legion_JoinQuick_Ack] = WS_Legion_JoinQuickAck
MESSAGE_MAP[MSG_ID.WS_Legion_ClearJoinCD_Req] = WS_Legion_ClearJoinCDReq
MESSAGE_MAP[MSG_ID.WS_Legion_ClearJoinCD_Ack] = WS_Legion_ClearJoinCDAck
MESSAGE_MAP[MSG_ID.WS_Legion_Quit_Req] = WS_Legion_QuitReq
MESSAGE_MAP[MSG_ID.WS_Legion_Quit_Ack] = WS_Legion_QuitAck
MESSAGE_MAP[MSG_ID.WS_Legion_GetData_Req] = WS_Legion_GetDataReq
MESSAGE_MAP[MSG_ID.WS_Legion_GetData_Ack] = WS_Legion_GetDataAck
MESSAGE_MAP[MSG_ID.WS_Legion_GetMembers_Req] = WS_Legion_GetMembersReq
MESSAGE_MAP[MSG_ID.WS_Legion_GetMembers_Ack] = WS_Legion_GetMembersAck
MESSAGE_MAP[MSG_ID.WS_Legion_GetApply_Req] = WS_Legion_GetApplyReq
MESSAGE_MAP[MSG_ID.WS_Legion_GetApply_Ack] = WS_Legion_GetApplyAck
MESSAGE_MAP[MSG_ID.WS_Legion_GetLog_Req] = WS_Legion_GetLogReq
MESSAGE_MAP[MSG_ID.WS_Legion_GetLog_Ack] = WS_Legion_GetLogAck
MESSAGE_MAP[MSG_ID.WS_Legion_GetSelfInfo_Req] = WS_Legion_GetSelfInfoReq
MESSAGE_MAP[MSG_ID.WS_Legion_GetSelfInfo_Ack] = WS_Legion_GetSelfInfoAck
MESSAGE_MAP[MSG_ID.WS_Legion_Donate_Req] = WS_Legion_DonateReq
MESSAGE_MAP[MSG_ID.WS_Legion_Donate_Ack] = WS_Legion_DonateAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_Signature_Req] = WS_LegionManage_SignatureReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_Signature_Ack] = WS_LegionManage_SignatureAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_JoinSet_Req] = WS_LegionManage_JoinSetReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_JoinSet_Ack] = WS_LegionManage_JoinSetAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_OfficeSet_Req] = WS_LegionManage_OfficeSetReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_OfficeSet_Ack] = WS_LegionManage_OfficeSetAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_ApplyPass_Req] = WS_LegionManage_ApplyPassReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_ApplyPass_Ack] = WS_LegionManage_ApplyPassAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_ApplyRefuse_Req] = WS_LegionManage_ApplyRefuseReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_ApplyRefuse_Ack] = WS_LegionManage_ApplyRefuseAck
MESSAGE_MAP[MSG_ID.WS_LegionManage_Kick_Req] = WS_LegionManage_KickReq
MESSAGE_MAP[MSG_ID.WS_LegionManage_Kick_Ack] = WS_LegionManage_KickAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingOpen_Req] = WS_LegionGame_RollingOpenReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingOpen_Ack] = WS_LegionGame_RollingOpenAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingContinue_Req] = WS_LegionGame_RollingContinueReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingContinue_Ack] = WS_LegionGame_RollingContinueAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingGain_Req] = WS_LegionGame_RollingGainReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_RollingGain_Ack] = WS_LegionGame_RollingGainAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_DinnerOpen_Req] = WS_LegionGame_DinnerOpenReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_DinnerOpen_Ack] = WS_LegionGame_DinnerOpenAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_DinnerGain_Req] = WS_LegionGame_DinnerGainReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_DinnerGain_Ack] = WS_LegionGame_DinnerGainAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetDinner_Req] = WS_LegionGame_GetDinnerReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetDinner_Ack] = WS_LegionGame_GetDinnerAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetDinnerLog_Req] = WS_LegionGame_GetDinnerLogReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetDinnerLog_Ack] = WS_LegionGame_GetDinnerLogAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_Welfare_Req] = WS_LegionGame_WelfareReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_Welfare_Ack] = WS_LegionGame_WelfareAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_TrainStart_Req] = WS_LegionGame_TrainStartReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_TrainStart_Ack] = WS_LegionGame_TrainStartAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_TrainComplete_Req] = WS_LegionGame_TrainCompleteReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_TrainComplete_Ack] = WS_LegionGame_TrainCompleteAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_BuyBless_Req] = WS_LegionGame_BuyBlessReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_BuyBless_Ack] = WS_LegionGame_BuyBlessAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetBless_Req] = WS_LegionGame_GetBlessReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetBless_Ack] = WS_LegionGame_GetBlessAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetBlessLog_Req] = WS_LegionGame_GetBlessLogReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetBlessLog_Ack] = WS_LegionGame_GetBlessLogAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_SendHongbao_Req] = WS_LegionGame_SendHongbaoReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_SendHongbao_Ack] = WS_LegionGame_SendHongbaoAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GainHongbao_Req] = WS_LegionGame_GainHongbaoReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GainHongbao_Ack] = WS_LegionGame_GainHongbaoAck
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetHongbao_Req] = WS_LegionGame_GetHongbaoReq
MESSAGE_MAP[MSG_ID.WS_LegionGame_GetHongbao_Ack] = WS_LegionGame_GetHongbaoAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_StartFight_Req] = WS_LegionBoss_StartFightReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_StartFight_Ack] = WS_LegionBoss_StartFightAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_FightResult_Req] = WS_LegionBoss_FightResultReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_FightResult_Ack] = WS_LegionBoss_FightResultAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetHurtRank_Req] = WS_LegionBoss_GetHurtRankReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetHurtRank_Ack] = WS_LegionBoss_GetHurtRankAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetInfo_Req] = WS_LegionBoss_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetInfo_Ack] = WS_LegionBoss_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_BuyBuff_Req] = WS_LegionBoss_BuyBuffReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_BuyBuff_Ack] = WS_LegionBoss_BuyBuffAck
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetAward_Req] = WS_LegionBoss_GetAwardReq
MESSAGE_MAP[MSG_ID.WS_LegionBoss_GetAward_Ack] = WS_LegionBoss_GetAwardAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyAward_Req] = WS_LegionWar_DailyAwardReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyAward_Ack] = WS_LegionWar_DailyAwardAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyFightStart_Req] = WS_LegionWar_DailyFightStartReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyFightStart_Ack] = WS_LegionWar_DailyFightStartAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyFightResult_Req] = WS_LegionWar_DailyFightResultReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyFightResult_Ack] = WS_LegionWar_DailyFightResultAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyRepair_Req] = WS_LegionWar_DailyRepairReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_DailyRepair_Ack] = WS_LegionWar_DailyRepairAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_Apply_Req] = WS_LegionWar_ApplyReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_Apply_Ack] = WS_LegionWar_ApplyAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildFightStart_Req] = WS_LegionWar_BuildFightStartReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildFightStart_Ack] = WS_LegionWar_BuildFightStartAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildFightResult_Req] = WS_LegionWar_BuildFightResultReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildFightResult_Ack] = WS_LegionWar_BuildFightResultAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_PlayerFightStart_Req] = WS_LegionWar_PlayerFightStartReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_PlayerFightStart_Ack] = WS_LegionWar_PlayerFightStartAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_PlayerFightResult_Req] = WS_LegionWar_PlayerFightResultReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_PlayerFightResult_Ack] = WS_LegionWar_PlayerFightResultAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_DefendSet_Req] = WS_LegionWar_DefendSetReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_DefendSet_Ack] = WS_LegionWar_DefendSetAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_EliteSet_Req] = WS_LegionWar_EliteSetReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_EliteSet_Ack] = WS_LegionWar_EliteSetAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_Log_Req] = WS_LegionWar_LogReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_Log_Ack] = WS_LegionWar_LogAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_Report_Req] = WS_LegionWar_ReportReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_Report_Ack] = WS_LegionWar_ReportAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetDailyNode_Req] = WS_LegionWar_GetDailyNodeReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetDailyNode_Ack] = WS_LegionWar_GetDailyNodeAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetFightNode_Req] = WS_LegionWar_GetFightNodeReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetFightNode_Ack] = WS_LegionWar_GetFightNodeAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetData_Req] = WS_LegionWar_GetDataReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_GetData_Ack] = WS_LegionWar_GetDataAck
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildDefendInfo_Req] = WS_LegionWar_BuildDefendInfoReq
MESSAGE_MAP[MSG_ID.WS_LegionWar_BuildDefendInfo_Ack] = WS_LegionWar_BuildDefendInfoAck
MESSAGE_MAP[MSG_ID.WS_Common_GetGameEnv_Req] = WS_Common_GetGameEnvReq
MESSAGE_MAP[MSG_ID.WS_Common_GetGameEnv_Ack] = WS_Common_GetGameEnvAck
MESSAGE_MAP[MSG_ID.WS_Common_SetFirst_Req] = WS_Common_SetFirstReq
MESSAGE_MAP[MSG_ID.WS_Common_SetFirst_Ack] = WS_Common_SetFirstAck
MESSAGE_MAP[MSG_ID.WS_Common_SetRoleName_Req] = WS_Common_SetRoleNameReq
MESSAGE_MAP[MSG_ID.WS_Common_SetRoleName_Ack] = WS_Common_SetRoleNameAck
MESSAGE_MAP[MSG_ID.WS_Common_SetHeadId_Req] = WS_Common_SetHeadIdReq
MESSAGE_MAP[MSG_ID.WS_Common_SetHeadId_Ack] = WS_Common_SetHeadIdAck
MESSAGE_MAP[MSG_ID.WS_Common_DiamondExchange_Req] = WS_Common_DiamondExchangeReq
MESSAGE_MAP[MSG_ID.WS_Common_DiamondExchange_Ack] = WS_Common_DiamondExchangeAck
MESSAGE_MAP[MSG_ID.WS_Common_BuyHorn_Req] = WS_Common_BuyHornReq
MESSAGE_MAP[MSG_ID.WS_Common_BuyHorn_Ack] = WS_Common_BuyHornAck
MESSAGE_MAP[MSG_ID.WS_Common_BattleRecord_Req] = WS_Common_BattleRecordReq
MESSAGE_MAP[MSG_ID.WS_Common_BattleRecord_Ack] = WS_Common_BattleRecordAck
MESSAGE_MAP[MSG_ID.WS_Common_HeartBeat_Req] = WS_Common_HeartBeatReq
MESSAGE_MAP[MSG_ID.WS_Common_HeartBeat_Ack] = WS_Common_HeartBeatAck
MESSAGE_MAP[MSG_ID.WS_Common_FightStart_Req] = WS_Common_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Common_FightStart_Ack] = WS_Common_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Common_FightResult_Req] = WS_Common_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Common_FightResult_Ack] = WS_Common_FightResultAck
MESSAGE_MAP[MSG_ID.WS_SyncData_Ntf] = WS_SyncDataNtf
MESSAGE_MAP[MSG_ID.WS_SyncData_GameInfo_Req] = WS_SyncData_GameInfoReq
MESSAGE_MAP[MSG_ID.WS_SyncData_GameInfo_Ack] = WS_SyncData_GameInfoAck
MESSAGE_MAP[MSG_ID.WS_SyncData_UpgradeInfo_Req] = WS_SyncData_UpgradeInfoReq
MESSAGE_MAP[MSG_ID.WS_SyncData_UpgradeInfo_Ack] = WS_SyncData_UpgradeInfoAck
MESSAGE_MAP[MSG_ID.WS_SyncData_Formation_Req] = WS_SyncData_FormationReq
MESSAGE_MAP[MSG_ID.WS_SyncData_Formation_Ack] = WS_SyncData_FormationAck
MESSAGE_MAP[MSG_ID.WS_SyncData_HeroList_Req] = WS_SyncData_HeroListReq
MESSAGE_MAP[MSG_ID.WS_SyncData_HeroList_Ack] = WS_SyncData_HeroListAck
MESSAGE_MAP[MSG_ID.WS_Friends_GetData_Req] = WS_Friends_GetDataReq
MESSAGE_MAP[MSG_ID.WS_Friends_GetData_Ack] = WS_Friends_GetDataAck
MESSAGE_MAP[MSG_ID.WS_Friends_Apply_Req] = WS_Friends_ApplyReq
MESSAGE_MAP[MSG_ID.WS_Friends_Apply_Ack] = WS_Friends_ApplyAck
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyPass_Req] = WS_Friends_ApplyPassReq
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyPass_Ack] = WS_Friends_ApplyPassAck
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyRefuse_Req] = WS_Friends_ApplyRefuseReq
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyRefuse_Ack] = WS_Friends_ApplyRefuseAck
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyRefuseAll_Req] = WS_Friends_ApplyRefuseAllReq
MESSAGE_MAP[MSG_ID.WS_Friends_ApplyRefuseAll_Ack] = WS_Friends_ApplyRefuseAllAck
MESSAGE_MAP[MSG_ID.WS_Friends_Delete_Req] = WS_Friends_DeleteReq
MESSAGE_MAP[MSG_ID.WS_Friends_Delete_Ack] = WS_Friends_DeleteAck
MESSAGE_MAP[MSG_ID.WS_Friends_Action_Req] = WS_Friends_ActionReq
MESSAGE_MAP[MSG_ID.WS_Friends_Action_Ack] = WS_Friends_ActionAck
MESSAGE_MAP[MSG_ID.WS_Friends_Search_Req] = WS_Friends_SearchReq
MESSAGE_MAP[MSG_ID.WS_Friends_Search_Ack] = WS_Friends_SearchAck
MESSAGE_MAP[MSG_ID.WS_Friends_Recommend_Req] = WS_Friends_RecommendReq
MESSAGE_MAP[MSG_ID.WS_Friends_Recommend_Ack] = WS_Friends_RecommendAck
MESSAGE_MAP[MSG_ID.WS_Friends_FightStart_Req] = WS_Friends_FightStartReq
MESSAGE_MAP[MSG_ID.WS_Friends_FightStart_Ack] = WS_Friends_FightStartAck
MESSAGE_MAP[MSG_ID.WS_Friends_FightResult_Req] = WS_Friends_FightResultReq
MESSAGE_MAP[MSG_ID.WS_Friends_FightResult_Ack] = WS_Friends_FightResultAck
MESSAGE_MAP[MSG_ID.WS_Friends_GiveTili_Req] = WS_Friends_GiveTiliReq
MESSAGE_MAP[MSG_ID.WS_Friends_GiveTili_Ack] = WS_Friends_GiveTiliAck
MESSAGE_MAP[MSG_ID.WS_Friends_GiveTiliAll_Req] = WS_Friends_GiveTiliAllReq
MESSAGE_MAP[MSG_ID.WS_Friends_GiveTiliAll_Ack] = WS_Friends_GiveTiliAllAck
MESSAGE_MAP[MSG_ID.WS_Friends_GetTili_Req] = WS_Friends_GetTiliReq
MESSAGE_MAP[MSG_ID.WS_Friends_GetTili_Ack] = WS_Friends_GetTiliAck
MESSAGE_MAP[MSG_ID.WS_Friends_GetTiliAll_Req] = WS_Friends_GetTiliAllReq
MESSAGE_MAP[MSG_ID.WS_Friends_GetTiliAll_Ack] = WS_Friends_GetTiliAllAck
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_FightStart_Req] = WS_FriendsBoss_FightStartReq
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_FightStart_Ack] = WS_FriendsBoss_FightStartAck
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_FightResult_Req] = WS_FriendsBoss_FightResultReq
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_FightResult_Ack] = WS_FriendsBoss_FightResultAck
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_GetInfo_Req] = WS_FriendsBoss_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_GetInfo_Ack] = WS_FriendsBoss_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_GetBossInfo_Req] = WS_FriendsBoss_GetBossInfoReq
MESSAGE_MAP[MSG_ID.WS_FriendsBoss_GetBossInfo_Ack] = WS_FriendsBoss_GetBossInfoAck
MESSAGE_MAP[MSG_ID.WS_Chat_Send_Req] = WS_Chat_SendReq
MESSAGE_MAP[MSG_ID.WS_Chat_Send_Ack] = WS_Chat_SendAck
MESSAGE_MAP[MSG_ID.WS_Chat_Ntf] = WS_ChatNtf
MESSAGE_MAP[MSG_ID.WS_ChatRecord_Ntf] = WS_ChatRecordNtf
MESSAGE_MAP[MSG_ID.WS_Scroll_Ntf] = WS_ScrollNtf
MESSAGE_MAP[MSG_ID.WS_Barrage_Send_Req] = WS_Barrage_SendReq
MESSAGE_MAP[MSG_ID.WS_Barrage_Send_Ack] = WS_Barrage_SendAck
MESSAGE_MAP[MSG_ID.WS_Barrage_Pull_Req] = WS_Barrage_PullReq
MESSAGE_MAP[MSG_ID.WS_Barrage_Pull_Ack] = WS_Barrage_PullAck
MESSAGE_MAP[MSG_ID.WS_Vip_CreateOrder_Req] = WS_Vip_CreateOrderReq
MESSAGE_MAP[MSG_ID.WS_Vip_CreateOrder_Ack] = WS_Vip_CreateOrderAck
MESSAGE_MAP[MSG_ID.WS_Vip_SuccessOrder_Req] = WS_Vip_SuccessOrderReq
MESSAGE_MAP[MSG_ID.WS_Vip_SuccessOrder_Ack] = WS_Vip_SuccessOrderAck
MESSAGE_MAP[MSG_ID.WS_Vip_VipGiftBuy_Req] = WS_Vip_VipGiftBuyReq
MESSAGE_MAP[MSG_ID.WS_Vip_VipGiftBuy_Ack] = WS_Vip_VipGiftBuyAck
MESSAGE_MAP[MSG_ID.WS_Rank_Arena_Req] = WS_Rank_ArenaReq
MESSAGE_MAP[MSG_ID.WS_Rank_Arena_Ack] = WS_Rank_ArenaAck
MESSAGE_MAP[MSG_ID.WS_Rank_Comm_Req] = WS_Rank_CommReq
MESSAGE_MAP[MSG_ID.WS_Rank_Comm_Ack] = WS_Rank_CommAck
MESSAGE_MAP[MSG_ID.WS_Rank_Legion_Req] = WS_Rank_LegionReq
MESSAGE_MAP[MSG_ID.WS_Rank_Legion_Ack] = WS_Rank_LegionAck
MESSAGE_MAP[MSG_ID.WS_Rank_Hero_Req] = WS_Rank_HeroReq
MESSAGE_MAP[MSG_ID.WS_Rank_Hero_Ack] = WS_Rank_HeroAck
MESSAGE_MAP[MSG_ID.WS_Mail_GetList_Req] = WS_Mail_GetListReq
MESSAGE_MAP[MSG_ID.WS_Mail_GetList_Ack] = WS_Mail_GetListAck
MESSAGE_MAP[MSG_ID.WS_Mail_Read_Req] = WS_Mail_ReadReq
MESSAGE_MAP[MSG_ID.WS_Mail_Read_Ack] = WS_Mail_ReadAck
MESSAGE_MAP[MSG_ID.WS_Mail_GetAward_Req] = WS_Mail_GetAwardReq
MESSAGE_MAP[MSG_ID.WS_Mail_GetAward_Ack] = WS_Mail_GetAwardAck
MESSAGE_MAP[MSG_ID.WS_Mail_GetAllAward_Req] = WS_Mail_GetAllAwardReq
MESSAGE_MAP[MSG_ID.WS_Mail_GetAllAward_Ack] = WS_Mail_GetAllAwardAck
MESSAGE_MAP[MSG_ID.WS_Mail_Delete_Req] = WS_Mail_DeleteReq
MESSAGE_MAP[MSG_ID.WS_Mail_Delete_Ack] = WS_Mail_DeleteAck
MESSAGE_MAP[MSG_ID.WS_Bar_Draw_Req] = WS_Bar_DrawReq
MESSAGE_MAP[MSG_ID.WS_Bar_Draw_Ack] = WS_Bar_DrawAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_DailySign_Req] = WS_ActivityAct_DailySignReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_DailySign_Ack] = WS_ActivityAct_DailySignAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_Tili_Req] = WS_ActivityAct_TiliReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_Tili_Ack] = WS_ActivityAct_TiliAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_TiliAdded_Req] = WS_ActivityAct_TiliAddedReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_TiliAdded_Ack] = WS_ActivityAct_TiliAddedAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_CrazyUpgrade_Req] = WS_ActivityAct_CrazyUpgradeReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_CrazyUpgrade_Ack] = WS_ActivityAct_CrazyUpgradeAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LoginVip_Req] = WS_ActivityAct_LoginVipReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LoginVip_Ack] = WS_ActivityAct_LoginVipAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_WishTabRun_Req] = WS_ActivityAct_WishTabRunReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_WishTabRun_Ack] = WS_ActivityAct_WishTabRunAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_WishTabRefresh_Req] = WS_ActivityAct_WishTabRefreshReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_WishTabRefresh_Ack] = WS_ActivityAct_WishTabRefreshAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_OnlineAward_Req] = WS_ActivityAct_OnlineAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_OnlineAward_Ack] = WS_ActivityAct_OnlineAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_VipCardAward_Req] = WS_ActivityAct_VipCardAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_VipCardAward_Ack] = WS_ActivityAct_VipCardAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_TwoCardAward_Req] = WS_ActivityAct_TwoCardAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_TwoCardAward_Ack] = WS_ActivityAct_TwoCardAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_FirstRecharge_Req] = WS_ActivityAct_FirstRechargeReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_FirstRecharge_Ack] = WS_ActivityAct_FirstRechargeAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_VipSign_Req] = WS_ActivityAct_VipSignReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_VipSign_Ack] = WS_ActivityAct_VipSignAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LuckyDiamond_Req] = WS_ActivityAct_LuckyDiamondReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LuckyDiamond_Ack] = WS_ActivityAct_LuckyDiamondAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LuckyDiamondLog_Req] = WS_ActivityAct_LuckyDiamondLogReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_LuckyDiamondLog_Ack] = WS_ActivityAct_LuckyDiamondLogAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_BeInvite_Req] = WS_ActivityAct_BeInviteReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_BeInvite_Ack] = WS_ActivityAct_BeInviteAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_InviteAward_Req] = WS_ActivityAct_InviteAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_InviteAward_Ack] = WS_ActivityAct_InviteAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_RedeemCode_Req] = WS_ActivityAct_RedeemCodeReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_RedeemCode_Ack] = WS_ActivityAct_RedeemCodeAck
MESSAGE_MAP[MSG_ID.WS_ActivityAct_RebateAward_Req] = WS_ActivityAct_RebateAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityAct_RebateAward_Ack] = WS_ActivityAct_RebateAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_GetData_Req] = WS_ActivityOs_GetDataReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_GetData_Ack] = WS_ActivityOs_GetDataAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_LevelAward_Req] = WS_ActivityOs_LevelAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_LevelAward_Ack] = WS_ActivityOs_LevelAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_StarAward_Req] = WS_ActivityOs_StarAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_StarAward_Ack] = WS_ActivityOs_StarAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_PataAward_Req] = WS_ActivityOs_PataAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_PataAward_Ack] = WS_ActivityOs_PataAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_FVAward_Req] = WS_ActivityOs_FVAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_FVAward_Ack] = WS_ActivityOs_FVAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_ArenaAward_Req] = WS_ActivityOs_ArenaAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_ArenaAward_Ack] = WS_ActivityOs_ArenaAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_LoginAward_Req] = WS_ActivityOs_LoginAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_LoginAward_Ack] = WS_ActivityOs_LoginAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_HalfPacks_Req] = WS_ActivityOs_HalfPacksReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_HalfPacks_Ack] = WS_ActivityOs_HalfPacksAck
MESSAGE_MAP[MSG_ID.WS_ActivityOs_RechargeAward_Req] = WS_ActivityOs_RechargeAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityOs_RechargeAward_Ack] = WS_ActivityOs_RechargeAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_GetData_Req] = WS_ActivityGm_GetDataReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_GetData_Ack] = WS_ActivityGm_GetDataAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_DailyActive_Req] = WS_ActivityGm_DailyActiveReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_DailyActive_Ack] = WS_ActivityGm_DailyActiveAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ItemExchange_Req] = WS_ActivityGm_ItemExchangeReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ItemExchange_Ack] = WS_ActivityGm_ItemExchangeAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeHero_Req] = WS_ActivityGm_LimitTimeHeroReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeHero_Ack] = WS_ActivityGm_LimitTimeHeroAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeScore_Req] = WS_ActivityGm_LimitTimeScoreReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeScore_Ack] = WS_ActivityGm_LimitTimeScoreAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeShop_Req] = WS_ActivityGm_LimitTimeShopReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_LimitTimeShop_Ack] = WS_ActivityGm_LimitTimeShopAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundBuy_Req] = WS_ActivityGm_FundBuyReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundBuy_Ack] = WS_ActivityGm_FundBuyAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundAward_Req] = WS_ActivityGm_FundAwardReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundAward_Ack] = WS_ActivityGm_FundAwardAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundWelfare_Req] = WS_ActivityGm_FundWelfareReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_FundWelfare_Ack] = WS_ActivityGm_FundWelfareAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDaily_Req] = WS_ActivityGm_RechargeDailyReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDaily_Ack] = WS_ActivityGm_RechargeDailyAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDailySum_Req] = WS_ActivityGm_RechargeDailySumReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDailySum_Ack] = WS_ActivityGm_RechargeDailySumAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDailySingle_Req] = WS_ActivityGm_RechargeDailySingleReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeDailySingle_Ack] = WS_ActivityGm_RechargeDailySingleAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeSingle_Req] = WS_ActivityGm_RechargeSingleReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeSingle_Ack] = WS_ActivityGm_RechargeSingleAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeSum_Req] = WS_ActivityGm_RechargeSumReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_RechargeSum_Ack] = WS_ActivityGm_RechargeSumAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ConsumSum_Req] = WS_ActivityGm_ConsumSumReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ConsumSum_Ack] = WS_ActivityGm_ConsumSumAck
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ConsumDailySum_Req] = WS_ActivityGm_ConsumDailySumReq
MESSAGE_MAP[MSG_ID.WS_ActivityGm_ConsumDailySum_Ack] = WS_ActivityGm_ConsumDailySumAck
MESSAGE_MAP[MSG_ID.WS_Shop_GetShopItems_Req] = WS_Shop_GetShopItemsReq
MESSAGE_MAP[MSG_ID.WS_Shop_GetShopItems_Ack] = WS_Shop_GetShopItemsAck
MESSAGE_MAP[MSG_ID.WS_Shop_Refresh_Req] = WS_Shop_RefreshReq
MESSAGE_MAP[MSG_ID.WS_Shop_Refresh_Ack] = WS_Shop_RefreshAck
MESSAGE_MAP[MSG_ID.WS_Shop_Buy_Req] = WS_Shop_BuyReq
MESSAGE_MAP[MSG_ID.WS_Shop_Buy_Ack] = WS_Shop_BuyAck
MESSAGE_MAP[MSG_ID.WS_HeroComment_AddComment_Req] = WS_HeroComment_AddCommentReq
MESSAGE_MAP[MSG_ID.WS_HeroComment_AddComment_Ack] = WS_HeroComment_AddCommentAck
MESSAGE_MAP[MSG_ID.WS_HeroComment_Thumb_Req] = WS_HeroComment_ThumbReq
MESSAGE_MAP[MSG_ID.WS_HeroComment_Thumb_Ack] = WS_HeroComment_ThumbAck
MESSAGE_MAP[MSG_ID.WS_HeroComment_PullComment_Req] = WS_HeroComment_PullCommentReq
MESSAGE_MAP[MSG_ID.WS_HeroComment_PullComment_Ack] = WS_HeroComment_PullCommentAck
MESSAGE_MAP[MSG_ID.WS_Treasure_Start_Req] = WS_Treasure_StartReq
MESSAGE_MAP[MSG_ID.WS_Treasure_Start_Ack] = WS_Treasure_StartAck
MESSAGE_MAP[MSG_ID.WS_Treasure_FastStart_Req] = WS_Treasure_FastStartReq
MESSAGE_MAP[MSG_ID.WS_Treasure_FastStart_Ack] = WS_Treasure_FastStartAck
MESSAGE_MAP[MSG_ID.WS_Treasure_GetBoxAward_Req] = WS_Treasure_GetBoxAwardReq
MESSAGE_MAP[MSG_ID.WS_Treasure_GetBoxAward_Ack] = WS_Treasure_GetBoxAwardAck
MESSAGE_MAP[MSG_ID.WS_Treasure_GetInfo_Req] = WS_Treasure_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_Treasure_GetInfo_Ack] = WS_Treasure_GetInfoAck
MESSAGE_MAP[MSG_ID.WS_Dolls_PutCoin_Req] = WS_Dolls_PutCoinReq
MESSAGE_MAP[MSG_ID.WS_Dolls_PutCoin_Ack] = WS_Dolls_PutCoinAck
MESSAGE_MAP[MSG_ID.WS_Dolls_Grab_Req] = WS_Dolls_GrabReq
MESSAGE_MAP[MSG_ID.WS_Dolls_Grab_Ack] = WS_Dolls_GrabAck
MESSAGE_MAP[MSG_ID.WS_Dolls_GetInfo_Req] = WS_Dolls_GetInfoReq
MESSAGE_MAP[MSG_ID.WS_Dolls_GetInfo_Ack] = WS_Dolls_GetInfoAck
TypeNameMap = {
	F85 = "WS_Bar_DrawAck",
	X5 = "RankArenaAckData",
	w80 = "LegionTech",
	E10 = "WS_WorldSpe_FaceStartAck",
	D23 = "WS_Hero_PutDownPartnerAck",
	h15 = "Rate",
	C57 = "LegionBossDetail",
	o9 = "FriendsActionAckData",
	h52 = "ActivityActWishTabRefreshAckData",
	P5 = "HeroConfirmResetAckData",
	F62 = "WS_HeroComment_AddCommentReq",
	k9 = "UUID",
	E67 = "WS_LegionManage_KickAck",
	T5 = "FriendsApplyDetail",
	D76 = "WS_God_ChangeReq",
	w98 = "VType",
	h11 = "SignAward",
	h5 = "TechList",
	Q6 = "FormationSaveAckData",
	U1 = "FriendsSearchAckData",
	d11 = "WS_Trial_SaoDangAck",
	l54 = "WS_Common_SetHeadIdAck",
	F13 = "WS_FriendsBoss_GetInfoAck",
	B56 = "GmRechargeDailySingle",
	B2 = "Formation",
	c0 = "SenderName",
	B13 = "HeroReset",
	M1 = "SelfBaseInfo",
	d4 = "PlayerId",
	d5 = "RoleName",
	w89 = "Adviser",
	i1 = "DailyTaskAwardAckData",
	l06 = "WS_LegionBoss_GetInfoReq",
	x5 = "DiscountPrice",
	F23 = "DungeonType",
	e1 = "HeroWearEquipAckData",
	t11 = "WS_ActivityAct_LuckyDiamondAck",
	l09 = "WS_LegionBoss_BuyBuffAck",
	w79 = "DonateBaseInfo",
	a1 = "CommentList",
	p11 = "LegionWarGetDataAckData",
	h09 = "LeftDays",
	l23 = "WS_LegionWar_BuildFightStartReq",
	l83 = "WS_Friends_ApplyRefuseReq",
	l11 = "WS_LegionBoss_GetAwardAck",
	t5 = "FirstDiamond",
	F45 = "WS_Mail_GetListAck",
	h83 = "OsArenaAward",
	F40 = "WS_Rank_LegionReq",
	T6 = "FriendsBaseData",
	D41 = "WS_Equip_ComposeReq",
	u1 = "LevelId",
	i0 = "DailyTaskCompleteAckData",
	B01 = "ItemExchange",
	E6 = "WinCount",
	p83 = "ItemTid",
	d89 = "WS_WorldRes_ChangeAck",
	l82 = "WS_Friends_ApplyPassAck",
	w57 = "WorldBossDamageRankAckData",
	m1 = "CommonSetHeadIdAckData",
	h98 = "Notice",
	t09 = "WS_ActivityAct_VipSignAck",
	F79 = "WS_Dolls_PutCoinAck",
	Y5 = "SenderTm",
	t14 = "WS_ActivityAct_BeInviteReq",
	p09 = "LegionWarGetFightNodeAckData",
	A04 = "TrailLevel",
	E32 = "WS_Legion_SearchAck",
	A72 = "FreeTotalCount",
	L9 = "StarAwardList",
	A81 = "TotalFightCnt",
	A17 = "AwardLayerInfo",
	Y8 = "AwardState",
	t51 = "WS_ActivityGm_LimitTimeShopReq",
	B79 = "ActivityGmRechargeSingleAckData",
	R4 = "TeamResetHireAckData",
	E29 = "WS_Legion_PageListReq",
	D05 = "WS_Hero_TupoReq",
	D42 = "WS_Equip_ComposeAck",
	F98 = "WS_ActivityAct_WishTabRefreshReq",
	A85 = "ScoreAwardList",
	w64 = "LegionBoss",
	E09 = "WS_WorldSpe_FaceStartReq",
	l86 = "WS_Friends_ApplyRefuseAllAck",
	h20 = "AddedCost",
	w12 = "WorldBgzInfo",
	C88 = "JoinCount",
	C85 = "Log",
	h18 = "EndHour",
	C78 = "EliteList",
	p67 = "WS_Login_GameCompleteAck",
	A43 = "BuyList",
	C07 = "OpenState",
	F09 = "WS_FriendsBoss_FightStartAck",
	F10 = "WS_FriendsBoss_FightResultReq",
	E43 = "WS_Legion_GetDataReq",
	C06 = "LegionTrainDetail",
	t1 = "GoodsType",
	F8 = "SaleDiamond",
	l98 = "WS_Friends_FightResultAck",
	Y2 = "MailGetListData",
	l05 = "WS_LegionBoss_GetHurtRankAck",
	B89 = "AwardBoxList",
	D18 = "WS_HeroSoul_ExchangeAck",
	C2 = "ActivityGm",
	h05 = "RebateAward",
	N8 = "ChatType",
	F07 = "LevelIndex",
	B44 = "GmFund",
	d05 = "WS_Trial_FightStartAck",
	J8 = "GodList",
	B07 = "RechargeDailySum",
	F44 = "WS_Mail_GetListReq",
	w41 = "WorldSpeAwardBoxAckData",
	V8 = "BossInfo",
	l9 = "QuarterCard",
	l47 = "WS_Common_GetGameEnvReq",
	A98 = "DailySign",
	K4 = "SAttr",
	F61 = "WS_Shop_BuyAck",
	D80 = "WS_MainTask_GetDataReq",
	l33 = "WS_LegionWar_EliteSetReq",
	O4 = "HeroFragComposeAckData",
	h65 = "OsBaseInfo",
	t47 = "WS_ActivityGm_LimitTimeHeroReq",
	t05 = "WS_ActivityAct_TwoCardAwardAck",
	t42 = "WS_ActivityGm_GetDataAck",
	Q8 = "MainTaskAwardAckData",
	w01 = "Output",
	p05 = "LegionWarReport",
	f8 = "EquipList",
	C00 = "OpenCount",
	C01 = "ContinueCount",
	w65 = "SendMax",
	L0 = "DailyTaskDetail",
	M0 = "Sign",
	C62 = "LegionBossBuyBuffAckData",
	w81 = "LegionApply",
	H0 = "DollsMoney",
	F30 = "WS_Vip_CreateOrderAck",
	w06 = "WorldTaskTeam",
	F67 = "WS_HeroComment_PullCommentReq",
	D01 = "WS_Hero_UpgradeSkillReq",
	E39 = "WS_Legion_ClearJoinCDReq",
	F70 = "WS_Treasure_StartAck",
	C10 = "MaxLevel",
	W4 = "Content",
	A39 = "PataSaoDangDetail",
	F80 = "WS_Dolls_GrabReq",
	t69 = "WS_ActivityGm_ConsumSumReq",
	k4 = "ArenaFightStartAckData",
	F34 = "WS_Vip_VipGiftBuyAck",
	E0 = "LastTm",
	A7 = "PacketHeader",
	o4 = "ActionValue",
	A69 = "BarList",
	A47 = "SkillIndex",
	E7 = "LegionId",
	c4 = "IsHorn",
	p03 = "LegionWarEliteSetAckData",
	E47 = "WS_Legion_GetApplyReq",
	D73 = "WS_God_UpgradeStarAck",
	g4 = "EquipRefreshHoleAckData",
	h46 = "ActivityActDailySignAckData",
	p38 = "AS_NoticeListReq",
	t18 = "RedeemCode",
	l01 = "WS_LegionBoss_StartFightAck",
	l46 = "WS_LegionWar_BuildDefendInfoAck",
	t27 = "WS_ActivityOs_StarAwardReq",
	t32 = "WS_ActivityOs_FVAwardAck",
	h0 = "VipInfo",
	F36 = "WS_Rank_ArenaAck",
	F03 = "WS_Friends_GetTiliReq",
	t46 = "WS_ActivityGm_ItemExchangeAck",
	s4 = "ChatLegionRecord",
	d46 = "WS_Pata_SaoDangTurnBrandNextReq",
	E72 = "WS_LegionGame_RollingGainReq",
	A10 = "TrialFightResultAckData",
	w45 = "WorldBossBaseInfo",
	p52 = "LoginServer",
	b0 = "Food",
	C37 = "LegionManageKickAckData",
	B71 = "ActivityGmLimitTimeScoreAckData",
	E98 = "WS_LegionGame_GetHongbaoReq",
	l38 = "WS_LegionWar_ReportAck",
	l73 = "WS_SyncData_FormationReq",
	x0 = "MailGetAwardAckData",
	p46 = "LastTime",
	h38 = "InviteCount",
	B1 = "GodInfo",
	t01 = "WS_ActivityAct_OnlineAwardAck",
	F71 = "WS_Treasure_FastStartReq",
	d38 = "WS_Pata_SaoDangTurnBrandAck",
	d73 = "WS_World_GetLogAck",
	p01 = "LegionWarPlayerFightResultAckData",
	B76 = "ActivityGmRechargeDailyAckData",
	B49 = "GmWelfareDetail",
	C68 = "DailyCombatMax",
	B36 = "GmScoreExchangeDetail",
	F38 = "WS_Rank_CommReq",
	d2 = "HeroTid",
	x8 = "ShopType",
	C70 = "DailyRepairMax",
	t12 = "WS_ActivityAct_LuckyDiamondLogReq",
	C76 = "CDState",
	w02 = "WorldHoldNode",
	T1 = "FriendsGetDataAckData",
	E35 = "WS_Legion_ApplyReq",
	t38 = "WS_ActivityOs_HalfPacksAck",
	p8 = "ServTime",
	t48 = "WS_ActivityGm_LimitTimeHeroAck",
	A35 = "PataPlayerInfo",
	B69 = "ActivityGmItemExchangeAckData",
	h73 = "RechargeAward",
	D3 = "AwardItem",
	H1 = "WealthInfo",
	F69 = "WS_Treasure_StartReq",
	D77 = "WS_God_ChangeAck",
	h8 = "EquipFragList",
	h32 = "ActOnlineAward",
	j8 = "SkillId",
	l89 = "WS_Friends_ActionReq",
	P3 = "HeroUpgradeSatisfyAckData",
	n8 = "GemList",
	D34 = "WS_Bag_SaleItemAck",
	w29 = "WorldResSettleAckData",
	w5 = "BgzInfo",
	d8 = "HeadId",
	A92 = "BgzFightResultAckData",
	A00 = "DollsGrabAckData",
	K7 = "EquipAttrInfo",
	A4 = "ProtoVersion",
	E76 = "WS_LegionGame_DinnerGainReq",
	l94 = "WS_Friends_RecommendAck",
	E00 = "WS_WorldSpe_HCFightStartReq",
	F53 = "WS_Mail_DeleteReq",
	I7 = "Quality",
	l26 = "WS_LegionWar_BuildFightResultAck",
	I4 = "PartnerInfo",
	d09 = "WS_Trial_GetInfoAck",
	F91 = "WS_ActivityAct_TiliAddedAck",
	d01 = "WS_GameLevel_GetDataAck",
	E4 = "Rank",
	F32 = "WS_Vip_SuccessOrderAck",
	A76 = "SinglePrice",
	C33 = "LegionGetSelfInfoAckData",
	T8 = "FriendsDetail",
	F75 = "WS_Treasure_GetBoxAwardAck",
	l34 = "WS_LegionWar_EliteSetAck",
	w68 = "GainCount",
	N3 = "HeroSoulDetail",
	D6 = "AttrType",
	Y7 = "ReadState",
	h77 = "Recharge",
	J3 = "HeroCastExtraAttr",
	E2 = "PlayerBaseInfo",
	M7 = "BuffList",
	p70 = "WS_Player_BaseFormationReq",
	F3 = "VipSign",
	B75 = "ActivityGmFundWelfareAckData",
	Q7 = "MainTaskGetDataAckData",
	B8 = "CDInfo",
	B3 = "ForceSection",
	B16 = "ShowEnd",
	e7 = "HeroCastAckData",
	B0 = "HeroList",
	h42 = "NeedLevel",
	C45 = "LegionGameWelfareAckData",
	i7 = "RoleExp",
	F12 = "WS_FriendsBoss_GetInfoReq",
	Z3 = "AllShopList",
	E31 = "WS_Legion_SearchReq",
	t34 = "WS_ActivityOs_ArenaAwardAck",
	l77 = "WS_Friends_GetDataReq",
	C74 = "DailyLeftHp",
	B28 = "ExchangeNum",
	a7 = "Box1State",
	p77 = "WS_HeroFrag_ComposeAck",
	R3 = "GameLevelGetDataAckData",
	w00 = "FullTm",
	u7 = "TeamHireInfo",
	l52 = "WS_Common_SetRoleNameAck",
	n3 = "Bag",
	w60 = "DailyDonate",
	y7 = "HeroAddAttrList",
	c8 = "ChatWorldCD",
	F94 = "WS_ActivityAct_LoginVipReq",
	F28 = "WS_Barrage_PullAck",
	m7 = "CommonFightResultAckData",
	w33 = "SpecialType",
	f3 = "BuildingDetail",
	A62 = "PataSaoDangNextAckData",
	C29 = "MemberList",
	P0 = "HeroSoulExchangeAckData",
	b3 = "Soul",
	E62 = "WS_LegionManage_ApplyPassReq",
	A02 = "TrialList",
	B59 = "GmRechargeSingleDetail",
	p90 = "SrcSlot",
	V3 = "KillerId",
	E04 = "WS_WorldSpe_HCGiveUpReq",
	F59 = "ShopItemIndex",
	z3 = "TreasureGetBoxAwardAckData",
	E97 = "WS_LegionGame_GainHongbaoAck",
	E75 = "WS_LegionGame_DinnerOpenAck",
	w1 = "BarInfo",
	v3 = "RankLegionAckData",
	A97 = "BgzGetBossInfoAckData",
	J2 = "AttrInfo",
	E54 = "WS_Legion_DonateAck",
	w74 = "MaxMemberCount",
	x4 = "MoneyType",
	l30 = "WS_LegionWar_PlayerFightResultAck",
	D26 = "WS_Hero_UpgradeSatisfyAck",
	p19 = "LS_LoginReq",
	h81 = "OsPataAward",
	h30 = "WishTurntableSlot",
	w95 = "Donate",
	A27 = "BuffBuyList",
	t54 = "WS_ActivityGm_FundBuyAck",
	D96 = "WS_GameLevel_StarAwardReq",
	B88 = "FaceList",
	D99 = "WS_GameLevel_ResetAck",
	K8 = "AttrList",
	N4 = "HeroSoulId",
	C60 = "LegionBossRankDetail",
	B74 = "ActivityGmFundAwardAckData",
	d7 = "VipLevel",
	h4 = "BuildingList",
	l32 = "WS_LegionWar_DefendSetAck",
	E27 = "WS_WorldBoss_GetAwardReq",
	B24 = "GmItemExchange",
	t62 = "WS_ActivityGm_RechargeDailySumAck",
	H5 = "SkillBookCount",
	l63 = "WS_Common_HeartBeatAck",
	C22 = "LegionPageListAckData",
	t30 = "WS_ActivityOs_PataAwardAck",
	C91 = "NpcId",
	l5 = "VipBaseInfo",
	t39 = "WS_ActivityOs_RechargeAwardReq",
	B61 = "GmRechargeSumDetail",
	h29 = "ActWishTurntable",
	d63 = "WS_Bgz_GetInfoAck",
	F24 = "LevelWave",
	p84 = "WS_Hero_UpgradeReq",
	d26 = "WS_Pata_BuyBuffReq",
	U9 = "FriendsGetTiliAllAckData",
	B09 = "RechargeSingle",
	C25 = "LegionApplyAckData",
	p26 = "Platform",
	F90 = "WS_ActivityAct_TiliAddedReq",
	t52 = "WS_ActivityGm_LimitTimeShopAck",
	d96 = "WS_WorldSpe_GetInfoReq",
	l90 = "WS_Friends_ActionAck",
	B90 = "SettleList",
	A66 = "PataSaoDangBuyBuffNextAckData",
	t17 = "WS_ActivityAct_InviteAwardAck",
	h26 = "RunCost",
	t63 = "WS_ActivityGm_RechargeDailySingleReq",
	E66 = "WS_LegionManage_KickReq",
	l96 = "WS_Friends_FightStartAck",
	t26 = "WS_ActivityOs_LevelAwardAck",
	H6 = "GemOpenHoleCount",
	d90 = "WS_WorldRes_TauntReq",
	h96 = "ActivityOsHalfPacksAckData",
	i9 = "ExtraAwardList",
	L6 = "Passed",
	E93 = "WS_LegionGame_GetBlessLogAck",
	q6 = "HpPercent",
	D22 = "WS_Hero_PutDownPartnerReq",
	t25 = "WS_ActivityOs_LevelAwardReq",
	A93 = "BgzGetAwardAckData",
	p96 = "WS_Hero_SwapEquipReq",
	D87 = "WS_DailyTask_CompleteAck",
	D67 = "WS_Tech_FastUpgradeAck",
	E06 = "WS_WorldSpe_BgzBribeReq",
	E51 = "WS_Legion_GetSelfInfoReq",
	E19 = "WS_WorldBoss_ClearCDReq",
	X6 = "SelfRankInfo",
	E02 = "WS_WorldSpe_HCFightResultReq",
	d3 = "EquipSlot",
	A19 = "BestLayer",
	I2 = "WashInfo",
	V5 = "TotalFightCount",
	D92 = "WS_GameLevel_FightResultReq",
	p68 = "WS_Login_OutReq",
	E23 = "WS_WorldBoss_DamageRankReq",
	p42 = "AS_NoticeData",
	t67 = "WS_ActivityGm_RechargeSumReq",
	C64 = "ApplyStartTm",
	A2 = "NodMsg",
	d88 = "WS_WorldRes_ChangeReq",
	f9 = "SkillList",
	c6 = "ChatMsg",
	h6 = "BagItemList",
	B98 = "RefreshTm",
	p76 = "WS_HeroFrag_ComposeReq",
	h22 = "ActLoginVip",
	l67 = "WS_Common_FightResultAck",
	F20 = "WS_ChatNtf",
	h53 = "ActivityActOnlineAwardAckData",
	d22 = "WS_Arena_SignatureReq",
	U2 = "RecommendList",
	B20 = "GmDoubleDrop",
	B65 = "GmConsumDailySum",
	D84 = "WS_DailyTask_GetDataReq",
	d67 = "WS_Bgz_GetBossInfoAck",
	h34 = "MaxIncome",
	w25 = "WorldResFightResultAckData",
	v6 = "GameOrderId",
	x6 = "SaleState",
	C0 = "ActivityAct",
	B41 = "GmGoodsDetail",
	E1 = "Online",
	i2 = "GodUpgradeAckData",
	E49 = "WS_Legion_GetLogReq",
	d92 = "WS_WorldTask_StartReq",
	t22 = "WS_ActivityAct_RebateAwardAck",
	l18 = "RepairType",
	t43 = "WS_ActivityGm_DailyActiveReq",
	C21 = "LegionList",
	p22 = "Ticket",
	E85 = "WS_LegionGame_TrainStartAck",
	d87 = "WS_WorldRes_SettleAck",
	l92 = "WS_Friends_SearchAck",
	B51 = "GmRechargeDaily",
	d18 = "WS_Arena_RecordListReq",
	C48 = "LegionGameBuyBlessAckData",
	h92 = "ActivityOsPataAwardAckData",
	F51 = "WS_Mail_GetAllAwardAck",
	y2 = "BattleGodSkill",
	R1 = "GameLevelStarAwardAckData",
	w47 = "FightCD",
	h84 = "LoginCount",
	u2 = "FightCount",
	d45 = "WS_Pata_GetScoreAwardAck",
	p92 = "WS_Hero_WearEquipReq",
	d84 = "WS_WorldRes_ClearCDReq",
	q2 = "BossRoleId",
	F86 = "WS_ActivityAct_DailySignReq",
	C50 = "LegionGameGetBlessLogAckData",
	E15 = "WS_WorldBoss_StartFightReq",
	m2 = "CommonDiamondExchangeAckData",
	d99 = "WS_WorldSpe_OpenAck",
	w76 = "Confirm",
	l84 = "WS_Friends_ApplyRefuseAck",
	F49 = "WS_Mail_GetAwardAck",
	D94 = "WS_GameLevel_SaoDangReq",
	F89 = "WS_ActivityAct_TiliAck",
	w83 = "LegionDinner",
	d42 = "WS_Pata_SaoDangBuyBuffAck",
	L4 = "ForceList",
	d30 = "WS_Pata_GetAwardAck",
	d06 = "WS_Trial_FightResultReq",
	h01 = "WishTurntable",
	C84 = "LegionWarLegion",
	D50 = "WS_Equip_GemSetReq",
	W0 = "Priority",
	D14 = "WS_HeroSoul_BuyAck",
	B86 = "SpecialList",
	F65 = "WS_HeroComment_ThumbAck",
	a5 = "CommentDetail",
	C65 = "ApplyEndTm",
	z8 = "DollsDetail",
	w21 = "WorldUnlockAckData",
	C99 = "LegionWarBuildFightResultAckData",
	l8 = "MonthCard",
	d56 = "WS_Bgz_FightResultReq",
	Q4 = "TechFastUpgradeAckData",
	d23 = "WS_Arena_SignatureAck",
	A52 = "PataTurnBrandDetail",
	Q1 = "BuildingImmCompleteAckData",
	w78 = "ManagerInfo",
	h80 = "OsStarAward",
	E52 = "WS_Legion_GetSelfInfoAck",
	C17 = "LegionHongbaoLogDetail",
	C87 = "LegionWarLogDetail",
	Z8 = "Comment",
	F9 = "VipGiftDetail",
	w48 = "WorldBossSelfInfo",
	D38 = "WS_Equip_UpgradeAck",
	D9 = "AttrDetail",
	B9 = "DailyRefresh",
	l53 = "WS_Common_SetHeadIdReq",
	A31 = "FightResultState",
	d10 = "WS_Trial_SaoDangReq",
	N9 = "SenderId",
	A24 = "PataBaseInfo",
	F16 = "TargetId",
	B55 = "GmRechargeDailySumDetail",
	d14 = "WS_Arena_FightStartReq",
	d53 = "WS_Pata_StartSaoDangAck",
	w50 = "SelfInfo",
	F55 = "WS_Shop_GetShopItemsReq",
	V9 = "FriendsBossFightResultAckData",
	D98 = "WS_GameLevel_ResetReq",
	K5 = "GemAttr",
	Z1 = "ItemList",
	R9 = "Signature",
	B82 = "ActivityGmConsumDailySumAckData",
	O5 = "HeroFragDecomposeAckData",
	l80 = "WS_Friends_ApplyAck",
	l6 = "VipGift",
	p53 = "AreaServer",
	C5 = "BagItem",
	E11 = "WS_WorldSpe_FaceEndReq",
	Z9 = "HeroCommentAddCommentAckData",
	t53 = "WS_ActivityGm_FundBuyReq",
	G5 = "VipCardInfo",
	w99 = "LegionLogDetail",
	E81 = "WS_LegionGame_GetDinnerLogAck",
	D85 = "WS_DailyTask_GetDataAck",
	w77 = "LegionBaseInfo",
	p80 = "WS_HeroFrag_DecomposeAck",
	b9 = "BarMoney",
	c3 = "SenderHeadId",
	C83 = "LegionWarBuildDetail",
	B62 = "ConsumList",
	n9 = "EquipDetail",
	w17 = "WorldLogDetail",
	S5 = "ArenaSignatureAckData",
	p79 = "WS_HeroFrag_DecomposeReq",
	D10 = "FateIdDes",
	D57 = "WS_Building_GetDataAck",
	W5 = "Tm",
	d80 = "WS_WorldRes_GainReq",
	v9 = "VipSuccessOrderAckData",
	F82 = "WS_Dolls_GetInfoReq",
	k5 = "IsBestRank",
	A23 = "Mode",
	C09 = "SelfState",
	D51 = "WS_Equip_GemSetAck",
	o5 = "ActionTm",
	L8 = "LevelList",
	A56 = "PataBuyBuffAckData",
	D46 = "WS_Equip_OpenHoleAck",
	c5 = "ChatTm",
	h2 = "CapacityInfo",
	z9 = "DollsPutCoinAckData",
	C13 = "LegionBlessLogDetail",
	g5 = "EquipGemSetAckData",
	D56 = "WS_Building_GetDataReq",
	P1 = "HeroPutOnPartnerAckData",
	h57 = "ActivityActVipSignAckData",
	D53 = "WS_Equip_GemRemoveAck",
	D63 = "WS_Building_IncomeAck",
	l10 = "WS_LegionBoss_GetAwardReq",
	l57 = "WS_Common_DiamondExchangeAck",
	d34 = "WS_Pata_FightResultAck",
	K1 = "HeroFragDetail",
	h1 = "Wealth",
	N1 = "HeroSoulAddAttrDetail",
	s5 = "ChatSystemRecord",
	D45 = "WS_Equip_OpenHoleReq",
	d1 = "EquipId",
	C40 = "LegionGameRollingGainAckData",
	w54 = "WorldBossInspireAckData",
	p32 = "ServerId",
	D44 = "WS_Equip_DecomposeAck",
	C58 = "LegionBossFightResultAckData",
	C97 = "LegionWarBuildFightStartAckData",
	C12 = "LegionBlessDetail",
	A11 = "TrialGetInfoAckData",
	p5 = "BagEquipChange",
	k0 = "CombatCount",
	B67 = "GmHeroReset",
	x1 = "MailGetAllAwardAckData",
	p57 = "Ret",
	D12 = "WS_Hero_ExchangeFateAck",
	x9 = "FlushCount",
	t10 = "WS_ActivityAct_LuckyDiamondReq",
	t57 = "WS_ActivityGm_FundWelfareReq",
	D11 = "WS_Hero_ExchangeFateReq",
	F04 = "WS_Friends_GetTiliAck",
	F41 = "WS_Rank_LegionAck",
	C79 = "AttackLegion",
	p75 = "WS_Player_GameInfoAck",
	B04 = "Fund",
	D09 = "FateIdRes",
	F76 = "WS_Treasure_GetInfoReq",
	B96 = "PlayerName",
	B63 = "GmConsumSum",
	E71 = "WS_LegionGame_RollingContinueAck",
	w13 = "WorldShopInfo",
	E56 = "WS_LegionManage_SignatureAck",
	p98 = "WS_Hero_FastUpgradeEquipReq",
	g8 = "EquipUpStarAckData",
	t49 = "WS_ActivityGm_LimitTimeScoreReq",
	d57 = "WS_Bgz_FightResultAck",
	A42 = "PataSaoDangAwardDetail",
	p89 = "WS_Hero_UpgradeStarAck",
	l16 = "WS_LegionWar_DailyFightResultReq",
	B78 = "ActivityGmRechargeDailySingleAckData",
	E42 = "WS_Legion_QuitAck",
	C05 = "TrainMode",
	H4 = "TiliCount",
	F78 = "WS_Dolls_PutCoinReq",
	p73 = "WS_Player_FormationAck",
	p66 = "WS_Login_GameCompleteReq",
	A08 = "LimitCount",
	p65 = "WS_Login_GameAck",
	B4 = "SelfArenaInfo",
	p63 = "WS_Login_GameReq",
	D06 = "WS_Hero_TupoAck",
	w38 = "WorldSpeBgzBribeAckData",
	D88 = "WS_DailyTask_AwardReq",
	l15 = "WS_LegionWar_DailyFightStartAck",
	w40 = "WorldSpeFaceEndAckData",
	D43 = "WS_Equip_DecomposeReq",
	p60 = "AS_AccountActivateReq",
	p59 = "AcCode",
	A8 = "GameEnvInfo",
	E96 = "WS_LegionGame_GainHongbaoReq",
	Q2 = "BuildingIncomeAckData",
	p54 = "PayServer",
	p51 = "Dump",
	t60 = "WS_ActivityGm_RechargeDailyAck",
	p49 = "Package",
	B94 = "NodeId",
	C44 = "LegionGameGetDinnerLogAckData",
	E07 = "WS_WorldSpe_BgzBribeAck",
	T4 = "ApplyTm",
	y6 = "HeroSoulList",
	E89 = "WS_LegionGame_BuyBlessAck",
	A07 = "TrialType",
	h63 = "ActivityActRedeemCodeAckData",
	i8 = "GameLevelFightResultAckData",
	J4 = "MasterTid",
	h43 = "ActBeInvite",
	h67 = "StarAward",
	P4 = "HeroCalcResetAckData",
	M8 = "BattleFormation",
	l43 = "WS_LegionWar_GetDataReq",
	h88 = "OsHalfPacks",
	p30 = "AS_AreaListAck",
	B45 = "GmFundIncome",
	v8 = "VipCreateOrderAckData",
	F00 = "WS_Friends_GiveTiliAck",
	w05 = "WorldTaskNode",
	U8 = "FriendsGetTiliAckData",
	d43 = "AwardScore",
	p88 = "WS_Hero_UpgradeStarReq",
	v4 = "RankHeroAckData",
	Z4 = "AllShopInfo",
	h14 = "Vip",
	l88 = "WS_Friends_DeleteAck",
	h10 = "SignToday",
	O0 = "ChatPrivateCD",
	v7 = "Extra",
	p18 = "Token",
	p17 = "ChannelId",
	t06 = "WS_ActivityAct_FirstRechargeReq",
	p43 = "AS_RoleInfoReq",
	E8 = "LegionName",
	A46 = "PataSaoDangBoxLayerDetail",
	e8 = "HeroExchangeFateAckData",
	B39 = "ShowPrice",
	p4 = "BagItemChange",
	E46 = "WS_Legion_GetMembersAck",
	q8 = "BossDegree",
	w8 = "HeroSoulHallInfo",
	d74 = "WS_WorldRes_GetInfoReq",
	p06 = "LegionWarReportAckData",
	m8 = "FriendsBaseInfo",
	K9 = "GemAttrDetail",
	O1 = "TiliCD",
	w11 = "BgzClue",
	b4 = "EquipSoul",
	D02 = "WS_Hero_UpgradeSkillAck",
	C95 = "LegionWarDailyRepairAckData",
	A73 = "NextFreeTm",
	w44 = "DeadTm",
	F97 = "WS_ActivityAct_WishTabRunAck",
	D47 = "WS_Equip_RefreshHoleReq",
	E73 = "WS_LegionGame_RollingGainAck",
	z4 = "TreasureGetInfoAckData",
	w09 = "WorldFaceDetail",
	p0 = "New",
	C93 = "LossHp",
	o0 = "ActionCount",
	y8 = "HeroSoulHallDetail",
	h7 = "BagEquipList",
	C23 = "LegionSearchAckData",
	r4 = "MainTaskDetail",
	r8 = "NeedCount",
	E03 = "WS_WorldSpe_HCFightResultAck",
	h06 = "ActivityActInfo",
	g0 = "EquipCuilianAckData",
	I0 = "HeroAttr",
	A03 = "AllTrialInfo",
	A5 = "ServPacketHeader",
	D72 = "WS_God_UpgradeStarReq",
	l02 = "WS_LegionBoss_FightResultReq",
	h47 = "ActivityActTiliAckData",
	D37 = "WS_Equip_UpgradeReq",
	s9 = "ScrollType",
	h02 = "OnlineAward",
	A36 = "BuffId",
	j9 = "HeroSkill",
	y3 = "Layout",
	d02 = "WS_Team_ResetHireReq",
	B05 = "FundWelfare",
	A87 = "LineList",
	w0 = "CreateTime",
	C71 = "DailyRepairNum",
	d47 = "WS_Pata_SaoDangTurnBrandNextAck",
	G6 = "TwoCardInfo",
	s0 = "FriendsBossGetInfoAckData",
	C82 = "DefendList",
	E36 = "WS_Legion_ApplyAck",
	C1 = "ActivityOs",
	h72 = "HalfPacks",
	B35 = "GmLimitTimeHero",
	b8 = "Horn",
	l0 = "PlayerBaseFormationInfo",
	l72 = "WS_SyncData_UpgradeInfoAck",
	t02 = "WS_ActivityAct_VipCardAwardReq",
	p47 = "AS_RoleData",
	l37 = "WS_LegionWar_ReportReq",
	h54 = "ActivityActVipCardAwardAckData",
	p02 = "LegionWarDefendSetAckData",
	B70 = "ActivityGmLimitTimeHeroAckData",
	V4 = "TotalHurt",
	d72 = "WS_World_GetLogReq",
	F35 = "WS_Rank_ArenaReq",
	p95 = "DstHero",
	d37 = "WS_Pata_SaoDangTurnBrandReq",
	C34 = "LegionDonateAckData",
	l45 = "WS_LegionWar_BuildDefendInfoReq",
	E69 = "WS_LegionGame_RollingOpenAck",
	p37 = "AS_ServerData",
	Y1 = "MailList",
	h68 = "PataAward",
	h90 = "ActivityOsLevelAwardAckData",
	A77 = "TenPrice",
	p72 = "WS_Player_FormationReq",
	l68 = "WS_SyncDataNtf",
	C6 = "BagEquip",
	E77 = "WS_LegionGame_DinnerGainAck",
	t72 = "WS_ActivityGm_ConsumDailySumAck",
	B5 = "MainTask",
	M4 = "EnemyFormation",
	t37 = "WS_ActivityOs_HalfPacksReq",
	H7 = "DollsMoneyCount",
	d68 = "WS_World_GetInfoReq",
	w6 = "TeamHire",
	u4 = "ForceLevelDetail",
	L7 = "StarCount",
	g2 = "EquipDecomposeAckData",
	F4 = "NextExp",
	D33 = "WS_Bag_SaleItemReq",
	p14 = "RetCode",
	R0 = "GameLevelSaoDangAckData",
	l66 = "WS_Common_FightResultReq",
	B92 = "LogList",
	D7 = "AddType",
	w71 = "LegionBossBaseInfo",
	V6 = "FriendsBossDetail",
	C8 = "EquipFrag",
	X7 = "HistoryInfo",
	t68 = "WS_ActivityGm_RechargeSumAck",
	I3 = "CastList",
	G4 = "DailyAward",
	C30 = "LegionGetMembersAckData",
	A15 = "SaoDangInfo",
	E3 = "BestFV",
	C67 = "FightEndTm",
	P7 = "BagSaleItemAckData",
	C75 = "CD",
	A32 = "PataFightLayerInfo",
	p10 = "LegionWarNodeList",
	T7 = "ActionList",
	W1 = "Repeat",
	j3 = "EquipData",
	B53 = "RechargeList",
	h76 = "ArenaRank",
	b5 = "Arena",
	Y3 = "MailId",
	h33 = "NeedVip",
	l7 = "VipShop",
	F31 = "WS_Vip_SuccessOrderReq",
	U3 = "FriendsRecommendAckData",
	d33 = "WS_Pata_FightResultReq",
	d83 = "WS_WorldRes_RefreshAck",
	B31 = "SingleScore",
	Q3 = "TechUpgradeAckData",
	D95 = "WS_GameLevel_SaoDangAck",
	w34 = "WorldSpeOpenAckData",
	B91 = "GodDomainList",
	F74 = "WS_Treasure_GetBoxAwardReq",
	C4 = "Hero",
	x7 = "ShopItemDetail",
	w43 = "AwardTm",
	i3 = "GodUpgradeStarAckData",
	C28 = "LegionQuitAckData",
	B12 = "ConsumDailySum",
	K0 = "EquipFragDetail",
	e3 = "HeroFastUpgradeEquipAckData",
	t33 = "WS_ActivityOs_ArenaAwardReq",
	p7 = "EquipFragChange",
	h87 = "OsLoginAwardDetail",
	E94 = "WS_LegionGame_SendHongbaoReq",
	p33 = "ServerName",
	t7 = "DailyAwardList",
	F43 = "WS_Rank_HeroAck",
	F29 = "WS_Vip_CreateOrderReq",
	C59 = "LegionBossGetHurtRankAckData",
	h45 = "VipExp",
	S4 = "ArenaResetAckData",
	B29 = "GmExchangeDetail",
	s8 = "ChatPrivateDetail",
	C90 = "LegionWarDailyAwardAckData",
	A3 = "MsgID",
	u3 = "RefreshCount",
	h95 = "ActivityOsLoginAwardAckData",
	I8 = "Star",
	p6 = "HeroFragChange",
	q3 = "RoleLevel",
	d95 = "WS_WorldTask_GainAck",
	C63 = "LegionBossGetAwardAckData",
	E26 = "WS_WorldBoss_GetInfoAck",
	A94 = "BgzGetScoreAwardAckData",
	F56 = "WS_Shop_GetShopItemsAck",
	B58 = "GmRechargeSingle",
	A26 = "PataScoreAwardInfo",
	f4 = "TechId",
	l95 = "WS_Friends_FightStartReq",
	F58 = "WS_Shop_RefreshAck",
	r3 = "TaskId",
	F46 = "WS_Mail_ReadReq",
	G0 = "Icon",
	F42 = "WS_Rank_HeroReq",
	m4 = "CommonBattleRecordAckData",
	n4 = "ItemDetail",
	C41 = "LegionGameDinnerOpenAckData",
	D27 = "WS_Hero_CalcResetReq",
	A44 = "PataSaoDangBuffLayerDetail",
	w87 = "LegionDetail",
	w28 = "WorldResClearCDAckData",
	A9 = "BaseInfo",
	D60 = "WS_Building_ImmCompleteReq",
	S3 = "ArenaRecord",
	p45 = "AS_RoleInfoAck",
	w30 = "WorldTaskStartAckData",
	w92 = "LegionTechDetail",
	t2 = "Price",
	a2 = "HeroCommentPullCommentAckData",
	a6 = "MagnifierCount",
	C32 = "LegionGetLogAckData",
	C31 = "LegionGetApplyAckData",
	B40 = "SalePrice",
	l20 = "WS_LegionWar_DailyRepairAck",
	l00 = "WS_LegionBoss_StartFightReq",
	A61 = "PataSaoDangTurnBrandAckData",
	u8 = "RandomSeed",
	C96 = "LegionWarApplyAckData",
	F60 = "WS_Shop_BuyReq",
	E61 = "WS_LegionManage_OfficeSetAck",
	C24 = "LegionCreateAckData",
	l27 = "WS_LegionWar_PlayerFightStartReq",
	h60 = "ActivityActLuckyDiamondLogAckData",
	A90 = "BgzScoreAwardDetail",
	D29 = "WS_Hero_ConfirmResetReq",
	h27 = "RefreshCost",
	l60 = "WS_Common_BattleRecordReq",
	R8 = "ArenaInfo",
	B66 = "GmConsumDailySumDetail",
	d27 = "WS_Pata_BuyBuffAck",
	D0 = "Type",
	F25 = "WS_Barrage_SendReq",
	F66 = "LastRecordTm",
	w63 = "Hongbao",
	d60 = "WS_Bgz_GetScoreAwardReq",
	B25 = "CostNum",
	D91 = "WS_GameLevel_FightStartAck",
	K6 = "Addition",
	l1 = "PlayerFormationInfo",
	F39 = "WS_Rank_CommAck",
	B97 = "Taunt",
	O6 = "HeroFragExchangeSoulAckData",
	B93 = "WorldInfo",
	w52 = "WorldBossFightResultAckData",
	l91 = "WS_Friends_SearchReq",
	w96 = "LegionMemberBaseInfo",
	E22 = "WS_WorldBoss_InspireAck",
	C61 = "LegionBossGetInfoAckData",
	h91 = "ActivityOsStarAwardAckData",
	p27 = "AS_AreaListReq",
	A22 = "DayScore",
	E90 = "WS_LegionGame_GetBlessReq",
	F19 = "WS_Chat_SendAck",
	L2 = "ActiveAwardDetail",
	w37 = "WorldSpeHCGiveUpAckData",
	t19 = "WS_ActivityAct_RedeemCodeReq",
	p91 = "DstSlot",
	H2 = "GoldCount",
	C16 = "Gain",
	a8 = "Box2State",
	U6 = "FriendsGiveTiliAckData",
	D2 = "Count",
	w4 = "PataInfo",
	A09 = "TrialFightStartAckData",
	w24 = "WorldResFightStartAckData",
	W6 = "ScrollNtfData",
	D64 = "WS_Tech_UpgradeReq",
	q1 = "FriendsBossInfo",
	d91 = "WS_WorldRes_TauntAck",
	k6 = "ArenaFightResultAckData",
	F93 = "WS_ActivityAct_CrazyUpgradeAck",
	C18 = "Page",
	h21 = "ActTiliDetail",
	o6 = "FriendsActionDetail",
	F08 = "WS_FriendsBoss_FightStartReq",
	C3 = "SelfGameCompleteInfo",
	C02 = "HeroTemplateId",
	T2 = "TiliMax",
	E84 = "WS_LegionGame_TrainStartReq",
	A65 = "PataSaoDangTurnBrandNextAckData",
	R6 = "ArenaCombatInfo",
	P2 = "HeroPutDownPartnerAckData",
	A84 = "TotalResetCount",
	E65 = "WS_LegionManage_ApplyRefuseAck",
	C20 = "LegionCount",
	l2 = "PlayerGameInfo",
	h64 = "ActivityActRebateAwardAckData",
	r9 = "CompleteCount",
	X0 = "SMsg",
	h23 = "RunCount",
	l64 = "WS_Common_FightStartReq",
	B85 = "HoldNodeList",
	C7 = "HeroFrag",
	s6 = "ChatPrivateRecord",
	p1 = "Update",
	F21 = "WS_ChatRecordNtf",
	C51 = "LegionGameSendHongbaoAckData",
	w67 = "GainMax",
	d64 = "WS_Bgz_ResetReq",
	B21 = "ActId",
	D48 = "WS_Equip_RefreshHoleAck",
	w69 = "LegionHongbao",
	G1 = "VipShopDetail",
	d54 = "WS_Bgz_FightStartReq",
	Y4 = "Title",
	x2 = "ShopIndex",
	g6 = "EquipGemRemoveAckData",
	w91 = "LegionTechId",
	E30 = "WS_Legion_PageListAck",
	t23 = "WS_ActivityOs_GetDataReq",
	p64 = "RetData",
	S0 = "FightType",
	C86 = "LogTm",
	p23 = "LS_LoginAck",
	t64 = "WS_ActivityGm_RechargeDailySingleAck",
	w18 = "WorldGetInfoAckData",
	F15 = "WS_FriendsBoss_GetBossInfoAck",
	F50 = "WS_Mail_GetAllAwardReq",
	e4 = "HeroUpgradeSkillAckData",
	p2 = "Del",
	B15 = "ShowStart",
	w85 = "LegionBless",
	X8 = "RankCommAckData",
	F87 = "WS_ActivityAct_DailySignAck",
	l48 = "WS_Common_GetGameEnvAck",
	d85 = "WS_WorldRes_ClearCDAck",
	f6 = "HeroBaseInfo",
	B87 = "HorseCarList",
	w20 = "SpecialNode",
	A49 = "PataBuffDetail",
	A53 = "Score",
	w75 = "LimitLvl",
	d48 = "WS_Pata_SaoDangBuyBuffNextReq",
	l85 = "WS_Friends_ApplyRefuseAllReq",
	E53 = "WS_Legion_DonateReq",
	C14 = "LeftCount",
	h48 = "ActivityActTiliAddedAckData",
	h85 = "LoginAwardList",
	A25 = "IndexList",
	B00 = "DailyActive",
	w61 = "MaxDonate",
	w59 = "WorldBossGetAwardAckData",
	E80 = "WS_LegionGame_GetDinnerLogReq",
	w70 = "FightMax",
	o8 = "FriendsDeleteAckData",
	p85 = "WS_Hero_UpgradeAck",
	D17 = "WS_HeroSoul_ExchangeReq",
	X2 = "FontPos",
	w51 = "WorldBossStartFightAckData",
	C38 = "LegionGameRollingOpenAckData",
	B18 = "ActEnd",
	D52 = "WS_Equip_GemRemoveReq",
	L1 = "Active",
	W7 = "BarrageSendAckData",
	D1 = "Id",
	m3 = "CommonBuyHornAckData",
	w86 = "BossInfoList",
	D81 = "WS_MainTask_GetDataAck",
	m6 = "CommonFightStartAckData",
	I9 = "Satisfy",
	C55 = "LegionBossStartFightAckData",
	E16 = "WS_WorldBoss_StartFightAck",
	S6 = "SyncDataGameInfoAckData",
	E9 = "PlayerTipsInfo",
	t15 = "WS_ActivityAct_BeInviteAck",
	A16 = "FightLayerInfo",
	Z2 = "ShopInfo",
	Q9 = "DailyTaskGetDataAckData",
	l22 = "WS_LegionWar_ApplyAck",
	J5 = "PartnerList",
	l17 = "WS_LegionWar_DailyFightResultAck",
	M9 = "BattleHeroInfo",
	d0 = "SlotType",
	N5 = "Status",
	h17 = "StartHour",
	Y9 = "MailDetail",
	h99 = "DoubleDrop",
	B54 = "GmRechargeDailySum",
	d17 = "WS_Arena_FightResultAck",
	w14 = "WorldGodDomainNode",
	F11 = "WS_FriendsBoss_FightResultAck",
	F54 = "WS_Mail_DeleteAck",
	t0 = "GoodsId",
	d52 = "WS_Pata_StartSaoDangReq",
	p99 = "WS_Hero_FastUpgradeEquipAck",
	Z5 = "ShopGetShopItemsAckData",
	C08 = "LeftTili",
	F83 = "WS_Dolls_GetInfoAck",
	l99 = "WS_Friends_GiveTiliReq",
	d81 = "WS_WorldRes_GainAck",
	w32 = "WorldSpeGetInfoAckData",
	B83 = "NodeList",
	U4 = "FriendsFightStartAckData",
	R5 = "ArenaBaseInfo",
	A57 = "PataGetAwardAckData",
	e9 = "HeroSoulBuyAckData",
	D68 = "WS_Tech_GetDataReq",
	l81 = "WS_Friends_ApplyPassReq",
	E57 = "WS_LegionManage_JoinSetReq",
	q9 = "StartTm",
	C9 = "DataChange",
	j5 = "FateId",
	w16 = "LogData",
	m9 = "FriendsApplyList",
	O2 = "LinkType",
	n5 = "SLucky",
	d98 = "WS_WorldSpe_OpenReq",
	y9 = "AttrValue",
	B32 = "LeftScore",
	p81 = "WS_HeroFrag_ExchangeSoulReq",
	D13 = "WS_HeroSoul_BuyReq",
	u9 = "MaxRound",
	w55 = "SelfHurtHp",
	f5 = "TechDetail",
	z6 = "DollsInfo",
	S1 = "ChangeRank",
	l42 = "WS_LegionWar_GetFightNodeAck",
	z5 = "PutCoinTm",
	l76 = "WS_SyncData_HeroListAck",
	o1 = "GiveTili",
	w82 = "Rolling",
	p34 = "WSIP",
	B42 = "DiamondCost",
	k1 = "MaxCombatCount",
	d16 = "WS_Arena_FightResultReq",
	E12 = "WS_WorldSpe_FaceEndAck",
	U7 = "FriendsGiveTiliAllAckData",
	g1 = "EquipComposeAckData",
	D40 = "WS_Equip_CuilianAck",
	v5 = "BestHeroRankInfo",
	w08 = "Select",
	c1 = "SenderLevel",
	D03 = "WS_Hero_XilianReq",
	B95 = "NpcLevel",
	l13 = "WS_LegionWar_DailyAwardAck",
	h56 = "ActivityActFirstRechargeAckData",
	p48 = "AS_ClientAddressReq",
	A88 = "BgzLineDetail",
	h13 = "Day",
	l56 = "WS_Common_DiamondExchangeReq",
	A01 = "DollsGetInfoAckData",
	A41 = "PataSaoDangAwardLayerDetail",
	d13 = "WS_Arena_GetDataAck",
	w10 = "BribeCount",
	B72 = "ActivityGmLimitTimeShopAckData",
	E41 = "WS_Legion_QuitReq",
	i4 = "UpgradeState",
	s1 = "FriendsBossGetBossInfoAckData",
	W2 = "Interval",
	D89 = "WS_DailyTask_AwardAck",
	C04 = "LegionRolling",
	a9 = "Box3State",
	l40 = "WS_LegionWar_GetDailyNodeAck",
	q7 = "BossTid",
	D79 = "WS_Formation_SaveAck",
	t4 = "Diamond",
	r0 = "AdditionType",
	r5 = "ActiveCount",
	t13 = "WS_ActivityAct_LuckyDiamondLogAck",
	p56 = "AS_AccountCheckReq",
	d40 = "WS_Pata_SaoDangNextAck",
	F05 = "WS_Friends_GetTiliAllReq",
	p13 = "ReqMsgId",
	t56 = "WS_ActivityGm_FundAwardAck",
	B50 = "DayList",
	A78 = "BarMoneyPrice",
	w2 = "LegionInfo",
	M3 = "EnemyBaseInfo",
	N2 = "SoulList",
	E78 = "WS_LegionGame_GetDinnerReq",
	E88 = "WS_LegionGame_BuyBlessReq",
	g9 = "BuildingGetDataAckData",
	p40 = "AS_NoticeListAck",
	c9 = "ChatLegionCD",
	h79 = "OsLevelAward",
	C43 = "LegionGameGetDinnerAckData",
	t40 = "WS_ActivityOs_RechargeAwardAck",
	F5 = "NextTotalExp",
	l79 = "WS_Friends_ApplyReq",
	D86 = "WS_DailyTask_CompleteReq",
	h40 = "Invite",
	d76 = "WS_WorldRes_FightStartReq",
	X1 = "FontColor",
	C54 = "LegionGameGetHongbaoAckData",
	A06 = "TrialLevelDetail",
	B11 = "ConsumSum",
	d79 = "WS_WorldRes_FightResultAck",
	B52 = "GmRechargeDailyDetail",
	B10 = "RechargeSum",
	B08 = "RechargeDailySingle",
	d59 = "WS_Bgz_GetAwardAck",
	w27 = "WorldResRefreshAckData",
	n2 = "GodSkillSlot",
	t6 = "FollowDiamond",
	w04 = "TeamList",
	D07 = "WS_Hero_CastReq",
	j4 = "EquipType",
	T0 = "FriendsList",
	H8 = "ExchangeInfo",
	A89 = "BgzLayerDetail",
	B03 = "LimitTimeShop",
	w9 = "SelfGameInfo",
	E45 = "WS_Legion_GetMembersReq",
	D54 = "WS_Equip_UpStarReq",
	U0 = "SearchList",
	A80 = "BarDrawAckData",
	P8 = "BagOpenBoxAckData",
	P6 = "BagGemComposeAckData",
	h49 = "ActivityActCrazyUpgradeAckData",
	j0 = "SkillPoint",
	O7 = "UpLevel",
	w88 = "LeaderId",
	A1 = "Msg",
	w58 = "WorldBossGetInfoAckData",
	A45 = "Times",
	u5 = "HireList",
	d44 = "WS_Pata_GetScoreAwardReq",
	h16 = "ActDailySignAward",
	N0 = "Position",
	l07 = "WS_LegionBoss_GetInfoAck",
	h44 = "ActInvite",
	M2 = "SelfFormation",
	J0 = "MAttr",
	h07 = "SignCount",
	h37 = "InviteCode",
	F0 = "ForeverCard",
	F01 = "WS_Friends_GiveTiliAllReq",
	d07 = "WS_Trial_FightResultAck",
	e2 = "HeroSwapEquipAckData",
	M5 = "BattleInfo",
	h89 = "OsRechargeAward",
	B46 = "FundCount",
	t44 = "WS_ActivityGm_DailyActiveAck",
	h82 = "OsFVAward",
	t8 = "BuyState",
	C39 = "LegionGameRollingContinueAckData",
	l14 = "WS_LegionWar_DailyFightStartReq",
	D83 = "WS_MainTask_AwardAck",
	Z0 = "MaxFlushCount",
	y1 = "BattleHeroBaseInfo",
	l44 = "WS_LegionWar_GetDataAck",
	D8 = "Value",
	V0 = "EndTm",
	t07 = "WS_ActivityAct_FirstRechargeAck",
	p44 = "RoleList",
	B73 = "ActivityGmFundBuyAckData",
	a4 = "hasThumb",
	p07 = "DefendFormation",
	C47 = "LegionGameTrainCompleteAckData",
	F73 = "BoxIndex",
	n0 = "Power",
	J9 = "GodId",
	B38 = "GmLimitTimeShop",
	A67 = "PataGetInfoAckData",
	y4 = "HeroSoulHallList",
	D97 = "WS_GameLevel_StarAwardAck",
	C92 = "LegionWarDailyFightStartAckData",
	d6 = "Level",
	f0 = "UpgradeStartTm",
	A12 = "TrialSaoDangAckData",
	C72 = "NodeState",
	E37 = "WS_Legion_JoinQuickReq",
	q4 = "RoleVipLevel",
	E50 = "WS_Legion_GetLogAck",
	B19 = "GmBaseInfo",
	A37 = "ImmBuffDetail",
	D30 = "WS_Hero_ConfirmResetAck",
	a3 = "ThumbCnt",
	y0 = "Boss",
	F2 = "FirstBuy",
	z0 = "TreasureRecordDetail",
	d77 = "WS_WorldRes_FightStartAck",
	T3 = "DelCount",
	v0 = "PlayerRankInfo",
	D36 = "WS_Bag_OpenBoxAck",
	w39 = "WorldSpeFaceStartAckData",
	A68 = "PataStartSaoDangAckData",
	D71 = "WS_God_UpgradeAck",
	l03 = "WS_LegionBoss_FightResultAck",
	E68 = "WS_LegionGame_RollingOpenReq",
	h03 = "LuckyDiamond",
	d03 = "WS_Team_ResetHireAck",
	A70 = "BarType",
	E70 = "WS_LegionGame_RollingContinueReq",
	C35 = "LegionManageOfficeSetAckData",
	D69 = "WS_Tech_GetDataAck",
	l36 = "WS_LegionWar_LogAck",
	h71 = "LoginAward",
	h36 = "ActLuckyDiamondRecord",
	l71 = "WS_SyncData_UpgradeInfoReq",
	t03 = "WS_ActivityAct_VipCardAwardAck",
	B77 = "ActivityGmRechargeDailySumAckData",
	d36 = "WS_Pata_TurnBrandAck",
	w72 = "IconId",
	F77 = "WS_Treasure_GetInfoAck",
	d71 = "WS_World_UnlockAck",
	B34 = "ScoreList",
	h69 = "FVAward",
	l69 = "WS_SyncData_GameInfoReq",
	E33 = "WS_Legion_CreateReq",
	t36 = "WS_ActivityOs_LoginAwardAck",
	p71 = "WS_Player_BaseFormationAck",
	G7 = "FirstBuyInfo",
	A33 = "PataAwardLayerInfo",
	p36 = "ServerStatus",
	t71 = "WS_ActivityGm_ConsumDailySumReq",
	d69 = "WS_World_GetInfoAck",
	L3 = "ForceId",
	H3 = "FoodCount",
	S7 = "SyncDataUpgradeInfoAckData",
	D32 = "WS_Bag_GemComposeAck",
	w35 = "WorldSpeHCFightStartAckData",
	p69 = "WS_Login_OutAck",
	D75 = "WS_God_UpgradeSkillAck",
	k7 = "RecordList",
	o7 = "FriendsApplyPassAckData",
	X3 = "BarrageDetail",
	c7 = "ChatDetail",
	E95 = "WS_LegionGame_SendHongbaoAck",
	A74 = "IsFreeFirst",
	g7 = "Result",
	A95 = "BgzGetInfoAckData",
	E74 = "WS_LegionGame_DinnerOpenReq",
	D28 = "WS_Hero_CalcResetAck",
	l3 = "Exp",
	h75 = "PataLevel",
	h3 = "Exchange",
	l75 = "WS_SyncData_HeroListReq",
	s7 = "ChatRecordNtfData",
	d32 = "WS_Pata_NextLayerAck",
	w7 = "TreasureInfo",
	d75 = "WS_WorldRes_GetInfoAck",
	B30 = "SingleCost",
	D59 = "WS_Building_UpgradeAck",
	A29 = "PataSaoDangInfo",
	x3 = "ItemType",
	l28 = "WS_LegionWar_PlayerFightStartAck",
	t3 = "CCY",
	h28 = "SlotList",
	F26 = "WS_Barrage_SendAck",
	p3 = "HeroChange",
	d28 = "BrandIndex",
	E58 = "WS_LegionManage_JoinSetAck",
	B26 = "CostDiamond",
	F63 = "WS_HeroComment_AddCommentAck",
	F96 = "WS_ActivityAct_WishTabRunReq",
	l59 = "WS_Common_BuyHornAck",
	d94 = "WS_WorldTask_GainReq",
	w31 = "WorldTaskGainAckData",
	A58 = "PataNextLayerAckData",
	A60 = "PataTurnBrandAckData",
	t28 = "WS_ActivityOs_StarAwardAck",
	E60 = "WS_LegionManage_OfficeSetReq",
	C27 = "LegionClearJoinCDAckData",
	p28 = "DefaultSid",
	h59 = "ActivityActLuckyDiamondAckData",
	h94 = "ActivityOsArenaAwardAckData",
	E91 = "WS_LegionGame_GetBlessAck",
	A91 = "BgzFightStartAckData",
	p94 = "SrcHero",
	D24 = "DessertTemplateId",
	D61 = "WS_Building_ImmCompleteAck",
	t59 = "WS_ActivityGm_RechargeDailyReq",
	w62 = "Welfare",
	w97 = "Target",
	D90 = "WS_GameLevel_FightStartReq",
	C66 = "FightStartTm",
	E25 = "WS_WorldBoss_GetInfoReq",
	h61 = "ActivityActBeInviteAckData",
	J6 = "PartnerAttr",
	l24 = "WS_LegionWar_BuildFightStartAck",
	l61 = "WS_Common_BattleRecordAck",
	N6 = "HeroAddAttr",
	h24 = "RunMax",
	F22 = "WS_ScrollNtf",
	B6 = "DailyTask",
	d24 = "WS_Pata_FightStartReq",
	d61 = "WS_Bgz_GetScoreAwardAck",
	B22 = "GmDailyActive",
	F6 = "State",
	C19 = "PageSize",
	Z6 = "ShopRefreshAckData",
	F92 = "WS_ActivityAct_CrazyUpgradeReq",
	K2 = "GemShape",
	p61 = "AS_AccountActivateAck",
	A64 = "PataGetScoreAwardAckData",
	G2 = "LeftDay",
	t24 = "WS_ActivityOs_GetDataAck",
	t61 = "WS_ActivityGm_RechargeDailySumReq",
	E64 = "WS_LegionManage_ApplyRefuseReq",
	F18 = "WS_Chat_SendReq",
	p24 = "Version",
	j6 = "FateEquipDetail",
	n6 = "CLevel",
	F84 = "WS_Bar_DrawReq",
	b6 = "Bgz",
	D20 = "WS_Hero_PutOnPartnerReq",
	D65 = "WS_Tech_UpgradeAck",
	B84 = "ViewNodeList",
	S2 = "RecordTm",
	w66 = "SendCount",
	o2 = "GetTili",
	w93 = "MemberBaseInfo",
	k2 = "ResetCount",
	r6 = "TaskList",
	E21 = "WS_WorldBoss_InspireReq",
	w19 = "NodeType",
	c2 = "SenderVipLevel",
	A21 = "TotalScore",
	A48 = "CostItem",
	l65 = "WS_Common_FightStartAck",
	E48 = "WS_Legion_GetApplyAck",
	A50 = "AwardType",
	w23 = "WorldResGetInfoAckData",
	d20 = "WS_Arena_ResetReq",
	d65 = "WS_Bgz_ResetAck",
	s2 = "ChatSendAckData",
	C15 = "LegionHongbaoDetail",
	l51 = "WS_Common_SetRoleNameReq",
	D49 = "GemTid",
	E87 = "WS_LegionGame_TrainCompleteAck",
	t20 = "WS_ActivityAct_RedeemCodeAck",
	t65 = "WS_ActivityGm_RechargeSingleReq",
	d51 = "WS_Pata_GetInfoAck",
	F14 = "WS_FriendsBoss_GetBossInfoReq",
	p20 = "AccountId",
	B14 = "ActivityGmInfo",
	t08 = "WS_ActivityAct_VipSignReq",
	E99 = "WS_LegionGame_GetHongbaoAck",
	d86 = "WS_WorldRes_SettleReq",
	A99 = "CrazyUpgrade",
	C52 = "HongbaoDetail",
	B80 = "ActivityGmRechargeSumAckData",
	l49 = "WS_Common_SetFirstReq",
	E17 = "WS_WorldBoss_FightResultReq",
	h51 = "ActivityActWishTabRunAckData",
	h86 = "OsLoginAward",
	D55 = "WS_Equip_UpStarAck",
	d49 = "WS_Pata_SaoDangBuyBuffNextAck",
	p86 = "WS_Hero_UpgradeQualityReq",
	w15 = "LogType",
	C81 = "BuildId",
	D16 = "DesHeroSoulId",
	H9 = "BuildingId",
	E5 = "BestRank",
	T9 = "Friendly",
	D82 = "WS_MainTask_AwardReq",
	I5 = "HeroDetail",
	P9 = "EquipUpgradeAckData",
	A54 = "PataScoreAwardDetail",
	C11 = "Cost",
	X9 = "RankInfo",
	U5 = "FriendsFightResultAckData",
	d55 = "WS_Bgz_FightStartAck",
	d9 = "FV",
	F57 = "WS_Shop_RefreshReq",
	E83 = "WS_LegionGame_WelfareAck",
	h55 = "ActivityActTwoCardAwardAckData",
	J1 = "HeroWashInfo",
	A83 = "CurLevel",
	D08 = "WS_Hero_CastAck",
	F1 = "TwoCard",
	Q5 = "TechGetDataAckData",
	h9 = "HeroFragList",
	B57 = "GmRechargeDailySingleDetail",
	e5 = "HeroXilianAckData",
	t55 = "WS_ActivityGm_FundAwardReq",
	t9 = "IsHot",
	d82 = "WS_WorldRes_RefreshReq",
	i5 = "GodUpgradeSkillAckData",
	h08 = "SignMax",
	p9 = "TimeZone",
	l55 = "ExchangeType",
	V1 = "Killed",
	E13 = "WS_WorldSpe_AwardBoxReq",
	t16 = "WS_ActivityAct_InviteAwardReq",
	p55 = "AS_ClientAddressAck",
	C56 = "LeftHp",
	A13 = "ScoreAwardInfo",
	p16 = "ErrorCodeAck",
	l08 = "WS_LegionBoss_BuyBuffReq",
	n1 = "Bless",
	y5 = "HallId",
	j1 = "EEquipType",
	p82 = "WS_HeroFrag_ExchangeSoulAck",
	m5 = "CommonHeartBeatAckData",
	d08 = "WS_Trial_GetInfoReq",
	f1 = "UpgradeEndTm",
	q5 = "RoleHeadIcon",
	p08 = "LegionWarGetDailyNodeAckData",
	b1 = "Tili",
	A40 = "BrandList",
	E40 = "WS_Legion_ClearJoinCDAck",
	z1 = "TreasureStartAckData",
	v1 = "RankValue",
	r1 = "GemAdditionDetail",
	A79 = "BarDetail",
	D04 = "WS_Hero_XilianAck",
	w56 = "SelfRank",
	E79 = "WS_LegionGame_GetDinnerAck",
	l12 = "WS_LegionWar_DailyAwardReq",
	A05 = "MaxStar",
	h12 = "ActDailySign",
	d12 = "WS_Arena_GetDataReq",
	C42 = "LegionGameDinnerGainAckData",
	E05 = "WS_WorldSpe_HCGiveUpAck",
	D78 = "WS_Formation_SaveReq",
	F88 = "WS_ActivityAct_TiliReq",
	h41 = "ActInviteAward",
	B06 = "RechargeDaily",
	l04 = "WS_LegionBoss_GetHurtRankReq",
	l41 = "WS_LegionWar_GetFightNodeReq",
	B43 = "IncomeList",
	p12 = "LegionWarBuildDefendInfoAckData",
	d04 = "WS_Trial_FightStartReq",
	d41 = "WS_Pata_SaoDangBuyBuffReq",
	F06 = "WS_Friends_GetTiliAllAck",
	p04 = "LegionWarLogAckData",
	G8 = "VipSignInfo",
	h78 = "LeftTm",
	C89 = "LegionWarReportDetail",
	l78 = "WS_Friends_GetDataAck",
	h04 = "InviteAward",
	p41 = "SubTitle",
	O8 = "HeroUpgradeAckData",
	t04 = "WS_ActivityAct_TwoCardAwardReq",
	t41 = "WS_ActivityGm_GetDataReq",
	E44 = "WS_Legion_GetDataAck",
	d78 = "WS_WorldRes_FightResultReq",
	W8 = "BarrageList",
	D00 = "ToLevel",
	S8 = "SyncDataHeroListAckData",
	p78 = "FragList",
	w42 = "BossId",
	D4 = "AwardList",
	X4 = "RankList",
	E01 = "WS_WorldSpe_HCFightStartAck",
	C46 = "LegionGameTrainStartAckData",
	A0 = "Header",
	k8 = "ArenaRecordListAckData",
	D39 = "WS_Equip_CuilianReq",
	h00 = "LoginVip",
	Y0 = "VipVipGiftBuyAckData",
	d00 = "WS_GameLevel_GetDataReq",
	l4 = "AvatarId",
	F02 = "WS_Friends_GiveTiliAllAck",
	B47 = "WelfareList",
	Q0 = "BuildingUpgradeAckData",
	B02 = "LimitTimeHero",
	F47 = "WS_Mail_ReadAck",
	C73 = "HpMax",
	E38 = "WS_Legion_JoinQuickAck",
	w07 = "WorldHorseCarDetail",
	A38 = "TurnBrandInfo",
	t00 = "WS_ActivityAct_OnlineAwardReq",
	e0 = "HeroUpgradeStarAckData",
	l39 = "WS_LegionWar_GetDailyNodeReq",
	p00 = "LegionWarPlayerFightStartAckData",
	a0 = "HeroCommentThumbAckData",
	h39 = "BeInvite",
	C03 = "LevelState",
	F37 = "RankType",
	t45 = "WS_ActivityGm_ItemExchangeReq",
	d39 = "WS_Pata_SaoDangNextReq",
	B37 = "GoodsList",
	F72 = "WS_Treasure_FastStartAck",
	u0 = "ForceDetail",
	q0 = "BossList",
	A71 = "FreeCount",
	w46 = "HurtHp",
	m0 = "CommonSetRoleNameAckData",
	F68 = "WS_HeroComment_PullCommentAck",
	C36 = "LegionManageApplyPassAckData",
	p39 = "NoticeList",
	B68 = "ActivityGmDailyActiveAckData",
	D35 = "WS_Bag_OpenBoxReq",
	D70 = "WS_God_UpgradeReq",
	w73 = "MemberCount",
	w03 = "DailyCount",
	C69 = "DailyCombatNum",
	C77 = "BuildList",
	E34 = "WS_Legion_CreateAck",
	A34 = "PataPlayerBaseInfo",
	h70 = "ArenaAward",
	J7 = "Energy",
	l35 = "WS_LegionWar_LogReq",
	l70 = "WS_SyncData_GameInfoAck",
	N7 = "SoulDetail",
	h35 = "ActLuckyDiamond",
	w36 = "WorldSpeHCFightResultAckData",
	F33 = "WS_Vip_VipGiftBuyReq",
	B7 = "TrialInfo",
	d35 = "WS_Pata_TurnBrandReq",
	d70 = "WS_World_UnlockReq",
	B33 = "FreeTm",
	F7 = "ShowDiamond",
	O3 = "LinkDetail",
	Z7 = "ShopBuyAckData",
	K3 = "GemSlotDetail",
	A75 = "IsMoneyFirst",
	G3 = "EmdTm",
	R7 = "PlayerList",
	t35 = "WS_ActivityOs_LoginAwardReq",
	t70 = "WS_ActivityGm_ConsumSumAck",
	V7 = "FriendsBossFightStartAckData",
	p35 = "WSPort",
	j7 = "Index",
	n7 = "CExp",
	W3 = "SysChat",
	F95 = "WS_ActivityAct_LoginVipAck",
	b7 = "Legion",
	D31 = "WS_Bag_GemComposeReq",
	D74 = "WS_God_UpgradeSkillReq",
	E28 = "WS_WorldBoss_GetAwardAck",
	f7 = "HeroSubInfo",
	o3 = "ActionType",
	A28 = "PataBuffLayerInfo",
	z7 = "Item",
	k3 = "ArenaPlayerInfo",
	g3 = "EquipOpenHoleAckData",
	r7 = "DailyTaskInfo",
	C94 = "LegionWarDailyFightResultAckData",
	D62 = "WS_Building_IncomeReq",
	A30 = "PlayerInfo",
	h74 = "ActivityOsInfo",
	A59 = "PataFightResultAckData",
	l31 = "WS_LegionWar_DefendSetReq",
	l74 = "WS_SyncData_FormationAck",
	E59 = "Office",
	h31 = "NextTm",
	w3 = "LegionWarBaseInfo",
	A63 = "PataSaoDangBuyBuffAckData",
	d31 = "WS_Pata_NextLayerReq",
	s3 = "ChatWorldRecord",
	E63 = "WS_LegionManage_ApplyPassAck",
	C26 = "LegionJoinQuickAckData",
	l29 = "WS_LegionWar_PlayerFightResultReq",
	l62 = "WS_Common_HeartBeatReq",
	D58 = "WS_Building_UpgradeReq",
	B60 = "GmRechargeSum",
	p74 = "WS_Player_GameInfoReq",
	A96 = "BgzResetAckData",
	t31 = "WS_ActivityOs_FVAwardReq",
	d29 = "WS_Pata_GetAwardReq",
	d62 = "WS_Bgz_GetInfoReq",
	F27 = "WS_Barrage_PullReq",
	p31 = "SortId",
	B27 = "LimitNum",
	d97 = "WS_WorldSpe_GetInfoAck",
	w94 = "LegionMemberDetail",
	p62 = "IMEI",
	h58 = "HitDiamond",
	t29 = "WS_ActivityOs_PataAwardReq",
	E24 = "WS_WorldBoss_DamageRankAck",
	l58 = "WS_Common_BuyHornReq",
	l97 = "WS_Friends_FightResultReq",
	p29 = "ServerList",
	h62 = "ActivityActInviteAwardAckData",
	h97 = "ActivityOsRechargeAwardAckData",
	D66 = "WS_Tech_FastUpgradeReq",
	d58 = "WS_Bgz_GetAwardReq",
	p97 = "WS_Hero_SwapEquipAck",
	D25 = "WS_Hero_UpgradeSatisfyReq",
	w26 = "WorldResGainAckData",
	p58 = "AS_AccountCheckAck",
	t58 = "WS_ActivityGm_FundWelfareAck",
	D93 = "WS_GameLevel_FightResultAck",
	I6 = "TemplateId",
	A6 = "ProtoMsg",
	F64 = "WS_HeroComment_ThumbReq",
	l25 = "WS_LegionWar_BuildFightResultReq",
	d66 = "WS_Bgz_GetBossInfoReq",
	E92 = "WS_LegionGame_GetBlessLogReq",
	h25 = "RefreshMax",
	h66 = "LevelAward",
	Y6 = "ExpireTm",
	d25 = "WS_Pata_FightStartAck",
	D19 = "PartnerTemplateId",
	M6 = "BattleGod",
	B64 = "GmConsumSumDetail",
	A18 = "Layer",
	B23 = "ExchangeList",
	t66 = "WS_ActivityGm_RechargeSingleAck",
	e6 = "HeroTupoAckData",
	d93 = "WS_WorldTask_StartAck",
	w90 = "LegionManagerInfo",
	h19 = "Num",
	i6 = "GameLevelFightStartAckData",
	E18 = "WS_WorldBoss_FightResultAck",
	E20 = "WS_WorldBoss_ClearCDAck",
	V2 = "KillerName",
	l93 = "WS_Friends_RecommendReq",
	p25 = "Channel",
	A20 = "TodaySaoDangLayer",
	R2 = "GameLevelResetAckData",
	h93 = "ActivityOsFVAwardAckData",
	l19 = "WS_LegionWar_DailyRepairReq",
	u6 = "ResetList",
	j2 = "Equip",
	p93 = "WS_Hero_WearEquipAck",
	D21 = "WS_Hero_PutOnPartnerAck",
	d19 = "WS_Arena_RecordListAck",
	f2 = "NextIncomeTm",
	w22 = "WorldGetLogAckData",
	A51 = "PataAwardLayerDetail",
	b2 = "BarCard",
	B48 = "GmFundWelfare",
	F48 = "WS_Mail_GetAwardReq",
	z2 = "TreasureFastStartAckData",
	E86 = "WS_LegionGame_TrainCompleteReq",
	v2 = "ExtraValue",
	A86 = "LayerList",
	r2 = "TaskType",
	l21 = "WS_LegionWar_ApplyReq",
	D15 = "ResHeroSoulId",
	C49 = "LegionGameGetBlessAckData",
	A14 = "BuffLayerInfo",
	w84 = "Train",
	d21 = "WS_Arena_ResetAck",
	C53 = "LegionGameGainHongbaoAckData",
	E14 = "WS_WorldSpe_AwardBoxAck",
	F99 = "WS_ActivityAct_WishTabRefreshAck",
	h50 = "ActivityActLoginVipAckData",
	B17 = "ActStart",
	t21 = "WS_ActivityAct_RebateAwardReq",
	B99 = "WorldViewNode",
	l50 = "WS_Common_SetFirstAck",
	C80 = "LegionWarNodeInfo",
	p21 = "Account",
	F52 = "DelList",
	d15 = "WS_Arena_FightStartAck",
	d50 = "WS_Pata_GetInfoReq",
	F17 = "LinkList",
	G9 = "Gold",
	p15 = "SyncId",
	F81 = "WS_Dolls_GrabAck",
	C98 = "DefendCount",
	B81 = "ActivityGmConsumSumAckData",
	O9 = "HeroUpgradeQualityAckData",
	A55 = "PataFightStartAckData",
	p50 = "Res",
	l87 = "WS_Friends_DeleteReq",
	E55 = "WS_LegionManage_SignatureReq",
	t50 = "WS_ActivityGm_LimitTimeScoreAck",
	W9 = "BarragePullAckData",
	w49 = "WorldBossRankDetail",
	S9 = "CommonSetFirstAckData",
	E82 = "WS_LegionGame_WelfareReq",
	L5 = "LevelType",
	p87 = "WS_Hero_UpgradeQualityAck",
	A82 = "DayFightCnt",
	w53 = "WorldBossClearCDAckData",
	D5 = "LevelAwardList",
	E08 = "Face",
	I1 = "FateEquipList"
}
