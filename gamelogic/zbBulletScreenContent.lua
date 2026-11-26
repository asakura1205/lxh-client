require("gamelogic.zbBulletScreenItem")

local var_0_0 = class("zbBulletScreenContent", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = 3

function createBulletScreenContent(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

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

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.index = arg_3_1
	arg_3_0.bulletOver = 1
	arg_3_0.stringNum = 1
	arg_3_0.spriteNum = 1
	arg_3_0.width = 0
	arg_3_0.lbString = {}
	arg_3_0.spriteArray = {}
end

function var_0_0.refresh(arg_4_0, arg_4_1)
	arg_4_0.barrage = arg_4_1

	for iter_4_0, iter_4_1 in pairs(arg_4_0.lbString) do
		iter_4_1:setString("")
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.spriteArray) do
		iter_4_3:setVisible(false)
	end

	arg_4_0:setVisible(true)

	arg_4_0.bulletOver = 0
	arg_4_0.width = 0
	arg_4_0.stringNum = 1
	arg_4_0.spriteNum = 1

	arg_4_0:filtface(arg_4_1)
end

function var_0_0._addString(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.lbString[arg_5_0.stringNum]

	if var_5_0 == nil then
		arg_5_0.lbString[arg_5_0.stringNum] = CCLabelTTF:create(a2u(arg_5_1), DefaultFontName, 26)

		ui:setTTFStroke(arg_5_0.lbString[arg_5_0.stringNum])
		arg_5_0.lbString[arg_5_0.stringNum]:setAnchorPoint(ccp(0, 0.5))
		arg_5_0:addChild(arg_5_0.lbString[arg_5_0.stringNum])

		var_5_0 = arg_5_0.lbString[arg_5_0.stringNum]
	else
		var_5_0:setString(a2u(arg_5_1))
	end

	var_5_0:setPosition(arg_5_0.width, 0)

	if arg_5_0.barrage.FontColor == EBarrageFontColorType.White then
		arg_5_0.lbString[arg_5_0.stringNum]:setColor(FONT_COLOR_WHITE)
	elseif arg_5_0.barrage.FontColor == EBarrageFontColorType.Red then
		arg_5_0.lbString[arg_5_0.stringNum]:setColor(FONT_COLOR_RED)
	else
		arg_5_0.lbString[arg_5_0.stringNum]:setColor(FONT_COLOR_GREEN)
	end

	local var_5_1 = var_5_0:getContentSize()

	arg_5_0.width = arg_5_0.width + var_5_1.width - 2
	arg_5_0.stringNum = arg_5_0.stringNum + 1
end

function var_0_0._addFace(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 .. ".png"

	arg_6_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_6_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/face.plist")

	local var_6_1 = arg_6_0.spriteframeCache:spriteFrameByName(var_6_0)

	if var_6_1 then
		if arg_6_0.spriteArray[arg_6_0.spriteNum] == nil then
			arg_6_0.spriteArray[arg_6_0.spriteNum] = CCSprite:createWithSpriteFrame(var_6_1)

			arg_6_0:addChild(arg_6_0.spriteArray[arg_6_0.spriteNum])
			arg_6_0.spriteArray[arg_6_0.spriteNum]:setScale(0.6)
		else
			arg_6_0.spriteArray[arg_6_0.spriteNum]:initWithSpriteFrame(var_6_1)
			arg_6_0.spriteArray[arg_6_0.spriteNum]:setVisible(true)
		end

		arg_6_0.spriteArray[arg_6_0.spriteNum]:setAnchorPoint(ccp(0, 0.5))

		local var_6_2 = arg_6_0.spriteArray[arg_6_0.spriteNum]:getContentSize()

		arg_6_0.spriteArray[arg_6_0.spriteNum]:setPosition(arg_6_0.width, 0)

		arg_6_0.width = arg_6_0.width + var_6_2.width / 2
		arg_6_0.spriteNum = arg_6_0.spriteNum + 1
	end
end

function var_0_0.filtface(arg_7_0, arg_7_1)
	if type(arg_7_1.SMsg) ~= "string" then
		return
	end

	local var_7_0 = a2u(arg_7_1.SMsg)
	local var_7_1 = 0

	while 1 == 1 do
		local var_7_2, var_7_3 = string.find(var_7_0, "%[%d%d%]")

		if var_7_2 ~= nil and var_7_3 ~= nil then
			local var_7_4 = string.sub(var_7_0, 1, var_7_2 - 1)
			local var_7_5 = string.sub(var_7_0, var_7_2 + 1, var_7_3 - 1)

			var_7_0 = string.sub(var_7_0, var_7_3 + 1)

			if var_7_4 ~= "" then
				arg_7_0:_addString(var_7_4)
			end

			if tonumber(var_7_5) > 24 then
				arg_7_0:_addString("[" .. var_7_5 .. "]")
			else
				arg_7_0:_addFace(var_7_5)
			end
		else
			local var_7_6 = string.sub(var_7_0, 1)

			arg_7_0:_addString(var_7_6)

			break
		end
	end
end

function var_0_0.actionOver(arg_8_0)
	arg_8_0:setVisible(false)

	arg_8_0.bulletOver = 1
end

function var_0_0.isOver(arg_9_0)
	if arg_9_0.bulletOver == 1 then
		return true
	else
		return false
	end
end

function var_0_0.setOver(arg_10_0)
	arg_10_0.bulletOver = 1
end
