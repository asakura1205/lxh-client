local var_0_0 = class("zbMapNodeOpenDlg", CCNodeExtend)

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

function createMapNodeOpenGlg()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local var_3_1 = CCBProxy:create()
	local var_3_2 = CCBReaderLoad("ccbi/world_opennode.ccbi", var_3_1, true, "HelloCocosBuilderLayerOwner")
	local var_3_3 = tolua.cast(var_3_2:getChildByTag(1), "CCLayer")

	arg_3_0.layer = var_3_3
	arg_3_0.btnTouch = tolua.cast(var_3_3:getChildByTag(3), "CCControlButton")

	arg_3_0.btnTouch:setSwallowsTouches(true)
	arg_3_0.btnTouch:addHandleOfControlEvent(function()
		arg_3_0:onTouch()
	end, CCControlEventTouchUpInside)

	arg_3_0.lblLevelNeed = tolua.cast(var_3_3:getChildByTag(1002), "CCLabelTTF")
	arg_3_0.foodCostNode = tolua.cast(var_3_3:getChildByTag(2), "CCNode")
	arg_3_0.lblCost = tolua.cast(arg_3_0.foodCostNode:getChildByTag(1002), "CCLabelTTF")

	var_3_3:removeFromParentAndCleanup(false)
	arg_3_0:addChild(var_3_3)
	arg_3_0:setAnchorPoint(ccp(0, 0))
	arg_3_0:setContentSize(CCSizeMake(120, 30))
	var_3_0()
end

function var_0_0.setlayerVisible(arg_6_0, arg_6_1)
	arg_6_0.layer:setVisible(arg_6_1)
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	if arg_7_1 then
		local var_7_0 = arg_7_0.data.pixelX
		local var_7_1 = WORLD_SCENE_HEIGHT - arg_7_0.data.pixelY

		arg_7_0:setPosition(var_7_0 - arg_7_0:getContentSize().width / 2, var_7_1 - arg_7_0:getContentSize().height / 2)

		local var_7_2 = arg_7_1.needTechLevel

		arg_7_0.lblLevelNeed:setVisible(true)
		arg_7_0.foodCostNode:setVisible(false)

		local var_7_3 = g_Self.kTechHandler:getStudyedTechLevel(3001)

		arg_7_0.btnTouch:setVisible(var_7_2 <= var_7_3)

		if var_7_3 < var_7_2 then
			arg_7_0.lblLevelNeed:setString(a2u("\xD7߽\xF8\xBF\xC6ѧ") .. var_7_2 .. a2u("\xBC\xB6\xBF\xAA\xC6\xF4"))
		else
			arg_7_0.lblLevelNeed:setVisible(false)
			arg_7_0.foodCostNode:setVisible(true)
			arg_7_0.lblCost:setString(arg_7_1.needFood)
		end
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.data then
		g_WsMsgHandler:WS_World_Unlock_Req(arg_8_0.data.id)
	end
end
