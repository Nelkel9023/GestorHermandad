--========================================--
-- Gestor de Hermandad
-- FiltroExpulsiones.lua
-- Sistema de filtros de expulsión
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

GH.FiltrosExpulsion = {
    DiasOffline = 0,
    NivelMaximo = 0,
    Rango = nil,
}

---------------------------------------------------
-- Buscar jugadores que cumplen filtros
---------------------------------------------------
function GH:BuscarJugadoresExpulsion()
    local resultados = {}
    local filtros = self.FiltrosExpulsion

    GuildRoster()
    local total = GetNumGuildMembers()

    for i = 1, total do
        local nombre, rango, rangoID, nivel, clase, zona, nota, notaOficial, conectado,
              estado, claseID = GetGuildRosterInfo(i)

        if nombre then
            local expulsar = true

            -- No expulsar conectados
            if conectado then expulsar = false end

            -- Filtro nivel
            if filtros.NivelMaximo > 0 then
                if nivel > filtros.NivelMaximo then expulsar = false end
            end

            -- Filtro rango (opcional)
            if filtros.Rango then
                if rango ~= filtros.Rango then expulsar = false end
            end

            -- Filtro días offline
            local anos, meses, diasOff, horas = GetGuildRosterLastOnline(i)
            local totalDiasOff = 0
            if not conectado then
                totalDiasOff = (anos or 0) * 365 + (meses or 0) * 30 + (diasOff or 0)
            end

            if filtros.DiasOffline > 0 then
                if totalDiasOff < filtros.DiasOffline then
                    expulsar = false
                end
            end

            if expulsar then
                table.insert(resultados, {
                    Nombre = nombre,
                    Nivel = nivel,
                    Rango = rango,
                    Offline = totalDiasOff
                })
            end
        end
    end

    return resultados
end

---------------------------------------------------
-- Expulsar jugador
---------------------------------------------------
function GH:ExpulsarJugador(nombre)
    if not nombre then return end
    GuildUninvite(nombre)
    self:Imprimir("Expulsado: " .. nombre)
end