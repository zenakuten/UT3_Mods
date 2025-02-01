class VPAmmo_SniperRifle extends UTAmmo_SniperRifle;

function SpawnCopyFor( Pawn Recipient )
{
	if ( ProxyInventoryManager(Recipient.InvManager) != none )
		ProxyInventoryManager(Recipient.InvManager).AddAmmoToWeapon(AmmoAmount, TargetWeapon);
	else if ( UTInventoryManager(Recipient.InvManager) != none )
		UTInventoryManager(Recipient.InvManager).AddAmmoToWeapon(AmmoAmount, TargetWeapon);

	Recipient.PlaySound(PickupSound);
	Recipient.MakeNoise(0.2);

	if (PlayerController(Recipient.Controller) != None)
		PlayerController(Recipient.Controller).ReceiveLocalizedMessage(MessageClass,,,,TransformedClass != None ? TransformedClass : Class);
}

auto state Pickup
{
	function bool ValidTouch( Pawn Other )
	{
		if ( !Super.ValidTouch(Other) )
			return false;

		if ( ProxyInventoryManager(Other.InvManager) != none)
		  return ProxyInventoryManager(Other.InvManager).NeedsAmmo(TargetWeapon);
		else if ( UTInventoryManager(Other.InvManager) != none)
		  return UTInventoryManager(Other.InvManager).NeedsAmmo(TargetWeapon);

		return true;
	}
}

defaultproperties
{
    bNoDelete=false
}
