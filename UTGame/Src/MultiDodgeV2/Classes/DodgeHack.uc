//=============================================================================
// DodgeHack
// Copyright (c) 2003-2004 by Wormbo <wormbo@onlinehome.de>
//
// Re-enables dodging after player performed a dodging move.
//=============================================================================
// ported to UT3 by snarf

class DodgeHack extends Info;


//=============================================================================
// Variables
//=============================================================================

var UTPlayerController Controller;
var bool bBoostDodging;
var bool bMultiDodge;
var bool bResetMaxJump;


//=============================================================================
// Replication
//=============================================================================

replication
{
  if ( Role == ROLE_Authority)
    Controller, bBoostDodging, bMultiDodge, bResetMaxJump;
}

//=============================================================================
// PostBeginPlay
//
// Initializes the Controller variable.
//=============================================================================

simulated function PostBeginPlay()
{
    Controller = UTPlayerController(Owner);
    Super.PostBeginPlay();
}

//=============================================================================
// Tick
//
// Re-enables dodging if it's disabled after a previous dodge.
//=============================================================================
simulated function Tick(float DeltaTime)
{
    local UTPawn Pawn;
    if ( Controller == None ) 
    { 
        // player left the game
        if ( WorldInfo.NetMode != NM_Client )
            Destroy();

        return;
    }
  
    Pawn = UTPawn(Controller.Pawn);
    if ( Controller.DoubleClickDir >= DCLICK_Active ) 
    { 
        // dodging is disabled, so re-enable
        Controller.ClearDoubleClick();
        Controller.DoubleClickDir = DCLICK_None;
        if ( Pawn != None )
        {
            Pawn.bReadyToDoubleJump = true;
            if(bResetMaxJump)
            {
                Pawn.MultiJumpRemaining = Pawn.MaxMultiJump;
            }

            if(bMultiDodge)
            {
                Pawn.MultiDodgeRemaining = Pawn.MaxMultiDodge;
                Pawn.DodgeResetTimestamp = WorldInfo.TimeSeconds - 1;
            }

            // Use 2k3 'no boost dodge' logic
            if(Pawn.bDodging && !bBoostDodging)
            {
                Pawn.Velocity.Z = Pawn.DodgeSpeedZ;
            }
        }
    }
}

//=============================================================================
// Default properties
//=============================================================================

defaultproperties
{
    bOnlyRelevantToOwner=True
    bReplicateMovement=False
    RemoteRole=ROLE_SimulatedProxy
}
