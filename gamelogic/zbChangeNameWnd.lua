require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbChangeNameWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createChangeNameWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/changename_sex.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.sexlayer = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.namelayer = tolua.cast(var_5_1:getChildByTag(3), "CCLayerColor")
		arg_3_0.signlayer = tolua.cast(var_5_1:getChildByTag(2), "CCLayerColor")
		arg_3_0.codelayer = tolua.cast(var_5_1:getChildByTag(4), "CCLayerColor")

		local var_5_2 = tolua.cast(arg_3_0.codelayer:getChildByTag(2), "CCLayer")
		local var_5_3 = 50
		local var_5_4 = ccc3(184, 167, 144)

		arg_3_0.inputBox_code = zbUtil:createEditBox(var_5_2, a2u("\xC7\xEB\xD4ڴ\xCB\xCA\xE4\xC8\xEB\xC4\xFA\xB5\xC4\xC0\xF1\xB0\xFC\xB6һ\xBB\xC2\xEB..."), var_5_3, "image/common/button_transparent.png", 22, var_5_4)

		local var_5_5 = var_5_2:getContentSize()

		arg_3_0.inputBox_code:setpLabelDimensions(CCSizeMake(var_5_5.width - 10, var_5_5.height - 10))
		var_5_2:addChild(arg_3_0.inputBox_code)

		arg_3_0.btnSure_code = tolua.cast(arg_3_0.codelayer:getChildByTag(1), "CCControlButton")
		arg_3_0.btnCancle_code = tolua.cast(arg_3_0.codelayer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSure_code:addHandleOfControlEvent(function()
			arg_3_0:onSure()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnCancle_code:addHandleOfControlEvent(function()
			arg_3_0:onCancle()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnSure_sign = tolua.cast(arg_3_0.signlayer:getChildByTag(11), "CCControlButton")
		arg_3_0.btnCancle_sign = tolua.cast(arg_3_0.signlayer:getChildByTag(10), "CCControlButton")

		arg_3_0.btnSure_sign:addHandleOfControlEvent(function()
			arg_3_0:onSure()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnCancle_sign:addHandleOfControlEvent(function()
			arg_3_0:onCancle()
		end, CCControlEventTouchUpInside)

		local var_5_6 = tolua.cast(arg_3_0.signlayer:getChildByTag(2), "CCLayer")
		local var_5_7 = 50
		local var_5_8 = ccc3(184, 167, 144)

		arg_3_0.inputBox_sign = zbUtil:createEditBox(var_5_6, "", var_5_7, "image/common/button_transparent.png", 22, var_5_8)

		local var_5_9 = var_5_6:getContentSize()

		arg_3_0.inputBox_sign:setpLabelDimensions(CCSizeMake(var_5_9.width - 10, var_5_9.height - 10))
		var_5_6:addChild(arg_3_0.inputBox_sign)

		arg_3_0.btnSure_name = tolua.cast(arg_3_0.namelayer:getChildByTag(1), "CCControlButton")

		arg_3_0.btnSure_name:addHandleOfControlEvent(function()
			arg_3_0:onSure()
		end, CCControlEventTouchUpInside)

		local var_5_10 = tolua.cast(arg_3_0.namelayer:getChildByTag(2), "CCLayer")
		local var_5_11 = 8
		local var_5_12 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_10, "", var_5_11, "image/common/button_transparent.png", 22, var_5_12)

		var_5_10:addChild(arg_3_0.inputBox)

		arg_3_0.lblcostMoney = tolua.cast(arg_3_0.namelayer:getChildByTag(3), "CCLabelTTF")

		arg_3_0.lblcostMoney:setString(100)

		arg_3_0.btnClose_name = tolua.cast(arg_3_0.namelayer:getChildByTag(4), "CCControlButton")

		arg_3_0.btnClose_name:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeSex = tolua.cast(arg_3_0.sexlayer:getChildByTag(3), "CCLayerColor")
		arg_3_0.checkBoy = {}
		arg_3_0.checkBoy[1] = tolua.cast(arg_3_0.nodeSex:getChildByTag(1), "CCControlButton")
		arg_3_0.checkBoy[2] = tolua.cast(arg_3_0.nodeSex:getChildByTag(2), "CCSprite")

		arg_3_0.checkBoy[1]:addHandleOfControlEvent(function()
			arg_3_0:onBoy()
		end, CCControlEventTouchUpInside)

		arg_3_0.checkGirl = {}
		arg_3_0.checkGirl[1] = tolua.cast(arg_3_0.nodeSex:getChildByTag(3), "CCControlButton")
		arg_3_0.checkGirl[2] = tolua.cast(arg_3_0.nodeSex:getChildByTag(4), "CCSprite")

		arg_3_0.checkGirl[1]:addHandleOfControlEvent(function()
			arg_3_0:onGirl()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnSure_sex = tolua.cast(arg_3_0.sexlayer:getChildByTag(11), "CCControlButton")
		arg_3_0.btnCancle_sex = tolua.cast(arg_3_0.sexlayer:getChildByTag(10), "CCControlButton")

		arg_3_0.btnSure_sex:addHandleOfControlEvent(function()
			arg_3_0:onSure()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnCancle_sex:addHandleOfControlEvent(function()
			arg_3_0:onCancle()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_17_0, arg_17_1)
	arg_17_0.type = arg_17_1

	arg_17_0.signlayer:setVisible(arg_17_0.type == EChangeBaseInfoType.E_SIGN)
	arg_17_0.namelayer:setVisible(arg_17_0.type == EChangeBaseInfoType.E_NAME)
	arg_17_0.sexlayer:setVisible(arg_17_0.type == EChangeBaseInfoType.E_SEX)
	arg_17_0.codelayer:setVisible(arg_17_0.type == EChangeBaseInfoType.E_CODE)

	if arg_17_0.type == EChangeBaseInfoType.E_NAME then
		arg_17_0.inputBox:setText(a2u(g_GameData.BaseInfo.RoleName))
	elseif arg_17_0.type == EChangeBaseInfoType.E_SEX then
		arg_17_0.checkGirl[2]:setVisible(g_GameData.BaseInfo.Sex == 0)
		arg_17_0.checkBoy[2]:setVisible(g_GameData.BaseInfo.Sex == 1)
	end
end

function var_0_0.onTouchTest(arg_18_0)
	local var_18_0 = arg_18_0.btnTouchTest:getTouch():getLocation()
	local var_18_1 = arg_18_0.namelayer

	if arg_18_0.type == EChangeBaseInfoType.E_SIGN then
		var_18_1 = arg_18_0.signlayer
	elseif arg_18_0.type == EChangeBaseInfoType.E_SEX then
		var_18_1 = arg_18_0.sexlayer
	elseif arg_18_0.type == EChangeBaseInfoType.E_CODE then
		var_18_1 = arg_18_0.codelayer
	end

	if zbUtil:PointInCtrl(var_18_1, var_18_0.x, var_18_0.y) == false then
		arg_18_0:hide()
	end
end

function var_0_0.onBoy(arg_19_0)
	arg_19_0.checkBoy[2]:setVisible(true)
	arg_19_0.checkGirl[2]:setVisible(false)
end

function var_0_0.onGirl(arg_20_0)
	arg_20_0.checkGirl[2]:setVisible(true)
	arg_20_0.checkBoy[2]:setVisible(false)
end

function var_0_0.onSure(arg_21_0)
	if arg_21_0.type == EChangeBaseInfoType.E_NAME then
		zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")

		local var_21_0 = string.trim(arg_21_0.inputBox:getText())

		if var_21_0 == "" then
			g_Bubble:bubbleInfo(a2u("\xCD\xE6\xBC\xD2\xC3\xFB\xB2\xBB\xC4\xDCΪ\xBF\xD5"))

			return
		end

		if zbUtil:isValidText(var_21_0) == false then
			g_Bubble:bubbleInfo(a2u("\xBA\xAC\xD3зǷ\xA8\xD7ַ\xFB"))

			return
		end

		if g_GameData.Wealth.Diamond < 100 then
			g_Bubble:bubbleInfo(a2u("û\xD3\xD0\xD7㹻\xB5\xC4\xD7\xEAʯ"))

			return
		end

		g_WsMsgHandler:WS_Common_SetRoleName_Req(a2u(var_21_0))
	elseif arg_21_0.type == EChangeBaseInfoType.E_SEX then
		if (arg_21_0.checkGirl[2]:isVisible() and 0 or 1) ~= g_GameData.BaseInfo.Sex then
			g_WsMsgHandler:WS_Common_SetSex_Req()
		end
	elseif arg_21_0.type == EChangeBaseInfoType.E_SIGN then
		local var_21_1 = arg_21_0.inputBox_sign:getText()

		g_WsMsgHandler:WS_Common_SetSignature_Req(a2u(var_21_1))
	elseif arg_21_0.type == EChangeBaseInfoType.E_CODE then
		local var_21_2 = arg_21_0.inputBox_code:getText()

		if var_21_2 == "" then
			g_Bubble:bubbleInfo(a2u("\xC7\xEB\xC0\xF1\xB0\xFC\xB6һ\xBB\xC2\xEB"))

			return
		end

		g_WsMsgHandler:WS_ActivityAct_RedeemCode_Req(a2u(var_21_2))
	end

	arg_21_0:hide()
end

function var_0_0.onCancle(arg_22_0)
	arg_22_0:hide()
end
