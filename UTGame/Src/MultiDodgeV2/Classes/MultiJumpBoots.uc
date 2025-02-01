//
// Make JumpBoots compatible with MultiJump
//
class MultiJumpBoots extends UTJumpBoots;

simulated function OwnerEvent(name EventName)
{
	if (Role == ROLE_Authority)
	{
		if (EventName == 'MultiJump')
		{
            // fix for multijump bug, charges was going negative
            // so check first
            if(Charges > 0)
            {
                Charges--;
            }
            else
            {
                // if we are here, we ran out of charges but did a multijump
                // revert to old boost so additional multijumps are not boosted
                UTPawn(Owner).MaxFallSpeed = UTPawn(Owner).default.MaxFallSpeed + class'UTJumpBoots'.default.MultiJumpBoost;

                // convert the jumpboot jump we did to regular jump
                UTPawn(Owner).Velocity.Z = UTPawn(Owner).Velocity.Z - MultiJumpBoost + UTPawn(Owner).JumpZ;

            }

			UTPawn(Owner).JumpBootCharge = Charges;
			Spawn(class'UTJumpBootEffect', Owner,, Owner.Location, Owner.Rotation);
			Owner.PlaySound(ActivateSound, false, true, false);
		}
		else if (EventName == 'Landed' && Charges <= 0)
		{
			Destroy();
		}
	}
	else if (EventName == 'MultiJump')
	{
		Owner.PlaySound(ActivateSound, false, true, false);
	}
}

defaultproperties
{
}