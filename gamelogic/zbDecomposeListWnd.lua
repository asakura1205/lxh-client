require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbDecomposeListWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createDecomposeListWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	(function()
		local var_4_0 = CCBProxy:create()
		local var_4_1 = CCBReaderLoad("ccbi/decompose_list.ccbi", var_4_0, true, "HelloCocosBuilderLayerOwner")
		local var_4_2 = tolua.cast(var_4_1:getChildByTag(1), "CCNode")

		arg_3_0.hero_Decompose = tolua.cast(var_4_2:getChildByTag(1), "CCControlButton")
		arg_3_0.equip_Decompose = tolua.cast(var_4_2:getChildByTag(2), "CCControlButton")
		arg_3_0.gem_Decompose = tolua.cast(var_4_2:getChildByTag(3), "CCControlButton")
		arg_3_0.hero_Reset = tolua.cast(var_4_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btntouch = tolua.cast(var_4_1:getChildByTag(100), "CCControlButton")

		arg_3_0.btntouch:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.equip_Decompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onMenuDecomposeEquip), CCControlEventTouchUpInside)
		arg_3_0.hero_Decompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onMenuDecomposeHero), CCControlEventTouchUpInside)
		arg_3_0.gem_Decompose:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onMenuDecomposeGem), CCControlEventTouchUpInside)
		arg_3_0.hero_Reset:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onMenuHeroReset), CCControlEventTouchUpInside)

		arg_3_0.gemPoint = ccp(arg_3_0.gem_Decompose:getPosition())
		arg_3_0.heroPoint = ccp(arg_3_0.hero_Decompose:getPosition())
		arg_3_0.equipPoint = ccp(arg_3_0.equip_Decompose:getPosition())

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_4_1)
	end)()
end

function var_0_0.onMenuDecomposeEquip(arg_6_0)
	arg_6_0:hide()
	g_MainScene:showEquipDecompose()
end

function var_0_0.onMenuDecomposeHero(arg_7_0)
	arg_7_0:hide()
	g_MainScene:showHeroDecompose()
end

function var_0_0.onMenuHeroReset(arg_8_0)
	if g_Self.kGmActivityHandler:getGmActivityHeroReset() == nil then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xBB\xD8¯\xBB\xD4\xDDδ\xBF\xAA\xB7\xC5"))

		return
	end

	arg_8_0:hide()
	g_MainScene:showHeroReset()
end

function var_0_0.onMenuDecomposeGem(arg_9_0)
	arg_9_0:hide()
	g_MainScene:showGemsDecompose()
end

function var_0_0.refresh(arg_10_0)
	arg_10_0.hero_Reset:setGray(g_Self.kGmActivityHandler:getGmActivityHeroReset() == nil)
end

function var_0_0.onTouchTest(arg_11_0, arg_11_1, arg_11_2)
	if zbUtil:PointInCtrl(arg_11_0.equip_Decompose, arg_11_1, arg_11_2) or zbUtil:PointInCtrl(arg_11_0.hero_Decompose, arg_11_1, arg_11_2) or zbUtil:PointInCtrl(arg_11_0.hero_Back, arg_11_1, arg_11_2) or zbUtil:PointInCtrl(arg_11_0.gem_Decompose, arg_11_1, arg_11_2) then
		return true
	end

	return false
end
