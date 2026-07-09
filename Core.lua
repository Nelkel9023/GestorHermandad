--========================================--
-- Gestor de Hermandad
-- Core.lua
-- WoW 3.3.5a (Interface 30300)
--========================================--

local GH = _G.GH
if not GH then
    GH = {}
    _G.GH = GH
end

GH.Version = "1.0.0"
GH.Frame = CreateFrame("Frame")

---------------------------------------------------
-- Base de datos
---------------------------------------------------
local function CrearConfiguracion()
    if not GestorHermandadDB then
        GestorHermandadDB = {}
    end
    if GestorHermandadDB.AutoInvitacion == nil then
        GestorHermandadDB.AutoInvitacion = true
    end
    if not GestorHermandadDB.ListaNegra then
        GestorHermandadDB.ListaNegra = {}
    end
    if not GestorHermandadDB.FiltrosExpulsion then
        GestorHermandadDB.FiltrosExpulsion = {}
    end
    if GestorHermandadDB.DebugMode == nil then
        GestorHermandadDB.DebugMode = false
    end
end

---------------------------------------------------
-- Imprimir
---------------------------------------------------
function GH:Imprimir(texto)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99Gestor Hermandad|r: " .. texto)
end

---------------------------------------------------
-- Slash Command
---------------------------------------------------
SLASH_GESTORHERMANDAD1 = "/gh"
SlashCmdList["GESTORHERMANDAD"] = function(msg)
    if msg == "debug" then
        GestorHermandadDB.DebugMode = not GestorHermandadDB.DebugMode
        if GestorHermandadDB.DebugMode then
            GH:Imprimir("Modo debug: ACTIVADO (Permisos forzados)")
        else
            GH:Imprimir("Modo debug: DESACTIVADO (Permisos normales)")
        end
        return
    end

    if GH.MostrarModuloExpulsiones then
        GH:MostrarModuloExpulsiones()
    else
        GH:Imprimir("La interfaz aún no está disponible.")
    end
end

---------------------------------------------------
-- Carga inicial
---------------------------------------------------
function GH:ADDON_LOADED(nombre)
    if nombre ~= "GestorHermandad" then return end
    CrearConfiguracion()
    GH:Imprimir(GH.L["CARGADO"])
end

---------------------------------------------------
-- Registro de eventos
---------------------------------------------------
GH.Frame:RegisterEvent("ADDON_LOADED")
GH.Frame:SetScript("OnEvent", function(self, event, ...)
    if GH[event] then
        GH[event](GH, ...)
    end
end)