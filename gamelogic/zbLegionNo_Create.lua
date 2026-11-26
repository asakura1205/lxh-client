local var_0_0 = class("zbLegionNo_Create")

var_0_0.__index = var_0_0

function createLegionNoCreatePanel(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.selHeadId = 0
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.nodeHead = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.btnFrame = tolua.cast(arg_2_0.nodeHead:getChildByTag(1), "CCControlButton")
		arg_2_0.spriteIcon = tolua.cast(arg_2_0.nodeHead:getChildByTag(2), "CCSprite")
		arg_2_0.spriteAdd = tolua.cast(arg_2_0.nodeHead:getChildByTag(3), "CCSprite")
		arg_2_0.spritePayType = tolua.cast(arg_2_1:getChildByTag(4), "CCSprite")
		arg_2_0.lbPrice = tolua.cast(arg_2_1:getChildByTag(5), "CCLabelTTF")
		arg_2_0.lbLimitedLevel = tolua.cast(arg_2_1:getChildByTag(3), "CCLabelTTF")

		local var_4_0 = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")

		arg_2_0.inputBoxName = zbUtil:createEditBox(var_4_0, "", 6, "image/common/button_transparent.png", 22, ccc3(255, 255, 255))

		var_4_0:addChild(arg_2_0.inputBoxName)

		arg_2_0.btnCreate = tolua.cast(arg_2_1:getChildByTag(6), "CCControlButton")

		arg_2_0.btnCreate:addHandleOfControlEvent(function()
			arg_2_0:onCreate()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnFrame:addHandleOfControlEvent(function()
			arg_2_0:onAddHeadIcon()
		end, CCControlEventTouchUpInside)
		arg_2_0.inputBoxName:setPlaceHolder(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xBB\xE1\xB9\xDD\xC3\xFB\xD7\xD6..."))
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_7_0)
	return
end

function var_0_0.refresh(arg_8_0)
	arg_8_0.spriteAdd:setVisible(true)
	arg_8_0.spriteIcon:setVisible(false)
	arg_8_0.lbPrice:setString(g_DataConfig.m_kLegionBaseCfg.createDiamond)
	arg_8_0.lbLimitedLevel:setString(a2u("\xBD\xC7ɫ\xB5ȼ\xB6\xB4ﵽ") .. OPEN_LEGION_LEVEL .. a2u("\xBC\xB6"))
end

function var_0_0.onCreate(arg_9_0)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")

	if g_Self:getLevel() < OPEN_LEGION_LEVEL then
		g_Bubble:bubbleInfo(a2u("\xBD\xC7ɫ\xB5ȼ\xB6δ\xB4ﵽ") .. OPEN_LEGION_LEVEL .. a2u("\xBC\xB6"))

		return
	end

	if g_DataConfig.m_kLegionBaseCfg.createDiamond > g_GameData.Wealth.Diamond then
		return
	end

	local var_9_0 = string.trim(arg_9_0.inputBoxName:getText())

	if zbUtil:isValidText(var_9_0) == false then
		g_Bubble:bubbleInfo(a2u("\xBB\xE1\xB9\xDD\xC3\xFB\xD7ֺ\xAC\xD3зǷ\xA8\xD7ַ\xFB"))
		arg_9_0.inputBoxName:setText("")

		return
	end

	if arg_9_0.selHeadId <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEBѡ\xD4\xF1\xBB\xE1\xB9ݻ\xD5\xD5\xC2"))

		return
	end

	g_WsMsgHandler:WS_Legion_Create_Req(a2u(var_9_0), arg_9_0.selHeadId)
end

function var_0_0.onAddHeadIcon(arg_10_0)
	g_MainScene:showLegionIconSelWnd()
end

function var_0_0.onIconSetEnd(arg_11_0)
	arg_11_0.spriteAdd:setVisible(false)
	arg_11_0.spriteIcon:setVisible(true)

	local var_11_0 = g_Self.kLegionHandler.selIconId

	arg_11_0.selHeadId = var_11_0

	local var_11_1 = zbIconHelper:getLegionIconPath(var_11_0)

	arg_11_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_11_1))
end
