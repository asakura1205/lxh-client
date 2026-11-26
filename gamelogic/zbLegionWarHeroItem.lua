local var_0_0 = class("zbLegionWarHeroItem")

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

function createLegionWarHeroItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.data = nil
		arg_3_0.type = 0
		arg_3_0.parent = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteHead = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.spriteJob = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")
		arg_3_0.lbTime = tolua.cast(var_5_0:getChildByTag(1007), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1008), "CCLabelTTF")

		arg_3_0.spriteFight = tolua.cast(var_5_0:getChildByTag(9), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.spriteFight:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.5)

		arg_3_0.lbDonate = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbDonate)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.5)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.lbDonate:setVisible(arg_7_2 == ELgionWarHero.E_EliteSet)
	arg_7_0.spriteFight:setVisible(arg_7_2 == ELgionWarHero.E_NodeAdd)

	arg_7_0.type = arg_7_2
	arg_7_0.data = arg_7_1
	arg_7_0.myIndex = arg_7_3

	if arg_7_0.data ~= nil then
		arg_7_0.btnTouch:setEnabled(arg_7_0.type == ELgionWarHero.E_NodeAdd or arg_7_1.PlayerBaseInfo.PlayerId ~= g_Self:getPlayerId())
		arg_7_0.layerContent:setGray(arg_7_0.type == ELgionWarHero.E_EliteSet and arg_7_1.PlayerBaseInfo.PlayerId == g_Self:getPlayerId())

		local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerBaseInfo.HeadId)

		arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
		arg_7_0.lbLevel:setString(arg_7_1.PlayerBaseInfo.Level)
		arg_7_0.lbVip:setString(arg_7_1.PlayerBaseInfo.VipLevel)
		arg_7_0.lbName:setString(arg_7_1.PlayerBaseInfo.RoleName)
		arg_7_0.lbDonate:setString(arg_7_1.MemberBaseInfo.Donate)
		arg_7_0.lbFight:setString(arg_7_1.PlayerBaseInfo.FV)

		local var_7_1 = g_Self.kLegionHandler:getOfficeById(arg_7_1.PlayerBaseInfo.PlayerId)

		zbLegionHelp:setOfficeTexture(arg_7_0.spriteJob, var_7_1)

		if arg_7_1.PlayerBaseInfo.Online == 1 then
			arg_7_0.lbTime:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_7_2 = math.max(g_Self.kTimeHandler:getServerTime() - arg_7_1.PlayerBaseInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_7_3 = zbUtil:getPassTimeShort(var_7_2)

			arg_7_0.lbTime:setString(var_7_3)
		end
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.data and arg_8_0.type then
		if arg_8_0.type == ELgionWarHero.E_EliteSet then
			if g_MainScene.wndLegionWarEliteSet then
				g_MainScene.wndLegionWarEliteSet.eliteList[arg_8_0.myIndex] = arg_8_0.data.PlayerBaseInfo.PlayerId

				g_WsMsgHandler:WS_LegionWar_EliteSet_Req(g_MainScene.wndLegionWarEliteSet.nodeId, g_MainScene.wndLegionWarEliteSet.eliteList)
				arg_8_0.parent:hide()
			end
		elseif arg_8_0.type == ELgionWarHero.E_NodeAdd and g_MainScene.wndLegionWarAssign then
			g_MainScene.wndLegionWarAssign.heroList[arg_8_0.myIndex] = arg_8_0.data.PlayerBaseInfo.PlayerId

			g_MainScene.wndLegionWarAssign:freshHeroList()
			arg_8_0.parent:hide()
		end
	end
end
