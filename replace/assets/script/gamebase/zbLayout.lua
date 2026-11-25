zbLayout = class("zbLayout")
zbLayout.__index = zbLayout

function zbLayout.init(self)
	local view = CCEGLView:sharedOpenGLView()
	local frame = view:getFrameSize()

	self.DESIGN_WIDTH = 1136
	self.DESIGN_HEIGHT = 640
	self.FRAME_WIDTH = frame.width
	self.FRAME_HEIGHT = frame.height
	self.SCALE_X = self.FRAME_WIDTH / self.DESIGN_WIDTH
	self.SCALE_Y = self.FRAME_HEIGHT / self.DESIGN_HEIGHT

	echoInfo(string.format("FRAME_WIDTH=%d, FRAME_HEIGHT=%d", self.FRAME_WIDTH, self.FRAME_HEIGHT))

	-- Allow for the small difference between the design canvas and 16:9.
	self.fitToWidth = self.SCALE_Y > self.SCALE_X * 1.002
	if self.fitToWidth then
		self.SCALE_Y = self.SCALE_X
	end
end

function zbLayout.getScaleFactor(self)
	return self.SCALE_X, self.SCALE_Y
end

-- Existing callers use this predicate to select the centered, width-fit layout.
function zbLayout.isWHRatio4_3(self)
	return self.fitToWidth
end

function zbLayout.fullScreenWndOffsetY(self)
	return (self.FRAME_HEIGHT - self.DESIGN_HEIGHT * self.SCALE_Y) / 2
end

function zbLayout.POS(self, x, y)
	return ccp(x * self.SCALE_X, y * self.SCALE_Y + self:fullScreenWndOffsetY())
end

function zbLayout.RPOS(self, x, y)
	return ccp(x / self.SCALE_X, (y - self:fullScreenWndOffsetY()) / self.SCALE_Y)
end

function createLayout()
	local layout = zbLayout.new()
	layout:init()

	return layout
end
