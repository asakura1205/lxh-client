require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbWorldTaskSetWnd", zbBaseWnd)

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

function createWorldTaskSetWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.needHeroTag = {}
		arg_3_0.needHeroTagSelect = {}
		arg_3_0.lastTouchTime = 0
		arg_3_0.awardItems = {}
		arg_3_0.taskdata = nil
		arg_3_0.selheroIndex = 1
		arg_3_0.selHeroData = {}
		arg_3_0.needHeroAttr = {}
		arg_3_0.addDiamondCount = 0
		arg_3_0.tagCount = 0
		arg_3_0.costDiamon = 0
		arg_3_0.successRate = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_taskset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nodeNeed = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.lbNeedFv = tolua.cast(arg_3_0.nodeNeed:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbCurFv = tolua.cast(arg_3_0.nodeNeed:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbNeedTime = tolua.cast(arg_3_0.nodeNeed:getChildByTag(3), "CCLabelTTF")

		for iter_5_0 = 1, 3 do
			arg_3_0.needHeroTag[iter_5_0] = tolua.cast(arg_3_0.nodeNeed:getChildByTag(iter_5_0 + 3), "CCSprite")
			arg_3_0.needHeroTagSelect[iter_5_0] = tolua.cast(arg_3_0.needHeroTag[iter_5_0]:getChildByTag(1), "CCSprite")
		end

		arg_3_0.nodeSelect = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.btnSel = {}
		arg_3_0.selHeroSp = {}
		arg_3_0.selAddSp = {}
		arg_3_0.selHeroFrame = {}

		for iter_5_1 = 1, 3 do
			local var_5_3 = tolua.cast(arg_3_0.nodeSelect:getChildByTag(iter_5_1), "CCNode")

			arg_3_0.btnSel[iter_5_1] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

			arg_3_0.btnSel[iter_5_1]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_1)
			end, CCControlEventTouchUpInside)
			arg_3_0.btnSel[iter_5_1]:addHandleOfControlEvent(function()
				arg_3_0:onTouchDown(iter_5_1)
			end, CCControlEventTouchDown)
			arg_3_0.btnSel[iter_5_1]:addHandleOfControlEvent(function()
				arg_3_0:onTouchEnd(iter_5_1)
			end, CCControlEventTouchEnd)

			arg_3_0.selHeroSp[iter_5_1] = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
			arg_3_0.selAddSp[iter_5_1] = tolua.cast(var_5_3:getChildByTag(2), "CCSprite")
			arg_3_0.selHeroFrame[iter_5_1] = tolua.cast(var_5_3:getChildByTag(4), "CCSprite")

			zbUIEffect:runFadeToAction(arg_3_0.selAddSp[iter_5_1])
		end

		arg_3_0.nodeMoney = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		arg_3_0.lbSuccess = tolua.cast(arg_3_0.nodeMoney:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteMoney2 = tolua.cast(arg_3_0.nodeMoney:getChildByTag(3), "CCSprite")
		arg_3_0.lbMoneyDummy1 = tolua.cast(arg_3_0.nodeMoney:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbMoneyDummy2 = tolua.cast(arg_3_0.nodeMoney:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnExplore = tolua.cast(arg_3_0.nodeMoney:getChildByTag(6), "CCControlButton")
		arg_3_0.btnaddMoney = tolua.cast(arg_3_0.nodeMoney:getChildByTag(11), "CCControlButton")
		arg_3_0.btnaddJianMoney = tolua.cast(arg_3_0.nodeMoney:getChildByTag(10), "CCControlButton")

		arg_3_0.btnaddMoney:addHandleOfControlEvent(function()
			arg_3_0:onSetAddDiamondCount(1)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnaddJianMoney:addHandleOfControlEvent(function()
			arg_3_0:onSetAddDiamondCount(2)
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnExplore:addHandleOfControlEvent(function()
			arg_3_0:onExplore()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.taskdata = arg_14_1

		arg_14_0.lbNeedFv:setString(arg_14_0.taskdata.FV)
		arg_14_0:setCurFightValue(0)

		local var_14_0 = arg_14_1.NodeId
		local var_14_1 = zbWorldNodeTable:getRecord(var_14_0)

		if var_14_1 then
			local var_14_2 = var_14_1.taskId
			local var_14_3 = zbWorldTaskTable:getRecord(var_14_2)

			if var_14_3 then
				arg_14_0.lbNeedTime:setString(var_14_3.needTm .. a2u("\xB7\xD6\xD6\xD3"))
				arg_14_0.lbMoneyDummy2:setString(var_14_3.needFood)
			end
		end

		arg_14_0.addDiamondCount = 0
		arg_14_0.costDiamon = 0

		arg_14_0.lbMoneyDummy1:setString(0)
		arg_14_0.lbSuccess:setString(a2u("\xB3ɹ\xA6\xC2\xCA:0%"))

		for iter_14_0 = 1, 3 do
			arg_14_0.needHeroTag[iter_14_0]:setVisible(false)
			arg_14_0.needHeroTagSelect[iter_14_0]:setVisible(false)
		end

		local var_14_4 = 1

		if zbUtil:isValidTable(arg_14_0.taskdata.AttrList) then
			arg_14_0.needHeroAttr = {}

			for iter_14_1, iter_14_2 in pairs(arg_14_0.taskdata.AttrList) do
				local var_14_5 = {}

				var_14_5.isTag = false
				var_14_5.type = iter_14_2

				table.insert(arg_14_0.needHeroAttr, var_14_5)
				arg_14_0.needHeroTag[var_14_4]:setVisible(true)
				arg_14_0.needHeroTag[var_14_4]:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(iter_14_2)))

				var_14_4 = var_14_4 + 1
			end
		end

		arg_14_0.selHeroData = {}

		arg_14_0:refreshSelHero()
	end
end

function var_0_0.onSetAddDiamondCount(arg_15_0, arg_15_1)
	if table.maxn(arg_15_0.selHeroData) <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ѡ\xD4\xF1\xBB\xEF\xB0\xE9"))

		return
	end

	local var_15_0 = table.getn(g_DataConfig.m_kWorldBaseCfg.task.addRateCost)

	if arg_15_1 == 1 then
		if arg_15_0.successRate == 100 then
			return
		end

		if var_15_0 <= arg_15_0.addDiamondCount then
			arg_15_0.addDiamondCount = var_15_0
		else
			arg_15_0.addDiamondCount = arg_15_0.addDiamondCount + 1
		end
	elseif arg_15_0.addDiamondCount <= 0 then
		arg_15_0.addDiamondCount = 0
	else
		arg_15_0.addDiamondCount = arg_15_0.addDiamondCount - 1
	end

	if arg_15_0.addDiamondCount > 0 then
		local var_15_1 = g_DataConfig.m_kWorldBaseCfg.task.addRateCost[arg_15_0.addDiamondCount]

		arg_15_0.lbMoneyDummy1:setString(var_15_1)

		arg_15_0.costDiamon = var_15_1
	else
		arg_15_0.lbMoneyDummy1:setString(0)

		arg_15_0.costDiamon = 0
	end

	arg_15_0:setSuccessRate()
end

function var_0_0.getMoenyRate(arg_16_0)
	local var_16_0 = 0

	return arg_16_0.addDiamondCount * 10
end

function var_0_0.setSuccessRate(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = arg_17_0:getMoenyRate()

	if var_17_1 >= 100 then
		arg_17_0.lbSuccess:setString(a2u("\xB3ɹ\xA6\xC2\xCA:100%"))

		return
	end

	local var_17_2 = 0

	if arg_17_0.taskdata then
		var_17_2 = arg_17_0.taskdata.FV
	end

	local var_17_3 = 0
	local var_17_4 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_0.selHeroData) do
		var_17_4 = var_17_4 + iter_17_1.HeroBaseInfo.FV
	end

	local var_17_5 = var_17_1 + math.min(var_17_4 / var_17_2, 1) * 60

	if arg_17_0.tagCount == 3 then
		var_17_5 = var_17_5 + 40
	elseif arg_17_0.tagCount == 2 then
		var_17_5 = var_17_5 + 20
	elseif arg_17_0.tagCount == 1 then
		var_17_5 = var_17_5 + 10
	end

	local var_17_6 = math.ceil(var_17_5)
	local var_17_7 = math.min(100, var_17_6)

	arg_17_0.successRate = var_17_7

	arg_17_0.lbSuccess:setString(a2u("\xB3ɹ\xA6\xC2\xCA:") .. var_17_7 .. "%")
end

function var_0_0.setCurFightValue(arg_18_0, arg_18_1)
	arg_18_0.lbCurFv:setString(arg_18_1)
end

function var_0_0.refreshSelHero(arg_19_0)
	for iter_19_0 = 1, 3 do
		arg_19_0.needHeroTagSelect[iter_19_0]:setVisible(false)
	end

	for iter_19_1, iter_19_2 in pairs(arg_19_0.needHeroAttr) do
		iter_19_2.isTag = false
	end

	local var_19_0 = 0

	arg_19_0.tagCount = 0

	for iter_19_3 = 1, 3 do
		local var_19_1 = arg_19_0.selHeroData[iter_19_3]

		arg_19_0.selHeroSp[iter_19_3]:setVisible(var_19_1 ~= nil)
		arg_19_0.selAddSp[iter_19_3]:setVisible(var_19_1 == nil)
		arg_19_0.selHeroFrame[iter_19_3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/frame/heroframe/heroframe1.png"))

		if var_19_1 then
			var_19_0 = var_19_1.HeroBaseInfo.FV + var_19_0

			local var_19_2 = zbIconHelper:getHeroIconPath(var_19_1.HeroBaseInfo.TemplateId)

			arg_19_0.selHeroSp[iter_19_3]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_19_2))

			local var_19_3 = zbColor:getHeroFrameTex(var_19_1.HeroBaseInfo.Quality)

			arg_19_0.selHeroFrame[iter_19_3]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_19_3))

			local var_19_4 = zbHeroTable:getRecord(var_19_1.HeroBaseInfo.TemplateId)

			local function var_19_5(arg_20_0)
				for iter_20_0, iter_20_1 in pairs(arg_19_0.needHeroAttr) do
					if iter_20_1.type == arg_20_0 and iter_20_1.isTag == false then
						iter_20_1.isTag = true

						return true
					end
				end
			end

			if var_19_4 then
				local var_19_6 = var_19_4.heroType
				local var_19_7

				if zbUtil:isValidTable(arg_19_0.taskdata.AttrList) then
					for iter_19_4, iter_19_5 in pairs(arg_19_0.taskdata.AttrList) do
						if iter_19_5 == var_19_6 then
							var_19_7 = iter_19_4

							if arg_19_0.needHeroTagSelect[var_19_7]:isVisible() == false then
								break
							end
						end
					end
				end

				if var_19_7 and var_19_5(var_19_6) then
					arg_19_0.tagCount = arg_19_0.tagCount + 1

					arg_19_0.needHeroTagSelect[var_19_7]:setVisible(true)
				end
			end
		end
	end

	arg_19_0:setCurFightValue(var_19_0)
	arg_19_0:setSuccessRate()
end

function var_0_0.getSelectedHeros(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = g_Self.kWorldHandler.worldInfo

	if var_21_1 and zbUtil:isValidTable(var_21_1.TaskList) then
		for iter_21_0, iter_21_1 in pairs(var_21_1.TaskList) do
			if zbUtil:isValidTable(iter_21_1.TeamList) then
				for iter_21_2, iter_21_3 in pairs(iter_21_1.TeamList) do
					for iter_21_4, iter_21_5 in pairs(iter_21_3.HeroList) do
						table.insert(var_21_0, iter_21_5)
					end
				end
			end
		end
	end

	for iter_21_6, iter_21_7 in pairs(arg_21_0.selHeroData) do
		local var_21_2 = iter_21_7.HeroBaseInfo.TemplateId

		table.insert(var_21_0, var_21_2)
	end

	return var_21_0
end

function var_0_0.onSelHero(arg_22_0, arg_22_1)
	arg_22_0.selheroIndex = arg_22_1

	local var_22_0 = arg_22_0:getSelectedHeros()
	local var_22_1 = g_MainScene:showWorldHeroSelectWnd()

	var_22_1:setPrevWnd(arg_22_0)
	var_22_1:setCannotSelList(var_22_0)
	var_22_1:refreshHeroSelCallback(handler(arg_22_0, arg_22_0.heroSelectBack))
end

function var_0_0.heroSelectBack(arg_23_0, arg_23_1)
	arg_23_0.selHeroData[arg_23_0.selheroIndex] = arg_23_1

	arg_23_0:refreshSelHero()
end

function var_0_0.onTouch(arg_24_0, arg_24_1)
	if arg_24_0.showTipsWnd == false then
		if arg_24_0.selHeroData[arg_24_1] then
			arg_24_0.selHeroData[arg_24_1] = nil

			arg_24_0:refreshSelHero()

			return
		end

		arg_24_0:onSelHero(arg_24_1)
	end
end

function var_0_0.onTouchDown(arg_25_0, arg_25_1)
	if os_timenow() - arg_25_0.lastTouchTime < 0.5 then
		-- block empty
	else
		arg_25_0.lastTouchTime = os_timenow()
	end

	arg_25_0.touchDown = true
	arg_25_0.showTipsWnd = false
	arg_25_0.lastDownTouch = arg_25_0.btnSel[arg_25_1]:getTouch():getLocation()

	local var_25_0 = CCArray:create()

	var_25_0:addObject(CCDelayTime:create(0.3))
	var_25_0:addObject(CCCallFuncN:create(function()
		arg_25_0:onShowTips(arg_25_1)
	end))

	local var_25_1 = CCSequence:create(var_25_0)

	arg_25_0:stopAllActions()
	arg_25_0:runAction(var_25_1)
end

function var_0_0.onShowTips(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.layer

	while var_27_0:getParent() ~= nil do
		var_27_0 = var_27_0:getParent()
	end

	if arg_27_0.selHeroData[arg_27_1] ~= nil then
		arg_27_0.showTipsWnd = true

		local var_27_1 = var_27_0:convertToNodeSpace(arg_27_0.lastDownTouch)

		g_MainScene:showHeroTip(arg_27_0.selHeroData[arg_27_1].HeroBaseInfo)
		g_MainScene.wndCommomTip:refreshPos(var_27_1)
	end
end

function var_0_0.onTouchEnd(arg_28_0, arg_28_1)
	arg_28_0.lastTouchTime = os_timenow()
	arg_28_0.touchDown = false

	arg_28_0:stopAllActions()

	if g_MainScene.wndCommomTip ~= nil then
		g_MainScene.wndCommomTip:hideTips()
	end
end

function var_0_0.onExplore(arg_29_0)
	if table.maxn(arg_29_0.selHeroData) <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8ѡ\xD4\xF1\xBB\xEF\xB0\xE9"))

		return
	end

	if arg_29_0.costDiamon > g_GameData.Wealth.Diamond then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0.selHeroData) do
		table.insert(var_29_0, iter_29_1.HeroBaseInfo.TemplateId)
	end

	if arg_29_0.taskdata then
		g_WsMsgHandler:WS_WorldTask_Start_Req(arg_29_0.taskdata.NodeId, arg_29_0.addDiamondCount, var_29_0)
	end

	arg_29_0:hide()
end

function var_0_0.onTouchTest(arg_30_0)
	local var_30_0 = arg_30_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_30_0.layer, var_30_0.x, var_30_0.y) == false then
		arg_30_0:hide()
	end
end
