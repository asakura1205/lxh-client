zbUIEffect = {}

function zbUIEffect.centerStar(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1[1]:getContentSize().width * arg_1_1[1]:getScale()

	if arg_1_3 then
		var_1_0 = var_1_0 + arg_1_3
	end

	local var_1_1 = table.getn(arg_1_1)
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		if iter_1_1:isVisible() then
			var_1_2 = var_1_2 + 1
		end
	end

	for iter_1_2 = 1, var_1_2 do
		arg_1_1[iter_1_2]:setPositionX(arg_1_2 - var_1_0 * var_1_2 / 2 + (iter_1_2 - 1) * var_1_0 + var_1_0 / 2)
	end
end

function zbUIEffect.centerHeroDetailBtn(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if table.getn(arg_2_1) <= 0 then
		return
	end

	local var_2_0 = arg_2_1[1]:getContentSize().width

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		iter_2_1:setGray(false)
		iter_2_1:setVisible(false)
	end

	for iter_2_2 = 1, arg_2_2 do
		arg_2_1[iter_2_2]:setVisible(true)
		arg_2_1[iter_2_2]:setPositionX(((iter_2_2 - 1) * var_2_0 - var_2_0 * (arg_2_2 - 1) / 2) / (arg_2_2 / arg_2_4))
	end

	arg_2_1[arg_2_2]:setGray(arg_2_3)
end

function zbUIEffect.centerNodeItems(arg_3_0, arg_3_1)
	if table.getn(arg_3_1) <= 0 then
		return
	end

	local var_3_0 = arg_3_1[1]:getContentSize().width
	local var_3_1 = table.getn(arg_3_1)
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1:isVisible() then
			var_3_2 = var_3_2 + 1
		end
	end

	for iter_3_2 = 1, var_3_2 do
		arg_3_1[iter_3_2]:setPositionX(-(var_3_0 * var_3_2) / 2 + (iter_3_2 - 1) * var_3_0)
	end
end

function zbUIEffect.centerHeroStar(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if table.getn(arg_4_1) <= 0 then
		return
	end

	if arg_4_3 == nil then
		arg_4_3 = math.max(arg_4_2, 5)
	end

	local var_4_0 = arg_4_1[1]:getContentSize().width

	for iter_4_0 = 1, 8 do
		arg_4_1[iter_4_0]:setGray(false)
		arg_4_1[iter_4_0]:setVisible(false)
	end

	local var_4_1 = 2.5

	if arg_4_5 then
		var_4_1 = var_4_1 / arg_4_5
	end

	for iter_4_1 = 1, arg_4_3 do
		arg_4_1[iter_4_1]:setPositionX((var_4_0 * (arg_4_3 - 1) / 2 - (iter_4_1 - 1) * var_4_0) / var_4_1)
	end

	if arg_4_4 then
		local var_4_2 = 1
		local var_4_3 = arg_4_1[1]

		if var_4_3 == nil then
			return
		end

		local function var_4_4()
			if var_4_2 > arg_4_3 then
				var_4_3:stopAllActions()
			else
				if var_4_2 <= arg_4_2 then
					if arg_4_1[var_4_2] then
						arg_4_1[var_4_2]:setGray(false)
						arg_4_1[var_4_2]:setVisible(true)
					end
				elseif var_4_2 > arg_4_2 and arg_4_1[var_4_2] then
					arg_4_1[var_4_2]:setGray(true)
					arg_4_1[var_4_2]:setVisible(true)
				end

				var_4_2 = var_4_2 + 1
			end
		end

		local var_4_5 = CCCallFuncN:create(var_4_4)
		local var_4_6 = CCDelayTime:create(0.2)
		local var_4_7 = CCSequence:createWithTwoActions(var_4_5, var_4_6)

		var_4_3:stopAllActions()
		var_4_3:runAction(CCRepeatForever:create(var_4_7))
	else
		for iter_4_2 = 1, arg_4_2 do
			arg_4_1[iter_4_2]:setGray(false)
			arg_4_1[iter_4_2]:setVisible(true)
		end

		for iter_4_3 = arg_4_2 + 1, arg_4_3 do
			arg_4_1[iter_4_3]:setGray(true)
			arg_4_1[iter_4_3]:setVisible(true)
		end
	end
end

function zbUIEffect.createArrowMoveAction(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = ccp(arg_6_1:getPosition())

	var_6_0.y = var_6_0.y - arg_6_2

	local var_6_1 = CCMoveTo:create(arg_6_3, var_6_0)

	var_6_0.y = var_6_0.y + arg_6_2 * 2

	local var_6_2 = CCMoveTo:create(arg_6_3, var_6_0)
	local var_6_3 = CCArray:create()

	var_6_3:addObject(CCEaseInOut:create(var_6_1, 2))
	var_6_3:addObject(CCEaseInOut:create(var_6_2, 2))

	local var_6_4 = CCSequence:create(var_6_3)

	arg_6_1:stopAllActions()
	arg_6_1:runAction(CCRepeatForever:create(var_6_4))
end

function zbUIEffect.createNotifyTagScaleAction(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = CCArray:create()

	if arg_7_2 and arg_7_3 then
		var_7_0:addObject(CCScaleTo:create(0.3, 1.15 * arg_7_2, 1.15 * arg_7_3))
		var_7_0:addObject(CCScaleTo:create(0.2, 1 * arg_7_2, 1 * arg_7_3))
		var_7_0:addObject(CCDelayTime:create(2.5))
	else
		var_7_0:addObject(CCScaleTo:create(0.3, 1.15))
		var_7_0:addObject(CCScaleTo:create(0.2, 1))
		var_7_0:addObject(CCDelayTime:create(2.5))
	end

	local var_7_1 = CCSequence:create(var_7_0)

	arg_7_1:stopAllActions()
	arg_7_1:runAction(CCRepeatForever:create(var_7_1))
end

function zbUIEffect.runFadeToAction(arg_8_0, arg_8_1)
	local var_8_0 = CCFadeTo:create(1.5, 200)
	local var_8_1 = CCFadeTo:create(0.7, 20)
	local var_8_2 = CCSequence:createWithTwoActions(var_8_0, var_8_1)

	arg_8_1:stopAllActions()
	arg_8_1:runAction(CCRepeatForever:create(var_8_2))
end

function zbUIEffect.runScaleToAction(arg_9_0, arg_9_1)
	local var_9_0 = CCScaleTo:create(1, 0.6)
	local var_9_1 = CCScaleTo:create(1, 0.7)
	local var_9_2 = CCSequence:createWithTwoActions(var_9_0, var_9_1)

	arg_9_1:stopAllActions()
	arg_9_1:runAction(CCRepeatForever:create(var_9_2))
end

function zbUIEffect.runMoveByAction(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = CCMoveBy:create(1, ccp(0, arg_10_2))
	local var_10_1 = CCMoveBy:create(1, ccp(0, -arg_10_2))
	local var_10_2 = CCSequence:createWithTwoActions(var_10_0, var_10_1)

	arg_10_1:stopAllActions()
	arg_10_1:runAction(CCRepeatForever:create(var_10_2))
end
