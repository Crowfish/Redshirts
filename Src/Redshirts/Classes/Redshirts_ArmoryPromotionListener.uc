//---------------------------------------------------------------------------------------
//	UIArmory_Promotion is the soldier promotion screen
//	Update soldier once the user leaves this screen
//--------------------------------------------------------------------------------------- 

class Redshirts_ArmoryPromotionListener extends UIScreenListener;

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen) {

	local Redshirts_ArmorPainter painter;

	// Don't update if AfterAction is in the screen stack since we'll update on that screen anyway.
	if (!`SCREENSTACK.IsInStack(class'UIAfterAction'))
	{
		// Call update function
		if (painter == none)
			painter = new class'Redshirts_ArmorPainter';

		painter.PaintSoldiers(false);
	}
}

defaultproperties
{
	ScreenClass = UIArmory_Promotion;
}