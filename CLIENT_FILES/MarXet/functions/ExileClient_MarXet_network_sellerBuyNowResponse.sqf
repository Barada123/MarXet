/*
*
*  ExileClient_MarXet_network_sellerBuyNowResponse.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_listingArray","_newMoneyString","_configName","_name"];
_listingArray = _this select 0;
_newMoneyString = _this select 1;
MarXet_Hint_ItemName = "";
MarXet_Hint_Poptabs = "";
_configName = ((_listingArray select 2) select 0) call ExileClient_util_gear_getConfigNameByClassName;
_name = getText(configFile >> _configName >> ((_listingArray select 2) select 0) >> "displayName");
ExileClientPlayerMoney = parseNumber(_newMoneyString);
MarXet_Hint_ItemName = _name;
MarXet_Hint_Poptabs = _listingArray select 3;
[["MarXet","Sold"],20,"",20,"",true,true,false,true] call BIS_fnc_advHint;
