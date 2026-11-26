require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRoleCreateWnd", zbBaseWnd)

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

function createRoleCreateWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.randomCount = 0
		arg_3_0.roleIndex = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/role_create.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.nodeAvatar = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.heroAvatar = createUIAnimation()

		arg_3_0.heroAvatar:setPosition(0, 22)
		arg_3_0.heroAvatar:setScale(1.5)
		arg_3_0.nodeAvatar:addChild(arg_3_0.heroAvatar)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLayer")

		arg_3_0.btnRandom = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")
		arg_3_0.btnStartGame = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		arg_3_0.inputName = zbUtil:createEditBox(var_5_4, a2u("\xD76\xB8\xF6\xBA\xBA\xD7\xD6"), MAX_ROLENAME_LEN, "image/common/button_transparent.png")

		arg_3_0.inputName:setAnchorPoint(ccp(0, 0.5))
		arg_3_0.inputName:setPositionY(var_5_4:getContentSize().height / 2)
		arg_3_0.inputName:setFontColor(FONT_COLOR_GREEN)
		var_5_4:addChild(arg_3_0.inputName)

		arg_3_0.btnLeft = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.btnRight = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnRandom:addHandleOfControlEvent(function()
			arg_3_0:onRandom()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnStartGame:addHandleOfControlEvent(function()
			arg_3_0:onStartGame()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLeft:addHandleOfControlEvent(function()
			arg_3_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRight:addHandleOfControlEvent(function()
			arg_3_0:onRight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:onRandomName()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onFirstRoleInfoAck()
	end, zbGameEvent.Event_FirstRoleInfoSet_Ack)
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	arg_12_0.roleIndex = arg_12_1

	arg_12_0:refreshAvatar()
end

function var_0_0.refreshAvatar(arg_13_0)
	arg_13_0.heroAvatar:refreshAvatarId(arg_13_0.roleIndex)
	arg_13_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
end

function var_0_0.onLeft(arg_14_0)
	if arg_14_0.roleIndex == 1 then
		arg_14_0.roleIndex = 5
	end

	arg_14_0.roleIndex = arg_14_0.roleIndex - 1

	arg_14_0:refreshAvatar()
end

function var_0_0.onRight(arg_15_0)
	if arg_15_0.roleIndex == 4 then
		arg_15_0.roleIndex = 0
	end

	arg_15_0.roleIndex = arg_15_0.roleIndex + 1

	arg_15_0:refreshAvatar()
end

function var_0_0.onRandom(arg_16_0)
	local function var_16_0()
		arg_16_0.randomCount = arg_16_0.randomCount + 1

		local var_17_0 = "image/role/role_random1.png"
		local var_17_1 = "image/role/role_random2.png"

		if arg_16_0.randomCount % 2 == 0 then
			require("gamebase.zbUI"):setButtonPic(arg_16_0.btnRandom, var_17_0, var_17_0)
			zbUtil:setHighlightSprite(arg_16_0.btnRandom, var_17_0)
		else
			require("gamebase.zbUI"):setButtonPic(arg_16_0.btnRandom, var_17_1, var_17_1)
			zbUtil:setHighlightSprite(arg_16_0.btnRandom, var_17_1)
		end
	end

	arg_16_0:onRandomName()

	local var_16_1 = CCArray:create()

	var_16_1:addObject(CCEaseSineOut:create(CCRotateTo:create(0.4, 1440)))
	var_16_1:addObject(CCCallFuncN:create(var_16_0))

	local var_16_2 = CCSequence:create(var_16_1)

	arg_16_0.btnRandom:stopAllActions()
	arg_16_0.btnRandom:runAction(var_16_2)
end

function var_0_0.onRandomName(arg_18_0)
	local var_18_0 = g_NameHelper:randomName()

	if zbUtil:isValidText(var_18_0) == true then
		arg_18_0.inputName:setText(a2u(var_18_0))
	else
		arg_18_0:onRandomName()
	end
end

function var_0_0.onStartGame(arg_19_0)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")

	local var_19_0 = string.trim(arg_19_0.inputName:getText())

	if var_19_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC6\xF0\xB8\xF6\xCF\xEC\xC1\xC1\xB5\xC4\xC3\xFB\xD7ְ\xC9"))
	else
		if zbUtil:isValidText(var_19_0) == false then
			g_Bubble:bubbleInfo(a2u("\xC3\xFB\xD7ֺ\xAC\xD3зǷ\xA8\xD7ַ\xFB"))
			arg_19_0.inputName:setText("")

			return
		end

		local function var_19_1()
			g_WsMsgHandler:WS_Common_SetFirst_Req(arg_19_0.roleIndex, a2u(var_19_0))
		end

		local var_19_2 = a2u("\xC4\xFAҪʹ\xD3á\xBE") .. var_19_0 .. a2u("\xA1\xBF\xD7\xF7Ϊ\xD3\xCEϷ\xBD\xC7ɫ\xC3\xFB\xC2\xF0\xA3\xBF")

		g_MessageBox:showYesNo(var_19_2, var_19_1)
	end
end

function var_0_0.onFirstRoleInfoAck(arg_21_0)
	arg_21_0:hide()
	g_MainScene:showNewRoleWnd(arg_21_0.roleIndex)
end
