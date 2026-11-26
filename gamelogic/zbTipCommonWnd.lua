require("gamelogic.zbBaseWnd")
require("gamelogic.zbTipCommonWnd_Equip")
require("gamelogic.zbTipCommonWnd_Money")
require("gamelogic.zbTipCommonWnd_Frag")
require("gamelogic.zbTipCommonWnd_Item")
require("gamelogic.zbTipCommonWnd_Skill")
require("gamelogic.zbTipCommonWnd_godEquipSkill")

local var_0_0 = class("zbTipCommonWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createTipCommonWnd()
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
		arg_3_0.contentSizeHeight = 0
		arg_3_0.contentSizeWidth = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/tips.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCLayer")

		arg_3_0.layerMoney = createTipCommonWndMoney(tolua.cast(var_5_2:getChildByTag(1), "CCNode"), var_5_1)
		arg_3_0.layerItem = createTipCommonWndItem(tolua.cast(var_5_2:getChildByTag(2), "CCNode"), var_5_1)
		arg_3_0.layerEquip = createTipCommonWndEquip(tolua.cast(var_5_2:getChildByTag(3), "CCNode"), var_5_1)
		arg_3_0.layerFrag = createTipCommonWndFrag(tolua.cast(var_5_2:getChildByTag(4), "CCNode"), var_5_1)
		arg_3_0.layerSkill = createTipCommonWndSkill(tolua.cast(var_5_2:getChildByTag(5), "CCNode"), var_5_1)
		arg_3_0.layerGodequipSkill = createTipCommonWndgodEquipSkill(tolua.cast(var_5_2:getChildByTag(6), "CCNode"), var_5_1)

		arg_3_0:addChild(var_5_2)

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.showHeroTips(arg_7_0, arg_7_1)
	arg_7_0:hideLayer()
	arg_7_0.layerItem:refreshHero(arg_7_1)

	arg_7_0.contentSizeHeight = arg_7_0.layerItem.contentSizeHeight
	arg_7_0.contentSizeWidth = arg_7_0.layerItem.contentSizeWidth
end

function var_0_0.showAwardTips(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:hideLayer()

	if arg_8_1 == ECommonAwardType.Gold or arg_8_1 == ECommonAwardType.Diamond or arg_8_1 == ECommonAwardType.Food or arg_8_1 == ECommonAwardType.Tili or arg_8_1 == ECommonAwardType.BarCard or arg_8_1 == ECommonAwardType.Soul or arg_8_1 == ECommonAwardType.BarMoney or arg_8_1 == ECommonAwardType.EquipSoul or arg_8_1 == ECommonAwardType.Arena or arg_8_1 == ECommonAwardType.Bgz or arg_8_1 == ECommonAwardType.Legion or arg_8_1 == ECommonAwardType.Horn or arg_8_1 == ECommonAwardType.RoleExp or arg_8_1 == ECommonAwardType.VipExp then
		arg_8_0.layerMoney:refresh(arg_8_1, arg_8_2)

		arg_8_0.contentSizeHeight = arg_8_0.layerMoney.contentSizeHeight
		arg_8_0.contentSizeWidth = arg_8_0.layerMoney.contentSizeWidth
	elseif arg_8_1 == ECommonAwardType.Hero then
		arg_8_0.layerItem:refreshHeroTemplate(arg_8_1, arg_8_2)

		arg_8_0.contentSizeHeight = arg_8_0.layerItem.contentSizeHeight
		arg_8_0.contentSizeWidth = arg_8_0.layerItem.contentSizeWidth
	elseif arg_8_1 == ECommonAwardType.Item then
		if zbItemTable:IsConsumItem(arg_8_2) then
			arg_8_0.layerItem:refresh(arg_8_1, arg_8_2)

			arg_8_0.contentSizeHeight = arg_8_0.layerItem.contentSizeHeight
			arg_8_0.contentSizeWidth = arg_8_0.layerItem.contentSizeWidth
		else
			arg_8_0.layerEquip:refresh(arg_8_1, arg_8_2)

			arg_8_0.contentSizeHeight = arg_8_0.layerEquip.contentSizeHeight
			arg_8_0.contentSizeWidth = arg_8_0.layerEquip.contentSizeWidth
		end
	elseif arg_8_1 == ECommonAwardType.EquipFrag or arg_8_1 == ECommonAwardType.HeroFrag then
		arg_8_0.layerFrag:refresh(arg_8_1, arg_8_2)

		arg_8_0.contentSizeHeight = arg_8_0.layerFrag.contentSizeHeight
		arg_8_0.contentSizeWidth = arg_8_0.layerFrag.contentSizeWidth
	end
end

function var_0_0.showSkillTips(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:hideLayer()

	if arg_9_1 == nil or arg_9_2 == nil then
		return
	end

	arg_9_0.layerSkill:refresh(arg_9_1, arg_9_2)

	arg_9_0.contentSizeHeight = arg_9_0.layerSkill.contentSizeHeight
	arg_9_0.contentSizeWidth = arg_9_0.layerSkill.contentSizeWidth
end

function var_0_0.showGodEquipSkillTips(arg_10_0, arg_10_1)
	arg_10_0:hideLayer()

	if arg_10_1 == nil then
		return
	end

	arg_10_0.layerGodequipSkill:refresh(arg_10_1)

	arg_10_0.contentSizeHeight = arg_10_0.layerGodequipSkill.contentSizeHeight
	arg_10_0.contentSizeWidth = arg_10_0.layerGodequipSkill.contentSizeWidth
end

function var_0_0.hideTips(arg_11_0)
	arg_11_0:hide()
end

function var_0_0.hideLayer(arg_12_0)
	arg_12_0.layerMoney.layer:setVisible(false)
	arg_12_0.layerItem.layer:setVisible(false)
	arg_12_0.layerEquip.layer:setVisible(false)
	arg_12_0.layerFrag.layer:setVisible(false)
	arg_12_0.layerSkill.layer:setVisible(false)
	arg_12_0.layerGodequipSkill.layer:setVisible(false)
end

function var_0_0.refreshPos(arg_13_0, arg_13_1)
	arg_13_1.y = arg_13_1.y - g_Layout:fullScreenWndOffsetY()
	arg_13_0.contentSizeHeight = arg_13_0.contentSizeHeight + 50

	local var_13_0 = arg_13_1

	if arg_13_1.y + arg_13_0.contentSizeHeight <= zbUtil:getScreenSize().height then
		var_13_0 = ccp(arg_13_1.x, arg_13_1.y + 50)
	elseif arg_13_1.y - arg_13_0.contentSizeHeight < 0 then
		var_13_0 = ccp(arg_13_1.x - arg_13_0.contentSizeWidth * 0.5, 0)
	else
		var_13_0 = ccp(arg_13_1.x - arg_13_0.contentSizeWidth * 0.5, arg_13_1.y - arg_13_0.contentSizeHeight)
	end

	if var_13_0.x - arg_13_0.contentSizeWidth * 0.5 < 0 then
		var_13_0.x = arg_13_0.contentSizeWidth * 0.5
	elseif var_13_0.x + arg_13_0.contentSizeWidth * 0.5 > zbUtil:getScreenSize().width then
		var_13_0.x = zbUtil:getScreenSize().width - arg_13_0.contentSizeWidth * 0.5
	end

	arg_13_0:setPosition(var_13_0)
end

function var_0_0.onTouchTest(arg_14_0)
	arg_14_0:hideTips()
end
