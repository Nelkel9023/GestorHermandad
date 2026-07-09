--========================================--
-- Gestor de Hermandad
-- Dropdowns.lua
-- Menús desplegables
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Crear dropdown genérico
---------------------------------------------------
function GH:CrearDropdown(parent, nombre, valores, seleccion, funcion)
    local dropdown = CreateFrame("Frame", nombre, parent, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropdown, 120)
    UIDropDownMenu_Initialize(dropdown, function(self, level)
        for _, valor in ipairs(valores) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = valor.texto
            info.value = valor.valor
            info.checked = (seleccion == valor.valor)
            info.func = function()
                UIDropDownMenu_SetText(dropdown, valor.texto)
                funcion(valor.valor)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)
    return dropdown
end

---------------------------------------------------
-- Dropdown días offline (sin cambios)
---------------------------------------------------
function GH:CrearDropdownDias(parent)
    local opciones = {
        { texto = "Sin filtro", valor = 0 },
        { texto = "30 días", valor = 30 },
        { texto = "60 días", valor = 60 },
        { texto = "90 días", valor = 90 },
        { texto = "180 días", valor = 180 },
    }
    return self:CrearDropdown(parent, "GHDiasDropdown", opciones, 90, function(valor)
        GH.FiltrosExpulsion.DiasOffline = valor
    end)
end

---------------------------------------------------
-- Dropdown nivel (ACTUALIZADO: 10–60 en pasos de 10)
---------------------------------------------------
function GH:CrearDropdownNivel(parent)
    local opciones = {
        { texto = "Sin filtro", valor = 0 },
        { texto = "Menor de nivel 10", valor = 10 },
        { texto = "Menor de nivel 20", valor = 20 },
        { texto = "Menor de nivel 30", valor = 30 },
        { texto = "Menor de nivel 40", valor = 40 },
        { texto = "Menor de nivel 50", valor = 50 },
        { texto = "Menor de nivel 60", valor = 60 },
    }
    return self:CrearDropdown(parent, "GHNivelDropdown", opciones, 0, function(valor)
        GH.FiltrosExpulsion.NivelMaximo = valor
    end)
end