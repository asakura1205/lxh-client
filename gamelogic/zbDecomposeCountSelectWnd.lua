require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbDecomposeCountSelectWnd", zbBaseWnd)

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

function createDecomposeCountSelWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.numSel = 1
		arg_3_0.numAll = 1
		arg_3_0.callback = callback
		arg_3_0.touchDecDown = false
		arg_3_0.touchAddDown = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/decomposecountselect.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.ItemNode = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.itemFrame = tolua.cast(arg_3_0.ItemNode:getChildByTag(1), "CCControlButton")
		arg_3_0.itemIcon = tolua.cast(arg_3_0.ItemNode:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbOwnNum = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.btnMin = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")
		arg_3_0.btnMax = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")
		arg_3_0.btnDec = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnAdd = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.spriteBarBg = tolua.cast(var_5_2:getChildByTag(13), "CCSprite")
		arg_3_0.lbSelNum = tolua.cast(var_5_2:getChildByTag(14), "CCLabelTTF")
		arg_3_0.btnSure = tolua.cast(var_5_2:getChildByTag(15), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSure:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)

		local function var_5_3(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(100)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBar = var_5_3(arg_3_0.spriteBarBg, "image/common/progress.png")
		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMin:addHandleOfControlEvent(function()
			arg_3_0:onMin()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onDec()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnMax:addHandleOfControlEvent(function()
			arg_3_0:onMax()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onAdd()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchDownDec()
		end, CCControlEventTouchDown)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnDec:addHandleOfControlEvent(function()
			arg_3_0:onTouchMoveDec()
		end, CCControlEventTouchMove)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchDownAdd()
		end, CCControlEventTouchDown)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:onTouchMoveAdd()
		end, CCControlEventTouchMove)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.onClose(arg_20_0)
	if arg_20_0.callback ~= nil then
		arg_20_0.callback()

		arg_20_0.callback = nil

		arg_20_0:hide()
	end
end

function var_0_0.refresh(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == nil then
		return
	end

	arg_21_0.data = arg_21_1
	arg_21_0.callback = arg_21_2
	arg_21_0.numSel = 1
	arg_21_0.numAll = 1
	arg_21_0.touchDecDown = false
	arg_21_0.touchAddDown = false

	local var_21_0 = zbItemTable:getRecord(arg_21_1.equip.TemplateId)

	if var_21_0 == nil then
		arg_21_0:hide()

		return
	end

	arg_21_0.numSel = 1

	arg_21_0.lbName:setString(var_21_0.name)

	local var_21_1 = zbColor:getEquipFragFrameTex(var_21_0.quality)

	ui:setButtonPic(arg_21_0.itemFrame, var_21_1, var_21_1, var_21_1)

	local var_21_2 = zbIconHelper:getItemIconPath(arg_21_1.equip.TemplateId)

	arg_21_0.itemIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_21_2))

	local var_21_3 = arg_21_1.equip.Count

	if var_21_3 == 0 then
		arg_21_0:hide()

		return
	end

	arg_21_0.numAll = var_21_3

	arg_21_0.lbOwnNum:setString(a2u("ӵ\xD3\xD0:" .. var_21_3))
	arg_21_0:refreshNum()
end

function var_0_0.refreshNum(arg_22_0)
	arg_22_0.lbSelNum:setString(arg_22_0.numSel .. "/" .. arg_22_0.numAll)

	local var_22_0 = math.min(math.ceil(100 * (arg_22_0.numSel / arg_22_0.numAll)), 100)

	arg_22_0.spriteBar:setPercentage(var_22_0)

	arg_22_0.data.count = arg_22_0.numSel
end

function var_0_0.onTouchDownDec(arg_23_0)
	arg_23_0.touchAddDown = false

	local var_23_0 = CCArray:create()

	var_23_0:addObject(CCDelayTime:create(0.3))
	var_23_0:addObject(CCCallFuncN:create(function()
		arg_23_0.touchDecDown = true
	end))

	local var_23_1 = CCSequence:create(var_23_0)

	arg_23_0:stopAllActions()
	arg_23_0:runAction(var_23_1)
end

function var_0_0.onTouchDownAdd(arg_25_0)
	arg_25_0.touchDecDown = false

	local var_25_0 = CCArray:create()

	var_25_0:addObject(CCDelayTime:create(0.3))
	var_25_0:addObject(CCCallFuncN:create(function()
		arg_25_0.touchAddDown = true
	end))

	local var_25_1 = CCSequence:create(var_25_0)

	arg_25_0:stopAllActions()
	arg_25_0:runAction(var_25_1)
end

function var_0_0.onTouchMoveDec(arg_27_0)
	local var_27_0 = arg_27_0.btnDec:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_27_0.btnDec, var_27_0.x, var_27_0.y) == false then
		arg_27_0:stopAllActions()

		arg_27_0.touchDecDown = false
	end
end

function var_0_0.onTouchMoveAdd(arg_28_0)
	local var_28_0 = arg_28_0.btnAdd:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_28_0.btnAdd, var_28_0.x, var_28_0.y) == false then
		arg_28_0:stopAllActions()

		arg_28_0.touchAddDown = false
	end
end

function var_0_0.onTouchEnd(arg_29_0)
	arg_29_0:stopAllActions()

	arg_29_0.touchDecDown = false
	arg_29_0.touchAddDown = false
end

function var_0_0.onMin(arg_30_0)
	if arg_30_0.numSel > 1 then
		arg_30_0.numSel = 1

		arg_30_0:refreshNum()
	end
end

function var_0_0.onDec(arg_31_0)
	if arg_31_0.numSel > 1 then
		arg_31_0.numSel = arg_31_0.numSel - 1

		arg_31_0:refreshNum()
	end
end

function var_0_0.onMax(arg_32_0)
	if arg_32_0.numSel ~= arg_32_0.numAll then
		arg_32_0.numSel = arg_32_0.numAll

		arg_32_0:refreshNum()
	end
end

function var_0_0.onAdd(arg_33_0)
	if arg_33_0.numSel < arg_33_0.numAll then
		arg_33_0.numSel = arg_33_0.numSel + 1

		arg_33_0:refreshNum()
	end
end

function var_0_0.onTouchTest(arg_34_0)
	local var_34_0 = arg_34_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_34_0.layerTouchTest, var_34_0.x, var_34_0.y) == false and zbUtil:PointInCtrl(arg_34_0.btnClose, var_34_0.x, var_34_0.y) == false then
		arg_34_0:onClose()
	end
end

local var_0_1 = os_timenow()

function var_0_0.onFrameUpdate(arg_35_0, arg_35_1)
	if os_timenow() - var_0_1 < 0.02 then
		return
	end

	var_0_1 = os_timenow()

	if arg_35_0.touchDecDown then
		arg_35_0:onDec()
	end

	if arg_35_0.touchAddDown then
		arg_35_0:onAdd()
	end
end
