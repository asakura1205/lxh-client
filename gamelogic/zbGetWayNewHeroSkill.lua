zbGetWayNewHeroSkill = class("zbGetWayNewHeroSkill", CCNodeExtend)
zbGetWayNewHeroSkill.__index = zbGetWayNewHeroSkill

local var_0_0 = 155
local var_0_1 = 260

function zbGetWayNewHeroSkill.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbGetWayNewHeroSkill)

	return arg_1_0
end

function zbGetWayNewHeroSkill.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbGetWayNewHeroSkill.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbGetWayNewHeroSkill.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_2
		arg_3_0.skillId = 0
	end

	local function var_3_1()
		arg_3_0.btnFrame = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(arg_3_1:getChildByTag(2), "CCSprite")

		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1005), "CCLabelTTF")
		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(8), "CCNode")

		var_5_0:setVisible(false)
		var_5_1:setVisible(false)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.spriteIcon:setMaskTexture(MASK_NOMRML_TEX)
		arg_3_0:setContentSize(arg_3_0.btnFrame:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbGetWayNewHeroSkill.refresh(arg_8_0, arg_8_1)
	arg_8_0.templateId = arg_8_1

	local var_8_0 = zbIconHelper:getSkillIconPath(arg_8_1)

	arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
end

function zbGetWayNewHeroSkill.onTouchDown(arg_9_0)
	local var_9_0 = zbHeroSkillTable:getRecord(arg_9_0.templateId)

	if var_9_0 ~= nil then
		g_MainScene:showSkillDescTips(0, var_9_0, 0, arg_9_0.index)
	end
end

function zbGetWayNewHeroSkill.onTouchEnd(arg_10_0)
	if g_MainScene.wndSkillDescTips ~= nil then
		g_MainScene.wndSkillDescTips:hide()
	end
end
