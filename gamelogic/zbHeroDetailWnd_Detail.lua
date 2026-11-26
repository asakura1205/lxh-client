require("gamelogic.zbHeroDetailWnd_Detail_Sub")

zbHeroDetailWnd_Detail = class("zbHeroDetailWnd_Detail")
zbHeroDetailWnd_Detail.__index = zbHeroDetailWnd_Detail
AttributMaxLine = 30

function zbHeroDetailWnd_Detail.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.itemLayer = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.layerDetail = tolua.cast(arg_1_1:getChildByTag(10), "CCLayerColor")
		arg_1_0.itemLayer = zbHeroDetailWnd_Detail_Sub:create(arg_1_0.layerDetail)
	end

	var_1_0()
	var_1_1()
end

function zbHeroDetailWnd_Detail.refresh(arg_4_0, arg_4_1)
	arg_4_0.itemLayer:refresh(arg_4_1)
end

function zbHeroDetailWnd_Detail.free(arg_5_0)
	return
end

function createHeroDetailDetailPanel(arg_6_0)
	local var_6_0 = zbHeroDetailWnd_Detail.new()

	var_6_0:init(arg_6_0)

	return var_6_0
end
