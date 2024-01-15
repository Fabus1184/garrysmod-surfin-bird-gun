SWEP.PrintName = "Surfin Bird Gun"
SWEP.Author = "Fabus1184"
SWEP.Contact = "github/Fabus1184"
SWEP.Purpose = "A-well-a everybody's heard about the bird! B-b-b-bird, bird, bird, b-bird's the word!"
SWEP.Instructions = "BIRD BIRD BIRD, B-BIRD'S THE WORD!"
SWEP.Category = "BIRD BIRD BIRD, B-BIRD'S THE WORD!"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Base = "weapon_tttbase"
SWEP.Icon = "icon_surfin_bird_gun"

-- TTT
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.EquipMenuData = {
    type = "item_weapon",
    desc = "BIRD BIRD BIRD, B-BIRD'S THE WORD!"
}
SWEP.Kind = WEAPON_EQUIP1

SWEP.Primary.Damage = 10
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "Surfin Birds"
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Spread = 0.1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = .2
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 200

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo	= "none"

SWEP.Slot = 6
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.Weight = 10
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true
SWEP.HoldType = "Pistol" 
SWEP.FiresUnderwater = false
SWEP.CSMuzzleFlashes = true

local SurfinBird = "surfinbird.wav"

function SWEP:Initialize()
    util.PrecacheSound(SurfinBird)
    self:SetWeaponHoldType(self.HoldType)
end

local Playing = false

function SWEP:Holster()
    if Playing then
        Playing = false
        self:StopSound(SurfinBird)
    end

    return true
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
        return
    end

    if not Playing then
        print("BIRD BIRD BIRD, B-BIRD'S THE WORD!")
        Playing = true
        self:EmitSound(SurfinBird, 500)

        self:SetNextPrimaryFire(CurTime() + 3)
        return
    end

    if CLIENT then
        return
    end
    
    -- spawn flying bird entity
    local bird = ents.Create("surfin_bird")
    bird:SetPos(self.Owner:GetShootPos())
    bird:SetAngles(self.Owner:EyeAngles())
    bird:SetOwner(self.Owner)
    bird:Spawn()
    bird:Activate()
    bird:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector() * 10000)

    self:ShootEffects()

    self.Owner:ViewPunch(Angle(rnda, rndb, rnda)) 
    self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay) 
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end