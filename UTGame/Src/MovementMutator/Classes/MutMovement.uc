class MutMovement extends UTMutator 
    config(MovementMutator);

var config float JumpZ;
var config float DodgeSpeed;
var config float DodgeSpeedZ;
var config float WorldGravityZ;
var config float RBPhysicsGravityScaling;
var config float AirControl;

function bool CheckReplacement(Actor Other)
{
    if(UTPawn(Other) != None)
    {
        //UT3 = 420
        //2k4 = 340
        UTPawn(Other).JumpZ = JumpZ;

        //UT3 = 600
        //2k4 = DodgeSpeedFactor (1.5) * groundspeed (440)
        UTPawn(Other).DodgeSpeed = DodgeSpeed;

        //UT3 = 295
        //2k4 = 210
        UTPawn(Other).DodgeSpeedZ = DodgeSpeedZ;

        UTPawn(Other).AirControl = AirControl;
        UTPawn(Other).DefaultAirControl = AirControl;
    }

	return super.CheckReplacement(Other);
}

function InitMutator(string Options, out string ErrorMessage)
{
    // UT3 = -520 * RBPhysicsGravityScaling? (2.0) 
    // 2k4 = -950
	WorldInfo.WorldGravityZ = WorldGravityZ;
    WorldInfo.RBPhysicsGravityScaling = RBPhysicsGravityScaling;
	Super.InitMutator(Options, ErrorMessage);
}


defaultproperties
{
    JumpZ=340.0
    DodgeSpeed=660.0
    DodgeSpeedZ=210.0
    WorldGravityZ=-475.0
    RBPhysicsGravityScaling=1.0
    AirControl=0.1
}