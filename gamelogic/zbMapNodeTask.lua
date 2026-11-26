require("gamelogic.zbMapNodeBase")

local var_0_0 = class("zbMapNodeTask", zbMapNodeBase)

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

function createMapNodeTask(arg_2_0)
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

	tolua.cast(var_3_3:getChildByTag(3), "CCNode"):setVisible(false)
	tolua.cast(var_3_3:getChildByTag(4), "CCSprite"):setVisible(false)
	tolua.cast(var_3_3:getChildByTag(6), "CCSprite"):setVisible(false)

	arg_3_0.nodebottom = tolua.cast(var_3_3:getChildByTag(2), "CCNode")
	arg_3_0.nodeName = tolua.cast(arg_3_0.nodebottom:getChildByTag(1003), "CCLabelTTF")

	arg_3_0:setContentSize(CCSizeMake(100, 150))
	arg_3_0:setAnchorPoint(ccp(0, 0))

	arg_3_0.notifyTag = (function(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setPosition(90, 15)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end)(var_3_3)

	arg_3_0:addChild(var_3_3)
	var_3_0()
	arg_3_0:initBaseInfo()
end

function var_0_0.initBaseInfo(arg_6_0)
	if arg_6_0.record then
		local var_6_0 = arg_6_0.record.pixelX
		local var_6_1 = WORLD_SCENE_HEIGHT - arg_6_0.record.pixelY

		arg_6_0:setPosition(var_6_0 - arg_6_0:getContentSize().width / 2, var_6_1 - arg_6_0:getContentSize().height / 2)
		arg_6_0.nodeName:setString(arg_6_0.record.name)

		local var_6_2 = arg_6_0.record.texPath
		local var_6_3 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_6_2)

		if var_6_3 then
			arg_6_0.resBg:initWithSpriteFrame(var_6_3)
		end
	end
end

function var_0_0.setlayerVisible(arg_7_0, arg_7_1)
	arg_7_0.layer:setVisible(arg_7_1)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:setlayerVisible(true)
end

function var_0_0.onClick(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0.record then
		local var_9_0 = g_Self.kWorldHandler:getWorldTaskInfoById(arg_9_0.record.id)

		g_MainScene:showWorldTaskWnd(var_9_0)
	end
end

function var_0_0.update(arg_10_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	local var_10_0 = false

	if arg_10_0.record then
		var_10_0 = g_Self.kWorldHandler:hasNotiFyTaskNodeById(arg_10_0.record.id)
	end

	arg_10_0.notifyTag:setVisible(var_10_0)
end
