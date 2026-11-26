require("gamelogic.zbPataWnd_BuffItem")

zbPataWnd_Buff = class("zbPataWnd_Buff")
zbPataWnd_Buff.__index = zbPataWnd_Buff

function createPataWnd_Buff(arg_1_0, arg_1_1)
	local var_1_0 = zbPataWnd_Buff.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function zbPataWnd_Buff.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parent = arg_2_2
		arg_2_0.layer = arg_2_1
		arg_2_0.buffItems = {}
		arg_2_0.itemPoint = {}
	end

	local function var_2_1()
		arg_2_0.lbFightDesc = tolua.cast(arg_2_1:getChildByTag(4), "CCLabelTTF")

		for iter_4_0 = 1, 3 do
			local var_4_0 = zbTableViewHelper:create()

			var_4_0:loadCCBFile("ccbi/tb_patabuff.ccbi")

			local var_4_1 = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCLayerColor")
			local var_4_2 = zbPataWnd_BuffItem:create(translateAndStrokeHelper(var_4_0:readCCBNode()))

			var_4_2:setPosition(var_4_1:getPosition())
			arg_2_1:addChild(var_4_2)

			arg_2_0.buffItems[iter_4_0] = var_4_2
			arg_2_0.itemPoint[iter_4_0] = ccp(var_4_1:getPosition())

			var_4_1:removeFromParentAndCleanup(true)
			var_4_0:releaseSelf()
		end
	end

	var_2_0()
	var_2_1()
end

function zbPataWnd_Buff.refresh(arg_5_0, arg_5_1)
	arg_5_0.layer:setVisible(true)

	arg_5_0.PataInfo = arg_5_1

	for iter_5_0 = 1, 3 do
		arg_5_0.buffItems[iter_5_0]:setVisible(false)

		if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
			arg_5_0.buffItems[iter_5_0]:setPosition(arg_5_0.itemPoint[iter_5_0])
		else
			arg_5_0.buffItems[iter_5_0]:setPosition(arg_5_0.itemPoint[4 - iter_5_0].x, arg_5_0.itemPoint[iter_5_0].y)
		end
	end

	for iter_5_1, iter_5_2 in pairs(arg_5_0.PataInfo.BuffLayerInfo.BuffBuyList) do
		arg_5_0.buffItems[iter_5_2.SkillIndex]:refresh(iter_5_2)
	end

	arg_5_0:playEffect()
end

function zbPataWnd_Buff.playEffect(arg_6_0)
	local var_6_0 = 0

	local function var_6_1(arg_7_0, arg_7_1)
		local function var_7_0(arg_8_0)
			arg_8_0:setVisible(true)
		end

		local var_7_1 = CCArray:create()

		var_7_1:addObject(CCDelayTime:create(var_6_0))
		var_7_1:addObject(CCCallFuncN:create(var_7_0))
		arg_7_0:setVisible(false)
		arg_7_0:stopAllActions()
		arg_7_0:runAction(CCSequence:create(var_7_1))

		var_6_0 = var_6_0 + arg_7_1
	end

	var_6_1(arg_6_0.buffItems[1], 0.25)
	var_6_1(arg_6_0.buffItems[2], 0.25)
	var_6_1(arg_6_0.buffItems[3], 0.25)
end
