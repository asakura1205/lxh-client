zbLuaErrorDialog = {}

function zbLuaErrorDialog.init(arg_1_0)
	local var_1_0 = CCBProxy:create()
	local var_1_1, var_1_2 = CCBReaderLoad("ccbi/lua_error_dialog.ccbi", var_1_0, true, "HelloCocosBuilderLayerOwner")
	local var_1_3 = tolua.cast(var_1_1, "CCLayer")

	arg_1_0.content = tolua.cast(var_1_3:getChildByTag(1):getChildByTag(1001), "CCLabelTTF")
	arg_1_0.exitBtn = tolua.cast(var_1_3:getChildByTag(1):getChildByTag(101), "CCControlButton")

	arg_1_0.exitBtn:addHandleOfControlEvent(function()
		arg_1_0:hide()
	end, CCControlEventTouchUpInside)

	arg_1_0.layer = var_1_3

	arg_1_0.layer:retain()

	arg_1_0.modelLayer = CCLayerModel:create()

	arg_1_0.modelLayer:retain()
	arg_1_0.modelLayer:bindChild(arg_1_0.layer)
	arg_1_0.layer:setVisible(false)
end

function zbLuaErrorDialog.free(arg_3_0)
	arg_3_0:hide()
	arg_3_0.modelLayer:release()
end

function zbLuaErrorDialog.show(arg_4_0, arg_4_1)
	if zbGlobalUtil:getTargetPlatform() == "ios" or zbGlobalUtil:getTargetPlatform() == "android" then
		return
	end

	arg_4_0:hide()
	arg_4_0.content:setString(arg_4_1)
	arg_4_0.layer:setVisible(true)
	arg_4_0.modelLayer:doModel(CCDirector:sharedDirector():getRunningScene())
end

function zbLuaErrorDialog.hide(arg_5_0)
	arg_5_0.layer:setVisible(false)
	arg_5_0.modelLayer:exitModel()
end

function createLuaErrorDialog()
	zbLuaErrorDialog:init()

	return zbLuaErrorDialog
end
