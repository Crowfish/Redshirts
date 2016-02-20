//---------------------------------------------------------------------------------------
//	UIAfterAction is the post mission screen
//	Update soldiers once the user leaves this screen
//--------------------------------------------------------------------------------------- 

class Redshirts_AfterActionListener extends UIScreenListener;

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen) {

	local Redshirts_ArmorPainter painter;

	// Call update function

	if (painter == none)
		painter = new class'Redshirts_ArmorPainter';

	//painter.PaintSoldiers();
	painter.PaintSoldiers(false);  // For now just go through all soldiers to possibly catch any new soldiers from mission rewards
}

defaultproperties
{
	ScreenClass = UIAfterAction;
}