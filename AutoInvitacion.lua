--========================================--
-- Gestor de Hermandad
-- AutoInvitacion.lua
-- Sistema de invitación automática
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Inicializar
---------------------------------------------------
function GH:InicializarAutoInvitacion()
    if GestorHermandadDB.AutoInvitacion == nil then
        GestorHermandadDB.AutoInvitacion = true
    end
end

---------------------------------------------------
-- Comprobar comando válido
---------------------------------------------------
function GH:EsComandoInvitacion(mensaje)
    if not mensaje then return false end
    mensaje = string.lower(mensaje)
    if mensaje == "inv guild" then return true end
    if mensaje == "inv hermandad" then return true end
    return false
end

---------------------------------------------------
-- Procesar susurro
---------------------------------------------------
function GH:ProcesarSusurro(nombre, mensaje)
    self:InicializarAutoInvitacion()
    if not GestorHermandadDB.AutoInvitacion then return end
    if not self:EsComandoInvitacion(mensaje) then return end
    if self:EstaEnListaNegra(nombre) then
        self:Imprimir("Solicitud ignorada (lista negra): " .. nombre)
        return
    end
    GuildInvite(nombre)
    self:Imprimir("Invitación enviada a " .. nombre)
end

---------------------------------------------------
-- Evento de susurros
---------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:SetScript("OnEvent", function(self, event, ...)
    local mensaje = select(1, ...)
    local nombre = select(2, ...)
    if event == "CHAT_MSG_WHISPER" then
        GH:ProcesarSusurro(nombre, mensaje)
    end
end)