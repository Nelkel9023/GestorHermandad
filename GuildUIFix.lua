--========================================--
-- Gestor de Hermandad
-- GuildUIFix.lua
-- Integración con interfaz Blizzard
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

GH.GuildUILoaded = false

---------------------------------------------------
-- Crear panel dentro de GuildFrame
---------------------------------------------------
function GH:CrearPanelGuild()
    if GH.PanelHermandad then return end
    if not GuildFrame then return end

    local panel = CreateFrame("Frame", "GHGuildPanel", GuildFrame)
    panel:SetWidth(330)
    panel:SetHeight(424)
    panel:SetPoint("TOPLEFT", GuildFrame, "TOPRIGHT", -5, 0)
    panel:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })

    local header = panel:CreateTexture(nil, "ARTWORK")
    header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    header:SetWidth(300)
    header:SetHeight(64)
    header:SetPoint("TOP", 0, 12)

    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", header, "TOP", 0, -14)
    title:SetText("Gestor de Hermandad")
    
    local closeBtn = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    
    panel:Hide()

    GH.PanelHermandad = panel
    GH:CrearInterfaz()
    print("|cFFFFFF00[GH]|r PanelHermandad creado con éxito y anclado a GuildFrame.")
end

---------------------------------------------------
-- Mostrar/ocultar según permisos
---------------------------------------------------
function GH:ActualizarPanelGuild()
    if not GH.PanelHermandad then
        print("|cFFFFFF00[GH]|r Error: PanelHermandad no existe.")
        return
    end
    if not GuildFrame or not GuildFrame:IsShown() then
        GH.PanelHermandad:Hide()
        return
    end
    if GH:TienePermisos() then
        GH.PanelHermandad:Show()
    else
        print("|cFFFFFF00[GH]|r Ocultando panel por falta de permisos.")
        GH.PanelHermandad:Hide()
    end
end

---------------------------------------------------
-- Hook de eventos Blizzard
---------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("GUILD_ROSTER_UPDATE")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = select(1, ...)
        if addon == "Blizzard_GuildUI" then
            GH.GuildUILoaded = true
            GH:CrearPanelGuild()
            if GuildFrame then
                GuildFrame:HookScript("OnShow", function()
                    GH:ActualizarPanelGuild()
                end)
                GuildFrame:HookScript("OnHide", function()
                    if GH.PanelHermandad then GH.PanelHermandad:Hide() end
                end)
            end
        end
    end
    if event == "PLAYER_LOGIN" then
        if GuildFrame then
            GH:CrearPanelGuild()
            GuildFrame:HookScript("OnShow", function()
                GH:ActualizarPanelGuild()
            end)
            GuildFrame:HookScript("OnHide", function()
                if GH.PanelHermandad then GH.PanelHermandad:Hide() end
            end)
        end
    end
    if event == "GUILD_ROSTER_UPDATE" then
        if GH.PanelHermandad and GuildFrame and GuildFrame:IsShown() then
            GH:ActualizarPanelGuild()
        end
    end
end)