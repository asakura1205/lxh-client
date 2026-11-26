local var_0_0 = class("zbMailItem", CCNodeExtend)

var_0_0.__index = var_0_0

function createMailItem(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.mailInfo = nil
		arg_3_0.parentWnd = arg_3_1
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_2:getChildByTag(1), "CCNode")

		arg_3_0.s9mail = tolua.cast(var_5_0:getChildByTag(20), "CCScale9Sprite")
		arg_3_0.s9mailRead = tolua.cast(var_5_0:getChildByTag(30), "CCScale9Sprite")
		arg_3_0.iconAttach = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbTitle = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbSender = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbSendTime = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.nodeAtt = tolua.cast(var_5_0:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteRead = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbLeftTime = tolua.cast(arg_3_0.nodeAtt:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.btnGet = tolua.cast(arg_3_0.nodeAtt:getChildByTag(1), "CCControlButton")
		arg_3_0.btnDetail = tolua.cast(var_5_0:getChildByTag(10), "CCControlButton")

		arg_3_0.btnGet:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnDetail:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGet:setSwallowsTouches(false)
		arg_3_0.btnDetail:setSwallowsTouches(false)
		arg_3_0:addChild(arg_3_2)
		arg_3_0:setContentSize(CCSizeMake(630, 115))
		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onSelectedMail()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDetail:addHandleOfControlEvent(function()
			arg_3_0:onSelectedMail()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.mailInfo = arg_8_1

	arg_8_0.lbTitle:setString(arg_8_1.Title)
	arg_8_0.lbSender:setString(arg_8_1.SenderName)
	arg_8_0.lbSendTime:setString(zbUtil:getDateBySecond(arg_8_1.SenderTm) .. " " .. zbUtil:SprintfHHMM(arg_8_1.SenderTm + g_Self.kTimeHandler:getTimeZoneDelt()))
	arg_8_0.lbLeftTime:setString(zbUtil:getExpireTime(arg_8_1.ExpireTm - g_Self.kTimeHandler:getServerTime()))

	if table.getn(arg_8_1.AwardList) > 0 and arg_8_1.AwardState == 1 then
		arg_8_0.s9mail:setVisible(false)
		arg_8_0.s9mailRead:setVisible(true)
		arg_8_0.nodeAtt:setVisible(false)
		arg_8_0.spriteRead:setVisible(true)
		arg_8_0.iconAttach:setTexture(CCTextureCache:sharedTextureCache():addImage("image/mail/mail_sysread.png"))
	elseif table.getn(arg_8_1.AwardList) <= 0 and arg_8_1.ReadState == 1 then
		arg_8_0.s9mail:setVisible(false)
		arg_8_0.s9mailRead:setVisible(true)
		arg_8_0.nodeAtt:setVisible(false)
		arg_8_0.spriteRead:setVisible(true)
		arg_8_0.iconAttach:setTexture(CCTextureCache:sharedTextureCache():addImage("image/mail/mail_sysread.png"))
	elseif table.getn(arg_8_1.AwardList) > 0 and arg_8_1.AwardState == 0 then
		arg_8_0.s9mail:setVisible(true)
		arg_8_0.s9mailRead:setVisible(false)
		arg_8_0.nodeAtt:setVisible(true)
		arg_8_0.spriteRead:setVisible(false)
		arg_8_0.iconAttach:setTexture(CCTextureCache:sharedTextureCache():addImage("image/mail/mail_attach.png"))
	else
		arg_8_0.s9mail:setVisible(true)
		arg_8_0.s9mailRead:setVisible(false)
		arg_8_0.nodeAtt:setVisible(true)
		arg_8_0.spriteRead:setVisible(false)
		arg_8_0.iconAttach:setTexture(CCTextureCache:sharedTextureCache():addImage("image/mail/mail_sys.png"))
	end
end

function var_0_0.onSelectedMail(arg_9_0)
	g_MainScene:showMailContentWnd(arg_9_0.mailInfo):setPrevWnd(arg_9_0.parentWnd)

	if arg_9_0.mailInfo.ReadState ~= 1 then
		g_WsMsgHandler:WS_Mail_Read_Req(arg_9_0.mailInfo.MailId)

		for iter_9_0, iter_9_1 in pairs(g_Self.kMailHandler.MailList) do
			if iter_9_1.MailId == arg_9_0.mailInfo.MailId then
				arg_9_0.mailInfo.ReadState = 1

				break
			end
		end
	end
end
