zbFormationHelper = {}

function zbFormationHelper.getFormationDesc(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = "\xCE\xDE\xD5\xF3\xD0\xCD"
	local var_1_1 = "\xCE\xDE\xD5\xF3\xB7\xA8Ч\xB9\xFB"
	local var_1_2 = ""
	local var_1_3 = zbTechTable:getRecord(arg_1_1)

	if var_1_3 == nil then
		return
	end

	local var_1_4 = var_1_3.name

	if var_1_3.attrType1 > 0 then
		var_1_1 = "\xD4\xF6\xBC\xD3" .. arg_1_2 * var_1_3.attrGrowth1 + var_1_3.attrBase1 .. "\xB5\xE3" .. getItemPropStr(var_1_3.attrType1)
	end

	if var_1_3.attrType2 > 0 then
		var_1_2 = "\xD4\xF6\xBC\xD3" .. arg_1_2 * var_1_3.attrGrowth2 + var_1_3.attrBase2 .. "\xB5\xE3" .. getItemPropStr(var_1_3.attrType2)
	end

	return a2u(var_1_4), a2u(var_1_1), a2u(var_1_2)
end

function zbFormationHelper.formationAnimShow(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_3 == 0 or arg_2_4 < 1 then
		arg_2_1:setVisible(false)

		return false
	end

	local var_2_0 = string.format("image/icon/formation/formation_%d.png", arg_2_3)

	arg_2_1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_2_0))

	local var_2_1 = string.format("image/icon/formation/text_%d.png", arg_2_3)

	arg_2_2:setTexture(CCTextureCache:sharedTextureCache():addImage(var_2_1))

	local function var_2_2(arg_3_0)
		arg_3_0:setVisible(false)
	end

	arg_2_1:setVisible(true)
	arg_2_1:setCascadeOpacityEnabled(true)
	arg_2_1:setScale(3)

	local var_2_3 = CCArray:create()

	var_2_3:addObject(CCFadeIn:create(0.125))
	var_2_3:addObject(CCScaleTo:create(0.125, 1))

	local var_2_4 = CCSpawn:create(var_2_3)
	local var_2_5 = CCArray:create()

	var_2_5:addObject(CCFadeOut:create(0.08))
	var_2_5:addObject(CCScaleTo:create(0.08, 2))

	local var_2_6 = CCSpawn:create(var_2_5)
	local var_2_7 = CCArray:create()

	var_2_7:addObject(var_2_4)
	var_2_7:addObject(CCScaleTo:create(0.1, 1.05))
	var_2_7:addObject(CCScaleTo:create(0.1, 0.95))
	var_2_7:addObject(CCScaleTo:create(0.1, 1))
	var_2_7:addObject(CCDelayTime:create(1))
	var_2_7:addObject(var_2_6)
	var_2_7:addObject(CCCallFuncN:create(function()
		var_2_2(arg_2_1)
	end))

	local var_2_8 = CCSequence:create(var_2_7)

	arg_2_1:stopAllActions()
	arg_2_1:runAction(var_2_8)

	return true
end
