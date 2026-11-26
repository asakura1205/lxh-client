require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbTechListWnd", zbBaseWnd)

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

function createTechListWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	(function()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setPosition(130, 150)
			var_5_0:setVisible(false)
			arg_5_0:addChild(var_5_0)
			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		local var_4_1 = CCBProxy:create()
		local var_4_2 = CCBReaderLoad("ccbi/techList.ccbi", var_4_1, true, "HelloCocosBuilderLayerOwner")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCNode")

		arg_3_0.btn_herosoul = tolua.cast(var_4_3:getChildByTag(2), "CCControlButton")
		arg_3_0.btn_tech = tolua.cast(var_4_3:getChildByTag(1), "CCControlButton")
		arg_3_0.btntouch = tolua.cast(var_4_2:getChildByTag(100), "CCControlButton")

		arg_3_0.btntouch:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btn_herosoul:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onHerosoul), CCControlEventTouchUpInside)
		arg_3_0.btn_tech:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.onZhanxing), CCControlEventTouchUpInside)

		arg_3_0.herosoulNotify = var_4_0(arg_3_0.btn_herosoul)
		arg_3_0.techNotify = var_4_0(arg_3_0.btn_tech)

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_4_2)
	end)()
end

function var_0_0.onHerosoul(arg_7_0)
	if zbFunHelper:isLockAndTip(EFuncType.HeroSoul) then
		return
	end

	arg_7_0:hide()
	g_MainScene:showHeroSoulHall()
end

function var_0_0.onZhanxing(arg_8_0)
	if zbFunHelper:isLockAndTip(EFuncType.Tech) then
		return
	end

	arg_8_0:hide()
	g_MainScene:showTechWnd()
end

function var_0_0.updateNotify(arg_9_0)
	arg_9_0.techNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Tech))
	arg_9_0.herosoulNotify:setVisible(g_Self.kHeroSoulHallHandler:hasHeroSoulHall())
end

function var_0_0.refresh(arg_10_0)
	arg_10_0:updateNotify()
	arg_10_0.btn_herosoul:setGray(zbFunHelper:isLockNoTip(EFuncType.HeroSoul))
	arg_10_0.btn_tech:setGray(zbFunHelper:isLockNoTip(EFuncType.Tech))
end

function var_0_0.onTouchTest(arg_11_0, arg_11_1, arg_11_2)
	if zbUtil:PointInCtrl(arg_11_0.btn_herosoul, arg_11_1, arg_11_2) or zbUtil:PointInCtrl(arg_11_0.btn_tech, arg_11_1, arg_11_2) then
		return true
	end

	return false
end
