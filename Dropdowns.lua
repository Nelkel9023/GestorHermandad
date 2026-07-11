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
        { texto = "1 o más días", valor = 1 },
        { texto = "2 o más días", valor = 2 },
        { texto = "3 o más días", valor = 3 },
        { texto = "4 o más días", valor = 4 },
        { texto = "5 o más días", valor = 5 },
        { texto = "6 o más días", valor = 6 },
        { texto = "7 o más días", valor = 7 },
        { texto = "8 o más días", valor = 8 },
        { texto = "9 o más días", valor = 9 },
        { texto = "10 o más días", valor = 10 },
        { texto = "20 o más días", valor = 20 },
        { texto = "30 o más días", valor = 30 },
    }
    return self:CrearDropdown(parent, "GHDiasDropdown", opciones, 0, function(valor)
        GH.FiltrosExpulsion.DiasOffline = valor
    end)
end

---------------------------------------------------
-- Dropdown nivel (ACTUALIZADO: 10–60 en pasos de 10)
---------------------------------------------------
function GH:CrearDropdownNivel(parent)
    local opciones = {
        { texto = "Sin filtro", valor = 0 },
        { texto = "Nivel 10 o menor", valor = 10 },
        { texto = "Nivel 20 o menor", valor = 20 },
        { texto = "Nivel 30 o menor", valor = 30 },
        { texto = "Nivel 40 o menor", valor = 40 },
        { texto = "Nivel 50 o menor", valor = 50 },
        { texto = "Nivel 60 o menor", valor = 60 },
    }
    return self:CrearDropdown(parent, "GHNivelDropdown", opciones, 0, function(valor)
        GH.FiltrosExpulsion.NivelMaximo = valor
    end)
end