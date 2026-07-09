--========================================--
-- Gestor de Hermandad
-- ListaMiembros.lua
-- Lista de resultados de expulsión
-- WoW 3.3.5a
--========================================--

local GH = _G.GH
GH.MiembrosSeleccionados = {}

---------------------------------------------------
-- Crear scroll list
---------------------------------------------------
function GH:CrearListaMiembros(parent)
    if parent.ListaMiembros then return end
    local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    scroll:SetWidth(240)
    scroll:SetHeight(180)
    scroll:SetPoint("TOPLEFT", 0, -130)
    local contenido = CreateFrame("Frame")
    contenido:SetWidth(220)
    contenido:SetHeight(400)
    scroll:SetScrollChild(contenido)
    parent.ListaMiembros = contenido
end

---------------------------------------------------
-- Actualizar resultados
---------------------------------------------------
function GH:ActualizarListaMiembros(parent, jugadores)
    self:CrearListaMiembros(parent)
    local lista = parent.ListaMiembros

    lista.botones = lista.botones or {}
    for _, boton in ipairs(lista.botones) do
        boton:Hide()
        boton:SetChecked(false)
    end
    
    GH.MiembrosSeleccionados = {}
    local y = 0
    
    for i, jugador in ipairs(jugadores) do
        local boton = lista.botones[i]
        if not boton then
            boton = CreateFrame("CheckButton", "GHKickCheck_" .. i, lista, "UICheckButtonTemplate")
            table.insert(lista.botones, boton)
        end
        
        boton:SetPoint("TOPLEFT", 0, y)
        _G[boton:GetName() .. "Text"]:SetText(jugador.Nombre .. "  Lv." .. jugador.Nivel)
        boton:Show()
        
        -- Wrap the script in a fresh closure to capture the current `jugador`
        boton:SetScript("OnClick", function(self)
            if self:GetChecked() then
                table.insert(GH.MiembrosSeleccionados, jugador)
            else
                for j, v in ipairs(GH.MiembrosSeleccionados) do
                    if v.Nombre == jugador.Nombre then
                        table.remove(GH.MiembrosSeleccionados, j)
                        break
                    end
                end
            end
        end)
        
        y = y - 25
    end
end

function GH:ObtenerSeleccionExpulsion()
    return GH.MiembrosSeleccionados
end