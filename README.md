# [ZP] Give Packs Menu

A menu-based admin utility plugin for **Zombie Plague** servers in **Counter-Strike 1.6**.
Allows administrators to give ```Ammo Packs``` to players through an interactive player menu with custom amount input and logging support.

## Plugin Information

  - **Name**: [ZP] Give Packs Menu
  - **Version**: 1.0
  - **Author**: DadoDz
  - **Game**: Counter-Strike 1.6
  - **Mod**: Zombie Plague

## Requirements

- AMX Mod X **1.9+**
- Zombie Plague Mod

## Installation
1. Place ```add_commas.inc``` in: **addons/amxmodx/scripting/include/zombie_plague**
2. Place ```zp_give_packs_menu.sma``` in: **addons/amxmodx/scripting/**
3. Compile it with your AMXX compiler.
4. Place the compiled .amxx file in: **addons/amxmodx/plugins/**
5. Add this line to your plugins.ini: ```zp_give_packs_menu.amxx```
6. Restart your server.

## Required Natives
This plugin uses custom natives to get and set ammo packs, you must change these natives based on your zombie plague version.
- ```native zp_get_user_packs(index)```
- ```native zp_set_user_packs(index, packs)```

## Commands

| Console Command | Description               |
|-----------------|---------------------------|
| `zp_packsmenu`  | Open Ammo Packs Give Menu |

## Notice
> This plugin was originally created for my own server.
The concept already exists, this is simply my own lightweight implementation adapted for **Zombie Plague** servers.
