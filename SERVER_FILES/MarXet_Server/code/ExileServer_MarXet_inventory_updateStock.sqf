/*
*
*  ExileServer_MarXet_inventory_updateStock.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_listingID","_count"];
_listingID = _this;
try {
    if (_listingID isEqualTo "") then
    {
        throw 1;
    };
    _count = -1;
    {
        if ((_x find _listingID) != -1) then
        {
            _count = _forEachIndex;
        };
    } forEach MarXetInventory;
    if (_count isEqualTo -1) then
    {
        throw 2;
    };
    MarXetInventory deleteAt _count;
    format["deleteListing:%1",_listingID] call ExileServer_system_database_query_fireAndForget;
    ["updateInventoryResponse",[MarXetInventory]] call ExileServer_system_network_send_broadcast;
}
catch
{
    [_exception,"updateStock"] call ExileServer_MarXet_util_log;
};
