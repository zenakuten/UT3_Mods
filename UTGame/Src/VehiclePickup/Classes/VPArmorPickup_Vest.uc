class VPArmorPickup_Vest extends UTArmorPickup_Vest;

function SpawnCopyFor( Pawn Recipient )
{
    // if vehicle, replace recipient with driver
    if(UTVehicle(Recipient) != None)
        Recipient = UTVehicle(Recipient).Driver;

	if ( UTPawn(Recipient) == None )
		return;

	if ( UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo) != None )
	{
		UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo).IncrementPickupStat(GetPickupStatName());
	}

	// Give armor to recipient
	Recipient.MakeNoise(0.2);
	AddShieldStrength(UTPawn(Recipient));
	super(UTArmorPickupFactory).SpawnCopyFor(Recipient);
}

function GiveTo( Pawn P )
{
    // if vehicle, replace recipient with driver
    if(UTVehicle(P) != None)
        P = UTVehicle(P).Driver;

	SpawnCopyFor(P);
	PickedUpBy(P);
}




defaultproperties
{
    bNoDelete=false
}