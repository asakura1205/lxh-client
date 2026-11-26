require("gamelogic.zbItem")

zbMailDetailAward = class("zbMailDetailAward")
zbMailDetailAward.__index = zbMailDetailAward

function createAwardMail(arg_1_0)
	local var_1_0 = zbMailDetailAward.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function zbMailDetailAward.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.mailItems = {}
		arg_2_0.mailInfo = nil
	end

	local function var_2_1()
		arg_2_0.layerContent = arg_2_1
		arg_2_0.detailLayer = tolua.cast(arg_2_1:getChildByTag(1), "CCLayer")
		arg_2_0.scrollView = tolua.cast(arg_2_1:getChildByTag(21), "CCScrollView")

		arg_2_0.scrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_2_0.scrollView:setPosition(arg_2_0.detailLayer:getPosition())
		arg_2_0.scrollView:setAnchorPoint(ccp(0, 0))
		arg_2_0.scrollView:setBounceable(false)
		arg_2_0.detailLayer:removeFromParentAndCleanup(false)
		arg_2_0.scrollView:setContainer(arg_2_0.detailLayer)

		for iter_4_0 = 1, 5 do
			local var_4_0 = tolua.cast(arg_2_1:getChildByTag(10 + iter_4_0), "CCLayerColor")
			local var_4_1 = createItem()

			var_4_1:setPosition(var_4_0:getPosition())
			arg_2_1:addChild(var_4_1)

			arg_2_0.mailItems[iter_4_0] = var_4_1

			var_4_0:removeFromParentAndCleanup(true)
		end

		arg_2_0.btnDelete = tolua.cast(arg_2_1:getChildByTag(2), "CCControlButton")
		arg_2_0.btnGet = tolua.cast(arg_2_1:getChildByTag(3), "CCControlButton")

		arg_2_0.btnDelete:addHandleOfControlEvent(function()
			arg_2_0:onDelete()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnGet:addHandleOfControlEvent(function()
			arg_2_0:onGet()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function zbMailDetailAward.stringSplit(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = 1

	while true do
		var_7_1 = string.find(arg_7_1, "\n", var_7_1 + 1)

		if var_7_1 == nil then
			local var_7_3 = string.len(arg_7_1)

			if var_7_2 - 1 ~= var_7_3 then
				var_7_1 = var_7_3
				var_7_0[#var_7_0 + 1] = string.sub(arg_7_1, var_7_2, var_7_1)
			end

			break
		end

		var_7_0[#var_7_0 + 1] = string.sub(arg_7_1, var_7_2, var_7_1)
		var_7_2 = var_7_1 + 1
	end

	return var_7_0
end

function zbMailDetailAward.refreshAwardCase(arg_8_0, arg_8_1)
	arg_8_0.layerContent:setVisible(true)

	if arg_8_1 then
		arg_8_0.mailInfo = arg_8_1

		arg_8_0.btnGet:setGray(arg_8_0.mailInfo.AwardState == 1)

		local function var_8_0(arg_9_0)
			local var_9_0 = string.gsub(arg_9_0, "%[color=0x[%a%d]+%]", "")

			return (string.gsub(var_9_0, "%[/color%]", ""))
		end

		local var_8_1 = a2u(arg_8_1.Content)
		local var_8_2 = arg_8_0:stringSplit(var_8_1)
		local var_8_3 = CCLabelTTF:create("", DefaultFontName, 20)
		local var_8_4 = 0
		local var_8_5 = {}

		for iter_8_0, iter_8_1 in pairs(var_8_2) do
			local var_8_6 = a2u(var_8_0(iter_8_1))

			var_8_3:setString(var_8_6)

			local var_8_7 = var_8_3:getContentSize().width
			local var_8_8 = math.ceil(var_8_7 / 450)

			if var_8_8 == 0 then
				var_8_8 = 1
			end

			var_8_4 = var_8_4 + 25 * var_8_8

			local var_8_9 = 20
			local var_8_10 = CCRichLabelTTF:create(450, 25 * var_8_8, var_8_9, DefaultFontName, ccc3(120, 63, 4), false)

			var_8_10:setRichString(a2u(iter_8_1))
			table.insert(var_8_5, var_8_10)
		end

		arg_8_0.detailLayer:setContentSize(CCSize(450, var_8_4 + 10))
		arg_8_0.detailLayer:removeAllChildrenWithCleanup(true)

		local var_8_11 = arg_8_0.detailLayer:getContentSize().height - 10

		for iter_8_2, iter_8_3 in pairs(var_8_5) do
			var_8_11 = var_8_11 - iter_8_3:getContentSize().height

			iter_8_3:setPositionY(var_8_11)
			arg_8_0.detailLayer:addChild(iter_8_3)
		end

		arg_8_0.scrollView:setContentOffset(ccp(0, 120 - arg_8_0.detailLayer:getContentSize().height))
		arg_8_0.scrollView:setBounceable(false)

		for iter_8_4 = 1, 5 do
			arg_8_0.mailItems[iter_8_4]:setVisible(false)
		end

		local var_8_12 = 1

		for iter_8_5, iter_8_6 in pairs(arg_8_1.AwardList) do
			if var_8_12 <= 5 then
				arg_8_0.mailItems[var_8_12]:refreshAward(iter_8_6.Type, iter_8_6.Id, iter_8_6.Count)
				arg_8_0.mailItems[var_8_12]:setVisible(true)
				arg_8_0.mailItems[var_8_12]:setScale(0.75)
			end

			var_8_12 = var_8_12 + 1
		end
	else
		arg_8_0.lbiDesc:setString("")

		for iter_8_7 = 1, 5 do
			arg_8_0.mailItems[iter_8_7]:setVisible(false)
		end
	end
end

function zbMailDetailAward.onDelete(arg_10_0)
	if arg_10_0.mailInfo.AwardState == 0 then
		g_Bubble:bubbleInfo("\xC7\xEB\xCF\xC8\xC1\xECȡ\xB8\xBD\xBC\xFE\xD4\xD9ɾ\xB3\xFD")

		return
	end

	local var_10_0 = {}

	table.insert(var_10_0, arg_10_0.mailInfo.MailId)
	g_WsMsgHandler:WS_Mail_Delete_Req(var_10_0)
end

function zbMailDetailAward.onGet(arg_11_0)
	if arg_11_0.mailInfo.AwardState == 1 then
		g_Bubble:bubbleInfo("\xB8\xBD\xBC\xFE\xD2\xD1\xC1\xECȡ")
	else
		g_WsMsgHandler:WS_Mail_GetAward_Req(arg_11_0.mailInfo.MailId)
	end
end

function zbMailDetailAward.doHide(arg_12_0)
	arg_12_0.layerContent:setVisible(false)
end
