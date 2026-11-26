require("gamelogic.zbMapNodeBase")

local var_0_0 = class("zbMapNodeGodDomain", zbMapNodeBase)

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

function createMapNodeGodDomain(arg_2_0)
	local var_2_0 = var_0_0.extend(zbMapNodeBase.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.record = arg_3_1
	end

	local var_3_1 = CCBProxy:create()
	local var_3_2 = CCBReaderLoad("ccbi/tb_worldnode.ccbi", var_3_1, true, "HelloCocosBuilderLayerOwner")
	local var_3_3 = tolua.cast(var_3_2:getChildByTag(1), "CCLayerColor")

	var_3_3:removeFromParentAndCleanup(false)

	arg_3_0.layer = var_3_3
	arg_3_0.resBg = tolua.cast(var_3_3:getChildByTag(1), "CCSprite")
	arg_3_0.hud = tolua.cast(var_3_3:getChildByTag(3), "CCNode")
	arg_3_0.hudbg = tolua.cast(arg_3_0.hud:getChildByTag(1), "CCSprite")
	arg_3_0.nodelv = tolua.cast(arg_3_0.hud:getChildByTag(2), "CCNode")

	arg_3_0.hud:setVisible(false)
	arg_3_0.nodelv:setVisible(false)

	arg_3_0.resYzl = tolua.cast(var_3_3:getChildByTag(4), "CCSprite")

	tolua.cast(var_3_3:getChildByTag(6), "CCSprite"):setVisible(false)

	arg_3_0.nodebottom = tolua.cast(var_3_3:getChildByTag(2), "CCNode")
	arg_3_0.nodeName = tolua.cast(arg_3_0.nodebottom:getChildByTag(1003), "CCLabelTTF")

	local var_3_4 = arg_3_0.nodeName:getPositionY()

	arg_3_0.nodeName:setPositionY(var_3_4 - 8)
	arg_3_0:setContentSize(CCSizeMake(100, 150))
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:addChild(var_3_3)
	var_3_0()
	arg_3_0:initBaseInfo()
end

function var_0_0.initBaseInfo(arg_5_0)
	if arg_5_0.record then
		local var_5_0 = arg_5_0.record.pixelX
		local var_5_1 = WORLD_SCENE_HEIGHT - arg_5_0.record.pixelY

		arg_5_0:setPosition(var_5_0 - arg_5_0:getContentSize().width / 2, var_5_1 - arg_5_0:getContentSize().height / 2)
		arg_5_0.nodeName:setString(arg_5_0.record.name)

		local var_5_2 = arg_5_0.record.texPath
		local var_5_3 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_5_2)

		if var_5_3 then
			arg_5_0.resBg:initWithSpriteFrame(var_5_3)
		end
	end
end

function var_0_0.setlayerVisible(arg_6_0, arg_6_1)
	arg_6_0.layer:setVisible(arg_6_1)
end

function var_0_0.creatFightEffect(arg_7_0)
	local var_7_0 = createUIAnimation()

	var_7_0:refresh("effect/spine/ui_chuzhengzhimen/ui_chuzhengzhimen.json", "effect/spine/ui_chuzhengzhimen/ui_chuzhengzhimen.atlas")
	var_7_0:setAnchorPoint(ccp(0, 0))
	var_7_0:setPosition(arg_7_0.resBg:getContentSize().width / 2, arg_7_0.resBg:getContentSize().height - 20)
	var_7_0:setZOrder(ZORDER_BOTTOM)
	var_7_0:setScale(1.08)
	var_7_0:setAnimation("animation", true)
	arg_7_0.resBg:addChild(var_7_0, 0)

	return var_7_0
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:setlayerVisible(true)
	arg_8_0.hud:setVisible(false)

	local var_8_0

	if zbUtil:isValidTable(g_Self.kLegionHandler.legionWarNodeList) == true then
		for iter_8_0, iter_8_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
			if arg_8_0.record.id == iter_8_1.NodeId then
				var_8_0 = iter_8_1
			end
		end
	end

	local var_8_1 = "world_box1.png"

	if var_8_0 then
		arg_8_0.resYzl:setVisible(g_GameData.LegionInfo.LegionId == var_8_0.Legion.LegionId and g_GameData.LegionInfo.LegionId ~= 0)

		if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) == ELegionOffice.Leader then
			var_8_1 = "world_box3.png"
		else
			for iter_8_2, iter_8_3 in pairs(var_8_0.EliteList) do
				if g_Self:getPlayerId() == iter_8_3 then
					var_8_1 = "world_box2.png"

					break
				end
			end
		end
	end

	zbUIEffect:runMoveByAction(arg_8_0.hud, 20)

	local var_8_2 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_8_1)

	if var_8_2 then
		arg_8_0.hudbg:initWithSpriteFrame(var_8_2)
	end
end

function var_0_0.onClick(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0.hud:isVisible() then
		g_WsMsgHandler:WS_LegionWar_DailyAward_Req(arg_9_0.record.id)

		return
	end

	if g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
		local var_9_0 = g_Self.kTimeHandler:getServerTime()
		local var_9_1 = g_Self.kLegionHandler.legionWarBaseInfo

		if var_9_1 == nil then
			return
		end

		if g_Self.kLegionHandler.legionWarBaseInfo and g_Self.kLegionHandler.legionWarBaseInfo.State ~= ELegionWarState.Unopen then
			if var_9_0 >= var_9_1.FightStartTm and var_9_0 < var_9_1.FightEndTm then
				if arg_9_0.effect and arg_9_0.effect:isVisible() == true then
					g_WsMsgHandler:WS_LegionWar_GetFightNode_Req(arg_9_0.record.id)
				else
					g_Bubble:bubbleInfo(a2u("\xBB\xE1\xB9\xDDս\xD5\xFD\xD4ڽ\xF8\xD0\xD0\xD6У\xACֻ\xD3оݵ\xE3\xB2\xCEս\xBB\xE1\xB9ݳ\xC9Ա\xBF\xC9\xD2Խ\xF8\xC8롣"))
				end
			else
				g_WsMsgHandler:WS_LegionWar_GetDailyNode_Req(arg_9_0.record.id)
			end
		else
			g_Bubble:bubbleInfo(a2u("\xBB\xE1\xB9\xDDս\xBB\xB9δ\xBF\xAA\xB7\xC5"))
		end
	else
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCFȼ\xD3\xC8\xEB\xBB\xE1\xB9ݣ\xAC\xB2ſ\xC9\xC7\xC0ռ\xBB\xE1\xB9ݾݵ\xE3"))
	end
end

function var_0_0.update(arg_10_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	local var_10_0 = g_Self.kLegionHandler.legionWarBaseInfo

	if var_10_0 == nil then
		return
	end

	local var_10_1 = g_Self.kTimeHandler:getServerTime()

	if var_10_1 >= var_10_0.FightStartTm and var_10_1 < var_10_0.FightEndTm then
		if arg_10_0.effect == nil then
			arg_10_0.effect = arg_10_0:creatFightEffect()
		end

		if g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
			local var_10_2 = false

			for iter_10_0, iter_10_1 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
				if arg_10_0.record.id == iter_10_1.NodeId then
					if g_GameData.LegionInfo.LegionId == iter_10_1.Legion.LegionId then
						var_10_2 = true

						break
					end

					for iter_10_2, iter_10_3 in pairs(iter_10_1.AttackLegion) do
						if g_GameData.LegionInfo.LegionId == iter_10_3 then
							var_10_2 = true

							break
						end
					end

					if var_10_2 then
						break
					end
				end
			end

			arg_10_0.effect:setVisible(var_10_2)
		else
			arg_10_0.effect:setVisible(false)
		end
	elseif arg_10_0.effect ~= nil then
		arg_10_0.effect:setVisible(false)
	end

	local var_10_3 = g_Self.kWorldHandler.worldInfo

	if var_10_3 and zbUtil:isValidTable(var_10_3.GodDomainList) then
		for iter_10_4, iter_10_5 in pairs(var_10_3.GodDomainList) do
			if iter_10_5.NodeId == arg_10_0.record.id then
				if iter_10_5.AwardState == 1 then
					arg_10_0.hud:setVisible(true)

					break
				end

				arg_10_0.hud:setVisible(false)

				break
			end
		end
	end
end
