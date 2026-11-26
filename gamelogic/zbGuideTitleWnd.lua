require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGuideTitleWnd", zbBaseWnd)

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

function createGuideTitleWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.talkData = nil
		arg_3_0.curStep = 0
		arg_3_0.talkOverCallback = nil
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCFadeTo:create(1.5, 255)
			local var_6_1 = CCFadeTo:create(1.5, 128)
			local var_6_2 = CCSequence:createWithTwoActions(var_6_0, var_6_1)

			arg_6_0:stopAllActions()
			arg_6_0:runAction(CCRepeatForever:create(var_6_2))
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/guide_title.ccbi", var_5_1, true, "")

		arg_3_0.layerBlack = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.layer = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnTouch = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.lbSubtitle = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbClickGo = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCLabelTTF")

		var_5_0(arg_3_0.lbClickGo)
		arg_3_0.btnTouch:setSoundTag(SOUNDTAG_GUIDE)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
end

function var_0_0.onHide(arg_9_0)
	if arg_9_0.talkOverCallback ~= nil then
		arg_9_0.talkOverCallback()
	end
end

function var_0_0.refresh(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.talkOverCallback = arg_10_2
	arg_10_0.talkData = g_DataConfig:getGuideTitle(arg_10_1)

	if arg_10_0.talkData == nil then
		echo("warning: invalid guide titleId: " .. arg_10_1)

		return
	end

	arg_10_0:setModel(true)
	arg_10_0:show(g_MainScene)
	arg_10_0:goto(1)
end

function var_0_0.goto(arg_11_0, arg_11_1)
	arg_11_0.curStep = arg_11_1

	local var_11_0 = arg_11_0.talkData[arg_11_0.curStep]

	if var_11_0 == nil then
		arg_11_0:hide()

		return
	end

	local var_11_1 = (function(arg_12_0)
		local var_12_0 = string.gsub(arg_12_0, "%[color=0x[%a%d]+%]", "")

		return (string.gsub(var_12_0, "%[/color%]", ""))
	end)(var_11_0.desc)

	arg_11_0.lbSubtitle:setString(a2u(var_11_1))
end

function var_0_0.onTouch(arg_13_0)
	arg_13_0:goto(arg_13_0.curStep + 1)
end
