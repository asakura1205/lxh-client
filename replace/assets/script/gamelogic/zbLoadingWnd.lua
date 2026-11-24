require("gamelogic.zbBaseWnd")
require("gamelogic.zbLoadingRes")

g_ccbiTable = {}

local var_0_0 = class("zbLoadingWnd", zbBaseWnd)

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

function createLoadingWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.resCount = 0
		arg_3_0.curCount = 0
		arg_3_0.finish = false
		arg_3_0.progressSlider = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/loading.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.spriteBg = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")
		arg_3_0.lblpersent = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.sprite = tolua.cast(var_5_2:getChildByTag(100), "CCSprite")

		tolua.cast(var_5_2:getChildByTag(4), "CCSprite"):setVisible(g_Login.channel ~= EChannelType.uc)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(5), "CCSprite")

		arg_3_0.progressSlider = CCControlSlider:create("image/login/loading/load_progressbg.png", "image/login/loading/load_progress.png", "image/login/loading/load_fly06.png")

		arg_3_0.progressSlider:setMinimumValue(0)
		arg_3_0.progressSlider:setMaximumValue(100)
		arg_3_0.progressSlider:setAnchorPoint(var_5_3:getAnchorPoint())
		arg_3_0.progressSlider:setPosition(var_5_3:getPosition())
		arg_3_0.progressSlider:setScale(zbGlobalUtil:correctScale(1))
		arg_3_0.progressSlider:getThumbSprite():setVisible(true)
		arg_3_0.progressSlider:getThumbSprite():setAnchorPoint(ccp(0.8, 0.4))
		arg_3_0.progressSlider:setTouchEnabled(false)

		arg_3_0.EnjoymintonNode = tolua.cast(var_5_2:getChildByTag(7), "CCSprite")

		arg_3_0.EnjoymintonNode:setZOrder(ZORDER_TOP)
		arg_3_0.spriteBg:setVisible(false)

		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0.layerScene:load(COMBAT_SCENE_LOGIN)
		arg_3_0:addChild(arg_3_0.layerScene)
		var_5_2:addChild(arg_3_0.progressSlider)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.doDestroy(arg_6_0)
	arg_6_0.layerScene:free()
end

function var_0_0.beginLoad(arg_7_0)
	CCDirector:sharedDirector():setAnimationInterval(0.016666666666666666)

	arg_7_0.resImageCount = table.getn(logingameRes.image)
	arg_7_0.resCCBICount = table.getn(logingameRes.ccbi)
	arg_7_0.resCCBI2Count = table.getn(logingameRes.ccbi2)
	arg_7_0.resCount = arg_7_0.resImageCount + arg_7_0.resCCBICount + arg_7_0.resCCBI2Count
	arg_7_0.curCount = 0
	arg_7_0.finish = false

	arg_7_0.lblpersent:setString("0%")
	arg_7_0.progressSlider:setValue(0)

	if g_Self:getName() == "" then
		g_Audio.preLoadMgr:preHero(1001)
		g_Audio.preLoadMgr:preHero(1011)
		g_Audio.preLoadMgr:preHero(1041)
	end

	for iter_7_0, iter_7_1 in pairs(zbAvatarSoundTable.records) do
		g_Audio.preLoadMgr:addTask(iter_7_1.attackSound)
	end
end

function var_0_0.onFrameUpdate(arg_8_0)
	if arg_8_0.finish then
		return
	end

	if arg_8_0.progressSlider ~= nil then
		arg_8_0.progressSlider:setVisible(true)
	end

	-- [本地私服] 一帧内加载完全部资源，直接跳到 100%（原为每帧加载一个）
	while arg_8_0.curCount < arg_8_0.resCount do
		arg_8_0.curCount = arg_8_0.curCount + 1

		if arg_8_0.curCount <= arg_8_0.resImageCount then
			local var_8_0 = logingameRes.image[arg_8_0.curCount]
			local var_8_1 = CCTextureCache:sharedTextureCache():addImage(var_8_0)

			var_8_1:retain()
			arg_8_0.sprite:setTexture(var_8_1)
		elseif arg_8_0.curCount <= arg_8_0.resImageCount + arg_8_0.resCCBICount then
			local var_8_2 = logingameRes.ccbi[arg_8_0.curCount - arg_8_0.resImageCount]
			local var_8_3 = CCBProxy:create()
			local var_8_4 = CCBReaderLoad(var_8_2, var_8_3, true, "HelloCocosBuilderLayerOwner")

			g_ccbiTable[var_8_2] = var_8_4
		else
			local var_8_5 = logingameRes.ccbi2[arg_8_0.curCount - arg_8_0.resImageCount - arg_8_0.resCCBICount]
			local var_8_6 = CCBProxy:create()
			local var_8_7 = CCBReaderLoad(var_8_5, var_8_6, true, "HelloCocosBuilderLayerOwner", true)

			g_ccbiTable[var_8_5] = var_8_7
		end
	end

	arg_8_0.lblpersent:setString("100%")

	if arg_8_0.progressSlider ~= nil then
		arg_8_0.progressSlider:setValue(97)
		arg_8_0:setBadmintonTexture(97)
	end

	arg_8_0:finishLoad()
end

function var_0_0.setBadmintonTexture(arg_9_0, arg_9_1)
	local var_9_0 = 18

	for iter_9_0 = 1, 6 do
		if arg_9_1 >= var_9_0 * (iter_9_0 - 1) and arg_9_1 < var_9_0 * iter_9_0 then
			local var_9_2 = CCTextureCache:sharedTextureCache():addImage("image/login/loading/load_fly0" .. iter_9_0 .. ".png")

			arg_9_0.progressSlider:getThumbSprite():setTexture(var_9_2)

			local var_9_3 = CCTextureCache:sharedTextureCache():addImage("image/login/loading/load_enjoy0" .. iter_9_0 .. ".png")

			arg_9_0.EnjoymintonNode:setTexture(var_9_3)

			return
		end
	end
end

function var_0_0.finishLoad(arg_10_0)
	CCDirector:sharedDirector():setAnimationInterval(0.03333333333333333)
	g_Self:onAfterEnterGame()

	arg_10_0.finish = true

	arg_10_0:hide()

	if g_Self:getName() == "" then
		g_Audio.preLoadMgr:stop()
	end

	local var_10_0 = g_Self:getLevel()

	if g_Self:getName() == "" then
		g_Guide:execGuide(GUIDE_STEP_STORY)
	else
		g_MainScene:showMain()
		g_MainScene:createHeroListWnd()

		if var_10_0 == 1 then
			g_Guide:execGuide(GUIDE_STEP_FRISTIN)
		elseif var_10_0 == 2 then
			g_Guide:execGuide(GUIDE_STEP_LEVEL002)
		elseif var_10_0 == 3 then
			g_Guide:execGuide(GUIDE_STEP_LEVEL003)
		elseif var_10_0 == 4 then
			-- block empty
		elseif var_10_0 == 5 then
			-- block empty
		elseif zbGlobalUtil:getTargetPlatform() ~= "ios" then
			g_MainScene:showSubjectWnd()
		end
	end

	g_WsMsgHandler:WS_Login_GameComplete_Req()
end

function getPreloadCCNode(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(g_ccbiTable) do
		if iter_11_0 == arg_11_0 then
			return iter_11_1
		end
	end

	return nil
end
