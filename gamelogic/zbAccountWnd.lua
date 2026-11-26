require("gamelogic.zbBaseWnd")
require("gamelogic.zbAcLoginNormal")
require("gamelogic.zbAcRegNormal")
require("gamelogic.zbAcBindMobile")
require("gamelogic.zbAcInputVrifyWnd")
require("gamelogic.zbAcSetPwd")
require("gamelogic.zbAcFindpwdBack")
require("gamelogic.zbAcUpwnd")
require("gamelogic.zbAcUpNormal")
require("gamelogic.zbAcInputAccodeWnd")

local var_0_0 = class("zbAccountWnd", zbBaseWnd)

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

function createAccountWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		g_bSetLabelStrok = false

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/account.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(100), "CCLayer")

		g_bSetLabelStrok = true
		arg_3_0.moudle = {}
		arg_3_0.TabLayer = {}
		arg_3_0.TabLayer[ELoginmoudle.Login] = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.NormalReg] = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.BindMobile] = tolua.cast(var_5_2:getChildByTag(4), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.FindbackPwd] = tolua.cast(var_5_2:getChildByTag(5), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.SetPwd] = tolua.cast(var_5_2:getChildByTag(6), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.InputVery] = tolua.cast(var_5_2:getChildByTag(7), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.AcUp] = tolua.cast(var_5_2:getChildByTag(8), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.AcUpNormal] = tolua.cast(var_5_2:getChildByTag(9), "CCLayer")
		arg_3_0.TabLayer[ELoginmoudle.AcCode] = tolua.cast(var_5_2:getChildByTag(10), "CCLayer")
		arg_3_0.moudle[ELoginmoudle.Login] = createLoginNormalWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.Login])
		arg_3_0.moudle[ELoginmoudle.NormalReg] = createRegNormalWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.NormalReg])
		arg_3_0.moudle[ELoginmoudle.BindMobile] = createBindMobileWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.BindMobile])
		arg_3_0.moudle[ELoginmoudle.InputVery] = createInputVeryWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.InputVery])
		arg_3_0.moudle[ELoginmoudle.SetPwd] = createSetpwdWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.SetPwd])
		arg_3_0.moudle[ELoginmoudle.FindbackPwd] = createAcFindpwdBackWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.FindbackPwd])
		arg_3_0.moudle[ELoginmoudle.AcUp] = createAcUpWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.AcUp])
		arg_3_0.moudle[ELoginmoudle.AcUpNormal] = createAcUpNormalWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.AcUpNormal])
		arg_3_0.moudle[ELoginmoudle.AcCode] = createInputAccodeWnd(arg_3_0, arg_3_0.TabLayer[ELoginmoudle.AcCode])

		arg_3_0:addChild(var_5_1)
		arg_3_0:showNormalLogin()
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function(arg_6_0)
		arg_3_0:onShowCallback()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:doHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onLoginSuc()
	end, zbGameEvent.Event_Account_Login)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRegisterAck()
	end, zbGameEvent.Event_Account_Register)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onAccountCheckAck()
	end, zbGameEvent.Event_Account_Check)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onCheckCodeAck()
	end, zbGameEvent.Event_Account_CheckCode)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBindPhoneAck()
	end, zbGameEvent.Event_Account_BindPhone)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBindVisitorAck()
	end, zbGameEvent.Event_Account_Up)
end

function var_0_0.onFrameUpdate(arg_14_0)
	arg_14_0.moudle[ELoginmoudle.InputVery]:update()
end

function var_0_0.reset(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.TabLayer) do
		if iter_15_1 then
			iter_15_1:setVisible(false)
		end
	end

	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(false)
	end
end

function var_0_0.doHide(arg_16_0)
	if g_GameStateMachine:getCurrStateId() == GameState_Login and g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(true)
	end
end

function var_0_0.onShowCallback(arg_17_0)
	if g_LoginScene.wndLogin then
		g_LoginScene.wndLogin:setNodeVisible(false)
	end
end

function var_0_0.showNormalReg(arg_18_0)
	arg_18_0:reset()
	arg_18_0.TabLayer[ELoginmoudle.NormalReg]:setVisible(true)
end

function var_0_0.showMobileReg(arg_19_0)
	g_Login.accountCheckType = E_AccountCheckType.E_MOBILE_REG

	arg_19_0:showFindbackPwd()
end

function var_0_0.showNormalLogin(arg_20_0)
	arg_20_0:reset()
	arg_20_0.TabLayer[ELoginmoudle.Login]:setVisible(true)
	arg_20_0.moudle[ELoginmoudle.Login]:setLoginAccountInfo()
end

function var_0_0.showBindMobile(arg_21_0)
	arg_21_0:reset()
	arg_21_0.TabLayer[ELoginmoudle.BindMobile]:setVisible(true)
end

function var_0_0.showInputAccode(arg_22_0)
	arg_22_0:reset()
	arg_22_0.TabLayer[ELoginmoudle.AcCode]:setVisible(true)
end

function var_0_0.showInputVrify(arg_23_0)
	arg_23_0:reset()
	arg_23_0.TabLayer[ELoginmoudle.InputVery]:setVisible(true)
	arg_23_0.moudle[ELoginmoudle.InputVery]:onGetVrify()
	arg_23_0.moudle[ELoginmoudle.InputVery]:setVerifyText()

	if g_Login.accountCheckType == E_AccountCheckType.E_NORMAL_BIND then
		arg_23_0.moudle[ELoginmoudle.InputVery]:setNextButtonTile(a2u("\xCD\xEA\xB3\xC9"))
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		if g_Login.accountUp_type == E_AccountUpPhone.E_NAME then
			arg_23_0.moudle[ELoginmoudle.InputVery]:setNextButtonTile(a2u("\xCD\xEA\xB3\xC9\xC9\xFD\xBC\xB6"))
		else
			arg_23_0.moudle[ELoginmoudle.InputVery]:setNextButtonTile(a2u("\xCF\xC2һ\xB2\xBD"))
		end
	else
		arg_23_0.moudle[ELoginmoudle.InputVery]:setNextButtonTile(a2u("\xCF\xC2һ\xB2\xBD"))
	end
end

function var_0_0.showSetPwd(arg_24_0)
	arg_24_0:reset()
	arg_24_0.TabLayer[ELoginmoudle.SetPwd]:setVisible(true)

	if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
		arg_24_0.moudle[ELoginmoudle.SetPwd]:setCompleteButtonTile(a2u("\xCD\xEA\xB3\xC9ע\xB2\xE1"))
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
		arg_24_0.moudle[ELoginmoudle.SetPwd]:setCompleteButtonTile(a2u("\xCD\xEA\xB3ɲ\xA2\xBD\xF8\xC8\xEB\xD3\xCEϷ"))
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		arg_24_0.moudle[ELoginmoudle.SetPwd]:setCompleteButtonTile(a2u("\xCD\xEA\xB3\xC9\xC9\xFD\xBC\xB6"))
	end
end

function var_0_0.showFindbackPwd(arg_25_0)
	arg_25_0:reset()
	arg_25_0.TabLayer[ELoginmoudle.FindbackPwd]:setVisible(true)

	if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
		arg_25_0.moudle[ELoginmoudle.FindbackPwd]:setTitle(a2u("\xCAֻ\xFAע\xB2\xE1"))
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
		arg_25_0.moudle[ELoginmoudle.FindbackPwd]:setTitle(a2u("\xD5һ\xD8\xC3\xDC\xC2\xEB"))
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		arg_25_0.moudle[ELoginmoudle.FindbackPwd]:setTitle(a2u("\xC9\xFD\xBC\xB6Ϊ\xCAֻ\xFA\xD5˺\xC5"))
	end
end

function var_0_0.showAcUp(arg_26_0)
	arg_26_0:reset()
	arg_26_0.TabLayer[ELoginmoudle.AcUp]:setVisible(true)
end

function var_0_0.showAcUpNormal(arg_27_0)
	arg_27_0:reset()
	arg_27_0.TabLayer[ELoginmoudle.AcUpNormal]:setVisible(true)
end

function var_0_0.onLoginSuc(arg_28_0)
	g_Login:saveAccountInfo()
	zbGlobalUtil:setLoginState(true)
	arg_28_0:hide()
end

function var_0_0.onRegisterAck(arg_29_0)
	if g_Login.account_type == E_AccountType.E_USER_NAME then
		arg_29_0:showBindMobile()
	else
		g_Login:login()
	end
end

function var_0_0.onAccountCheckAck(arg_30_0)
	arg_30_0:showInputVrify()
end

function var_0_0.onBindPhoneAck(arg_31_0)
	g_Login:login()
end

function var_0_0.completeNormalBindPhone(arg_32_0)
	local var_32_0 = zbGlobalUtil:getUserToken()
	local var_32_1 = zbGlobalUtil:getUserId()
	local var_32_2 = {
		appid = g_Login.appid,
		userid = var_32_1,
		token = var_32_0,
		account = g_Login.phoneregAc,
		account_type = E_AccountType.E_PHONE,
		check_code = g_Login.check_code
	}
	local var_32_3 = g_Login:getPostData(var_32_2)

	g_HttpMsgHandler:sendPostMsg(accountBindPost_url, var_32_3, E_ZB_MSG_BINDPHONE)
end

function var_0_0.completePhoneReg(arg_33_0)
	arg_33_0:showSetPwd()
end

function var_0_0.completeNamePhoneUp(arg_34_0)
	local var_34_0 = zbGlobalUtil:getUserToken()
	local var_34_1 = zbGlobalUtil:getUserId()
	local var_34_2 = {
		appid = g_Login.appid,
		userid = var_34_1,
		token = var_34_0,
		account = g_Login.phoneregAc,
		account_type = E_AccountType.E_PHONE,
		check_code = g_Login.check_code
	}
	local var_34_3 = g_Login:getPostData(var_34_2)

	g_HttpMsgHandler:sendPostMsg(accountBindPost_url, var_34_3, E_ZB_MSG_AC_UP)
end

function var_0_0.onCheckCodeAck(arg_35_0)
	if g_Login.accountCheckType == E_AccountCheckType.E_NORMAL_BIND then
		arg_35_0:completeNormalBindPhone()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
		arg_35_0:completePhoneReg()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
		arg_35_0:showSetPwd()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		if g_Login.accountUp_type == E_AccountUpPhone.E_NAME then
			arg_35_0:hide()
			arg_35_0:completeNamePhoneUp()
		else
			arg_35_0:showSetPwd()
		end
	end
end

function var_0_0.onBindVisitorAck(arg_36_0)
	arg_36_0:hide()
end
