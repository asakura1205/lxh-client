require("gamecore.errorcode")
require("gamelogic.proto")
require("gamelogic.zbNetTipConnecting")

WS_STATE_CONNECTING = 0
WS_STATE_OPEN = 1
WS_STATE_CLOSING = 2
WS_STATE_CLOSED = 3
zbWsMsgHandler = class(zbWsMsgHandler)
zbWsMsgHandler.__index = zbWsMsgHandler

require("gamelogic.msg_Login")
require("gamelogic.msg_RoleBase")
require("gamelogic.msg_Common")
require("gamelogic.msg_Chat")
require("gamelogic.msg_Hero")
require("gamelogic.msg_Equip")
require("gamelogic.msg_Shop")
require("gamelogic.msg_Task")
require("gamelogic.msg_Daily")
require("gamelogic.msg_Bag")
require("gamelogic.msg_Build")
require("gamelogic.msg_Tech")
require("gamelogic.msg_Mail")
require("gamelogic.msg_Combat")
require("gamelogic.msg_Decompose")
require("gamelogic.msg_God")
require("gamelogic.msg_Arena")
require("gamelogic.msg_Bar")
require("gamelogic.msg_Formation")
require("gamelogic.msg_Friend")
require("gamelogic.msg_Rank")
require("gamelogic.msg_Pata")
require("gamelogic.msg_HeroTrial")
require("gamelogic.msg_Bgz")
require("gamelogic.msg_Legion")
require("gamelogic.msg_LegionWar")
require("gamelogic.msg_World")
require("gamelogic.msg_Activity")
require("gamelogic.msg_Seven")
require("gamelogic.msg_GmActivity")
require("gamelogic.msg_Vip")
require("gamelogic.msg_HeroSoulHall")

function createWsMsgHandler()
	local var_1_0 = zbWsMsgHandler.new()

	var_1_0:init()

	return var_1_0
end

zbWsMsgHandler.m_wsHandlerMap = {
	[MSG_ID.ErrorCode_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.ErrorCode_Ack),
	[MSG_ID.WS_Login_Game_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Login_Game_Ack),
	[MSG_ID.WS_Login_Out_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Login_Out_Ack),
	[MSG_ID.WS_Login_GameComplete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Login_GameComplete_Ack),
	[MSG_ID.WS_Scroll_Ntf] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Scroll_Ntf),
	[MSG_ID.WS_ChatRecord_Ntf] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ChatRecord_Ntf),
	[MSG_ID.WS_Chat_Ntf] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Chat_Ntf),
	[MSG_ID.WS_Chat_Send_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Chat_Send_Ack),
	[MSG_ID.WS_Common_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_FightStart_Ack),
	[MSG_ID.WS_Common_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_FightResult_Ack),
	[MSG_ID.WS_Common_GetGameEnv_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_GetGameEnv_Ack),
	[MSG_ID.WS_Common_SetFirst_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_SetFirst_Ack),
	[MSG_ID.WS_Common_SetRoleName_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_SetRoleName_Ack),
	[MSG_ID.WS_Common_SetHeadId_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_SetHeadId_Ack),
	[MSG_ID.WS_Player_BaseFormation_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Player_BaseFormation_Ack),
	[MSG_ID.WS_Player_Formation_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Player_Formation_Ack),
	[MSG_ID.WS_Player_GameInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Player_GameInfo_Ack),
	[MSG_ID.WS_Common_DiamondExchange_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_DiamondExchange_Ack),
	[MSG_ID.WS_SyncData_Ntf] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_SyncData_Ntf),
	[MSG_ID.WS_SyncData_GameInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_SyncData_GameInfo_Ack),
	[MSG_ID.WS_SyncData_UpgradeInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_SyncData_UpgradeInfo_Ack),
	[MSG_ID.WS_Common_HeartBeat_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_HeartBeat_Ack),
	[MSG_ID.WS_SyncData_HeroList_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_SyncData_HeroList_Ack),
	[MSG_ID.WS_HeroFrag_Compose_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroFrag_Compose_Ack),
	[MSG_ID.WS_Hero_Upgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_Upgrade_Ack),
	[MSG_ID.WS_Hero_UpgradeQuality_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_UpgradeQuality_Ack),
	[MSG_ID.WS_Hero_UpgradeStar_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_UpgradeStar_Ack),
	[MSG_ID.WS_Hero_WearEquip_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_WearEquip_Ack),
	[MSG_ID.WS_Hero_SwapEquip_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_SwapEquip_Ack),
	[MSG_ID.WS_Hero_FastUpgradeEquip_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_FastUpgradeEquip_Ack),
	[MSG_ID.WS_Hero_UpgradeSkill_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_UpgradeSkill_Ack),
	[MSG_ID.WS_Hero_Xilian_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_Xilian_Ack),
	[MSG_ID.WS_Hero_Tupo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_Tupo_Ack),
	[MSG_ID.WS_Hero_Cast_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_Cast_Ack),
	[MSG_ID.WS_Hero_ExchangeFate_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_ExchangeFate_Ack),
	[MSG_ID.WS_Hero_PutOnPartner_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_PutOnPartner_Ack),
	[MSG_ID.WS_Hero_PutDownPartner_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_PutDownPartner_Ack),
	[MSG_ID.WS_HeroComment_PullComment_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroComment_PullComment_Ack),
	[MSG_ID.WS_HeroComment_Thumb_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroComment_Thumb_Ack),
	[MSG_ID.WS_HeroComment_AddComment_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroComment_AddComment_Ack),
	[MSG_ID.WS_Equip_Upgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_Upgrade_Ack),
	[MSG_ID.WS_Equip_Cuilian_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_Cuilian_Ack),
	[MSG_ID.WS_Equip_Compose_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_Compose_Ack),
	[MSG_ID.WS_Equip_OpenHole_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_OpenHole_Ack),
	[MSG_ID.WS_Equip_RefreshHole_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_RefreshHole_Ack),
	[MSG_ID.WS_Equip_GemSet_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_GemSet_Ack),
	[MSG_ID.WS_Equip_GemRemove_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_GemRemove_Ack),
	[MSG_ID.WS_Equip_UpStar_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_UpStar_Ack),
	[MSG_ID.WS_Mail_GetList_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Mail_GetList_Ack),
	[MSG_ID.WS_Mail_Read_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Mail_Read_Ack),
	[MSG_ID.WS_Mail_GetAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Mail_GetAward_Ack),
	[MSG_ID.WS_Mail_GetAllAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Mail_GetAllAward_Ack),
	[MSG_ID.WS_Mail_Delete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Mail_Delete_Ack),
	[MSG_ID.WS_Building_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Building_GetData_Ack),
	[MSG_ID.WS_Building_Upgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Building_Upgrade_Ack),
	[MSG_ID.WS_Building_ImmComplete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Building_ImmComplete_Ack),
	[MSG_ID.WS_Building_Income_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Building_Income_Ack),
	[MSG_ID.WS_SyncData_Formation_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_SyncData_Formation_Ack),
	[MSG_ID.WS_Formation_Save_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Formation_Save_Ack),
	[MSG_ID.WS_Tech_Upgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Tech_Upgrade_Ack),
	[MSG_ID.WS_Tech_FastUpgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Tech_FastUpgrade_Ack),
	[MSG_ID.WS_Tech_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Tech_GetData_Ack),
	[MSG_ID.WS_GameLevel_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_FightStart_Ack),
	[MSG_ID.WS_GameLevel_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_FightResult_Ack),
	[MSG_ID.WS_GameLevel_SaoDang_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_SaoDang_Ack),
	[MSG_ID.WS_GameLevel_Reset_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_Reset_Ack),
	[MSG_ID.WS_GameLevel_StarAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_StarAward_Ack),
	[MSG_ID.WS_Barrage_Send_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Barrage_Send_Ack),
	[MSG_ID.WS_Barrage_Pull_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Barrage_Pull_Ack),
	[MSG_ID.WS_Treasure_Start_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Treasure_Start_Ack),
	[MSG_ID.WS_Treasure_FastStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Treasure_FastStart_Ack),
	[MSG_ID.WS_Treasure_GetBoxAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Treasure_GetBoxAward_Ack),
	[MSG_ID.WS_Treasure_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Treasure_GetInfo_Ack),
	[MSG_ID.WS_GameLevel_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_GameLevel_GetData_Ack),
	[MSG_ID.WS_Bag_GemCompose_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bag_GemCompose_Ack),
	[MSG_ID.WS_Equip_Decompose_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Equip_Decompose_Ack),
	[MSG_ID.WS_HeroFrag_Decompose_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroFrag_Decompose_Ack),
	[MSG_ID.WS_Hero_CalcReset_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_CalcReset_Ack),
	[MSG_ID.WS_Hero_ConfirmReset_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Hero_ConfirmReset_Ack),
	[MSG_ID.WS_Shop_GetShopItems_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Shop_GetShopItems_Ack),
	[MSG_ID.WS_Shop_Refresh_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Shop_Refresh_Ack),
	[MSG_ID.WS_Shop_Buy_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Shop_Buy_Ack),
	[MSG_ID.WS_Common_BuyHorn_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_BuyHorn_Ack),
	[MSG_ID.WS_Bag_SaleItem_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bag_SaleItem_Ack),
	[MSG_ID.WS_Bag_OpenBox_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bag_OpenBox_Ack),
	[MSG_ID.WS_God_Change_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_God_Change_Ack),
	[MSG_ID.WS_God_Upgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_God_Upgrade_Ack),
	[MSG_ID.WS_God_UpgradeStar_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_God_UpgradeStar_Ack),
	[MSG_ID.WS_God_UpgradeSkill_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_God_UpgradeSkill_Ack),
	[MSG_ID.WS_Arena_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_GetData_Ack),
	[MSG_ID.WS_Arena_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_FightStart_Ack),
	[MSG_ID.WS_Arena_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_FightResult_Ack),
	[MSG_ID.WS_Arena_RecordList_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_RecordList_Ack),
	[MSG_ID.WS_Arena_Reset_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_Reset_Ack),
	[MSG_ID.WS_Arena_Signature_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Arena_Signature_Ack),
	[MSG_ID.WS_Common_BattleRecord_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Common_BattleRecord_Ack),
	[MSG_ID.WS_Bar_Draw_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bar_Draw_Ack),
	[MSG_ID.WS_MainTask_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_MainTask_GetData_Ack),
	[MSG_ID.WS_MainTask_Award_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_MainTask_Award_Ack),
	[MSG_ID.WS_DailyTask_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_DailyTask_GetData_Ack),
	[MSG_ID.WS_DailyTask_Complete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_DailyTask_Complete_Ack),
	[MSG_ID.WS_DailyTask_Award_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_DailyTask_Award_Ack),
	[MSG_ID.WS_Friends_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_GetData_Ack),
	[MSG_ID.WS_Friends_Recommend_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_Recommend_Ack),
	[MSG_ID.WS_Friends_Apply_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_Apply_Ack),
	[MSG_ID.WS_Friends_Search_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_Search_Ack),
	[MSG_ID.WS_Friends_ApplyPass_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_ApplyPass_Ack),
	[MSG_ID.WS_Friends_ApplyRefuse_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_ApplyRefuse_Ack),
	[MSG_ID.WS_Friends_ApplyRefuseAll_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_ApplyRefuseAll_Ack),
	[MSG_ID.WS_Friends_Delete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_Delete_Ack),
	[MSG_ID.WS_Friends_Action_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_Action_Ack),
	[MSG_ID.WS_Friends_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_FightStart_Ack),
	[MSG_ID.WS_Friends_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_FightResult_Ack),
	[MSG_ID.WS_Friends_GiveTili_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_GiveTili_Ack),
	[MSG_ID.WS_Friends_GiveTiliAll_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_GiveTiliAll_Ack),
	[MSG_ID.WS_Friends_GetTili_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_GetTili_Ack),
	[MSG_ID.WS_Friends_GetTiliAll_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Friends_GetTiliAll_Ack),
	[MSG_ID.WS_FriendsBoss_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_FriendsBoss_FightStart_Ack),
	[MSG_ID.WS_FriendsBoss_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_FriendsBoss_FightResult_Ack),
	[MSG_ID.WS_FriendsBoss_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_FriendsBoss_GetInfo_Ack),
	[MSG_ID.WS_FriendsBoss_GetBossInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_FriendsBoss_GetBossInfo_Ack),
	[MSG_ID.WS_Pata_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_GetInfo_Ack),
	[MSG_ID.WS_Pata_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_FightStart_Ack),
	[MSG_ID.WS_Pata_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_FightResult_Ack),
	[MSG_ID.WS_Pata_BuyBuff_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_BuyBuff_Ack),
	[MSG_ID.WS_Pata_GetAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_GetAward_Ack),
	[MSG_ID.WS_Pata_NextLayer_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_NextLayer_Ack),
	[MSG_ID.WS_Pata_StartSaoDang_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_StartSaoDang_Ack),
	[MSG_ID.WS_Pata_SaoDangNext_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_SaoDangNext_Ack),
	[MSG_ID.WS_Pata_SaoDangTurnBrand_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_SaoDangTurnBrand_Ack),
	[MSG_ID.WS_Pata_SaoDangTurnBrandNext_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_SaoDangTurnBrandNext_Ack),
	[MSG_ID.WS_Pata_SaoDangBuyBuff_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_SaoDangBuyBuff_Ack),
	[MSG_ID.WS_Pata_SaoDangBuyBuffNext_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_SaoDangBuyBuffNext_Ack),
	[MSG_ID.WS_Pata_GetScoreAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Pata_GetScoreAward_Ack),
	[MSG_ID.WS_Bgz_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_GetInfo_Ack),
	[MSG_ID.WS_Bgz_GetBossInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_GetBossInfo_Ack),
	[MSG_ID.WS_Bgz_GetAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_GetAward_Ack),
	[MSG_ID.WS_Bgz_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_FightStart_Ack),
	[MSG_ID.WS_Bgz_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_FightResult_Ack),
	[MSG_ID.WS_Bgz_Reset_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_Reset_Ack),
	[MSG_ID.WS_Bgz_GetScoreAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Bgz_GetScoreAward_Ack),
	[MSG_ID.WS_ActivityAct_DailySign_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_DailySign_Ack),
	[MSG_ID.WS_ActivityAct_Tili_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_Tili_Ack),
	[MSG_ID.WS_ActivityAct_TiliAdded_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_TiliAdded_Ack),
	[MSG_ID.WS_ActivityAct_CrazyUpgrade_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_CrazyUpgrade_Ack),
	[MSG_ID.WS_ActivityAct_LoginVip_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_LoginVip_Ack),
	[MSG_ID.WS_ActivityAct_WishTabRun_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_WishTabRun_Ack),
	[MSG_ID.WS_ActivityAct_WishTabRefresh_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_WishTabRefresh_Ack),
	[MSG_ID.WS_ActivityAct_RedeemCode_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_RedeemCode_Ack),
	[MSG_ID.WS_ActivityAct_OnlineAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_OnlineAward_Ack),
	[MSG_ID.WS_ActivityAct_LuckyDiamond_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_LuckyDiamond_Ack),
	[MSG_ID.WS_ActivityAct_LuckyDiamondLog_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_LuckyDiamondLog_Ack),
	[MSG_ID.WS_ActivityAct_VipCardAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_VipCardAward_Ack),
	[MSG_ID.WS_ActivityAct_TwoCardAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_TwoCardAward_Ack),
	[MSG_ID.WS_ActivityAct_FirstRecharge_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_FirstRecharge_Ack),
	[MSG_ID.WS_ActivityAct_RebateAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityAct_RebateAward_Ack),
	[MSG_ID.WS_ActivityOs_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_GetData_Ack),
	[MSG_ID.WS_ActivityOs_LevelAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_LevelAward_Ack),
	[MSG_ID.WS_ActivityOs_StarAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_StarAward_Ack),
	[MSG_ID.WS_ActivityOs_PataAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_PataAward_Ack),
	[MSG_ID.WS_ActivityOs_FVAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_FVAward_Ack),
	[MSG_ID.WS_ActivityOs_ArenaAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_ArenaAward_Ack),
	[MSG_ID.WS_ActivityOs_LoginAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_LoginAward_Ack),
	[MSG_ID.WS_ActivityOs_HalfPacks_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_HalfPacks_Ack),
	[MSG_ID.WS_ActivityOs_RechargeAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityOs_RechargeAward_Ack),
	[MSG_ID.WS_ActivityGm_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_GetData_Ack),
	[MSG_ID.WS_ActivityGm_DailyActive_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_DailyActive_Ack),
	[MSG_ID.WS_ActivityGm_ItemExchange_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_ItemExchange_Ack),
	[MSG_ID.WS_ActivityGm_LimitTimeHero_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_LimitTimeHero_Ack),
	[MSG_ID.WS_ActivityGm_LimitTimeScore_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_LimitTimeScore_Ack),
	[MSG_ID.WS_ActivityGm_LimitTimeShop_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_LimitTimeShop_Ack),
	[MSG_ID.WS_ActivityGm_FundBuy_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_FundBuy_Ack),
	[MSG_ID.WS_ActivityGm_FundAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_FundAward_Ack),
	[MSG_ID.WS_ActivityGm_FundWelfare_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_FundWelfare_Ack),
	[MSG_ID.WS_ActivityGm_RechargeDaily_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_RechargeDaily_Ack),
	[MSG_ID.WS_ActivityGm_RechargeDailySum_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_RechargeDailySum_Ack),
	[MSG_ID.WS_ActivityGm_RechargeDailySingle_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_RechargeDailySingle_Ack),
	[MSG_ID.WS_ActivityGm_RechargeSingle_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_RechargeSingle_Ack),
	[MSG_ID.WS_ActivityGm_RechargeSum_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_RechargeSum_Ack),
	[MSG_ID.WS_ActivityGm_ConsumSum_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_ConsumSum_Ack),
	[MSG_ID.WS_ActivityGm_ConsumDailySum_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_ActivityGm_ConsumDailySum_Ack),
	[MSG_ID.WS_Rank_Arena_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Rank_Arena_Ack),
	[MSG_ID.WS_Rank_Comm_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Rank_Comm_Ack),
	[MSG_ID.WS_Rank_Legion_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Rank_Legion_Ack),
	[MSG_ID.WS_Rank_Hero_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Rank_Hero_Ack),
	[MSG_ID.WS_Trial_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Trial_FightStart_Ack),
	[MSG_ID.WS_Trial_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Trial_FightResult_Ack),
	[MSG_ID.WS_Trial_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Trial_GetInfo_Ack),
	[MSG_ID.WS_Trial_SaoDang_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Trial_SaoDang_Ack),
	[MSG_ID.WS_Dolls_PutCoin_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Dolls_PutCoin_Ack),
	[MSG_ID.WS_Dolls_Grab_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Dolls_Grab_Ack),
	[MSG_ID.WS_Dolls_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Dolls_GetInfo_Ack),
	[MSG_ID.WS_Legion_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_GetData_Ack),
	[MSG_ID.WS_Legion_Search_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_Search_Ack),
	[MSG_ID.WS_Legion_PageList_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_PageList_Ack),
	[MSG_ID.WS_Legion_Create_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_Create_Ack),
	[MSG_ID.WS_Legion_Apply_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_Apply_Ack),
	[MSG_ID.WS_Legion_JoinQuick_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_JoinQuick_Ack),
	[MSG_ID.WS_Legion_ClearJoinCD_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_ClearJoinCD_Ack),
	[MSG_ID.WS_LegionManage_Signature_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_Signature_Ack),
	[MSG_ID.WS_Legion_Quit_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_Quit_Ack),
	[MSG_ID.WS_Legion_GetMembers_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_GetMembers_Ack),
	[MSG_ID.WS_Legion_GetLog_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_GetLog_Ack),
	[MSG_ID.WS_LegionManage_JoinSet_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_JoinSet_Ack),
	[MSG_ID.WS_Legion_GetApply_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_GetApply_Ack),
	[MSG_ID.WS_LegionManage_ApplyPass_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_ApplyPass_Ack),
	[MSG_ID.WS_LegionManage_ApplyRefuse_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_ApplyRefuse_Ack),
	[MSG_ID.WS_LegionManage_Kick_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_Kick_Ack),
	[MSG_ID.WS_LegionManage_OfficeSet_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionManage_OfficeSet_Ack),
	[MSG_ID.WS_Legion_GetSelfInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_GetSelfInfo_Ack),
	[MSG_ID.WS_LegionGame_RollingOpen_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_RollingOpen_Ack),
	[MSG_ID.WS_LegionGame_RollingContinue_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_RollingContinue_Ack),
	[MSG_ID.WS_LegionGame_RollingGain_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_RollingGain_Ack),
	[MSG_ID.WS_Legion_Donate_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Legion_Donate_Ack),
	[MSG_ID.WS_LegionGame_Welfare_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_Welfare_Ack),
	[MSG_ID.WS_LegionGame_TrainStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_TrainStart_Ack),
	[MSG_ID.WS_LegionGame_TrainComplete_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_TrainComplete_Ack),
	[MSG_ID.WS_LegionGame_DinnerOpen_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_DinnerOpen_Ack),
	[MSG_ID.WS_LegionGame_DinnerGain_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_DinnerGain_Ack),
	[MSG_ID.WS_LegionGame_GetDinner_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GetDinner_Ack),
	[MSG_ID.WS_LegionGame_GetDinnerLog_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GetDinnerLog_Ack),
	[MSG_ID.WS_LegionBoss_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_GetInfo_Ack),
	[MSG_ID.WS_LegionBoss_BuyBuff_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_BuyBuff_Ack),
	[MSG_ID.WS_LegionBoss_GetAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_GetAward_Ack),
	[MSG_ID.WS_LegionBoss_GetHurtRank_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_GetHurtRank_Ack),
	[MSG_ID.WS_LegionBoss_StartFight_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_StartFight_Ack),
	[MSG_ID.WS_LegionBoss_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionBoss_FightResult_Ack),
	[MSG_ID.WS_LegionGame_BuyBless_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_BuyBless_Ack),
	[MSG_ID.WS_LegionGame_GetBless_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GetBless_Ack),
	[MSG_ID.WS_LegionGame_GetBlessLog_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GetBlessLog_Ack),
	[MSG_ID.WS_LegionGame_SendHongbao_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_SendHongbao_Ack),
	[MSG_ID.WS_LegionGame_GainHongbao_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GainHongbao_Ack),
	[MSG_ID.WS_LegionGame_GetHongbao_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionGame_GetHongbao_Ack),
	[MSG_ID.WS_LegionWar_GetData_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_GetData_Ack),
	[MSG_ID.WS_LegionWar_GetDailyNode_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_GetDailyNode_Ack),
	[MSG_ID.WS_LegionWar_GetFightNode_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_GetFightNode_Ack),
	[MSG_ID.WS_LegionWar_DailyRepair_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_DailyRepair_Ack),
	[MSG_ID.WS_LegionWar_DailyFightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_DailyFightStart_Ack),
	[MSG_ID.WS_LegionWar_DailyFightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_DailyFightResult_Ack),
	[MSG_ID.WS_LegionWar_Apply_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_Apply_Ack),
	[MSG_ID.WS_LegionWar_EliteSet_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_EliteSet_Ack),
	[MSG_ID.WS_LegionWar_Log_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_Log_Ack),
	[MSG_ID.WS_LegionWar_Report_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_Report_Ack),
	[MSG_ID.WS_LegionWar_DefendSet_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_DefendSet_Ack),
	[MSG_ID.WS_LegionWar_BuildFightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_BuildFightStart_Ack),
	[MSG_ID.WS_LegionWar_BuildFightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_BuildFightResult_Ack),
	[MSG_ID.WS_LegionWar_PlayerFightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_PlayerFightStart_Ack),
	[MSG_ID.WS_LegionWar_PlayerFightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_PlayerFightResult_Ack),
	[MSG_ID.WS_LegionWar_BuildDefendInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_BuildDefendInfo_Ack),
	[MSG_ID.WS_LegionWar_DailyAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_LegionWar_DailyAward_Ack),
	[MSG_ID.WS_World_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_World_GetInfo_Ack),
	[MSG_ID.WS_World_Unlock_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_World_Unlock_Ack),
	[MSG_ID.WS_WorldRes_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_GetInfo_Ack),
	[MSG_ID.WS_WorldRes_FightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_FightStart_Ack),
	[MSG_ID.WS_WorldRes_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_FightResult_Ack),
	[MSG_ID.WS_WorldRes_Gain_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_Gain_Ack),
	[MSG_ID.WS_WorldRes_Refresh_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_Refresh_Ack),
	[MSG_ID.WS_WorldRes_ClearCD_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_ClearCD_Ack),
	[MSG_ID.WS_World_Unlock_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_World_Unlock_Ack),
	[MSG_ID.WS_WorldSpe_Open_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_Open_Ack),
	[MSG_ID.WS_WorldTask_Start_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldTask_Start_Ack),
	[MSG_ID.WS_WorldTask_Gain_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldTask_Gain_Ack),
	[MSG_ID.WS_WorldSpe_BgzBribe_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_BgzBribe_Ack),
	[MSG_ID.WS_WorldSpe_FaceStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_FaceStart_Ack),
	[MSG_ID.WS_WorldSpe_FaceEnd_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_FaceEnd_Ack),
	[MSG_ID.WS_WorldSpe_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_GetInfo_Ack),
	[MSG_ID.WS_WorldSpe_AwardBox_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_AwardBox_Ack),
	[MSG_ID.WS_WorldSpe_HCGiveUp_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_HCGiveUp_Ack),
	[MSG_ID.WS_WorldSpe_HCFightStart_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_HCFightStart_Ack),
	[MSG_ID.WS_WorldSpe_HCFightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldSpe_HCFightResult_Ack),
	[MSG_ID.WS_WorldRes_Settle_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_Settle_Ack),
	[MSG_ID.WS_World_GetLog_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_World_GetLog_Ack),
	[MSG_ID.WS_WorldRes_Change_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldRes_Change_Ack),
	[MSG_ID.WS_WorldBoss_StartFight_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_StartFight_Ack),
	[MSG_ID.WS_WorldBoss_FightResult_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_FightResult_Ack),
	[MSG_ID.WS_WorldBoss_ClearCD_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_ClearCD_Ack),
	[MSG_ID.WS_WorldBoss_Inspire_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_Inspire_Ack),
	[MSG_ID.WS_WorldBoss_DamageRank_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_DamageRank_Ack),
	[MSG_ID.WS_WorldBoss_GetInfo_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_GetInfo_Ack),
	[MSG_ID.WS_WorldBoss_GetAward_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_WorldBoss_GetAward_Ack),
	[MSG_ID.WS_Vip_CreateOrder_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Vip_CreateOrder_Ack),
	[MSG_ID.WS_Vip_SuccessOrder_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Vip_SuccessOrder_Ack),
	[MSG_ID.WS_Vip_VipGiftBuy_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_Vip_VipGiftBuy_Ack),
	[MSG_ID.WS_HeroSoul_Buy_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroSoul_Buy_Ack),
	[MSG_ID.WS_HeroSoul_Exchange_Ack] = handler(zbWsMsgHandler, zbWsMsgHandler.WS_HeroSoul_Exchange_Ack)
}

function zbWsMsgHandler.init(arg_2_0)
	arg_2_0.wsUrl = ""
	arg_2_0.wndCircle = createNetTipConnecting()
	arg_2_0.sendMsgNeedCircle = true
	arg_2_0.lastHeartReqTime = os_timenow()
	arg_2_0.heartPackCheckback = true
	arg_2_0.needLoginReq = false
	arg_2_0.isWsConnect = true
	arg_2_0.isClosed = false
	arg_2_0.lastRecvMsgId = 0

	zbWebSocketUtil:Instance():RegisterLuaOpenCallback(handler(arg_2_0, arg_2_0.wsOnOpen))
	zbWebSocketUtil:Instance():RegisterLuaCloseCallback(handler(arg_2_0, arg_2_0.wsOnClose))
	zbWebSocketUtil:Instance():RegisterLuaMessageCallback(handler(arg_2_0, arg_2_0.wsOnMessage))
	zbWebSocketUtil:Instance():RegisterLuaErrorCallback(handler(arg_2_0, arg_2_0.wsOnError))
end

function zbWsMsgHandler.free(arg_3_0)
	echo("call zbWsMsgHandler:free")
	zbWebSocketUtil:Instance():Free()
	arg_3_0.wndCircle:free()
end

function zbWsMsgHandler.wsConnect(arg_4_0)
	echo("call webSocketUtil connect wsConnect:" .. tostring(arg_4_0.wsUrl))
	zbWebSocketUtil:Instance():Free()
	zbWebSocketUtil:Instance():Init()
	zbWebSocketUtil:Instance():Connect(arg_4_0.wsUrl)
	arg_4_0.wndCircle:show()
end

function zbWsMsgHandler.wsOnOpen(arg_5_0)
	echo("websocket：" .. tostring(arg_5_0.wsUrl) .. " is Open")
	arg_5_0:hideReconnectWnd()

	arg_5_0.isWsConnect = true
	arg_5_0.lastHeartReqTime = os_timenow()
	arg_5_0.heartPackCheckback = true

	arg_5_0.wndCircle:setResponsed(true)
	arg_5_0.wndCircle:hide()

	if arg_5_0.needLoginReq then
		arg_5_0.needLoginReq = false

		g_WsMsgHandler:WS_Login_Game_Req()
	end

	arg_5_0.isClosed = false
end

function zbWsMsgHandler.wsOnClose(arg_6_0)
	echo("websocket：" .. tostring(arg_6_0.wsUrl) .. " is close")

	arg_6_0.isClosed = true
end

function zbWsMsgHandler.wsOnMessage(arg_7_0, arg_7_1)
	arg_7_0.wndCircle:setResponsed(true)
	arg_7_0.wndCircle:hide()

	arg_7_0.isWsConnect = true

	print("Websocket RecvMsg: " .. tostring(arg_7_1))

	local var_7_0 = require("cjson").decode(arg_7_1)

	if type(var_7_0) ~= "table" then
		echoInfo("faild return value")

		return
	end

	local var_7_1 = var_7_0.Header
	local var_7_2 = var_7_0.Msg

	arg_7_0:wsProcessMsg(var_7_1.MsgID, var_7_0.Msg)
end

function zbWsMsgHandler.wsOnError(arg_8_0, arg_8_1)
	echo("websocket error:" .. tostring(arg_8_1))
end

function zbWsMsgHandler.update(arg_9_0)
	arg_9_0.wndCircle:update()

	if g_GameStateMachine:getCurrStateId() ~= GameState_Scene then
		return
	end

	if arg_9_0:isCanHeart() == false then
		return
	end

	if arg_9_0:isConnected() then
		local var_9_0 = os_timenow()
		local var_9_1 = var_9_0 - arg_9_0.lastHeartReqTime

		if var_9_1 > 120 and g_MainScene:isWndVisible(g_MainScene.wndCombat) == false then
			arg_9_0:WS_Common_HeartBeat_Req()

			arg_9_0.heartPackCheckback = false
			arg_9_0.lastHeartReqTime = var_9_0
		elseif arg_9_0.heartPackCheckback == false and var_9_1 > 6 then
			-- block empty
		end
	elseif arg_9_0.isClosed then
		arg_9_0:popReconnectWnd()
	end
end

function zbWsMsgHandler.wsProcessMsg(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.lastRecvMsgId = arg_10_1

	if arg_10_0.m_wsHandlerMap[arg_10_1] ~= nil then
		arg_10_0.m_wsHandlerMap[arg_10_1](arg_10_2)
	else
		echo("Unregister msg:" .. tostring(arg_10_1) .. " msg:" .. tostring(arg_10_2))
	end
end

function zbWsMsgHandler.wsPackMsg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = PacketHeader

	var_11_0.MsgID = arg_11_2

	local var_11_1 = ProtoMsg

	var_11_1.Header = var_11_0
	var_11_1.Msg = arg_11_1

	local var_11_2 = require("cjson").encode(var_11_1)

	echo("Websocket SendMsg:" .. tostring(var_11_2))
	echo("Websocket SendMsg:" .. arg_11_2)
	zbWebSocketUtil:Instance():Send(var_11_2)

	if arg_11_0.sendMsgNeedCircle then
		arg_11_0.wndCircle:show()
	end
end

function zbWsMsgHandler.popReconnectWnd(arg_12_0)
	if g_MainScene then
		g_MainScene:showWsConnectWaitWnd()
	end
end

function zbWsMsgHandler.hideReconnectWnd(arg_13_0)
	if g_MainScene then
		g_MainScene:freeWsConnectWaitWnd()
	end
end

function zbWsMsgHandler.getState(arg_14_0)
	return zbWebSocketUtil:Instance():getReadyState()
end

function zbWsMsgHandler.isConnected(arg_15_0)
	return arg_15_0:getState() == WS_STATE_OPEN and arg_15_0.isWsConnect == true
end

function zbWsMsgHandler.isCanHeart(arg_16_0)
	if g_MainScene ~= nil then
		if g_MainScene.wndLoading ~= nil and g_MainScene.wndLoading.isShow then
			return false
		end

		if g_MainScene.wndReconnect ~= nil and g_MainScene.wndReconnect.isShow then
			return false
		end
	end

	return true
end
