/*
*
*  ExileServer_MarXet_network_buyNowRequest.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_sessionID","_package","_listingID","_location","_vehicleObject","_playerObject","_stock","_price","_sellersUID","_buyerUID","_playerMoney","_listingArray","_vehicleClass","_pinCode","_position","_hitpoints","_newMoney","_sellerPlayerObject","_sellersMoney","_newSellerMoney","_sellerSessionID"];
_sessionID = _this select 0;
_package = _this select 1;
_listingID = _package select 0;
_location = _package select 1;
_vehicleObject = "";
try {
    _playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
    if (isNull _playerObject) then
	{
		throw "Who are you again?";
	};
    if (_listingID isEqualTo "") then
    {
        throw "Listing ID doesn't exist!";
    };
    _stock = _listingID call ExileServer_MarXet_inventory_confirmStock;
    if (_stock isEqualTo false) then
    {
        throw "Oh noes! The item is no longer available!";
    };
    _price = parseNumber(_stock select 3);
    _sellersUID = _stock select 4;
    _buyerUID = getPlayerUID _playerObject;
    _playerMoney = _playerObject getVariable ["ExileMoney",0];
    if (_playerMoney < _price) then
    {
        throw "You don't have enough money to purchase the item";
    };
    if (count(_stock select 2) > 1) then
    {
        _listingArray = _stock select 2;
        _vehicleClass = _listingArray select 0;
        _pinCode = _listingArray select 4;
        if (_vehicleClass isKindOf "Ship") then
        {
            _position = [(getPosATL _playerObject), 80, 10] call ExileClient_util_world_findWaterPosition;
            _vehicleObject = [_vehicleClass, _position, (random 360), false, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
        }
        else
        {
            _position = (getPos _playerObject) findEmptyPosition [10, 175, _vehicleClass];
            if (_position isEqualTo []) then
            {
                throw "Couldn't find a suitable position for vehicle";
            };
            _vehicleObject = [_vehicleClass, _position, (random 360), true, _pinCode] call ExileServer_object_vehicle_createPersistentVehicle;
        };
        _vehicleObject setVariable ["ExileOwnerUID", _buyerUID];
        _vehicleObject setVariable ["ExileIsLocked",0];
        _vehicleObject lock 0;
        _vehicleObject call ExileServer_object_vehicle_database_insert;
        _vehicleObject setFuel (_listingArray select 1);
        _vehicleObject setDamage (_listingArray select 2);
        _hitpoints = _listingArray select 3;
        if ((typeName _hitpoints) isEqualTo "ARRAY") then
        {
        	{
        		_vehicleObject setHitPointDamage [_x select 0, _x select 1];
        	}
        	forEach _hitpoints;
        };
        _vehicleObject call ExileServer_object_vehicle_database_update;
        _vehicleObject = netID _vehicleObject;
    };
    _listingID call ExileServer_MarXet_inventory_updateStock;
    if (_buyerUID isEqualTo _sellersUID) then
    {
        [_sessionID,"buyerBuyNowResponse",[_stock,str(_playerMoney),_location,_vehicleObject]] call ExileServer_system_network_send_to;
    }
    else
    {
        _newMoney = _playerMoney - _price;
        _playerObject setVariable ["ExileMoney",_newMoney];
        format["setAccountMoney:%1:%2",_newMoney,_buyerUID] call ExileServer_system_database_query_fireAndForget;
        [_sessionID,"buyerBuyNowResponse",[_stock,str(_newMoney),_location,_vehicleObject]] call ExileServer_system_network_send_to;
        _sellerPlayerObject = _sellersUID call ExileServer_MarXet_system_getPlayerObject;
        if (_sellerPlayerObject isEqualTo "") then
        {
            _sellersMoney = format["getAccountMoney:%1", _sellersUID] call ExileServer_system_database_query_selectSingleField;
            _newSellerMoney = _sellersMoney + _price;
            format["setAccountMoney:%1:%2",_newSellerMoney, _sellersUID] call ExileServer_system_database_query_fireAndForget;
        }
        else
        {
            _sellersMoney = _sellerPlayerObject getVariable ["ExileMoney",0];
            _newSellerMoney = _sellersMoney + _price;
            _sellerPlayerObject setVariable ["ExileMoney", _newSellerMoney];
            _sellerSessionID = _sellerPlayerObject getVariable ["ExileSessionID",-1];
            format["setAccountMoney:%1:%2",_newSellerMoney, _sellersUID] call ExileServer_system_database_query_fireAndForget;
            if !(_sellerSessionID isEqualTo -1) then
            {
                [_sellerSessionID,"sellerBuyNowResponse",[_stock,str(_newSellerMoney)]] call ExileServer_system_network_send_to;
            };
        };
    };
}
catch
{
    [_sessionID,"notificationRequest", ["Whoops", [_exception]]] call ExileServer_system_network_send_to;
    [_exception,"BuyNowRequest"] call ExileServer_MarXet_util_log;
};
