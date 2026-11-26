require("gamelogic.zbBaseWnd")
require("gamelogic.zbWarForceLevelPanel")
require("gamelogic.zbWarForceStarItem")
require("gamelogic.zbWarForceTeam")
require("gamebase.zbUI")

zbWarForceWnd = class("zbWarForceWnd", zbBaseWnd)
zbWarForceWnd.__index = zbWarForceWnd

function zbWarForceWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWarForceWnd)

	return arg_1_0
end

function createWarForceWnd()
	local var_2_0 = zbWarForceWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbWarForceWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.enterWay = EForceEnterWay.Normal
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = zbTableViewHelper:create()

			var_6_0:loadCCBFile("ccbi/tb_warforcestar.ccbi")

			local var_6_1 = createWarForceStarItem(translateAndStrokeHelper(var_6_0:readCCBNode()), arg_6_2)

			var_6_1:setPosition(arg_6_1:getPosition())
			arg_6_0:addChild(var_6_1)
			arg_6_1:removeFromParentAndCleanup(true)
			var_6_0:releaseSelf()

			return var_6_1
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/warforce.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.layerForceName = var_5_3
		arg_3_0.spriteModeBg = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.lbForceName = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.forceStarAward1 = var_5_0(var_5_4, tolua.cast(var_5_4:getChildByTag(1), "CCNode"), 1)
		arg_3_0.forceStarAward2 = var_5_0(var_5_4, tolua.cast(var_5_4:getChildByTag(2), "CCNode"), 2)
		arg_3_0.forceStarAward3 = var_5_0(var_5_4, tolua.cast(var_5_4:getChildByTag(3), "CCNode"), 3)
		arg_3_0.lbCurForceStarDummy = tolua.cast(var_5_4:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbCurForceStar = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCurForceStarDummy, arg_3_0.lbCurForceStar)
		arg_3_0.lbCurForceStar:setScale(0.6)

		arg_3_0.nodeForce = tolua.cast(var_5_2:getChildByTag(100), "CCNode")
		arg_3_0.nodeTeamForce = tolua.cast(var_5_2:getChildByTag(99), "CCNode")
		arg_3_0.lbTip = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteLeft = tolua.cast(var_5_2:getChildByTag(21), "CCSprite")
		arg_3_0.spriteRight = tolua.cast(var_5_2:getChildByTag(22), "CCSprite")
		arg_3_0.btnLeft = tolua.cast(var_5_2:getChildByTag(23), "CCControlButton")
		arg_3_0.btnRight = tolua.cast(var_5_2:getChildByTag(24), "CCControlButton")

		arg_3_0.btnLeft:addHandleOfControlEvent(function()
			arg_3_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRight:addHandleOfControlEvent(function()
			arg_3_0:onRight()
		end, CCControlEventTouchUpInside)

		arg_3_0.pnlForce = createWarForceLevelPanel()

		arg_3_0.nodeForce:addChild(arg_3_0.pnlForce)

		local var_5_5 = zbTableViewHelper:create()

		var_5_5:loadCCBFile("ccbi/warforce_team.ccbi")

		arg_3_0.teamForce = createWarForceTeam(translateAndStrokeHelper(var_5_5:readCCBNode()), arg_3_0)

		arg_3_0.nodeTeamForce:addChild(arg_3_0.teamForce)
		var_5_5:releaseSelf()
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Tili
		}, function()
			arg_3_0:onClose()
		end)
		zbUIEffect:runFadeToAction(arg_3_0.spriteLeft)
		zbUIEffect:runFadeToAction(arg_3_0.spriteRight)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_Update_ForceDetail)
end

function zbWarForceWnd.onClose(arg_11_0)
	arg_11_0:hide()

	if arg_11_0.enterWay == EForceEnterWay.Normal then
		g_MainScene:showWarPath(arg_11_0.levelType, false)
	end
end

function zbWarForceWnd.gotoForce(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == nil then
		arg_12_0.enterWay = EForceEnterWay.Normal
	else
		arg_12_0.enterWay = arg_12_3
	end

	if g_Self.kWarPathHandler:isVisibleForce(arg_12_1, arg_12_2) == false then
		g_Bubble:bubbleInfo("ǰ\xD6\xC3\xD5½\xDAͨ\xB9غ\xF3\xBD\xE2\xCB\xF8")

		return
	end

	if arg_12_1 == ELevelType.Normal then
		local var_12_0 = zbForceTable:getRecord(arg_12_2)

		if var_12_0 ~= nil and g_Self:getLevel() < var_12_0.loginLevel then
			g_Bubble:bubbleInfo(a2u("\xBD\xC7ɫ\xB5ȼ\xB6") .. var_12_0.loginLevel .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4") .. zbForceTable:getRecordName(arg_12_2))

			return
		end
	end

	if arg_12_1 == ELevelType.Elite then
		local var_12_1 = zbForceSetTable:getLastLevelId(arg_12_2)

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, arg_12_2, var_12_1) <= 0 then
			g_Bubble:bubbleInfo(a2u("ͨ\xB9\xD8") .. zbForceTable:getRecordName(arg_12_2) .. a2u("\xC6\xD5ͨ\xB9ؿ\xA8\xBA\xF3\xB2\xC5\xC4ܿ\xAA\xC6\xF4\xB6\xD4Ӧ\xBE\xABӢ\xB9ؿ\xA8"))

			return
		end

		if g_Self.kWarPathHandler:isVisibleForce(arg_12_1, arg_12_2) == false then
			g_Bubble:bubbleInfo("ǰ\xD6\xC3\xCA\xC6\xC1\xA6\xBE\xABӢ\xB9ؿ\xA8δͨ\xB9\xD8")

			return
		end
	end

	arg_12_0.levelType = arg_12_1
	arg_12_0.forceId = arg_12_2

	local var_12_2 = string.format("image/warpath/forcedetail/fd_mode_%d.png", arg_12_0.levelType)

	arg_12_0.spriteModeBg:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_2))
	arg_12_0.lbForceName:setString(a2u("\xB5\xDA") .. zbUtil:getNumberBig(arg_12_2) .. a2u("\xD5£\xBA") .. zbForceTable:getRecordName(arg_12_2))
	arg_12_0.pnlForce:gotoForce(arg_12_0.levelType, arg_12_0.forceId, arg_12_3)
	arg_12_0:refreshDetail()
	arg_12_0:checkFirstTalk()
end

function zbWarForceWnd.checkFirstTalk(arg_13_0)
	arg_13_0.guideTalkKey = g_Login.account .. "_" .. g_Login.lastServerId .. "_level" .. arg_13_0.forceId

	if arg_13_0.levelType == ELevelType.Normal then
		local var_13_0 = tonumber(string.format("%d%.4d", arg_13_0.forceId, 1))

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, arg_13_0.forceId, var_13_0) <= 0 then
			local var_13_1 = zbGameCore:Instance():getConfigValue(arg_13_0.guideTalkKey)

			if g_Guide:isGuiding() == false and (var_13_1 == nil or var_13_1 == "") then
				local var_13_2 = tonumber(string.format("100%.2d", arg_13_0.forceId))

				g_MainScene:showGuideTalkWnd(var_13_2, function()
					arg_13_0:saveGuideTalkConfig()
				end, true)
			end
		end
	end
end

function zbWarForceWnd.saveGuideTalkConfig(arg_15_0)
	zbGameCore:Instance():setConfigValue(arg_15_0.guideTalkKey, 1)
	zbGameCore:Instance():saveConfig()
end

function zbWarForceWnd.onLeft(arg_16_0)
	local var_16_0 = arg_16_0.forceId - 1

	arg_16_0:gotoForce(arg_16_0.levelType, var_16_0, arg_16_0.enterWay)
end

function zbWarForceWnd.onRight(arg_17_0)
	local var_17_0 = arg_17_0.forceId + 1

	if g_Self.kWarPathHandler:isVisibleForce(arg_17_0.levelType, var_17_0) == false then
		if arg_17_0.levelType == ELevelType.Elite or arg_17_0.levelType == ELevelType.Nightmare then
			local var_17_1 = zbForceSetTable:getLastLevelId(var_17_0)

			if g_Self.kWarPathHandler:getLevelStar(arg_17_0.levelType - 1, var_17_0, var_17_1) <= 0 then
				if arg_17_0.levelType == ELevelType.Elite then
					g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ͨ\xB9\xD8\xCF¸\xF6\xD5½\xDA\xC6\xD5ͨģʽ"))
				elseif arg_17_0.levelType == ELevelType.Nightmare then
					g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ͨ\xB9\xD8\xCF¸\xF6\xD5½ھ\xABӢģʽ"))
				end

				return
			end
		end

		local var_17_2 = zbForceTable:getRecord(var_17_0)

		if var_17_2 ~= nil and g_Self:getLevel() < var_17_2.loginLevel then
			g_Bubble:bubbleInfo(string.format("\xBD\xC7ɫ%d\xBC\xB6\xBF\xAA\xC6\xF4\xD0\xC2\xD5½\xDA", var_17_2.loginLevel))

			return
		end

		g_Bubble:bubbleInfo("ͨ\xB9ر\xBE\xD5½ں\xF3\xB2\xC5\xC4ܽ\xF8\xC8\xEB\xD0\xC2\xD5½ڣ\xA1")

		return
	end

	arg_17_0:gotoForce(arg_17_0.levelType, var_17_0, arg_17_0.enterWay)
end

function zbWarForceWnd.updateStarPanel(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = zbForceSetTable:getNeedStarCount(arg_18_0.levelType, arg_18_0.forceId)

	arg_18_0.forceStarAward1:refresh(arg_18_0.levelType, arg_18_0.forceId, var_18_0)
	arg_18_0.forceStarAward2:refresh(arg_18_0.levelType, arg_18_0.forceId, var_18_1)
	arg_18_0.forceStarAward3:refresh(arg_18_0.levelType, arg_18_0.forceId, var_18_2)
end

function zbWarForceWnd.updateArrowVisible(arg_19_0)
	local var_19_0 = arg_19_0.forceId - 1 >= zbForceTable:getMinForceId()

	arg_19_0.spriteLeft:setVisible(var_19_0)
	arg_19_0.btnLeft:setVisible(var_19_0)

	local var_19_1 = arg_19_0.forceId + 1 <= zbForceTable:getMaxForceId()

	arg_19_0.spriteRight:setVisible(var_19_1)
	arg_19_0.btnRight:setVisible(var_19_1)
end

function zbWarForceWnd.refreshDetail(arg_20_0)
	arg_20_0.pnlForce:refreshStages(arg_20_0.enterWay)
	arg_20_0:updateStarPanel()
	arg_20_0:updateArrowVisible()

	if arg_20_0.levelType == ELevelType.Nightmare then
		arg_20_0.teamForce:refresh(arg_20_0.forceId)
		arg_20_0.teamForce:setVisible(true)
	else
		arg_20_0.teamForce:setVisible(false)
	end

	arg_20_0.lbCurForceStar:setString(string.format("%d/%d", g_Self.kWarPathHandler:getForceStarCount(arg_20_0.levelType, arg_20_0.forceId)))
end

function zbWarForceWnd.hideTagFinger(arg_21_0, arg_21_1)
	arg_21_0.pnlForce:hideTagFinger(arg_21_1)
end

function zbWarForceWnd.getTagFinger(arg_22_0, arg_22_1)
	return arg_22_0.pnlForce:getTagFinger(arg_22_1)
end
