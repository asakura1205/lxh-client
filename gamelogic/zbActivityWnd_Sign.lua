require("gamelogic.zbSignItem")

zbActivityWnd_Sign = class("zbActivityWnd_Sign")
zbActivityWnd_Sign.__index = zbActivityWnd_Sign

local var_0_0 = 120
local var_0_1 = 120
local var_0_2 = 5

function zbActivityWnd_Sign.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Sign)

	return arg_1_0
end

function zbActivityWnd_Sign.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbActivityWnd_Sign.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbActivityWnd_Sign.init(arg_3_0, arg_3_1, arg_3_2)
	(function()
		arg_3_0.items = {}
		arg_3_0.lines = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
	end)()
end

function zbActivityWnd_Sign.initSignList(arg_5_0)
	(function()
		if arg_5_0.node ~= nil then
			return
		end

		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/activity_sign.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")

		arg_5_0.layerContent = tolua.cast(var_6_2:getChildByTag(2), "CCLayerColor")
		arg_5_0.nodeShow = tolua.cast(var_6_2:getChildByTag(1), "CCLayer")
		arg_5_0.spriteHero = tolua.cast(arg_5_0.nodeShow:getChildByTag(1), "CCSprite")

		local var_6_3 = tolua.cast(arg_5_0.nodeShow:getChildByTag(1005), "CCLabelTTF")

		arg_5_0.lbCountDown = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_6_3, arg_5_0.lbCountDown)
		arg_5_0.lbCountDown:setScale(0.6)

		arg_5_0.node = var_6_1

		arg_5_0.nodeParent:addChild(var_6_1)
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.DailySign) == false then
		return
	end

	arg_5_0:refreshDetail()

	if arg_5_0.tableViewHelper ~= nil and arg_5_0.tableViewHelper.clearLuaEnterHandler ~= nil then
		arg_5_0.tableViewHelper:clearLuaEnterHandler()
	end

	if arg_5_0.tableView == nil then
		local var_5_0 = arg_5_0.layerContent:getContentSize()

		arg_5_0.tableViewHelper = zbTableViewHelper:create()
		arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, 1, arg_5_0.tableViewHelper)

		arg_5_0.tableView:setPosition(0, 0)
		arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_5_0.layerContent:addChild(arg_5_0.tableView)
		arg_5_0.tableViewHelper:setMaskPanel(nil, nil, arg_5_0.maskLeft, arg_5_0.maskRight)
	else
		arg_5_0.tableViewHelper:removeAllCells()
	end

	local var_5_1 = g_GameData.ActivityAct.DailySign.SignAward
	local var_5_2 = math.ceil(table.getn(var_5_1) / var_0_2)
	local var_5_3 = table.getn(arg_5_0.lines)

	arg_5_0.count = var_5_2

	for iter_5_0 = 1, var_5_3 do
		if iter_5_0 <= var_5_2 then
			local var_5_4 = arg_5_0.lines[iter_5_0]

			arg_5_0.tableViewHelper:addCell(var_5_4)
		end
	end

	if var_5_2 - var_5_3 > 0 then
		for iter_5_1 = 1, var_5_2 - var_5_3 do
			local var_5_5 = arg_5_0.tableViewHelper:addListItem()

			var_5_5:setAnchorPoint(ccp(0, 0))
			var_5_5:setContentSize(CCSizeMake(var_0_0 * var_0_2, var_0_1))

			arg_5_0.lines[var_5_3 + iter_5_1] = var_5_5

			for iter_5_2 = 1, var_0_2 do
				local var_5_6 = zbSignItem:create()

				var_5_6:setAnchorPoint(ccp(0, 0))
				var_5_6:setPosition((iter_5_2 - 1) * var_0_0 - 10, 0)
				var_5_5:addChild(var_5_6)

				arg_5_0.items[(var_5_3 + iter_5_1 - 1) * var_0_2 + iter_5_2] = var_5_6
			end
		end
	end

	local var_5_7 = 1

	for iter_5_3, iter_5_4 in pairs(var_5_1) do
		arg_5_0.items[var_5_7]:refresh(iter_5_4)

		var_5_7 = var_5_7 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())

	if arg_5_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_5_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_5_0:onTBNotifyEnter()
		end)
	end
end

function zbActivityWnd_Sign.onTBNotifyEnter(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:refreshFinger()
	end
end

function zbActivityWnd_Sign.refresh(arg_9_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.DailySign) == false then
		return
	end

	if arg_9_0.tableView == nil then
		arg_9_0:initSignList()
	end

	local var_9_0 = g_GameData.ActivityAct.DailySign.SignAward

	for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
		iter_9_1:setVisible(false)
	end

	if zbUtil:isValidTable(var_9_0) == false then
		return
	end

	local var_9_1 = 1

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		arg_9_0.items[var_9_1]:refreshState(iter_9_3)

		var_9_1 = var_9_1 + 1
	end
end

function zbActivityWnd_Sign.refreshDetail(arg_10_0)
	if zbHeroTable:getRecord(g_GameData.ActivityAct.DailySign.HeroTid) == nil then
		echoInfo("error hero template id: " .. g_GameData.ActivityAct.DailySign.HeroTid)

		return
	end

	local var_10_0 = g_Self.kHeroFragHandler:getHeroFragCount(g_GameData.ActivityAct.DailySign.HeroTid)
	local var_10_1 = g_Self.kHeroFragHandler:getHeroComposeNeeds(g_GameData.ActivityAct.DailySign.HeroTid)

	if var_10_1 ~= nil then
		arg_10_0.lbCountDown:setString(var_10_0 .. "/" .. var_10_1.needFrag)
	end

	arg_10_0.spriteHero:setTexture(CCTextureCache:sharedTextureCache():addImage("image/activity/sign/activity_sign" .. g_GameData.ActivityAct.DailySign.HeroTid .. ".jpg"))
end

function zbActivityWnd_Sign.onAvatarTouch(arg_11_0)
	return
end

function zbActivityWnd_Sign.onSignAck(arg_12_0)
	return
end

function zbActivityWnd_Sign.RefreshHeroStarLevel(arg_13_0)
	return
end
