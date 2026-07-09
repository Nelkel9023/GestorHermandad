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

    for _, boton in ipairs(lista.botones or {}) do
        boton:Hide()
    end
    lista.botones = {}
    GH.MiembrosSeleccionados = {}

    local y = 0
    for _, jugador in ipairs(jugadores) do
        local boton = CreateFrame("CheckButton", "GHKickCheck_" .. y, lista, "UICheckButtonTemplate")
        boton:SetPoint("TOPLEFT", 0, y)
        _G[boton:GetName() .. "Text"]:SetText(jugador.Nombre .. "  Lv." .. jugador.Nivel)
        boton:SetScript("OnClick", function(self)
            if self:GetChecked() then
                table.insert(GH.MiembrosSeleccionados, jugador)
            else
                for i, v in ipairs(GH.MiembrosSeleccionados) do
                    if v.Nombre == jugador.Nombre then
                        table.remove(GH.MiembrosSeleccionados, i)
                        break
                    end
                end
            end
        end)
        table.insert(lista.botones, boton)
        y = y - 25
    end
end

function GH:ObtenerSeleccionExpulsion()
    return GH.MiembrosSeleccionados
end