require("gamelogic.zbTabWnd")
require("gamelogic.zbTechWnd_Hero")
require("gamelogic.zbTechWnd_Func")
require("gamelogic.zbTechWnd_Formation")
require("gamelogic.zbTechWnd_Parter")
require("gamelogic.zbTechItemDetail")

local var_0_0 = class("zbTechWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createTechWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		arg_3_0.refreshTag = true
		arg_3_0.posbtn = {}
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setAnchorPoint(ccp(0.5, 0.5))
		var_5_0:setPosition(arg_5_0:getContentSize().width - 25, arg_5_0:getContentSize().height / 2 + 20)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	local function var_3_2()
		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/tech.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner")
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")
		local var_6_3 = tolua.cast(var_6_2:getChildByTag(10), "CCNode")

		arg_3_0.techItemDetail = createTechItemDetail(var_6_3)

		local var_6_4 = tolua.cast(var_6_1:getChildByTag(2), "CCNode")
		local var_6_5 = {
			[ETechTab.Hero] = tolua.cast(var_6_4:getChildByTag(1), "CCControlButton"),
			[ETechTab.Func] = tolua.cast(var_6_4:getChildByTag(2), "CCControlButton"),
			[ETechTab.Formation] = tolua.cast(var_6_4:getChildByTag(3), "CCControlButton"),
			[ETechTab.Parter] = tolua.cast(var_6_4:getChildByTag(4), "CCControlButton")
		}

		arg_3_0.notify = {}
		arg_3_0.notify[ETechTab.Hero] = var_3_1(var_6_5[ETechTab.Hero])
		arg_3_0.notify[ETechTab.Func] = var_3_1(var_6_5[ETechTab.Func])
		arg_3_0.notify[ETechTab.Formation] = var_3_1(var_6_5[ETechTab.Formation])
		arg_3_0.notify[ETechTab.Parter] = var_3_1(var_6_5[ETechTab.Parter])
		arg_3_0.posbtn[ETechTab.Hero] = ccp(var_6_5[ETechTab.Hero]:getPosition())
		arg_3_0.posbtn[ETechTab.Func] = ccp(var_6_5[ETechTab.Func]:getPosition())
		arg_3_0.posbtn[ETechTab.Formation] = ccp(var_6_5[ETechTab.Formation]:getPosition())
		arg_3_0.posbtn[ETechTab.Parter] = ccp(var_6_5[ETechTab.Parter]:getPosition())

		local var_6_6 = {
			[ETechTab.Hero] = tolua.cast(var_6_2:getChildByTag(1), "CCLayer"),
			[ETechTab.Func] = tolua.cast(var_6_2:getChildByTag(2), "CCLayer"),
			[ETechTab.Formation] = tolua.cast(var_6_2:getChildByTag(3), "CCLayer"),
			[ETechTab.Parter] = tolua.cast(var_6_2:getChildByTag(4), "CCLayer")
		}
		local var_6_7 = {
			[ETechTab.Hero] = "image/tab/tab_tech_hero.png",
			[ETechTab.Func] = "image/tab/tab_tech_func.png",
			[ETechTab.Formation] = "image/tab/tab_tech_formation.png",
			[ETechTab.Parter] = "image/tab/tab_tech_parter.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ETechTab.Hero] = createTechWnd_Hero(arg_3_0, var_6_6[ETechTab.Hero])
		arg_3_0.module[ETechTab.Func] = createTechWnd_Func(arg_3_0, var_6_6[ETechTab.Func])
		arg_3_0.module[ETechTab.Formation] = createTechWnd_Formation(arg_3_0, var_6_6[ETechTab.Formation])
		arg_3_0.module[ETechTab.Parter] = createTechWnd_Parter(arg_3_0, var_6_6[ETechTab.Parter])

		arg_3_0:initTab(var_6_5, var_6_6, var_6_7)
		arg_3_0:addChild(var_6_1)
		arg_3_0:createMoneyPanel(var_6_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_2()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_Tech)
end

function var_0_0.refresh(arg_10_0)
	return
end

function var_0_0.onShowCallback(arg_11_0)
	if arg_11_0.refreshTag then
		arg_11_0:selectTab(ETechTab.Hero)
		arg_11_0.notify[ETechTab.Hero]:setVisible(arg_11_0.module[ETechTab.Hero]:refresh())
		arg_11_0.notify[ETechTab.Func]:setVisible(arg_11_0.module[ETechTab.Func]:refresh())
		arg_11_0.notify[ETechTab.Formation]:setVisible(arg_11_0.module[ETechTab.Formation]:refresh())
		arg_11_0.notify[ETechTab.Parter]:setVisible(arg_11_0.module[ETechTab.Parter]:refresh())
	end
end

function var_0_0.doSelectTab(arg_12_0)
	local function var_12_0(arg_13_0, arg_13_1)
		arg_13_0.unlockLvl = zbTechTable:getUnlockLevel(arg_13_0.id)
		arg_13_1.unlockLvl = zbTechTable:getUnlockLevel(arg_13_1.id)

		if arg_13_0.unlockLvl == arg_13_1.unlockLvl then
			return arg_13_0.id < arg_13_1.id
		else
			return arg_13_0.unlockLvl < arg_13_1.unlockLvl
		end
	end

	local var_12_1 = arg_12_0.module[arg_12_0.currTab].items

	table.sort(var_12_1, var_12_0)

	local var_12_2 = 0

	if table.getn(var_12_1) > 0 then
		var_12_2 = var_12_1[1].id
	end

	arg_12_0.module[arg_12_0.currTab]:refresh()
	arg_12_0.techItemDetail:refresh(var_12_2)
	arg_12_0.module[arg_12_0.currTab].items[1]:onTouch(arg_12_0.module[arg_12_0.currTab])
end

function var_0_0.onDataUpdateAck(arg_14_0)
	if arg_14_0.isShow == false then
		arg_14_0.refreshTag = true

		return
	end

	local var_14_0 = arg_14_0.module[arg_14_0.currTab]:refresh()

	arg_14_0.notify[arg_14_0.currTab]:setVisible(var_14_0)
	arg_14_0.techItemDetail:forceRefresh()
end

function var_0_0.onFrameUpdate(arg_15_0)
	arg_15_0:updateBackEffect()
end
