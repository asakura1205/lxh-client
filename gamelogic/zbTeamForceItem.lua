local var_0_0 = class("zbTeamForceItem", CCNodeExtend)

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

function createTeamForceItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.playerId = 0
		arg_3_0.parent = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(0), "CCControlButton")
		arg_3_0.headIcon = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbLevel = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.btnGet = tolua.cast(var_5_0:getChildByTag(7), "CCControlButton")
		arg_3_0.spriteRest = tolua.cast(var_5_0:getChildByTag(8), "CCSprite")
		arg_3_0.spriteSort = tolua.cast(var_5_0:getChildByTag(9), "CCSprite")
		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.55)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.55)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGet()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.friendBaseData = arg_8_1

	arg_8_0.spriteSort:setVisible(false)
	arg_8_0.btnGet:setVisible(false)
	arg_8_0.spriteRest:setVisible(false)

	if arg_8_0.friendBaseData == nil then
		return
	end

	arg_8_0.playerId = arg_8_0.friendBaseData.PlayerBaseInfo.PlayerId

	local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_0.friendBaseData.PlayerBaseInfo.HeadId)

	arg_8_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	arg_8_0.lbName:setString(a2u(arg_8_0.friendBaseData.PlayerBaseInfo.RoleName))
	arg_8_0.lbLevel:setString("lv." .. arg_8_0.friendBaseData.PlayerBaseInfo.Level)
	arg_8_0.lbVip:setString(arg_8_0.friendBaseData.PlayerBaseInfo.VipLevel)
	arg_8_0.lbPower:setString(arg_8_0.friendBaseData.PlayerBaseInfo.FV)

	for iter_8_0, iter_8_1 in pairs(g_GameData.TeamHire.HireList) do
		if arg_8_0.friendBaseData.PlayerBaseInfo.PlayerId == iter_8_1 then
			arg_8_0.spriteSort:setVisible(false)
			arg_8_0.btnGet:setVisible(false)
			arg_8_0.spriteRest:setVisible(true)

			return
		end
	end

	local var_8_1 = 1

	for iter_8_2, iter_8_3 in pairs(g_MainScene.wndEmbattle.selectList) do
		if arg_8_0.friendBaseData.PlayerBaseInfo.PlayerId == iter_8_3.PlayerBaseInfo.PlayerId then
			arg_8_0.spriteSort:setTexture(CCTextureCache:sharedTextureCache():addImage("image/warpath/teamforce/teamforce_sort" .. var_8_1 + 1 .. ".png"))
			arg_8_0.spriteSort:setVisible(true)
			arg_8_0.btnGet:setVisible(false)
			arg_8_0.spriteRest:setVisible(false)

			return
		end

		var_8_1 = var_8_1 + 1
	end

	arg_8_0.spriteSort:setVisible(false)
	arg_8_0.btnGet:setVisible(true)
	arg_8_0.spriteRest:setVisible(false)
end

function var_0_0.onTouch(arg_9_0)
	if arg_9_0.playerId ~= nil then
		g_WsMsgHandler:WS_Player_BaseFormation_Req(arg_9_0.playerId)
	end
end

function var_0_0.onGet(arg_10_0)
	if table.getn(g_MainScene.wndEmbattle.selectList) >= 2 then
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xADѡ\xD4\xF1\xC1\xBD\xC3\xFB\xBA\xC3\xD3\xD1"))

		return
	end

	table.insert(g_MainScene.wndEmbattle.selectList, arg_10_0.friendBaseData)
	arg_10_0.parent:refreshList()
end
