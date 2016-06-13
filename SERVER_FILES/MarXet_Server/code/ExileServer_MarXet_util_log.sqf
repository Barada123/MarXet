/*
*
*  ExileServer_MarXet_util_log.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_msg"];
_msg = format["MarXet: [%2] : %1",(_this select 0),(_this select 1)];
diag_log _msg;
