local var_0_0 = "ui/face/"

CCRichLabelTTF = class("CCRichLabelTTF", function()
	return CCSprite:create()
end)
CCRichLabelTTF.__index = CCRichLabelTTF

function CCRichLabelTTF.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = CCRichLabelTTF.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)

	return var_2_0
end

function CreateRichLabelTTF(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = CCRichLabelTTF.new()

	var_3_0:init(arg_3_0 + 40, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	return var_3_0
end

function CCRichLabelTTF.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.mWidth = arg_4_1
	arg_4_0.mHeight = arg_4_2
	arg_4_0.defaultColor = arg_4_5 or ccc3(255, 255, 255)
	arg_4_0.mFontSize = arg_4_3 or 24
	arg_4_0.mFontName = arg_4_4 or DefaultFontName
	arg_4_0.mPoint = ccp(0, arg_4_0.mHeight)
	arg_4_0.mLineHeight = 0

	arg_4_0:setContentSize(CCSizeMake(arg_4_1, arg_4_2))
	arg_4_0:setCascadeOpacityEnabled(true)

	if arg_4_6 == nil then
		arg_4_6 = true
	end

	arg_4_0.mHasEdges = arg_4_6
end

local var_0_1 = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	18,
	13,
	18,
	18,
	18,
	18,
	18,
	17,
	18,
	18,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	19,
	18,
	19,
	20,
	15,
	15,
	21,
	21,
	10,
	14,
	19,
	14,
	25,
	20,
	21,
	17,
	21,
	17,
	17,
	15,
	20,
	18,
	26,
	19,
	17,
	18,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	18,
	18,
	15,
	18,
	17,
	11,
	18,
	17,
	9,
	9,
	16,
	9,
	24,
	17,
	17,
	18,
	18,
	12,
	14,
	11,
	17,
	15,
	16,
	16,
	16,
	16
}

function CCRichLabelTTF._addString(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 1
	local var_5_1 = arg_5_0.mFontSize
	local var_5_2 = arg_5_0.mFontSize
	local var_5_3 = arg_5_0.mPoint

	while var_5_0 <= arg_5_1:len() do
		local var_5_4 = 2
		local var_5_5 = string.byte(arg_5_1, var_5_0)

		if var_5_5 > 128 then
			var_5_4 = 3
			var_5_2 = var_5_1
		else
			var_5_4 = 1

			if var_0_1[var_5_5] ~= nil then
				var_5_2 = var_5_1 * var_0_1[var_5_5] / 30
			else
				var_5_2 = var_5_1 * 0.5
			end
		end

		local var_5_6 = CCLabelTTF:create(arg_5_1:sub(var_5_0, var_5_0 + var_5_4 - 1), arg_5_2, var_5_1)

		var_5_6:setAnchorPoint(ccp(0, 1))

		if arg_5_0.mHasEdges == true then
			var_5_6:setColor(ccc3(0, 0, 0))
			var_5_6:setPosition(var_5_3.x - 1, var_5_3.y)
			var_5_6:visit()
			var_5_6:setPosition(var_5_3.x, var_5_3.y - 1)
			var_5_6:visit()
			var_5_6:setPosition(var_5_3.x + 1, var_5_3.y)
			var_5_6:visit()
			var_5_6:setPosition(var_5_3.x, var_5_3.y + 1)
			var_5_6:visit()
		end

		var_5_6:setColor(arg_5_3)
		var_5_6:setPosition(var_5_3)
		var_5_6:visit()

		var_5_0 = var_5_0 + var_5_4
		var_5_3.x = var_5_3.x + var_5_2

		if var_5_1 > arg_5_0.mLineHeight then
			arg_5_0.mLineHeight = var_5_1
		end

		if var_5_3.x > arg_5_0.mWidth - var_5_2 then
			var_5_3.x = 0
			var_5_3.y = var_5_3.y - arg_5_0.mLineHeight
			arg_5_0.mLineHeight = 0
		end
	end

	arg_5_0.mPoint = var_5_3
end

function CCRichLabelTTF._addFace(arg_6_0, arg_6_1)
	local var_6_0 = CCSprite:create(arg_6_1)
	local var_6_1 = 1
	local var_6_2 = arg_6_0.fontSize
	local var_6_3 = var_6_0:getContentSize().width
	local var_6_4 = var_6_0:getContentSize().height
	local var_6_5 = arg_6_0.mPoint

	if var_6_5.x > arg_6_0.mWidth - var_6_3 then
		var_6_5.x = 0
		var_6_5.y = var_6_5.y - arg_6_0.mLineHeight
	end

	if var_6_4 > arg_6_0.mLineHeight then
		arg_6_0.mLineHeight = var_6_4
	end

	var_6_0:setAnchorPoint(ccp(0, 1))

	local var_6_6, var_6_7 = arg_6_0.mFontSize / var_6_0:getContentSize().width, arg_6_0.mFontSize / var_6_0:getContentSize().height

	if var_6_6 < var_6_7 then
		var_6_6 = var_6_7
	end

	var_6_0:setScaleX(var_6_6)
	var_6_0:setScaleY(var_6_6)
	var_6_0:setPosition(var_6_5)
	var_6_0:visit()

	var_6_5.x = var_6_5.x + var_6_3
	arg_6_0.mPoint = var_6_5
end

function CCRichLabelTTF.setRichString(arg_7_0, arg_7_1)
	arg_7_0.renderTexture = CCRenderTexture:create(arg_7_0.mWidth, arg_7_0.mHeight)

	arg_7_0.renderTexture:setAnchorPoint(ccp(0, 0))
	arg_7_0.renderTexture:getSprite():setAnchorPoint(ccp(0, 1))
	arg_7_0.renderTexture:getSprite():setCascadeOpacityEnabled(true)
	arg_7_0.renderTexture:getSprite():setPosition(arg_7_0.mWidth / 2, arg_7_0.mHeight / 2)
	arg_7_0.renderTexture:setPosition(arg_7_0.mWidth / 2, arg_7_0.mHeight / 2)

	arg_7_0.mLineHeight = 0

	local var_7_0 = arg_7_0:parseString(arg_7_1)

	arg_7_0.renderTexture:begin()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0]

		if var_7_1.type == "string" then
			local var_7_2 = var_7_0[iter_7_0].color
			local var_7_3 = arg_7_0.defaultColor

			if var_7_2 ~= "default" then
				local var_7_4 = tonumber(var_7_2)
				local var_7_5 = var_7_4 / 65536
				local var_7_6 = var_7_4 % 65536 / 256
				local var_7_7 = var_7_4 % 256

				var_7_3 = ccc3(math.floor(var_7_5), math.floor(var_7_6), math.floor(var_7_7))
			end

			arg_7_0:_addString(var_7_0[iter_7_0].string, arg_7_0.mFontName, var_7_3)
		elseif var_7_1.type == "face" then
			local var_7_8 = var_0_0 .. var_7_1.icon .. ".png"

			arg_7_0:_addFace(var_7_8)
		end
	end

	arg_7_0.renderTexture:endToLua()

	local var_7_9 = arg_7_0.renderTexture:getSprite()

	var_7_9:getTexture():setAntiAliasTexParameters()
	var_7_9:removeFromParentAndCleanup(false)
	arg_7_0:addChild(var_7_9)
	arg_7_0:setDirty(true)
end

function CCRichLabelTTF.setRichStringBegin(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1 = arg_8_0:parseString(arg_8_1)

	for iter_8_0 = 1, #var_8_1 do
		local var_8_2 = var_8_1[iter_8_0]

		if var_8_2.type == "string" then
			var_8_0 = var_8_0 + arg_8_0:_calStringLength(var_8_1[iter_8_0].string)
		elseif var_8_2.type == "face" then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_1, var_8_0
end

function CCRichLabelTTF._calStringLength(arg_9_0, arg_9_1)
	local var_9_0 = 1
	local var_9_1 = 0

	while var_9_0 <= arg_9_1:len() do
		local var_9_2 = 2

		var_9_0 = var_9_0 + (string.byte(arg_9_1, var_9_0) > 128 and 3 or 1)
		var_9_1 = var_9_1 + 1
	end

	return var_9_1
end

function CCRichLabelTTF.setRichStringPrinter(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.mLineHeight = 0
	arg_10_0.renderTexture = CCRenderTexture:create(arg_10_0.mWidth, arg_10_0.mHeight)

	arg_10_0.renderTexture:setAnchorPoint(ccp(0, 0))
	arg_10_0.renderTexture:getSprite():setAnchorPoint(ccp(0, 1))
	arg_10_0.renderTexture:getSprite():setCascadeOpacityEnabled(true)
	arg_10_0.renderTexture:getSprite():setPosition(arg_10_0.mWidth / 2, arg_10_0.mHeight / 2)
	arg_10_0.renderTexture:setPosition(arg_10_0.mWidth / 2, arg_10_0.mHeight / 2)
	arg_10_0.renderTexture:newCCImage()

	local var_10_0 = 0

	arg_10_0.renderTexture:begin()

	for iter_10_0 = 1, #arg_10_1 do
		local var_10_1 = arg_10_1[iter_10_0]

		if var_10_1.type == "string" then
			local var_10_2 = arg_10_1[iter_10_0].color
			local var_10_3 = arg_10_0.defaultColor

			if var_10_2 ~= "default" then
				local var_10_4 = tonumber(var_10_2)
				local var_10_5 = var_10_4 / 65536
				local var_10_6 = var_10_4 % 65536 / 256
				local var_10_7 = var_10_4 % 256

				var_10_3 = ccc3(math.floor(var_10_5), math.floor(var_10_6), math.floor(var_10_7))
			end

			local var_10_8 = arg_10_1[iter_10_0].string

			if arg_10_2 > var_10_0 + arg_10_0:_calStringLength(var_10_8) then
				var_10_0 = var_10_0 + arg_10_0:_calStringLength(var_10_8)
			else
				arg_10_0:_addStringPrinter(arg_10_1[iter_10_0].string, arg_10_0.mFontName, var_10_3, arg_10_2 - var_10_0)

				break
			end
		elseif var_10_1.type == "face" then
			local var_10_9 = var_0_0 .. var_10_1.icon .. ".png"

			arg_10_0:_addFace(var_10_9)

			var_10_0 = var_10_0 + 1

			if arg_10_2 <= var_10_0 then
				break
			end
		end
	end

	arg_10_0.renderTexture:endToLua()

	local var_10_10 = arg_10_0.renderTexture:getSprite()

	var_10_10:getTexture():setAntiAliasTexParameters()
	var_10_10:removeFromParentAndCleanup(false)
	arg_10_0:addChild(var_10_10)
	arg_10_0:setDirty(true)
end

function CCRichLabelTTF._addStringPrinter(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = 1
	local var_11_1 = 0
	local var_11_2 = arg_11_0.mFontSize
	local var_11_3 = arg_11_0.mFontSize
	local var_11_4 = arg_11_0.mPoint

	while var_11_0 <= arg_11_1:len() do
		local var_11_5 = 2
		local var_11_6 = string.byte(arg_11_1, var_11_0)

		if var_11_6 > 128 then
			var_11_5 = 3
			var_11_3 = var_11_2
		else
			var_11_5 = 1

			if var_0_1[var_11_6] ~= nil then
				var_11_3 = var_11_2 * var_0_1[var_11_6] / 30
			else
				var_11_3 = var_11_2 * 0.5
			end
		end

		var_11_1 = var_11_1 + 1

		if arg_11_4 == var_11_1 then
			local var_11_7 = CCLabelTTF:create(arg_11_1:sub(var_11_0, var_11_0 + var_11_5 - 1), arg_11_2, var_11_2)

			var_11_7:setAnchorPoint(ccp(0, 1))
			var_11_7:setColor(arg_11_3)
			var_11_7:setPosition(var_11_4)
			var_11_7:visit()

			var_11_4.x = var_11_4.x + var_11_3

			if var_11_2 > arg_11_0.mLineHeight then
				arg_11_0.mLineHeight = var_11_2
			end

			if var_11_4.x > arg_11_0.mWidth - var_11_3 then
				var_11_4.x = 0
				var_11_4.y = var_11_4.y - arg_11_0.mLineHeight
				arg_11_0.mLineHeight = 0
			end
		end

		var_11_0 = var_11_0 + var_11_5

		if arg_11_4 < var_11_1 then
			break
		end
	end

	arg_11_0.mPoint = var_11_4
end

function CCRichLabelTTF.parseString(arg_12_0, arg_12_1)
	local function var_12_0(arg_13_0)
		local var_13_0 = {}
		local var_13_1 = arg_13_0:sub(1, arg_13_0:len())

		if string.find(var_13_1, "%[face=[%d]+%]") == nil then
			local var_13_2 = {}

			var_13_2.strType = "string"
			var_13_2.string = var_13_1
			var_13_0[#var_13_0 + 1] = var_13_2

			return var_13_0
		end

		while string.find(var_13_1, "%[face=[%d]+%]") ~= nil do
			local var_13_3, var_13_4 = string.find(var_13_1, "%[face=[%d]+%]")

			if var_13_3 ~= 1 then
				local var_13_5 = {}

				var_13_5.strType = "string"
				var_13_5.string = var_13_1:sub(1, var_13_3 - 1)
				var_13_0[#var_13_0 + 1] = var_13_5
			end

			local var_13_6 = var_13_1:sub(var_13_3, var_13_4)
			local var_13_7 = {}

			var_13_7.strType = "face"
			var_13_7.icon = var_13_6:sub(7, var_13_6:len() - 1)
			var_13_0[#var_13_0 + 1] = var_13_7
			var_13_1 = var_13_1:sub(var_13_4 + 1, var_13_1:len())
		end

		if var_13_1 ~= nil and var_13_1:len() ~= 0 then
			local var_13_8 = {}

			var_13_8.strType = "string"
			var_13_8.string = var_13_1
			var_13_0[#var_13_0 + 1] = var_13_8
		end

		return var_13_0
	end

	local var_12_1 = {}
	local var_12_2 = 1
	local var_12_3 = arg_12_1:sub(var_12_2, arg_12_1:len())
	local var_12_4, var_12_5 = string.find(var_12_3, "%[color=0x[%a%d]+%]")

	if var_12_4 == 0 or var_12_4 == nil then
		local var_12_6 = var_12_0(var_12_3)

		for iter_12_0 = 1, #var_12_6 do
			local var_12_7 = var_12_6[iter_12_0]

			if var_12_7.strType == "string" then
				local var_12_8 = {}

				var_12_8.type = "string"
				var_12_8.string = var_12_7.string
				var_12_8.color = "default"
				var_12_1[#var_12_1 + 1] = var_12_8
			else
				local var_12_9 = {}

				var_12_9.type = "face"
				var_12_9.icon = var_12_7.icon
				var_12_1[#var_12_1 + 1] = var_12_9
			end
		end
	end

	repeat
		if var_12_4 ~= 0 and var_12_4 ~= nil then
			local var_12_10 = var_12_3:sub(0, var_12_4 - 1)
			local var_12_11 = "default"
			local var_12_12 = var_12_0(var_12_10)

			for iter_12_1 = 1, #var_12_12 do
				local var_12_13 = var_12_12[iter_12_1]

				if var_12_13.strType == "string" then
					local var_12_14 = {}

					var_12_14.type = "string"
					var_12_14.string = var_12_13.string
					var_12_14.color = var_12_11
					var_12_1[#var_12_1 + 1] = var_12_14
				else
					local var_12_15 = {}

					var_12_15.type = "face"
					var_12_15.icon = var_12_13.icon
					var_12_1[#var_12_1 + 1] = var_12_15
				end
			end
		else
			break
		end

		local var_12_16
		local var_12_17
		local var_12_18, var_12_19 = string.find(var_12_3, "%[/color%]")
		local var_12_20 = var_12_3:sub(var_12_5 + 1, var_12_18 - 1)
		local var_12_21 = var_12_3:sub(var_12_4, var_12_5)
		local var_12_22 = var_12_21:sub(8, var_12_21:len() - 1)
		local var_12_23 = var_12_0(var_12_20)

		for iter_12_2 = 1, #var_12_23 do
			local var_12_24 = var_12_23[iter_12_2]

			if var_12_24.strType == "string" then
				local var_12_25 = {}

				var_12_25.type = "string"
				var_12_25.string = var_12_24.string
				var_12_25.color = var_12_22
				var_12_1[#var_12_1 + 1] = var_12_25
			else
				local var_12_26 = {}

				var_12_26.type = "face"
				var_12_26.icon = var_12_24.icon
				var_12_1[#var_12_1 + 1] = var_12_26
			end
		end

		var_12_3 = var_12_3:sub(var_12_19 + 1, var_12_3:len())
		var_12_4, var_12_5 = string.find(var_12_3, "%[color=0x[%a%d]+%]")

		if var_12_4 == nil then
			local var_12_27 = var_12_3
			local var_12_28 = "default"
			local var_12_29 = var_12_0(var_12_27)

			for iter_12_3 = 1, #var_12_29 do
				local var_12_30 = var_12_29[iter_12_3]

				if var_12_30.strType == "string" then
					local var_12_31 = {}

					var_12_31.type = "string"
					var_12_31.string = var_12_30.string
					var_12_31.color = var_12_28
					var_12_1[#var_12_1 + 1] = var_12_31
				else
					local var_12_32 = {}

					var_12_32.type = "face"
					var_12_32.icon = var_12_30.icon
					var_12_1[#var_12_1 + 1] = var_12_32
				end
			end

			break
		end
	until var_12_3 == nil or var_12_3:len() == 0

	return var_12_1
end
