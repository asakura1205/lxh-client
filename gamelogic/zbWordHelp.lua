require("gamelogic.zbWorldDefine")
require("gamelogic.zbMapNodeRes")
require("gamelogic.zbMapNodeMainCity")
require("gamelogic.zbMapNodeBoss")
require("gamelogic.zbMapNodeTask")
require("gamelogic.zbMapNodeGodDomain")
require("gamelogic.zbMapNodeRand")

zbWordHelp = {}

local var_0_0 = {
	[ECommonAwardType.Gold] = "world_pop1.png",
	[EMaterialType.HeroExpPill] = "world_pop3.png",
	[EMaterialType.GodLevel] = "world_pop2.png"
}
local var_0_1 = {
	[EWorldSpecialNode.BgzClue] = "world_noen_tuanshu.png",
	[EWorldSpecialNode.Shop] = "world_none_shop.png"
}
local var_0_2 = {
	13,
	19,
	20,
	21,
	22,
	23,
	24,
	18,
	12,
	6
}
local var_0_3 = {}

function zbWordHelp.loadWolrCommonSprite(arg_1_0)
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("ui/image/plist/worldcommon.plist")
end

function zbWordHelp.setRandNodeTexture(arg_2_0, arg_2_1, arg_2_2)
	if var_0_1[arg_2_2] then
		local var_2_0 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_0_1[arg_2_2])

		if var_2_0 then
			arg_2_1:initWithSpriteFrame(var_2_0)
		end
	end
end

function zbWordHelp.setResIconByResType(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.resOut

	if zbUtil:isValidTable(var_3_0) then
		local var_3_1 = var_3_0[1]

		if var_3_1 == ECommonAwardType.Gold then
			local var_3_2 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_0_0[var_3_1])

			if var_3_2 then
				arg_3_1:initWithSpriteFrame(var_3_2)
			end
		elseif var_3_1 == ECommonAwardType.Item then
			local var_3_3 = var_3_0[2]
			local var_3_4 = zbItemTable:getRecord(var_3_3)

			if var_3_4 and var_3_4.type == EItemType.Material then
				local var_3_5 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_0_0[var_3_4.subType])

				if var_3_5 then
					arg_3_1:initWithSpriteFrame(var_3_5)
				end
			end
		end
	end
end

function zbWordHelp.loadMap(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = "ui/image/world/map/"
	local var_4_1 = WORLD_SCENE_HEIGHT

	local function var_4_2(arg_5_0)
		for iter_5_0, iter_5_1 in pairs(var_0_2) do
			if iter_5_1 == arg_5_0 then
				return true
			end
		end

		return false
	end

	local var_4_3 = 1

	for iter_4_0 = 1, 4 do
		local var_4_4 = 512

		if iter_4_0 == 4 then
			var_4_4 = 164
		end

		var_4_1 = var_4_1 - var_4_4

		for iter_4_1 = 1, 6 do
			if not var_4_2(var_4_3) then
				icon = var_4_0 .. var_4_3 .. ".jpg"

				local var_4_5 = CCSprite:create(icon)

				var_4_5:setAnchorPoint(ccp(0, 0))

				local var_4_6 = (iter_4_1 - 1) * 512

				var_4_5:setPosition(var_4_6, var_4_1)
				arg_4_1:addChild(var_4_5, ZORDER_BOTTOM)
				table.insert(arg_4_2, var_4_5)
			else
				local var_4_7 = {}
				local var_4_8 = (iter_4_1 - 1) * 512

				var_4_7.index = var_4_3
				var_4_7.pos = ccp(var_4_8, var_4_1)

				table.insert(var_0_3, var_4_7)
			end

			var_4_3 = var_4_3 + 1
		end
	end
end

function zbWordHelp.loadSecondMap(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = "ui/image/world/map/"

	for iter_6_0, iter_6_1 in pairs(var_0_3) do
		icon = var_6_0 .. iter_6_1.index .. ".jpg"

		local var_6_1 = CCSprite:create(icon)

		var_6_1:setAnchorPoint(ccp(0, 0))
		var_6_1:setPosition(iter_6_1.pos)
		arg_6_1:addChild(var_6_1, ZORDER_BOTTOM)
		table.insert(arg_6_2, var_6_1)
	end
end

function zbWordHelp.createMapNode(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3[arg_7_1]

	if var_7_0 == nil then
		local var_7_1 = zbWorldNodeTable:getRecord(arg_7_1)

		if var_7_1 then
			local var_7_2 = var_7_1.nodeType

			if var_7_2 == EWorldNodeType.ResNode then
				var_7_0 = createMapNodeRes(var_7_1)
			elseif var_7_2 == EWorldNodeType.MainCity then
				var_7_0 = createMapNodeMainCity(var_7_1)
			elseif var_7_2 == EWorldNodeType.WorldBoss then
				var_7_0 = createMapNodeBoss(var_7_1)
			elseif var_7_2 == EWorldNodeType.GodDomain then
				var_7_0 = createMapNodeGodDomain(var_7_1)
			elseif var_7_2 == EWorldNodeType.TaskNode then
				var_7_0 = createMapNodeTask(var_7_1)
			elseif var_7_2 == EWorldNodeType.NullNode then
				var_7_0 = createMapNodeRand(var_7_1)
			end

			if var_7_0 then
				arg_7_2:addChild(var_7_0)

				arg_7_3[arg_7_1] = var_7_0
			end
		end
	end

	return var_7_0
end
