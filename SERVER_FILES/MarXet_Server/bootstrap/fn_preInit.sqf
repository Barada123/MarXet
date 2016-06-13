/*
*
*  fn_preInit.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private ['_code'];
{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
    ['ExileServer_MarXet_inventory_checkListingID','MarXet_Server\code\ExileServer_MarXet_inventory_checkListingID.sqf'],
    ['ExileServer_MarXet_inventory_confirmStock','MarXet_Server\code\ExileServer_MarXet_inventory_confirmStock.sqf'],
    ['ExileServer_MarXet_inventory_createListingID','MarXet_Server\code\ExileServer_MarXet_inventory_createListingID.sqf'],
    ['ExileServer_MarXet_inventory_initalize','MarXet_Server\code\ExileServer_MarXet_inventory_initalize.sqf'],
    ['ExileServer_MarXet_inventory_updateStock','MarXet_Server\code\ExileServer_MarXet_inventory_updateStock.sqf'],
    ['ExileServer_MarXet_network_buyNowRequest','MarXet_Server\code\ExileServer_MarXet_network_buyNowRequest.sqf'],
    ['ExileServer_MarXet_network_createNewListingRequest','MarXet_Server\code\ExileServer_MarXet_network_createNewListingRequest.sqf'],
    ['ExileServer_MarXet_network_updateInventoryRequest','MarXet_Server\code\ExileServer_MarXet_network_updateInventoryRequest.sqf'],
    ['ExileServer_MarXet_system_getPlayerObject','MarXet_Server\code\ExileServer_MarXet_system_getPlayerObject.sqf'],
    ['ExileServer_MarXet_util_log','MarXet_Server\code\ExileServer_MarXet_util_log.sqf']
];
[format["MarXet has been compiled"],"PreInit"] call ExileServer_MarXet_util_log;
true
