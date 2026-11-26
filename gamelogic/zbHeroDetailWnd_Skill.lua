require("gamelogic.zbHeroDetailWnd_SkillDesc")
require("gamelogic.zbHeroDetailWnd_SkillTips")

zbHeroDetailWnd_Skill = class("zbHeroDetailWnd_Skill", CCNodeExtend)
zbHeroDetailWnd_Skill.__index = zbHeroDetailWnd_Skill

function zbHeroDetailWnd_Skill.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Skill)

	return arg_1_0
end

function createHeroDetailSkillPanel(arg_2_0)
	local var_2_0 = zbHeroDetailWnd_Skill.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function zbHeroDetailWnd_Skill.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.skillList = {}
		arg_3_0.needPoint = 0
		arg_3_0.skillid = 0
		arg_3_0.showTips = false
		arg_3_0.skillMaxlv = 1
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_0
		arg_3_0.skill = {}

		for iter_5_0 = 1, 5 do
			local var_5_1 = zbTableViewHelper:create()

			var_5_1:loadCCBFile("ccbi/tb_skillDesc.ccbi")

			local var_5_2 = tolua.cast(var_5_0:getChildByTag(10 + iter_5_0), "CCNode")
			local var_5_3 = ccp(var_5_2:getPosition())
			local var_5_4 = zbHeroDetailWnd_SkillDesc:create(translateAndStrokeHelper(var_5_1:readCCBNode()), iter_5_0, arg_3_0)

			var_5_4:setPosition(var_5_3.x, var_5_3.y + 5)
			var_5_0:addChild(var_5_4)
			var_5_2:removeFromParentAndCleanup(true)
			table.insert(arg_3_0.skill, var_5_4)
			var_5_1:releaseSelf()
		end

		arg_3_0.lbHeroSkillPoint = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbAddSkillPoint = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCLabelTTF")
		arg_3_0.layerTips = createHeroDetailSkillTips(tolua.cast(var_5_0:getChildByTag(100), "CCNode"))

		arg_3_1:setZOrder(ZORDER_TOP)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_Skill.free(arg_6_0)
	return
end

function zbHeroDetailWnd_Skill.refresh(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 5 do
		arg_7_0.skill[iter_7_0]:refresh(arg_7_1)
	end

	local var_7_0 = zbItemTable:getRecord(2040201)
	local var_7_1 = g_Self.kBagItemHandler:getItemCountByTemplateId(2040201)

	arg_7_0.lbHeroSkillPoint:setString(arg_7_1.HeroSubInfo.SkillPoint)
	arg_7_0.lbAddSkillPoint:setString(var_7_0.virtual * var_7_1)
	arg_7_0.layerTips.layer:setVisible(false)
end
