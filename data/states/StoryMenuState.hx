import openfl.Lib;
var customWindowX:Int = 640;   
var customWindowY:Int = 200;

function create()
{
     positionWindowCentered();   
    trace("Custom Desktop Main Menu Loaded.");

    originalWidth = Lib.application.window.width;
    originalHeight = Lib.application.window.height;

    Lib.application.window.resize(700, 700);
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
//yes im copy and pasting my own code