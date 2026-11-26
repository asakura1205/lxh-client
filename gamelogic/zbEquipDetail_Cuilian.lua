require("gamelogic.zbItem")
require("gamelogic.zbEquipDetail_CuilianItem")

local var_0_0 = 4

zbEquipDetail_Cuilian = class("zbEquipDetail_Cuilian")
zbEquipDetail_Cuilian.__index = zbEquipDetail_Cuilian

function zbEquipDetail_Cuilian.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.subNode = {}
		arg_1_0.awardItems = {}
		arg_1_0.subAttrName = {}
		arg_1_0.subCurrAttr = {}
		arg_1_0.subNextAttr = {}
		arg_1_0.count = {}
		arg_1_0.selectedList = {}
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.lbCurrpop = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbNextpop = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.subNode[1] = tolua.cast(arg_1_0.layer:getChildByTag(3), "CCNode")
		arg_1_0.subAttrName[1] = tolua.cast(arg_1_0.subNode[1]:getChildByTag(1), "CCLabelTTF")

		local var_3_0 = tolua.cast(arg_1_0.subNode[1]:getChildByTag(2), "CCLabelTTF")
		local var_3_1 = tolua.cast(arg_1_0.subNode[1]:getChildByTag(3), "CCLabelTTF")

		arg_1_0.subNode[2] = tolua.cast(arg_1_0.layer:getChildByTag(4), "CCNode")
		arg_1_0.subAttrName[2] = tolua.cast(arg_1_0.subNode[2]:getChildByTag(1), "CCLabelTTF")

		local var_3_2 = tolua.cast(arg_1_0.subNode[2]:getChildByTag(2), "CCLabelTTF")
		local var_3_3 = tolua.cast(arg_1_0.subNode[2]:getChildByTag(3), "CCLabelTTF")

		arg_1_0.subCurrAttr[1] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_0, arg_1_0.subCurrAttr[1])
		arg_1_0.subCurrAttr[1]:setScale(0.55)

		arg_1_0.subNextAttr[1] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_1, arg_1_0.subNextAttr[1])
		arg_1_0.subNextAttr[1]:setScale(0.55)

		arg_1_0.subCurrAttr[2] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_2, arg_1_0.subCurrAttr[2])
		arg_1_0.subCurrAttr[2]:setScale(0.55)

		arg_1_0.subNextAttr[2] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_3_3, arg_1_0.subNextAttr[2])
		arg_1_0.subNextAttr[2]:setScale(0.55)

		local var_3_4 = tolua.cast(arg_1_0.layer:getChildByTag(7), "CCNode")

		arg_1_0.lblexpAdd = {}
		arg_1_0.btnFrame = {}
		arg_1_0.items = {}

		for iter_3_0 = 1, 5 do
			arg_1_0.lblexpAdd[iter_3_0] = tolua.cast(var_3_4:getChildByTag(iter_3_0 + 9), "CCLabelTTF")
			arg_1_0.btnFrame[iter_3_0] = tolua.cast(var_3_4:getChildByTag(iter_3_0 + 99), "CCControlButton")

			local var_3_5 = tolua.cast(var_3_4:getChildByTag(iter_3_0), "CCLayerColor")
			local var_3_6 = createItem()
			local var_3_7 = ccp(var_3_5:getPosition())

			var_3_6:setPosition(var_3_7.x + 10, var_3_7.y + 20)
			var_3_6:setAnchorPoint(ccp(0.5, 0.5))
			var_3_6.btnFrame:setEnabled(false)
			var_3_4:addChild(var_3_6)

			arg_1_0.items[iter_3_0] = var_3_6

			arg_1_0.items[iter_3_0]:setScale(0.8)
			var_3_5:removeFromParentAndCleanup(true)
			arg_1_0.btnFrame[iter_3_0]:setTouchPriority(TOUCHPRIORITY_MIN)
			arg_1_0.btnFrame[iter_3_0]:addHandleOfControlEvent(function()
				arg_1_0:onTouchDown(iter_3_0)
			end, CCControlEventTouchDown)
			arg_1_0.btnFrame[iter_3_0]:addHandleOfControlEvent(function()
				arg_1_0:onTouchEnd(iter_3_0)
			end, CCControlEventTouchEnd)
			arg_1_0.btnFrame[iter_3_0]:addHandleOfControlEvent(function()
				arg_1_0:onTouch(iter_3_0)
			end, CCControlEventTouchUpInside)
			arg_1_0.btnFrame[iter_3_0]:addHandleOfControlEvent(function()
				arg_1_0:onTouch(iter_3_0)
			end, CCControlEventTouchUpOutside)
		end

		local var_3_8 = tolua.cast(arg_1_0.layer:getChildByTag(5), "CCNode")

		arg_1_0.progressBg = tolua.cast(var_3_8:getChildByTag(6), "CCSprite")
		arg_1_0.lbExp = tolua.cast(var_3_8:getChildByTag(7), "CCLabelTTF")
		arg_1_0.progressAdd = zbUtil:createProgressTimer(arg_1_0.progressBg, "image/equip/equip_progressadd.png")
		arg_1_0.progress = zbUtil:createProgressTimer(arg_1_0.progressBg, "image/equip/equip_progress.png")
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_Cuilian.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.heroTemplateId = arg_8_1
	arg_8_0.equip = arg_8_2

	local var_8_0 = zbItemTable:getRecord(arg_8_2.TemplateId)

	if var_8_0 == nil then
		echoInfo("fail to get item record: " .. tostring(arg_8_2.TemplateId))

		return
	end

	arg_8_0.equipRecord = var_8_0

	arg_8_0.lbCurrpop:setString(var_8_0.name)
	arg_8_0.lbNextpop:setString(var_8_0.name)

	local var_8_1 = zbColor:getItemColor(arg_8_2.Quality)

	arg_8_0.lbCurrpop:setColor(var_8_1)
	arg_8_0.lbNextpop:setColor(var_8_1)

	if arg_8_2.CLevel ~= 0 then
		arg_8_0.lbCurrpop:setString(var_8_0.name .. "+" .. arg_8_2.CLevel)
		arg_8_0.lbNextpop:setString(var_8_0.name .. "+" .. arg_8_2.CLevel + 1)
	end

	arg_8_0.subNode[1]:setVisible(false)
	arg_8_0.subNode[2]:setVisible(false)

	local var_8_2 = 1

	for iter_8_0, iter_8_1 in pairs(var_8_0.subAttrList) do
		local var_8_3 = a2u(getItemPropStr(iter_8_1.AttrType))

		arg_8_0.subAttrName[var_8_2]:setString(var_8_3 .. ":")

		if iter_8_1.AttrAdditionType == EAttrAdditionType.Fixed then
			arg_8_0.subCurrAttr[var_8_2]:setString("+" .. iter_8_1.AttrValue + arg_8_2.CLevel * iter_8_1.AttrValueGrow)
			arg_8_0.subNextAttr[var_8_2]:setString("+" .. iter_8_1.AttrValue + (arg_8_2.CLevel + 1) * iter_8_1.AttrValueGrow)
		else
			arg_8_0.subCurrAttr[var_8_2]:setString("+" .. (iter_8_1.AttrValue + arg_8_2.CLevel * iter_8_1.AttrValueGrow) * 100 .. "%")
			arg_8_0.subNextAttr[var_8_2]:setString("+" .. (iter_8_1.AttrValue + (arg_8_2.CLevel + 1) * iter_8_1.AttrValueGrow) * 100 .. "%")
		end

		arg_8_0.subNode[var_8_2]:setVisible(true)

		var_8_2 = var_8_2 + 1
	end

	local var_8_4 = zbEquipCuilianUpgradeTable:getRecordbyQuality(arg_8_2.CLevel, arg_8_2.Quality)
	local var_8_5 = math.min(math.ceil(100 * (arg_8_2.CExp / var_8_4)), 99)

	arg_8_0.progress:setPercentage(var_8_5)
	arg_8_0.progressAdd:setPercentage(0)
	arg_8_0.lbExp:setString(arg_8_2.CExp .. "/" .. var_8_4)
	arg_8_0:refreshCostItemInfo()
end

function zbEquipDetail_Cuilian.refreshCostItemInfo(arg_9_0)
	arg_9_0.costItem = zbItemTable:getEquipLevelUpItems()

	local var_9_0 = 1

	arg_9_0.itemcount = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.costItem) do
		if var_9_0 <= 5 then
			arg_9_0.lblexpAdd[var_9_0]:setString(iter_9_1.virtual)

			arg_9_0.count[var_9_0] = g_Self.kBagItemHandler:getItemCountByTemplateId(iter_9_1.id)

			arg_9_0.items[var_9_0]:refreshAward(ECommonAwardType.Item, iter_9_1.id, arg_9_0.count[var_9_0])
			arg_9_0.items[var_9_0]:setGray(arg_9_0.count[var_9_0] == 0)
			arg_9_0.items[var_9_0]:setNeedTip(false)

			arg_9_0.itemcount[var_9_0] = arg_9_0.count[var_9_0]
		end

		var_9_0 = var_9_0 + 1
	end
end

function zbEquipDetail_Cuilian.onLevelUp(arg_10_0, arg_10_1)
	if arg_10_0.selItemCount > 0 then
		local var_10_0 = {}

		if arg_10_0.heroTemplateId and arg_10_0.heroTemplateId > 0 then
			if arg_10_0.equip then
				var_10_0.SlotType = EEquipSlotType.Hero
				var_10_0.HeroTid = arg_10_0.heroTemplateId
				var_10_0.EquipId = arg_10_0.equip.EquipId
			end
		elseif arg_10_0.equip then
			var_10_0.SlotType = EEquipSlotType.Bag
			var_10_0.HeroTid = 0
			var_10_0.EquipId = arg_10_0.equip.EquipId
		end

		local var_10_1 = arg_10_0.costItem[arg_10_1].id

		g_WsMsgHandler:WS_Equip_Cuilian_Req(var_10_0, var_10_1, arg_10_0.selItemCount)
	end
end

function zbEquipDetail_Cuilian.onTouchDown(arg_11_0, arg_11_1)
	if arg_11_0.count[arg_11_1] <= 0 then
		arg_11_0.touchFlag = true

		g_MainScene:showGetWayWnd(arg_11_0.costItem[arg_11_1].id, ECommonAwardType.Item)

		return
	end

	if arg_11_0.equip.CLevel >= arg_11_0.equip.Level then
		arg_11_0.touchFlag = true

		g_Bubble:bubbleInfo(a2u("\xB4\xE3\xC1\xB6\xB5ȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFDװ\xB1\xB8\xB5ȼ\xB6"))

		return
	end

	arg_11_0.selItemCount = 1
	arg_11_0.currLevel = arg_11_0.equip.CLevel
	arg_11_0.currExp = arg_11_0.equip.CExp

	local var_11_0 = zbItemTable:getRecord(arg_11_0.costItem[arg_11_1].id)

	if var_11_0 == nil then
		return
	end

	local var_11_1 = CCArray:create()

	var_11_1:addObject(CCDelayTime:create(0.3))
	var_11_1:addObject(CCCallFuncN:create(function()
		arg_11_0:onAddExp(arg_11_1, var_11_0)
	end))

	local var_11_2 = CCSequence:create(var_11_1)

	arg_11_0.layer:stopAllActions()
	arg_11_0.layer:runAction(var_11_2)
end

function zbEquipDetail_Cuilian.onAddExp(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0
	local var_13_1 = 0

	local function var_13_2()
		if arg_13_0.currLevel >= arg_13_0.equip.Level then
			g_Bubble:bubbleInfo(a2u("\xB4\xE3\xC1\xB6\xB5ȼ\xB6\xB2\xBB\xC4ܳ\xAC\xB9\xFDװ\xB1\xB8\xB5ȼ\xB6"))
			arg_13_0.items[arg_13_1]:stopAllActions()

			return
		end

		var_13_0 = var_13_0 + 1

		if arg_13_0.count[arg_13_1] < var_13_0 then
			g_Bubble:bubbleInfo(a2u("\xB2\xC4\xC1\xCF\xD2\xD1\xD3\xC3\xCD\xEA"))
			arg_13_0.items[arg_13_1]:stopAllActions()

			return
		end

		arg_13_0.selItemCount = var_13_0

		arg_13_0.items[arg_13_1]:setItemNumber(arg_13_0.count[arg_13_1] - var_13_0)

		arg_13_0.currLevel, arg_13_0.currExp, var_13_1 = zbEquipCuilianUpgradeTable:getCanUpgradeLevel(arg_13_0.currLevel, arg_13_0.currExp, arg_13_2.virtual, arg_13_0.equip.Quality, arg_13_0.equip.Level)

		arg_13_0.lbNextpop:setString(arg_13_0.equipRecord.name .. "+" .. arg_13_0.currLevel)

		local var_14_0 = 1

		for iter_14_0, iter_14_1 in pairs(arg_13_0.equipRecord.subAttrList) do
			if iter_14_1.AttrAdditionType == EAttrAdditionType.Fixed then
				arg_13_0.subNextAttr[var_14_0]:setString("+" .. iter_14_1.AttrValue + arg_13_0.currLevel * iter_14_1.AttrValueGrow)
			else
				arg_13_0.subNextAttr[var_14_0]:setString("+" .. (iter_14_1.AttrValue + arg_13_0.currLevel * iter_14_1.AttrValueGrow) * 100 .. "%")
			end

			var_14_0 = var_14_0 + 1
		end

		local var_14_1 = math.min(math.ceil(100 * (arg_13_0.currExp / var_13_1)), 99)

		arg_13_0.progress:setPercentage(var_14_1)
		arg_13_0.lbExp:setString(arg_13_0.currExp .. "/" .. var_13_1)
	end

	local var_13_3 = CCArray:create()

	var_13_3:addObject(CCCallFuncN:create(function()
		var_13_2()
	end))
	var_13_3:addObject(CCDelayTime:create(0.005))

	local var_13_4 = CCSequence:create(var_13_3)

	arg_13_0.items[arg_13_1]:stopAllActions()
	arg_13_0.items[arg_13_1]:runAction(CCRepeatForever:create(var_13_4))
end

function zbEquipDetail_Cuilian.onTouchEnd(arg_16_0, arg_16_1)
	arg_16_0.touchFlag = false

	arg_16_0.items[arg_16_1]:stopAllActions()
	arg_16_0.items[arg_16_1]:setScale(0.8)
	arg_16_0.layer:stopAllActions()
end

function zbEquipDetail_Cuilian.onTouch(arg_17_0, arg_17_1)
	if arg_17_0.touchFlag == false then
		arg_17_0:onLevelUp(arg_17_1)
	elseif arg_17_0.count[arg_17_1] <= 0 then
		return
	end
end

function createEquipDetail_Cuilian(arg_18_0)
	local var_18_0 = zbEquipDetail_Cuilian.new()

	var_18_0:init(arg_18_0)

	return var_18_0
end
