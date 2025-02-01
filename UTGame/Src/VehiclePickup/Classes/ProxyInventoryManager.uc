// ProxyInventoryManager
// We replace all vehicles InventoryManagers with this version
// When a vehicle touches a pickup, pass the item into the driver's inventory instead
// otherwise it works the same

class ProxyInventoryManager extends UTInventoryManager;

var Pawn Driver;

replication
{
	if ( (!bSkipActorPropertyReplication || bNetInitial) && (Role==ROLE_Authority) && bNetDirty && bNetOwner )
		Driver;
}

simulated function bool AddInventory(Inventory NewItem, optional bool bDoNotActivate)
{
    if(Driver != None && !NewItem.IsA('UTVehicleWeapon'))
        return Driver.InvManager.AddInventory(NewItem, bDoNotActivate);

    return super.AddInventory(NewItem, bDoNotActivate);
}

simulated function RemoveFromInventory(Inventory ItemToRemove)
{
    if(Driver != None && !ItemToRemove.IsA('UTVehicleWeapon'))
    {
        Driver.InvManager.RemoveFromInventory(ItemToRemove);
        return;
    }

    super.RemoveFromInventory(ItemToRemove);
}

function bool NeedsAmmo(class<UTWeapon> TestWeapon)
{
    if(Driver != None && UTInventoryManager(Driver.InvManager) != None)
        return UTInventoryManager(Driver.InvManager).NeedsAmmo(TestWeapon);

    return super.NeedsAmmo(TestWeapon);
}

function AddAmmoToWeapon(int AmountToAdd, class<UTWeapon> WeaponClassToAddTo)
{
    if(Driver != None && UTInventoryManager(Driver.InvManager) != None)
    {
        UTInventoryManager(Driver.InvManager).AddAmmoToWeapon(AmountToAdd, WeaponClassToAddTo);
        return;
    }

    super.AddAmmoToWeapon(AmountToAdd, WeaponClassToAddTo);
}

defaultproperties
{
}