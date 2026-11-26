zbGuideBase = class("zbGuideBase")
zbGuideBase.__index = zbGuideBase

function zbGuideBase.initBase(arg_1_0)
	arg_1_0.guildOver = true
	arg_1_0.preStepId = 0
	arg_1_0.subStep = 0
	arg_1_0.guideSection = ""
end

function zbGuideBase.isOver(arg_2_0)
	return arg_2_0.guildOver
end

function zbGuideBase.getPrefixSectionKey(arg_3_0)
	return g_GameData.BaseInfo.PlayerId .. "_" .. g_Login.lastServerId .. "_guide_"
end

function zbGuideBase.save(arg_4_0)
	local var_4_0 = arg_4_0:getPrefixSectionKey() .. arg_4_0.guideSection
	local var_4_1 = arg_4_0.subStep

	zbGameCore:Instance():setConfigValue(var_4_0, var_4_1)
end

function zbGuideBase.load(arg_5_0)
	local var_5_0 = arg_5_0:getPrefixSectionKey() .. arg_5_0.guideSection
	local var_5_1 = zbGameCore:Instance():getConfigValue(var_5_0)

	if var_5_1 ~= nil and var_5_1 ~= "" then
		arg_5_0.subStep = tonumber(var_5_1)
	end
end

function zbGuideBase.checkEvent(arg_6_0, arg_6_1)
	return
end

function zbGuideBase.onGuideWndHide(arg_7_0)
	return
end
