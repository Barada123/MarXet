/*
*
*  ExileServer_MarXet_network_createNewListingRequest.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_sessionID","_package","_itemArray","_itemClassname","_price","_location","_newListing","_playerObject","_playerUID","_listingID","_vehicle","_la","_vehicleObjectNetID","_vehicleObject","_availableHitpoints","_vehicleHitpoints"];
_sessionID = _this select 0;
_package = _this select 1;
_itemArray = _package select 0;
_itemClassname = _itemArray select 0;
_price = parseNumber(_itemArray select 1);
_location = _itemArray select 2;
_newListing = [];
try {
    _playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
    _playerUID = getPlayerUID _playerObject;
    if (isNull _playerObject) then
	{
		throw "Who are you again?";
	};
    if !(alive _playerObject) then
	{
		throw "Dead players shouldn't be selling stuff, except their soul to the devil";
	};
    if (_itemClassname isEqualTo "") then
    {
        throw "Classname doesn't exist!";
    };
    if (_price <= 0) then
    {
        throw "The sale price was less than or equal to 0";
    };
    _listingID = call ExileServer_MarXet_inventory_createListingID;
    if (_listingID isEqualTo "") then
    {
        throw "Listing ID failed to create. Blame the devs";
    };
    _vehicle = false;
    _la = [_itemClassname];
    if (count(_itemArray) isEqualTo 4) then
    {
        _vehicleObjectNetID = _itemArray select 3;
        _vehicleObject = objectFromNetId _vehicleObjectNetID;
        if (isNull _vehicleObject) then
        {
            throw "Vehicle object is nil, cannot process!";
        };
        _availableHitpoints = getAllHitPointsDamage _vehicleObject;
        _vehicleHitpoints = [];
        if!(_availableHitpoints isEqualTo [])then
        {
            {
                _vehicleHitpoints pushBack [_x ,_vehicleObject getHitPointDamage _x];
            }
            forEach (_availableHitpoints select 0);
        };
        _la =
        [
            _itemClassname,
            fuel _vehicleObject,
            damage _vehicleObject,
            _vehicleHitpoints,
            _vehicleObject getVariable ["ExileAccessCode",""]
        ];
        deleteVehicle _vehicleObject;
        _vehicleObject call ExileServer_object_vehicle_database_delete;
        _vehicle = true;
    };
    _newListing =
    [
        _listingID,
        1,
        _la,
        str(_price),
        _playerUID
    ];
    MarXetInventory pushBack _newListing;
    MarXetInventory = [MarXetInventory, [], {(_x select 2) select 0}, "ASCEND"] call BIS_fnc_sortBy;
    ["updateInventoryResponse",[MarXetInventory]] call ExileServer_system_network_send_broadcast;
    [_sessionID,"createNewListingResponse",[_vehicle,_itemClassname,str(_price),_location]] call ExileServer_system_network_send_to;
    format["createNewListing:%1:%2:%3:%4:%5",_listingID,1,_la,_price,_playerUID] call ExileServer_system_database_query_fireAndForget;
}
catch
{
    [_sessionID,"notificationRequest", ["Whoops", [_exception]]] call ExileServer_system_network_send_to;
    [_exception,"createNewListingRequest"] call ExileServer_MarXet_util_log;
};
