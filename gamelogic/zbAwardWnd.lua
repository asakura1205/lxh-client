require("gamelogic.zbItem")

local var_0_0 = class("zbAwardWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createAwardWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
		arg_3_0.initPos = ccp(0, 0)
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/awardshow.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layerBg = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.nodeAward = tolua.cast(arg_3_0.layerBg:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_2 = tolua.cast(arg_3_0.nodeAward:getChildByTag(iter_5_0), "CCNode")
			local var_5_3 = createItem()

			var_5_3:setContentSize(CCSizeMake(110, 110))
			var_5_3:setPositionY(var_5_2:getPositionY() + 25)
			var_5_3:setScale(0.9)
			var_5_3:setCascadeOpacityEnabled(true)

			arg_3_0.awardItems[iter_5_0] = var_5_3

			arg_3_0.nodeAward:addChild(arg_3_0.awardItems[iter_5_0])
			var_5_2:removeFromParentAndCleanup(true)
		end

		arg_3_0.layerBg:setCascadeOpacityEnabled(true)

		arg_3_0.initPos = ccp(arg_3_0.layerBg:getPosition())

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	for iter_6_0 = 1, 5 do
		arg_6_0.awardItems[iter_6_0]:setVisible(false)
	end

	local function var_6_0()
		arg_6_0.layerBg:setVisible(true)

		local var_7_0 = 1

		for iter_7_0, iter_7_1 in pairs(arg_6_1) do
			if arg_6_0.awardItems[var_7_0] == nil then
				break
			end

			arg_6_0.awardItems[var_7_0]:refreshAward(iter_7_1.awardType, iter_7_1.awardId, iter_7_1.awardCount)
			arg_6_0.awardItems[var_7_0]:setVisible(true)
			arg_6_0.awardItems[var_7_0]:fadeOut(1.5)
			arg_6_0.awardItems[var_7_0]:setNeedTip(false)

			var_7_0 = var_7_0 + 1
		end

		zbUIEffect:centerNodeItems(arg_6_0.awardItems)
		g_Audio:playSound(AudioDefine.UI_AWARD)
		arg_6_0.layerBg:setOpacity(255)
	end

	local function var_6_1()
		arg_6_0:hide()
	end

	local var_6_2 = CCArray:create()

	if g_AwardShowDelayTime > 0 then
		var_6_2:addObject(CCDelayTime:create(g_AwardShowDelayTime))
	end

	var_6_2:addObject(CCCallFuncN:create(var_6_0))
	var_6_2:addObject(CCDelayTime:create(0.9))
	var_6_2:addObject(CCSpawn:createWithTwoActions(CCFadeTo:create(1.5, 0), CCMoveTo:create(1.5, ccp(arg_6_0.initPos.x, arg_6_0.initPos.y + 60))))
	var_6_2:addObject(CCCallFuncN:create(var_6_1))

	local var_6_3 = CCSequence:create(var_6_2)

	arg_6_0.layerBg:setOpacity(0)
	arg_6_0.layerBg:setPosition(arg_6_0.initPos)
	arg_6_0.layerBg:stopAllActions()
	arg_6_0.layerBg:runAction(var_6_3)
end
