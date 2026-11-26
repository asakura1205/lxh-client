require("gamebase.zbFunctions")

local var_0_0 = class("zbLegionBossRankItem", CCNodeExtend)

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

function createLegionBossRankItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	function initMember()
		arg_3_0.data = nil
		arg_3_0.lefttime = 0
		arg_3_0.lastTime = os_timenow()
	end

	function initCCB()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.sprank = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.5)

		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1007), "CCLabelTTF")

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.5)

		arg_3_0.lbdamage = tolua.cast(var_5_0:getChildByTag(1009), "CCLabelTTF")

		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	initMember()
	initCCB()
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		zbLegionHelp:setLegionRankTexture(arg_6_0.sprank, arg_6_0.lbRank, arg_6_2)
		arg_6_0.lbdamage:setString(arg_6_1.HurtHp)

		local var_6_0 = zbIconHelper:getPlayerHeadIconPath(arg_6_1.PlayerInfo.HeadId)

		arg_6_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))
		arg_6_0.lbName:setString(a2u(arg_6_1.PlayerInfo.RoleName))
		arg_6_0.lbLevel:setString(arg_6_1.PlayerInfo.Level)
		arg_6_0.lbVip:setString(arg_6_1.PlayerInfo.VipLevel)
	end
end
