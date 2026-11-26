local var_0_0 = class("zbSubjectWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createSubjectWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

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

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.btnCount = 1
		arg_3_0.spriteSpecial = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/subject.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(100), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.spriteBg = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.spriteSpecial = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCSprite")
		arg_3_0.btnKnow = tolua.cast(var_5_2:getChildByTag(100), "CCControlButton")

		arg_3_0.btnKnow:addHandleOfControlEvent(function()
			arg_3_0:onKnow()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

local var_0_1 = {}

var_0_1[1] = "image/subject/subject1.jpg"
var_0_1[2] = "image/subject/subject2.jpg"

function var_0_0.refresh(arg_7_0)
	local var_7_0 = var_0_1[1]

	if var_7_0 then
		arg_7_0.spriteSpecial:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	end
end

function var_0_0.onKnow(arg_8_0)
	arg_8_0.btnCount = arg_8_0.btnCount + 1

	if arg_8_0.btnCount > table.getn(var_0_1) then
		arg_8_0:hide()

		return
	end

	local var_8_0 = var_0_1[arg_8_0.btnCount]

	if var_8_0 then
		arg_8_0.spriteSpecial:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	end
end
