require("gamecore.zbAnimation")

zbCombatScene = class("zbCombatScene", CCNodeExtend)
zbCombatScene.__index = zbCombatScene

function zbCombatScene.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCombatScene)

	return arg_1_0
end

function zbCombatScene.create(arg_2_0)
	local var_2_0 = zbCombatScene.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()
	var_2_0:retain()

	return var_2_0
end

function zbCombatScene.init(arg_3_0)
	arg_3_0.config = nil
	arg_3_0.skeletonList = {}
	arg_3_0.shakeList = {}
end

function zbCombatScene.free(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.skeletonList) do
		if iter_4_1 then
			iter_4_1:removeFromParentAndCleanup(true)

			iter_4_1 = nil
		end
	end

	arg_4_0.skeletonList = {}
	arg_4_0.shakeList = {}

	arg_4_0:removeAllChildrenWithCleanup(true)

	arg_4_0.config = nil
end

function zbCombatScene.load(arg_5_0, arg_5_1)
	arg_5_0:free()

	arg_5_0.config = arg_5_0:getConfig(arg_5_1)

	if arg_5_0.config == nil then
		echo("warning: invalid sceneId: " .. arg_5_1)

		return
	end

	local var_5_0 = CCSprite:create(arg_5_0.config.bg)

	var_5_0:setAnchorPoint(ccp(0.5, 0.5))

	if var_5_0:getContentSize().height ~= 640 then
		var_5_0:setPosition(568, 670 - var_5_0:getContentSize().height / 2)
	else
		var_5_0:setPosition(568, 320)
	end

	var_5_0:setZOrder(ZORDER_BOTTOM)
	arg_5_0:addChild(var_5_0)
	arg_5_0:insertShakeNode(var_5_0)

	if arg_5_0.config.fg ~= nil then
		local var_5_1 = CCSprite:create(arg_5_0.config.fg)

		var_5_1:setAnchorPoint(ccp(0.5, 0.5))
		var_5_1:setPositionX(arg_5_0.config.fgPosX)
		var_5_1:setPositionY(arg_5_0.config.fgPosY)
		var_5_1:setZOrder(ZORDER_TOP - 100)
		arg_5_0:addChild(var_5_1)
		arg_5_0:insertShakeNode(var_5_1)
	end

	if arg_5_0.config.fg1 ~= nil then
		local var_5_2 = CCSprite:create(arg_5_0.config.fg1)

		var_5_2:setAnchorPoint(ccp(0.5, 0.5))
		var_5_2:setPositionX(arg_5_0.config.fg1PosX)
		var_5_2:setPositionY(arg_5_0.config.fg1PosY)
		var_5_2:setZOrder(ZORDER_TOP - 100)
		arg_5_0:addChild(var_5_2)
		arg_5_0:insertShakeNode(var_5_2)
	end

	if arg_5_0.config.fg2 ~= nil then
		local var_5_3 = CCSprite:create(arg_5_0.config.fg2)

		var_5_3:setAnchorPoint(ccp(0.5, 0.5))
		var_5_3:setPositionX(arg_5_0.config.fg2PosX)
		var_5_3:setPositionY(arg_5_0.config.fg2PosY)
		var_5_3:setRotationY(180)
		var_5_3:setZOrder(ZORDER_TOP - 100)
		arg_5_0:addChild(var_5_3)
		arg_5_0:insertShakeNode(var_5_3)
	end

	local var_5_4 = table.getn(arg_5_0.config.layerList)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.config.layerList) do
		if iter_5_1.json ~= nil and iter_5_1.atlas ~= nil and iter_5_1.sequenceName ~= nil then
			local var_5_5 = createSpineAnimation(iter_5_1.json, iter_5_1.atlas)
			local var_5_6 = ccp(568, 320)

			if iter_5_1.posX ~= nil and iter_5_1.posY ~= nil then
				var_5_6.x = iter_5_1.posX
				var_5_6.y = iter_5_1.posY
			end

			if iter_5_1.scale ~= nil then
				var_5_5:setScale(iter_5_1.scale)
			end

			var_5_5:setAnchorPoint(ccp(0.5, 0.5))
			var_5_5:setPosition(var_5_6)
			var_5_5:setZOrder(iter_5_1.zorder)
			var_5_5:clearTracks()
			var_5_5:setAnimation(0, iter_5_1.sequenceName, true)
			arg_5_0:addChild(var_5_5)
			arg_5_0:insertShakeNode(var_5_5)
		elseif iter_5_1.sprite ~= nil and iter_5_1.sprite ~= "" then
			local var_5_7 = CCSprite:create(iter_5_1.sprite)

			var_5_7:setAnchorPoint(ccp(0.5, 0.5))
			var_5_7:setPosition(568, 670 - var_5_7:getContentSize().height / 2)
			var_5_7:setZOrder(iter_5_1.zorder)
			arg_5_0:addChild(var_5_7)
			arg_5_0:insertShakeNode(var_5_7)

			if iter_5_1.spriteMask ~= nil and iter_5_1.spriteMask ~= "" then
				var_5_7:setMaskTexture(CCTextureCache:sharedTextureCache():addImage(iter_5_1.spriteMask))
			end
		end
	end

	arg_5_0:adapter()
end

function zbCombatScene.addHero(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:adapterNode(arg_6_1)

	if arg_6_1.forceType == ForceType.Left then
		arg_6_1:setInitZOrder(arg_6_2)
	else
		arg_6_1:setInitZOrder(arg_6_2 + 100)
	end

	arg_6_0:addChild(arg_6_1)
end

function zbCombatScene.addBubbleLayer(arg_7_0, arg_7_1)
	arg_7_1:removeFromParentAndCleanup(false)
	arg_7_0:addChild(arg_7_1)
	arg_7_1:setZOrder(ZORDER_TOP + 10000000)
end

function zbCombatScene.hideHeros(arg_8_0)
	local var_8_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_8_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		iter_8_1:setVisible(false)
	end

	for iter_8_2, iter_8_3 in pairs(var_8_1) do
		iter_8_3:setVisible(false)
	end
end

function zbCombatScene.update(arg_9_0, arg_9_1)
	return
end

function zbCombatScene.adapter(arg_10_0)
	arg_10_0:setContentSize(CCSizeMake(1136, 640))
	arg_10_0:setAnchorPoint(ccp(0, 0))
	arg_10_0:setPosition(0, 0)

	local var_10_0 = CCEGLView:sharedOpenGLView():getFrameSize()
	local var_10_1 = arg_10_0:getContentSize()
	local var_10_2 = var_10_0.width / var_10_1.width
	local var_10_3 = var_10_0.height / var_10_1.height

	if g_Layout:isWHRatio4_3() then
		var_10_3 = var_10_2
	end

	local var_10_4 = (var_10_0.width - var_10_1.width * var_10_2) / 2
	local var_10_5 = (var_10_0.height - var_10_1.height * var_10_3) / 2

	arg_10_0:setPosition(var_10_4, var_10_5)
	arg_10_0:setScaleX(var_10_2)
	arg_10_0:setScaleY(var_10_3)

	if g_Layout:isWHRatio4_3() == false then
		local var_10_6 = arg_10_0:getChildren()

		if var_10_6 ~= nil then
			for iter_10_0 = 1, var_10_6:count() do
				local var_10_7 = tolua.cast(var_10_6:objectAtIndex(iter_10_0 - 1), "CCNode")

				var_10_7:setScaleX(var_10_3 / var_10_2 * var_10_7:getScaleX())
			end
		end
	end
end

function zbCombatScene.adapterNode(arg_11_0, arg_11_1)
	local var_11_0 = CCEGLView:sharedOpenGLView():getFrameSize()
	local var_11_1 = arg_11_0:getContentSize()
	local var_11_2 = var_11_0.width / var_11_1.width
	local var_11_3 = var_11_0.height / var_11_1.height

	if g_Layout:isWHRatio4_3() then
		var_11_3 = var_11_2
	end

	if g_Layout:isWHRatio4_3() == false then
		arg_11_1:setScaleX(var_11_3 / var_11_2 * arg_11_1:getScaleX())
	end
end

function zbCombatScene.getConfig(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(g_DataConfig.kSceneTable) do
		if iter_12_1.id == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function zbCombatScene.insertShakeNode(arg_13_0, arg_13_1)
	local var_13_0 = {
		node = arg_13_1,
		initPos = ccp(arg_13_1:getPosition())
	}

	table.insert(arg_13_0.shakeList, var_13_0)
end
