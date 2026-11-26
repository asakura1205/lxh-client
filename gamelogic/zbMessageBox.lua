require("gamelogic.CCRichLabelTTF")

zbMessageBox = {}
zbMessageBox.m_yesnoMsgBox = nil
EBoxType = {
	EBoxType_OK = 0,
	EBoxType_YESNO = 1
}
BaseBoxInfo = {
	_wnd,
	_back,
	_frame,
	_txt,
	_richtxt,
	_aniMgr,
	_type
}

function BaseBoxInfo.new(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}

	setmetatable(arg_1_1, arg_1_0)

	arg_1_0.__index = arg_1_0

	return arg_1_1
end

YesNoMsgBoxInfo = {
	_baseBoxInfo,
	_yesBtnHandle,
	_noBtnHandle
}

function zbMessageBox.hideByAni(arg_2_0, arg_2_1)
	local var_2_0 = CCArray:create()

	function CallFucn_ActionOver(arg_3_0)
		arg_2_1._wnd:setVisible(false)
		arg_2_1._wnd:removeFromParentAndCleanup(true)
	end

	var_2_0:addObject(CCCallFuncN:create(CallFucn_ActionOver))
	arg_2_1._frame:runAction(CCSequence:create(var_2_0))
end

local function var_0_0(arg_4_0)
	local var_4_0 = string.gsub(arg_4_0, "%[color=0x[%a%d]+%]", "")

	return (string.gsub(var_4_0, "%[/color%]", ""))
end

function zbMessageBox.showByAni(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1._wnd:isVisible() == true then
		arg_5_1._wnd:setVisible(false)
		arg_5_1._wnd:removeFromParentAndCleanup(true)
	end

	arg_5_1._wnd:setVisible(true)
	arg_5_1._txt:setString(var_0_0(arg_5_2))

	local var_5_0 = arg_5_1._txt:getTxtBound()
	local var_5_1 = arg_5_1._txt:getDimensions()

	echo("width = " .. var_5_0.width .. " height =" .. var_5_0.height)

	if var_5_0.width > var_5_1.width then
		var_5_0 = arg_5_1._txt:getTxtBound(var_5_1.width, 0)

		echo("new width = " .. var_5_0.width .. " height =" .. var_5_0.height)
	end

	if arg_5_1._type == EBoxType.EBoxType_OK then
		local var_5_2 = var_5_0.width + 100
		local var_5_3 = var_5_0.height + 100

		arg_5_1._frame:setContentSize(CCSizeMake(var_5_2, var_5_3))
	end

	if arg_5_1._richtxt ~= nil then
		arg_5_1._richtxt:removeFromParentAndCleanup(true)

		arg_5_1._richtxt = nil
	end

	arg_5_1._richtxt = CCRichLabelTTF:create(var_5_0.width, var_5_0.height, arg_5_1._txt:getFontSize(), arg_5_1._txt:getFontName(), ccc3(0, 0, 0), false)

	arg_5_1._richtxt:setRichString(arg_5_2)
	arg_5_1._richtxt:setPosition((var_5_1.width - var_5_0.width) / 2, (var_5_1.height - var_5_0.height) / 2)
	arg_5_1._txt:addChild(arg_5_1._richtxt)
	arg_5_1._wnd:doModel(CCDirector:sharedDirector():getRunningScene())
	arg_5_1._aniMgr:runAnimationsForSequenceNamed("appear")
end

function zbMessageBox.free(arg_6_0)
	if arg_6_0.m_yesnoMsgBox ~= nil then
		arg_6_0.m_yesnoMsgBox._baseBoxInfo._wnd:release()
	end
end

function zbMessageBox.createYesNoMsgBox(arg_7_0)
	local var_7_0 = YesNoMsgBoxInfo

	var_7_0._baseBoxInfo = BaseBoxInfo:new()
	var_7_0._baseBoxInfo._wnd = CCLayerModel:create()

	local var_7_1 = CCBProxy:create()
	local var_7_2, var_7_3 = CCBReaderLoad("ccbi/messagebox_yesno.ccbi", var_7_1, true, "")
	local var_7_4 = tolua.cast(var_7_2, "CCLayer")

	var_7_0._baseBoxInfo._back = tolua.cast(var_7_4:getChildByTag(2), "CCLayer")
	var_7_0._baseBoxInfo._frame = tolua.cast(var_7_4:getChildByTag(1), "CCLayer")
	var_7_0._baseBoxInfo._txt = tolua.cast(var_7_0._baseBoxInfo._frame:getChildByTag(1001), "CCLabelTTF")

	var_7_0._baseBoxInfo._txt:setOpacity(0)

	local var_7_5 = tolua.cast(var_7_3:getAnimationManagersForNodes(), "CCArray")

	var_7_0._baseBoxInfo._aniMgr = tolua.cast(var_7_5:objectAtIndex(0), "CCBAnimationManager")

	local var_7_6 = tolua.cast(var_7_0._baseBoxInfo._frame:getChildByTag(2), "CCControlButton")
	local var_7_7 = tolua.cast(var_7_0._baseBoxInfo._frame:getChildByTag(3), "CCControlButton")

	function OnYesBtn()
		if var_7_0._yesBtnHandle ~= nil then
			var_7_0._yesBtnHandle()

			var_7_0._yesBtnHandle = nil
		end

		arg_7_0:hideByAni(zbMessageBox.m_yesnoMsgBox._baseBoxInfo)
	end

	var_7_6:addHandleOfControlEvent(function()
		OnYesBtn()
	end, CCControlEventTouchUpInside)

	function OnNoBtn()
		if var_7_0._noBtnHandle ~= nil then
			var_7_0._noBtnHandle()

			var_7_0._noBtnHandle = nil
		end

		arg_7_0:hideByAni(zbMessageBox.m_yesnoMsgBox._baseBoxInfo, var_7_6, var_7_7)
	end

	var_7_7:addHandleOfControlEvent(function()
		OnNoBtn()
	end, CCControlEventTouchUpInside)

	var_7_0._baseBoxInfo._type = EBoxType.EBoxType_YESNO

	var_7_0._baseBoxInfo._wnd:bindChild(var_7_4)
	var_7_0._baseBoxInfo._wnd:retain()

	arg_7_0.m_yesnoMsgBox = var_7_0

	translateAndStrokeHelper(var_7_2)
end

function zbMessageBox.showYesNo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.m_yesnoMsgBox == nil then
		arg_12_0:createYesNoMsgBox()
	end

	arg_12_0:showByAni(arg_12_0.m_yesnoMsgBox._baseBoxInfo, a2u(arg_12_1))

	arg_12_0.m_yesnoMsgBox._yesBtnHandle = arg_12_2
	arg_12_0.m_yesnoMsgBox._noBtnHandle = arg_12_3
end
