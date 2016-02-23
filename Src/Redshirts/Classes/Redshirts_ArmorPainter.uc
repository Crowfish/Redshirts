//---------------------------------------------------------------------------------------
//	Configuration and functions to paint soldier armor
//--------------------------------------------------------------------------------------- 

class Redshirts_ArmorPainter extends Object config(Redshirts);

enum ERedshirtsThresholdMode {
	eRTM_Rank,
	eRTM_Missions,
	eRTM_Kills,
};

// Config values
var protected config ERedshirtsThresholdMode Mode;		// Which value to look at
var protected config int Threshold;						// The rank/missions/kills to reach to get armor colors back
var protected config int PrimaryColor;					// Primary "red" color		7
var protected config int SecondaryColor;				// Secondary				80
var protected config bool ExcludeCharacterPool;			// Don't color character pool soldiers

var XGCharacterGenerator Chargen;						// Used just to get a single config value...
var bool NewSoldier_ForceColors;						// Forces units to use color selections 0-6 when being spawned
var CharacterPoolManager CPM;

// Paint group of soldiers
function PaintSoldiers(optional bool bSquadOnly = true) {

	local int i;
	local XComGameState_Unit Unit;
	local XComGameState_HeadquartersXCom HQState;
	local array<StateObjectReference> Soldiers;

	// Get a game state
	HQState = class'UIUtilities_Strategy'.static.GetXComHQ();

	// Get a config value from CharacterCreator -- there must be a better way. 
	if (Chargen == none)
		Chargen = `XCOMGAME.spawn(class'XGCharacterGenerator');
	NewSoldier_ForceColors = Chargen.NewSoldier_ForceColors;

	// Get a characterpool manager
	CPM = CharacterPoolManager(`XENGINE.GetCharacterPoolManager());
	
	// iterate over squad or all crew members
	if (bSquadOnly)
		Soldiers = HQState.Squad;
	else
		Soldiers = HQState.Crew;

	for (i = 0; i < Soldiers.Length; i++) {

		Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Soldiers[i].ObjectID));

		if (Unit.IsAlive()) {
			if (Unit.IsASoldier()) {
				// We found a soldier
				// Check if soldier needs painting
				switch (Mode)
				{
					case eRTM_Rank:
						CheckAndPaint(Unit, Unit.GetSoldierRank());
						break;
					case eRTM_Missions:
						CheckAndPaint(Unit, Unit.GetNumMissions());
						break;
					case eRTM_Kills:
						CheckAndPaint(Unit, Unit.GetNumKills());
						break;
				}
			}
		}
	}

	// Remove Chargen instance again
	Chargen.Destroy();
}

// Paint the soldier red or back to original colors if needed
function CheckAndPaint(XComGameState_Unit Unit, int iValue)
{
	local int iColors;
	local int SkipColors;
	local int DefaultColors;
	local bool bPaint;
	local XComGameState_Unit PoolUnit;
	
	if (iValue < Threshold)
	{

		if (ExcludeCharacterPool)
		{
			// Check if soldier is from the characterpool.
			// It seems the only way is to compare names
			PoolUnit = CPM.GetCharacter(Unit.GetFullName());
			bPaint = (PoolUnit == none);
		}
		
		if (bPaint)
		{
			Unit.kAppearance.iArmorTint = PrimaryColor;	
			Unit.kAppearance.iArmorTintSecondary = SecondaryColor;
			Unit.StoreAppearance();
		}
	}
	else
	{
		// Check if soldier has red armor then restore original if needed
		if (Unit.kAppearance.iArmorTint == PrimaryColor && Unit.kAppearance.iArmorTintSecondary == SecondaryColor)
		{
			// Check if soldier is from the characterpool.
			// It seems the only way is to compare names
			PoolUnit = CPM.GetCharacter(Unit.GetFullName());
			if (PoolUnit == none)
			{
				// Non-pool soldier, randomize armor colors
				// Grabbed from XGCharacterGenerator, not using templates
				// Randomly select colors for new soldiers
				SkipColors = 10; //The last colors in the palette are rainbow colors, so skip those
				DefaultColors = 7; //Military default colors are 0-7

				if (NewSoldier_ForceColors)
				{
					Unit.kAppearance.iArmorTint = `SYNC_RAND(DefaultColors);
					Unit.kAppearance.iArmorTintSecondary = `SYNC_RAND(DefaultColors);
				}
				else
				{
					iColors = `CONTENT.GetColorPalette(ePalette_ArmorTint).Entries.length - SkipColors; 
					Unit.kAppearance.iArmorTint = `SYNC_RAND(iColors);
					Unit.kAppearance.iArmorTintSecondary = `SYNC_RAND(iColors);
				}
			}
			else
			{
				// Character pool soldier, restore armor colors
				Unit.kAppearance.iArmorTint = PoolUnit.kAppearance.iArmorTint;
				Unit.kAppearance.iArmorTintSecondary = PoolUnit.kAppearance.iArmorTintSecondary;
			}
		}
	}
}
