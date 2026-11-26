zbLayout = class("zbLayout")
zbLayout.__index = zbLayout

function zbLayout.init(arg_1_0)
	local var_1_0 = CCEGLView:sharedOpenGLView()
	local var_1_1 = CCRectMake(0, 0, 0, 0)

	var_1_1.origin = var_1_0:getVisibleOrigin()
	var_1_1.size = var_1_0:getVisibleSize()
	arg_1_0.DESIGN_WIDTH = 1136
	arg_1_0.DESIGN_HEIGHT = 640
	arg_1_0.FRAME_WIDTH = var_1_0:getFrameSize().width
	arg_1_0.FRAME_HEIGHT = var_1_0:getFrameSize().height
	arg_1_0.SCALE_X = arg_1_0.FRAME_WIDTH / arg_1_0.DESIGN_WIDTH
	arg_1_0.SCALE_Y = arg_1_0.FRAME_HEIGHT / arg_1_0.DESIGN_HEIGHT

	echoInfo(string.format("FRAME_WIDTH=%d, FRAME_HEIGHT=%d", arg_1_0.FRAME_WIDTH, arg_1_0.FRAME_HEIGHT))

	arg_1_0.bWHRatio4_3 = arg_1_0.FRAME_WIDTH * 3 - arg_1_0.FRAME_HEIGHT * 4 <= 0.0001

	if arg_1_0.bWHRatio4_3 then
		arg_1_0.SCALE_Y = arg_1_0.SCALE_X
	end
end

function zbLayout.getScaleFactor(arg_2_0)
	return arg_2_0.SCALE_X, arg_2_0.SCALE_Y
end

function zbLayout.isWHRatio4_3(arg_3_0)
	return arg_3_0.bWHRatio4_3
end

function zbLayout.fullScreenWndOffsetY(arg_4_0)
	if not arg_4_0.bWHRatio4_3 then
		return 0
	end

	local var_4_0 = arg_4_0.FRAME_HEIGHT / arg_4_0.DESIGN_HEIGHT

	return arg_4_0.DESIGN_HEIGHT * (var_4_0 - arg_4_0.SCALE_Y) / 2
end

function zbLayout.POS(arg_5_0, arg_5_1, arg_5_2)
	return ccp(arg_5_1 * arg_5_0.SCALE_X, arg_5_2 * arg_5_0.SCALE_Y + arg_5_0:fullScreenWndOffsetY())
end

function zbLayout.RPOS(arg_6_0, arg_6_1, arg_6_2)
	return ccp(arg_6_1 / arg_6_0.SCALE_X, arg_6_2 / arg_6_0.SCALE_Y - arg_6_0:fullScreenWndOffsetY())
end

function createLayout()
	local var_7_0 = zbLayout.new()

	var_7_0:init()

	return var_7_0
end
