import openfl.Lib;
 var customWindowX:Int = 320;   
var customWindowY:Int = 200;
function postCreate()
{
    positionWindowCentered();   
    Lib.application.window.resize(1280, 720); // change to your normal resolution
   
}
function positionWindowCentered()
{
    if (customWindowX != -1 && customWindowY != -1)
    {
        Lib.application.window.x = customWindowX;
        Lib.application.window.y = customWindowY;
    }
    else
    {
        var centerX = Std.int((Lib.application.window.screenWidth - 700) / 2);
        var centerY = Std.int((Lib.application.window.screenHeight - 700) / 2);
        Lib.application.window.x = centerX;
        Lib.application.window.y = centerY;
    }
}
//-mods/GenesisFaultFNF-main/data/credits.txt   (dont touch this pls)
//yes im copy and pasting my own code