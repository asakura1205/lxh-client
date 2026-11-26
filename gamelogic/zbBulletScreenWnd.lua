require("gamelogic.zbBulletScreenContent")
require("gamelogic.zbBulletScreenFace")

local var_0_0 = 12
local var_0_1 = 64
local var_0_2 = 64
local var_0_3 = class("zbBulletScreenWnd", zbBaseWnd)

var_0_3.__index = var_0_3

function createBulletScreenWnd()
	local var_1_0 = var_0_3.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_3.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_3)

	return arg_2_0
end

function var_0_3.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.locationType = EBarrageFontPos.Fixed
		arg_3_0.colorType = EBarrageFontColorType.White
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/bulletScreen.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layerInput = tolua.cast(var_5_1:getChildByTag(2), "CCLayerColor")
		arg_3_0.nodebottom = tolua.cast(arg_3_0.layerInput:getChildByTag(600), "CCNode")
		arg_3_0.btnLocation = tolua.cast(arg_3_0.nodebottom:getChildByTag(1), "CCControlButton")

		local var_5_2 = tolua.cast(arg_3_0.nodebottom:getChildByTag(2), "CCControlButton")
		local var_5_3 = tolua.cast(arg_3_0.nodebottom:getChildByTag(5), "CCControlButton")
		local var_5_4 = tolua.cast(arg_3_0.nodebottom:getChildByTag(6), "CCControlButton")

		arg_3_0.layerPicture = tolua.cast(arg_3_0.nodebottom:getChildByTag(7), "CCLayer")
		arg_3_0.layerPicContent = tolua.cast(arg_3_0.layerPicture:getChildByTag(2), "CCLayer")
		arg_3_0.layerColor = tolua.cast(arg_3_0.nodebottom:getChildByTag(8), "CCLayer")
		arg_3_0.btnWhiteColor = tolua.cast(arg_3_0.layerColor:getChildByTag(1), "CCControlButton")
		arg_3_0.btnRedColor = tolua.cast(arg_3_0.layerColor:getChildByTag(2), "CCControlButton")

		local var_5_5 = tolua.cast(arg_3_0.nodebottom:getChildByTag(3), "CCLayer")
		local var_5_6 = tolua.cast(arg_3_0.nodebottom:getChildByTag(4), "CCScrollView")
		local var_5_7 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_5, a2u("\xCA\xE4\xC8뵯Ļ\xC4\xDA\xC8\xDD,\xD7\xEE\xB6\xE0\xCA\xE4\xC8\xEB15\xB8\xF6\xD7\xD6"), MAX_CHAT_LEN, "image/common/button_transparent.png", 20, var_5_7)

		var_5_6:addChild(arg_3_0.inputBox)
		var_5_6:setCanMove(false)

		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.nodebottom:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnTouchTest2 = tolua.cast(arg_3_0.layerPicture:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest2:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest2()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLocation:addHandleOfControlEvent(function()
			arg_3_0:onLocation()
		end, CCControlEventTouchUpInside)
		var_5_2:addHandleOfControlEvent(function()
			arg_3_0:onColor()
		end, CCControlEventTouchUpInside)
		var_5_3:addHandleOfControlEvent(function()
			arg_3_0:onPicture()
		end, CCControlEventTouchUpInside)
		var_5_4:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnWhiteColor:addHandleOfControlEvent(function()
			arg_3_0:onSelectColor(EBarrageFontColorType.White)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRedColor:addHandleOfControlEvent(function()
			arg_3_0:onSelectColor(EBarrageFontColorType.Red)
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:refreshPicture()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:sendUpdate()
	end, zbGameEvent.Event_Barrage_Send_Ack)
end

function var_0_3.onShow(arg_17_0)
	g_CombatSystem:pause()
end

function var_0_3.onHide(arg_18_0)
	g_CombatSystem:resume()
end

function var_0_3.onTouchTest(arg_19_0)
	local var_19_0 = arg_19_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_19_0.nodebottom, var_19_0.x, var_19_0.y) == false then
		arg_19_0:hide()
	end
end

function var_0_3.onTouchTest2(arg_20_0)
	local var_20_0 = arg_20_0.btnTouchTest2:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_20_0.nodebottom, var_20_0.x, var_20_0.y) == false and zbUtil:PointInCtrl(arg_20_0.layerPicContent, var_20_0.x, var_20_0.y) == false then
		arg_20_0:hide()
	end
end

local var_0_4 = {
	[EBarrageFontPos.Center] = "image/combat/battleui/bulletscreen/bulletscreen_mid.png",
	[EBarrageFontPos.Fixed] = "image/combat/battleui/bulletscreen/bulletscreen_dang.png"
}

function var_0_3.refresh(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0.dungeonType = arg_21_1
	arg_21_0.LevelId = arg_21_2
	arg_21_0.LevelWave = arg_21_3

	arg_21_0.layerPicture:setVisible(false)
	arg_21_0.layerColor:setVisible(false)
	require("gamebase.zbUI"):setButtonPic(arg_21_0.btnLocation, var_0_4[arg_21_0.locationType], var_0_4[arg_21_0.locationType])
end

function var_0_3.refreshPicture(arg_22_0)
	local var_22_0 = arg_22_0.layerPicContent:getContentSize()

	arg_22_0.tableViewHelper = zbTableViewHelper:create()
	arg_22_0.tableView = zbTableViewHelper:createTableView(var_22_0, var_22_0, kCCScrollViewDirectionVertical, arg_22_0.tableViewHelper)

	arg_22_0.tableView:setPosition(0, 0)
	arg_22_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_22_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_22_0.layerPicContent:addChild(arg_22_0.tableView)

	local var_22_1 = 24
	local var_22_2 = math.ceil(var_22_1 / var_0_0)

	for iter_22_0 = 1, var_22_2 do
		local var_22_3 = arg_22_0.tableViewHelper:addListItem()

		var_22_3:setAnchorPoint(ccp(0, 0))
		var_22_3:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

		arg_22_0.lines[iter_22_0] = var_22_3

		for iter_22_1 = 1, var_0_0 do
			local var_22_4 = zbTableViewHelper:create()

			var_22_4:loadCCBFile("ccbi/tb_chatface.ccbi")

			local var_22_5 = createBulletScreenFace(translateAndStrokeHelper(var_22_4:readCCBNode()), arg_22_0)

			var_22_5:setAnchorPoint(ccp(0, 0))
			var_22_5:setPosition((iter_22_1 - 1) * var_0_1, 0)
			var_22_3:addChild(var_22_5)

			arg_22_0.items[(iter_22_0 - 1) * var_0_0 + iter_22_1] = var_22_5

			var_22_4:releaseSelf()
		end
	end

	for iter_22_2 = 1, var_22_1 do
		arg_22_0.items[iter_22_2]:refresh(iter_22_2)
	end

	arg_22_0.tableViewHelper:refreshTabelView()
	arg_22_0.tableViewHelper:setTouchPriority(arg_22_0.btnTouchTest:getTouchPriority())
end

function var_0_3.setInputBoxStr(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.inputBox:getText() .. arg_23_1

	arg_23_0.inputBox:setText(a2u(var_23_0))
end

function var_0_3.onLocation(arg_24_0)
	arg_24_0.locationType = 3 - arg_24_0.locationType

	require("gamebase.zbUI"):setButtonPic(arg_24_0.btnLocation, var_0_4[arg_24_0.locationType], var_0_4[arg_24_0.locationType])
end

function var_0_3.onColor(arg_25_0)
	if arg_25_0.layerColor:isVisible() then
		arg_25_0.layerColor:setVisible(false)
	else
		arg_25_0.layerColor:setVisible(true)
	end
end

function var_0_3.onSelectColor(arg_26_0, arg_26_1)
	local var_26_0 = zbVipTable:getRecord(g_GameData.BaseInfo.VipLevel)

	if arg_26_1 == EBarrageFontColorType.White or var_26_0.barrageColor == 1 then
		arg_26_0.colorType = arg_26_1

		arg_26_0.layerColor:setVisible(false)
	else
		g_Bubble:bubbleInfo(a2u("VIP7\xD2\xD4\xC9Ͽ\xAA\xC6\xF4\xBA\xECɫ\xB5\xAFĻ\xA1\xA3"))
	end
end

function var_0_3.sendUpdate(arg_27_0)
	arg_27_0.inputBox:setText("")
	arg_27_0.inputBox:setPlaceHolder(a2u("\xCA\xE4\xC8뵯Ļ\xC4\xDA\xC8\xDD,\xD7\xEE\xB6\xE0\xCA\xE4\xC8\xEB15\xB8\xF6\xD7\xD6"))
	arg_27_0:hide()
end

function var_0_3.onSend(arg_28_0)
	local var_28_0 = string.trim(arg_28_0.inputBox:getText())

	if var_28_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8뵯Ļ\xC4\xDA\xC8\xDD"))

		return
	end

	local var_28_1 = zbUtil:repValidText(var_28_0)
	local var_28_2 = {
		DungeonType = arg_28_0.dungeonType,
		SMsg = a2u(var_28_1),
		LevelId = arg_28_0.LevelId,
		LevelWave = arg_28_0.LevelWave,
		FontColor = arg_28_0.colorType,
		FontPos = arg_28_0.locationType
	}

	g_WsMsgHandler:WS_Barrage_Send_Req(var_28_2)
end

function var_0_3.onPicture(arg_29_0)
	if arg_29_0.layerPicture:isVisible() then
		arg_29_0.layerPicture:setVisible(false)
	else
		arg_29_0.layerPicture:setVisible(true)
	end
end
