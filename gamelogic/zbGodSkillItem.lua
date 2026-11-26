local var_0_0 = class("zbGodSkillItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createGodSkillItem(arg_1_0)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0)

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

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = var_5_0
		arg_3_0.skillbg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.skillname = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.skilltype = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.skilldesc = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.skillLvbg = tolua.cast(var_5_0:getChildByTag(6), "CCSprite")
		arg_3_0.skillLv = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.skillLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.skillLv, arg_3_0.skillLvRep)
		arg_3_0.skillLvRep:setScale(0.55)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		local var_6_0 = zbGodSkillTable:getRecord(arg_6_1)

		if var_6_0 then
			arg_6_0.skillname:setString(a2u(var_6_0.name))

			if arg_6_2 == 1 then
				arg_6_0.skillbg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/godequip/skillbg1.png"))
				arg_6_0.skilltype:setString(a2u("\xD6\xF7\xB6\xAF\xBC\xBC\xC4\xDC"))
			else
				arg_6_0.skillbg:setTexture(CCTextureCache:sharedTextureCache():addImage("image/godequip/skillbg2.png"))
				arg_6_0.skilltype:setString(a2u("\xB1\xBB\xB6\xAF\xBC\xBC\xC4\xDC"))
			end
		end

		local var_6_1 = g_Self.kGodHandler:getSkillLevel(arg_6_1)

		arg_6_0.skillLvRep:setString(var_6_1)
		arg_6_0.layerContent:setGray(var_6_1 == 0)
		arg_6_0.skillLvbg:setVisible(var_6_1 ~= 0)
		arg_6_0.skillLvRep:setVisible(var_6_1 ~= 0)

		local var_6_2 = g_Self.kGodHandler:getGodSkillDesc(arg_6_1, var_6_1)

		arg_6_0.skilldesc:setString(a2u(var_6_2))
	end
end
