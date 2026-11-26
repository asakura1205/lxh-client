require("gamecore.zbAwardHelper")

local var_0_0 = class("zbTechItem", CCNodeExtend)

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

function createTechItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local function var_3_0()
		arg_3_0.point = arg_3_5
		arg_3_0.parentNode = arg_3_4
		arg_3_0.ccNode = arg_3_1
		arg_3_0.id = arg_3_2
	end

	local function var_3_1()
		function createArrowMoveAction(arg_6_0)
			local var_6_0 = 1.1
			local var_6_1 = 10
			local var_6_2 = ccp(arg_6_0:getPosition())

			var_6_2.y = var_6_2.y - 3

			local var_6_3 = CCMoveTo:create(var_6_0, var_6_2)

			var_6_2.y = var_6_2.y + 6

			local var_6_4 = CCMoveTo:create(var_6_0, var_6_2)
			local var_6_5 = CCArray:create()

			var_6_5:addObject(var_6_3)
			var_6_5:addObject(var_6_4)

			local var_6_6 = CCSequence:create(var_6_5)

			arg_6_0:stopAllActions()
			arg_6_0:runAction(CCRepeatForever:create(var_6_6))
		end

		local var_5_0 = zbTechTable:getRecord(arg_3_0.id)

		arg_3_0.iconRoot = tolua.cast(arg_3_1:getChildByTag(0), "CCNode")
		arg_3_0.btnFrame = tolua.cast(arg_3_0.iconRoot:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.iconRoot:getChildByTag(2), "CCSprite")
		arg_3_0.spriteUpHint = tolua.cast(arg_3_0.iconRoot:getChildByTag(3), "CCSprite")

		arg_3_0.spriteUpHint:setVisible(false)

		arg_3_0.select_Item = tolua.cast(arg_3_0.parentNode:getChildByTag(20), "CCNode")

		arg_3_0.select_Item:setZOrder(ZORDER_TOP)

		local var_5_1 = createUIAnimation()

		var_5_1:refresh("effect/spine/ui_tubiaokuang_03/ui_tubiaokuang_03.json", "effect/spine/ui_tubiaokuang_03/ui_tubiaokuang_03.atlas")
		var_5_1:setAnimation("animation", true, 0.5)
		var_5_1:setAnchorPoint(ccp(0, 0))
		var_5_1:setPosition(0, 0)
		var_5_1:setZOrder(ZORDER_TOP)
		arg_3_0.select_Item:addChild(var_5_1)
		createArrowMoveAction(arg_3_0.spriteUpHint)
		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)

		local var_5_2 = zbIconHelper:getTechIconPath(arg_3_0.id)

		arg_3_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_2))
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch(arg_3_3)
		end, CCControlEventTouchUpInside)

		if g_Self.kTechHandler:getStudyedTech(arg_3_0.id) == nil then
			arg_3_0.spriteIcon:setGray(false)
		end

		arg_3_0:refresh()
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = zbTechTable:getRecord(arg_8_0.id)
	local var_8_1 = g_Self.kTechHandler:getStudyedTech(arg_8_0.id)

	if arg_8_0.id == 4001 or arg_8_0.id == 4002 or arg_8_0.id == 4003 then
		arg_8_0.spriteIcon:setGray(g_Self:getLevel() < var_8_0.unlockLvl)
	else
		arg_8_0.spriteIcon:setGray(var_8_1 == nil)
	end

	local var_8_2 = g_Self.kTechHandler:canUpgrade(arg_8_0.id)

	arg_8_0.spriteUpHint:setVisible(var_8_2 == true)

	return var_8_2
end

function var_0_0.onTouch(arg_9_0, arg_9_1)
	arg_9_0.select_Item:setPosition(arg_9_0.point)

	if g_MainScene.wndTech then
		g_MainScene.wndTech.techItemDetail:refresh(arg_9_0.id)
	end
end
