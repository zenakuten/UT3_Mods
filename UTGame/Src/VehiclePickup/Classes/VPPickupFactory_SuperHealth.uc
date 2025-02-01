class VPPickupFactory_SuperHealth extends UTPickupFactory_SuperHealth;

function SpawnCopyFor( Pawn Recipient )
{
    if(UTVehicle(Recipient) != None && UTVehicle(Recipient).Driver != None)
        Recipient = UTVehicle(Recipient).Driver;
            
	// Give health to recipient
	Recipient.Health += HealAmount(Recipient);

	if ( UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo) != None )
	{
		UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo).IncrementPickupStat(GetPickupStatName());
	}

	super(UTItemPickupFactory).SpawnCopyFor(Recipient);
}

function GiveTo( Pawn P )
{
    // if vehicle, replace recipient with driver
    if(UTVehicle(P) != None)
        P = UTVehicle(P).Driver;

	SpawnCopyFor(P);
	PickedUpBy(P);
}

function int HealAmount(Pawn Recipient)
{
	local UTPawn UTP;

    if(UTVehicle(Recipient) != None && UTVehicle(Recipient).Driver != None)
        Recipient = UTVehicle(Recipient).Driver;

	if (bSuperHeal)
	{
		UTP = UTPawn(Recipient);
		if (UTP != None)
		{
			return FClamp(UTP.SuperHealthMax - Recipient.Health, 0, HealingAmount);
		}
	}
	return FClamp(Recipient.HealthMax - Recipient.Health, 0, HealingAmount);
}

defaultproperties
{
    bNoDelete=false
}