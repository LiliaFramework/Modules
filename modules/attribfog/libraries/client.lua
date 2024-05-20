function MODULE:SetupWorldFog()
    if not LocalPlayer():getChar() then return false end
    local maxAttrib = LocalPlayer():getChar():getAttrib(self.fogAttribute, 0)
    render.FogStart(0)
    render.FogColor(255, 255, 255, 255)
    render.FogMaxDensity(0.40)
    render.FogMode(1)
    render.FogEnd((self.FogAttribDistance * 3) + (self.FogAttribDistance * maxAttrib))
    return true
end

function MODULE:SetupSkyboxFog()
    if not LocalPlayer():getChar() then return false end
    render.FogStart(0)
    render.FogMode(1)
    render.FogColor(255, 255, 255, 255)
    render.FogMaxDensity(0.50)
    render.FogEnd(0)
    return true
end
