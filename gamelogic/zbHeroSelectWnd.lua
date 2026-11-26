require("gamelogic.zbTabWnd")
require("gamelogic.zbHeroSelectList")

zbHeroSelectWnd = class("zbHeroSelectWnd", zbTabWnd)
zbHeroSelectWnd.__index = zbHeroSelectWnd

function zbHeroSelectWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSelectWnd)

	return arg_1_0
end

function createHeroSelectWnd()
	local var_2_0 = zbHeroSelectWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroSelectWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.usefor = -1
		arg_3_0.partnerIndex = 0
		arg_3_0.templateid = 0
		arg_3_0.partnerList = {}
		arg_3_0.cannotSelList = {}
		arg_3_0.callback = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroSelectwnd.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		}
		local var_5_5 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_3:getChildByTag(11), "CCLayer"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_3:getChildByTag(12), "CCLayer"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_3:getChildByTag(13), "CCLayer")
		}
		local var_5_6 = {
			[EHeroTabType.Battle] = "image/tab/tab_herotab_battle.png",
			[EHeroTabType.Entourage] = "image/tab/tab_herotab_entourage.png",
			[EHeroTabType.UnUse] = "image/tab/tab_herotab_unUse.png"
		}

		arg_3_0.tabButtons = var_5_4
		arg_3_0.module = {}
		arg_3_0.module[EHeroTabType.Battle] = createHeroListSelectPanel(var_5_5[EHeroTabType.Battle], EHeroTabType.Battle, var_5_4[EHeroTabType.Battle], arg_3_0)
		arg_3_0.module[EHeroTabType.Entourage] = createHeroListSelectPanel(var_5_5[EHeroTabType.Entourage], EHeroTabType.Entourage, var_5_4[EHeroTabType.Entourage], arg_3_0)
		arg_3_0.module[EHeroTabType.UnUse] = createHeroListSelectPanel(var_5_5[EHeroTabType.UnUse], EHeroTabType.UnUse, var_5_4[EHeroTabType.UnUse], arg_3_0)

		arg_3_0:initTab(var_5_4, var_5_5, var_5_6)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_2:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onHide()
	end, zbGameEvent.Event_Update_Hero)
end

function zbHeroSelectWnd.refreshSwapEquip(arg_9_0, arg_9_1)
	arg_9_0.usefor = E_HeroSelWnd_usefor.E_SwapEquip
	arg_9_0.templateid = arg_9_1
	arg_9_0.cannotSelList = {}

	arg_9_0:selectTab(1)
end

function zbHeroSelectWnd.refreshPartner(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.usefor = E_HeroSelWnd_usefor.E_Partner
	arg_10_0.partnerIndex = arg_10_1
	arg_10_0.templateid = arg_10_2
	arg_10_0.cannotSelList = {}

	arg_10_0:selectTab(3)
end

function zbHeroSelectWnd.refreshHeroSelCallback(arg_11_0, arg_11_1)
	arg_11_0.usefor = E_HeroSelWnd_usefor.E_SelHero
	arg_11_0.templateid = nil
	arg_11_0.callback = arg_11_1

	arg_11_0:selectTab(1)
end

function zbHeroSelectWnd.setCannotSelList(arg_12_0, arg_12_1)
	arg_12_0.cannotSelList = arg_12_1
end

function zbHeroSelectWnd.doSelectTab(arg_13_0)
	if arg_13_0.module[arg_13_0.currTab] then
		arg_13_0.module[arg_13_0.currTab]:refresh()
	end

	for iter_13_0 = 1, table.getn(arg_13_0.tabButtons) do
		if iter_13_0 == arg_13_0.currTab then
			arg_13_0.tabButtons[iter_13_0]:setZOrder(ZORDER_TOP)
		else
			arg_13_0.tabButtons[iter_13_0]:setZOrder(ZORDER_BOTTOM)
		end
	end
end

function zbHeroSelectWnd.onHide(arg_14_0)
	arg_14_0:hide()
end

function zbHeroSelectWnd.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layerTouchTest, var_15_0.x, var_15_0.y) == false and zbUtil:PointInCtrl(arg_15_0.btnClose, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end
