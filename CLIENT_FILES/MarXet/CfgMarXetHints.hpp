class MarXet
{
    // Topic title (displayed only in topic listbox in Field Manual)
    displayName = "MarXet";

    class NewListing
    {
        displayName = "MarXet";
        description = "<t size='2' align='center' valign='middle'>%3It's been listed!%4</t>%1You have successfully listed your <t color='#ff0000'>%11</t> for <t color='#ff0000'>%12</t> poptabs on Mar<t color='#531517'>X</t>et.%1If one of our proud customers purchases your listing while you are online, you will be notified just like this.%1If you happen to be away at time of purchase, we will securely deposit your payment in to your account.%1Thank you for using Mar<t color='#531517'>X</t>et: Exile's leading marketplace!";
        image = "";
        noImage = true;
        tip = "";
        arguments[] = {
            "MarXet_Hint_ItemName",
            "MarXet_Hint_Poptabs"
        };
    };

    class VehicleBought
    {
        displayName = "MarXet";
        description = "<t size='2' align='center' valign='middle'>%3Vehicle Bought!%4</t>%1Congratulations on your purchase of your new <t color='#ff0000'>%11</t>%1Your total cost was <t color='#ff0000'>%12</t> poptabs and your pincode for your vehicle is <t color='#ff0000'>%13</t>%1Thank you for choosing Mar<t color='#531517'>X</t>et: Exile's leading marketplace!";
        image = "";
        noImage = true;
        tip = "";
        arguments[] = {
            "MarXet_Hint_ItemName",
            "MarXet_Hint_Poptabs",
            "MarXet_Hint_Pincode"
        };
    };

    class Sold
    {
        displayName = "MarXet";
        description = "<t size='2' align='center' valign='middle'>%3Item Sold!%4</t>%1A fellow inmate has purchased your <t color='#ff0000'>%11</t> that you had listed on Mar<t color='#531517'>X</t>et.%1<t color='#ff0000'>%12</t> poptabs has been deposited in your account%1Thank you for using Mar<t color='#531517'>X</t>et: Exile's leading marketplace!";
        image = "";
        noImage = true;
        tip = "";
        arguments[] = {
            "MarXet_Hint_ItemName",
            "MarXet_Hint_Poptabs"
        };
    };
    class VehicleBoughtSeller
    {
        displayName = "MarXet";
        description = "<t size='2' align='center' valign='middle'>%3Vehicle Bought!%4</t>%1Congratulations on your purchase of your old <t color='#ff0000'>%11</t>. Couldn't let go of it huh?%1This transaction didn't cost you anything and your pincode for your vehicle is <t color='#ff0000'>%12</t>%1Thank you for choosing Mar<t color='#531517'>X</t>et: Exile's leading marketplace!";
        image = "";
        noImage = true;
        tip = "";
        arguments[] = {
            "MarXet_Hint_ItemName",
            "MarXet_Hint_Pincode"
        };
    };
};
