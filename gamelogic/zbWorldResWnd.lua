require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldResWnd", zbBaseWnd)

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

function createWorldResWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.nodeId = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_res.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbLimitDes = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLimit = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.nodeProduce = tolua.cast(var_5_2:getChildByTag(5), "CCNode")
		arg_3_0.spriteProduce = tolua.cast(arg_3_0.nodeProduce:getChildByTag(1), "CCSprite")
		arg_3_0.lbProduce = tolua.cast(arg_3_0.nodeProduce:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeSave = tolua.cast(var_5_2:getChildByTag(6), "CCNode")
		arg_3_0.spriteSave = tolua.cast(arg_3_0.nodeSave:getChildByTag(1), "CCSprite")
		arg_3_0.lbSave = tolua.cast(arg_3_0.nodeSave:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_UpdateNodeInfo)
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	if arg_9_1 ~= nil then
		arg_9_0.nodeId = arg_9_1
	end

	local var_9_0 = zbWorldNodeTable:getRecord(arg_9_0.nodeId)

	if var_9_0 == nil then
		return
	end

	arg_9_0.lbTitle:setString(var_9_0.name)
	arg_9_0.lbDesc:setString(var_9_0.desc)

	local var_9_1 = zbIconHelper:getAwardIconPath(var_9_0.resOut[1], var_9_0.resOut[2])

	arg_9_0.spriteProduce:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_1))

	local var_9_2 = g_Self.kWorldHandler:getWorldNodeResInfoById(EWorldNodeOccupyType.E_HOLD, arg_9_0.nodeId)

	if var_9_2 == nil then
		return
	end

	arg_9_0.lbProduce:setString(a2u(var_9_2.Output) .. a2u("/时"))
	arg_9_0.spriteSave:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_1))

	local var_9_3 = g_Self.kWorldHandler:getHoldAndFullSecondsByNodeId(arg_9_0.nodeId)
	local var_9_4 = math.ceil(var_9_3 / 3600 * tonumber(var_9_2.Output))

	arg_9_0.lbSave:setString(var_9_4 .. "/" .. var_9_0.maxOut)
end

function var_0_0.onFrameUpdate(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = g_Self.kWorldHandler:getHoldAndFullSecondsByNodeId(arg_10_0.nodeId)

	if var_10_0 < var_10_1 then
		arg_10_0.lbLimit:setString(zbUtil:SprintfHHMMSSNo24(var_10_1 - var_10_0))
	else
		arg_10_0:hide()
	end
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
