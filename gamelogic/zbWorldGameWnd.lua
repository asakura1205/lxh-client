require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldGameWnd", zbBaseWnd)

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

local var_0_1 = {
	[EFaceResultType.Quan] = "ui/image/world/world_rock.png",
	[EFaceResultType.Bu] = "ui/image/world/world_paper.png",
	[EFaceResultType.Jian] = "ui/image/world/world_scissors.png"
}

function createWorldGameWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.record = nil
		arg_3_0.gameData = nil
		arg_3_0.initPos = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_game.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbResultUp = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.nodeStart = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnScissors = tolua.cast(arg_3_0.nodeStart:getChildByTag(1), "CCControlButton")
		arg_3_0.btnRock = tolua.cast(arg_3_0.nodeStart:getChildByTag(2), "CCControlButton")
		arg_3_0.btnPaper = tolua.cast(arg_3_0.nodeStart:getChildByTag(3), "CCControlButton")
		arg_3_0.initPos[1] = ccp(arg_3_0.btnScissors:getPosition())
		arg_3_0.initPos[2] = ccp(arg_3_0.btnRock:getPosition())
		arg_3_0.initPos[3] = ccp(arg_3_0.btnPaper:getPosition())
		arg_3_0.nodeResult = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.spriteSelf = tolua.cast(arg_3_0.nodeResult:getChildByTag(1), "CCSprite")
		arg_3_0.spriteOther = tolua.cast(arg_3_0.nodeResult:getChildByTag(2), "CCSprite")
		arg_3_0.lbResultDown = tolua.cast(arg_3_0.nodeResult:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnAgain = tolua.cast(arg_3_0.nodeResult:getChildByTag(5), "CCControlButton")

		arg_3_0.btnAgain:addHandleOfControlEvent(function()
			arg_3_0:onAgain()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeAward = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		arg_3_0.nodeSuccess = tolua.cast(arg_3_0.nodeAward:getChildByTag(1), "CCNode")
		arg_3_0.lbSuccess = tolua.cast(arg_3_0.nodeSuccess:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbMoney = tolua.cast(arg_3_0.nodeSuccess:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeSuccess:getChildByTag(3), "CCSprite")
		arg_3_0.lbFalse = tolua.cast(arg_3_0.nodeAward:getChildByTag(2), "CCNode")
		arg_3_0.lbResultDown = tolua.cast(arg_3_0.nodeAward:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(arg_3_0.nodeAward:getChildByTag(31), "CCControlButton")

		local var_5_3 = g_DataConfig.m_kWorldBaseCfg.special.faceWorld.gold

		arg_3_0.lbMoney:setString(var_5_3)
		arg_3_0.btnScissors:addHandleOfControlEvent(function()
			arg_3_0:onFaceStart(EFaceResultType.Jian)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRock:addHandleOfControlEvent(function()
			arg_3_0:onFaceStart(EFaceResultType.Quan)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnPaper:addHandleOfControlEvent(function()
			arg_3_0:onFaceStart(EFaceResultType.Bu)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onEventRfresh()
	end, zbGameEvent.Event_UpdateFaceInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onFaceEnd()
	end, zbGameEvent.Event_FaceEndAck)
end

function var_0_0.doShow(arg_14_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(false)
	end
end

function var_0_0.doHide(arg_15_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(true)
	end
end

function var_0_0.onEventRfresh(arg_16_0)
	if arg_16_0.record then
		arg_16_0:refresh(arg_16_0.record, true)
	end
end

function var_0_0.onFaceEnd(arg_17_0)
	arg_17_0.nodeStart:setVisible(false)
	arg_17_0.nodeResult:setVisible(false)
	arg_17_0.nodeAward:setVisible(true)
	arg_17_0.btnTouchTest:setEnabled(true)
	arg_17_0.lbFalse:setVisible(arg_17_0.gameData.State == EWorldFaceState.Fail)
	arg_17_0.nodeSuccess:setVisible(arg_17_0.gameData.State == EWorldFaceState.Win)
end

function var_0_0.doAction(arg_18_0, arg_18_1)
	arg_18_0:refreshNoAction(arg_18_1)
end

function var_0_0.refreshNoAction(arg_19_0, arg_19_1)
	arg_19_0.nodeStart:setVisible(arg_19_1.State == EWorldFaceState.Start)
	arg_19_0.nodeResult:setVisible(arg_19_1.State ~= EWorldFaceState.Start)
	arg_19_0.btnTouchTest:setEnabled(false)

	if arg_19_1.State == EWorldFaceState.Start then
		arg_19_0.lbResultUp:setString(a2u("\xBAͶ\xC4\xCD\xF5\xB6\xC4һ\xB0\xD1,\xBF\xB4\xBF\xB4\xC4\xE3\xCAǺ\xDA\xC1\xB3\xBB\xB9\xCAǰ\xD7\xC1\xB3"))
	elseif arg_19_1.State == EWorldFaceState.Going then
		local var_19_0 = arg_19_0.gameData.Select

		arg_19_0.spriteSelf:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[var_19_0]))
		arg_19_0.spriteOther:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[var_19_0]))
		arg_19_0.lbResultUp:setString(a2u("ƽ\xBE\xD6,\xD4\xD9\xC0\xB4һ\xB0\xD1"))
	else
		local var_19_1 = arg_19_0.gameData.Select

		arg_19_0.spriteSelf:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[var_19_1]))
		arg_19_0:setOtherResultTexture(arg_19_0.spriteOther, arg_19_1.State)
	end
end

function var_0_0.refresh(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.nodeStart:setVisible(true)
	arg_20_0.nodeResult:setVisible(false)
	arg_20_0.nodeAward:setVisible(false)

	arg_20_0.record = arg_20_1

	if arg_20_1 then
		local var_20_0 = g_Self.kWorldHandler:getFaceDataById(arg_20_1.id)

		if var_20_0 then
			arg_20_0.gameData = var_20_0

			if arg_20_2 then
				arg_20_0:doAction(var_20_0)
			else
				arg_20_0:refreshNoAction(var_20_0)
			end
		end
	end
end

function var_0_0.setOtherResultTexture(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2 == EWorldFaceState.Fail then
		local var_21_0 = arg_21_0.gameData.Select + 1

		if var_21_0 > 3 then
			var_21_0 = 1
		end

		arg_21_1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[var_21_0]))
		arg_21_0.lbResultUp:setString(a2u("\xC4\xE3\xCA\xE4\xC1\xCB"))
	elseif arg_21_2 == EWorldFaceState.Win then
		local var_21_1 = arg_21_0.gameData.Select - 1

		if var_21_1 < 1 then
			var_21_1 = 3
		end

		arg_21_1:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[var_21_1]))
		arg_21_0.lbResultUp:setString(a2u("\xB9\xA7ϲ\xC4\xE3\xBB\xF1\xB5\xC3ʤ\xC0\xFB"))
	end
end

function var_0_0.onAgain(arg_22_0)
	if arg_22_0.gameData then
		if arg_22_0.gameData.State == EWorldFaceState.Going then
			arg_22_0.nodeStart:setVisible(true)
			arg_22_0.nodeResult:setVisible(false)
			arg_22_0.nodeAward:setVisible(false)
		elseif arg_22_0.record then
			g_WsMsgHandler:WS_WorldSpe_FaceEnd_Req(arg_22_0.record.id)
		end
	end
end

function var_0_0.onFaceStart(arg_23_0, arg_23_1)
	if arg_23_0.record then
		g_WsMsgHandler:WS_WorldSpe_FaceStart_Req(arg_23_0.record.id, arg_23_1)
	end
end

function var_0_0.onTouchTest(arg_24_0)
	local var_24_0 = arg_24_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_24_0.layer, var_24_0.x, var_24_0.y) == false then
		arg_24_0:hide()
	end
end
