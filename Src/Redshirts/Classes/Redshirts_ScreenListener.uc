//---------------------------------------------------------------------------------------
//  Log all ScreenClasses we run into, so we can figure out what to use
//	TODO: Remove this once everything works
//--------------------------------------------------------------------------------------- 

class Redshirts_ScreenListener extends UIScreenListener;

// This event is triggered after a screen is initialized
event OnInit(UIScreen Screen) {

}

// This event is triggered after a screen receives focus
event OnReceiveFocus(UIScreen Screen) {

}

// This event is triggered after a screen loses focus
event OnLoseFocus(UIScreen Screen) {

}

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen) {

	`log("Redshirts: Removed " $ Screen.Class);
}

defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass = none;
}