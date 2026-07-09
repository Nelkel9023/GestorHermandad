--========================================--
-- Gestor de Hermandad
-- Eventos.lua
-- Sistema central de eventos
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

if not GH.EventFrame then
    GH.EventFrame = CreateFrame("Frame")
end

GH.EventFrame:RegisterEvent("ADDON_LOADED")
GH.EventFrame:RegisterEvent("PLAYER_LOGIN")
GH.EventFrame:RegisterEvent("GUILD_ROSTER_UPDATE")

GH.EventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = select(1, ...)
        if addon == "GestorHermandad" then
            if GH.Inicializar then GH:Inicializar() end
        end
    end

    if event == "PLAYER_LOGIN" then
        if GH.CrearInterfaz and GH.PanelHermandad then
            GH:CrearInterfaz()
        end
    end

    if event == "GUILD_ROSTER_UPDATE" then
        GH.RosterActualizado = true
    end
end)