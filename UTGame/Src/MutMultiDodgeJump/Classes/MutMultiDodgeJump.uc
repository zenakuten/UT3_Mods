
class MutMultiDodgeJump extends UTMutator
    hidecategories(Navigation,Movement,Collision)
    config(MutDodgeJump);

var() config bool bAllowMultiDodge;
var array<Controller> DodgeJumpOwners;
var config int MaxExtraDodges;

function PostBeginPlay()
{
    super(Actor).PostBeginPlay();

    if(WorldInfo.NetMode == NM_DedicatedServer)
    {
        SaveConfig();
    }
    return;    
}

function ModifyPlayer(Pawn Other)
{
    local int I, J;
    local MDTracker tracker;
    local MultiDodgeJumpInfo A;

    super(Mutator).ModifyPlayer(Other);

    if((Other != none) && UTPlayerController(Other.Controller) != none)
    {
        tracker = Spawn(class'MDTracker', Other.Controller);
        tracker.MaxExtraDodges = MaxExtraDodges;
        J = DodgeJumpOwners.Length;
        for( i = 0; i < j; i ++ )
		{
            if(Other.Controller == DodgeJumpOwners[I])
            {
                super(Mutator).ModifyPlayer(Other);
                return;
            }
        }
        DodgeJumpOwners[DodgeJumpOwners.Length] = Other.Controller;
        A = Spawn(class'MultiDodgeJumpInfo', Other.Controller);
        A.Mutator = self;
    }
    super(Mutator).ModifyPlayer(Other);
    return;    
}

defaultproperties
{
}