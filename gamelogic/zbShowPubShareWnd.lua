require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowPubShareWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowPubShareWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

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

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/shareui_pub.ccbi", var_5_0, true, "")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onHide()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteAvatar = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteType = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.lbLocation = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.skillframe = tolua.cast(var_5_2:getChildByTag(6), "CCSprite")
		arg_3_0.spriteSkill = tolua.cast(arg_3_0.skillframe:getChildByTag(1), "CCSprite")
		arg_3_0.lbSkill = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbSkillDesc = tolua.cast(var_5_2:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lbNotice = tolua.cast(var_5_2:getChildByTag(9), "CCLabelTTF")
		arg_3_0.nodeShare = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		arg_3_0.shareName = tolua.cast(arg_3_0.nodeShare:getChildByTag(1), "CCLabelTTF")
		arg_3_0.shareArea = tolua.cast(arg_3_0.nodeShare:getChildByTag(2), "CCLabelTTF")
		arg_3_0.shareQRcode = tolua.cast(arg_3_0.nodeShare:getChildByTag(3), "CCSprite")

		arg_3_0.spriteSkill:setMaskTexture(MASK_NOMRML_TEX)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	local var_7_0 = zbHeroTable:getRecord(arg_7_1)

	if var_7_0 == nil then
		arg_7_0:onHide()

		return
	end

	local var_7_1 = zbIconHelper:getHeroCardIconPath(arg_7_1)

	arg_7_0.spriteAvatar:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
	arg_7_0.lbName:setString(var_7_0.name)
	arg_7_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_7_0.rarity .. ".png"))
	arg_7_0.lbLocation:setString(var_7_0.description0)
	arg_7_0.lbDesc:setString(var_7_0.description)

	local var_7_2 = zbIconHelper:getSkillIconPath(var_7_0.skillId1)

	arg_7_0.spriteSkill:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_2))

	local var_7_3 = zbHeroSkillTable:getRecord(var_7_0.skillId1)

	if var_7_3 ~= nil then
		arg_7_0.lbSkill:setString(var_7_3.name)
		arg_7_0.lbSkillDesc:setString(var_7_3.descBase)
	end

	arg_7_0.shareName:setString(g_GameData.BaseInfo.RoleName)

	local var_7_4 = g_Login:getCurServer()
	local var_7_5 = ""

	if var_7_4 then
		var_7_5 = var_7_4.ServerName
	end

	arg_7_0.shareArea:setString(g_Login.selectServerId .. a2u("\xC7\xF8") .. a2u(var_7_5))
	arg_7_0.shareQRcode:setVisible(zbGlobalUtil:getTargetPlatform() == "ios" or zbChannelUtil:isOfficialChannel(g_Login.channel))
end

function var_0_0.onHide(arg_8_0)
	arg_8_0:hide()

	if g_MainScene.wndPubGetHero then
		g_MainScene.wndPubGetHero:setShareUiVisible(true)
	end

	if g_MainScene.wndPub then
		g_MainScene.wndPub:setShareUiVisible(true)
	end

	if g_Broadcast then
		g_Broadcast:setBroadCastVisible(true)
	end
end
