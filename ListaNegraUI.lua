--========================================--
-- Gestor de Hermandad
-- ListaNegraUI.lua
-- Interfaz lista negra
-- WoW 3.3.5a
--========================================--

local GH = _G.GH
GH.ListaNegraSeleccionada = nil

function GH:CrearModuloListaNegra(parent)
    if parent.ModuloListaNegra then return end

    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent.Contenido)
    parent.ModuloListaNegra = frame

    local titulo = frame:CreateFontString(nil, "OVERLAY")
    titulo:SetFontObject(GameFontNormal)
    titulo:SetPoint("TOPLEFT", 15, -10)
    titulo:SetText("Jugadores en Lista Negra:")

    local lista = CreateFrame("Frame", nil, frame)
    lista:SetPoint("TOPLEFT", 15, -35)
    lista:SetPoint("BOTTOMRIGHT", -15, 45)
    
    -- Fondo negro para la lista
    local bg = lista:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture(0, 0, 0, 0.5)
    
    frame.Lista = lista

    function GH:ActualizarListaNegraUI()
        if not frame.Lista then return end
        for _, boton in ipairs(frame.Lista.botones or {}) do
            boton:Hide()
        end
        frame.Lista.botones = {}

        local y = -5
        for jugador, _ in pairs(GestorHermandadDB.ListaNegra) do
            local boton = CreateFrame("Button", nil, frame.Lista)
            boton:SetWidth(260)
            boton:SetHeight(20)
            boton:SetPoint("TOPLEFT", 5, y)
            boton:SetNormalFontObject(GameFontWhite)
            boton:SetText(jugador)
            boton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            
            local selectedTex = boton:CreateTexture(nil, "ARTWORK")
            selectedTex:SetAllPoints()
            selectedTex:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            selectedTex:Hide()
            boton.selectedTex = selectedTex

            boton:SetScript("OnClick", function()
                GH.ListaNegraSeleccionada = jugador
                for _, b in ipairs(frame.Lista.botones) do
                    if b.selectedTex then b.selectedTex:Hide() end
                end
                boton.selectedTex:Show()
            end)
            
            table.insert(frame.Lista.botones, boton)
            y = y - 22
        end
    end

    local eliminar = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    eliminar:SetWidth(140)
    eliminar:SetHeight(22)
    eliminar:SetPoint("BOTTOM", 0, 10)
    eliminar:SetText("Desbloquear")
    eliminar:SetScript("OnClick", function()
        if GH.ListaNegraSeleccionada then
            GH:EliminarListaNegra(GH.ListaNegraSeleccionada)
            GH.ListaNegraSeleccionada = nil
            GH:ActualizarListaNegraUI()
        end
    end)

    GH:ActualizarListaNegraUI()
end