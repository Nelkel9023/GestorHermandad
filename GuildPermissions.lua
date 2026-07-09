--========================================--
-- Gestor de Hermandad
-- GuildPermissions.lua
-- Control de permisos
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Obtener rango del jugador
---------------------------------------------------
function GH:ObtenerMiRango()
    local nombreJugador = UnitName("player")
    GuildRoster()
    local total = GetNumGuildMembers()
    for i = 1, total do
        local nombre, rango, rangoID = GetGuildRosterInfo(i)
        if nombre and self:CompararNombre(nombre, nombreJugador) then
            return rango, rangoID
        end
    end
    return nil, nil
end

---------------------------------------------------
-- Es Guild Master
---------------------------------------------------
function GH:EsGuildMaster()
    local _, rangoID = self:ObtenerMiRango()
    if rangoID == 0 then return true end
    return false
end

---------------------------------------------------
-- Tiene permisos de gestión
---------------------------------------------------
function GH:TienePermisos()
    -- Debug: force permissions if enabled
    if GestorHermandadDB and GestorHermandadDB.DebugMode then
        return true
    end
    
    -- Permissions check: Can kick players or is Guild Master
    if CanGuildRemove() or IsGuildLeader() then
        return true
    end
    
    return false
end

---------------------------------------------------
-- Ocultar panel si no tiene permisos
---------------------------------------------------
function GH:ComprobarPermisosUI()
    if not GH.PanelHermandad then return end
    if self:TienePermisos() then
        GH.PanelHermandad:Show()
    else
        GH.PanelHermandad:Hide()
    end
end