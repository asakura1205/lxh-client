require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRank_TipPowerWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createRankTipPowerWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.playerInfo = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rank_tippower.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_2:getChildByTag(5), "CCSprite")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(1), "CCLabelTTF")

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.6)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.6)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.6)

		arg_3_0.rootSizeHeight = root:getContentSize().height
		arg_3_0.rootSizeWidth = root:getContentSize().width

		local var_5_8 = var_5_2:getContentSize()

		arg_3_0.contentSizeHeight = var_5_8.height
		arg_3_0.contentSizeWidth = var_5_8.width

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.playerInfo = arg_7_1

	if arg_7_1 == nil then
		return
	end

	if arg_7_1.PlayerBaseInfo ~= nil then
		arg_7_0.lbLevel:setString(arg_7_1.PlayerBaseInfo.Level)
		arg_7_0.lbName:setString(arg_7_1.PlayerBaseInfo.RoleName)
		arg_7_0.lbFight:setString(arg_7_1.PlayerBaseInfo.FV)
		arg_7_0.lbVip:setString(arg_7_1.PlayerBaseInfo.VipLevel)

		local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerBaseInfo.HeadId)

		arg_7_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	end
end

function var_0_0.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layer, var_8_0.x, var_8_0.y) == false then
		arg_8_0:hide()
	end
end

function zbPlayerFightTipsWnd.refreshPos(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = zbUtil:getScreenSize().height
	local var_9_1 = zbUtil:getScreenSize().width

	contentSizeWidth = arg_9_0.contentSizeWidth
	contentSizeHeight = arg_9_0.contentSizeHeight

	local var_9_2 = arg_9_0.rootSizeHeight / var_9_0
	local var_9_3 = arg_9_0.rootSizeWidth / var_9_1
	local var_9_4 = var_9_1 * var_9_3
	local var_9_5 = var_9_0 * var_9_2

	arg_9_1.x = arg_9_1.x * var_9_3
	arg_9_1.y = arg_9_1.y * var_9_2
	arg_9_1.y = arg_9_1.y - g_Layout:fullScreenWndOffsetY()

	local var_9_6 = arg_9_1

	if var_9_5 >= arg_9_1.y + contentSizeHeight then
		var_9_6 = arg_9_1
	elseif arg_9_1.y - contentSizeHeight < 0 then
		var_9_6 = ccp(arg_9_1.x - contentSizeWidth * 0.5, 0)
	else
		var_9_6 = ccp(arg_9_1.x, var_9_5 - arg_9_0.contentSizeHeight)
	end

	if var_9_6.x - contentSizeWidth * 0.5 < 20 * (1 - var_9_3) then
		var_9_6.x = contentSizeWidth * 0.5 + 20 * (1 - var_9_3)
	elseif var_9_6.x + contentSizeWidth * 0.5 > var_9_4 - 20 * (1 - var_9_3) then
		var_9_6.x = var_9_4 - contentSizeWidth * 0.5 - 20 * (1 - var_9_3)
	end

	if arg_9_3 == true then
		var_9_6.x = arg_9_2.x + contentSizeWidth * 0.5 + 150
	else
		var_9_6.x = arg_9_2.x - contentSizeWidth * 0.5
	end

	arg_9_0.layer:setPosition(var_9_6)
end
