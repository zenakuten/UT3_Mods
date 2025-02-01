//=============================================================================
// MutMultiDodging
// Copyright (c) 2003-2004 by Wormbo <wormbo@onlinehome.de>
//
// Wall dodging as often as you like.
//=============================================================================
// port to ut3 by snarf

class MutMultiDodging extends UTMutator
    config(MultidodgeV2);

var config int MaxMultiJump;
var config bool bMultiDodge;
var config bool bBoostDodging;
var config bool bResetMaxJump;

//=============================================================================
// ModifyPlayer
//
// Re-enables dodging if it's disabled after a previous dodge.
//=============================================================================
function ModifyPlayer(Pawn Other)
{
    local DodgeHack A;
    local UTPlayerController C;
   
    Super.ModifyPlayer(Other);
  
    C = UTPlayerController(Other.Controller);
    if ( C == None )
        return;

  
    ForEach C.ChildActors(class'DodgeHack', A)
    {
        return;
    }
  
    A = Spawn(class'DodgeHack', C);
    A.bBoostDodging = bBoostDodging;
    A.bMultiDodge = bMultiDodge;
    A.bResetMaxJump = bResetMaxJump;

}

function bool CheckReplacement(Actor Other)
{
    if(UTPawn(Other) != None)
        UTPawn(Other).MaxMultiJump = MaxMultiJump;
    else if(UTPickupFactory_JumpBoots(Other) != None)
        UTPickupFactory_JumpBoots(Other).InventoryType=class'MultiJumpBoots';


    return super.CheckReplacement(Other);
}

//=============================================================================
// Default properties
//=============================================================================

defaultproperties
{
    MaxMultiJump = 2
    bBoostDodging = false
    bMultiDodge = true
    bResetMaxJump = true
}
