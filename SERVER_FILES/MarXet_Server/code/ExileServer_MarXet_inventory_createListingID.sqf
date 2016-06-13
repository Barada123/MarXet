/*
*
*  ExileServer_MarXet_inventory_createListingID.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_numbers","_alpha","_listingID","_generatingListingID"];
_numbers = "1234567890";
_alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
_listingID = "";
_generatingListingID = true;
while {_generatingListingID} do
{
	_listingID = "";
	for "_i" from 1 to 2 do
	{
		_listingID = _listingID + (_alpha select [floor (random 51), 1]);
	};
    for "_i" from 1 to 6 do
	{
		_listingID = _listingID + (_numbers select [floor (random 9), 1]);
	};
	if (_listingID call ExileServer_MarXet_inventory_checkListingID) then
	{
		_generatingListingID = false;
	};
};
_listingID
