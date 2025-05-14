// squirrel.osm versions of some gen.osm scripts


// Changes your MAP_MAX_PAGE quest variable to the page on the object's Automap property, then brings up your automap
class MapSupplement extends SqRootScript
{
// MESSAGES:

	// handle "FrobInvEnd" messages (message class is "sFrobMsg", see "API-reference_message.txt")
	function OnFrobInvEnd()
	{
		// get value of quest var "map_max_page"
		local oldmax = Quest.Get("map_max_page");

		// see if this object has the property "Automap"
		if ( HasProperty("Automap") )
		{
			// get the value of the "Page" field in the "Automap" property
			local newmax = GetProperty("Automap", "Page");

			// update the "map_max_page" quest var with the new value from the property, if it's larger than before
			if(newmax > oldmax)
				Quest.Set("map_max_page", newmax);
		}

		// execute the "automap" command
		Debug.Command("automap");
	}
}

// Musical instrument: make a sound (on yourself) if world frobbed or inv frobbed
class Instrument extends SqRootScript
{
// MESSAGES:

	// handle "FrobWorldEnd" messages (message class is "sFrobMsg")
	function OnFrobWorldEnd()
	{
		// play sound schema
		Sound.PlayEnvSchema(self, "Event Activate", self, message().Frobber, eEnvSoundLoc.kEnvSoundAtObjLoc);
	}

	// handle "FrobInvEnd" messages (message class is "sFrobMsg")
	function OnFrobInvEnd()
	{
		// play sound schema
		Sound.PlayEnvSchema(self, "Event Activate", self, message().Frobber, eEnvSoundLoc.kEnvSoundAtObjLoc);
	}
}

// For healing potions: when I am frobbed, make an unreffed clone of myself and put it in A/R contact with the frobber.
class CloneContactFrob extends SqRootScript
{
// MESSAGES:

	// handle "FrobInvEnd" messages (message class is "sFrobMsg")
	function OnFrobInvEnd()
	{
		// create a new object that is a clone of this object
		local newobj = Object.BeginCreate(self);
		// set the "HasRefs" property to FALSE on the clone
		Property.Set(newobj, "HasRefs", FALSE);
		Object.EndCreate(newobj);

		// begin a stim contact between the clone and frobber
		ActReact.BeginContact(newobj, message().Frobber);
	}
}

// Similar to the above: when I take damage from VenomStim, clone the weapon responsible and put me in contact with it, causing continuing damage.
class CloneContactDmg extends SqRootScript
{
// MESSAGES:

	// handle "Damage" messages (message class is "sDamageScrMsg")
	function OnDamage()
	{
		// see if damage type is "VenomStim"
		if (message().kind == ObjID("VenomStim"))
		{
			// create a new object that is a clone of the object causing the damage
			local newobj = Object.BeginCreate(message().culprit);
			Property.Set(newobj, "HasRefs", FALSE);
			Object.EndCreate(newobj);

			// begin a stim contact between the clone and this object
			ActReact.BeginContact(newobj, self);
		}
	}
}

// For object which is slain when frobbed
class FrobSlay extends SqRootScript
{
// MESSAGES:

	function OnFrobWorldEnd()
	{
		// slay this object, with frobber as the culprit
		Damage.Slay(self, message().Frobber);
	}
}

// Manages adding and removing the A/R heat source on flames
class DoFlameSource extends SqRootScript
{
// MESSAGES:

	// handle "Sim" messages (message class is "sSimMsg")
	function OnSim()
	{
		// check that it's a sim start message
		if (message().starting)
		{
			// add the "FlameHeatSource" metaproperty to this object
			Object.AddMetaProperty(self, "FlameHeatSource");
		}
	}

	// handle "Slain" messages
	function OnSlain()
	{
		// remove the "FlameHeatSource" metaproperty from this object
		Object.RemoveMetaProperty(self, "FlameHeatSource");
	}
}

class EatFood extends SqRootScript
{
// MESSAGES:

	function OnFrobInvEnd()
	{
		local Frobber = message().Frobber;
		local is_player = (Frobber == ObjID("Player"));
		local loc = is_player ? eEnvSoundLoc.kEnvSoundAmbient : eEnvSoundLoc.kEnvSoundAtObjLoc;

		local zeroes = vector(0);

		// move the object to the frobber
		Object.Teleport(self, zeroes, zeroes, Frobber);

		Sound.PlayEnvSchema(self, "Event Activate", self, Frobber, loc);
	}
}

class HolyH2O extends EatFood
{
// MESSAGES:

	function OnFrobInvEnd()
	{
		local Frobber = message().Frobber;
		local invent = Link.GetAll("Contains", Frobber);
		local haswater = false;
		local water = ObjID("water");

		foreach (link in invent)
		{
			if ( Object.InheritsFrom(LinkDest(link), water) )
			{
				haswater = true;
				break;
			}
		}

		if (haswater)
			PostMessage(Frobber, "Sanctify");
		else
			Reply(0);

		base.OnFrobInvEnd();
	}

}

class Arrow extends SqRootScript
{
// METHODS:

	function UnEquipMe()
	{
		Bow.UnEquip();
		DrkInv.RemoveSpeedControl("BowDraw");
	}

// MESSAGES:

	function OnBeginScript()
	{
		if ( !IsDataSet("Selected") )
			SetData("Selected", FALSE);
	}

	function OnFrobInvBegin()
	{
		if (message().Abort)
		{
			Bow.AbortAttack();
			DrkInv.RemoveSpeedControl("BowDraw");
		}
		else
		{
			Bow.StartAttack();
			DrkInv.AddSpeedControl("BowDraw", 0.75, 1.0);
		}
	}

	function OnFrobInvEnd()
	{
		local retval = Bow.FinishAttack();
		DrkInv.RemoveSpeedControl("BowDraw");
		Reply(retval);
	}

	function OnInvSelect()
	{
		SetData("Selected", TRUE);
		Bow.SetArrow(self);
		Bow.Equip();
	}

	function OnInvDeSelect()
	{
		SetData("Selected", FALSE);
		UnEquipMe();
	}

	function OnDestroy()
	{
		if ( GetData("Selected") )
			UnEquipMe();
	}
}

class LootSounds extends RootScript
{
// MESSAGES:

	function OnContained()
	{
		if (message().event != eContainsEvent.kContainRemove
			&& message().container == ObjID("Player")
			&& GetTime() > 0.1)
		{
			local schem;

			if ( Object.InheritsFrom(self, "IsLoot") )
				schem = "pickup_loot";
			else
				schem = "pickup_power";

			if (schem)
				Sound.PlaySchemaAmbient(self, schem);
		}
	}
}

class Legible extends SqRootScript
{
// METHODS:

	function ShowText()
	{
		if ( HasProperty("book") )
		{
			local bookname = GetProperty("book");

			if ( HasProperty("TrapQVar") )
			{
				local qvar = GetProperty("TrapQVar");
				local index = Quest.Get(qvar);

				bookname += format("%02d", index);
			}

			if ( HasProperty("bookart") )
			{
				local bookart = GetProperty("bookart");
				DarkUI.ReadBook(bookname, bookart);
			}
			else
			{
				local popup = Data.GetString(bookname, "Page_0", "", "Books");
				DarkUI.TextMessage(popup);
			}
		}
	}
}

class StdBook extends Legible
{
// MESSAGES:

	function OnFrobWorldEnd()
	{
		ShowText();
	}
}

class StdScroll extends Legible
{
// MESSAGES:

	function OnFrobInvEnd()
	{
		ShowText();
	}
}

class BlackJack extends SqRootScript
{
// MESSAGES:

	function OnFrobInvBegin()
	{
		if (message().Abort)
			Weapon.FinishAttack(message().Frobber, message().SrcObjId);
		else
			Weapon.StartAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobInvEnd()
	{
		Weapon.FinishAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobToolBegin()
	{
		Weapon.StartAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobToolEnd()
	{
		Weapon.FinishAttack(message().Frobber, message().SrcObjId);
	}

	function OnInvSelect()
	{
		Weapon.Equip(self, eDarkWeaponType.kDWT_BlackJack);
	}

	function OnInvDeSelect()
	{
		Weapon.UnEquip(self);
	}
}

class Sword extends SqRootScript
{
// MESSAGES:

	function OnFrobInvBegin()
	{
		if (message().Abort)
			Weapon.FinishAttack(message().Frobber, message().SrcObjId);
		else
			Weapon.StartAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobInvEnd()
	{
		Weapon.FinishAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobToolBegin()
	{
		Weapon.StartAttack(message().Frobber, message().SrcObjId);
	}

	function OnFrobToolEnd()
	{
		Weapon.FinishAttack(message().Frobber, message().SrcObjId);
	}

	function OnInvSelect()
	{
		Weapon.Equip(self, eDarkWeaponType.kDWT_Sword);
		DrkInv.AddSpeedControl("SwordEquip", 0.75, 0.8);
	}

	function OnInvDeSelect()
	{
		Weapon.UnEquip(self);
		DrkInv.RemoveSpeedControl("SwordEquip");
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
