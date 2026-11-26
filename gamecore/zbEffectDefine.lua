MISSILE_SPEED = 1200
EPathType = {
	Bezier = 2,
	Line = 1
}
BONES_SEQUENCE_CLOSE = "00"
BONES_SEQUENCE_MONEYPANEL = "01"
BONES_SEQUENCE_TAB = "02"
BONES_SEQUENCE_TITLE = "03"
BONES_SEQUENCE_YUN = "04"
BONES_SEQUENCE_SUBTITLE = "05"
BONES_SEQUENCE_SMBG = "06"
BONES_SEQUENCE_ZUODW = "11"
BONES_SEQUENCE_ZUOUP = "12"
BONES_SEQUENCE_YOU = "00"
BONES_SEQUENCE_BIGBG = "13"

function findBonePosition(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = ccp(0, 60)
	local var_1_1 = false

	if arg_1_2 ~= nil then
		local var_1_2 = arg_1_2:findBone(arg_1_3)

		if var_1_2 ~= nil then
			var_1_0.x = spBone_getWorldX(var_1_2)
			var_1_0.y = spBone_getWorldY(var_1_2)
			var_1_1 = true

			if arg_1_4 ~= nil and arg_1_4 == ForceType.Left then
				var_1_0.x = -spBone_getWorldX(var_1_2)
			end
		end
	end

	if var_1_1 == false then
		echo("warning: can not find hero bone: " .. arg_1_1 .. "," .. arg_1_3)

		if arg_1_0 == 1025 then
			var_1_0.y = 30
		end
	end

	if arg_1_3 == ANIMATION_FXDUMMY_BEHIT then
		var_1_0.y = var_1_0.y + 5
	end

	return var_1_0
end
