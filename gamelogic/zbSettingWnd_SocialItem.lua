local var_0_0 = class("zbSettingWnd_SocialItem")

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createSetting_SocialItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.SocialData = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.socialIcon = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.lbDesc = tolua.cast(var_5_1:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.btnCare = tolua.cast(var_5_1:getChildByTag(3), "CCControlButton")

		arg_3_0.btnCare:addHandleOfControlEvent(function()
			arg_3_0:onCare()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.socialType = arg_7_1

	local var_7_0, var_7_1 = zbIconHelper:getSetSocialIconDesc(arg_7_1)

	arg_7_0.socialIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	arg_7_0.lbDesc:setString(var_7_1)
end

function var_0_0.onCare(arg_8_0)
	local var_8_0 = "http://weibo.com/lxhzjzb"

	if arg_8_0.socialType == ESocialType.BaiDu then
		var_8_0 = "http://tieba.baidu.com/f?kw=%E7%BD%97%E5%B0%8F%E9%BB%91%E6%88%98%E8%AE%B0%E5%A6%96%E7%81%B5%E7%B0%BF"
	elseif arg_8_0.socialType == ESocialType.WeiBo then
		var_8_0 = "http://weibo.com/lxhzjzb"
	elseif arg_8_0.socialType == ESocialType.WeiXin then
		var_8_0 = "http://mp.weixin.qq.com/s/UBV9G-G99e1QCDEbGU3inA"
	elseif arg_8_0.socialType == ESocialType.Magic then
		var_8_0 = "http://www.magicbai.com/forum.php/forum.php?mod=forumdisplay&fid=135"
	end

	zbGlobalUtil:GameCallSDKFunction("openurl", var_8_0, "")
end
