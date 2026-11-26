require("gamelogic.zbItem")

local var_0_0 = class("zbHeroSkillItem", CCNodeExtend)

var_0_0.__index = var_0_0

local var_0_1 = 120

function createHeroSkillItem(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.create(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function var_0_0.extend(arg_3_0)
	local var_3_0 = tolua.getpeer(arg_3_0)

	if not var_3_0 then
		var_3_0 = {}

		tolua.setpeer(arg_3_0, var_3_0)
	end

	setmetatable(var_3_0, var_0_0)

	return arg_3_0
end

function var_0_0.init(arg_4_0, arg_4_1)
	local function var_4_0()
		arg_4_0.heroSkillItems = nil
	end

	local function var_4_1()
		local var_6_0 = tolua.cast(arg_4_1:getChildByTag(1), "CCNode")

		arg_4_0.skillFrame = tolua.cast(var_6_0:getChildByTag(4), "CCSprite")
		arg_4_0.skillIcon = tolua.cast(arg_4_0.skillFrame:getChildByTag(1), "CCSprite")
		arg_4_0.skillName = tolua.cast(var_6_0:getChildByTag(1), "CCLabelTTF")
		arg_4_0.skillDes = tolua.cast(var_6_0:getChildByTag(2), "CCLabelTTF")
		arg_4_0.skillOpen = tolua.cast(var_6_0:getChildByTag(3), "CCLabelTTF")

		local var_6_1 = tolua.cast(var_6_0:getChildByTag(4), "CCLayerColor")
		local var_6_2 = createItem()

		var_6_2:setPosition(var_6_1:getPosition())
		var_6_2:setScale(0.8)
		var_6_0:addChild(var_6_2)

		arg_4_0.heroSkillItems = var_6_2

		var_6_1:removeFromParentAndCleanup(true)
		arg_4_0:addChild(arg_4_1)
		arg_4_0:setContentSize(CCSizeMake(arg_4_1:getContentSize().width, var_0_1))
	end

	var_4_0()
	var_4_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = zbHeroTable:getSkillId(arg_7_1, arg_7_2)
	local var_7_1 = zbHeroSkillTable:getRecord(var_7_0)
	local var_7_2 = arg_7_0.heroSkillItems

	if var_7_2 ~= nil then
		var_7_2:refreshSkill(var_7_0)
		var_7_2:setVisible(true)
	end

	arg_7_0.skillName:setString(var_7_1.name)
	arg_7_0.skillDes:setString(var_7_1.desc)
	arg_7_0.skillOpen:setString("(" .. var_7_1.unlockLevel .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8)"))
end

function var_0_0.onDiamond(arg_8_0)
	print(a2u("\xBB\xA8\xB7\xD1"))
end
