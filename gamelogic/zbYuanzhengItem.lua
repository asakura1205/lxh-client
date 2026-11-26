local var_0_0 = class("zbYuanzhengItem", CCNodeExtend)

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

function createYuanzhengItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.playerInfo = nil
		arg_3_0.index = arg_3_2
		arg_3_0.ccNode = arg_3_1
	end

	local function var_3_1()
		arg_3_0.btnTask = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.sprite = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_1:getChildByTag(5), "CCNode")
		arg_3_0.spriteNum = tolua.cast(arg_3_1:getChildByTag(6), "CCSprite")

		if arg_3_2 ~= 6 then
			arg_3_0.effectFocus = createUIAnimation()

			arg_3_0.effectFocus:refresh("effect/spine/tuanshu/tuanshu.json", "effect/spine/tuanshu/tuanshu.atlas")
			arg_3_0.effectFocus:setPosition(0, 0)
			arg_3_0.effectFocus:setAnchorPoint(ccp(0.5, 0.5))
			arg_3_0.effectFocus:setAnimation("animation", true, 1 - (zbUtil:random(1, 5) - 3) / 20)
			arg_3_0.nodeEffect:addChild(arg_3_0.effectFocus)
		end

		arg_3_0.btnTask:setTouchPriority(g_MainScene.wndYuanZheng.moneyPanel.btnClose:getTouchPriority())
		arg_3_0.btnTask:addHandleOfControlEvent(function()
			arg_3_0:onTask()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.bgzLayerDetail = arg_7_1
	arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/bgz.plist")

	if arg_7_0.index == 6 then
		local var_7_0 = ""

		if g_GameData.BgzInfo.State == 1 then
			var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName("bgz_littlebox.png")
		else
			var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName("bgz_littlebox_empty.png")
		end

		if var_7_0 and var_7_0 ~= "" then
			arg_7_0.sprite:initWithSpriteFrame(var_7_0)
		end

		return
	end

	if arg_7_0.bgzLayerDetail.State == 1 and g_GameData.BgzInfo.State ~= 1 then
		arg_7_0.nodeEffect:setVisible(false)
		arg_7_0.spriteNum:setVisible(false)
		arg_7_0.sprite:setVisible(true)
	else
		arg_7_0.nodeEffect:setVisible(true)
		arg_7_0.spriteNum:setVisible(true)
		arg_7_0.sprite:setVisible(false)
	end
end

function var_0_0.onTask(arg_8_0)
	if arg_8_0.index == 6 then
		if g_GameData.BgzInfo.State == 1 then
			g_WsMsgHandler:WS_Bgz_GetAward_Req()
		end

		return
	end

	if g_GameData.BgzInfo.State == 1 then
		g_Bubble:bubbleInfo("\xBD\xB1\xC0\xF8\xBB\xB9δ\xC1\xECȡ")

		return
	end

	if arg_8_0.bgzLayerDetail.State == 1 then
		g_Bubble:bubbleInfo("\xD5\xE2\xB8\xF6\xB6\xB4\xBF\xDA\xD2Ѿ\xAD̽\xCB\xF7\xB9\xFD\xC1ˡ\xAD\xA1\xAD")

		return
	end

	g_Self.kYuanzhengHandler.currBtnIndex = arg_8_0.index

	g_WsMsgHandler:WS_Bgz_GetBossInfo_Req(arg_8_0.index)
end
