--========================================--
-- Gestor de Hermandad
-- FiltroExpulsionesUI.lua
-- Interfaz de expulsiones
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

function GH:CrearModuloExpulsiones(parent)
    if parent.ModuloExpulsiones then return end

    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent.Contenido)
    parent.ModuloExpulsiones = frame

    -- Dropdown días
    local offlineLabel = frame:CreateFontString(nil, "OVERLAY")
    offlineLabel:SetFontObject(GameFontNormal)
    offlineLabel:SetPoint("TOPLEFT", 0, 0)
    offlineLabel:SetText("Días desconectado:")

    local diasInput = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    diasInput:SetWidth(40)
    diasInput:SetHeight(20)
    diasInput:SetPoint("TOPLEFT", 130, -3)
    diasInput:SetNumeric(true)
    diasInput:SetAutoFocus(false)
    diasInput:SetMaxLetters(3)
    diasInput:SetText(tostring(GH.FiltrosExpulsion.DiasOffline or 0))
    diasInput:SetScript("OnTextChanged", function(self)
        local value = tonumber(self:GetText()) or 0
        GH.FiltrosExpulsion.DiasOffline = value
    end)
    frame.DiasInput = diasInput

    -- Dropdown nivel
    local nivelLabel = frame:CreateFontString(nil, "OVERLAY")
    nivelLabel:SetFontObject(GameFontNormal)
    nivelLabel:SetPoint("TOPLEFT", 0, -40)
    nivelLabel:SetText("Nivel máximo:")

    local nivelDD = GH:CrearDropdownNivel(frame)
    nivelDD:SetPoint("TOPLEFT", 120, -45)

    -- Botón buscar
    local buscar = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    buscar:SetWidth(100)
    buscar:SetHeight(22)
    buscar:SetPoint("TOPLEFT", 0, -80)
    buscar:SetText("Buscar")
    frame.Buscar = buscar

    -- Resultados
    local resultadosLabel = frame:CreateFontString(nil, "OVERLAY")
    resultadosLabel:SetFontObject(GameFontNormal)
    resultadosLabel:SetPoint("TOPLEFT", 0, -120)
    resultadosLabel:SetText("Resultados:")
    frame.Resultados = resultadosLabel

    -- Botón expulsar
    local expulsar = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    expulsar:SetWidth(140)
    expulsar:SetHeight(22)
    expulsar:SetPoint("BOTTOMLEFT")
    expulsar:SetText("Expulsar seleccionados")
    frame.Expulsar = expulsar

    -- Lógica de búsqueda
    buscar:SetScript("OnClick", function()
        local lista = GH:BuscarJugadoresExpulsion()
        GH:ActualizarListaMiembros(frame, lista)
        frame.Lista = lista
    end)

    -- Lógica de expulsión
    expulsar:SetScript("OnClick", function()
        local seleccionados = GH:ObtenerSeleccionExpulsion()
        if #seleccionados == 0 then
            GH:Imprimir("No hay jugadores seleccionados.")
            return
        end
        GH:ConfirmarExpulsiones(seleccionados)
    end)
end