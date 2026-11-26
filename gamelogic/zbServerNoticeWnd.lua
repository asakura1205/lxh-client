require("gamelogic.zbBaseWnd")
require("gamelogic.zbServerNoticeBtn")

zbServerNoticeWnd = class("zbServerNoticeWnd", zbBaseWnd)
zbServerNoticeWnd.__index = zbServerNoticeWnd

local var_0_0 = ""

function zbServerNoticeWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbServerNoticeWnd)

	return arg_1_0
end

function zbServerNoticeWnd.init(arg_2_0)
	local function var_2_0()
		arg_2_0.spriteRandoms = {}
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.selectId = 1
	end

	local function var_2_1()
		local var_4_0 = CCBProxy:create()
		local var_4_1 = CCBReaderLoad("ccbi/servernotice.ccbi", var_4_0, true, "HelloCocosBuilderLayerOwner")
		local var_4_2 = tolua.cast(var_4_1:getChildByTag(1), "CCLayer")

		arg_2_0.testLayer = var_4_2
		arg_2_0.spriteRandom = tolua.cast(var_4_2:getChildByTag(0), "CCNode")

		for iter_4_0 = 1, 4 do
			arg_2_0.spriteRandoms[iter_4_0] = tolua.cast(arg_2_0.spriteRandom:getChildByTag(iter_4_0), "CCSprite")
		end

		arg_2_0.lbTitle = tolua.cast(var_4_2:getChildByTag(1), "CCLabelTTF")

		arg_2_0.lbTitle:setVisible(false)

		arg_2_0.leftlayer = tolua.cast(var_4_2:getChildByTag(2), "CCLayer")
		arg_2_0.detailLayer = tolua.cast(var_4_2:getChildByTag(3), "CCLayer")
		arg_2_0.scrollView = tolua.cast(var_4_2:getChildByTag(4), "CCScrollView")

		arg_2_0.scrollView:setDirection(kCCScrollViewDirectionVertical)
		arg_2_0.scrollView:setPosition(arg_2_0.detailLayer:getPosition())
		arg_2_0.scrollView:setAnchorPoint(ccp(0, 0))
		arg_2_0.scrollView:setBounceable(false)

		arg_2_0.btnClose = tolua.cast(var_4_2:getChildByTag(5), "CCControlButton")

		arg_2_0.btnClose:addHandleOfControlEvent(function()
			arg_2_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_2_0.detailLayer:removeFromParentAndCleanup(false)
		arg_2_0.scrollView:setContainer(arg_2_0.detailLayer)
		arg_2_0:setWinType(EWinType.Pop_OnlyDark)
		arg_2_0:addChild(var_4_1)
	end

	arg_2_0:setShowCallback(function()
		arg_2_0:doShow()
	end)
	var_2_0()
	var_2_1()
end

function zbServerNoticeWnd.doShow(arg_7_0)
	if zbUtil:isValidTable(g_Login.noticeData) and table.getn(g_Login.noticeData) > 0 then
		arg_7_0.selectId = g_Login.noticeData[1].SortId

		arg_7_0.lbTitle:setVisible(true)
	else
		arg_7_0.lbTitle:setVisible(false)
	end

	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(false)
	end
end

function zbServerNoticeWnd.onClose(arg_8_0)
	arg_8_0:hide()

	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(true)
	end
end

function zbServerNoticeWnd.refresh(arg_9_0)
	local var_9_0 = zbUtil:random(1, 4)

	for iter_9_0 = 1, 4 do
		if iter_9_0 == var_9_0 then
			arg_9_0.spriteRandoms[iter_9_0]:setVisible(true)
		else
			arg_9_0.spriteRandoms[iter_9_0]:setVisible(false)
		end
	end

	if zbUtil:isValidTable(g_Login.noticeData) and table.getn(g_Login.noticeData) > 0 then
		arg_9_0:confirmCreateView()
		arg_9_0:refreshDetail()
	end
end

function zbServerNoticeWnd.confirmCreateView(arg_10_0)
	arg_10_0.count = table.getn(g_Login.noticeData)

	local var_10_0 = table.getn(arg_10_0.items)
	local var_10_1 = arg_10_0.leftlayer:getContentSize()
	local var_10_2 = CCSizeMake(var_10_1.width, 107 * arg_10_0.count)
	local var_10_3 = CCSizeMake(var_10_1.width, var_10_1.height)

	if arg_10_0.tableViewHelper == nil then
		arg_10_0.tableViewHelper = zbTableViewHelper:create()
	end

	if arg_10_0.tableView == nil then
		arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_2, var_10_3, 1, arg_10_0.tableViewHelper)

		arg_10_0.tableView:setPosition(0, 0)
		arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_10_0.leftlayer:addChild(arg_10_0.tableView)
	end

	if arg_10_0.count - var_10_0 > 0 then
		local var_10_4 = zbTableViewHelper:create()

		var_10_4:loadCCBFile("ccbi/tb_servernotictypeitem.ccbi")

		for iter_10_0 = 1, arg_10_0.count - var_10_0 do
			local var_10_5 = createServerNoticeBtn(translateAndStrokeHelper(var_10_4:readCCBNode()), arg_10_0)

			var_10_5:retain()

			arg_10_0.items[var_10_0 + iter_10_0] = var_10_5
		end
	end

	arg_10_0.tableViewHelper:removeAllCells()

	local var_10_6 = 1

	for iter_10_1, iter_10_2 in pairs(g_Login.noticeData) do
		local var_10_7 = arg_10_0.items[var_10_6]

		arg_10_0.tableViewHelper:addCell(var_10_7)
		var_10_7:refresh(iter_10_2)

		var_10_6 = var_10_6 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function zbServerNoticeWnd.onFrameUpdate(arg_11_0)
	return
end

function zbServerNoticeWnd.refreshDetail(arg_12_0)
	local var_12_0

	for iter_12_0, iter_12_1 in pairs(g_Login.noticeData) do
		if iter_12_1.SortId == arg_12_0.selectId then
			var_12_0 = iter_12_1
		end
	end

	if var_12_0 == nil then
		return
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.items) do
		if iter_12_3 then
			iter_12_3:setItemSelected(arg_12_0.selectId)
		end
	end

	arg_12_0.lbTitle:setString(a2u(var_12_0.Title))

	local function var_12_1(arg_13_0)
		local var_13_0 = string.gsub(arg_13_0, "%[color=0x[%a%d]+%]", "")

		return (string.gsub(var_13_0, "%[/color%]", ""))
	end

	local var_12_2 = a2u(var_12_0.Content)
	local var_12_3 = arg_12_0:stringSplit(var_12_2)
	local var_12_4 = CCLabelTTF:create("", DefaultFontName, 20)
	local var_12_5 = 0
	local var_12_6 = {}

	for iter_12_4, iter_12_5 in pairs(var_12_3) do
		local var_12_7 = a2u(var_12_1(iter_12_5))

		var_12_4:setString(var_12_7)

		local var_12_8 = var_12_4:getContentSize().width
		local var_12_9 = math.ceil(var_12_8 / 510)

		if var_12_9 == 0 then
			var_12_9 = 1
		end

		var_12_5 = var_12_5 + 25 * var_12_9

		local var_12_10 = 20
		local var_12_11 = CCRichLabelTTF:create(510, 25 * var_12_9, var_12_10, DefaultFontName, ccc3(255, 255, 255), false)

		var_12_11:setRichString(a2u(iter_12_5))
		table.insert(var_12_6, var_12_11)
	end

	arg_12_0.detailLayer:setContentSize(CCSize(530, var_12_5 + 10))
	arg_12_0.detailLayer:removeAllChildrenWithCleanup(true)

	local var_12_12 = arg_12_0.detailLayer:getContentSize().height - 10

	for iter_12_6, iter_12_7 in pairs(var_12_6) do
		var_12_12 = var_12_12 - iter_12_7:getContentSize().height

		iter_12_7:setPositionY(var_12_12)
		arg_12_0.detailLayer:addChild(iter_12_7)
	end

	arg_12_0.scrollView:setContentOffset(ccp(0, 350 - arg_12_0.detailLayer:getContentSize().height))
	arg_12_0.scrollView:setBounceable(false)
end

function zbServerNoticeWnd.stringSplit(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = 0
	local var_14_2 = 1

	while true do
		var_14_1 = string.find(arg_14_1, "\n", var_14_1 + 1)

		if var_14_1 == nil then
			local var_14_3 = string.len(arg_14_1)

			if var_14_2 - 1 ~= var_14_3 then
				var_14_1 = var_14_3
				var_14_0[#var_14_0 + 1] = string.sub(arg_14_1, var_14_2, var_14_1)
			end

			break
		end

		var_14_0[#var_14_0 + 1] = string.sub(arg_14_1, var_14_2, var_14_1)
		var_14_2 = var_14_1 + 1
	end

	return var_14_0
end

function zbServerNoticeWnd.onNoticeSel(arg_15_0, arg_15_1)
	arg_15_0.selectId = arg_15_1

	arg_15_0:refreshDetail()
end

function createServerNoticeWnd()
	local var_16_0 = zbServerNoticeWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_16_0:initBase()
	var_16_0:init()

	return var_16_0
end
