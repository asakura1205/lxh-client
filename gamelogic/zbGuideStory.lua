require("gamelogic.zbGuideBase")

zbGuideStory = class("zbGuideStory", zbGuideBase)
zbGuideStory.__index = zbGuideStory

function zbGuideStory.create(arg_1_0)
	local var_1_0 = zbGuideStory.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideStory.initMy(arg_2_0)
	arg_2_0.preStepId = 0
end

function zbGuideStory.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideLxhVideoWnd()
end

function zbGuideStory.stop(arg_4_0)
	arg_4_0.guildOver = true
end

function zbGuideStory.update(arg_5_0, arg_5_1)
	return
end

function zbGuideStory.stepActive(arg_6_0)
	return
end
