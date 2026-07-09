--========================================--
-- Gestor de Hermandad
-- Utilidades.lua
-- Funciones generales
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Comparar nombres
---------------------------------------------------
function GH:CompararNombre(nombre1, nombre2)
    if not nombre1 or not nombre2 then return false end
    return string.lower(nombre1) == string.lower(nombre2)
end

---------------------------------------------------
-- Convertir segundos a días
---------------------------------------------------
function GH:SegundosADias(segundos)
    if not segundos then return 0 end
    return math.floor(segundos / 86400)
end

---------------------------------------------------
-- Obtener información del miembro
---------------------------------------------------
function GH:ObtenerMiembro(nombre)
    GuildRoster()
    local total = GetNumGuildMembers()
    for i = 1, total do
        local nombreJugador, rango, rangoID = GetGuildRosterInfo(i)
        if self:CompararNombre(nombreJugador, nombre) then
            return { Nombre = nombreJugador, Rango = rango, RangoID = rangoID }
        end
    end
    return nil
end

---------------------------------------------------
-- Comprobar Guild Master
---------------------------------------------------
function GH:SoyGuildMaster()
    local miembro = self:ObtenerMiembro(UnitName("player"))
    if not miembro then return false end
    return miembro.RangoID == 0
end

---------------------------------------------------
-- Comprobar si puede gestionar miembros
---------------------------------------------------
function GH:PuedeGestionar()
    local miembro = self:ObtenerMiembro(UnitName("player"))
    if not miembro then return false end
    if miembro.RangoID == 0 then return true end
    if CanGuildPromote() or CanGuildRemove() then return true end
    return false
end

---------------------------------------------------
-- Texto seguro
---------------------------------------------------
function GH:TextoVacio(texto)
    if not texto then return true end
    if texto == "" then return true end
    return false
end