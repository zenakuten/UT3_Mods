
class MultiDodgeJumpInfo extends Actor
    hidecategories(Navigation,Navigation,Movement,Collision)
    notplaceable;

var UTPlayerController PC;
var int MaxExtraDodges;
var int Count;
var MutMultiDodgeJump Mutator;

replication
{
    if(bNetInitial && Role == ROLE_Authority)
        MaxExtraDodges;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if(WorldInfo.NetMode != NM_DedicatedServer)
    {
        foreach LocalPlayerControllers(class'UTPlayerController', PC)
        {
            break;            
        }        
    }
    else
    {
        if(UTPlayerController(Owner) != none)
        {
            PC = UTPlayerController(Owner);
        }
    }
    Enable('Tick');
    return;    
}

simulated function Tick(float DT)
{
    if((PC == none) || PC.Pawn == none)
    {
        if(PC == none)
        {
            if(PC.Pawn == none)
            {
                Destroy();
            }
        }
        return;
    }
    if(WorldInfo.NetMode == NM_DedicatedServer)
    {
        if(PC.DoubleClickDir == 5)
        {
            PC.ClearDoubleClick();
            PC.DoubleClickDir = DCLICK_None;
            UTPawn(PC.Pawn).MultiJumpRemaining = 1;
        }
    }
    else
    {
        if(PC.Pawn.Physics == 1)
        {
            Count = 0;
        }
        if(((MaxExtraDodges <= 0) || Count < MaxExtraDodges) && PC.DoubleClickDir == 5)
        {
            PC.ClearDoubleClick();
            PC.DoubleClickDir = DCLICK_None;
            UTPawn(PC.Pawn).MultiJumpRemaining = 1;
            ++ Count;
        }
    }
    return;    
}

defaultproperties
{
    RemoteRole=ROLE_SimulatedProxy
    bHidden=true
    bOnlyRelevantToOwner=true
    bReplicateMovement=false
    bOnlyDirtyReplication=true
}