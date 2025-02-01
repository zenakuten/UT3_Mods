class VPCTFBlueFlag extends UTCTFBlueFlag;

function bool ValidHolder(Actor other)
{
	local Pawn p;
	local UTPawn UTP;
	local UTBot B;

	p = Pawn(other);

    // we don't want hoverboard to eat the flag, modify this condition from original since it 
    // conflicted with turning on bCanPickupInventory for vehicle
	if ( p == None || p.Health <= 0 || !p.IsPlayerPawn() || Vehicle(p.base) != None || p == OldHolder
		|| (UTVehicle(p) != None && !UTVehicle(p).bCanCarryFlag) || UTVehicle_Hoverboard(p) != None)
	{
		return false;
	}

	// feigning death pawns can't pick up flags
	UTP = UTPawn(Other);
	if (UTP != None && UTP.IsInState('FeigningDeath'))
	{
		return false;
	}

	B = UTBot(P.Controller);
	if (B != None)
	{
		B.NoVehicleGoal = None;
	}

	return true;
}

defaultproperties
{
}
