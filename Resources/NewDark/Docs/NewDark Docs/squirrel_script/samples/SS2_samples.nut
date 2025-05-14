// squirrel.osm versions of some allobjs.osm scripts


class Battery extends SqRootScript
{
// MESSAGES:

	// handle "FrobToolEnd" messages (message class is "sFrobMsg", see "API-reference_messages.txt")
	function OnFrobToolEnd()
	{
		// post a "Recharge" message to the frob dest object, with a large enough value to ensure a full recharge
		PostMessage(message().DstObjId, "Recharge", 9999);

		// prevent the inventory slot object from being swapped with the battery
		// (only want to recharge the dest object and not do an inventory shuffle)
		ShockGame.PreventSwap();
		// refresh inventory so it displays the recharged state of the object
		ShockGame.RefreshInv();
	}

	// handle "Consume" messages (message class is "sScrMsg")
	function OnConsume()
	{
		// remove 1 stacked battery object
		Container.StackAdd(self, -1);

		// check if "StackCount" property value is 0 or if this object doesn't have the property (in which case 'null' is returned)
		if ( !GetProperty("StackCount") )
			// there are no stacked batteries left or it isn't stackable, destroy this object
			ShockGame.DestroyInvObj(self);
	}

	// handle "FrobInvEnd" messages (message class is "sFrobMsg")
	function OnFrobInvEnd()
	{
		// display on-screen help message for battery
		ShockGame.AddTranslatableText("HelpBattery", "misc", "Player");
	}
}

class BaseImplant extends SqRootScript
{
// METHODS:

	function DoDrain()
	{
		SetData("timer", SetOneShotTimer("drain", GetProperty("DrainRate")));
	}

	function StartUse()
	{
		DoDrain();
		SetData("usage", 1);
	}

	function StopUse()
	{
		KillTimer( GetData("timer") );
		SetData("usage", 0);
	}

// MESSAGES:

	function OnBeginScript()
	{
		if (ShockGame.Equipped(ePlayerEquip.kEquipArmor) == self
			|| ShockGame.Equipped(ePlayerEquip.kEquipSpecial) == self
			|| ShockGame.Equipped(ePlayerEquip.kEquipSpecial2) == self)
		{
			if (GetProperty("Energy") > 0)
			{
				DoDrain();
				SetData("usage", 1);
			}
		}
	}

	function OnEndScript()
	{
		if ( GetData("usage") )
			KillTimer( GetData("timer") );
	}

	function OnTurnOn()
	{
		if (GetProperty("Energy") > 0 && !GetData("usage"))
			StartUse();
	}

	function OnTurnOff()
	{
		if ( GetData("usage") )
			StopUse();
	}

	function OnRecharge()
	{
		local iEnergy = GetProperty("Energy");
		if ((!iEnergy && ShockGame.Equipped(ePlayerEquip.kEquipSpecial) == self)
			|| ShockGame.Equipped(ePlayerEquip.kEquipArmor) == self
			|| ShockGame.Equipped(ePlayerEquip.kEquipSpecial2) == self)
		{
			if ( !GetData("usage") )
				StartUse();
		}

		local iFiniteRechargeAmount = message().data;

		local iNewEnergy = iFiniteRechargeAmount ? iEnergy + iFiniteRechargeAmount : 9999;

		local iMaxCharge = Property.Get("Player", "BaseTechDesc", "Maintain") * 6 + 100;
		if (iNewEnergy > iMaxCharge)
			iNewEnergy = iMaxCharge;

		SetProperty("Energy", iNewEnergy);

		if (iFiniteRechargeAmount && iNewEnergy > iEnergy)
			PostMessage(message().from, "Consume");
	}

	function OnTimer()
	{
		if (message().name == "drain")
		{
			local iNewEnergy = GetProperty("Energy") - GetProperty("DrainAmt");
			if (iNewEnergy < 0)
				iNewEnergy = 0;

			SetProperty("Energy", iNewEnergy);

			ShockGame.RefreshInv();

			if (iNewEnergy <= 0)
			{
				if ( GetData("usage") )
				{
					Sound.PlaySchemaAmbient(self, "bb07");
					StopUse();
				}
			}
			else
				DoDrain();
		}
	}

	function OnFrobToolEnd()
	{
		if ( Object.InheritsFrom(message().DstObjId, "Recharging Station") )
		{
			PostMessage(self, "Recharge");

			Sound.PlayEnvSchema(message().DstObjId, "Event Activate", message().DstObjId, 0, eEnvSoundLoc.kEnvSoundAtObjLoc);

			ShockGame.PreventSwap();
		}
	}
}

class TestImplant extends BaseImplant
{
// METHODS:

	function StartUse()
	{
		print("Equipped!");

		base.StartUse();
	}

	function StopUse()
	{
		print("Un-Equipped!");

		base.StopUse();
	}
}

class WormHeartImplant extends BaseImplant
{
// METHODS:

	function StartUse()
	{
		SetData("Timer", SetOneShotTimer("HealTick", 30));

		base.StartUse();
	}

	function StopUse()
	{
		local hTimer = GetData("Timer");
		if (hTimer != -1)
		{
			KillTimer(hTimer);
			SetData("Timer", -1);
		}

		ActReact.Stimulate("Player", "Venom", 4.0);

		base.StopUse();
	}

// MESSAGES:

	function OnTimer()
	{
		if (message().name == "HealTick")
		{
			SetData("Timer", SetOneShotTimer("HealTick", 30));

			ShockGame.HealObj("Player", 1);

			Sound.PlayEnvSchema(self, "Event Activate", 0, 0, eEnvSoundLoc.kEnvSoundAmbient);
		}
		else
			base.OnTimer();
	}
}

class Recycler extends SqRootScript
{
// MESSAGES:

	function OnFrobToolEnd()
	{
		local item = message().DstObjId;
		if (item)
		{
			if (ShockGame.Equipped(ePlayerEquip.kEquipWeapon) == item
				|| ShockGame.Equipped(ePlayerEquip.kEquipWeaponAlt) == item
				|| ShockGame.Equipped(ePlayerEquip.kEquipArmor) == item
				|| ShockGame.Equipped(ePlayerEquip.kEquipSpecial) == item
				|| ShockGame.Equipped(ePlayerEquip.kEquipSpecial2) == item)
			{
				return;
			}

			local iAmount = Property.Get(item, "Recycle", "");
			if (iAmount > 0)
			{
				local iCount = Property.Get(item, "StackCount", "");
				if (!iCount)
					iCount = 1;

				ShockGame.PayNanites(-iAmount * iCount);

				Object.Destroy(item);

				Sound.PlayEnvSchema(self, "Event Activate", 0, 0, eEnvSoundLoc.kEnvSoundAmbient);

				if ( Container.IsHeld("Player", item) )
					ShockGame.PreventSwap();
			}
		}
	}

	function OnFrobInvEnd()
	{
		ShockGame.AddTranslatableText("HelpRecycler", "misc", "Player");
	}
}

// door base class (does nothing)
class DoorBase extends SqRootScript
{
}

class StdDoor extends DoorBase
{
	// static constant
	static StateTags = [ "Open", "Closed", "Opening", "Closing", "Halted" ];

// METHODS:

	function StateChangeTags()
	{
		local Status = message().ActionType;
		local OldStatus = message().PrevActionType;

		local retval = "Event StateChange, OpenState " + StateTags[Status] + ", OldOpenState " + StateTags[OldStatus];

		if (OldStatus != eDoorStatus.kDoorHalt && IsDataSet("PlayerFrob"))
			retval = retval + ", CreatureType Player";

		if (Status != eDoorStatus.kDoorClosing && Status != eDoorStatus.kDoorOpening)
			ClearData("PlayerFrob");

		return retval;
	}

	function SetCloseTimer()
	{
		if (Door.GetDoorState( self ) != eDoorStatus.kDoorClosing)
		{
			local iStayOpenTime = GetProperty("DoorTimer");
			if (iStayOpenTime != 0)
			{
				if ( IsDataSet("Timer") )
					KillTimer( GetData("Timer") );

				SetData("Timer", SetOneShotTimer("DoorClose", iStayOpenTime));
			}
		}
	}

// MESSAGES:

	function OnTurnOn()
	{
		if ( IsDataSet("Timer") )
			KillTimer( GetData("Timer") );

		Door.OpenDoor( self );

		if (Door.GetDoorState( self ) == eDoorStatus.kDoorOpen)
			SetCloseTimer();
	}

	function OnTurnOff()
	{
		if ( IsDataSet("Timer") )
			KillTimer( GetData("Timer") );

		SetData("Timer", SetOneShotTimer("DoorClose", 3));
	}

	function OnDoorOpening()
	{
		if ( !message().isProxy )
		{
			Link.BroadcastOnAllLinks(self, "TurnOn", "SwitchLink");
			SetCloseTimer();
		}

		Sound.PlayEnvSchemaNet(self, StateChangeTags(), self, 0, eEnvSoundLoc.kEnvSoundOnObj, eSoundNetwork.kSoundNoNetworkSpatial);
	}

	function OnDoorClosing()
	{
		if ( !message().isProxy )
		{
			Link.BroadcastOnAllLinks(self, "TurnOff", "SwitchLink");
			SetCloseTimer();
		}

		Sound.PlayEnvSchemaNet(self, StateChangeTags(), self, 0, eEnvSoundLoc.kEnvSoundOnObj, eSoundNetwork.kSoundNoNetworkSpatial);
	}

	function OnDoorOpen()
	{
		Sound.HaltSchema(self, "", 0);
		Sound.PlayEnvSchemaNet(self, StateChangeTags(), self, 0, eEnvSoundLoc.kEnvSoundOnObj, eSoundNetwork.kSoundNoNetworkSpatial);
	}

	function OnDoorClose()
	{
		OnDoorOpen();
	}

	function OnFrobWorldEnd()
	{
		if ( ShockGame.CheckLocked(self, TRUE, message().Frobber) )
			Door.ToggleDoor( self );
	}

	function OnTimer()
	{
		if (message().name == "DoorClose")
			Door.CloseDoor( self );
	}
}

class HealingStation extends SqRootScript
{
// MESSAGES:

	function OnFrobWorldEnd()
	{
		local Frobber = message().Frobber;

		local hp = Property.Get(Frobber, "HitPoints");
		local hpMax = Property.Get(Frobber, "MAX_HP");

		if (hpMax > hp)
		{
			if (ShockGame.PayNanites(5) == S_OK)
			{
				ShockGame.AddTranslatableText("MedBedUse", "misc", "Player");

				PostMessage(Frobber, "FullHeal");

				Property.SetSimple(Frobber, "RadLevel", 0);
				ShockGame.OverlayChange(kOverlayRadiation, kOverlayModeOff);

				Property.SetSimple(Frobber, "Toxin", 0);
				ShockGame.OverlayChange(kOverlayPoison, kOverlayModeOff);

				Sound.PlayEnvSchema(self, "Event Activate", self, 0, eEnvSoundLoc.kEnvSoundAtObjLoc);
			}
			else
				ShockGame.AddTranslatableText("NeedNanites", "misc", "Player");
		}
	}
}

class BeakerScript extends SqRootScript
{
// MESSAGES:

	function OnFrobToolEnd()
	{
		if ( Object.InheritsFrom(message().DstObjId, "Worm Piles") )
		{
			local beakerArchetype = ShockGame.GetArchetypeName( self );

			if ( Link.AnyExist("Mutate", beakerArchetype) )
			{
				ShockGame.DestroyInvObj( message().SrcObjId );

				local newArchetype = LinkDest( Link.GetOne("Mutate", beakerArchetype) );
				ShockGame.AddInvObj( Object.Create(newArchetype) );
			}
		}
	}
}

class WormPileScript extends SqRootScript
{
// MESSAGES:

	function OnFrobWorldEnd()
	{
		if ( ShockGame.HasImplant("Player", eImplant.kImplantWormBlood) )
		{
			ShockGame.HealObj("Player", 10);
			Sound.PlayAmbient("Player", "hypo02");
			Object.Destroy( self );
		}
	}
}

class TrapSpawn extends SqRootScript
{
// METHODS:

	function GetSpawnType()
	{
		local r1 = GetProperty("Spawn", "Rarity 1");
		local r2 = GetProperty("Spawn", "Rarity 2");
		local r3 = GetProperty("Spawn", "Rarity 3");
		local r4 = GetProperty("Spawn", "Rarity 4");

		local rnd = Data.RandInt(0, r1 + r2 + r3 + r4 - 1);

		local sum = r1;
		if (rnd <= sum) return GetProperty("Spawn", "Type 1");
		sum += r2;
		if (rnd <= sum) return GetProperty("Spawn", "Type 2");
		sum += r3;
		if (rnd <= sum) return GetProperty("Spawn", "Type 3");
		sum += r4;
		if (rnd <= sum) return GetProperty("Spawn", "Type 4");

		return null;
	}

	function Spawn(spawnpoint)
	{
		local type = GetSpawnType();
		if (type)
		{
			//print("TrapSpawn (" + self + ") spawning a " + type); // DEBUG

			local zeroes = vector(0);

			local obj = Object.BeginCreate(type);
			Property.CopyFrom(obj, "EcoType", self);
			Object.Teleport(obj, zeroes, zeroes, spawnpoint);
			if (Property.Get(spawnpoint, "AI_Patrol", "") == 1)
				Property.SetSimple(obj, "AI_Patrol", 1);
			Object.EndCreate(obj);

			Link.Create("Spawned", spawnpoint, obj);

			local sfx = Object.BeginCreate("SpawnSFX");
			Object.Teleport(sfx, zeroes, zeroes, spawnpoint);
			Object.EndCreate(sfx);

			ShockAI.ValidateSpawn(obj, self);

			return obj;
		}

		return 0;
	}

// MESSAGES:

	function OnTurnOn()
	{
		local supply = GetProperty("Spawn", "Supply");

		//print("TrapSpawn (" + self + ") TurnOn, supply = " + supply); // DEBUG

		// if limited supply then decrease available amount (0 = unlimited)
		if (supply > 0)
			SetProperty("Spawn", "Supply", supply == 1 ? -1 : supply-1);

		if (supply != -1)
		{
			local flags = GetProperty("Spawn", "Flags");
			local spawnpoint = ShockGame.FindSpawnPoint(self, flags);
			if (spawnpoint)
			{
				local obj = Spawn(spawnpoint);

				//print("    found spawnpoint, flags = " + flags + ", spawned obj " + obj); // DEBUG

				if (obj && (flags & eSpawnFlags.kSpawnFlagGotoAlarm))
				{
					local dst = message().data;
					AI.MakeGotoObjLoc(obj, dst ? dst : "Player", eAIScriptSpeed.kFast);
				}
			}

			local schema = GetProperty("ObjSoundName");
			if (schema)
				Sound.PlaySchemaAmbientNet(self, schema, eSoundNetwork.kSoundNetworkAmbient);
		}
	}
}

class TriggerEcology extends SqRootScript
{
// METHODS:

	function EcoTriggerMaybe()
	{
		local iMin, iMax, iRand;

		switch ( GetProperty("EcoState") )
		{
		case eEcoState.kEcologyNormal:
			iMin = GetProperty("Ecology", "Normal Min");
			iMax = GetProperty("Ecology", "Normal Max");
			iRand = GetProperty("Ecology", "Normal Rand");
			break;

		case eEcoState.kEcologyAlert:
			iMin = GetProperty("Ecology", "Alert Min");
			iMax = GetProperty("Ecology", "Alert Max");
			iRand = GetProperty("Ecology", "Alert Rand");
			break;

		default:
			return;
		}

		local iPopulation = ShockGame.CountEcoMatching( GetProperty("EcoType") );

		//print("TriggerEcology (" + self + ") update (state = " + GetProperty("EcoState") + "), current population is " + iPopulation); // DEBUG

		if (iPopulation < iMax && (iPopulation < iMin || (iRand > 0 && !Data.RandInt(0, iRand))))
		{
			//print("   triggering! min/max/rand = " + iMin + " " + iMax + " " + iRand); // DEBUG

			Link.BroadcastOnAllLinksData(self, "TurnOn", "SwitchLink", GetData("victim"));
		}
	}

	function SetRecoveryTimer(t)
	{
		KillRecoverTimer();
		SetData("RecoverTime", SetOneShotTimer("Recovery", t));
	}

	function KillRecoverTimer()
	{
		local hTimer = GetData("RecoverTime");
		if (hTimer != -1)
			KillTimer(hTimer);
	}

	function SetEcoNormal()
	{
		SetProperty("EcoState", eEcoState.kEcologyNormal);
	}

	function SetEcoTimer()
	{
		SetData("ecotimer", SetOneShotTimer("Ecology", GetProperty("Ecology", "Period")));
	}

	function AlarmOn()
	{
		Sound.PlaySchemaAmbient(self, "xer02");
		ShockGame.AddAlarm(GetProperty("Ecology", "Alert Recovery") * 1000);
		PostMessage("Player", "KlaxOn");
	}

	function AlarmOff()
	{
		Sound.PlaySchemaAmbient(self, "xer03");
		ShockGame.RemoveAlarm();
		PostMessage("Player", "KlaxOff");
	}

	function ResetEco()
	{
		Link.BroadcastOnAllLinks(self, "Reset", "SwitchLink");
		SetEcoNormal();
		AlarmOff();
		Networking.Broadcast(self, "NetClearAlarm");
	}

// MESSAGES:

	function OnBeginScript()
	{
		if ( !Networking.IsProxy( self ) )
		{
			SetEcoTimer();
			if ( !IsDataSet("RecoverTime") )
				SetData("RecoverTime", -1);
		}
	}

	function OnNetAlarm()
	{
		AlarmOn();
	}

	function OnNetClearAlarm()
	{
		AlarmOff();
	}

	function OnAlarm()
	{
		if (GetProperty("EcoState") == eEcoState.kEcologyNormal)
		{
			SetRecoveryTimer( GetProperty("Ecology", "Alert Recovery") );
			Link.BroadcastOnAllLinksData(self, "Alarm", "SwitchLink", message().data);
			SetData("victim", message().data);
			SetProperty("EcoState", eEcoState.kEcologyAlert);
			AlarmOn();
			Networking.Broadcast(self, "NetAlarm");
		}
	}

	function OnReset()
	{
		if (GetProperty("EcoState") == eEcoState.kEcologyAlert)
		{
			Link.BroadcastOnAllLinksData(self, "Reset", "SwitchLink", message().data);
			SetEcoNormal();
			AlarmOff();
			Networking.Broadcast(self, "NetClearAlarm");
			KillRecoverTimer();
		}
	}

	function OnTimer()
	{
		if (message().name == "Ecology")
		{
			EcoTriggerMaybe();
			SetEcoTimer();
		}
		else if (message().name == "Recovery")
			ResetEco();
	}
}

class TriggerEcologyDiff extends TriggerEcology
{
// METHODS:

	function EcoTriggerMaybe()
	{
		local iMin, iMax, iRand;
		local iref = int_ref();

		switch ( GetProperty("EcoState") )
		{
		case eEcoState.kEcologyNormal:
			iMin = GetProperty("Ecology", "Normal Min");
			iMax = GetProperty("Ecology", "Normal Max");
			iRand = GetProperty("Ecology", "Normal Rand");
			if ( ShockGame.ConfigIsDefined("no_spawn") )
				iMax = 0;
			if ( ShockGame.ConfigGetInt("lower_spawn_min", iref) )
				iMin -= iref.tointeger();
			if (iMin < 0);
				iMin = 0;
			if ( ShockGame.ConfigGetInt("raise_spawn_rand", iref) )
				iRand += iref.tointeger();
			break;

		case eEcoState.kEcologyAlert:
			iMin = GetProperty("Ecology", "Alert Min");
			iMax = GetProperty("Ecology", "Alert Max");
			iRand = GetProperty("Ecology", "Alert Rand");
			break;

		default:
			return;
		}

		if (Quest.Get("Difficulty") == 1)
		{
			if (iMin > 1)
				iMin--;
			if (iMax > 1)
				iMax--;
			iRand *= 2;
		}

		local iPopulation = ShockGame.CountEcoMatching( GetProperty("EcoType") );

		//print("TriggerEcologyDiff (" + self + ") update (state = " + GetProperty("EcoState") + "), current population is " + iPopulation); // DEBUG

		if (iPopulation < iMax && (iPopulation < iMin || (iRand > 0 && !Data.RandInt(0, iRand))))
		{
			//print("   triggering! min/max/rand = " + iMin + " " + iMax + " " + iRand); // DEBUG

			Link.BroadcastOnAllLinksData(self, "TurnOn", "SwitchLink", GetData("victim"));
		}
	}

	function SetEcoTimer()
	{
		local t = GetProperty("Ecology", "Period");

		if (Quest.Get("Difficulty") == 1)
			t *= 2

		SetData("ecotimer", SetOneShotTimer("Ecology", t));
	}
}

class RootPsi extends SqRootScript
{
// METHODS:

	function ActivatePsi()
	{
		local power, type;
		local scriptdonor = ShockObj.FindScriptDonor(self, GetClassName());

		SetData("MetaPropID", scriptdonor);

		SetData("Power", power = Property.Get(scriptdonor, "PsiPower", "Power"));
		SetData("Type", type = Property.Get(scriptdonor, "PsiPower", "Type"));
		SetData("Data1", Property.Get(scriptdonor, "PsiPower", "Data 1"));
		SetData("Data2", Property.Get(scriptdonor, "PsiPower", "Data 2"));
		SetData("Data3", Property.Get(scriptdonor, "PsiPower", "Data 3"));
		SetData("Data4", Property.Get(scriptdonor, "PsiPower", "Data 4"));

		local stat = ShockGame.GetStat(self, eStats.kStatPsi);
		if ( ShockPsi.IsOverloaded(power) )
			stat += 2;
		SetData("PsiStat", stat);

		if (type == ePsiPowerType.kPsiTypeShield)
			SetData("EndHandle", SetOneShotTimer("ShutDown", ShockPsi.GetActiveTime(power), power));
	}

	function DeactivatePsi()
	{
		ShockPsi.OnDeactivate( GetData("Power") );
	}

	function ClearShieldTimer()
	{
		if ( IsDataSet("EndHandle") )
		{
			KillTimer( GetData("EndHandle") );
			ClearData("EndHandle");
		}
	}

// MESSAGES:

	function OnBeginScript()
	{
		if (self == ObjID("Player"))
			ActivatePsi();
	}

	function OnEndScript()
	{
		ClearShieldTimer();
	}

	function OnTimer()
	{
		if (message().name == "ShutDown")
		{
			if (self == ObjID("Player") && message().data == GetData("Power"))
			{
				ClearData("EndHandle");
				DeactivatePsi();
			}
		}
	}

	// there is no "LevelExit" message, but there is however an "EndLevel" message
	// (the game deactivates active psi before level transition so don't need to handle that anyway
	function OnLevelExit()
	{
		if (self == ObjID("Player"))
		{
			ClearShieldTimer();
			DeactivatePsi();
		}
	}

	function OnDeactivatePsi()
	{
		if (self == ObjID("Player") && message().data == GetData("Power"))
		{
			ClearShieldTimer();
			DeactivatePsi();
		}
	}
}

class Immolate extends RootPsi
{
// METHODS:

	function ActivatePsi()
	{
		base.ActivatePsi();

		SetData("pyroFX", Object.Create("Localized Pyro"));
	}

	function DeactivatePsi()
	{
		base.DeactivatePsi();

		Object.Destroy( GetData("pyroFX") );
	}
}


// intercepts all messages sent to all script instances from this OSM
// primarily intended for debugging, do not declare this function unless absolutely needed,
// because it can have a negative impact on performance if there are many script instances
/*function PreFilterMessage(message)
{
	print("PreFilterMessage: \"" + message.message + "\" " + message.from + " -> " + message.to);

	// if it's necessary to set a message reply then the Reply functions from SqRootScript can be used
	//SqRootScript.Reply( .. );

	// return 'true' if message should be intercepted and not sent to the script instance it was intended for (be careful when doing this)
	return false;
}*/
