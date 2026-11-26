require("gamelogic.zbItem")

local var_0_0 = class("zbGmActivityWnd_Double")

var_0_0.__index = var_0_0

function createGmActivityWnd_Double(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.doubleInfo = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.DoubleDrop) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.DoubleDrop) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.doubleInfo = iter_2_1

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
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_double.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.spriteDouble = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
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

	if arg_4_0.doubleInfo == nil then
		return
	end

	arg_4_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_4_0.doubleInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.doubleInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.doubleInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.doubleInfo.GmBaseInfo.ActEnd)))
	arg_4_0.lbDesc:setString(arg_4_0.doubleInfo.GmBaseInfo.Content)

	local var_4_0 = "image/gmactivity/double/double_type" .. arg_4_0.doubleInfo.Type .. ".png"

	arg_4_0.spriteDouble:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_0))
	arg_4_0.lbActivityDate:setString(a2u("\xBBʱ\xBC\xE4:") .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.doubleInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.doubleInfo.GmBaseInfo.ActEnd)))
end

function var_0_0.onGoto(arg_7_0)
	if arg_7_0.doubleInfo == nil then
		return
	end

	if arg_7_0.doubleInfo.Type == EActDoubleDropType.ForceNormal then
		zbLinkHelper:execLink("normalLevel")
	elseif arg_7_0.doubleInfo.Type == EActDoubleDropType.ForceElite then
		zbLinkHelper:execLink("eliteLevel")
	elseif arg_7_0.doubleInfo.Type == EActDoubleDropType.ForceNightmare then
		zbLinkHelper:execLink("nightmareLevel")
	elseif arg_7_0.doubleInfo.Type == EActDoubleDropType.HeroTrial then
		zbLinkHelper:execLink("trial")
	elseif arg_7_0.doubleInfo.Type == EActDoubleDropType.Pata then
		zbLinkHelper:execLink("pata")
	elseif arg_7_0.doubleInfo.Type == EActDoubleDropType.Bgz then
		zbLinkHelper:execLink("bgz")
	end

	g_MainScene.wndGmActivity:hide()
end
