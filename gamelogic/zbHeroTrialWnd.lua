require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroTrialItem")

local var_0_0 = class("zbHeroTrialWnd", zbBaseWnd)

var_0_0.__index = var_0_0
HeroTrialItem_Width = 250
HeroTrialItem_Height = 330

function createHeroTrialWnd()
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
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/herotrial.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.mainLayer = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)
		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:confirmCreateView()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_TrialInfo)
end

function var_0_0.confirmCreateView(arg_8_0)
	local var_8_0 = arg_8_0.mainLayer:getContentSize()
	local var_8_1 = CCSizeMake(HeroTrialItem_Width * 4, var_8_0.height)
	local var_8_2 = CCSizeMake(var_8_0.width, var_8_0.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_1, var_8_2, 0, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.mainLayer:addChild(arg_8_0.tableView)
	arg_8_0.tableViewHelper:setMaskPanel(arg_8_0.left_arrow, arg_8_0.right_arrow, nil, nil)

	local var_8_3 = zbHeroTrialBaseTable.records
	local var_8_4 = zbTableViewHelper:create()

	var_8_4:loadCCBFile("ccbi/tb_herotrial.ccbi")

	local var_8_5 = createHeroTrialItem(translateAndStrokeHelper(var_8_4:readCCBNode()), 6, arg_8_0)

	var_8_5:setContentSize(CCSizeMake(HeroTrialItem_Width, HeroTrialItem_Height))
	var_8_5:retain()
	arg_8_0.tableViewHelper:addCell(var_8_5)

	arg_8_0.items[1] = var_8_5

	for iter_8_0 = 1, 5 do
		local var_8_6 = createHeroTrialItem(translateAndStrokeHelper(var_8_4:readCCBNode()), var_8_3[iter_8_0].trialId, arg_8_0)

		var_8_6:setContentSize(CCSizeMake(HeroTrialItem_Width, HeroTrialItem_Height))
		var_8_6:retain()
		arg_8_0.tableViewHelper:addCell(var_8_6)

		arg_8_0.items[iter_8_0 + 1] = var_8_6
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.moneyPanel.btnClose:getTouchPriority())
end

function var_0_0.refresh(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
		iter_9_1:refresh()
	end
end

function var_0_0.onFrameUpdate(arg_10_0)
	arg_10_0:updateBackEffect()
end
