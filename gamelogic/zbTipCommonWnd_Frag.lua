zbTipCommonWnd_Frag = class("zbTipCommonWnd_Frag")
zbTipCommonWnd_Frag.__index = zbTipCommonWnd_Frag

function zbTipCommonWnd_Frag.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		return
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.btnFrame = tolua.cast(arg_1_1:getChildByTag(2), "CCControlButton")
		arg_1_0.spriteIcon = tolua.cast(arg_1_1:getChildByTag(3), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.bmLevel = tolua.cast(arg_1_1:getChildByTag(4), "CCLabelTTF")
		arg_1_0.OwnerNum = tolua.cast(arg_1_1:getChildByTag(7), "CCLabelTTF")
		arg_1_0.NeedNum = tolua.cast(arg_1_1:getChildByTag(8), "CCLabelTTF")
		arg_1_0.lbDesc1 = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.lbMainAttribute = tolua.cast(arg_1_1:getChildByTag(5), "CCLabelTTF")
		arg_1_0.posNode = tolua.cast(arg_1_1:getChildByTag(10), "CCNode")
		arg_1_0.lbFate = tolua.cast(arg_1_0.posNode:getChildByTag(11), "CCLabelTTF")
		arg_1_0.lbFateName = tolua.cast(arg_1_0.posNode:getChildByTag(12), "CCLabelTTF")

		arg_1_0.bmLevel:setVisible(false)
		arg_1_0.lbFateName:setVisible(false)

		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height * arg_1_1:getScaleY() * arg_1_2:getScaleY()
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width * arg_1_1:getScaleX() * arg_1_2:getScaleX()
	end

	var_1_0()
	var_1_1()
end

function zbTipCommonWnd_Frag.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.layer:setVisible(true)
	zbAwardHelper:refreshAwardItem(arg_4_1, arg_4_2, 1, arg_4_0.btnFrame, arg_4_0.spriteIcon, lbName)

	local var_4_0

	if arg_4_1 == ECommonAwardType.HeroFrag then
		var_4_0 = zbHeroTable:getRecord(arg_4_2)
	else
		var_4_0 = zbItemTable:getRecord(arg_4_2)
	end

	if var_4_0 == nil then
		return
	end

	arg_4_0.posNode:setVisible(false)
	arg_4_0.lbMainAttribute:setVisible(false)
	arg_4_0.lbName:setString(var_4_0.name)

	if arg_4_1 == ECommonAwardType.HeroFrag then
		local var_4_1 = g_Self.kHeroFragHandler:getHeroFragCount(arg_4_2)

		arg_4_0.OwnerNum:setString(a2u(var_4_1))

		local var_4_2 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_4_2)

		if var_4_2 ~= nil then
			if g_Self.kHeroHandler:getHeroByTemplateId(arg_4_2) ~= nil then
				arg_4_0.lbDesc1:setString(a2u("\xBE\xDB\xC6\xEB") .. var_4_2.needFrag .. a2u("\xB8\xF6\xCB\xE9Ƭ\xBF\xC9\xD2\xD4\xC9\xFD\xD0ǻ\xEF\xB0\xE9") .. var_4_0.name)
			else
				arg_4_0.lbDesc1:setString(a2u("\xBE\xDB\xC6\xEB") .. var_4_2.needFrag .. a2u("\xB8\xF6\xCB\xE9Ƭ\xBF\xC9\xD2Ժϳɻ\xEF\xB0\xE9") .. var_4_0.name)
			end
		end
	else
		local var_4_3 = g_Self.kEquipFragHandler:getEquipFragCount(arg_4_2)

		arg_4_0.OwnerNum:setString(a2u(var_4_3))
		arg_4_0.posNode:setVisible(false)

		local var_4_4, var_4_5 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_4_2)

		arg_4_0.lbDesc1:setString(a2u("\xBE\xDB\xC6\xEB") .. var_4_4 .. a2u("\xB8\xF6\xCB\xE9Ƭ\xBF\xC9\xD2Ժϳ\xC9װ\xB1\xB8") .. var_4_0.name)

		local var_4_6 = ""

		for iter_4_0, iter_4_1 in pairs(var_4_0.mainAttrList) do
			local var_4_7 = a2u(getItemPropStr(iter_4_1.AttrType))

			if iter_4_1.AttrAdditionType == EAttrAdditionType.Fixed then
				var_4_6 = var_4_6 .. " " .. var_4_7 .. ":" .. iter_4_1.AttrValue
			else
				var_4_6 = var_4_6 .. " " .. var_4_7 .. ":" .. iter_4_1.AttrValue * 100 .. "%"
			end
		end

		arg_4_0.lbMainAttribute:setString(var_4_6)
	end
end

function createTipCommonWndFrag(arg_5_0, arg_5_1)
	local var_5_0 = zbTipCommonWnd_Frag.new()

	var_5_0:init(arg_5_0, arg_5_1)

	return var_5_0
end
