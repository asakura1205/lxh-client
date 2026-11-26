require("gamebase.zbLoadCSV")

zbRandomNameTable = {}
zbRandomNameTable.firstName = {}
zbRandomNameTable.lastName = {}

function zbRandomNameTable.load(arg_1_0, arg_1_1)
	local var_1_0 = require(arg_1_1)

	if var_1_0 == nil then
		return
	end

	if type(var_1_0) == "table" then
		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if iter_1_0 == 1 or iter_1_0 == 2 or iter_1_1[1] == "" then
				-- block empty
			else
				table.insert(zbRandomNameTable.firstName, iter_1_1[1])
				table.insert(zbRandomNameTable.lastName, iter_1_1[2])
			end
		end
	end

	return arg_1_0
end
