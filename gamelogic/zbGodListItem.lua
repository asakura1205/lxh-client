local var_0_0 = class("zbGodListItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createGodListItem(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

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

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.godData = nil
	end

	local function var_3_1()
		arg_3_0.godGetWay = tolua.cast(arg_3_1:getChildByTag(1002), "CCLabelTTF")

		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = var_5_0
		arg_3_0.godSprite = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.godName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnIn = tolua.cast(var_5_0:getChildByTag(3), "CCControlButton")
		arg_3_0.godType = tolua.cast(var_5_0:getChildByTag(4), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")
		arg_3_0.spuse = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")

		arg_3_0.btnIn:addHandleOfControlEvent(function()
			arg_3_0:onGodIn()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onGodTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.godData = arg_8_1

		arg_8_0.godName:setString(a2u(arg_8_1.name))
		g_Self.kGodHandler:setGodTypeTexture(arg_8_0.godType, arg_8_1.type)
		arg_8_0.godSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_8_1.iconPath))
		arg_8_0.godGetWay:setVisible(false)
		arg_8_0.spuse:setVisible(false)

		if zbGodBaseTable:getRecord(arg_8_1.id) then
			if not g_Self.kGodHandler:isGodOpen(arg_8_1.id) then
				arg_8_0.layerContent:setGray(true)
				arg_8_0.btnIn:setVisible(false)
				arg_8_0.btnTouch:setEnabled(false)
				arg_8_0.godGetWay:setVisible(true)

				local var_8_0 = zbForceTable:getRecord(arg_8_1.open)

				if var_8_0 then
					arg_8_0.godGetWay:setVisible(true)

					local var_8_1 = string.format(a2u("ͨ\xB9\xFD%s\xD5½ڻ\xF1\xB5\xC3"), a2u(var_8_0.name))

					arg_8_0.godGetWay:setString(a2u(var_8_1))
				end
			elseif g_GameData.GodInfo then
				arg_8_0.btnIn:setVisible(arg_8_1.id ~= g_GameData.GodInfo.GodId)
				arg_8_0.spuse:setVisible(arg_8_1.id == g_GameData.GodInfo.GodId)
			end
		end
	end
end

function var_0_0.onGodIn(arg_9_0)
	if arg_9_0.godData then
		if g_MainScene.wndGodList then
			g_MainScene.wndGodList:hide()
		end

		g_WsMsgHandler:WS_God_Change_Req(arg_9_0.godData.id)
	end
end

function var_0_0.onGodTouch(arg_10_0)
	if arg_10_0.godData then
		g_MainScene:showGodDetailWnd(arg_10_0.godData):setPrevWnd(g_MainScene.wndGodList)
	end
end
