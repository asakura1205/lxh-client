local var_0_0 = class("zbHeroCommentItem")

var_0_0.__index = var_0_0

local var_0_1 = {
	"image/hero/hero_zan1.png",
	"image/hero/hero_zan2.png"
}

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroCommentItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_0
		arg_3_0.spZan = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lblcontent = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lblrolename = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbltm = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.spSelfzan = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")
		arg_3_0.lblzanTimes = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.btnZan = tolua.cast(var_5_0:getChildByTag(7), "CCControlButton")

		arg_3_0.btnZan:addHandleOfControlEvent(function()
			arg_3_0:onZan()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.data = arg_7_1

	arg_7_0.layer:setVisible(arg_7_1 ~= nil)

	if arg_7_1 then
		arg_7_0.spZan:setVisible(arg_7_2 <= 3)
		arg_7_0.lblcontent:setString(a2u(arg_7_1.Content))
		arg_7_0.lblrolename:setString(a2u(arg_7_1.RoleName))
		arg_7_0.lbltm:setString(zbUtil:SprintfYYYYMMDD(arg_7_1.Tm))
		arg_7_0.lblzanTimes:setString(arg_7_1.ThumbCnt)

		if arg_7_1.hasThumb == 1 then
			arg_7_0.spSelfzan:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[2]))
		else
			arg_7_0.spSelfzan:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[1]))
		end
	end
end

function var_0_0.onZan(arg_8_0)
	if arg_8_0.data then
		if arg_8_0.data.hasThumb == 1 then
			g_Bubble:bubbleInfo(a2u("\xD2\xD1\xD4޹\xFD"))

			return
		end

		arg_8_0.spSelfzan:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[2]))
		arg_8_0.lblzanTimes:setString(arg_8_0.data.ThumbCnt + 1)
		g_WsMsgHandler:WS_HeroComment_Thumb_Req(g_Self.kHeroHandler.commentHeroTemlatedId, arg_8_0.data.UUID)
	end
end
