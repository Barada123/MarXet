/*
*
*  ExileClient_MarXet_gui_load.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private ["_option","_display"];
disableSerialization;
_option = _this select 0;
_display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
switch (_option) do
{
    case ("Load"):
    {
        private ["_display","_rightDropdown","_rightLB","_leftLB","_leftDropdown","_priceEditBox","_purchaseBtn"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        MarXet_TempVehicleArray = [];
        MarXet_VehicleObjectArray = [];
        MarXet_ListingArray = [];
        MarXet_SelectedListingID = "";
        MarXet_TempListingClassname = "";
        ["LoadDropdown","Left"] call ExileClient_MarXet_gui_load;
        ["LoadDropdown","Right"] call ExileClient_MarXet_gui_load;
        ["LoadRight"] call ExileClient_MarXet_gui_load;
        ["LoadLeft"] call ExileClient_MarXet_gui_load;
        _rightDropdown = (_display displayCtrl 21016);
        _rightDropdown ctrlRemoveAllEventHandlers "LBSelChanged";
        _rightDropdown ctrlSetEventHandler ["LBSelChanged", "[""LoadRight""] call ExileClient_MarXet_gui_load;"];
        _rightLB = (_display displayCtrl 21017);
        _rightLB ctrlRemoveAllEventHandlers "LBSelChanged";
        _rightLB ctrlSetEventHandler ["LBSelChanged", "[""LoadCenter"",0,_this select 1] call ExileClient_MarXet_gui_load;"];
        _leftLB = (_display displayCtrl 21018);
        _leftLB ctrlRemoveAllEventHandlers "LBSelChanged";
        _leftLB ctrlSetEventHandler ["LBSelChanged", "[""LoadCenter"",1,_this select 1] call ExileClient_MarXet_gui_load;"];
        _leftDropdown = (_display displayCtrl 21019);
        _leftDropdown ctrlRemoveAllEventHandlers "LBSelChanged";
        _leftDropdown ctrlSetEventHandler ["LBSelChanged", "[""LoadLeft""] call ExileClient_MarXet_gui_load;"];
        _priceEditBox = (_display displayCtrl 21011);
        _priceEditBox ctrlRemoveAllEventHandlers "KeyUp";
        _priceEditBox ctrlSetEventHandler ["KeyUp","if ((count(ctrlText (_this select 0))) > 0) then {ctrlEnable [21024,true];}else{ctrlEnable [21024,false];};"];
        _purchaseBtn = _display displayCtrl 21014;
        _purchaseBtn ctrlEnable false;
        _priceEditBox ctrlEnable false;
        true call ExileClient_gui_postProcessing_toggleDialogBackgroundBlur;
        ctrlSetFocus (_display displayCtrl 21025);
    };
    case ("LoadRight"):
    {
        private ["_display","_dropdown","_dropdownOption","_location","_itemsLB"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        _dropdown = _display displayCtrl 21016;
        _dropdownOption = lbCurSel _dropdown;
        _location = _dropdown lbValue _dropdownOption;
        _itemsLB = (_display displayCtrl 21017);
        lbClear _itemsLB;
        switch (_location) do
        {
            case 0:
            {
                private ["_text","_ClassName","_listingID","_price","_configName","_name","_index"];
                {
                    ctrlShow [_x,false];
                }
                forEach [21020,21021,21022,21023];
                {
                    _text = "";
                    _ClassName = (_x select 2) select 0;
                    _listingID = _x select 0;
                    _price = _x select 3;
                    if ((_x select 1) isEqualTo 1) then
                    {
                        _configName = _ClassName call ExileClient_util_gear_getConfigNameByClassName;
                        if !(_configName isEqualTo "CfgVehicles") then
                        {
                            _name = getText(configFile >> _configName >> _ClassName >> "displayName");
                            _index = _itemsLB lbAdd _name;
                            _itemsLB lbSetPicture [_index, getText(configFile >> _configName >> _ClassName >> "picture")];
                            _itemsLB lbSetTextRight [_index, format["%1", _price]];
                	    	_itemsLB lbSetPictureRight [_index, "exile_assets\texture\ui\poptab_trader_ca.paa"];
                            if (ExileClientPlayerMoney < parseNumber(_price)) then
                            {
                                _itemLB lbSetColor [_index, [0.8,0,0,1]];
                            };
                            _text = format["%1:%2:%3:%4",_name,_price,_listingID,_ClassName];
                            _itemsLB lbSetData [_index,_text];
                        };
                    };
                } forEach MarXetInventory;
            };
            case 1:
            {
                private ["_text","_ClassName","_listingID","_price","_configName","_name","_index","_fuel","_health"];
                {
                    _text = "";
                    _ClassName = (_x select 2) select 0;
                    _listingID = _x select 0;
                    _price = _x select 3;
                    if ((_x select 1) isEqualTo 1) then
                    {
                        _configName = _ClassName call ExileClient_util_gear_getConfigNameByClassName;
                        if (_configName isEqualTo "CfgVehicles") then
                        {
                            _fuel = (_x select 2) select 1;
                            _health = (_x select 2) select 2;
                            _name = getText(configFile >> "CfgVehicles" >> _ClassName >> "displayName");
                            _index = _itemsLB lbAdd _name;
                            _itemsLB lbSetPicture [_index, getText(configFile >> "CfgVehicles" >> _ClassName >> "picture")];
                            _itemsLB lbSetTextRight [_index, format["%1", _price]];
                            _itemsLB lbSetPictureRight [_index, "exile_assets\texture\ui\poptab_trader_ca.paa"];
                            if (ExileClientPlayerMoney < parseNumber(_price)) then
                            {
                                _itemLB lbSetColor [_index, [0.8,0,0,1]];
                            };
                            _text = format["%1:%2:%3:%4:%5",_name,_price,_listingID,_health,_fuel];
                            _itemsLB lbSetData [_index,_text];
                        };
                    };
                } forEach MarXetInventory;
            };
        };
    };
    case ("LoadLeft"):
    {
        private ["_display","_playerMoney","_dropdown","_dropdownIndex","_location","_inventoryListBox","_items","_configName","_name","_index","_text"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        _playerMoney = _display displayCtrl 21025;
        _playerMoney ctrlSetStructuredText parseText format["<t valign='middle' align='right' size='0.9' shadow='0'>%1</t>",ExileClientPlayerMoney];
        _dropdown = _display displayCtrl 21019;
        _dropdownIndex = lbCurSel _dropdown;
        _location = _dropdown lbValue _dropdownIndex;
        _inventoryListBox = _display displayCtrl 21018;
        lbClear _inventoryListBox;
        _items = [];
        MarXet_VehicleObjectArray = [];
        switch (_location) do
        {
        	case 0:
        	{
        		_items = [player, true] call ExileClient_util_playerEquipment_list;
        	};
        	case 1:
        	{
        		_items = (uniformContainer player) call ExileClient_util_containerCargo_list;
        	};
        	case 2:
        	{
        		_items = (vestContainer player) call ExileClient_util_containerCargo_list;
        	};
        	case 3:
        	{
        		_items = (backpackContainer player) call ExileClient_util_containerCargo_list;
        	};
        	default
        	{
                private ["_nearVehicles","_name","_index","_text"];
                _nearVehicles = nearestObjects [player, ["LandVehicle", "Air", "Ship"], 50];
                {
                    if (((locked _x) != 2) && (locked _x) != 1) then
                    {
                        if (local _x) then
                        {
                            if (alive _x) then
                            {
                                _name = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
                                _index = _inventoryListBox lbAdd _name;
                                _inventoryListBox lbSetPicture [_index, getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")];
                                _text = format["%1:%2",(typeOf _x),_name];
                                _inventoryListBox lbSetData [_index,_text];
                                MarXet_VehicleObjectArray pushBack _x;
                            };
                        };
                    };
                } forEach _nearVehicles;
        	};
        };
        {
            _className = _x;
            _configName = _x call ExileClient_util_gear_getConfigNameByClassName;
            _name = getText(configFile >> _configName >> _x >> "displayName");
            _index = _inventoryListBox lbAdd _name;
            _inventoryListBox lbSetPicture [_index, getText(configFile >> _configName >> _x >> "picture")];
            _canList = true;
            if (_location isEqualTo 0) then
            {
                {
                    if (_className isEqualTo (_x select 0)) then
                    {
                        _items = (_x select 1) call ExileClient_util_containerCargo_list;
                        if !((count _items) isEqualTo 0) then
                        {
                            _canList = false;
                        };
                    };
                }
                forEach
                [
                    [uniform player, uniformContainer player],
                    [vest player, vestContainer player],
                    [backpack player, backpackContainer player]
                ];
            };
            if (_canList) then
            {
                _text = format["%1:%2",_x, _name];
                _inventoryListBox lbSetData [_index,_text];
            }
            else
            {
                _inventoryListBox lbSetData [_index,""];
            };
        } forEach _items;
        lbSetCurSel [_inventoryListBox,0];
    };
    case ("LoadCenter"):
    {
        private ["_display"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        _purchaseBtn = _display displayCtrl 21014;
        _purchaseBtn ctrlSetText "Purchase";
        switch (_this select 1) do
        {
            case 0:
            {
                private ["_rightLB","_priceEditBox","_dropdown","_dropdownOption","_location","_dataString","_dataArray","_purchaseBtn","_location","_health","_fuel","_healthText","_fuelText"];
                MarXet_SelectedListingID = "";
                _rightLB = (_display displayCtrl 21017);
                _priceEditBox = _display displayCtrl 21011;
                ctrlEnable [21011,false];
                _priceEditBox ctrlSetText "";
                _dropdown = _display displayCtrl 21016;
                _dropdownOption = lbCurSel _dropdown;
                _location = _dropdown lbValue _dropdownOption;
                ctrlEnable [21024,false];
                {
                    ctrlShow [_x,false];
                }
                forEach [21020,21021,21022,21023,21024];
                _dataString = lbData [21017,_this select 2];
                if !(_dataString isEqualTo "") then
                {
                    _dataArray = _dataString splitString ":";
                    _purchaseBtn = _display displayCtrl 21014;
                    _purchaseBtn ctrlShow true;
                    if (_location isEqualto 1) then
                    {
                        _health = parseNumber(_dataArray select 3);
                        _fuel = parseNumber(_dataArray select 4);
                        _health = round((1 - _health) * 100);
                        _fuel = round(_fuel * 100);
                        _healthText = format["%1%2",_health,"%"];
                        _fuelText = format["%1%2",_fuel,"%"];
                        ctrlSetText [21021,_healthText];
                        ctrlSetText [21023,_fuelText];
                        {
                            ctrlShow [_x,true];
                        }
                        forEach [21020,21021,21022,21023];
                    };
                    ctrlSetText [21009,_dataArray select 0];
                    ctrlSetText [21011,_dataArray select 1];
                    if (ExileClientPlayerMoney < parseNumber(_dataArray select 1)) then
                    {
                        ctrlEnable [21014,false];
                    }
                    else
                    {
                        if !(_location isEqualTo 1) then
                        {
                            _leftdropdown = _display displayCtrl 21019;
                            _leftdropdownOption = lbCurSel _leftdropdown;
                            _leftlocation = _leftdropdown lbValue _leftdropdownOption;
                            _itemClassName = _dataArray select 3;
                            try
                            {
                                switch (_leftlocation) do
                                {
                                    case 0: {
                                        if !([player,_itemClassName] call ExileClient_util_playerCargo_canAdd) then
                                        {
                                            throw 0;
                                        };
                                    };
                                    case 1:
                                    {
                                        if !(player canAddItemToUniform _itemClassName) then
                        				{
                        					throw 0;
                        				};
                                    };
                                    case 2:
                                    {
                                        if !(player canAddItemToVest _itemClassName) then
                        				{
                        					throw 0;
                        				};
                                    };
                                    case 3:
                                    {
                                        if !(player canAddItemToBackpack _itemClassName) then
                        				{
                        					throw 0;
                        				};
                                    };
                                };
                                _purchaseBtn ctrlSetText "Purchase";
                                ctrlEnable [21014,true];
                            }
                            catch
                            {
                                _purchaseBtn ctrlSetText "NO SPACE";
                                ctrlEnable [21014,false];
                            };
                        }
                        else
                        {
                            ctrlEnable [21014,true];
                        };
                    };
                    MarXet_SelectedListingID = _dataArray select 2;
                };
            };
            case 1:
            {
                private ["_leftLB","_priceEditBox","_dataString","_dataArray","_dropdown","_dropdownOption","_location","_purchaseBtn","_health","_fuel","_healthText","_fuelText"];
                MarXet_TempListingClassname = "";
                _leftLB = (_display displayCtrl 21018);
                {
                    ctrlShow [_x,false];
                }
                forEach [21020,21021,21022,21023,21012,21013,21014];
                _priceEditBox = _display displayCtrl 21011;
                ctrlEnable [21011,false];
                _priceEditBox ctrlSetText "";
                _dataString = _leftLB lbData (_this select 2);
                if !(_dataString isEqualTo "") then
                {
                    _dataArray = _dataString splitString ":";
                    _dropdown = _display displayCtrl 21019;
                    _dropdownOption = lbCurSel _dropdown;
                    _location = _dropdown lbValue _dropdownOption;
                    ctrlSetText [21009,_dataArray select 1];
                    ctrlEnable [21024,false];
                    ctrlEnable [21014,false];
                    ctrlEnable [21011,true];
                    _purchaseBtn = _display displayCtrl 21024;
                    _purchaseBtn ctrlShow true;
                    if (_location isEqualTo 4) then
                    {
                        MarXet_TempListingClassname = [_dataArray select 0,(netID (MarXet_VehicleObjectArray select (_this select 2)))];
                        _health = (1 - (damage (MarXet_VehicleObjectArray select (_this select 2)))) * 100;
                        _fuel = (fuel (MarXet_VehicleObjectArray select (_this select 2))) * 100;
                        _healthText = format["%1%2",round(_health),"%"];
                        _fuelText = format["%1%2",round(_fuel),"%"];
                        ctrlSetText [21021,_healthText];
                        ctrlSetText [21023,_fuelText];
                        {
                            ctrlShow [_x,true];
                        } forEach [21021,21023,21020,21022];
                    }
                    else
                    {
                        MarXet_TempListingClassname = [_dataArray select 0];
                    };
                }
                else
                {
                    _priceEditBox ctrlSetText "NOT EMPTY";
                };
            };
        };
    };
    case ("LoadDropdown"):
    {
        private ["_display"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        switch (_this select 1) do
        {
            case ("Left"):
            {
                private ["_leftDropdown","_index","_nearVehicles","_addVeh"];
                _leftDropdown = (_display displayCtrl 21019);
                lbClear _leftDropdown;
                _index = _leftDropdown lbAdd "Equipment";
                _leftDropdown lbSetValue [_index, 0];
                if !((uniform player) isEqualTo "") then
                {
                	_index = _leftDropdown lbAdd "Uniform";
                	_leftDropdown lbSetValue [_index, 1];
                };
                if !((vest player) isEqualTo "") then
                {
                	_index = _leftDropdown lbAdd "Vest";
                	_leftDropdown lbSetValue [_index, 2];
                };
                if !((backpack player) isEqualTo "") then
                {
                	_index = _leftDropdown lbAdd "Backpack";
                	_leftDropdown lbSetValue [_index, 3];
                };
                _nearVehicles = nearestObjects [player, ["LandVehicle", "Air", "Ship"], 50];
                if !(_nearVehicles isEqualTo []) then
                {
                    _addVeh = false;
                    {
                        if (((locked _x) != 2) && (locked _x) != 1) then
                        {
                            if (local _x) then
                            {
                                if (alive _x) then
                                {
                                    _addVeh = true;
                                };
                            };
                        };
                    } forEach _nearVehicles;
                    if (_addVeh) then
                    {
                        _index = _leftDropdown lbAdd "Nearby Vehicles";
                        _leftDropdown lbSetValue [_index, 4];
                    };
                };
                _leftDropdown lbSetCurSel -1;
            };
            case ("Right"):
            {
                private ["_rightDropdown","_index"];
                _rightDropdown = (_display displayCtrl 21016);
                lbClear _rightDropdown;
                _index = _rightDropdown lbAdd "Equipment Listings";
                _rightDropdown lbSetValue [_index,0];
                _index = _rightDropdown lbAdd "Vehicle Listings";
                _rightDropdown lbSetValue [_index,1];
                _rightDropdown lbSetCurSel 0;
            };
        };
    };
    case ("buttonPressed"):
    {
        private ["_display"];
        disableSerialization;
        _display = uiNamespace getVariable ["RscMarXetDialog",displayNull];
        switch (_this select 1) do
        {
            case 0:
            {
                private ["_dropdown","_dropdownIndex","_location"];
                ctrlEnable [21014,false];
                if !(MarXet_SelectedListingID isEqualTo "") then
                {
                    _dropdown = _display displayCtrl 21019;
                    _dropdownIndex = lbCurSel _dropdown;
                    _location = _dropdown lbValue _dropdownIndex;
                    ["buyNowRequest",[MarXet_SelectedListingID,_location]] call ExileClient_system_network_send;
                };
                MarXet_SelectedListingID = nil;
                ["LoadRight"] call ExileClient_MarXet_gui_load;
                ["LoadLeft"] call ExileClient_MarXet_gui_load;
            };
            case 1:
            {
                private ["_dropdown","_dropdownIndex","_location"];
                MarXet_ListingArray = [];
                ctrlEnable [21024,false];
                ctrlEnable [21011,false];
                _dropdown = _display displayCtrl 21019;
                _dropdownIndex = lbCurSel _dropdown;
                _location = _dropdown lbValue _dropdownIndex;
                if !(parseNumber(ctrlText 21011) isEqualTo 0) then
                {
                    if (count(MarXet_TempListingClassname) isEqualTo 1) then
                    {
                        MarXet_ListingArray = [MarXet_TempListingClassname select 0,str(abs(parseNumber(ctrlText 21011))),_location];
                    }
                    else
                    {
                        MarXet_ListingArray = [MarXet_TempListingClassname select 0,str(abs(parseNumber(ctrlText 21011))),_location,MarXet_TempListingClassname select 1];
                    };
                    ["createNewListingRequest",[MarXet_ListingArray]] call ExileClient_system_network_send;
                }
                else
                {
                    ["Whoops",["Please set a list price"]] call ExileClient_gui_notification_event_addNotification;
                };
                MarXet_ListingArray = nil;
            };
        };
    };
    case ("UnLoad"):
    {
        disableSerialization;
        MarXet_VehicleObjectArray = nil;
        MarXet_SelectedListingID = nil;
        MarXet_ListingArray = nil;
        MarXet_TempListingClassname = nil;
        false call ExileClient_gui_postProcessing_toggleDialogBackgroundBlur;
        closeDialog 21000;
    };
};
