--========================================--
-- Gestor de Hermandad
-- NotaOficial.lua
-- Gestión de notas de oficial
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Comprobar permisos de nota
---------------------------------------------------
function GH:PuedeEditarNotaOficial()
    if CanEditOfficerNote then
        return CanEditOfficerNote()
    end
    return false
end

---------------------------------------------------
-- Buscar índice del miembro
---------------------------------------------------
function GH:BuscarIndiceGuild(nombre)
    GuildRoster()
    local total = GetNumGuildMembers()
    for i = 1, total do
        local jugador = GetGuildRosterInfo(i)
        if jugador and self:CompararNombre(jugador, nombre) then
            return i
        end
    end
    return nil
end

---------------------------------------------------
-- Cambiar nota oficial
---------------------------------------------------
function GH:CambiarNotaOficial(nombre, nota)
    if not nombre or not nota then return false end
    if not self:PuedeEditarNotaOficial() then
        self:Imprimir("No tienes permiso para editar notas de oficial.")
        return false
    end
    local idx = self:BuscarIndiceGuild(nombre)
    if not idx then return false end
    SetGuildRosterSelection(idx)
    GuildRosterSetOfficerNote(nota)
    self:Imprimir("Nota oficial actualizada: " .. nombre)
    return true
end