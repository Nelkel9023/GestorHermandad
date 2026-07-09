# Gestor de Hermandad (Guild Manager)

Gestor de Hermandad is a highly specialized, lightweight Guild Management Addon designed natively for World of Warcraft 3.3.5a (WotLK). It aims to simplify the day-to-day administrative tasks for Guild Masters and Officers by providing advanced kicking filters, automated invitations, and a permanent blacklist.

[![Download Addon](https://img.shields.io/badge/Download-Latest_Release-success?style=for-the-badge&logo=github)](https://github.com/Nelkel9023/GestorHermandad/archive/refs/heads/master.zip)

## 🌟 Key Features

- **Advanced Kick Filters:** Easily find inactive guild members by selecting how many days they've been offline, while safely ignoring players who have reached a maximum level threshold (so you don't kick your level 60 veterans by accident!).
- **Mass Kick / Check All:** Quickly select and kick dozens of inactive players at once with a single click.
- **Auto-Invite System:** Automatically send a guild invite to anyone who whispers you the trigger words (`inv guild` or `inv hermandad`).
- **Persistent Blacklist:** Block specific toxic or unwanted players from ever receiving an automatic invite again.
- **Native WotLK UI Integration:** Designed from the ground up to look and feel exactly like a standard Blizzard UI frame.

## 🛠️ Installation

1. Click the green **Download Addon** button above.
2. Extract the downloaded `.zip` file.
3. If the extracted folder is named something like `GestorHermandad-master`, rename it to exactly **`GestorHermandad`**.
4. Move the `GestorHermandad` folder into your WoW Addons directory:
   `<Your WoW Directory>\Interface\AddOns\`
5. Log into the game, make sure the addon is enabled on your character selection screen, and type `/reload` just to be safe.

## 🕹️ How to Use

The addon automatically attaches to the standard Guild window for anyone with the permissions to kick members (or the Guild Master). 

- **Debug Mode:** If you ever need to forcefully show the UI for testing purposes, you can toggle debug mode by typing `/gh debug` in your chat window.

## 🐛 Troubleshooting

If the addon is not loading, ensure that your folder structure looks exactly like this:
```text
Interface/
└── AddOns/
    └── GestorHermandad/
        ├── GestorHermandad.toc
        ├── Core.lua
        └── (other addon files...)
```
*(There should be no nested `GestorHermandad` folders!)*
