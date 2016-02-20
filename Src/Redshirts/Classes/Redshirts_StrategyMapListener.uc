//---------------------------------------------------------------------------------------
//	Update all soldiers once the user leaves the strategy screen as we might have gotten
//	rookies or a new soldier.
//--------------------------------------------------------------------------------------- 

class Redshirts_StrategyMapListener extends UIScreenListener;

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen) {

	local Redshirts_ArmorPainter painter;

	// Call update function
	if (painter == none)
		painter = new class'Redshirts_ArmorPainter';

	painter.PaintSoldiers(false);
}

defaultproperties
{
	ScreenClass = UIStrategyMap;
}