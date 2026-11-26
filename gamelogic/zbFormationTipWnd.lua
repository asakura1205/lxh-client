local var_0_0 = class("zbFormationTipWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createFormationTipWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/formation_tip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.spriteIcon = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.spriteFormationIcon = tolua.cast(arg_3_0.spriteIcon:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbLevel = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbDesc1 = tolua.cast(var_5_2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.lbDesc2 = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")

		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		arg_6_0:hide()

		return
	end

	local var_6_0 = string.format("image/icon/formation/small_formation_%d.png", arg_6_1.id)

	arg_6_0.spriteFormationIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_6_0))

	local var_6_1 = g_Self.kTechHandler:getStudyedTech(arg_6_1.id)

	if var_6_1 ~= nil then
		arg_6_0.lbName:setString(arg_6_1.name)
		arg_6_0.lbLevel:setString(a2u("LV.") .. var_6_1.Level)
	end

	if arg_6_1.attrType1 ~= 0 then
		local var_6_2 = var_6_1.Level * arg_6_1.attrGrowth1 + arg_6_1.attrBase1
		local var_6_3 = getItemPropStr(arg_6_1.attrType1)
		local var_6_4 = "ȫԱ" .. var_6_3 .. "+" .. var_6_2

		arg_6_0.lbDesc1:setString(a2u(var_6_4))
	end

	if arg_6_1.attrType2 ~= 0 then
		arg_6_0.lbDesc2:setVisible(true)

		local var_6_5 = var_6_1.Level * arg_6_1.attrGrowth2 + arg_6_1.attrBase2
		local var_6_6 = getItemPropStr(arg_6_1.attrType2)
		local var_6_7 = "ȫԱ" .. var_6_6 .. "+" .. var_6_5

		arg_6_0.lbDesc2:setString(a2u(var_6_7))
	else
		arg_6_0.lbDesc2:setVisible(false)
	end
end
