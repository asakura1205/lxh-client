zbTipCommonWnd_Money = class("zbTipCommonWnd_Money")
zbTipCommonWnd_Money.__index = zbTipCommonWnd_Money

function zbTipCommonWnd_Money.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		return
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.btnFrame = tolua.cast(arg_1_0.layer:getChildByTag(2), "CCControlButton")
		arg_1_0.spriteIcon = tolua.cast(arg_1_0.layer:getChildByTag(3), "CCSprite")
		arg_1_0.lbName = tolua.cast(arg_1_0.layer:getChildByTag(1), "CCLabelTTF")
		arg_1_0.OwnerNum = tolua.cast(arg_1_0.layer:getChildByTag(5), "CCLabelTTF")
		arg_1_0.lbDesc1 = tolua.cast(arg_1_0.layer:getChildByTag(6), "CCLabelTTF")
		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height * arg_1_1:getScaleY() * arg_1_2:getScaleY()
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width * arg_1_1:getScaleX() * arg_1_2:getScaleX()
	end

	var_1_0()
	var_1_1()
end

function zbTipCommonWnd_Money.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.layer:setVisible(true)
	zbAwardHelper:refreshAwardItem(arg_4_1, 0, nil, arg_4_0.btnFrame, arg_4_0.spriteIcon, arg_4_0.lbName)
	arg_4_0.OwnerNum:setVisible(true)

	local var_4_0, var_4_1, var_4_2 = zbIconHelper:getMoneyPanelIconPath(arg_4_1)
	local var_4_3 = g_Self.kWealthHandler:getWealthMoneyByType(arg_4_1)

	if arg_4_1 == ECommonAwardType.VipExp then
		var_4_2 = a2u("\xD3\xC3\xD3\xDA\xC9\xFD\xBC\xB6VIP\xB5ȼ\xB6\xA1\xA3")
		var_4_3 = g_GameData.VipInfo.VipBaseInfo.Exp
	end

	arg_4_0.lbDesc1:setString(var_4_2)
	arg_4_0.OwnerNum:setString(a2u("ӵ\xD3\xD0:" .. var_4_3))
end

function createTipCommonWndMoney(arg_5_0, arg_5_1)
	local var_5_0 = zbTipCommonWnd_Money.new()

	var_5_0:init(arg_5_0, arg_5_1)

	return var_5_0
end
