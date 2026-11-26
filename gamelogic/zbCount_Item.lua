require("gamebase.zbFunctions")

zbCount_Item = class("zbCount_Item", CCNodeExtend)
zbCount_Item.__index = zbCount_Item

function zbCount_Item.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbCount_Item)

	return arg_1_0
end

function zbCount_Item.create(arg_2_0, arg_2_1)
	local var_2_0 = zbCount_Item.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbCount_Item.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.successInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbKey = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbValue = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.progressNode = tolua.cast(var_5_0:getChildByTag(4), "CCNode")
		arg_3_0.progressBg = tolua.cast(arg_3_0.progressNode:getChildByTag(1), "CCSprite")
		arg_3_0.progress = tolua.cast(arg_3_0.progressNode:getChildByTag(2), "CCSprite")
		arg_3_0.lbProgressTxt = tolua.cast(arg_3_0.progressNode:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbProgress = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI").replaceCtrl(arg_3_0.lbProgressTxt, arg_3_0.lbProgress)
		arg_3_0.lbProgress:setScale(0.6)
		arg_3_0.lbProgress:setString("3/4")

		arg_3_0.moneyNode = tolua.cast(var_5_0:getChildByTag(5), "CCNode")
		arg_3_0.goldIcon = tolua.cast(arg_3_0.moneyNode:getChildByTag(1), "CCSprite")
		arg_3_0.goldTxt = tolua.cast(arg_3_0.moneyNode:getChildByTag(2), "CCLabelTTF")
		arg_3_0.diamondIcon = tolua.cast(arg_3_0.moneyNode:getChildByTag(3), "CCSprite")
		arg_3_0.diamondTxt = tolua.cast(arg_3_0.moneyNode:getChildByTag(4), "CCLabelTTF")
		arg_3_0.goldCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI").replaceCtrl(arg_3_0.goldTxt, arg_3_0.goldCount)
		arg_3_0.goldCount:setScale(0.8)
		arg_3_0.goldCount:setString("50")

		arg_3_0.diamondCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI").replaceCtrl(arg_3_0.diamondTxt, arg_3_0.diamondCount)
		arg_3_0.diamondCount:setScale(0.8)
		arg_3_0.diamondCount:setString("50")

		arg_3_0.starNode = tolua.cast(var_5_0:getChildByTag(6), "CCNode")
		arg_3_0.star = {}

		for iter_5_0 = 1, 5 do
			arg_3_0.star[iter_5_0] = tolua.cast(arg_3_0.starNode:getChildByTag(iter_5_0), "CCControlButton")

			arg_3_0.star[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_0)
			end, CCControlEventTouchDown)
			arg_3_0.star[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_0)
			end, CCControlEventTouchEnd)
		end

		arg_3_0.tipNode = tolua.cast(var_5_0:getChildByTag(7), "CCNode")
		arg_3_0.tip = tolua.cast(arg_3_0.tipNode:getChildByTag(7), "CCLabelTTF")

		arg_3_0.tipNode:setVisible(false)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(CCSizeMake(790, 105))
	end

	var_3_0()
	var_3_1()
end

function zbCount_Item.refresh(arg_8_0)
	return
end
