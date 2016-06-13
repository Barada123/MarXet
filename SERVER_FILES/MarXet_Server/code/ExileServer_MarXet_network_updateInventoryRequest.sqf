/*
*
*  ExileServer_MarXet_network_updateInventoryRequest.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
[_this select 0,"updateInventoryResponse",[MarXetInventory]] call ExileServer_system_network_send_to;
true
