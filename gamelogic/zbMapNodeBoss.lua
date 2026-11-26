require("gamelogic.zbMapNodeBase")

local var_0_0 = class("zbMapNodeBoss", zbMapNodeBase)

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

function createMapNodeBoss(arg_2_0)
	local var_2_0 = var_0_0.extend(zbMapNodeBase.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
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

	arg_3_0.nodebottom:setVisible(false)
	arg_3_0:setContentSize(CCSizeMake(100, 150))
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:addChild(var_3_3)
	var_3_0()
	arg_3_0:initBaseInfo()
	arg_3_0:refresh()
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

function var_0_0.refresh(arg_6_0)
	arg_6_0.layer:setVisible(zbFunHelper:isLockNoTip(EFuncType.WorldBoss) == false)
end

function var_0_0.onClick(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g_MainScene:showWorldBoss()
end

function var_0_0.update(arg_8_0)
	return
end
