--========================================--
-- Gestor de Hermandad
-- AutoInvitacionUI.lua
-- Interfaz de auto invitación
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

function GH:CrearModuloAutoInvitacion(parent)
    if parent.ModuloAutoInvitacion then return end

    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent.Contenido)
    parent.ModuloAutoInvitacion = frame

    -- Checkbox
    local check = CreateFrame("CheckButton", "GHAutoInviteCheck", frame, "UICheckButtonTemplate")
    check:SetPoint("TOPLEFT", 10, -10)
    check:SetChecked(GestorHermandadDB.AutoInvitacion)
    _G[check:GetName().."Text"]:SetText("Activar Auto Invitación")
    check:SetScript("OnClick", function(self)
        GestorHermandadDB.AutoInvitacion = self:GetChecked()
    end)

    -- Comandos
    local comandos = frame:CreateFontString(nil, "OVERLAY")
    comandos:SetFontObject(GameFontNormal)
    comandos:SetPoint("TOPLEFT", 15, -60)
    comandos:SetText("Comandos de chat aceptados:\n|cFFFFFFFFinv guild|r\n|cFFFFFFFFinv hermandad|r")
    comandos:SetJustifyH("LEFT")

    -- Agregar a lista negra
    local titulo = frame:CreateFontString(nil, "OVERLAY")
    titulo:SetFontObject(GameFontNormal)
    titulo:SetPoint("TOPLEFT", 15, -140)
    titulo:SetText("Bloquear jugador (Lista Negra):")

    local nombre = CreateFrame("EditBox", "GHAutoInviteBlacklistInput", frame, "InputBoxTemplate")
    nombre:SetWidth(140)
    nombre:SetHeight(20)
    nombre:SetPoint("TOPLEFT", 25, -165)
    nombre:SetAutoFocus(false)

    local agregar = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    agregar:SetWidth(100)
    agregar:SetHeight(22)
    agregar:SetPoint("LEFT", nombre, "RIGHT", 10, 0)
    agregar:SetText("Bloquear")
    agregar:SetScript("OnClick", function()
        local jugador = nombre:GetText()
        if jugador ~= "" then
            GH:AgregarListaNegra(jugador)
            nombre:SetText("")
        end
    end)
end