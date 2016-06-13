/*
*
*  ExileClient_MarXet_network_buyerBuyNowResponse.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_stockArray","_newMoneyString","_location","_vehicleNetID","_itemClassName","_vehicleObject","_name","_containersBefore","_containersAfter","_dialog"];
_stockArray = _this select 0;
_newMoneyString = _this select 1;
_location = _this select 2;
_vehicleNetID = _this select 3;
_itemClassName = (_stockArray select 2) select 0;
_sellersUID = _stockArray select 4;
MarXet_Hint_ItemName = "";
MarXet_Hint_Poptabs = "";
MarXet_Hint_Pincode = "";
ExileClientPlayerMoney = parseNumber(_newMoneyString);
if !(_vehicleNetID isEqualTo "") then
{
    _vehicleObject = objectFromNetId _vehicleNetID;
    player moveInDriver _vehicleObject;
    closeDialog 21000;
    _name = getText(configFile >> "CfgVehicles" >> ((_stockArray select 2) select 0) >> "displayName");
    if (_sellersUID isEqualTo (getplayerUID player)) then
    {
        MarXet_Hint_ItemName = _name;
        MarXet_Hint_Pincode = ((_stockArray select 2) select 4);
        [["MarXet","VehicleBoughtSeller"],15,"",15,"",true,true,false,true] call BIS_fnc_advHint;
    }
    else
    {
        MarXet_Hint_ItemName = _name;
        MarXet_Hint_Poptabs = (parseNumber(_stockArray select 3) * -1);
        MarXet_Hint_Pincode = ((_stockArray select 2) select 4);
        [["MarXet","VehicleBought"],15,"",15,"",true,true,false,true] call BIS_fnc_advHint;
    };
}
else
{
    // Thx to Exile for code logic
    switch (_location) do
	{
		case 0:
		{
			_containersBefore = [uniform player, vest player, backpack player];
			[player, _itemClassName] call ExileClient_util_playerCargo_add;
			_containersAfter = [uniform player, vest player, backpack player];
			if !(_containersAfter isEqualTo _containersBefore) then
			{
				["LoadDropdown","Left"] call ExileClient_MarXet_gui_load;
			};
		};
		case 1:
		{
			[(uniformContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
		case 2:
		{
			[(vestContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
		case 3:
		{
			[(backpackContainer player), _itemClassName] call ExileClient_util_containerCargo_add;
		};
	};
    if (_sellersUID isEqualTo (getplayerUID player)) then
    {
        ["Success", ["Couldn't let go of it, huh? I understand :)"]] call ExileClient_gui_notification_event_addNotification;
    }
    else
    {
        ["ItemPurchasedInformation", [parseNumber(_stockArray select 3) * -1]] call ExileClient_gui_notification_event_addNotification;
    };
    _dialog = uiNameSpace getVariable ["RscMarXetDialog", displayNull];
    if !(_dialog isEqualTo displayNull) then
    {
        ["LoadLeft"] call ExileClient_MarXet_gui_load;
        ["LoadRight"] call ExileClient_MarXet_gui_load;
    };
};
