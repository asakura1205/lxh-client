local var_0_0 = class("zbGmActivityWnd_Notice")

var_0_0.__index = var_0_0

function createGmActivityWnd_Notice(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.noticeInfo = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.Notice) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.Notice) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.noticeInfo = iter_2_1

				break
			end
		end
	end
end

function var_0_0.refresh(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_notice.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.lbContent = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
	end)()

	if arg_4_0.noticeInfo == nil then
		return
	end

	arg_4_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_4_0.noticeInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.noticeInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_4_0.noticeInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_4_0.noticeInfo.ActEnd)))
	arg_4_0.lbDesc:setString(arg_4_0.noticeInfo.Title)
	arg_4_0.lbContent:setString(arg_4_0.noticeInfo.Content)
end
