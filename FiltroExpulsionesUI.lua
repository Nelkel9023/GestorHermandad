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

    local diasDD = GH:CrearDropdownDias(frame)
    diasDD:SetPoint("TOPLEFT", 120, -5)

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
    resultadosLabel:SetPoint("TOPLEFT", 0, -115)
    resultadosLabel:SetText("Resultados:")
    frame.Resultados = resultadosLabel

    local checkAll = CreateFrame("CheckButton", "GHCheckAllExpulsiones", frame, "UICheckButtonTemplate")
    checkAll:SetPoint("TOPLEFT", 110, -110)
    _G["GHCheckAllExpulsionesText"]:SetText("Marcar Todos")
    checkAll:SetScript("OnClick", function(self)
        if frame.ListaMiembros and frame.ListaMiembros.botones then
            for _, boton in ipairs(frame.ListaMiembros.botones) do
                if boton:IsShown() and boton:GetChecked() ~= self:GetChecked() then
                    boton:SetChecked(self:GetChecked())
                    -- Llamamos al script OnClick del botón para actualizar GH.MiembrosSeleccionados
                    local script = boton:GetScript("OnClick")
                    if script then script(boton) end
                end
            end
        end
    end)
    frame.CheckAll = checkAll

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