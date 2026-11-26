require("gamelogic.zbItem")

local var_0_0 = class("zbLegionWelfareWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionWelfareWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

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
		arg_3_0.spriteoffice = {}
		arg_3_0.awardItems = {}
		arg_3_0.btnGet = {}
		arg_3_0.spriteGet = {}
		arg_3_0.legionDetail = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_welfare.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCNode")

			arg_3_0.spriteoffice[iter_5_0] = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")

			for iter_5_1 = 1, 3 do
				local var_5_4 = tolua.cast(var_5_3:getChildByTag(iter_5_1 + 1), "CCLayerColor")
				local var_5_5 = createItem()

				var_5_5:setPosition(var_5_4:getPosition())
				var_5_5:setScale(0.7)
				var_5_3:addChild(var_5_5)
				var_5_4:removeFromParentAndCleanup(true)

				arg_3_0.awardItems[3 * (iter_5_0 - 1) + iter_5_1] = var_5_5
			end

			arg_3_0.btnGet[iter_5_0] = tolua.cast(var_5_3:getChildByTag(5), "CCControlButton")

			arg_3_0.btnGet[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onGet()
			end, CCControlEventTouchUpInside)

			arg_3_0.spriteGet[iter_5_0] = tolua.cast(var_5_3:getChildByTag(6), "CCSprite")
		end

		arg_3_0.btnTip = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnTip:addHandleOfControlEvent(function()
			g_Bubble:bubbleInfo("ֻ\xD3йݳ\xA4\xBF\xC9\xD2\xD4\xC1\xECȡӴ~")
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionWelfare_Ack)
end

function var_0_0.refresh(arg_11_0)
	arg_11_0.legionDetail = g_Self.kLegionHandler.legionDetail

	if arg_11_0.legionDetail == nil then
		return
	end

	arg_11_0:refreshAwards()

	local var_11_0 = g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId())

	for iter_11_0 = 1, 3 do
		if var_11_0 == 4 - iter_11_0 then
			arg_11_0.btnGet[iter_11_0]:setVisible(g_GameData.LegionInfo.Welfare == 0)
			arg_11_0.spriteGet[iter_11_0]:setVisible(g_GameData.LegionInfo.Welfare == 1)
		else
			arg_11_0.btnGet[iter_11_0]:setVisible(false)
			arg_11_0.spriteGet[iter_11_0]:setVisible(false)
		end
	end
end

function var_0_0.refreshAwards(arg_12_0)
	local var_12_0 = zbLegionDailyAwardTable:getRecord(arg_12_0.legionDetail.LegionBaseInfo.Level)

	if var_12_0 == nil then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.awardItems) do
		iter_12_1:setVisible(false)
	end

	for iter_12_2, iter_12_3 in pairs(var_12_0.dailyAward1) do
		if iter_12_2 > 3 then
			break
		end

		arg_12_0.awardItems[iter_12_2]:refreshAward(iter_12_3.type, iter_12_3.value, iter_12_3.number, false)
		arg_12_0.awardItems[iter_12_2]:setVisible(true)
	end

	for iter_12_4, iter_12_5 in pairs(var_12_0.dailyAward2) do
		if iter_12_4 > 3 then
			break
		end

		arg_12_0.awardItems[iter_12_4 + 3]:refreshAward(iter_12_5.type, iter_12_5.value, iter_12_5.number, false)
		arg_12_0.awardItems[iter_12_4 + 3]:setVisible(true)
	end

	for iter_12_6, iter_12_7 in pairs(var_12_0.dailyAward3) do
		if iter_12_6 > 3 then
			break
		end

		arg_12_0.awardItems[iter_12_6 + 6]:refreshAward(iter_12_7.type, iter_12_7.value, iter_12_7.number, false)
		arg_12_0.awardItems[iter_12_6 + 6]:setVisible(true)
	end
end

function var_0_0.onGet(arg_13_0)
	g_WsMsgHandler:WS_LegionGame_Welfare_Req()
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layer, var_14_0.x, var_14_0.y) == false and zbUtil:PointInCtrl(arg_14_0.btnClose, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
