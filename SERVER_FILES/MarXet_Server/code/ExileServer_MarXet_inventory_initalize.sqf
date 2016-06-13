/*
*
*  ExileServer_MarXet_inventory_initalize.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_listings"];
["Loading MarXet Inventory...","InventoryInitalize"] call ExileServer_MarXet_util_log;
MarXetInventory = [];
_listings = format ["getListings"] call ExileServer_system_database_query_selectFull;
if !(count(_listings) isEqualTo 0) then
{
    MarXetInventory = [_listings, [], {(_x select 2) select 0}, "ASCEND"] call BIS_fnc_sortBy;
    ["Loaded MarXet Inventory! MarXetInventory is public!","InventoryInitalize"] call ExileServer_MarXet_util_log;
}
else
{
    ["MarXet inventory is empty. :( We've still made it public for your enjoyment. :D","InventoryInitalize"] call ExileServer_MarXet_util_log;
};
