![logo](http://puu.sh/pp1ty/864b4d13b2.jpg)
# Welcome to MarXet!
##### Exile's Leading Inmate Based Marketplace

MarXet is a server/client script made for Exile to provide a unique and dynamic player based market. Players can create new "listings" for any item or persistent vehicle in game with it's own price. Other players can then purchase any item/vehicle from MarXet.

#### Features
* Dynamic, player based marketplace
* Built using Exile's Security
* Sell any item or any persistent vehicles
* Accessible via placed MarXet Traders
* GUI built to match Exile's GUI theme
* Persistent , saves to the database

#### Installation
Installation is simple and easy with only one Exile overwrite.

#### extDB
1. Copy `MarXet-SQL.sql` into your favorite mySQL viewer's query window and run it.
2. Confirm you have a `marxet` table.
3. Copy the contents of `MarXet-extDB.ini` into your `@ExileServer\extDB\sql_custom_v2\exile.ini` file at the bottom.

##### Server
1. Copy `ExileServer_system_network_dispatchIncomingMessage.sqf` from `MarXet\SERVER_FILES\exile_server\code` into your `@ExileServer\addons\exile_server\code` folder and replace the existing one.
    1. This allows MarXet to send network messages to the server. If you run Advanced Banking, Virtual Garage or Most Wanted, you won't need to copy this file over as you already have it. :)
2. PBO `MarXet_Server` in `SERVER_FILES` and copy that to your `@ExileServer\addons` folder.

##### Client
1. Copy `MarXet` from `CLIENT_FILES` into the root of your exile.MAPNAME folder.
2. In either `init.sqf` or `initPlayerLocal.sqf`, add `[] execVM "MarXet\MarXet_Init.sqf";`
3. `CfgHints.hpp` and `CfgNetworkMessages.hpp` both will depend on your set up.
    1. If you **ALREADY** have `class CfgHints` or `class CfgNetworkMessages` **ANYWHERE** in your `description.ext` or `config.cpp` in your exile.MAPNAME folder:
        1. Add `#include "MarXet\CfgMarXetNetworkMessages.hpp` to `class CfgNetworkMessages`
        2. Add `#include "MarXet\CfgMarXetHints.hpp` to `class CfgHints`
        3. It should look something like what is below.
    2. If you don't have `class CfgHints` or `class CfgNetworkMessages`, in your `config.cpp`, add this anywhere.

               class CfgHints
               {
                    #include "MarXet\CfgMarXetHints.hpp"
               };
               class CfgNetworkMessages
               {
                    #include "MarXet\CfgMarXetNetworkMessages.hpp"
               };

4. In your `description.ext` add the following:

        #include "MarXet\dialog\RscMarXetDefines.hpp"
        #include "MarXet\dialog\RscMarXetDialog.hpp"
5. You are done! Head on down to configuration.


#### Configuration
MarXet has very little configuration. However, it does have custom traders. Located in `MarXet\` in your `exile.MAPNAME` mission folder, there is a file called `MarXet_Traders.sqf`. The trader setup code is like Exile's, except instead of a setVariable, they have a pushBack. Feel free to add, or remove, or configure as much as you want.
