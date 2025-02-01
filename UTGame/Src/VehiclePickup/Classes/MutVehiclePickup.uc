class MutVehiclePickup extends UTMutator;

// update vehicles to have bCanPickupInventory = true so they will pickup items
// replace vehicle inventory manager with a custom version that proxies calls into the player's inventory
// replace orb spawners and flag spawners so they do *not* pickup (unless bCanCarryFlag is true)
// replace armor, health, and ammo pickups with custom versions that proxy into player's inventory
// - snarf
function bool CheckReplacement(Actor Other)
{
    local bool bRelevant;
    local UTVehicle V;
    local UTOnslaughtFlagBase_Content OrbBase;
    local UTCTFRedFlagBase RedFlagBase;
    local UTCTFBlueFlagBase BlueFlagBase;

	bRelevant = super.CheckReplacement(Other);
    if(bRelevant)
    {
        if(UTVehicle(Other) != None)
        {
            V = UTVehicle(Other);
            // set vehicles so they can pickup items
            V.bCanPickupInventory = true;

            // replace vehicle inventory manager with custom version
            V.InventoryManagerClass = class'ProxyInventoryManager';
            If(V.InvManager != None)
            {
                V.InvManager.Destroy();
                V.InvManager = spawn(V.InventoryManagerClass, V);
            }
        }
        else if(UTOnslaughtFlagBase_Content(Other) != None)
        {
            OrbBase = UTOnslaughtFlagBase_Content(Other);
            OrbBase.FlagClass = class'VPOnslaughtFlag_Content';
        }
        else if(UTCTFRedFlagBase(Other) != None)
        {
            RedFlagBase = UTCTFRedFlagBase(Other);
            RedFlagBase.FlagType = class'VPCTFRedFlag';
        }
        else if(UTCTFBlueFlagBase(Other) != None)
        {
            BlueFlagBase = UTCTFBlueFlagBase(Other);
            BlueFlagBase.FlagType = class'VPCTFBlueFlag';
        }
        else if(UTArmorPickup_Helmet(Other) != None && VPArmorPickup_Helmet(Other) == None)
        {
            // Armor
            if(ReplaceWith(Other, "VehiclePickup.VPArmorPickup_Helmet"))
            {
                return false;
            }
        }
        else if(UTArmorPickup_Shieldbelt(Other) != None && VPArmorPickup_Shieldbelt(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPArmorPickup_Shieldbelt"))
            {
                return false;
            }
        }
        else if(UTArmorPickup_Thighpads(Other) != None && VPArmorPickup_Thighpads(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPArmorPickup_Thighpads"))
            {
                return false;
            }
        }
        else if(UTArmorPickup_Vest(Other) != None && VPArmorPickup_Vest(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPArmorPickup_Vest"))
            {
                return false;
            }
        }
        else if(UTPickupFactory_HealthVial(Other) != None && VPPickupFactory_HealthVial(Other) == None)
        {
            // Health
            if(ReplaceWith(Other, "VehiclePickup.VPPickupFactory_HealthVial"))
            {
                return false;
            }
        }
        else if(UTPickupFactory_MediumHealth(Other) != None && VPPickupFactory_MediumHealth(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPPickupFactory_MediumHealth"))
            {
                return false;
            }
        }
        else if(UTPickupFactory_SuperHealth(Other) != None && VPPickupFactory_SuperHealth(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPPickupFactory_SuperHealth"))
            {
                return false;
            }
        }
        else if(UTAmmo_AVRiL(Other) != None && VPAmmo_AVRiL(Other) == None)
        {
            // Ammo
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_AVRiL"))
            {
                return false;
            }
        }
        else if(UTAmmo_BioRifle_Content(Other) != None && VPAmmo_BioRifle_Content(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_BioRifle_Content"))
            {
                return false;
            }
        }
        else if(UTAmmo_BioRifle(Other) != None && VPAmmo_BioRifle(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_BioRifle"))
            {
                return false;
            }
        }
        else if(UTAmmo_Enforcer(Other) != None && VPAmmo_Enforcer(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_Enforcer"))
            {
                return false;
            }
        }
        else if(UTAmmo_FlakCannon(Other) != None && VPAmmo_FlakCannon(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_FlakCannon"))
            {
                return false;
            }
        }
        else if(UTAmmo_LinkGun(Other) != None && VPAmmo_LinkGun(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_LinkGun"))
            {
                return false;
            }
        }
        else if(UTAmmo_RocketLauncher(Other) != None && VPAmmo_RocketLauncher(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_RocketLauncher"))
            {
                return false;
            }
        }
        else if(UTAmmo_RocketLauncher(Other) != None && VPAmmo_RocketLauncher(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_RocketLauncher"))
            {
                return false;
            }
        }
        else if(UTAmmo_ShockRifle(Other) != None && VPAmmo_ShockRifle(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_ShockRifle"))
            {
                return false;
            }
        }
        else if(UTAmmo_SniperRifle(Other) != None && VPAmmo_SniperRifle(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_SniperRifle"))
            {
                return false;
            }
        }
        else if(UTAmmo_Stinger(Other) != None && VPAmmo_Stinger(Other) == None)
        {
            if(ReplaceWith(Other, "VehiclePickup.VPAmmo_SniperRifle"))
            {
                return false;
            }
        }
    }

	return bRelevant;
}

function DriverEnteredVehicle(Vehicle V, Pawn P)
{
    // setup the driver for the proxied inventory manager
    if(ProxyInventoryManager(V.InvManager) != None)
        ProxyInventoryManager(V.InvManager).Driver = P;

    super.DriverEnteredVehicle(V,P);
}

function DriverLeftVehicle(Vehicle V, Pawn P)
{
    if(V != None)
    {
        if(ProxyInventoryManager(V.InvManager) != None)
            ProxyInventoryManager(V.InvManager).Driver = None;
    }

    super.DriverLeftVehicle(V, P);
}

defaultproperties
{
}