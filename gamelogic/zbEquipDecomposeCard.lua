local var_0_0 = class("zbEquipDecomposeCard")

var_0_0.__index = var_0_0

local var_0_1 = 5

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createEquipDecomposeCard(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.selectCallback = nil
	arg_3_0.type = arg_3_2

	translateAndStrokeHelper(arg_3_1)

	local var_3_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

	arg_3_0.btnTouch = tolua.cast(var_3_0:getChildByTag(0), "CCControlButton")
	arg_3_0.headRoot = tolua.cast(var_3_0:getChildByTag(1), "CCLayerColor")
	arg_3_0.spriteFrame = tolua.cast(arg_3_0.headRoot:getChildByTag(1), "CCSprite")
	arg_3_0.spriteHead = tolua.cast(arg_3_0.headRoot:getChildByTag(2), "CCSprite")
	arg_3_0.level = tolua.cast(arg_3_0.headRoot:getChildByTag(4), "CCLabelTTF")
	arg_3_0.lbName = tolua.cast(arg_3_0.headRoot:getChildByTag(6), "CCLabelTTF")

	local var_3_1 = tolua.cast(var_3_0:getChildByTag(4), "CCSprite")

	arg_3_0.checkBoxOk = tolua.cast(var_3_1:getChildByTag(1), "CCSprite")

	arg_3_0.btnTouch:addHandleOfControlEvent(handler(arg_3_0, arg_3_0.btnTouchCallback), CCControlEventTouchUpInside)
	arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
	arg_3_0.btnTouch:setSwallowsTouches(false)
	arg_3_0.btnTouch:setZoomScaleInner(false)
	arg_3_0.btnTouch:setZoomOnTouchDown(false)
	arg_3_0:setContentSize(var_3_0:getContentSize())
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setPosition(0, 0)
	arg_3_0:addChild(arg_3_1)
	arg_3_0:onSelect(false)
end

function var_0_0.refresh(arg_4_0, arg_4_1)
	arg_4_0:setVisible(arg_4_1 ~= nil)

	if arg_4_1 == nil then
		return
	end

	arg_4_0.data = arg_4_1

	arg_4_0.level:setVisible(not arg_4_1.isFrag and arg_4_1.equip.Level > 0)

	arg_4_0.selectCallback = nil

	local var_4_0 = zbItemTable:getRecord(arg_4_1.equip.TemplateId)

	arg_4_0.equipRecord = var_4_0
	arg_4_0.AllNum = 0

	if var_4_0 == nil then
		return
	end

	local var_4_1 = zbColor:getEquipFrameTex(var_4_0.quality)

	if arg_4_1.isFrag then
		var_4_1 = zbColor:getEquipFragFrameTex(var_4_0.quality)
	end

	arg_4_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_1))

	local var_4_2 = zbIconHelper:getItemIconPath(arg_4_1.equip.TemplateId)

	arg_4_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_2))

	local var_4_3 = arg_4_1.count

	arg_4_0.AllNum = var_4_3

	if not arg_4_1.isFrag then
		arg_4_0.level:setString(arg_4_1.equip.Level)
		arg_4_0.level:setVisible(arg_4_1.equip.Level >= 1)

		if var_4_3 > 1 then
			arg_4_0.lbName:setString(var_4_0.name .. a2u("X") .. var_4_3)
		else
			arg_4_0.lbName:setString(var_4_0.name)
		end
	else
		arg_4_0.lbName:setString(var_4_0.name .. a2u("X") .. var_4_3)
	end

	arg_4_0:onSelect(g_MainScene.wndEquipDecompose:isSelect(arg_4_1))
end

function var_0_0.btnTouchCallback(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:getTag()

	if g_MainScene.wndEquipDecomposeSelect:getEquipListNum() >= var_0_1 and var_5_0 == 0 then
		g_Bubble:bubbleInfo(a2u("\xC8\xDB\xC1\xB6λ\xD2\xD1\xC2\xFA"))

		return
	end

	local var_5_1 = true

	if var_5_0 == 1 then
		var_5_1 = false
	end

	arg_5_0:onSelect(var_5_1)

	if var_5_1 then
		if arg_5_0.AllNum > 1 then
			local function var_5_2()
				g_MainScene.wndEquipDecomposeSelect:addEquipSelected(arg_5_0.data)
			end

			g_MainScene:showDecomposeCountSelcetWnd(arg_5_0.data, var_5_2):setPrevWnd(g_MainScene.wndEquipDecomposeSelect)
		else
			arg_5_0.data.count = 1

			g_MainScene.wndEquipDecomposeSelect:addEquipSelected(arg_5_0.data)
		end
	else
		g_MainScene.wndEquipDecomposeSelect:removeEquipSelected(arg_5_0.data)
	end
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	local var_7_0 = 0

	if arg_7_1 then
		var_7_0 = 1
	end

	arg_7_0.btnTouch:setTag(var_7_0)
	arg_7_0.checkBoxOk:setVisible(arg_7_1)
end
