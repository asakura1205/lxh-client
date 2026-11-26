zbMailDetailSystem = class("zbMailDetailSystem")
zbMailDetailSystem.__index = zbMailDetailSystem

function createSystemMail(arg_1_0)
	local var_1_0 = zbMailDetailSystem.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function zbMailDetailSystem.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.mailInfo = nil
	end

	local function var_2_1()
		arg_2_0.layerContent = arg_2_1
		arg_2_0.detailLayer = tolua.cast(arg_2_1:getChildByTag(1), "CCLayer")
		arg_2_0.scrollView = tolua.cast(arg_2_1:getChildByTag(11), "CCScrollView")

		arg_2_0.scrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_2_0.scrollView:setPosition(arg_2_0.detailLayer:getPosition())
		arg_2_0.scrollView:setAnchorPoint(ccp(0, 0))
		arg_2_0.scrollView:setBounceable(false)
		arg_2_0.detailLayer:removeFromParentAndCleanup(false)
		arg_2_0.scrollView:setContainer(arg_2_0.detailLayer)

		arg_2_0.btnDelete = tolua.cast(arg_2_1:getChildByTag(2), "CCControlButton")

		arg_2_0.btnDelete:addHandleOfControlEvent(function()
			arg_2_0:onDelete()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function zbMailDetailSystem.stringSplit(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = 0
	local var_6_2 = 1

	while true do
		var_6_1 = string.find(arg_6_1, "\n", var_6_1 + 1)

		if var_6_1 == nil then
			local var_6_3 = string.len(arg_6_1)

			if var_6_2 - 1 ~= var_6_3 then
				var_6_1 = var_6_3
				var_6_0[#var_6_0 + 1] = string.sub(arg_6_1, var_6_2, var_6_1)
			end

			break
		end

		var_6_0[#var_6_0 + 1] = string.sub(arg_6_1, var_6_2, var_6_1)
		var_6_2 = var_6_1 + 1
	end

	return var_6_0
end

function zbMailDetailSystem.refreshTxtCase(arg_7_0, arg_7_1)
	arg_7_0.mailInfo = arg_7_1

	arg_7_0.layerContent:setVisible(true)

	if arg_7_1 then
		local function var_7_0(arg_8_0)
			local var_8_0 = string.gsub(arg_8_0, "%[color=0x[%a%d]+%]", "")

			return (string.gsub(var_8_0, "%[/color%]", ""))
		end

		local var_7_1 = a2u(arg_7_1.Content)
		local var_7_2 = arg_7_0:stringSplit(var_7_1)
		local var_7_3 = CCLabelTTF:create("", DefaultFontName, 20)
		local var_7_4 = 0
		local var_7_5 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_2) do
			local var_7_6 = a2u(var_7_0(iter_7_1))
			local var_7_7 = var_7_3:getContentSize().width
			local var_7_8 = math.ceil(var_7_7 / 450)

			if var_7_8 == 0 then
				var_7_8 = 1
			end

			var_7_4 = var_7_4 + 25 * var_7_8

			local var_7_9 = 20
			local var_7_10 = CCRichLabelTTF:create(450, 25 * var_7_8, var_7_9, DefaultFontName, ccc3(120, 63, 4), false)

			ui:setTTFStroke(var_7_10)
			var_7_10:setRichString(a2u(iter_7_1))
			table.insert(var_7_5, var_7_10)
		end

		arg_7_0.detailLayer:setContentSize(CCSize(450, var_7_4 + 10))
		arg_7_0.detailLayer:removeAllChildrenWithCleanup(true)

		local var_7_11 = arg_7_0.detailLayer:getContentSize().height - 10

		for iter_7_2, iter_7_3 in pairs(var_7_5) do
			var_7_11 = var_7_11 - iter_7_3:getContentSize().height

			iter_7_3:setPositionY(var_7_11)
			arg_7_0.detailLayer:addChild(iter_7_3)
		end

		arg_7_0.scrollView:setContentOffset(ccp(0, 250 - arg_7_0.detailLayer:getContentSize().height))
		arg_7_0.scrollView:setBounceable(false)
	end
end

function zbMailDetailSystem.onDelete(arg_9_0)
	local var_9_0 = {}

	table.insert(var_9_0, arg_9_0.mailInfo.MailId)
	g_WsMsgHandler:WS_Mail_Delete_Req(var_9_0)
end

function zbMailDetailSystem.doHide(arg_10_0)
	arg_10_0.layerContent:setVisible(false)
end
