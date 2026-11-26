require("gamelogic.zbTabWnd")
require("gamelogic.zbHeroPreviewList")

local var_0_0 = class("zbHeroPreviewWnd", zbTabWnd)

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

function createHeroPreviewWnd()
	local var_2_0 = var_0_0.extend(zbTabWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heropreview.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(401), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(100), "CCSprite")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(101), "CCSprite")
		local var_5_5 = {
			[ERarityType.B] = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton"),
			[ERarityType.A] = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton"),
			[ERarityType.S] = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton"),
			[ERarityType.SS] = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		}
		local var_5_6 = {
			[ERarityType.B] = tolua.cast(var_5_2:getChildByTag(1), "CCLayer"),
			[ERarityType.A] = tolua.cast(var_5_2:getChildByTag(2), "CCLayer"),
			[ERarityType.S] = tolua.cast(var_5_2:getChildByTag(3), "CCLayer"),
			[ERarityType.SS] = tolua.cast(var_5_2:getChildByTag(4), "CCLayer")
		}
		local var_5_7 = {
			[ERarityType.B] = "image/tab/tab_rarity_b.png",
			[ERarityType.A] = "image/tab/tab_rarity_a.png",
			[ERarityType.S] = "image/tab/tab_rarity_s.png",
			[ERarityType.SS] = "image/tab/tab_rarity_ss.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ERarityType.B] = createHeroPreviewList(var_5_6[ERarityType.B], ERarityType.B, var_5_3, var_5_4)
		arg_3_0.module[ERarityType.A] = createHeroPreviewList(var_5_6[ERarityType.A], ERarityType.A, var_5_3, var_5_4)
		arg_3_0.module[ERarityType.S] = createHeroPreviewList(var_5_6[ERarityType.S], ERarityType.S, var_5_3, var_5_4)
		arg_3_0.module[ERarityType.SS] = createHeroPreviewList(var_5_6[ERarityType.SS], ERarityType.SS, var_5_3, var_5_4)

		arg_3_0:initTab(var_5_5, var_5_6, var_5_7)

		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(100), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(101), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0)
	arg_7_0:selectTab(4)
end

function var_0_0.doSelectTab(arg_8_0)
	arg_8_0.module[arg_8_0.currTab]:refresh()
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:hide()

	if g_MainScene.wndPub then
		g_MainScene.wndPub:setDrawNodeVisible(true)
	end
end
