require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWsConnectWait", zbBaseWnd)

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

function createWsConnectWaitWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lasttime = os_timenow()
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/wsconnectwait.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.spriteBg = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")

		tolua.cast(var_5_2:getChildByTag(4), "CCSprite"):setVisible(g_Login.channel ~= EChannelType.uc)
		arg_3_0.spriteBg:setVisible(false)

		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0.layerScene:load(COMBAT_SCENE_LOGIN)
		arg_3_0:addChild(arg_3_0.layerScene)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
end

function var_0_0.doDestroy(arg_7_0)
	arg_7_0.layerScene:free()
end

function var_0_0.doShow(arg_8_0)
	arg_8_0.lasttime = os_timenow()
end

function var_0_0.onFrameUpdate(arg_9_0)
	if arg_9_0.isShow == false then
		return
	end

	if os_timenow() - arg_9_0.lasttime > 3 then
		g_WsMsgHandler.needLoginReq = true

		g_WsMsgHandler:wsConnect()

		arg_9_0.lasttime = os_timenow()
	end
end
