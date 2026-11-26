require("gamecore.zbHeroState_Wait")
require("gamecore.zbHeroState_Enter")
require("gamecore.zbHeroState_Show")
require("gamecore.zbHeroState_Fight")
require("gamecore.zbHeroState_Die")
require("gamecore.zbHeroState_Revive")
require("gamecore.zbHeroState_Win")

HeroState_Invalid = 0
HeroState_Wait = 1
HeroState_Enter = 2
HeroState_Show = 3
HeroState_Fight = 4
HeroState_Die = 5
HeroState_Revive = 6
HeroState_Win = 7
zbHeroStateMachine = class("zbHeroStateMachine")
zbHeroStateMachine.__index = zbHeroStateMachine

function zbHeroStateMachine.create(arg_1_0, arg_1_1)
	local var_1_0 = zbHeroStateMachine.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbHeroStateMachine.init(arg_2_0, arg_2_1)
	arg_2_0.hero = arg_2_1
	arg_2_0.states = {}
	arg_2_0.states[HeroState_Wait] = zbHeroState_Wait:create(zbHeroState_Wait, arg_2_1)
	arg_2_0.states[HeroState_Enter] = zbHeroState_Enter:create(HeroState_Enter, arg_2_1)
	arg_2_0.states[HeroState_Show] = zbHeroState_Show:create(HeroState_Show, arg_2_1)
	arg_2_0.states[HeroState_Fight] = zbHeroState_Fight:create(HeroState_Fight, arg_2_1)
	arg_2_0.states[HeroState_Die] = zbHeroState_Die:create(HeroState_Die, arg_2_1)
	arg_2_0.states[HeroState_Revive] = zbHeroState_Revive:create(HeroState_Revive, arg_2_1)
	arg_2_0.states[HeroState_Win] = zbHeroState_Win:create(HeroState_Win, arg_2_1)
	arg_2_0.dieAccumTime = 0
	arg_2_0.currStateId = -1

	arg_2_0:setCurrState(HeroState_Invalid)
end

function zbHeroStateMachine.free(arg_3_0)
	arg_3_0.currStateId = nil
end

function zbHeroStateMachine.update(arg_4_0, arg_4_1)
	if arg_4_0:getCurrState() == nil then
		return
	end

	arg_4_0:getCurrState():update(arg_4_1)

	if arg_4_0.hero.curHp > 0 then
		arg_4_0.dieAccumTime = 0
	end

	if arg_4_0.hero.curHp <= 0 then
		arg_4_0.dieAccumTime = arg_4_0.dieAccumTime + arg_4_1

		if arg_4_0.dieAccumTime > 0.8 / g_CombatSystem:getSpeed() and arg_4_0.hero:isSame(g_CombatSystem.combatData.combatQte:getQteTarget()) == false then
			arg_4_0:setCurrState(HeroState_Die)
		end
	end
end

function zbHeroStateMachine.setCurrState(arg_5_0, arg_5_1)
	if arg_5_0.currStateId == arg_5_1 then
		return
	end

	if arg_5_0.states[arg_5_1] == nil then
		return
	end

	if arg_5_0:getCurrState() then
		arg_5_0:getCurrState():exit()
	end

	arg_5_0.states[arg_5_1]:enter()

	arg_5_0.currStateId = arg_5_1
end

function zbHeroStateMachine.getCurrState(arg_6_0)
	return arg_6_0.states[arg_6_0.currStateId]
end

function zbHeroStateMachine.getCurrStateId(arg_7_0)
	return arg_7_0.currStateId
end
