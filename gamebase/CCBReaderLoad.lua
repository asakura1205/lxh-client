require("gamemain.zbGlobalVar")
require("gamebase.zbUI")

ccb = ccb or {}
g_bSetLabelStrok = true

local function var_0_0(arg_1_0)
	if g_bSetLabelStrok == false then
		return
	end

	if arg_1_0 == nil or arg_1_0:isLabelTTF() == false then
		return
	end

	local var_1_0 = tolua.cast(arg_1_0, "CCLabelTTF")

	if var_1_0:getString() ~= nil and var_1_0:getString() ~= "" and var_1_0:getTag() < 1000 then
		local var_1_1 = var_1_0:getColor()

		if var_1_1.r <= 10 and var_1_1.g <= 10 and var_1_1.b <= 10 then
			-- block empty
		else
			ui:setTTFStroke(var_1_0)
		end
	end
end

local function var_0_1(arg_2_0)
	if g_bSetLabelStrok == false then
		return
	end

	if arg_2_0 == nil or arg_2_0:isButton() == false then
		return
	end

	local var_2_0 = tolua.cast(arg_2_0, "CCControlButton")
	local var_2_1 = var_2_0:getTitleLabelForState(CCControlStateNormal)

	if var_2_1 ~= nil and var_2_1:isLabelTTF() then
		local var_2_2 = tolua.cast(var_2_1, "CCLabelTTF")

		if var_2_2 ~= nil and var_2_2:getString() ~= nil and var_2_2:getString() ~= "" then
			local var_2_3 = var_2_2:getFontSize()
			local var_2_4 = var_2_0:getTitleColorForState(CCControlStateNormal)

			if var_2_4.r <= 10 and var_2_4.g <= 10 and var_2_4.b <= 10 then
				-- block empty
			else
				local var_2_5 = ccc3(255, 255, 255)

				var_2_5.r = var_2_4.r
				var_2_5.g = var_2_4.g
				var_2_5.b = var_2_4.b

				ui:setButtonStroke(var_2_0, nil, var_2_3, var_2_5)
			end
		end
	end
end

function translateAndStroke(arg_3_0)
	if g_bSetLabelStrok == false then
		return
	end

	var_0_0(arg_3_0)
	var_0_1(arg_3_0)

	local var_3_0 = arg_3_0:getChildren()
	local var_3_1 = arg_3_0:getChildrenCount()

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = tolua.cast(var_3_0:objectAtIndex(iter_3_0 - 1), "CCNode")

		if var_3_2 ~= nil then
			translateAndStroke(var_3_2)
		end
	end
end

function translateAndStrokeHelper(arg_4_0)
	if g_bSetLabelStrok then
		translateAndStroke(arg_4_0)
	end

	return arg_4_0
end

function CCBReaderLoad(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_1 == nil then
		return
	end

	local var_5_0 = arg_5_1:createCCBReader()
	local var_5_1 = arg_5_1:readCCBFromFile(arg_5_0, var_5_0, arg_5_2)
	local var_5_2 = var_5_0:getOwner()
	local var_5_3 = ""

	if var_5_1 == nil then
		echo("11111111111111111111111111: " .. arg_5_0)
	end

	if var_5_2 ~= nil then
		local var_5_4 = tolua.cast(var_5_0:getOwnerCallbackNames(), "CCArray")
		local var_5_5 = tolua.cast(var_5_0:getOwnerCallbackNodes(), "CCArray")
		local var_5_6 = 1

		for iter_5_0 = 1, var_5_4:count() do
			local var_5_7 = tolua.cast(var_5_4:objectAtIndex(iter_5_0 - 1), "CCString")
			local var_5_8 = tolua.cast(var_5_5:objectAtIndex(iter_5_0 - 1), "CCNode")

			if arg_5_3 ~= "" and ccb[arg_5_3] ~= nil then
				local var_5_9 = var_5_7:getCString()

				if type(ccb[arg_5_3][var_5_9]) == "function" then
					arg_5_1:setCallback(var_5_8, ccb[arg_5_3][var_5_9])
				else
					print("WARNING: Cannot found lua function [" .. arg_5_3 .. "." .. var_5_9 .. "] for owner selector")
				end
			end
		end

		local var_5_10 = tolua.cast(var_5_0:getOwnerOutletNames(), "CCArray")
		local var_5_11 = tolua.cast(var_5_0:getOwnerOutletNodes(), "CCArray")

		for iter_5_1 = 1, var_5_10:count() do
			local var_5_12 = tolua.cast(var_5_10:objectAtIndex(iter_5_1 - 1), "CCString")
			local var_5_13 = tolua.cast(var_5_11:objectAtIndex(iter_5_1 - 1), "CCNode")

			if arg_5_3 ~= "" and ccb[arg_5_3] ~= nil then
				ccb[arg_5_3][var_5_12:getCString()] = tolua.cast(var_5_13, arg_5_1:getNodeTypeName(var_5_13))
			end
		end
	end

	local var_5_14 = tolua.cast(var_5_0:getNodesWithAnimationManagers(), "CCArray")
	local var_5_15 = tolua.cast(var_5_0:getAnimationManagersForNodes(), "CCArray")

	for iter_5_2 = 1, var_5_14:count() do
		local var_5_16 = tolua.cast(var_5_14:objectAtIndex(iter_5_2 - 1), "CCNode")
		local var_5_17 = tolua.cast(var_5_15:objectAtIndex(iter_5_2 - 1), "CCBAnimationManager")
		local var_5_18 = var_5_17:getDocumentControllerName()

		if var_5_18 == "" then
			-- block empty
		end

		if ccb[var_5_18] ~= nil then
			ccb[var_5_18].mAnimationManager = var_5_17
		end

		local var_5_19 = tolua.cast(var_5_17:getDocumentCallbackNames(), "CCArray")
		local var_5_20 = tolua.cast(var_5_17:getDocumentCallbackNodes(), "CCArray")

		for iter_5_3 = 1, var_5_19:count() do
			local var_5_21 = tolua.cast(var_5_19:objectAtIndex(iter_5_3 - 1), "CCString")
			local var_5_22 = tolua.cast(var_5_20:objectAtIndex(iter_5_3 - 1), "CCNode")

			if var_5_18 ~= "" and ccb[var_5_18] ~= nil then
				local var_5_23 = var_5_21:getCString()

				if type(ccb[var_5_18][var_5_23]) == "function" then
					arg_5_1:setCallback(var_5_22, ccb[var_5_18][var_5_23])
				else
					print("WARNING: Cannot found lua function [" .. var_5_18 .. "." .. var_5_23 .. "] for docRoot selector")
				end
			end
		end

		local var_5_24 = tolua.cast(var_5_17:getDocumentOutletNames(), "CCArray")
		local var_5_25 = tolua.cast(var_5_17:getDocumentOutletNodes(), "CCArray")

		for iter_5_4 = 1, var_5_24:count() do
			local var_5_26 = tolua.cast(var_5_24:objectAtIndex(iter_5_4 - 1), "CCString")
			local var_5_27 = tolua.cast(var_5_25:objectAtIndex(iter_5_4 - 1), "CCNode")

			if ccb[var_5_18] ~= nil then
				ccb[var_5_18][var_5_26:getCString()] = tolua.cast(var_5_27, arg_5_1:getNodeTypeName(var_5_27))
			end
		end

		local var_5_28 = var_5_17:getKeyframeCallbacks()

		for iter_5_5 = 1, var_5_28:count() do
			local var_5_29 = tolua.cast(var_5_28:objectAtIndex(iter_5_5 - 1), "CCString"):getCString()
			local var_5_30, var_5_31 = string.find(var_5_29, ":")
			local var_5_32 = tonumber(string.sub(var_5_29, 1, var_5_30 - 1))
			local var_5_33 = string.sub(var_5_29, var_5_31 + 1, -1)

			if var_5_32 == 1 and ccb[var_5_18] ~= nil then
				local var_5_34 = CCCallFunc:create(ccb[var_5_18][var_5_33])

				var_5_17:setCallFuncForLuaCallbackNamed(var_5_34, var_5_29)
			elseif var_5_32 == 2 and var_5_2 ~= nil then
				local var_5_35 = CCCallFunc:create(ccb[arg_5_3][var_5_33])

				var_5_17:setCallFuncForLuaCallbackNamed(var_5_35, var_5_29)
			end
		end

		local var_5_36 = var_5_17:getAutoPlaySequenceId()

		if var_5_36 ~= -1 then
			var_5_17:runAnimationsForSequenceIdTweenDuration(var_5_36, 0)
		end
	end

	if arg_5_4 ~= nil and arg_5_4 == true then
		translateAndStroke(var_5_1)

		return var_5_1, var_5_0
	end

	local var_5_37 = CCEGLView:sharedOpenGLView():getFrameSize()
	local var_5_38 = var_5_1:getContentSize()
	local var_5_39 = var_5_37.width / var_5_38.width
	local var_5_40 = var_5_37.height / var_5_38.height

	echoInfo("scaleX: " .. var_5_39)
	echoInfo("scaleY: " .. var_5_40)

	if g_Layout:isWHRatio4_3() then
		var_5_40 = var_5_39
	end

	if arg_5_5 == nil or arg_5_5 ~= true then
		local var_5_41 = (var_5_37.width - var_5_38.width * var_5_39) / 2
		local var_5_42 = (var_5_37.height - var_5_38.height * var_5_40) / 2

		echoInfo("contentSize.width * scaleX: " .. var_5_38.width * var_5_39)
		echoInfo("contentSize.height * scaleY: " .. var_5_38.height * var_5_40)
		echoInfo("offsetX: " .. var_5_41)
		echoInfo("offsetY: " .. var_5_42)
		var_5_1:setPosition(var_5_41, var_5_42)
	end

	var_5_1:setScaleX(var_5_39)
	var_5_1:setScaleY(var_5_40)

	if g_Layout:isWHRatio4_3() == false then
		local var_5_43 = var_5_1:getChildren()

		if var_5_43 ~= nil then
			for iter_5_6 = 1, var_5_43:count() do
				local var_5_44 = tolua.cast(var_5_43:objectAtIndex(iter_5_6 - 1), "CCNode")

				var_5_44:setScaleX(var_5_40 / var_5_39 * var_5_44:getScaleX())
			end
		end
	end

	translateAndStroke(var_5_1)

	return var_5_1, var_5_0
end
