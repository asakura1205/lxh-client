FORCE_COLOR_ELITE = ccc3(160, 85, 255)
FORCE_COLOR_NIGHTMARE = ccc3(255, 55, 85)
FONT_COLOR_GRAY = ccc3(128, 128, 128)
FONT_COLOR_WHITE = ccc3(255, 255, 255)
FONT_COLOR_GREEN = ccc3(97, 226, 62)
FONT_COLOR_BLUE = ccc3(93, 215, 255)
FONT_COLOR_PURPLE = ccc3(205, 124, 246)
FONT_COLOR_ORANGE = ccc3(255, 155, 0)
FONT_COLOR_GOLD = ccc3(255, 181, 30)
FONT_COLOR_RED = ccc3(255, 0, 0)
FONT_COLOR_BLACK = ccc3(61, 58, 41)
HEX_FONT_COLOR_GRAY = "0x808080"
HEX_FONT_COLOR_WHITE = "0xFFFFFF"
HEX_FONT_COLOR_GREEN = "0x61E23E"
HEX_FONT_COLOR_BLUE = "0x5DD7FF"
HEX_FONT_COLOR_PURPLE = "0xCD7CF6"
HEX_FONT_COLOR_ORANGE = "0xFF9600"
HEX_FONT_COLOR_GOLD = "0xFFB51E"
HEX_FONT_COLOR_RED = "0xFF0000"
HEX_FONT_COLOR_BLACK = "0x3D3A29"
EItemOutLineColor = {
	{
		255,
		255,
		255
	},
	{
		97,
		226,
		62
	},
	{
		93,
		215,
		255
	},
	{
		205,
		124,
		246
	},
	{
		255,
		181,
		30
	},
	{
		255,
		0,
		0
	},
	{
		0,
		0,
		0
	}
}
EItemQuailtyColor = {
	FONT_COLOR_WHITE,
	FONT_COLOR_GREEN,
	FONT_COLOR_BLUE,
	FONT_COLOR_PURPLE,
	FONT_COLOR_GOLD,
	FONT_COLOR_RED,
	FONT_COLOR_ORANGE
}
EItemQuailtyColorHex = {
	HEX_FONT_COLOR_WHITE,
	HEX_FONT_COLOR_GREEN,
	HEX_FONT_COLOR_BLUE,
	HEX_FONT_COLOR_PURPLE,
	HEX_FONT_COLOR_GOLD,
	HEX_FONT_COLOR_RED,
	HEX_FONT_COLOR_ORANGE
}
EItemQuailtyDesc = {
	"\xB0\xD7",
	"\xC2\xCC",
	"\xC0\xB6",
	"\xD7\xCF",
	"\xBD\xF0",
	"\xBA\xEC",
	"\xBA\xDA"
}
zbColor = {}

local var_0_0 = {
	"image/frame/itemframe/itemframe1.png",
	"image/frame/itemframe/itemframe2.png",
	"image/frame/itemframe/itemframe3.png",
	"image/frame/itemframe/itemframe4.png",
	"image/frame/itemframe/itemframe5.png",
	"image/frame/itemframe/itemframe6.png",
	"image/frame/itemframe/itemframe7.png"
}
local var_0_1 = {
	"image/frame/itemfragframe/itemfragframe1.png",
	"image/frame/itemfragframe/itemfragframe2.png",
	"image/frame/itemfragframe/itemfragframe3.png",
	"image/frame/itemfragframe/itemfragframe4.png",
	"image/frame/itemfragframe/itemfragframe5.png",
	"image/frame/itemfragframe/itemfragframe6.png",
	"image/frame/itemfragframe/itemfragframe7.png"
}
local var_0_2 = {
	"image/frame/heroframe/heroframe1.png",
	"image/frame/heroframe/heroframe2.png",
	"image/frame/heroframe/heroframe3.png",
	"image/frame/heroframe/heroframe4.png",
	"image/frame/heroframe/heroframe5.png",
	"image/frame/heroframe/heroframe6.png",
	"image/frame/heroframe/heroframe7.png"
}
local var_0_3 = {
	"image/frame/herofragframe/herofragframe1.png",
	"image/frame/herofragframe/herofragframe2.png",
	"image/frame/herofragframe/herofragframe3.png",
	"image/frame/herofragframe/herofragframe4.png",
	"image/frame/herofragframe/herofragframe5.png",
	"image/frame/herofragframe/herofragframe6.png",
	"image/frame/herofragframe/herofragframe7.png"
}
local var_0_4 = {
	"image/frame/shopframe/shopframe1.png",
	"image/frame/shopframe/shopframe2.png",
	"image/frame/shopframe/shopframe3.png",
	"image/frame/shopframe/shopframe4.png",
	"image/frame/shopframe/shopframe5.png",
	"image/frame/shopframe/shopframe6.png",
	"image/frame/shopframe/shopframe7.png"
}

function zbColor.getHeroFrameTex(arg_1_0, arg_1_1)
	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_1_1)

	local var_1_0 = zbUtil:clamp(exchQuality, 1, 7)

	return var_0_2[var_1_0]
end

function zbColor.getEquipFrameTex(arg_2_0, arg_2_1)
	local var_2_0 = zbUtil:clamp(arg_2_1, 1, 7)

	return var_0_0[var_2_0]
end

function zbColor.getHeroFragFrameTex(arg_3_0, arg_3_1)
	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_3_1)

	local var_3_0 = zbUtil:clamp(exchQuality, 1, 7)

	return var_0_3[var_3_0]
end

function zbColor.getEquipFragFrameTex(arg_4_0, arg_4_1)
	local var_4_0 = zbUtil:clamp(arg_4_1, 1, 7)

	return var_0_1[var_4_0]
end

function zbColor.getShopItemFrameTex(arg_5_0, arg_5_1)
	local var_5_0 = zbUtil:clamp(arg_5_1, 1, 7)

	return var_0_4[var_5_0]
end

function zbColor.getItemColor(arg_6_0, arg_6_1)
	local var_6_0 = zbUtil:clamp(arg_6_1, 1, EItemQuality.MaxNum)

	return EItemQuailtyColor[var_6_0]
end

function zbColor.getItemColorHex(arg_7_0, arg_7_1)
	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_7_1)

	local var_7_0 = zbUtil:clamp(exchQuality, 1, 7)

	return EItemQuailtyColorHex[var_7_0]
end

function zbColor.getItemColorDesc(arg_8_0, arg_8_1)
	local var_8_0 = zbUtil:clamp(arg_8_1, 1, EItemQuality.MaxNum)

	return EItemQuailtyDesc[var_8_0]
end

function zbColor.getHeroNameColor(arg_9_0, arg_9_1)
	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_9_1)

	local var_9_0 = zbUtil:clamp(exchQuality, 1, 7)

	return EItemQuailtyColor[var_9_0]
end

CHAT_COLOR_SYSTEM = ccc3(252, 222, 4)
CHAT_COLOR_GUILD = ccc3(51, 204, 51)
CHAT_COLOR_PRIVATE = ccc3(255, 115, 248)
CHAT_COLOR_GREEN = ccc3(97, 226, 62)
CHAT_COLOR_WORLD = ccc3(10, 172, 105)
CHAT_COLOR_GM = ccc3(255, 255, 0)
TITLE_STROKE_COLOR = ccc3(90, 70, 50)
BTN_WHITE_STOKE_COLOR = ccc3(255, 255, 255)
BTN_YELLOW_STOKE_COLOR = ccc3(90, 70, 40)
COLOR_NAME = {}
COLOR_NAME[1] = FONT_COLOR_WHITE
COLOR_NAME[2] = FONT_COLOR_GREEN
COLOR_NAME[3] = FONT_COLOR_BLUE
COLOR_NAME[4] = FONT_COLOR_PURPLE
COLOR_NAME[5] = FONT_COLOR_GOLD
COLOR_NAME[6] = FONT_COLOR_RED
COLOR_NAME[7] = FONT_COLOR_BLACK
