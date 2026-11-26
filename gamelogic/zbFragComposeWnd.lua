require("gamelogic.zbBaseWnd")

zbFragComposeWnd = class("zbFragComposeWnd", zbBaseWnd)
zbFragComposeWnd.__index = zbFragComposeWnd

function zbFragComposeWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFragComposeWnd)

	return arg_1_0
end

function createFragComposeWnd()
	local var_2_0 = zbFragComposeWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbFragComposeWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.EquipFragData = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/fragCompose.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.useItem = {}

		for iter_5_0 = 1, 2 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLayer")

			var_5_3:setVisible(false)

			arg_3_0.useItem[iter_5_0] = createItem()

			local var_5_4 = ccp(var_5_3:getPosition())

			arg_3_0.useItem[iter_5_0]:setPosition(var_5_3:getPosition())
			arg_3_0.useItem[iter_5_0]:setNeedTip(true)
			arg_3_0.useItem[iter_5_0]:setScale(0.8)
			var_5_2:addChild(arg_3_0.useItem[iter_5_0])
		end

		arg_3_0.lbOwnNum = tolua.cast(var_5_2:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbComposeName = tolua.cast(var_5_2:getChildByTag(12), "CCLabelTTF")
		arg_3_0.nodeMoney = tolua.cast(var_5_2:getChildByTag(10), "CCNode")
		arg_3_0.bmComposePrice = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.btnCompose = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")

		arg_3_0.btnCompose:addHandleOfControlEvent(function()
			arg_3_0:onCompose()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_Hero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_FragEquip)
end

function zbFragComposeWnd.refresh(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.fragData = arg_11_1
	arg_11_0.itemType = arg_11_2

	if arg_11_2 == ELinkType.Hero then
		arg_11_0:refreshHero()
	elseif arg_11_2 == ELinkType.Equip then
		arg_11_0:refreshEquip()
	end
end

function zbFragComposeWnd.refreshHero(arg_12_0)
	if arg_12_0.fragData == nil then
		return
	end

	arg_12_0.record = zbHeroTable:getRecord(arg_12_0.fragData.TemplateId)

	if arg_12_0.record == nil then
		return
	end

	arg_12_0.lbComposeName:setString(arg_12_0.record.name)

	local var_12_0 = zbColor:getHeroNameColor(arg_12_0.record.quality)

	arg_12_0.lbComposeName:setColor(var_12_0)
	arg_12_0.useItem[1]:refreshAward(ECommonAwardType.HeroFrag, arg_12_0.fragData.TemplateId, 0, false)
	arg_12_0.useItem[2]:refreshAward(ECommonAwardType.Hero, arg_12_0.fragData.TemplateId, 0, false)

	local var_12_1 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_12_0.fragData.TemplateId)

	arg_12_0.lbOwnNum:setString(string.format("%d/%d", arg_12_0.fragData.Count, var_12_1.needFrag))
	arg_12_0.nodeMoney:setVisible(false)
end

function zbFragComposeWnd.refreshEquip(arg_13_0)
	if arg_13_0.fragData == nil then
		return
	end

	arg_13_0.record = zbItemTable:getRecord(arg_13_0.fragData.TemplateId)

	if arg_13_0.record == nil then
		return
	end

	arg_13_0.lbComposeName:setString(arg_13_0.record.name)

	local var_13_0 = zbColor:getItemColor(arg_13_0.record.quality)

	arg_13_0.lbComposeName:setColor(var_13_0)
	arg_13_0.useItem[1]:refreshAward(ECommonAwardType.EquipFrag, arg_13_0.fragData.TemplateId, 0, false, false)
	arg_13_0.useItem[2]:refreshAward(ECommonAwardType.Item, arg_13_0.fragData.TemplateId, 0, false, false)

	local var_13_1, var_13_2 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_13_0.fragData.TemplateId)

	arg_13_0.lbOwnNum:setString(string.format("%d/%d", arg_13_0.fragData.Count, var_13_1))
	arg_13_0.nodeMoney:setVisible(true)
	arg_13_0.bmComposePrice:setString(var_13_2)
end

function zbFragComposeWnd.onCompose(arg_14_0)
	if arg_14_0.fragData ~= nil then
		if arg_14_0.itemType == ELinkType.Hero then
			local var_14_0 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_14_0.fragData.TemplateId)

			if arg_14_0.fragData.Count < var_14_0.needFrag then
				-- block empty
			else
				g_WsMsgHandler:WS_HeroFrag_Compose_Req(arg_14_0.fragData.TemplateId)
			end
		elseif arg_14_0.itemType == ELinkType.Equip then
			local var_14_1, var_14_2 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_14_0.fragData.TemplateId)

			if var_14_1 > arg_14_0.fragData.Count then
				-- block empty
			else
				g_WsMsgHandler:WS_Equip_Compose_Req(arg_14_0.fragData.TemplateId)
			end
		end
	end
end

function zbFragComposeWnd.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layerTouchTest, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end

function zbFragComposeWnd.refreshUpdate(arg_16_0)
	if arg_16_0.isShow == false then
		return
	end

	if arg_16_0.itemType == ELinkType.Hero then
		arg_16_0:hide()
	elseif arg_16_0.itemType == ELinkType.Equip then
		arg_16_0.fragData = g_Self.kEquipFragHandler:getEquipFragData(arg_16_0.fragData.TemplateId)

		if arg_16_0.fragData ~= nil then
			arg_16_0:refreshEquip()
		else
			arg_16_0:hide()
		end
	end
end
