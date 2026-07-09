--========================================--
-- Gestor de Hermandad
-- Configuracion.lua
-- Configuración del addon
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

GH.ConfiguracionPredeterminada = {
    AutoInvitacion = true,
    FiltrosExpulsion = {
        DiasOffline = 90,
        NivelMaximo = 0,
        Rango = nil
    },
    MostrarConfirmacionExpulsion = true,
    AbrirConHermandad = true,
}

function GH:CrearConfiguracion()
    if not GestorHermandadDB then GestorHermandadDB = {} end

    if GestorHermandadDB.AutoInvitacion == nil then
        GestorHermandadDB.AutoInvitacion = GH.ConfiguracionPredeterminada.AutoInvitacion
    end

    if not GestorHermandadDB.FiltrosExpulsion then
        GestorHermandadDB.FiltrosExpulsion = {}
    end
    local filtros = GestorHermandadDB.FiltrosExpulsion
    if filtros.DiasOffline == nil then
        filtros.DiasOffline = GH.ConfiguracionPredeterminada.FiltrosExpulsion.DiasOffline
    end
    if filtros.NivelMaximo == nil then
        filtros.NivelMaximo = GH.ConfiguracionPredeterminada.FiltrosExpulsion.NivelMaximo
    end

    if GestorHermandadDB.MostrarConfirmacionExpulsion == nil then
        GestorHermandadDB.MostrarConfirmacionExpulsion = GH.ConfiguracionPredeterminada.MostrarConfirmacionExpulsion
    end
end

function GH:ObtenerConfiguracion()
    self:CrearConfiguracion()
    return GestorHermandadDB
end

function GH:RestaurarConfiguracion()
    GestorHermandadDB = nil
    self:CrearConfiguracion()
    self:Imprimir("Configuración restaurada.")
end