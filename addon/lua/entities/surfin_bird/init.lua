AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/pigeon.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetHealth(5)
    self:SetMaxHealth(5)
    self:SetFriction(0)

    local physObj = self:GetPhysicsObject()
    if not physObj:IsValid() then return end
    
    physObj:Wake()
    physObj:EnableGravity(false)
    physObj:EnableDrag(false)
    physObj:SetMass(100)
    physObj:SetDamping(0, 0)
end

function ENT:Use(ply)

end

function ENT:PhysicsCollide(data, physObj)
    local explosion = ents.Create("env_explosion")
    explosion:SetPos(self:GetPos())
    explosion:SetOwner(self:GetOwner())
    explosion:Spawn()
    explosion:SetKeyValue("iMagnitude", "10")
    explosion:Fire("Explode", 0, 0)

    -- damage players
    for _, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
        if v:IsPlayer() then
            v:TakeDamage(33, self:GetOwner(), self)
        end
    end

    self:Remove()
end