/*
*
*  ExileServer_MarXet_system_getPlayerObject.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_playerUID","_playerObject"];
_playerUID = _this;
_playerObject = "";
{
    if ((getPlayerUID _x) isEqualTo _playerUID) then
    {
        _playerObject = _x;
    };
} forEach allPlayers;
_playerObject
