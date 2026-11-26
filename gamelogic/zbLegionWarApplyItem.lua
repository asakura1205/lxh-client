local var_0_0 = class("zbLegionWarApplyItem")

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

function createLegionWarApplyItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.nodeInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.spriteNode = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbApplied = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnApply = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")

		arg_3_0.btnApply:addHandleOfControlEvent(function()
			arg_3_0:onApply()
		end, CCControlEventTouchUpInside)
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
		arg_7_0.lbDesc:setString(var_7_0.desc)
	end

	if g_Self.kWorldHandler:isNodeOpenById(arg_7_1.NodeId) then
		arg_7_0.layerContent:setGray(true)
		arg_7_0.lbApplied:setVisible(arg_7_1.NodeState == ELegionWarNodeState.AlreadyApply)
		arg_7_0.btnApply:setVisible(arg_7_1.NodeState ~= ELegionWarNodeState.AlreadyApply)
	else
		arg_7_0.layerContent:setGray(false)
	end

	if arg_7_1.NodeState == ELegionWarNodeState.AlreadyApply then
		arg_7_0.lbApplied:setVisible(true)
		arg_7_0.btnApply:setVisible(false)
		arg_7_0.layerContent:setGray(false)
		arg_7_0.lbApplied:setString(a2u("\xD2ѱ\xA8\xC3\xFB"))
		arg_7_0.lbApplied:setColor(FONT_COLOR_GREEN)
	elseif g_Self.kWorldHandler:isNodeOpenById(arg_7_1.NodeId) then
		arg_7_0.lbApplied:setVisible(false)
		arg_7_0.btnApply:setVisible(true)
		arg_7_0.layerContent:setGray(false)
	else
		arg_7_0.lbApplied:setVisible(true)
		arg_7_0.btnApply:setVisible(false)
		arg_7_0.layerContent:setGray(true)
		arg_7_0.lbApplied:setString(a2u("δ\xBF\xAA\xC6\xF4"))
		arg_7_0.lbApplied:setColor(FONT_COLOR_GRAY)
	end
end

function var_0_0.onApply(arg_8_0)
	if g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId()) ~= ELegionOffice.Leader then
		g_Bubble:bubbleInfo(a2u("\xBD\xF6\xBB\xE1\xB9ݳ\xA4\xBFɱ\xA8\xC3\xFB"))

		return
	end

	if arg_8_0.nodeInfo ~= nil then
		g_WsMsgHandler:WS_LegionWar_Apply_Req(arg_8_0.nodeInfo.NodeId)
	end
end
