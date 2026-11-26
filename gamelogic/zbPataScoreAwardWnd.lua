require("gamelogic.zbBaseWnd")
require("gamelogic.zbPataScoreAwardItem")
require("gamelogic.zbItem")

local var_0_0 = class("zbPataScoreAwardWnd", zbBaseWnd)

var_0_0.__index = var_0_0
ScoreAwardItem_Width = 250
PageCount = 10

function createPataScoreAwardWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

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

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.awardItems = {}
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.page = 1
		arg_3_0.haveLoadNum = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/scoreaward.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbScore = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbScore)
		arg_3_0.lbScore:setScale(0.55)

		arg_3_0.awardNode = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		for iter_5_0 = 1, 4 do
			local var_5_4 = tolua.cast(arg_3_0.awardNode:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setScale(0.6)
			arg_3_0.awardNode:addChild(var_5_5)

			arg_3_0.awardItems[iter_5_0] = var_5_5

			var_5_4:removeFromParentAndCleanup(true)
		end

		arg_3_0.layeraward = tolua.cast(var_5_2:getChildByTag(5), "CCLayer")
		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(6), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(7), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)

		arg_3_0.lbTotalaward = tolua.cast(var_5_2:getChildByTag(1000), "CCLabelTTF")
		arg_3_0.lbPage = tolua.cast(var_5_2:getChildByTag(9), "CCLabelTTF")
		arg_3_0.btnLeft = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")
		arg_3_0.btnRight = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnLeft:addHandleOfControlEvent(function()
			arg_3_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRight:addHandleOfControlEvent(function()
			arg_3_0:onRight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_PataRefreshAck)
	arg_3_0:confirmCreateView()
end

function var_0_0.totalAward(arg_10_0, arg_10_1)
	local var_10_0 = {}

	local function var_10_1(arg_11_0)
		local function var_11_0(arg_12_0, arg_12_1)
			for iter_12_0, iter_12_1 in pairs(var_10_0) do
				if iter_12_1.awardId == arg_12_0 and iter_12_1.awardType == arg_12_1 then
					return true
				end
			end

			return false
		end

		local function var_11_1(arg_13_0)
			if var_11_0(arg_13_0.awardId, arg_13_0.awardType) then
				for iter_13_0, iter_13_1 in pairs(var_10_0) do
					if iter_13_1.awardId == arg_13_0.awardId and iter_13_1.awardType == arg_13_0.awardType then
						iter_13_1.awardNum = iter_13_1.awardNum + arg_13_0.awardNum
					end
				end
			else
				table.insert(var_10_0, arg_13_0)
			end
		end

		for iter_11_0, iter_11_1 in pairs(arg_11_0) do
			for iter_11_2, iter_11_3 in pairs(iter_11_1) do
				var_11_1(iter_11_3)
			end
		end

		return var_10_0
	end

	local var_10_2 = {}

	if arg_10_1 and type(arg_10_1.IndexList) == "table" then
		for iter_10_0, iter_10_1 in pairs(arg_10_1.IndexList) do
			local var_10_3 = zbPataScoreAwardTable:getAwardByScore(iter_10_1)

			table.insert(var_10_2, var_10_3)
		end
	end

	var_10_0 = var_10_1(var_10_2)

	return var_10_0
end

function var_0_0.refresh(arg_14_0)
	local var_14_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_14_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_0))

	local var_14_1 = g_GameData.PataInfo

	for iter_14_0 = 1, 4 do
		arg_14_0.awardItems[iter_14_0]:setVisible(false)
	end

	arg_14_0.lbTotalaward:setVisible(false)

	if var_14_1 then
		arg_14_0.lbScore:setString(var_14_1.BaseInfo.TotalScore)

		local var_14_2 = arg_14_0:totalAward(var_14_1.ScoreAwardInfo)

		arg_14_0.lbTotalaward:setVisible(table.getn(var_14_2) > 0)

		local var_14_3 = 1

		for iter_14_1, iter_14_2 in pairs(var_14_2) do
			local var_14_4 = arg_14_0.awardItems[var_14_3]

			if var_14_4 then
				var_14_4:refreshAward(iter_14_2.awardType, iter_14_2.awardId, iter_14_2.awardNum, false)
				var_14_4:setVisible(true)

				var_14_3 = var_14_3 + 1
			end
		end
	end

	arg_14_0:refreshMainLayer()
end

function var_0_0.confirmCreateView(arg_15_0)
	local var_15_0 = arg_15_0.layeraward:getContentSize()
	local var_15_1 = CCSizeMake(ScoreAwardItem_Width * PageCount, var_15_0.height)

	arg_15_0.tableViewHelper = zbTableViewHelper:create()
	arg_15_0.tableView = zbTableViewHelper:createTableView(var_15_1, var_15_0, 0, arg_15_0.tableViewHelper)

	arg_15_0.tableView:setPosition(0, 0)
	arg_15_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_15_0.layeraward:addChild(arg_15_0.tableView)
	arg_15_0.tableViewHelper:setMaskPanel(arg_15_0.left_arrow, arg_15_0.right_arrow, nil, nil)

	for iter_15_0 = 1, PageCount do
		local var_15_2 = zbPataScoreAwardItem:create()

		var_15_2:setContentSize(CCSizeMake(180, 260))
		var_15_2:retain()
		arg_15_0.tableViewHelper:addCell(var_15_2)

		arg_15_0.items[iter_15_0] = var_15_2
	end

	arg_15_0.tableViewHelper:refreshTabelView()
	arg_15_0.tableViewHelper:setTouchPriority(arg_15_0.btnClose:getTouchPriority())
end

function var_0_0.refreshMainLayer(arg_16_0)
	arg_16_0.lbPage:setString((arg_16_0.page - 1) * PageCount + 1 .. "-" .. arg_16_0.page * PageCount)

	local var_16_0 = zbPataScoreAwardTable:getRecordsByPage(arg_16_0.page, PageCount)

	for iter_16_0 = 1, PageCount do
		arg_16_0.items[iter_16_0]:refresh(var_16_0[iter_16_0], arg_16_0.page)
	end

	arg_16_0.tableViewHelper:refreshTabelView()
end

function var_0_0.onLeft(arg_17_0)
	if arg_17_0.page > 1 then
		arg_17_0.page = arg_17_0.page - 1

		arg_17_0:refreshMainLayer()
	end
end

function var_0_0.onRight(arg_18_0)
	if arg_18_0.page < zbPataScoreAwardTable:getTotalPage(PageCount) then
		arg_18_0.page = arg_18_0.page + 1

		arg_18_0:refreshMainLayer()
	end
end
