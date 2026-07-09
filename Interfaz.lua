--========================================--
-- Gestor de Hermandad
-- Interfaz.lua
-- Control principal de pestañas
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Ocultar todos los módulos
---------------------------------------------------
function GH:OcultarModulos()
    if not GH.PanelHermandad then return end
    local panel = GH.PanelHermandad
    if panel.ModuloExpulsiones then panel.ModuloExpulsiones:Hide() end
    if panel.ModuloAutoInvitacion then panel.ModuloAutoInvitacion:Hide() end
    if panel.ModuloListaNegra then panel.ModuloListaNegra:Hide() end
end

---------------------------------------------------
-- Mostrar Expulsiones
---------------------------------------------------
function GH:MostrarModuloExpulsiones()
    local panel = GH.PanelHermandad
    if not panel.ModuloExpulsiones then
        GH:CrearModuloExpulsiones(panel)
    end
    GH:OcultarModulos()
    panel.ModuloExpulsiones:Show()
end

---------------------------------------------------
-- Mostrar Auto Invitación
---------------------------------------------------
function GH:MostrarModuloAutoInvitacion()
    local panel = GH.PanelHermandad
    if not panel.ModuloAutoInvitacion then
        GH:CrearModuloAutoInvitacion(panel)
    end
    GH:OcultarModulos()
    panel.ModuloAutoInvitacion:Show()
end

---------------------------------------------------
-- Mostrar Lista Negra
---------------------------------------------------
function GH:MostrarModuloListaNegra()
    local panel = GH.PanelHermandad
    if not panel.ModuloListaNegra then
        GH:CrearModuloListaNegra(panel)
    end
    GH:OcultarModulos()
    panel.ModuloListaNegra:Show()
    GH:ActualizarListaNegraUI()
end

---------------------------------------------------
-- Crear interfaz principal
---------------------------------------------------
function GH:CrearInterfaz()
    if not GH.PanelHermandad then return end
    local panel = GH.PanelHermandad
    if panel.InterfazCreada then return end

    -- Botón Expulsiones
    local exp = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    exp:SetWidth(95)
    exp:SetHeight(24)
    exp:SetPoint("TOPLEFT", 15, -35)
    exp:SetText("Expulsiones")
    exp:SetScript("OnClick", function() GH:MostrarModuloExpulsiones() end)

    -- Botón Auto Invit.
    local auto = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    auto:SetWidth(95)
    auto:SetHeight(24)
    auto:SetPoint("LEFT", exp, "RIGHT", 5, 0)
    auto:SetText("Auto Invit.")
    auto:SetScript("OnClick", function() GH:MostrarModuloAutoInvitacion() end)

    -- Botón Lista Negra
    local lista = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    lista:SetWidth(95)
    lista:SetHeight(24)
    lista:SetPoint("LEFT", auto, "RIGHT", 5, 0)
    lista:SetText("Lista Negra")
    lista:SetScript("OnClick", function() GH:MostrarModuloListaNegra() end)

    -- Contenedor de contenido
    local contenido = CreateFrame("Frame", nil, panel)
    contenido:SetPoint("TOPLEFT", 15, -65)
    contenido:SetPoint("BOTTOMRIGHT", -15, 15)
    panel.Contenido = contenido

    panel.InterfazCreada = true
    
    -- Show first tab by default
    GH:MostrarModuloExpulsiones()
end