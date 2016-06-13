/*
*
*  ExileServer_MarXet_inventory_confirmStock.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_listingID","_stock","_count","_listingInformation"];
_listingID = _this;
_stock = [];
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
    _listingInformation = MarXetInventory select _count;
    if ((_listingInformation select 1) isEqualTo 0) then
    {
        throw 3;
    };
    (MarXetInventory select _count) set [1,0];
    _stock = _listingInformation;
}
catch
{
    _stock = false;
    if (_exception isEqualTo 1) then
    {
        [format["Listing ID was blank, DAFUQ?!?!?!"],"ConfirmStock"] call ExileServer_MarXet_util_log;
    };
};
_stock
