#include <amxmodx>
#include <zombie_plague_x/add_commas>
//#include <zombie_plague_x/zp_packs_system>

#define PLUGIN  "[ZP] Give Packs Menu"
#define VERSION "1.0"
#define AUTHOR  "DadoDz"

native zp_get_user_packs(index);
native zp_set_user_packs(index, packs);

#define LOG_FILE "zp_give_packs_menu.log"
#define CMD_ACCESS ADMIN_IMMUNITY

new g_playername[33][32];
new g_GivePacks[33];

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);

	register_concmd("zp_packsmenu", "cmd_packsmenu", CMD_ACCESS)

	register_concmd("PACKS_AMOUNT", "GivePacks")
}

public client_putinserver(id) get_user_name(id, g_playername[id], charsmax(g_playername[]));

public cmd_packsmenu(id)
{
	show_menu_give_packs(id);
	return PLUGIN_HANDLED;
}

public show_menu_give_packs(id)
{
	static pmenu, menu[128], info[2], PacksString[16];
	
	format(menu, charsmax(menu), "\y•  \wGive\y Packs\r Menu  \y•\d")
	pmenu = menu_create(menu, "pmenu_handler_gpacks");

	for (new player = 1; player < get_maxplayers(); player++)
	{	
		if (!is_user_connected(player))
			continue;

		add_commas(zp_get_user_packs(player), PacksString, charsmax(PacksString));
		formatex(menu, charsmax(menu), "\r•  \w%s \r[\dPacks\w: \y%s\r]", g_playername[player], PacksString)

		info[0] = player;
		info[1] = 0;

		menu_additem(pmenu, menu, info);
	}

	menu_display(id, pmenu, 0);
}

public pmenu_handler_gpacks(id, pmenu, item)
{	
	if (item == MENU_EXIT)
	{
		menu_destroy(pmenu);
		return PLUGIN_HANDLED;
	}

	new player, access, info[2];
	menu_item_getinfo(pmenu, item, access, info, charsmax(info), _, _, access);
	player = info[0];

	if (!is_user_connected(player))
	{
		menu_destroy(pmenu);
		return PLUGIN_HANDLED;
	}

	client_cmd(id, "messagemode PACKS_AMOUNT");
	g_GivePacks[id] = player
	menu_destroy(pmenu);
	return PLUGIN_HANDLED;
}

public GivePacks(id)
{
	new playerid, packs, szAmount[32], szPacks[32];

	read_argv(1, szAmount, charsmax(szAmount));
	packs = str_to_num(szAmount);
	playerid = g_GivePacks[id]

	if (!is_user_connected(playerid))
		return PLUGIN_HANDLED;

	if (packs <= 0)
	{
		client_print_color(id, print_team_default, "^x04[^x01ZP^x04]^x01 Invalid value of^x03 packs^x01 to give!")
		return PLUGIN_HANDLED;
	}

	add_commas(packs, szPacks, charsmax(szPacks));
	zp_set_user_packs(playerid, zp_get_user_packs(playerid) + packs);

	client_print_color(0, print_team_default, "^04[^01ZP^04]^01 ADMIN^03 %s^01 gave^04 %s^01 Packs to^03 %s^04.", g_playername[id], szPacks, g_playername[playerid])
	log_to_file(LOG_FILE, "ADMIN: (%s) Gave %s Packs to (%s)", g_playername[id], szPacks, g_playername[playerid])
	return PLUGIN_HANDLED;
}
