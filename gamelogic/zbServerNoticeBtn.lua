local var_0_0 = class("zbServerNoticeBtn", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = {
	"ui/image/common/btnsharp250_80_blue.png",
	"ui/image/common/btnsharp250_80_gold.png"
}
local var_0_2 = {
	"ui/image/login/noticestate2.png",
	"ui/image/login/noticestate1.png"
}

function createServerNoticeBtn(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0, arg_1_1)

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

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.parent = arg_3_2
		arg_3_0.noticeDetail = nil
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.btnFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCControlButton")
		arg_3_0.lbTitle = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteHotNew = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")

		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(false)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(arg_3_0.layerContent:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.noticeDetail = arg_7_1

		arg_7_0.lbTitle:setString(a2u(arg_7_1.SubTitle))
		arg_7_0.spriteHotNew:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_2[arg_7_1.Status]))
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.noticeDetail then
		arg_8_0.parent:onNoticeSel(arg_8_0.noticeDetail.SortId)
	end
end

function var_0_0.setItemSelected(arg_9_0, arg_9_1)
	if arg_9_0.noticeDetail == nil then
		return
	end

	local var_9_0 = false

	if arg_9_1 == arg_9_0.noticeDetail.SortId then
		var_9_0 = true
	end

	local var_9_1 = var_0_1[1]

	if var_9_0 then
		var_9_1 = var_0_1[2]
	end

	ui:setButtonPic(arg_9_0.btnFrame, var_9_1, var_9_1, var_9_1)
end
