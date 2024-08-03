function MODULE:generateName()
    local name = self.firstNames[math.random(#self.firstNames)] .. " " .. self.lastNames[math.random(#self.lastNames)]
    return name
end