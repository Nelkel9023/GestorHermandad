--========================================--
-- Gestor de Hermandad
-- Confirmaciones.lua
-- Confirmaciones de acciones
-- WoW 3.3.5a
--========================================--

local GH = _G.GH

StaticPopupDialogs["GH_CONFIRMAR_EXPULSION"] = {
    text = "¿Seguro que quieres expulsar los jugadores seleccionados?",
    button1 = "Expulsar",
    button2 = "Cancelar",
    OnAccept = function()
        if not GH.ExpulsionesPendientes then return end
        for _, jugador in ipairs(GH.ExpulsionesPendientes) do
            GuildUninvite(jugador.Nombre)
        end
        GH:Imprimir("Expulsiones completadas.")
        GH.ExpulsionesPendientes = nil
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

function GH:ConfirmarExpulsiones(lista)
    if not lista then return end
    GH.ExpulsionesPendientes = lista
    StaticPopup_Show("GH_CONFIRMAR_EXPULSION")
end