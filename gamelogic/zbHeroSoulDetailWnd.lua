require("gamelogic.proto")

zbHeroSoulDetailWnd = class("zbHeroSoulDetailWnd", zbBaseWnd)
zbHeroSoulDetailWnd.__index = zbHeroSoulDetailWnd

function zbHeroSoulDetailWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulDetailWnd)

	return arg_1_0
end

function zbHeroSoulDetailWnd.create(arg_2_0)
	local var_2_0 = zbHeroSoulDetailWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroSoulDetailWnd.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroSoulDetail.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerOperate = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.layerOperate:getChildByTag(1), "CCSprite")
		arg_3_0.lbHeroName = tolua.cast(arg_3_0.layerOperate:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteDengjie = tolua.cast(arg_3_0.layerOperate:getChildByTag(3), "CCSprite")
		arg_3_0.spriteJibie = tolua.cast(arg_3_0.layerOperate:getChildByTag(4), "CCSprite")
		arg_3_0.nodeJiacheng = tolua.cast(arg_3_0.layerOperate:getChildByTag(5), "CCNode")
		arg_3_0.lbMiaoshu = tolua.cast(arg_3_0.nodeJiacheng:getChildByTag(3), "CCLabelTTF")
		arg_3_0.nodeEwai = tolua.cast(arg_3_0.layerOperate:getChildByTag(6), "CCNode")
		arg_3_0.lbEWaiDesc1 = tolua.cast(arg_3_0.nodeEwai:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbEWaiDesc2 = tolua.cast(arg_3_0.nodeEwai:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnUse = tolua.cast(arg_3_0.layerOperate:getChildByTag(7), "CCControlButton")

		arg_3_0.btnUse:addHandleOfControlEvent(function()
			arg_3_0:touchOnItem()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroSoulDetailWnd.doDestroy(arg_9_0)
	return
end

function zbHeroSoulDetailWnd.refresh(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.hallRecord = arg_10_1
	arg_10_0.myIndex = arg_10_2
	arg_10_0.hallData = arg_10_3

	local var_10_0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.hallData.HeroSoulList) do
		if arg_10_0.myIndex == iter_10_1.Position then
			var_10_0 = iter_10_1
			var_10_1 = var_10_1 + table.getn(iter_10_1.SoulList)
		end
	end

	local var_10_2 = zbHeroSoulHallTable:getHeroID(arg_10_0.hallRecord.id, arg_10_0.myIndex)
	local var_10_3 = zbHeroTable:getRecord(var_10_2)

	if var_10_3 ~= nil then
		arg_10_0.lbHeroName:setString(var_10_3.name)
	end

	local var_10_4 = zbIconHelper:getPlayerHeadIconPath(var_10_2)

	arg_10_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_4))

	local var_10_5 = 11

	for iter_10_2, iter_10_3 in pairs(var_10_0.SoulList) do
		if iter_10_3.Status == 1 then
			var_10_5 = iter_10_3.HeroSoulId
		end
	end

	arg_10_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_10_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herosoul.plist")

	local var_10_6 = zbHeroSoulTable:getRecordUseId(var_10_5)

	if var_10_6 ~= nil then
		local var_10_7 = arg_10_0.spriteframeCache:spriteFrameByName("herosoul_dengjie0" .. var_10_6.quality .. ".png")

		if var_10_7 then
			arg_10_0.spriteDengjie:initWithSpriteFrame(var_10_7)
		end

		local var_10_8 = arg_10_0.spriteframeCache:spriteFrameByName("herosoul_jibie0" .. var_10_6.grade .. ".png")

		if var_10_8 then
			arg_10_0.spriteJibie:initWithSpriteFrame(var_10_8)
		end
	end

	local var_10_9

	for iter_10_4, iter_10_5 in pairs(arg_10_0.hallData.HeroAddAttrList) do
		if arg_10_0.myIndex == iter_10_5.Position then
			var_10_9 = iter_10_5

			break
		end
	end

	if var_10_9 ~= nil then
		arg_10_0.lbMiaoshu:setString(a2u(g_strAttrType[var_10_9.AttrType]) .. "+" .. var_10_9.AttrValue)
	end

	arg_10_0.lbEWaiDesc2:setVisible(false)

	local var_10_10 = a2u(string.format("\xD1\xFD\xC1\xE9\xB4ﵽ%d\xB8\xF6\xA3\xAC\xCA\xF4\xD0Զ\xEE\xCD\xE2\xCC\xE1\xC9\xFD%d", var_10_1, var_10_1 * g_DataConfig.m_kCommonCfg.heroSoulHall.addValue.oneAdd * 100))

	arg_10_0.lbEWaiDesc1:setString(var_10_3.name .. var_10_10 .. "%")

	for iter_10_6, iter_10_7 in pairs(g_GameData.HeroList) do
		if var_10_2 == iter_10_7.HeroBaseInfo.TemplateId then
			local var_10_11 = a2u(string.format("\xB4ﵽ%d\xD0ǣ\xAC\xCA\xF4\xD0Զ\xEE\xCD\xE2\xCC\xE1\xC9\xFD%d", iter_10_7.HeroBaseInfo.Star, arg_10_0:getStar(iter_10_7.HeroBaseInfo.Star) * 100))

			arg_10_0.lbEWaiDesc2:setString(var_10_3.name .. var_10_11 .. "%")
			arg_10_0.lbEWaiDesc2:setVisible(true)
		end
	end
end

function zbHeroSoulDetailWnd.getStar(arg_11_0, arg_11_1)
	return g_DataConfig.m_kCommonCfg.heroSoulHall.addValue["Star" .. arg_11_1]
end

function zbHeroSoulDetailWnd.onTouchTest(arg_12_0)
	local var_12_0 = arg_12_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_12_0.layerTouchTest, var_12_0.x, var_12_0.y) == false and zbUtil:PointInCtrl(arg_12_0.btnClose, var_12_0.x, var_12_0.y) == false then
		arg_12_0:hide()
	end
end

function zbHeroSoulDetailWnd.touchOnItem(arg_13_0)
	g_MainScene:showHeroSoulList(arg_13_0.hallRecord, arg_13_0.myIndex)
	g_MainScene.wndHeroSoulList:setPrevWnd(g_MainScene.wndHeroSoulView)
	arg_13_0:hide()
end
