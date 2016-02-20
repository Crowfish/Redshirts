//---------------------------------------------------------------------------------------
//	UIArmory_PromotionPsiOp is the psiops promotion screen
//	Update soldiers once the user leaves this screen
//--------------------------------------------------------------------------------------- 

class Redshirts_ArmoryPromotionPsiOpListener extends UIScreenListener;

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen) {

	local Redshirts_ArmorPainter painter;

	if (!`SCREENSTACK.IsInStack(class'UIAfterAction'))
	{
		// Call update function
		if (painter == none)
			painter = new class'Redshirts_ArmorPainter';

		painter.PaintSoldiers();
	}
}

defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass = UIArmory_PromotionPsiOp;
}