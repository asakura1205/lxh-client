require("gamebase.zbFunctions")

zbGetWayItem = class("zbGetWayItem", CCNodeExtend)
zbGetWayItem.__index = zbGetWayItem
GetWayItem_Width = 590
GetWayItem_Height = 92

function zbGetWayItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbGetWayItem)

	return arg_1_0
end

function zbGetWayItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbGetWayItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbGetWayItem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.way = nil
		arg_3_0.parentWnd = arg_3_2
		arg_3_0.passed = false
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(4), "CCControlButton")
		arg_3_0.bmForceName = tolua.cast(var_5_0:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbLevelName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbTagJing = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0:setContentSize(CCSizeMake(GetWayItem_Width, GetWayItem_Height))
	end

	var_3_0()
	var_3_1()
end

function zbGetWayItem.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.way = arg_7_1
	arg_7_0.passed = false
	arg_7_0.parentFromWnd = arg_7_2

	if arg_7_0.way.wayType == EItemGetWayType.GetWay_ForceAward then
		arg_7_0.bmForceName:setString(zbForceTable:getRecordName(arg_7_1.forceId))

		arg_7_0.passed = arg_7_0.way.forceId <= g_Self.kWarPathHandler.levelModes[arg_7_1.levelType].curForceId
		arg_7_0.passed = arg_7_0.passed and arg_7_0.way.levelId <= g_Self.kWarPathHandler.levelModes[arg_7_1.levelType].curLevelId
		arg_7_0.passed = arg_7_0.passed and g_Self.kWarPathHandler:isVisibleForce(arg_7_1.levelType, arg_7_1.forceId)

		if arg_7_1.levelType ~= ELevelType.Normal then
			local var_7_0 = 0

			if arg_7_1.levelType == ELevelType.Elite then
				local var_7_1 = zbFunctionUnlockTable:getRecord(EFuncType.EliteLevel)

				var_7_0 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, var_7_1.requireForce, zbForceSetTable:getLastLevelId(var_7_1.requireForce))
			elseif arg_7_1.levelType == ELevelType.Nightmare then
				local var_7_2 = zbFunctionUnlockTable:getRecord(EFuncType.NightmareLevel)

				var_7_0 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, var_7_2.requireForce, zbForceSetTable:getLastLevelId(var_7_2.requireForce))
			end

			arg_7_0.passed = arg_7_0.passed and var_7_0 > 0
		end

		local var_7_3 = zbForceSetTable:getRecordName(arg_7_0.way.levelId)

		if arg_7_1.levelType == ELevelType.Elite then
			arg_7_0.lbTagJing:setString(a2u("(\xBE\xABӢ)"))
			arg_7_0.lbTagJing:setColor(FONT_COLOR_PURPLE)
		elseif arg_7_1.levelType == ELevelType.Nightmare then
			arg_7_0.lbTagJing:setString(a2u("(\xC9\xF1\xBB\xB0)"))
			arg_7_0.lbTagJing:setColor(FONT_COLOR_RED)
		else
			arg_7_0.lbTagJing:setString(a2u("(\xC6\xD5ͨ)"))
			arg_7_0.lbTagJing:setColor(FONT_COLOR_GREEN)
		end

		arg_7_0.lbLevelName:setVisible(true)
		arg_7_0.lbLevelName:setString(a2u(var_7_3))
		arg_7_0.layerContent:setGray(not arg_7_0.passed)
		arg_7_0.lbTagJing:setVisible(true)
	else
		arg_7_0.lbTagJing:setVisible(false)
		arg_7_0.lbLevelName:setVisible(false)

		if arg_7_0.way.wayType == EItemGetWayType.GetWay_ShopNormal then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.Shop))
			arg_7_0.bmForceName:setString(a2u("\xC6\xD5ͨ\xC9̵\xEA(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_ShopShenMi then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.Shop))
			arg_7_0.bmForceName:setString(a2u("\xC9\xF1\xC3\xD8\xC9̵\xEA(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_ShopHonor then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.Shop))
			arg_7_0.bmForceName:setString(a2u("\xBE\xBA\xBC\xBC\xC9̵\xEA(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_Pub then
			arg_7_0.layerContent:setGray(false)
			arg_7_0.bmForceName:setString(a2u("С\xBA\xDA\xCE\xDD(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_Yuanzheng then
			arg_7_0.layerContent:setGray(zbFunHelper:isLockNoTip(EFuncType.Bgz))
			arg_7_0.bmForceName:setString(a2u("\xCD\xC5\xCA\xF3\xB4\xF3\xD7\xF7ս(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_YuanzhengJiFen then
			arg_7_0.layerContent:setGray(zbFunHelper:isLockNoTip(EFuncType.Bgz))
			arg_7_0.bmForceName:setString(a2u("\xCD\xC5\xCA\xF3\xB4\xF3\xD7\xF7ս\xBB\xFD\xB7\xD6(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_Trial then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.Trial))
			arg_7_0.bmForceName:setString(a2u("\xB4\xE5\xB5\xC4\xC8ճ\xA3(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_Pata then
			arg_7_0.layerContent:setGray(zbFunHelper:isLockNoTip(EFuncType.Pata))
			arg_7_0.bmForceName:setString(a2u("\xBA\xF3ɽѰ\xB1\xA6(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_PataJiFen then
			arg_7_0.layerContent:setGray(zbFunHelper:isLockNoTip(EFuncType.Pata))
			arg_7_0.bmForceName:setString(a2u("\xBA\xF3ɽѰ\xB1\xA6\xBB\xFD\xB7\xD6(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_WorldTask then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.World))
			arg_7_0.bmForceName:setString(a2u("\xCA\xC0\xBD\xE7\xC8\xCE\xCE\xF1(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_WorldNode then
			arg_7_0.layerContent:setGray(zbFunHelper:isBuildingLockNoTip(EBuildingType.World))
			arg_7_0.bmForceName:setString(a2u("\xCA\xC0\xBD\xE7\xD7\xCAԴ\xB5\xE3(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		elseif arg_7_0.way.wayType == EItemGetWayType.GetWay_VipGift then
			arg_7_0.layerContent:setGray(false)
			arg_7_0.bmForceName:setString(a2u("VIP\xC0\xF1\xB0\xFC(\xD3м\xB8\xC2ʲ\xFA\xB3\xF6)"))
		end
	end
end

function zbGetWayItem.onTouch(arg_8_0)
	if g_Guide and g_Guide:isGuiding() then
		return
	end

	if arg_8_0.way.wayType == EItemGetWayType.GetWay_ForceAward then
		if arg_8_0.passed == false then
			g_Bubble:bubbleInfo(a2u("\xB9ؿ\xA8δ\xBF\xAA\xB7\xC5"))

			return
		end

		g_curFragLevelMode = arg_8_0.way.levelType
		g_curFragForceId = arg_8_0.way.forceId
		g_curFragLevelId = arg_8_0.way.levelId

		arg_8_0.parentWnd:hide()
		g_MainScene:showWarForce(arg_8_0.way.levelType, arg_8_0.way.forceId, EForceEnterWay.FragWay)

		if arg_8_0.parentFromWnd then
			g_MainScene.wndWarForce:setPrevWnd(arg_8_0.parentFromWnd)
		end
	else
		arg_8_0.parentWnd:hide()

		if arg_8_0.way.wayType == EItemGetWayType.GetWay_ShopNormal then
			if zbFunHelper:isLockAndTip(EFuncType.Shop) then
				return
			end

			g_MainScene:showShopWnd(EShopTab.Normal)

			if arg_8_0.parentFromWnd then
				g_MainScene.wndShop:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_ShopShenMi then
			if zbFunHelper:isLockAndTip(EFuncType.Shop) then
				return
			end

			g_MainScene:showShopWnd(EShopTab.Mystery)

			if arg_8_0.parentFromWnd then
				g_MainScene.wndShop:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_ShopHonor then
			if zbFunHelper:isLockAndTip(EFuncType.Shop) then
				return
			end

			g_MainScene:showShopWnd(EShopTab.Arena)

			if arg_8_0.parentFromWnd then
				g_MainScene.wndShop:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_WorldNode or arg_8_0.way.wayType == EItemGetWayType.GetWay_WorldTask then
			if zbFunHelper:isLockAndTip(EFuncType.World) then
				return
			end

			g_MainScene:showWorld()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndWorld:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_Trial then
			if zbFunHelper:isLockAndTip(EFuncType.Trial) then
				return
			end

			g_Self.kHeroTrialHandler:openHeroTrial()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndHeroTrial:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_Pata or arg_8_0.way.wayType == EItemGetWayType.GetWay_PataJiFen then
			if zbFunHelper:isLockAndTip(EFuncType.Pata) then
				return
			end

			g_Self.kPataHandler:openPata()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndPata:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_Yuanzheng or arg_8_0.way.wayType == EItemGetWayType.GetWay_YuanzhengJiFen then
			if zbFunHelper:isLockAndTip(EFuncType.Bgz) then
				return
			end

			g_Self.kYuanzhengHandler:openYuanzheng()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndYuanzheng:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_Pub then
			g_MainScene:showPubWnd()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndPub:setPrevWnd(arg_8_0.parentFromWnd)
			end
		elseif arg_8_0.way.wayType == EItemGetWayType.GetWay_VipGift then
			g_MainScene:showVipTequan()

			if arg_8_0.parentFromWnd then
				g_MainScene.wndPub:setPrevWnd(arg_8_0.parentFromWnd)
			end
		end
	end
end
