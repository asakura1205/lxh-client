require("gamelogic.zbLegionHelp")

local var_0_0 = class("zbLegionWarReportItem")

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

function createLegionWarReportItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteLegion = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbLegion = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteLevel = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbCount)

		arg_3_0.lbScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbScore)
		arg_3_0.lbScore:setScale(0.5)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.Legion then
		local var_6_0 = zbIconHelper:getLegionIconPath(arg_6_1.Legion.IconId)

		arg_6_0.spriteLegion:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))
		zbLegionHelp:setLegionLvTexture(arg_6_0.spriteLevel, arg_6_1.Legion.Level)
		arg_6_0.lbLegion:setString(a2u(arg_6_1.Legion.LegionName))
		arg_6_0.lbCount:setString(arg_6_1.JoinCount)
		arg_6_0.lbScore:setString(arg_6_1.Score)
	end
end
