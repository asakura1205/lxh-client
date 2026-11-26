local var_0_0 = class("zbLegionRedRankItem")

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

function createLegionRedRankItem(arg_2_0)
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

		arg_3_0.spriteRank = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbRank = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteMoney = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.65)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == nil or arg_6_2 == nil or arg_6_3 == nil then
		return
	end

	if arg_6_2 == ELegionHongbaoType.SeniorGold or arg_6_2 == ELegionHongbaoType.SupreGold then
		arg_6_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_gold.png"))
	elseif arg_6_2 == ELegionHongbaoType.SeniorDiamond or arg_6_2 == ELegionHongbaoType.SupreDiamond then
		arg_6_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_diamond.png"))
	end

	if arg_6_3 > 3 then
		arg_6_0.spriteRank:setVisible(false)
		arg_6_0.lbRank:setVisible(true)
		arg_6_0.lbRank:setString(a2u("\xB5\xDA") .. arg_6_3 .. a2u("\xC3\xFB"))
	else
		arg_6_0.spriteRank:setVisible(true)
		arg_6_0.lbRank:setVisible(false)

		if arg_6_3 == 1 then
			arg_6_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_first.png"))
		elseif arg_6_3 == 2 then
			arg_6_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_second.png"))
		elseif arg_6_3 == 3 then
			arg_6_0.spriteRank:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_third.png"))
		end
	end

	arg_6_0.lbName:setString(a2u(arg_6_1.RoleName))
	arg_6_0.lbCount:setString(arg_6_1.Gain)
end
