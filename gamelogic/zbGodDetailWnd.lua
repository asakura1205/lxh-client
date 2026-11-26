require("gamelogic.zbBaseWnd")
require("gamelogic.zbGodSkillList")

local var_0_0 = class("zbGodDetailWnd", zbBaseWnd)

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

function createGodDetailWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.godData = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/goddetail.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.godSprite = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.godName = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")
		arg_3_0.godType = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
		arg_3_0.godDesc = tolua.cast(var_5_3:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.godIn = tolua.cast(var_5_3:getChildByTag(4), "CCControlButton")

		arg_3_0.godIn:addHandleOfControlEvent(function()
			arg_3_0:onGodIn()
		end, CCControlEventTouchUpInside)

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")

		arg_3_0.skillList = createGodSkillList(var_5_4, arg_3_0.btnClose)

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.godData = arg_9_1

		arg_9_0.godName:setString(a2u(arg_9_1.name))
		g_Self.kGodHandler:setGodTypeTexture(arg_9_0.godType, arg_9_1.type)
		arg_9_0.godDesc:setString(a2u(arg_9_1.desc))
		arg_9_0.godSprite:setTexture(CCTextureCache:sharedTextureCache():addImage(arg_9_1.iconPath))

		if zbGodBaseTable:getRecord(arg_9_1.id) and g_GameData.GodInfo then
			arg_9_0.godIn:setVisible(arg_9_1.id ~= g_GameData.GodInfo.GodId)
		end

		arg_9_0.skillList:refresh(arg_9_0.godData)
	end
end

function var_0_0.onGodIn(arg_10_0)
	if arg_10_0.godData then
		arg_10_0:hide()

		if g_MainScene.wndGodList then
			g_MainScene.wndGodList:hide()
		end

		g_WsMsgHandler:WS_God_Change_Req(arg_10_0.godData.id)
	end
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.testLayer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
