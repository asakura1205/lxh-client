require("gamelogic.zbGuideDefine")

local var_0_0 = class("zbGuide")

var_0_0.__index = var_0_0

function createGuide()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.powerOn = true
	arg_2_0.steps = {}
	arg_2_0.stepsCreator = {}
	arg_2_0.curGuideStep = nil

	arg_2_0:registerGuide(GUIDE_STEP_STORY, function()
		require("gamelogic.zbGuideStory")

		return zbGuideStory:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_FRISTIN, function()
		require("gamelogic.zbGuideLevel001")

		return zbGuideLevel001:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_LEVEL002, function()
		require("gamelogic.zbGuideLevel002")

		return zbGuideLevel002:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_LEVEL003, function()
		require("gamelogic.zbGuideLevel003")

		return zbGuideLevel003:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_LEVEL004, function()
		require("gamelogic.zbGuideLevel004")

		return zbGuideLevel004:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_LEVEL005, function()
		require("gamelogic.zbGuideLevel005")

		return zbGuideLevel005:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_LEVEL006, function()
		require("gamelogic.zbGuideLevel006")

		return zbGuideLevel006:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_WEAREQUIP, function()
		require("gamelogic.zbGuideWearEquip")

		return zbGuideWearEquip:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_GOD, function()
		require("gamelogic.zbGuideGod")

		return zbGuideGod:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_DAILYTASK, function()
		require("gamelogic.zbGuideDailyTask")

		return zbGuideDailyTask:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_HEROTRAIL, function()
		require("gamelogic.zbGuideHeroTrail")

		return zbGuideHeroTrail:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_TECH, function()
		require("gamelogic.zbGuideTech")

		return zbGuideTech:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_HEROXIULIAN, function()
		require("gamelogic.zbGuideHeroXiuLian")

		return zbGuideHeroXiuLian:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_ELITELEVEL, function()
		require("gamelogic.zbGuideEliteLevel")

		return zbGuideEliteLevel:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_WORLD, function()
		require("gamelogic.zbGuideWorld")

		return zbGuideWorld:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_ARENA, function()
		require("gamelogic.zbGuideArena")

		return zbGuideArena:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_PATA, function()
		require("gamelogic.zbGuidePata")

		return zbGuidePata:create()
	end)
	arg_2_0:registerGuide(GUIDE_STEP_TUANSHU, function()
		require("gamelogic.zbGuideTuanShu")

		return zbGuideTuanShu:create()
	end)
end

function var_0_0.free(arg_21_0)
	return
end

function var_0_0.registerGuide(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.stepsCreator[arg_22_1] = arg_22_2
end

function var_0_0.execGuide(arg_23_0, arg_23_1)
	arg_23_0.curGuideStep = arg_23_0:getGuideStep(arg_23_1)

	if arg_23_0.curGuideStep ~= nil then
		arg_23_0.curGuideStep:start()
	end
end

function var_0_0.isGuiding(arg_24_0)
	return arg_24_0.curGuideStep ~= nil and arg_24_0.curGuideStep:isOver() == false
end

function var_0_0.update(arg_25_0, arg_25_1)
	if arg_25_0.curGuideStep ~= nil then
		arg_25_0.curGuideStep:update(arg_25_1)

		if arg_25_0.curGuideStep ~= nil and arg_25_0.curGuideStep:isOver() then
			arg_25_0.curGuideStep:stop()

			arg_25_0.curGuideStep = nil
		end
	end
end

function var_0_0.stopCurGuideStep(arg_26_0)
	if arg_26_0.curGuideStep ~= nil then
		arg_26_0.curGuideStep:stop()

		arg_26_0.curGuideStep = nil
	end

	g_MainScene:hideGuideWnd()

	if g_MainScene.wndGuide ~= nil then
		g_MainScene.wndGuide.watchNode = nil
		g_MainScene.wndGuide.watchWnd = nil
	end
end

function var_0_0.getGuideStep(arg_27_0, arg_27_1)
	if arg_27_0.steps[arg_27_1] == nil and arg_27_0.stepsCreator[arg_27_1] ~= nil then
		arg_27_0.steps[arg_27_1] = arg_27_0.stepsCreator[arg_27_1]()
	end

	return arg_27_0.steps[arg_27_1]
end

function var_0_0.getGuideStepPassed(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getGuideStep(arg_28_1)

	if var_28_0 == nil then
		return true
	end

	return var_28_0:isOver()
end

function var_0_0.checkEvent(arg_29_0, arg_29_1)
	if arg_29_0.curGuideStep ~= nil then
		arg_29_0.curGuideStep:checkEvent(arg_29_1)
	end
end

function var_0_0.notifyGuideWndHide(arg_30_0)
	if arg_30_0.curGuideStep ~= nil then
		arg_30_0.curGuideStep:onGuideWndHide()
	end
end
