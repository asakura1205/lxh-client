zbWorldBossRankItem = class("zbWorldBossRankItem", CCNodeExtend)
zbWorldBossRankItem.__index = zbWorldBossRankItem

function zbWorldBossRankItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWorldBossRankItem)

	return arg_1_0
end

function createWorldBossRankItem(arg_2_0)
	local var_2_0 = zbWorldBossRankItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function zbWorldBossRankItem.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.playerId = 0
		arg_3_0.isSelf = false
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.spriteRankTop = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteRank = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		local var_5_1 = tolua.cast(arg_3_0.spriteRank:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(5), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lbDamage = tolua.cast(var_5_0:getChildByTag(1007), "CCLabelTTF")
		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbRank)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.6)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function zbWorldBossRankItem.refresh(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == nil or arg_6_2 == nil then
		return
	end

	arg_6_0.lbDamage:setString(arg_6_1.HurtHp)

	if zbUtil:isValidTable(arg_6_1.PlayerInfo) then
		local var_6_0 = zbIconHelper:getPlayerHeadIconPath(arg_6_1.PlayerInfo.HeadId)

		arg_6_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))
		arg_6_0.lbName:setString(a2u(arg_6_1.PlayerInfo.RoleName))
		arg_6_0.lbLevel:setString(arg_6_1.PlayerInfo.Level)
		arg_6_0.lbVip:setString(arg_6_1.PlayerInfo.VipLevel)
	end

	arg_6_0.spriteRankTop:setVisible(arg_6_2 <= 3)
	arg_6_0.spriteRank:setVisible(arg_6_2 > 3)

	if arg_6_2 == 1 then
		arg_6_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_first.png"))
	elseif arg_6_2 == 2 then
		arg_6_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_second.png"))
	elseif arg_6_2 == 3 then
		arg_6_0.spriteRankTop:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_third.png"))
	else
		arg_6_0.lbRank:setString(arg_6_2)
	end
end
