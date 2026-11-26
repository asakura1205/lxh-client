local function var_0_0(arg_1_0, arg_1_1)
	if arg_1_0 == CCControlEventTouchDown or arg_1_0 == CCControlEventTouchMove or arg_1_0 == CCControlEventTouchEnd then
		return
	end

	if arg_1_1 ~= nil and arg_1_1.getSoundTag ~= nil then
		local var_1_0 = ESoundTag[arg_1_1:getSoundTag()]

		if var_1_0 ~= nil then
			g_Audio:playSound(var_1_0)

			return
		end
	end

	g_Audio:playSound(AudioDefine.UI_CLICK)
end

function registerGlobalEventHook()
	CCLuaEngine:defaultEngine():setGlobalControlTouchHook(var_0_0)
end

function unregisterGlobalEventHook()
	CCLuaEngine:defaultEngine():setGlobalControlTouchHook(nil)
end
