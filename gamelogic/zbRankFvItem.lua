zbRankFvItem = class("zbRankFvItem", CCNodeExtend)
zbRankFvItem.__index = zbRankFvItem

function zbRankFvItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbRankFvItem)

	return arg_1_0
end

function zbRankFvItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbRankFvItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbRankFvItem.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbLegionName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteLegionLv = tolua.cast(var_5_0:getChildByTag(5), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(7), "CCLabelTTF")

		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.6)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.7)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(lbRankDummy, arg_3_0.lbRank)
		arg_3_0.btnTouch:setEnabled(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
	end

	var_3_0()
	var_3_1()
end

function zbRankFvItem.refresh(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return
	end

	local var_7_0 = zbIconHelper:getLegionIconPath(arg_7_1.IconId)

	arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	zbLegionHelp:setLegionLvTexture(arg_7_0.spriteLegionLv, arg_7_1.Level)
	arg_7_0.lbLegionName:setString(a2u(arg_7_1.LegionName))
	arg_7_0.lbRank:setString(arg_7_1.Rank)
	arg_7_0.lbNum:setString(arg_7_1.MemberCount .. "/" .. arg_7_1.MaxMemberCount)
	arg_7_0.lbPower:setString(arg_7_1.FV)
end
