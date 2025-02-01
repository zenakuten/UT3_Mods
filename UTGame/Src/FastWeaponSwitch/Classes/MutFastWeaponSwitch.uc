class MutFastWeaponSwitch extends UTMutator;

function bool CheckReplacement(Actor Other)
{
    if(Weapon(Other) != None)
        Weapon(Other).PutDownTime = 0.0;

    return super.CheckReplacement(Other);
}


defaultproperties
{
}