/*
*
*  MarXet_Init.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
if (!hasInterface || isServer) exitWith {};

[] execVM "MarXet\MarXet_Traders.sqf";
private ['_code'];
{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
    ['ExileClient_MarXet_gui_load','MarXet\functions\ExileClient_MarXet_gui_load.sqf'],
    ['ExileClient_MarXet_network_buyerBuyNowResponse','MarXet\functions\ExileClient_MarXet_network_buyerBuyNowResponse.sqf'],
    ['ExileClient_MarXet_network_createNewListingResponse','MarXet\functions\ExileClient_MarXet_network_createNewListingResponse.sqf'],
    ['ExileClient_MarXet_network_sellerBuyNowResponse','MarXet\functions\ExileClient_MarXet_network_sellerBuyNowResponse.sqf'],
    ['ExileClient_MarXet_network_updateInventoryResponse','MarXet\functions\ExileClient_MarXet_network_updateInventoryResponse.sqf']
];
waitUntil {ExileClientSessionID != ""};
["updateInventoryRequest",[0]] call ExileClient_system_network_send;
