require("gamelogic.zbMapNodeBase")

local var_0_0 = class("zbMapNodeRand", zbMapNodeBase)

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

function createMapNodeRand(arg_2_0)
	local var_2_0 = var_0_0.extend(zbMapNodeBase.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.record = arg_3_1
		arg_3_0.type = nil
		arg_3_0.shopInfo = nil
	end

	local var_3_1 = CCBProxy:create()
	local var_3_2 = CCBReaderLoad("ccbi/tb_worldrandnode.ccbi", var_3_1, true, "HelloCocosBuilderLayerOwner")
	local var_3_3 = tolua.cast(var_3_2:getChildByTag(1), "CCLayerColor")

	var_3_3:removeFromParentAndCleanup(false)

	arg_3_0.layer = var_3_3
	arg_3_0.resBg = tolua.cast(var_3_3:getChildByTag(1), "CCSprite")

	arg_3_0:setContentSize(CCSizeMake(80, 70))
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:addChild(var_3_3)
	var_3_0()
	arg_3_0:reset()
end

function var_0_0.initBaseInfo(arg_5_0)
	if arg_5_0.record then
		local var_5_0 = arg_5_0.record.pixelX
		local var_5_1 = WORLD_SCENE_HEIGHT - arg_5_0.record.pixelY

		arg_5_0:setPosition(var_5_0 - arg_5_0:getContentSize().width / 2, var_5_1 - arg_5_0:getContentSize().height / 2)

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

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0:setlayerVisible(true)
	arg_7_0:initBaseInfo()

	arg_7_0.type = arg_7_1
	arg_7_0.shopInfo = nil

	if arg_7_0.type == EWorldSpecialNode.Shop then
		local var_7_0 = g_Self.kWorldHandler.worldInfo

		if var_7_0 then
			arg_7_0.shopInfo = var_7_0.ShopInfo

			if arg_7_0.shopInfo and arg_7_0.shopInfo.EndTm < g_Self.kTimeHandler:getServerTime() then
				arg_7_0:setlayerVisible(false)
				g_Self.kWorldHandler:resetWorldShopInfo()
			end
		end
	end

	zbWordHelp:setRandNodeTexture(arg_7_0.resBg, arg_7_1)
end

function var_0_0.onClick(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0.record == nil then
		return
	end

	if arg_8_0.type == nil then
		g_WsMsgHandler:WS_WorldSpe_Open_Req(arg_8_0.record.id)
	elseif arg_8_0.type == EWorldSpecialNode.HorseCar then
		g_MainScene:showWorldRobInfoWnd(arg_8_0.record)
	elseif arg_8_0.type == EWorldSpecialNode.Face then
		g_MainScene:showWorldGameWnd(arg_8_0.record)
	elseif arg_8_0.type == EWorldSpecialNode.BgzClue then
		g_MainScene:showWorldYuanZheng()
	elseif arg_8_0.type == EWorldSpecialNode.Shop then
		if g_Self.kWorldHandler:getWorldShopLessTimeByNodeId() > 0 then
			g_MainScene:showShopWorldWnd()
		end
	elseif arg_8_0.type == EWorldSpecialNode.AwardBox then
		g_MainScene:showWorldBoxWnd(arg_8_0.record)
	end
end

function var_0_0.update(arg_9_0)
	if arg_9_0.layer:isVisible() == false then
		return
	end

	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_9_0.type == EWorldSpecialNode.Shop and arg_9_0.shopInfo and arg_9_0.shopInfo.EndTm < g_Self.kTimeHandler:getServerTime() then
		arg_9_0:setlayerVisible(false)
		g_Self.kWorldHandler:resetWorldShopInfo()
	end
end
