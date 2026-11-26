require("gamelogic.zbMoneyPanel")

g_VisWinTable = {}

function insertVisWin(arg_1_0)
	if g_MainScene == nil or arg_1_0 == nil then
		return
	end

	if arg_1_0 == g_MainScene.wndMain or arg_1_0 == g_MainScene.wndTipEventComplete then
		return
	end

	for iter_1_0, iter_1_1 in pairs(g_VisWinTable) do
		if iter_1_1 == arg_1_0 then
			return
		end
	end

	table.insert(g_VisWinTable, arg_1_0)
end

function removeVisWin(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(g_VisWinTable) do
		if iter_2_1 == arg_2_0 then
			table.remove(g_VisWinTable, iter_2_0)

			break
		end
	end
end

function hasSecondWndVis()
	return table.getn(g_VisWinTable) > 0
end

EWinType = {
	Pop_Normal = 5,
	Pop_OnlyDark_NoHide = 6,
	Pop_OnlyDark = 4,
	Pop_HideAll = 1,
	Pop_Has_MoneyPanel_HeadPanel = 3,
	Pop_Has_MoneyPanel = 2
}
g_MainWinTable = {}

function insertMainSceneWin(arg_4_0)
	if g_GameStateMachine ~= nil and g_GameStateMachine:getCurrStateId() ~= GameState_Scene then
		return
	end

	for iter_4_0, iter_4_1 in pairs(g_MainWinTable) do
		if iter_4_1 == arg_4_0 then
			return
		end
	end

	table.insert(g_MainWinTable, arg_4_0)
end

function removeMainSceneWin(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(g_MainWinTable) do
		if iter_5_1 == arg_5_0 then
			table.remove(g_MainWinTable, iter_5_0)

			break
		end
	end
end
