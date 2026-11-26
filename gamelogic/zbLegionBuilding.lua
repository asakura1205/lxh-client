local var_0_0 = class("zbLegionBuilding")

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createLegionBuild(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.techId = 0
		arg_3_0.openLv = 0
		arg_3_0.bopen = false
	end

	local function var_3_1()
		arg_3_0.btnFunction = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.lblopen = tolua.cast(arg_3_1:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lblopen:setVisible(false)
		arg_3_0.btnFunction:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFunction:setSwallowsTouches(false)
		arg_3_0.btnFunction:addHandleOfControlEvent(function()
			arg_3_0:onFunction()
		end, CCControlEventTouchUpInside)

		local function var_5_0(arg_7_0)
			local var_7_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_7_0:setPosition(-105, 5)
			var_7_0:setVisible(false)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		arg_3_0.notifyTag = var_5_0(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	arg_8_0.techId = zbLegionHelp:getBuildingTechId(arg_8_0.index)

	local var_8_0 = zbLegionTechTable:getRecord(arg_8_0.techId)

	if var_8_0 then
		if arg_8_0.techId == ELegionTechType.LegionBattle then
			if g_Self.kLegionHandler.legionWarBaseInfo then
				if g_Self.kLegionHandler.legionWarBaseInfo.State == ELegionWarState.Unopen then
					arg_8_0.lblopen:setVisible(true)

					arg_8_0.bopen = false

					arg_8_0.btnFunction:setGray(true)

					if g_Self.kLegionHandler.legionWarBaseInfo.ApplyStartTm ~= nil then
						arg_8_0.lblopen:setString(a2u(zbUtil:getDateBySecond(g_Self.kLegionHandler.legionWarBaseInfo.ApplyStartTm)) .. a2u("\xBF\xAA\xC6\xF4"))
					end
				else
					arg_8_0.lblopen:setVisible(false)

					arg_8_0.bopen = true

					arg_8_0.btnFunction:setGray(false)
				end
			else
				arg_8_0.lblopen:setVisible(true)

				arg_8_0.bopen = false

				arg_8_0.btnFunction:setGray(true)
			end
		else
			arg_8_0.openLv = var_8_0.unlock

			if g_Self.kLegionHandler.legionDetail.LegionBaseInfo.Level >= arg_8_0.openLv then
				arg_8_0.lblopen:setVisible(false)

				arg_8_0.bopen = true

				arg_8_0.btnFunction:setGray(false)
			else
				arg_8_0.lblopen:setVisible(true)

				arg_8_0.bopen = false

				arg_8_0.btnFunction:setGray(true)
				arg_8_0.lblopen:setString(arg_8_0.openLv .. a2u("\xBC\xB6\xBB\xE1\xB9ݿ\xAA\xC6\xF4"))
			end
		end
	end
end

function var_0_0.onFunction(arg_9_0)
	if arg_9_0.techId == ELegionTechType.LegionBattle and arg_9_0.bopen == false then
		if g_Self.kLegionHandler.legionWarBaseInfo then
			local var_9_0 = g_Self.kLegionHandler.legionWarBaseInfo.ApplyStartTm

			if var_9_0 ~= nil then
				g_Bubble:bubbleInfo(a2u(zbUtil:getDateBySecond(var_9_0)) .. a2u("\xBF\xAA\xC6\xF4"))
			end
		end

		return
	end

	if arg_9_0.bopen == false and arg_9_0.openLv ~= 0 then
		g_Bubble:bubbleInfo(arg_9_0.openLv .. a2u("\xBC\xB6\xBB\xE1\xB9ݿ\xAA\xC6\xF4"))

		return
	end

	if arg_9_0.techId == ELegionTechType.Legion then
		g_MainScene:showLegionMemberWnd()
	elseif arg_9_0.techId == ELegionTechType.Hongbao then
		g_MainScene:showLegionRed()
	elseif arg_9_0.techId == ELegionTechType.Treasure then
		g_MainScene:showLegionLuckyCat()
	elseif arg_9_0.techId == ELegionTechType.Training then
		g_MainScene:showLegionHeroTrain()
	elseif arg_9_0.techId == ELegionTechType.LegionWelfare then
		g_MainScene:showLegionWelfare()
	elseif arg_9_0.techId == ELegionTechType.Bless then
		g_MainScene:showLegionBless()
	elseif arg_9_0.techId == ELegionTechType.DinnerOpen then
		g_WsMsgHandler:WS_LegionGame_GetDinner_Req(true)
	elseif arg_9_0.techId == ELegionTechType.LegionDonate then
		g_MainScene:showLegionDonateWnd()
	elseif arg_9_0.techId == ELegionTechType.LegionBattle then
		g_WsMsgHandler:WS_LegionWar_GetData_Req()
		g_MainScene:showLegionWarWnd()
	elseif arg_9_0.techId == ELegionTechType.LegionBoss then
		g_MainScene:showLegionBoss()
	end
end

function var_0_0.update(arg_10_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	local var_10_0 = false

	if arg_10_0.techId == ELegionTechType.LegionWelfare then
		var_10_0 = g_Self.kLegionHandler:hasNotifyWelfare()
	elseif arg_10_0.techId == ELegionTechType.Training then
		var_10_0 = g_Self.kLegionHandler:hasNotifyTrain()
	elseif arg_10_0.techId == ELegionTechType.Treasure then
		var_10_0 = g_Self.kLegionHandler:hasNotifyRolling()
	elseif arg_10_0.techId == ELegionTechType.Hongbao then
		var_10_0 = g_Self.kLegionHandler:hasNotifyHongbao()
	elseif arg_10_0.techId == ELegionTechType.LegionBoss then
		var_10_0 = g_Self.kLegionHandler:hasBossAwardGet() or g_Self.kLegionHandler:hasBossFight()
	end

	arg_10_0.notifyTag:setVisible(var_10_0)
end
