require("gamelogic.zbTabWnd")
require("gamelogic.zbEquipList")

zbEquipListWnd = class("zbEquipListWnd", zbTabWnd)
zbEquipListWnd.__index = zbEquipListWnd

function createEquipListWnd()
	local var_1_0 = zbEquipListWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbEquipListWnd.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbEquipListWnd)

	return arg_2_0
end

function zbEquipListWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.ItemId = 0
		arg_3_0.closeFunc = nil
		arg_3_0.notify = {}
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(115, 70)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/equiplist.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		local var_5_5 = {
			[EEquipBagTab.Weapon] = tolua.cast(var_5_4:getChildByTag(1), "CCControlButton"),
			[EEquipBagTab.Armor] = tolua.cast(var_5_4:getChildByTag(2), "CCControlButton"),
			[EEquipBagTab.Mount] = tolua.cast(var_5_4:getChildByTag(3), "CCControlButton"),
			[EEquipBagTab.Cloak] = tolua.cast(var_5_4:getChildByTag(4), "CCControlButton"),
			[EEquipBagTab.Book] = tolua.cast(var_5_4:getChildByTag(5), "CCControlButton"),
			[EEquipBagTab.Magic] = tolua.cast(var_5_4:getChildByTag(6), "CCControlButton")
		}

		arg_3_0.notify[EEquipBagTab.Weapon] = var_5_0(var_5_5[EEquipBagTab.Weapon])
		arg_3_0.notify[EEquipBagTab.Armor] = var_5_0(var_5_5[EEquipBagTab.Armor])
		arg_3_0.notify[EEquipBagTab.Mount] = var_5_0(var_5_5[EEquipBagTab.Mount])
		arg_3_0.notify[EEquipBagTab.Cloak] = var_5_0(var_5_5[EEquipBagTab.Cloak])
		arg_3_0.notify[EEquipBagTab.Book] = var_5_0(var_5_5[EEquipBagTab.Book])
		arg_3_0.notify[EEquipBagTab.Magic] = var_5_0(var_5_5[EEquipBagTab.Magic])

		local var_5_6 = tolua.cast(var_5_3:getChildByTag(22), "CCSprite")

		zbUIEffect:runFadeToAction(var_5_6)

		local var_5_7 = {
			[EEquipBagTab.Weapon] = tolua.cast(var_5_3:getChildByTag(11), "CCLayer"),
			[EEquipBagTab.Armor] = tolua.cast(var_5_3:getChildByTag(12), "CCLayer"),
			[EEquipBagTab.Mount] = tolua.cast(var_5_3:getChildByTag(13), "CCLayer"),
			[EEquipBagTab.Cloak] = tolua.cast(var_5_3:getChildByTag(14), "CCLayer"),
			[EEquipBagTab.Book] = tolua.cast(var_5_3:getChildByTag(15), "CCLayer"),
			[EEquipBagTab.Magic] = tolua.cast(var_5_3:getChildByTag(16), "CCLayer")
		}
		local var_5_8 = {
			[EEquipBagTab.Weapon] = "image/tab/tab_equipbag_weapon.png",
			[EEquipBagTab.Armor] = "image/tab/tab_equipbag_armor.png",
			[EEquipBagTab.Mount] = "image/tab/tab_equipbag_mount.png",
			[EEquipBagTab.Cloak] = "image/tab/tab_equipbag_cloak.png",
			[EEquipBagTab.Book] = "image/tab/tab_equipbag_book.png",
			[EEquipBagTab.Magic] = "image/tab/tab_equipbag_magic.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EEquipBagTab.Weapon] = createEquipList(var_5_7[EEquipBagTab.Weapon], EEquipBagTab.Weapon, EEquipType.Weapon, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)
		arg_3_0.module[EEquipBagTab.Armor] = createEquipList(var_5_7[EEquipBagTab.Armor], EEquipBagTab.Armor, EEquipType.Armor, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)
		arg_3_0.module[EEquipBagTab.Mount] = createEquipList(var_5_7[EEquipBagTab.Mount], EEquipBagTab.Mount, EEquipType.Mount, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)
		arg_3_0.module[EEquipBagTab.Cloak] = createEquipList(var_5_7[EEquipBagTab.Cloak], EEquipBagTab.Cloak, EEquipType.Cloak, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)
		arg_3_0.module[EEquipBagTab.Book] = createEquipList(var_5_7[EEquipBagTab.Book], EEquipBagTab.Book, EEquipType.Book, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)
		arg_3_0.module[EEquipBagTab.Magic] = createEquipList(var_5_7[EEquipBagTab.Magic], EEquipBagTab.Magic, EEquipType.Magic, arg_3_0.spriteLeft, var_5_6, var_5_5[1], arg_3_0)

		arg_3_0:initTab(var_5_5, var_5_7, var_5_8)
		arg_3_0:addChild(var_5_2)
		arg_3_0:addBtnChat(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_BagEquip)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_FragEquip)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_Hero)
end

function zbEquipListWnd.refresh(arg_12_0)
	return
end

function zbEquipListWnd.onShow(arg_13_0)
	arg_13_0:selectTab(1)

	for iter_13_0 = EEquipBagTab.Weapon, EEquipBagTab.Magic do
		arg_13_0.notify[iter_13_0]:setVisible(g_Self.kEquipFragHandler:hasFragNotify(iter_13_0) or g_Self.kBagEquipHandler:getCanEnchant(iter_13_0))
	end
end

function zbEquipListWnd.doSelectTab(arg_14_0)
	arg_14_0.module[arg_14_0.currTab]:refresh()
end

function zbEquipListWnd.onDataUpdateAck(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.module) do
		iter_15_1:refreshDirtyFlag()
	end

	if arg_15_0.isShow then
		arg_15_0.module[arg_15_0.currTab]:refresh()
		arg_15_0.notify[arg_15_0.currTab]:setVisible(g_Self.kEquipFragHandler:hasFragNotify(arg_15_0.currTab) or g_Self.kBagEquipHandler:getCanEnchant(arg_15_0.currTab))
	end

	g_Self.kRedPointHandler:refreshEquip()
end

function zbEquipListWnd.onFrameUpdate(arg_16_0)
	arg_16_0:updateBackEffect()
end
