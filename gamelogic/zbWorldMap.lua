require("gamelogic.zbWorldDefine")
require("gamelogic.zbWorldFog")
require("gamelogic.zbWorldGrid")
require("gamelogic.zbMapNodeMgr")
require("gamelogic.zbMapOpenTitleMgr")

local var_0_0 = 0.01
local var_0_1 = class("zbWorldMap", CCNodeExtend)

var_0_1.__index = var_0_1

function var_0_1.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_1)

	return arg_1_0
end

function createWordMap()
	local var_2_0 = var_0_1.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_1.init(arg_3_0)
	local function var_3_0()
		arg_3_0.dummyMapLayer = nil
		arg_3_0.mapobjectlist = {}
		arg_3_0.curScale = 1
		arg_3_0.secondMapLoad = false
		arg_3_0.curPickObj = nil
		arg_3_0.downPickObj = nil
		arg_3_0.beginTouchUIPos = ccp(0, 0)
		arg_3_0.touchMoving = false
		arg_3_0.execTouchDowned = false
		arg_3_0.bdoZoomScale = false
		arg_3_0.lasttouchEndpos = ccp(0, 0)
		arg_3_0.canZoom = true

		if zbGlobalUtil:getTargetPlatform() == "ios" then
			var_0_0 = 0.02
		end

		arg_3_0.mulTouchPos = {}
	end

	local function var_3_1()
		local var_5_0 = CCLayer:create()

		var_5_0:setContentSize(CCSizeMake(WORLD_SCENE_WIDTH, WORLD_SCENE_HEIGHT))
		var_5_0:setAnchorPoint(ccp(0.5, 0.5))
		var_5_0:setPosition(0, 0)
		var_5_0:retain()

		return var_5_0
	end

	local function var_3_2(arg_6_0)
		arg_3_0.fog = createWorldFog(arg_6_0)

		arg_3_0.fog:refresh()
	end

	local function var_3_3(arg_7_0)
		arg_3_0.nodeGrid = createWorldGrid(arg_7_0)
	end

	local function var_3_4(arg_8_0)
		arg_3_0.mapNodeMgr = createMapNodeMgr(arg_8_0, arg_3_0)
	end

	local function var_3_5(arg_9_0)
		arg_3_0.mapOpentitleMgr = createMapOpenTitleMgr(arg_9_0, arg_3_0)
	end

	local function var_3_6(arg_10_0)
		arg_3_0.effectFocus = createUIAnimation()

		arg_3_0.effectFocus:refresh("effect/spine/ui_tishiguangquan/ui_tishiguangquan.json", "effect/spine/ui_tishiguangquan/ui_tishiguangquan.atlas")
		arg_3_0.effectFocus:setPosition(0, 0)
		arg_3_0.effectFocus:setAnchorPoint(ccp(0.5, 0.5))
		arg_3_0.effectFocus:setScale(0.5)
		arg_10_0:addChild(arg_3_0.effectFocus)
	end

	local function var_3_7(arg_11_0)
		arg_3_0.effectVictor = createUIAnimation()

		arg_3_0.effectVictor:refresh("effect/spine/ui_shijielihua/ui_shijielihua.json", "effect/spine/ui_shijielihua/ui_shijielihua.atlas")
		arg_3_0.effectVictor:setPosition(0, 0)
		arg_3_0.effectVictor:setAnchorPoint(ccp(0.5, 0.5))
		arg_3_0.effectVictor:setScale(0.8)
		arg_11_0:addChild(arg_3_0.effectVictor)
	end

	local function var_3_8()
		arg_3_0.dummyMapLayer = var_3_1()

		arg_3_0:setContentSize(CCSizeMake(1136, 640))
		zbWordHelp:loadMap(arg_3_0.dummyMapLayer, arg_3_0.mapobjectlist)
		var_3_2(arg_3_0.dummyMapLayer)
		var_3_4(arg_3_0.dummyMapLayer)
		var_3_5(arg_3_0.dummyMapLayer)
		var_3_6(arg_3_0.dummyMapLayer)
		var_3_7(arg_3_0.dummyMapLayer)

		local var_12_0 = CCScrollView:create(CCSizeMake(1136, 640))

		var_12_0:setDirection(kCCScrollViewDirectionBoth)
		var_12_0:setBounceable(false)
		var_12_0:setContainer(arg_3_0.dummyMapLayer)

		arg_3_0.sv = var_12_0

		arg_3_0:addChild(var_12_0)

		arg_3_0.curScale = 0.5
		arg_3_0.maxScale = 1
		arg_3_0.minScale = 0.5

		arg_3_0.sv:setScaleMaxMin(arg_3_0.maxScale, arg_3_0.minScale)
		arg_3_0.sv:setZoomScale(arg_3_0.curScale)
		arg_3_0.sv:setTouchPriority(TOUCHPRIORITY_MAX)
	end

	var_3_0()
	var_3_8()
	arg_3_0:initMultiTouches()
end

function var_0_1.doShow(arg_13_0)
	arg_13_0.curScale = 0.5

	arg_13_0.sv:setZoomScale(arg_13_0.curScale)
	arg_13_0:gotoPositionAndScale(WORLD_SCENE_WIDTH / 2, WORLD_SCENE_HEIGHT / 2, true, nil, 0.9)
	zbWordHelp:loadWolrCommonSprite()
	arg_13_0:setLayerTouchEnabled(true)
end

function var_0_1.refresh(arg_14_0)
	local var_14_0 = g_Self.kTechHandler:getStudyedTechLevel(3001)

	if arg_14_0.secondMapLoad == false and var_14_0 >= 6 then
		zbWordHelp:loadSecondMap(arg_14_0.dummyMapLayer, arg_14_0.mapobjectlist)

		arg_14_0.secondMapLoad = true
	end

	arg_14_0.fog:setAllLock()

	for iter_14_0, iter_14_1 in pairs(g_Self.kWorldHandler.openGridList) do
		arg_14_0.fog:unlock(iter_14_1[1], iter_14_1[2])
	end

	arg_14_0.fog:refresh()
	arg_14_0.mapNodeMgr:initNodes()
	arg_14_0.mapNodeMgr:initRandNodeInfo()
	arg_14_0.mapOpentitleMgr:refreshInfo()
end

function var_0_1.setLayerTouchEnabled(arg_15_0, arg_15_1)
	arg_15_0.dummyMapLayer:setTouchEnabled(arg_15_1)
end

function var_0_1.playEffectFoucs(arg_16_0, arg_16_1)
	if arg_16_0.effectFocus then
		arg_16_0.effectFocus:setPosition(arg_16_1)
		arg_16_0.effectFocus:setAnimation("animation", false)
	end
end

function var_0_1.playEffectVictor(arg_17_0, arg_17_1)
	if arg_17_0.effectVictor then
		arg_17_0.effectVictor:setPosition(arg_17_1)
		arg_17_0.effectVictor:setAnimation("animation", false)
	end
end

function var_0_1.worldUnlock(arg_18_0)
	if WorldUnlockAckData then
		local var_18_0 = WorldUnlockAckData.NodeId
		local var_18_1 = g_Self.kWorldHandler:getNodeIndexById(var_18_0)

		if zbUtil:isValidTable(var_18_1) then
			for iter_18_0, iter_18_1 in pairs(var_18_1) do
				arg_18_0.fog:unlock(iter_18_1[1], iter_18_1[2])
				arg_18_0.fog:refresh()
			end
		end

		local var_18_2 = zbWorldNodeTable:getRecord(var_18_0)

		if var_18_2 and arg_18_0.secondMapLoad == false and var_18_2.needTechLevel >= 6 then
			zbWordHelp:loadSecondMap(arg_18_0.dummyMapLayer, arg_18_0.mapobjectlist)

			arg_18_0.secondMapLoad = true
		end
	end

	arg_18_0.mapNodeMgr:unlockNode()
	arg_18_0.mapOpentitleMgr:refreshInfo()
end

function var_0_1.update(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.mapobjectlist) do
		if iter_19_1 then
			arg_19_0:objectClip(iter_19_1)
		end
	end

	arg_19_0.mapNodeMgr:update(arg_19_1)
	arg_19_0.mapOpentitleMgr:update(arg_19_1)
	arg_19_0.fog:update(arg_19_1)
end

function var_0_1.getRootNode(arg_20_0)
	return arg_20_0.dummyMapLayer
end

function var_0_1.objectClip(arg_21_0, arg_21_1)
	if arg_21_1 then
		zbGlobalUtil:objectClip(arg_21_1, arg_21_0.sv)
	end
end

function var_0_1.onAdd(arg_22_0)
	if arg_22_0.canZoom == false then
		return
	end

	local var_22_0 = arg_22_0.curScale + var_0_0

	if var_22_0 >= arg_22_0.maxScale then
		var_22_0 = arg_22_0.maxScale
		arg_22_0.curScale = var_22_0
	end

	arg_22_0:nodeOpacitySet()

	arg_22_0.curScale = var_22_0

	if arg_22_0.touchmoveCenterPos == nil then
		return
	end

	arg_22_0:gotoPosition(arg_22_0.touchmoveCenterPos.x, arg_22_0.touchmoveCenterPos.y, false, arg_22_0.touchsvPos)
end

function var_0_1.onDec(arg_23_0)
	if arg_23_0.canZoom == false then
		return
	end

	local var_23_0 = arg_23_0.curScale - var_0_0

	if var_23_0 <= arg_23_0.minScale then
		var_23_0 = arg_23_0.minScale
		arg_23_0.curScale = var_23_0
	end

	arg_23_0:nodeOpacitySet()

	arg_23_0.curScale = var_23_0

	if arg_23_0.touchmoveCenterPos == nil then
		return
	end

	arg_23_0:gotoPosition(arg_23_0.touchmoveCenterPos.x, arg_23_0.touchmoveCenterPos.y, false, arg_23_0.touchsvPos)
end

function var_0_1.nodeOpacitySet(arg_24_0)
	local var_24_0 = 255 * ((arg_24_0.curScale - arg_24_0.minScale) / (arg_24_0.maxScale - arg_24_0.minScale))

	arg_24_0.mapNodeMgr:setLayerOpacity(var_24_0)
	arg_24_0.mapOpentitleMgr:setLayerOpacity(var_24_0)
end

function var_0_1.getTouchPosGL(arg_25_0, arg_25_1, arg_25_2)
	return (arg_25_0.dummyMapLayer:convertToNodeSpace(ccp(arg_25_1, arg_25_2)))
end

function var_0_1.getTouchPosSv(arg_26_0, arg_26_1, arg_26_2)
	return (arg_26_0.sv:convertToNodeSpace(ccp(arg_26_1, arg_26_2)))
end

function var_0_1.setScrollEnable(arg_27_0, arg_27_1)
	arg_27_0.sv:setCanMove(arg_27_1)
end

function var_0_1.didScroolEnd(arg_28_0)
	arg_28_0:nodeOpacitySet()

	if arg_28_0.curScale >= arg_28_0.maxScale then
		arg_28_0.curScale = arg_28_0.maxScale - 0.1
	elseif arg_28_0.curScale <= arg_28_0.minScale then
		arg_28_0.curScale = arg_28_0.minScale + 0.1
	end

	if arg_28_0.touchmoveCenterPos == nil then
		return
	end

	arg_28_0:gotoPosition(arg_28_0.touchmoveCenterPos.x, arg_28_0.touchmoveCenterPos.y, true, arg_28_0.touchsvPos)
end

function var_0_1.touchEnd(arg_29_0)
	arg_29_0:setScrollEnable(true)
end

function var_0_1.gotoPositionAndScale(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	if arg_30_5 then
		arg_30_0.curScale = arg_30_5
	end

	arg_30_0:gotoPosition(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
end

function var_0_1.gotoPosition(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = arg_31_0.sv:getViewSize()
	local var_31_1 = arg_31_0.sv:maxContainerOffset()
	local var_31_2 = ccp(0, 0)

	var_31_2.x = var_31_0.width - WORLD_SCENE_WIDTH * arg_31_0.curScale
	var_31_2.y = var_31_0.height - WORLD_SCENE_HEIGHT * arg_31_0.curScale

	if arg_31_4 == nil then
		arg_31_4 = ccp(var_31_0.width / 2, var_31_0.height / 2)
	end

	local var_31_3 = ccp(arg_31_4.x - arg_31_1 * arg_31_0.curScale, arg_31_4.y - arg_31_2 * arg_31_0.curScale)

	var_31_3.x = zbUtil:clamp(var_31_3.x, var_31_2.x, var_31_1.x)
	var_31_3.y = zbUtil:clamp(var_31_3.y, var_31_2.y, var_31_1.y)

	if arg_31_3 == false then
		arg_31_0.dummyMapLayer:setScale(arg_31_0.curScale)
		arg_31_0.dummyMapLayer:setPosition(var_31_3)
	else
		local function var_31_4()
			arg_31_0.canZoom = true
		end

		local var_31_5 = CCScaleTo:create(0.5, arg_31_0.curScale)
		local var_31_6 = CCMoveTo:create(0.5, var_31_3)
		local var_31_7 = CCCallFuncN:create(var_31_4)
		local var_31_8 = CCSpawn:createWithTwoActions(var_31_5, var_31_6)
		local var_31_9 = CCSequence:createWithTwoActions(var_31_8, var_31_7)

		arg_31_0.canZoom = false

		arg_31_0.dummyMapLayer:stopAllActions()
		arg_31_0.dummyMapLayer:runAction(var_31_9)
	end
end

function var_0_1.pickObject(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.mapNodeMgr.nodelist) do
		if iter_33_1:isVisible() and iter_33_1:pickTest(arg_33_1, arg_33_2) and var_33_0 == nil then
			var_33_0 = iter_33_1

			return var_33_0
		end
	end

	for iter_33_2, iter_33_3 in pairs(arg_33_0.mapNodeMgr.randNodelist) do
		if iter_33_3:isVisible() and iter_33_3:pickTest(arg_33_1, arg_33_2) and var_33_0 == nil then
			var_33_0 = iter_33_3

			return var_33_0
		end
	end

	return nil
end

function var_0_1.initMultiTouches(arg_34_0)
	arg_34_0.curdis = 0
	arg_34_0.lastdis = 0
	arg_34_0.lastTouchTm = 0

	local function var_34_0(arg_35_0, arg_35_1)
		if arg_35_0 == TOUCH_EVENT_TYPE_BEGAN then
			if table.getn(arg_35_1) == 3 then
				local var_35_0 = arg_34_0:getTouchPosGL(arg_35_1[1], arg_35_1[2])

				arg_34_0.beginTouchUIPos.x = arg_35_1[1]
				arg_34_0.beginTouchUIPos.y = arg_35_1[2]
				arg_34_0.touchMoving = false
				arg_34_0.execTouchDowned = false
				arg_34_0.downPickObj = arg_34_0:pickObject(var_35_0.x, var_35_0.y)
			end

			return true
		elseif arg_35_0 == TOUCH_EVENT_TYPE_MOVED then
			if table.getn(arg_35_1) <= 3 then
				local var_35_1 = arg_34_0:getTouchPosGL(arg_35_1[1], arg_35_1[2])
				local var_35_2 = zbUtil:distSq(arg_35_1[1], arg_35_1[2], arg_34_0.beginTouchUIPos.x, arg_34_0.beginTouchUIPos.y)

				if arg_34_0.touchMoving == false and var_35_2 >= MOVE_DIST_TEST then
					arg_34_0.touchMoving = true
				end
			elseif table.getn(arg_35_1) > 3 then
				arg_34_0:setScrollEnable(false)

				arg_34_0.bdoZoomScale = true
				arg_34_0.mulTouchPos = {}

				for iter_35_0 = 1, #arg_35_1, 3 do
					local var_35_3 = {
						x = arg_35_1[iter_35_0],
						y = arg_35_1[iter_35_0 + 1]
					}

					table.insert(arg_34_0.mulTouchPos, var_35_3)

					if table.getn(arg_34_0.mulTouchPos) == 2 then
						break
					end
				end

				local var_35_4 = arg_34_0.mulTouchPos[1]
				local var_35_5 = arg_34_0.mulTouchPos[2]

				arg_34_0.curdis = math.sqrt(math.pow(var_35_5.y - var_35_4.y, 2) + math.pow(var_35_5.x - var_35_4.x, 2))

				local var_35_6 = arg_34_0:getTouchPosGL(var_35_4.x, var_35_4.y)
				local var_35_7 = arg_34_0:getTouchPosGL(var_35_5.x, var_35_5.y)
				local var_35_8 = arg_34_0:getTouchPosSv(var_35_4.x, var_35_4.y)
				local var_35_9 = arg_34_0:getTouchPosSv(var_35_5.x, var_35_5.y)

				arg_34_0.touchmoveCenterPos = zbUtil:getCenterPosOn2Point(var_35_6, var_35_7)
				arg_34_0.touchsvPos = zbUtil:getCenterPosOn2Point(var_35_8, var_35_9)

				if arg_34_0.lastdis > arg_34_0.curdis and arg_34_0.lastdis ~= 0 then
					arg_34_0:onDec()
				elseif arg_34_0.lastdis < arg_34_0.curdis and arg_34_0.lastdis ~= 0 then
					arg_34_0:onAdd()
				end

				arg_34_0.lastdis = arg_34_0.curdis
			end
		elseif arg_35_0 == TOUCH_EVENT_TYPE_ENDED then
			if arg_34_0.curScale >= arg_34_0.maxScale or arg_34_0.curScale <= arg_34_0.minScale then
				arg_34_0:didScroolEnd()
			end

			if table.getn(arg_35_1) <= 3 and arg_34_0.bdoZoomScale == false then
				local var_35_10 = arg_34_0:getTouchPosGL(arg_35_1[1], arg_35_1[2])

				if zbUtil:distSq(arg_35_1[1], arg_35_1[2], arg_34_0.beginTouchUIPos.x, arg_34_0.beginTouchUIPos.y) < MOVE_DIST_TEST then
					arg_34_0.curPickObj = arg_34_0.downPickObj
					arg_34_0.execTouchDowned = true
				end

				if arg_34_0.execTouchDowned == true and arg_34_0.curPickObj ~= nil then
					arg_34_0.curPickObj:onClick(var_35_10.x, var_35_10.y)
				end
			end

			arg_34_0.bdoZoomScale = false

			arg_34_0:touchEnd()
		end
	end

	arg_34_0.dummyMapLayer:setTouchEnabled(true)
	arg_34_0.dummyMapLayer:registerScriptTouchHandler(var_34_0, true)
end
