local var_0_0 = class("zbGmActivityWnd_HeroReset")

var_0_0.__index = var_0_0

function createGmActivityWnd_HeroReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.heroResetInfo = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.HeroReset) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.HeroReset) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.heroResetInfo = iter_2_1

				break
			end
		end
	end
end

function var_0_0.refresh(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_heroreset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.lbActivityDate = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_4_0.btnGoto = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")

		arg_4_0.btnGoto:addHandleOfControlEvent(function()
			arg_4_0:onGoto()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnGoto:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_4_0.btnGoto:setSwallowsTouches(false)
		arg_4_0.btnGoto:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
		CCLabelTTF:endDelayCreateTexture(var_5_1)
	end)()

	if arg_4_0.heroResetInfo == nil then
		return
	end

	arg_4_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_4_0.heroResetInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.heroResetInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.heroResetInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.heroResetInfo.GmBaseInfo.ActEnd)))
	arg_4_0.lbDesc:setString(arg_4_0.heroResetInfo.GmBaseInfo.Content)
	arg_4_0.lbActivityDate:setString(a2u("\xBBʱ\xBC\xE4:") .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.heroResetInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.heroResetInfo.GmBaseInfo.ActEnd)))
end

function var_0_0.onGoto(arg_7_0)
	if arg_7_0.heroResetInfo == nil then
		return
	end

	if g_Self.kGmActivityHandler:isShowTime(arg_7_0.heroResetInfo.GmBaseInfo.ActStart, arg_7_0.heroResetInfo.GmBaseInfo.ActEnd) == false then
		g_Bubble:bubbleInfo(a2u("\xBB\xB2\xBB\xD4\xDA\xD3\xD0Чʱ\xBC\xE4\xC4\xDA!"))

		return
	end

	zbLinkHelper:execLink("huilu")
	g_MainScene.wndGmActivity:hide()
end
