--========================================--
-- Gestor de Hermandad
-- ListaNegra.lua
-- Sistema de lista negra
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

---------------------------------------------------
-- Inicializar
---------------------------------------------------
function GH:InicializarListaNegra()
    if not GestorHermandadDB.ListaNegra then
        GestorHermandadDB.ListaNegra = {}
    end
end

---------------------------------------------------
-- Agregar
---------------------------------------------------
function GH:AgregarListaNegra(nombre)
    if not nombre or nombre == "" then return false end
    self:InicializarListaNegra()
    nombre = string.lower(nombre)
    if GestorHermandadDB.ListaNegra[nombre] then return false end
    GestorHermandadDB.ListaNegra[nombre] = true
    self:Imprimir("Añadido a lista negra: " .. nombre)
    return true
end

---------------------------------------------------
-- Eliminar
---------------------------------------------------
function GH:EliminarListaNegra(nombre)
    if not nombre then return false end
    self:InicializarListaNegra()
    nombre = string.lower(nombre)
    if not GestorHermandadDB.ListaNegra[nombre] then return false end
    GestorHermandadDB.ListaNegra[nombre] = nil
    self:Imprimir("Eliminado de lista negra: " .. nombre)
    return true
end

---------------------------------------------------
-- Comprobar
---------------------------------------------------
function GH:EstaEnListaNegra(nombre)
    if not nombre then return false end
    self:InicializarListaNegra()
    return GestorHermandadDB.ListaNegra[string.lower(nombre)] == true
end

---------------------------------------------------
-- Obtener lista completa
---------------------------------------------------
function GH:ObtenerListaNegra()
    self:InicializarListaNegra()
    return GestorHermandadDB.ListaNegra
end