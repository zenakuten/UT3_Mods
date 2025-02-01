class MutHitbox extends UTMutator
    config(HitboxMutator);

var config float Height;
var config float Radius;

function bool CheckReplacement(Actor Other)
{
    if(UTPawn(Other) != None)
    {
        UTPawn(Other).DefaultHeight=Height;
        UTPawn(Other).DefaultRadius=Radius;
        UTPawn(Other).CylinderComponent.SetCylinderSize(Radius, Height);
    }

    return true;
}

defaultproperties
{
    Height=44.0;
    Radius=21.0;
}