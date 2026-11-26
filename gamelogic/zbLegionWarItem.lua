local var_0_0 = class("zbLegionWarItem")

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

function createLegionWarItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.nodeInfo = nil
		arg_3_0.parentWnd = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteNode = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbLegion = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.spriteApplied = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.btnGoto = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")

		arg_3_0.btnGoto:addHandleOfControlEvent(function()
			arg_3_0:onGoto()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGoto:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGoto:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return
	end

	arg_7_0.nodeInfo = arg_7_1

	local var_7_0 = zbWorldNodeTable:getRecord(arg_7_1.NodeId)

	if var_7_0 ~= nil then
		local var_7_1 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_7_0.texPath)

		if var_7_1 then
			arg_7_0.spriteNode:initWithSpriteFrame(var_7_1)
		end

		arg_7_0.lbName:setString(var_7_0.name)
	end

	if arg_7_1.NodeState == ELegionWarNodeState.AlreadyApply then
		arg_7_0.spriteApplied:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legionwar/legionwar_applied.png"))
		arg_7_0.spriteApplied:setVisible(true)
	elseif arg_7_1.NodeState == ELegionWarNodeState.ReadyAttack or arg_7_1.NodeState == ELegionWarNodeState.Fighting and g_Self.kLegionHandler:isNodeCanFight(arg_7_1.NodeId) == true then
		arg_7_0.spriteApplied:setTexture(CCTextureCache:sharedTextureCache():addImage("image/legionwar/legionwar_selected.png"))
		arg_7_0.spriteApplied:setVisible(true)
	else
		arg_7_0.spriteApplied:setVisible(false)
	end

	if g_Self.kWorldHandler:isNodeOpenById(arg_7_1.NodeId) == false then
		arg_7_0.spriteNode:setGray(true)
		arg_7_0.lbLegion:setColor(FONT_COLOR_BLACK)
	else
		arg_7_0.spriteNode:setGray(false)
		arg_7_0.lbLegion:setColor(ccc3(102, 51, 0))
	end

	if arg_7_1.Legion and arg_7_1.Legion.LegionName and arg_7_1.Legion.LegionName ~= "" then
		arg_7_0.lbLegion:setString(a2u("ռ\xC1췽:") .. a2u(arg_7_1.Legion.LegionName))
	else
		arg_7_0.lbLegion:setString("")
	end
end

function var_0_0.onGoto(arg_8_0)
	if arg_8_0.nodeInfo == nil then
		return
	end

	if g_Self.kWorldHandler:isNodeOpenById(arg_8_0.nodeInfo.NodeId) == false then
		g_Bubble:bubbleInfo(a2u("\xCA\xC0\xBD\xE7\xD4\xC6δ\xBF\xAA\xC6\xF4"))
	else
		local var_8_0 = g_Self.kTimeHandler:getServerTime()
		local var_8_1 = g_Self.kLegionHandler.legionWarBaseInfo

		if var_8_1 == nil then
			return
		end

		if var_8_0 >= var_8_1.FightStartTm and var_8_0 < var_8_1.FightEndTm then
			if g_Self.kLegionHandler:isNodeCanFight(arg_8_0.nodeInfo.NodeId) == true then
				g_WsMsgHandler:WS_LegionWar_GetFightNode_Req(arg_8_0.nodeInfo.NodeId)
			else
				g_Bubble:bubbleInfo(a2u("\xBB\xE1\xB9\xDDս\xD5\xFD\xD4ڽ\xF8\xD0\xD0\xD6У\xACֻ\xD3оݵ\xE3\xB2\xCEս\xBB\xE1\xB9ݳ\xC9Ա\xBF\xC9\xD2Խ\xF8\xC8롣"))

				return
			end
		else
			g_WsMsgHandler:WS_LegionWar_GetDailyNode_Req(arg_8_0.nodeInfo.NodeId)
		end

		g_MainScene:showWorld()
		arg_8_0.parentWnd:hide()

		if g_MainScene.wndLegionScene then
			g_MainScene.wndLegionScene:hide()
		end
	end
end
