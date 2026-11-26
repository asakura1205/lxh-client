local var_0_0 = class("zbChatContentItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createChatContentItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

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

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.chatdata = arg_3_1

	if arg_3_1.type == "chatstr" then
		local var_3_0 = CCLabelTTF:create(a2u(arg_3_1.content), "ui/font/FZY4JW--GB1-0.ttf", 22)

		var_3_0:setPositionX(arg_3_2)

		if arg_3_3 == nil then
			var_3_0:setColor(ccc3(128, 64, 0))
		else
			var_3_0:setColor(arg_3_3)
		end

		var_3_0:setAnchorPoint(ccp(0, 0.5))

		arg_3_2 = arg_3_2 + var_3_0:getContentSize().width

		arg_3_0:addChild(var_3_0)
	elseif arg_3_1.type == "equip" or arg_3_1.type == "hero" then
		arg_3_0.nodeGrid = CCDrawNode:create()

		arg_3_0:addChild(arg_3_0.nodeGrid)

		local var_3_1 = arg_3_1.content
		local var_3_2 = ""

		if arg_3_1.type == "hero" then
			local var_3_3 = zbHeroTable:getRecord(tonumber(var_3_1))

			if var_3_3 then
				var_3_2 = var_3_3.name
			end
		end

		if var_3_2 ~= "" then
			local var_3_4 = CCLabelTTF:create(a2u(var_3_2), "ui/font/FZY4JW--GB1-0.ttf", 22)

			var_3_4:setColor(ccc3(255, 0, 255))

			local var_3_5 = var_3_4:getContentSize()
			local var_3_6 = CCSprite:create("image/common/button_transparent.png")
			local var_3_7 = CCControlButton:create(var_3_4, var_3_6)

			var_3_7:setPreferredSize(var_3_5)
			var_3_7:setPositionX(arg_3_2)
			var_3_7:setZoomOnTouchDown(false)
			var_3_7:addHandleOfControlEvent(function()
				arg_3_0:onEquipTouch()
			end, CCControlEventTouchUpInside)
			var_3_7:setTouchPriority(TOUCHPRIORITY_MIN)

			local var_3_8 = ccp(arg_3_2 + 5, -var_3_5.height / 2)
			local var_3_9 = ccp(arg_3_2 + var_3_5.width - 5, -var_3_5.height / 2)

			var_3_7:setAnchorPoint(ccp(0, 0.5))

			arg_3_2 = arg_3_2 + var_3_5.width

			arg_3_0:addChild(var_3_7)

			local var_3_10 = 1
			local var_3_11 = ccc4f(0.39215686274509803, 0, 0.39215686274509803, 1)

			arg_3_0.nodeGrid:drawSegment(var_3_8, var_3_9, var_3_10, var_3_11)
		end
	elseif arg_3_1.type == "face" then
		local var_3_12 = CCSpriteFrameCache:sharedSpriteFrameCache()
		local var_3_13 = arg_3_0.chatdata.content .. ".png"
		local var_3_14 = var_3_12:spriteFrameByName(var_3_13)

		if var_3_14 then
			local var_3_15 = CCSprite:createWithSpriteFrame(var_3_14)

			var_3_15:setPositionX(arg_3_2)
			var_3_15:setAnchorPoint(ccp(0, 0.5))
			var_3_15:setScale(0.5)

			arg_3_2 = arg_3_2 + var_3_15:getContentSize().width / 2

			arg_3_0:addChild(var_3_15)
		end
	elseif arg_3_1.type == "color" then
		local var_3_16 = arg_3_1.color
		local var_3_17 = CCLabelTTF:create(a2u(arg_3_1.content), "ui/font/FZY4JW--GB1-0.ttf", 22)

		var_3_17:setColor(ccc3(var_3_16[1], var_3_16[2], var_3_16[3]))
		var_3_17:setPositionX(arg_3_2)
		var_3_17:setAnchorPoint(ccp(0, 0.5))

		arg_3_2 = arg_3_2 + var_3_17:getContentSize().width

		arg_3_0:addChild(var_3_17)
	end

	arg_3_0.pos = arg_3_2
end

function var_0_0.onEquipTouch(arg_5_0)
	if arg_5_0.chatdata then
		echo("equip:", arg_5_0.chatdata.content)
		g_Bubble:bubbleInfo(a2u(arg_5_0.chatdata.content))
	end
end
