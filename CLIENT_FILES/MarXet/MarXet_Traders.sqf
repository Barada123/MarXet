/*
*
*  MarXet_Traders.sqf
*  Author: WolfkillArcadia
*  © 2016 Arcas Industries
*  This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
*  To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
*/
private["_traders","_trader"];
_traders = [];
switch (toLower worldName) do {
	case "altis":
    {
		//////////////////////////////////////////////////////////
        // 			Airport MarXet Trader
        //////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [14579.1,16755.5,0.126438],
            38.0894
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;

		//////////////////////////////////////////////////////////
        //			 West MarXet Trader
        //////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [2988.63,18152.7,0.381263],
            113.04
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;

		//////////////////////////////////////////////////////////
        // 			Northern MarXet Trader
        ////////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [23333.5,24202.9,0.00140905],
            332.571
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;

    };
    case "namalsk":
    {
		//////////////////////////////////////////////////////////
        // 			Sebjan Mine MarXet Trader
        //////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [5012.31,8011.31,4.12741],
            93.9074
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;

		//////////////////////////////////////////////////////////
		// 			Northern Boat MarXet Trader
		//////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [9131.12,10084.1,7.10316],
            208.937
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;

		//////////////////////////////////////////////////////////
		// 			Southern Boat MarXet Trader
		//////////////////////////////////////////////////////////
        _trader =
        [
            "Exile_Cutscene_Prisoner01",
            "GreekHead_A3_01",
            ["AidlPercMstpSnonWnonDnon_G01", "AidlPercMstpSnonWnonDnon_G02", "AidlPercMstpSnonWnonDnon_G03", "AidlPercMstpSnonWnonDnon_G04", "AidlPercMstpSnonWnonDnon_G05", "AidlPercMstpSnonWnonDnon_G06"],
            [4353.53,4743.87,0.00144696],
            50.5659
        ]
        call ExileClient_object_trader_create;

		_traders pushBack _trader;
    };
};

{
	_x forceAddUniform "U_BG_Guerilla2_1";
	_x addVest "Exile_Vest_Snow";
	_x addHeadgear "H_Watchcap_blk";
	_x addGoggles "G_Bandanna_aviator";
	_x addWeapon "srifle_DMR_04_F";
	_x addPrimaryWeaponItem "optic_LRPS";
	_x addWeapon "hgun_ACPC2_F";
	_x addAction ["<img image='\a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa' size='1' shadow='false' />Access MarXet","createDialog 'RscMarXetDialog'","",1,false,true,"","((position player) distance _target) <= 4"];
} forEach _traders;
