zbHeroDetailWnd_Detail_Sub = class("zbHeroDetailWnd_Detail_Sub", CCNodeExtend)
zbHeroDetailWnd_Detail_Sub.__index = zbHeroDetailWnd_Detail_Sub

local var_0_0 = {}
local var_0_1 = 10
local var_0_2 = 2

var_0_0[var_0_2] = EAttrType.PhysicDefend

local var_0_3 = var_0_2 + 1

var_0_0[var_0_3] = EAttrType.Violent

local var_0_4 = var_0_3 + 1

var_0_0[var_0_4] = EAttrType.Hit

local var_0_5 = var_0_4 + 1

var_0_0[var_0_5] = EAttrType.PierceDamage

local var_0_6 = var_0_5 + 1

var_0_0[var_0_6] = EAttrType.HP

local var_0_7 = var_0_6 + 1

var_0_0[var_0_7] = EAttrType.MagicDefend

local var_0_8 = var_0_7 + 1

var_0_0[var_0_8] = EAttrType.Tough

local var_0_9 = var_0_8 + 1

var_0_0[var_0_9] = EAttrType.Dodge

local var_0_10 = var_0_9 + 1

var_0_0[var_0_10] = EAttrType.Block

local var_0_11 = var_0_10 + 1
local var_0_12 = 225
local var_0_13 = 30

function zbHeroDetailWnd_Detail_Sub.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Detail_Sub)

	return arg_1_0
end

function zbHeroDetailWnd_Detail_Sub.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroDetailWnd_Detail_Sub.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroDetailWnd_Detail_Sub.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.lines = {}
		arg_3_0.skillNode = {}
		arg_3_0.baseAttr = {}
	end

	local function var_3_1()
		arg_3_0.layer = arg_3_1
		arg_3_0.itemPanel = arg_3_1

		local var_5_0 = tolua.cast(arg_3_0.itemPanel:getChildByTag(5), "CCNode")

		arg_3_0.layerBaseDetail = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		local var_5_1 = tolua.cast(arg_3_0.layerBaseDetail:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.baseAttr[EAttrType.Force] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.baseAttr[EAttrType.Force])
		arg_3_0.baseAttr[EAttrType.Force]:setScale(0.65)

		local var_5_2 = tolua.cast(arg_3_0.layerBaseDetail:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.baseAttr[EAttrType.Intelligence] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.baseAttr[EAttrType.Intelligence])
		arg_3_0.baseAttr[EAttrType.Intelligence]:setScale(0.65)

		local var_5_3 = tolua.cast(arg_3_0.layerBaseDetail:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.baseAttr[EAttrType.Tili] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.baseAttr[EAttrType.Tili])
		arg_3_0.baseAttr[EAttrType.Tili]:setScale(0.65)

		arg_3_0.layerGrowDetail = tolua.cast(var_5_0:getChildByTag(2), "CCNode")

		local var_5_4 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.ForceGrowth = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.ForceGrowth)
		arg_3_0.ForceGrowth:setScale(0.65)

		local var_5_5 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.IntelligenceGrowth = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.IntelligenceGrowth)
		arg_3_0.IntelligenceGrowth:setScale(0.65)

		local var_5_6 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.TiliGrowth = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.TiliGrowth)
		arg_3_0.TiliGrowth:setScale(0.65)

		arg_3_0.heroDesc1 = tolua.cast(arg_3_0.itemPanel:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.heroDesc2 = tolua.cast(arg_3_0.itemPanel:getChildByTag(2), "CCLabelTTF")
		arg_3_0.layerPosition = tolua.cast(arg_3_0.itemPanel:getChildByTag(3), "CCNode")
		arg_3_0.lbPosition = tolua.cast(arg_3_0.layerPosition:getChildByTag(2), "CCLabelTTF")
		arg_3_0.layerDetail = tolua.cast(arg_3_0.itemPanel:getChildByTag(6), "CCNode")
		arg_3_0.attackname = tolua.cast(arg_3_0.layerDetail:getChildByTag(100), "CCLabelTTF")

		for iter_5_0 = 1, var_0_1 do
			arg_3_0.items[iter_5_0] = tolua.cast(arg_3_0.layerDetail:getChildByTag(iter_5_0), "CCLabelTTF")
		end

		arg_3_0.btnSkillDes = tolua.cast(arg_3_0.itemPanel:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSkillDes:addHandleOfControlEvent(function()
			arg_3_0:onSkillDes()
		end, CCControlEventTouchUpInside)
		arg_3_0.layerDetail:setVisible(true)
		arg_3_0:setContentSize(CCSizeMake(520, 480))
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_Detail_Sub.refresh(arg_7_0, arg_7_1)
	arg_7_0.hero = arg_7_1

	if arg_7_0.hero == nil then
		return
	end

	local var_7_0 = zbHeroTable:getRecord(arg_7_0.hero.HeroBaseInfo.TemplateId)

	if var_7_0 == nil then
		echoInfo("error hero template id: " .. arg_7_0.hero.HeroBaseInfo.TemplateId)

		return
	end

	arg_7_0.heroDesc1:setString(var_7_0.description)
	arg_7_0.heroDesc2:setString(var_7_0.description2)
	arg_7_0.heroDesc2:setColor(FONT_COLOR_WHITE)
	arg_7_0.lbPosition:setString(var_7_0.description0)

	local var_7_1 = 2
	local var_7_2 = zbHeroHelper:getHeroAttributeTable(arg_7_1)

	if var_7_0.attackType == EAttackType.Magic then
		arg_7_0.attackname:setString(a2u("\xB7\xA8\xB9\xA5"))
		arg_7_0.items[1]:setString(var_7_2[EAttrType.MagicAttack])
	end

	if var_7_0.attackType == EAttackType.Physic then
		arg_7_0.attackname:setString(a2u("\xCE﹥"))
		arg_7_0.items[1]:setString(var_7_2[EAttrType.PhysicAttack])
	end

	arg_7_0.items[1]:setColor(FONT_COLOR_WHITE)

	for iter_7_0 = 2, var_0_1 do
		arg_7_0.items[iter_7_0]:setString(var_7_2[var_0_0[iter_7_0]])
		arg_7_0.items[iter_7_0]:setColor(FONT_COLOR_WHITE)
	end

	for iter_7_1 = EAttrType.Force, EAttrType.Tili do
		local var_7_3 = 0

		for iter_7_2, iter_7_3 in pairs(arg_7_1.WashInfo.MAttr) do
			if iter_7_3[1] == iter_7_1 then
				var_7_3 = var_7_3 + iter_7_3[3]
			end
		end

		for iter_7_4, iter_7_5 in pairs(arg_7_1.PartnerInfo.PartnerAttr) do
			if iter_7_5[1] == iter_7_1 then
				var_7_3 = var_7_3 + iter_7_5[3]
			end
		end

		if var_7_3 > 0 then
			arg_7_0.baseAttr[iter_7_1]:setString(var_7_2[iter_7_1] - math.round(var_7_3) .. " +" .. math.round(var_7_3))
		else
			arg_7_0.baseAttr[iter_7_1]:setString(var_7_2[iter_7_1] - math.round(var_7_3))
		end
	end

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_7_1.HeroBaseInfo.TemplateId, arg_7_1.HeroBaseInfo.Level, arg_7_1.HeroBaseInfo.Star, arg_7_1.HeroBaseInfo.Quality)

	arg_7_0.ForceGrowth:setString(tonumber(string.format("%.1f", force)))
	arg_7_0.IntelligenceGrowth:setString(tonumber(string.format("%.1f", intelligence)))
	arg_7_0.TiliGrowth:setString(tonumber(string.format("%.1f", tili)))
end

function zbHeroDetailWnd_Detail_Sub.onSkillDes(arg_8_0)
	g_MainScene:showAttrExplainWnd()
end
