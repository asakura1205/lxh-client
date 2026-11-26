require("gamelogic.zbBaseWnd")

zbTabWnd = class("zbTabWnd", zbBaseWnd)
zbTabWnd.__index = zbTabWnd

function zbTabWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbTabWnd)

	return arg_1_0
end

function zbTabWnd.initTab(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if table.getn(arg_2_1) ~= table.getn(arg_2_2) then
		echoInfo("zbTabWnd.initTab invalid tabcount")
	end

	arg_2_0.switchCB = arg_2_4
	arg_2_0.tabCount = table.getn(arg_2_1)
	arg_2_0.tabButtons = arg_2_1
	arg_2_0.tabLayers = arg_2_2
	arg_2_0.tabImagePaths = arg_2_3
	arg_2_0.tabSprites = {}

	for iter_2_0 = 1, arg_2_0.tabCount do
		if arg_2_0.tabImagePaths ~= nil then
			zbUtil:setButtonTitle(arg_2_0.tabButtons[iter_2_0], "")

			arg_2_0.tabSprites[iter_2_0] = CCSprite:create(arg_2_0.tabImagePaths[iter_2_0])

			arg_2_0.tabSprites[iter_2_0]:setAnchorPoint(ccp(0.5, 0.5))
			arg_2_0.tabSprites[iter_2_0]:setPosition(arg_2_0.tabButtons[iter_2_0]:getContentSize().width / 2, arg_2_0.tabButtons[iter_2_0]:getContentSize().height / 2)
			arg_2_0.tabButtons[iter_2_0]:addChild(arg_2_0.tabSprites[iter_2_0])
		end

		arg_2_0.tabButtons[iter_2_0]:addHandleOfControlEvent(function(arg_3_0, arg_3_1)
			arg_2_0:onSwitchTab(arg_3_0, arg_3_1)
		end, CCControlEventTouchUpInside)
		arg_2_0.tabButtons[iter_2_0]:addHandleOfControlEvent(function()
			arg_2_0:onTouchDown(iter_2_0)
		end, CCControlEventTouchDown)
		arg_2_0.tabButtons[iter_2_0]:addHandleOfControlEvent(function()
			arg_2_0:onTouchDown(iter_2_0)
		end, CCControlEventTouchDragEnter)
		arg_2_0.tabButtons[iter_2_0]:addHandleOfControlEvent(function()
			arg_2_0:onTouchEnd()
		end, CCControlEventTouchDragExit)
	end

	arg_2_0.currTab = -1

	arg_2_0:selectTab(1)
end

function zbTabWnd.onSwitchTab(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.tabButtons) do
		if arg_7_2 == iter_7_1 then
			arg_7_0:selectTab(iter_7_0)

			break
		end
	end
end

function zbTabWnd.selectTab(arg_8_0, arg_8_1)
	if arg_8_1 < 1 or arg_8_1 > arg_8_0.tabCount then
		return
	end

	if not arg_8_0:bopen(arg_8_1) then
		return
	end

	if arg_8_0.switchCB ~= nil and arg_8_0.switchCB(arg_8_1) == false then
		return
	end

	for iter_8_0 = 1, arg_8_0.tabCount do
		arg_8_0.tabButtons[iter_8_0]:setEnabled(true)
		arg_8_0.tabLayers[iter_8_0]:setVisible(false)

		if arg_8_0.tabImagePaths ~= nil then
			arg_8_0.tabSprites[iter_8_0]:setGray(true)
		end
	end

	arg_8_0.tabButtons[arg_8_1]:setEnabled(false)
	arg_8_0.tabLayers[arg_8_1]:setVisible(true)

	if arg_8_0.tabImagePaths ~= nil then
		arg_8_0.tabSprites[arg_8_1]:setGray(false)
	end

	arg_8_0.currTab = arg_8_1

	arg_8_0:doSelectTab()
end

function zbTabWnd.bopen(arg_9_0, arg_9_1)
	return true
end

function zbTabWnd.doSelectTab(arg_10_0)
	return
end

function zbTabWnd.getSelectIndex(arg_11_0)
	for iter_11_0 = 1, arg_11_0.tabCount do
		if arg_11_0.tabButtons[iter_11_0]:isEnabled() == false then
			return iter_11_0
		end
	end

	return -1
end

function zbTabWnd.setTabVisible(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 < 1 or arg_12_1 > arg_12_0.tabCount then
		return
	end

	arg_12_0.tabButtons[arg_12_1]:setVisible(arg_12_2)
	arg_12_0.tabLayers[arg_12_1]:setVisible(arg_12_2)
end

function zbTabWnd.setTabButtonVisible(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 < 1 or arg_13_1 > arg_13_0.tabCount then
		return
	end

	arg_13_0.tabButtons[arg_13_1]:setVisible(arg_13_2)
end

function zbTabWnd.onTouchDown(arg_14_0, arg_14_1)
	for iter_14_0 = 1, table.getn(arg_14_0.tabButtons) do
		if iter_14_0 == arg_14_1 then
			arg_14_0.tabButtons[iter_14_0]:setZOrder(ZORDER_TOP)
		end
	end
end

function zbTabWnd.onTouchEnd(arg_15_0)
	for iter_15_0 = 1, table.getn(arg_15_0.tabButtons) do
		if iter_15_0 == arg_15_0.currTab then
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_TOP)
		else
			arg_15_0.tabButtons[iter_15_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end
