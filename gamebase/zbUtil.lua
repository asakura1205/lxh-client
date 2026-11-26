zbUtil = {}

function zbUtil.loadCCBNode(arg_1_0, arg_1_1)
	local var_1_0 = zbTableViewHelper:create()

	var_1_0:loadCCBFile(arg_1_1)

	local var_1_1 = translateAndStrokeHelper(var_1_0:readCCBNode())

	var_1_0:releaseSelf()

	return var_1_1
end

function zbUtil.hasVisibleParent(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1

	while var_2_0 ~= nil do
		if var_2_0:isVisible() == false then
			return false
		end

		var_2_0 = var_2_0:getParent()
	end

	return true
end

local var_0_0 = ccp(0, 0)

function zbUtil.PointInCtrl(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == nil then
		return false
	end

	var_0_0.x = arg_3_2
	var_0_0.y = arg_3_3
	var_0_0 = arg_3_1:getParent():convertToNodeSpace(var_0_0)

	if arg_3_1:boundingBox():containsPoint(var_0_0) then
		return true
	end

	return false
end

function zbUtil.PointInRect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 < arg_4_3.origin.x or arg_4_1 > arg_4_3.origin.x + arg_4_3.size.width or arg_4_2 < arg_4_3.origin.y or arg_4_2 > arg_4_3.origin.y + arg_4_3.size.height then
		return false
	end

	return true
end

function zbUtil.PointInRect2(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if arg_5_1 < arg_5_3 or arg_5_1 > arg_5_3 + arg_5_5 or arg_5_2 < arg_5_4 or arg_5_2 > arg_5_4 + arg_5_6 then
		return false
	end

	return true
end

function zbUtil.getScreenSize(arg_6_0)
	local var_6_0 = CCDirector:sharedDirector():getWinSize()

	if g_Layout:isWHRatio4_3() then
		var_6_0.height = var_6_0.height - 2 * g_Layout:fullScreenWndOffsetY()
	end

	return var_6_0
end

function zbUtil.freeWnd(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_1:freeDestroy()
		arg_7_1:release()
	end

	arg_7_1 = nil
end

function zbUtil.createEditBox(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	local var_8_0

	if arg_8_4 == nil then
		var_8_0 = CCSprite:create("image/login/green_edit.png")
	else
		var_8_0 = CCSprite:create(arg_8_4)
	end

	local var_8_1 = CCEditBox:create(CCSize(arg_8_1:getContentSize().width, arg_8_1:getContentSize().height), var_8_0)

	var_8_1:setPosition(ccp(0, 0))
	var_8_1:setAnchorPoint(ccp(0, 0))

	local var_8_2 = CCApplication:sharedApplication():getTargetPlatform()

	if arg_8_5 == nil then
		var_8_1:setFont(DefaultFontName, 26)
	else
		var_8_1:setFont(DefaultFontName, arg_8_5)
	end

	var_8_1:setFontName("font/FZY4JW--GB1-0.ttf")
	var_8_1:setPlaceholderFontName("font/FZY4JW--GB1-0.ttf")
	var_8_1:setFontSize(25)

	if arg_8_6 == nil then
		var_8_1:setFontColor(ccc3(163, 163, 163))
	else
		var_8_1:setFontColor(arg_8_6)
	end

	var_8_1:setPlaceHolder(arg_8_2)
	var_8_1:setPlaceholderFontColor(ccc3(163, 163, 163))
	var_8_1:setMaxLength(arg_8_3)
	var_8_1:setReturnType(kKeyboardReturnTypeDone)

	return var_8_1
end

function zbUtil.setButtonTitle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CCString:create(a2u(arg_9_2))

	arg_9_1:setTitleForState(var_9_0, CCControlStateNormal)
	arg_9_1:setTitleForState(var_9_0, CCControlStateHighlighted)
	arg_9_1:setTitleForState(var_9_0, CCControlStateDisabled)
	arg_9_1:setTitleForState(var_9_0, CCControlStateSelected)
end

function zbUtil.createProgressTimer(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = CCSprite:create(arg_10_2)

	var_10_0:setAnchorPoint(ccp(0, 0))

	local var_10_1 = CCProgressTimer:create(var_10_0)

	var_10_1:setAnchorPoint(ccp(0, 0))
	var_10_1:setPosition((arg_10_1:getContentSize().width - var_10_1:getContentSize().width) / 2, (arg_10_1:getContentSize().height - var_10_1:getContentSize().height) / 2)
	var_10_1:setPercentage(100)
	var_10_1:setMidpoint(ccp(0, 1))
	var_10_1:setBarChangeRate(ccp(1, 0))
	var_10_1:setType(kCCProgressTimerTypeBar)
	var_10_1:retain()
	arg_10_1:addChild(var_10_1)

	return var_10_1
end

function zbUtil.SprintfHHCh(arg_11_0, arg_11_1)
	local var_11_0 = string.split(arg_11_1, " ")
	local var_11_1 = string.split(var_11_0[2], ":")

	return (string.format("%02dʱ", var_11_1[1]))
end

function zbUtil.SprintfMMDDCh(arg_12_0, arg_12_1)
	local var_12_0 = string.split(arg_12_1, " ")
	local var_12_1 = string.split(var_12_0[1], "-")

	return (string.format("%02d\xD4\xC2%02d\xC8\xD5", var_12_1[2], var_12_1[3]))
end

function zbUtil.SprintfHHMM(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = math.floor(arg_13_1 + var_13_0 + 0.5)
	local var_13_2 = math.floor(var_13_1 / 3600) % 24
	local var_13_3 = math.floor(var_13_1 % 3600 / 60)
	local var_13_4 = math.floor(var_13_1 % 60)

	return (string.format("%02d:%02d", var_13_2, var_13_3))
end

function zbUtil.SprintfHHMMSS(arg_14_0, arg_14_1)
	local var_14_0 = math.floor(arg_14_1 + 0.5)
	local var_14_1 = math.floor(var_14_0 / 3600) % 24
	local var_14_2 = math.floor(var_14_0 % 3600 / 60)
	local var_14_3 = math.floor(var_14_0 % 60)

	return (string.format("%02d:%02d:%02d", var_14_1, var_14_2, var_14_3))
end

function zbUtil.SprintfMMSSHave60(arg_15_0, arg_15_1)
	local var_15_0 = math.floor(arg_15_1 + 0.5)
	local var_15_1 = math.floor(var_15_0 % 3600 / 60)
	local var_15_2 = math.floor(var_15_0 % 60)

	if arg_15_1 >= 3600 then
		var_15_1 = 60
		var_15_2 = 0
	end

	return (string.format("%02d:%02d", var_15_1, var_15_2))
end

function zbUtil.SprintfMMSS(arg_16_0, arg_16_1)
	local var_16_0 = math.floor(arg_16_1 + 0.5)
	local var_16_1 = math.floor(var_16_0 % 3600 / 60)
	local var_16_2 = math.floor(var_16_0 % 60)

	return (string.format("%02d:%02d", var_16_1, var_16_2))
end

function zbUtil.SprintfHHMMSSNo24(arg_17_0, arg_17_1)
	local var_17_0 = math.floor(arg_17_1 + 0.5)
	local var_17_1 = math.floor(var_17_0 / 3600)
	local var_17_2 = math.floor(var_17_0 % 3600 / 60)
	local var_17_3 = math.floor(var_17_0 % 60)

	return (string.format("%02d:%02d:%02d", var_17_1, var_17_2, var_17_3))
end

function zbUtil.SprintfYYYYMMDD(arg_18_0, arg_18_1)
	local var_18_0 = os.date("*t", arg_18_1)
	local var_18_1 = math.floor(arg_18_1 + 0.5)

	return (string.format("%04d-%02d-%02d", var_18_0.year, var_18_0.month, var_18_0.day))
end

function zbUtil.GetTimeByDate(arg_19_0, arg_19_1)
	local var_19_0 = string.split(arg_19_1, " ")
	local var_19_1 = string.split(var_19_0[1], "-")
	local var_19_2 = string.split(var_19_0[2], ":")

	return (os.time({
		year = var_19_1[1],
		month = var_19_1[2],
		day = var_19_1[3],
		hour = var_19_2[1],
		min = var_19_2[2],
		sec = var_19_2[3]
	}))
end

function zbUtil.getDateBySecond(arg_20_0, arg_20_1)
	local var_20_0 = os.date("*t", arg_20_1)

	return string.format("%04d/%02d/%02d", var_20_0.year, var_20_0.month, var_20_0.day)
end

function zbUtil.getNextRefreshTime(arg_21_0, arg_21_1)
	local var_21_0 = g_Self.kTimeHandler:getServerTime()
	local var_21_1 = os.date("*t", var_21_0)
	local var_21_2 = string.sub(arg_21_1, 1, 2)
	local var_21_3 = string.sub(arg_21_1, 4, 5)
	local var_21_4 = string.sub(arg_21_1, 7, 8)

	return (var_21_2 - var_21_1.hour) * 3600 + (var_21_3 - var_21_1.min) * 60 + var_21_4 - var_21_1.sec
end

function zbUtil.getPassTime(arg_22_0, arg_22_1)
	local var_22_0 = math.floor(arg_22_1)
	local var_22_1 = math.floor(var_22_0 / 3600)
	local var_22_2 = math.floor(var_22_0 % 3600 / 60)
	local var_22_3 = ""

	if var_22_1 > 72 then
		var_22_1 = 72
	end

	if var_22_1 >= 48 then
		var_22_3 = string.format("%d\xCC\xECǰ", math.floor(var_22_1 / 24))
	elseif var_22_1 >= 24 then
		var_22_3 = string.format("%d\xCC\xEC%dСʱǰ", math.floor(var_22_1 / 24), math.floor(var_22_1 % 24))
	elseif var_22_1 > 0 then
		var_22_3 = string.format("%dСʱ%d\xB7\xD6\xD6\xD3ǰ", math.floor(var_22_1 % 24), var_22_2)
	elseif var_22_2 > 0 then
		var_22_3 = string.format("%d\xB7\xD6\xD6\xD3ǰ", var_22_2)
	else
		var_22_3 = a2u("һ\xB7\xD6\xD6\xD3\xC4\xDA")
	end

	return a2u(var_22_3)
end

function zbUtil.getPassTimeShort(arg_23_0, arg_23_1)
	local var_23_0 = math.floor(arg_23_1)
	local var_23_1 = math.floor(var_23_0 / 3600)
	local var_23_2 = math.floor(var_23_0 % 3600 / 60)

	if var_23_1 > 72 then
		var_23_1 = 72
	end

	local var_23_3 = ""

	if var_23_1 >= 24 then
		var_23_3 = string.format("%d\xCC\xECǰ", math.floor(var_23_1 / 24))
	elseif var_23_1 > 0 then
		var_23_3 = string.format("%dСʱǰ", math.floor(var_23_1 % 24))
	elseif var_23_2 > 0 then
		var_23_3 = string.format("%d\xB7\xD6\xD6\xD3ǰ", var_23_2)
	else
		var_23_3 = a2u("һ\xB7\xD6\xD6\xD3\xC4\xDA")
	end

	return a2u(var_23_3)
end

function zbUtil.getPassTime2(arg_24_0, arg_24_1)
	local var_24_0 = math.floor(arg_24_1)
	local var_24_1 = math.floor(var_24_0 / 3600)
	local var_24_2 = math.floor(var_24_0 % 3600 / 60)
	local var_24_3 = ""

	if var_24_1 >= 24 then
		var_24_3 = string.format("%d\xCC\xEC%dʱ%d\xB7\xD6", math.floor(var_24_1 / 24), math.floor(var_24_1 % 24), var_24_2)
	elseif var_24_1 > 0 then
		var_24_3 = string.format("%dСʱ%d\xB7\xD6\xD6\xD3", math.floor(var_24_1 % 24), var_24_2)
	elseif var_24_2 > 0 then
		var_24_3 = string.format("%d\xB7\xD6\xD6\xD3", var_24_2)
	else
		var_24_3 = a2u(math.ceil(arg_24_1) .. "\xC3\xEB")
	end

	return a2u(var_24_3)
end

function zbUtil.getExpireTime(arg_25_0, arg_25_1)
	local var_25_0 = math.floor(arg_25_1)
	local var_25_1 = math.floor(var_25_0 / 3600)
	local var_25_2 = math.floor(var_25_0 % 3600 / 60)
	local var_25_3 = ""

	if var_25_1 >= 24 then
		var_25_3 = string.format("%d\xCC\xEC", math.floor(var_25_1 / 24))
	elseif var_25_1 > 0 then
		var_25_3 = string.format("%dСʱ", math.floor(var_25_1 % 24))
	elseif var_25_2 > 0 then
		var_25_3 = string.format("%d\xB7\xD6\xD6\xD3", var_25_2)
	else
		var_25_3 = a2u(math.ceil(arg_25_1) .. "\xC3\xEB")
	end

	return a2u(var_25_3)
end

function zbUtil.getNumberBig(arg_26_0, arg_26_1)
	local var_26_0 = {
		"һ",
		"\xB6\xFE",
		"\xC8\xFD",
		"\xCB\xC4",
		"\xCE\xE5",
		"\xC1\xF9",
		"\xC6\xDF",
		"\xB0\xCB",
		"\xBE\xC5",
		"ʮ"
	}
	local var_26_1 = arg_26_1
	local var_26_2 = ""

	while math.floor(var_26_1 / 10) > 0 do
		local var_26_3 = math.fmod(var_26_1, 10)

		if var_26_3 > 0 then
			var_26_2 = a2u(var_26_0[var_26_3]) .. var_26_2
		else
			var_26_2 = a2u("\xC1\xE3") .. var_26_2
		end

		var_26_1 = math.floor(var_26_1 / 10)
	end

	if var_26_1 > 0 then
		var_26_2 = a2u(var_26_0[var_26_1]) .. var_26_2
	else
		var_26_2 = a2u("\xC1\xE3") .. var_26_2
	end

	return var_26_2
end

function zbUtil.getWeekBig(arg_27_0, arg_27_1)
	local var_27_0 = {
		"һ",
		"\xB6\xFE",
		"\xC8\xFD",
		"\xCB\xC4",
		"\xCE\xE5",
		"\xC1\xF9",
		"\xC8\xD5"
	}

	if arg_27_1 > 0 then
		return a2u(var_27_0[arg_27_1])
	end

	return a2u("0")
end

function zbUtil.foramatCurrency(arg_28_0, arg_28_1)
	if string.find(arg_28_1, "/") then
		return arg_28_1
	end

	local var_28_0 = ""
	local var_28_1 = tostring(arg_28_1)
	local var_28_2 = string.len(var_28_1)
	local var_28_3 = var_28_2 % 3

	for iter_28_0 = 1, var_28_2 do
		if var_28_3 == 0 then
			if iter_28_0 > 1 then
				var_28_0 = var_28_0 .. ","
			end

			var_28_3 = 3
		end

		var_28_0 = var_28_0 .. string.byte(var_28_1, iter_28_0) - 48
		var_28_3 = var_28_3 - 1
	end

	return var_28_0
end

function zbUtil.formatABBNum(arg_29_0, arg_29_1)
	local var_29_0 = {
		";",
		"<",
		"=",
		">"
	}
	local var_29_1 = ""
	local var_29_2 = tostring(arg_29_1)

	if string.len(var_29_2) <= 3 then
		return var_29_2
	end

	local var_29_3 = zbUtil:foramatCurrency(arg_29_1)
	local var_29_4 = string.len(var_29_3)
	local var_29_5 = string.find(var_29_3, ",")
	local var_29_6 = string.gsub(var_29_3, ",", ".")
	local var_29_7 = 0
	local var_29_8 = 0

	for iter_29_0 = var_29_4, 1, -1 do
		local var_29_9 = string.char(string.byte(var_29_6, iter_29_0))

		if var_29_8 == 0 then
			if var_29_9 ~= "0" and var_29_9 ~= "." then
				var_29_8 = iter_29_0
				var_29_1 = var_29_9 .. var_29_1
			end

			if iter_29_0 == var_29_5 then
				var_29_8 = iter_29_0
			end
		elseif iter_29_0 == var_29_5 and var_29_5 < var_29_8 or var_29_9 ~= "." then
			var_29_1 = var_29_9 .. var_29_1
		end

		if var_29_9 == "." then
			var_29_7 = var_29_7 + 1
		end
	end

	if var_29_7 <= 4 and var_29_7 > 0 then
		var_29_1 = var_29_1 .. var_29_0[var_29_7]
	end

	return var_29_1
end

function zbUtil.clamp(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_3 < arg_30_1 then
		arg_30_1 = arg_30_3
	elseif arg_30_1 < arg_30_2 then
		arg_30_1 = arg_30_2
	end

	return arg_30_1
end

function zbUtil.getWordsCount(arg_31_0, arg_31_1)
	local var_31_0 = 0
	local var_31_1 = 1
	local var_31_2 = arg_31_1:len()

	while var_31_1 <= var_31_2 do
		local var_31_3 = 2

		var_31_1 = var_31_1 + (string.byte(arg_31_1, var_31_1) > 128 and 3 or 1)
		var_31_0 = var_31_0 + 1
	end

	return var_31_0
end

function zbUtil.setNormalSprite(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = CCSprite:create(arg_32_2)

	if arg_32_3 ~= nil and arg_32_3 ~= "" then
		var_32_0:setMaskTexture(CCTextureCache:sharedTextureCache():addImage(arg_32_3))
	end

	arg_32_1:setPSNormalSprite(var_32_0)
end

function zbUtil.setHighlightSprite(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = CCSprite:create(arg_33_2)

	var_33_0:usePSLevels(true)

	if arg_33_3 ~= nil and arg_33_3 ~= "" then
		var_33_0:setMaskTexture(CCTextureCache:sharedTextureCache():addImage(arg_33_3))
	end

	arg_33_1:setPSLevelSprite(var_33_0)
end

function zbUtil.setDisableSprite(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = CCSprite:create(arg_34_2)

	var_34_0:setGray(true)

	if arg_34_3 ~= nil and arg_34_3 ~= "" then
		var_34_0:setMaskTexture(CCTextureCache:sharedTextureCache():addImage(arg_34_3))
	end

	arg_34_1:setPSGraySprite(var_34_0)
end

function zbUtil.setTableViewOffset(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6, arg_35_7)
	if arg_35_7 < arg_35_4 or arg_35_5 < arg_35_7 then
		return
	end

	local var_35_0 = 0
	local var_35_1 = 0

	if arg_35_2 == kCCScrollViewDirectionVertical then
		if arg_35_3 == kCCTableViewFillTopDown then
			var_35_1 = -arg_35_6 * (arg_35_5 - arg_35_7 - 1)
		else
			var_35_1 = -arg_35_6 * arg_35_7 - 1
		end
	elseif arg_35_3 == kCCTableViewFillTopDown then
		var_35_0 = -arg_35_6 * (arg_35_5 - arg_35_7)
	else
		var_35_0 = -arg_35_6 * arg_35_7
	end

	arg_35_1:setContentOffset(ccp(var_35_0, var_35_1))
end

function wzSerialize(arg_36_0)
	local var_36_0 = ""
	local var_36_1 = type(arg_36_0)

	if var_36_1 == "number" then
		var_36_0 = var_36_0 .. arg_36_0
	elseif var_36_1 == "boolean" then
		var_36_0 = var_36_0 .. tostring(arg_36_0)
	elseif var_36_1 == "string" then
		var_36_0 = var_36_0 .. string.format("%q", arg_36_0)
	elseif var_36_1 == "table" then
		var_36_0 = var_36_0 .. "{\n"

		for iter_36_0, iter_36_1 in pairs(arg_36_0) do
			var_36_0 = var_36_0 .. "[" .. wzSerialize(iter_36_0) .. "]=" .. wzSerialize(iter_36_1) .. ",\n"
		end

		local var_36_2 = getmetatable(arg_36_0)

		if var_36_2 ~= nil and type(var_36_2.__index) == "table" then
			for iter_36_2, iter_36_3 in pairs(var_36_2.__index) do
				var_36_0 = var_36_0 .. "[" .. wzSerialize(iter_36_2) .. "]=" .. wzSerialize(iter_36_3) .. ",\n"
			end
		end

		var_36_0 = var_36_0 .. "}"
	elseif var_36_1 == "nil" then
		return nil
	else
		error("can not wzSerialize a " .. var_36_1 .. " type.")
	end

	return var_36_0
end

local var_0_1 = {}

function wzUnserialize(arg_37_0)
	if arg_37_0 == nil or arg_37_0 == "nil" then
		return nil
	elseif type(arg_37_0) ~= "string" then
		var_0_1 = {}

		return var_0_1
	elseif #arg_37_0 == 0 then
		var_0_1 = {}

		return var_0_1
	end

	local var_37_0, var_37_1 = pcall(loadstring(string.format("do local _=%s return _ end", arg_37_0)))

	if var_37_0 then
		return var_37_1
	else
		var_0_1 = {}

		return var_0_1
	end
end

function zbUtil.parseStr2Table(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = string.gsub(arg_38_1, "%[", "{")
	local var_38_2 = string.gsub(var_38_1, "%]", "}")

	return (wzUnserialize(var_38_2))
end

math.randomseed(os_timenow())

function zbUtil.random(arg_39_0, arg_39_1, arg_39_2)
	we_rand = math.random(arg_39_1, arg_39_2)

	return we_rand
end

function cclog(...)
	print(string.format(...))
end

function zbUtil.getRichColorString(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= nil and arg_41_1 ~= "" and arg_41_2 ~= nil then
		return a2u("[color=") .. arg_41_2 .. "]" .. arg_41_1 .. a2u("[/color]")
	end

	return ""
end

function zbUtil.isValidNameWith_1to9And_AtoZ(arg_42_0, arg_42_1)
	local var_42_0 = ""

	for iter_42_0 in string.gmatch(arg_42_1, "[%w_]") do
		var_42_0 = var_42_0 .. iter_42_0
	end

	return string.len(arg_42_1) == string.len(var_42_0), var_42_0
end

function zbUtil.isValidNameWith_0to9(arg_43_0, arg_43_1)
	local var_43_0 = ""

	for iter_43_0 in string.gmatch(arg_43_1, "[%d_]") do
		var_43_0 = var_43_0 .. iter_43_0
	end

	return string.len(arg_43_1) == string.len(var_43_0), var_43_0
end

function zbUtil.getRandomIndex(arg_44_0, arg_44_1, arg_44_2)
	arg_44_2 = arg_44_2 or arg_44_1

	local var_44_0 = {}
	local var_44_1 = {}

	for iter_44_0 = 1, arg_44_2 do
		local var_44_2 = math.random(1, arg_44_1 + 1 - iter_44_0)
		local var_44_3 = var_44_2

		for iter_44_1 = 1, arg_44_1 do
			if not var_44_0[iter_44_1] then
				var_44_2 = var_44_2 - 1

				if var_44_2 == 0 then
					table.insert(var_44_1, iter_44_1)

					var_44_0[iter_44_1] = true
				end
			end
		end
	end

	return var_44_1
end

function zbUtil.Split(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if string.find(arg_45_1, arg_45_2) == nil then
		return {
			arg_45_1
		}
	end

	if arg_45_3 == nil or arg_45_3 < 1 then
		arg_45_3 = 0
	end

	local var_45_0 = {}
	local var_45_1 = "(.-)" .. arg_45_2 .. "()"
	local var_45_2 = 0
	local var_45_3

	for iter_45_0, iter_45_1 in string.gfind(arg_45_1, var_45_1) do
		var_45_2 = var_45_2 + 1
		var_45_0[var_45_2] = iter_45_0
		var_45_3 = iter_45_1

		if var_45_2 == arg_45_3 then
			break
		end
	end

	if var_45_2 ~= arg_45_3 then
		var_45_0[var_45_2 + 1] = string.sub(arg_45_1, var_45_3)
	end

	return var_45_0
end

function zbUtil.distSq(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	return (arg_46_1 - arg_46_3) * (arg_46_1 - arg_46_3) + (arg_46_2 - arg_46_4) * (arg_46_2 - arg_46_4)
end

function zbUtil.isValidTable(arg_47_0, arg_47_1)
	return arg_47_1 ~= nil and type(arg_47_1) == "table"
end

function zbUtil.isEqualFloat(arg_48_0, arg_48_1, arg_48_2)
	return arg_48_1 > arg_48_2 - 0.001 and arg_48_1 < arg_48_2 - 0.001
end

function zbUtil.getCenterPosOn2Point(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = ccp(0, 0)
	local var_49_1 = 0
	local var_49_2 = 0

	if arg_49_2.x > arg_49_1.x then
		var_49_1 = arg_49_1.x + (arg_49_2.x - arg_49_1.x) / 2
	else
		var_49_1 = arg_49_2.x + (arg_49_1.x - arg_49_2.x) / 2
	end

	if arg_49_2.y > arg_49_1.y then
		var_49_2 = arg_49_1.y + (arg_49_2.y - arg_49_1.y) / 2
	else
		var_49_2 = arg_49_2.y + (arg_49_1.y - arg_49_2.y) / 2
	end

	return (ccp(var_49_1, var_49_2))
end

function zbUtil.setBtnEnable(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_2 then
		arg_50_1:setGray(false)
		arg_50_1:setEnabled(true)
	else
		arg_50_1:setGray(true)
		arg_50_1:setEnabled(false)
	end
end

function zbUtil.setCascadeOpacityEnabled(arg_51_0, arg_51_1, arg_51_2)
	arg_51_1:setCascadeOpacityEnabled(arg_51_2)

	local var_51_0 = arg_51_1:getChildren()
	local var_51_1 = arg_51_1:getChildrenCount()

	for iter_51_0 = 1, var_51_1 do
		local var_51_2 = tolua.cast(var_51_0:objectAtIndex(iter_51_0 - 1), "CCNode")

		if var_51_2 ~= nil then
			var_51_2:setCascadeOpacityEnabled(arg_51_2)
			zbUtil:setCascadeOpacityEnabled(var_51_2, arg_51_2)
		end
	end
end

function zbUtil.isValidText(arg_52_0, arg_52_1)
	if string.match(arg_52_1, "'") or string.match(arg_52_1, "\"") or string.match(arg_52_1, "\\") then
		return false
	end

	local var_52_0 = string.lower(arg_52_1)
	local var_52_1 = true
	local var_52_2 = require("config.sensitive.lua")

	for iter_52_0 = 1, table.getn(var_52_2) do
		local var_52_3 = string.match(var_52_0, var_52_2[iter_52_0])

		if var_52_3 ~= nil and var_52_3 == string.lower(var_52_2[iter_52_0]) then
			var_52_1 = false
		end
	end

	return var_52_1
end

function zbUtil.repValidText(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1
	local var_53_1 = string.lower(var_53_0)
	local var_53_2 = require("config.sensitive.lua")

	for iter_53_0 = 1, table.getn(var_53_2) do
		local var_53_3 = string.match(var_53_1, var_53_2[iter_53_0])

		if var_53_3 ~= nil and var_53_3 == string.lower(var_53_2[iter_53_0]) then
			local var_53_4 = 2

			var_53_0 = string.gsub(var_53_0, var_53_3, string.rep("*", var_53_4))
		end
	end

	return var_53_0
end

local var_0_2 = "85af3ddb1d4c9c1c57f122b1544e1f3e"

function zbUtil.fightResultReqSign(arg_54_0, arg_54_1)
	if type(arg_54_1) ~= "table" then
		return ""
	end

	local function var_54_0(arg_55_0)
		local var_55_0 = ""

		if type(arg_55_0) == "table" then
			for iter_55_0, iter_55_1 in pairs(arg_55_0) do
				local var_55_1 = ""

				if var_55_0 ~= "" then
					var_55_1 = ","
				end

				if type(iter_55_1) == "table" then
					var_55_0 = var_55_0 .. var_55_1 .. var_54_0(iter_55_1)
				else
					var_55_0 = var_55_0 .. var_55_1 .. iter_55_1
				end
			end
		else
			var_55_0 = var_55_0 .. arg_55_0
		end

		return var_55_0
	end

	local var_54_1 = {}

	for iter_54_0, iter_54_1 in pairs(arg_54_1) do
		table.insert(var_54_1, iter_54_0)
	end

	table.sort(var_54_1)

	local var_54_2 = ""

	for iter_54_2, iter_54_3 in pairs(var_54_1) do
		local var_54_3 = var_54_0(arg_54_1[iter_54_3])

		var_54_2 = var_54_2 .. iter_54_3 .. ":" .. var_54_3 .. ";"
	end

	local var_54_4 = var_54_2 .. var_0_2

	return (zbGlobalUtil:getMd5(var_54_4, true))
end

function zbUtil.fightReqAckSign(arg_56_0, arg_56_1)
	if arg_56_1 == nil then
		return ""
	end

	local function var_56_0(arg_57_0, arg_57_1)
		if arg_57_0 and zbUtil:isValidTable(arg_57_0.BattleGod) then
			table.insert(arg_57_1, arg_57_0.BattleGod.Level)
			table.insert(arg_57_1, arg_57_0.BattleGod.Energy)
			table.insert(arg_57_1, arg_57_0.BattleGod.Power)
		end

		if arg_57_0 and zbUtil:isValidTable(arg_57_0.HeroList) then
			for iter_57_0, iter_57_1 in pairs(arg_57_0.HeroList) do
				for iter_57_2 = 1, EAttrType.MaxNum do
					local var_57_0 = iter_57_1.HeroAttr[iter_57_2][3]

					table.insert(arg_57_1, var_57_0)
				end
			end
		end
	end

	local var_56_1 = {}

	for iter_56_0, iter_56_1 in pairs(arg_56_1.SelfFormation) do
		var_56_0(iter_56_1, var_56_1)
	end

	for iter_56_2, iter_56_3 in pairs(arg_56_1.EnemyFormation) do
		var_56_0(iter_56_3, var_56_1)
	end

	local var_56_2 = table.concat(var_56_1, ":") .. ":" .. var_0_2

	return (zbGlobalUtil:getMd5(var_56_2, true))
end

function zbUtil.getGuidePos(arg_58_0, arg_58_1)
	if arg_58_1 == nil then
		return ccp(0, 0)
	end

	local var_58_0 = arg_58_1
	local var_58_1 = 0
	local var_58_2 = 0

	while var_58_0 ~= nil do
		if var_58_0.isWindow ~= nil and var_58_0.isWindow == true then
			var_58_1 = var_58_0:getPositionX()
			var_58_2 = var_58_0:getPositionY()
		end

		var_58_0 = var_58_0:getParent()
	end

	local var_58_3 = arg_58_1:getParent():convertToWorldSpace(ccp(arg_58_1:getPosition()))

	var_58_3.x = var_58_3.x - var_58_1
	var_58_3.y = var_58_3.y - var_58_2

	return var_58_3
end
