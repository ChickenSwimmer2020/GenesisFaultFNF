import openfl.Lib;
import funkin.options.OptionsMenu;
import haxe.io.Path;
import sys.FileSystem;
import openfl.display.BitmapData;
import Sys;

var tvBG:FlxSprite;
var noApp:FlxSprite;
var setApp:FlxSprite;
var exeApp:FlxSprite;

var mauser:FlxSprite;
var highlightBox:FlxSprite;

var selectedApp:FlxSprite = null;

var originalWidth:Int = 1280;
var originalHeight:Int = 720;

// window pos 
var customWindowX:Int = 640;   
var customWindowY:Int = 200;

final wallpaperPath:String = 'C:/Users/'+Sys.environment()["USERNAME"]+'/AppData/Roaming/Microsoft/Windows/Themes/TranscodedWallpaper';

function attemptToMakeDesktopBG():FlxSprite {
    trace('attempting to get Windows Desktop Background\nFrom: ' + wallpaperPath);
    if(FileSystem.exists(wallpaperPath)) {
        trace('got wallpaper!');
        var theBitmapData = BitmapData.fromFile(wallpaperPath);
        var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(theBitmapData);
        bg.setGraphicSize(350, 350);
        bg.updateHitbox();
        return bg;
    }else{
        return new FlxSprite(0, 0).makeGraphic(350, 350, 0xFF008080); //default if the wallpaper couldnt be found.
    }

    return null;
}

function create() {
    trace("Custom Desktop Main Menu Loaded.");


    originalWidth = Lib.application.window.width;
    originalHeight = Lib.application.window.height;

    Lib.application.window.resize(700, 700);
    positionWindowCentered();   

    FlxG.mouse.visible = false;

    // Background TV
    tvBG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/TVbg"));
    tvBG.screenCenter();
    tvBG.scale.set(2, 2);
    add(tvBG);

    var winBG:FlxSprite = attemptToMakeDesktopBG();
    if(winBG==null) {
        trace("Failed to get Windows Desktop Background");
    }else{
        add(winBG);
        winBG.screenCenter();
        winBG.setGraphicSize(winBG.width*1.618, winBG.height*1.6);
        winBG.x+=0.5;
        winBG.y+=4;

        winBG.shader = new CustomShader("desktop", 330);
    }


    exeApp = createApp("exeApp", 400, 180, 2.0);
    setApp = createApp("setApp", 600, 120, 2.0);
    noApp  = createApp("noApp",  550, 300, 2.0);

    highlightBox = new FlxSprite().makeGraphic(160, 120, 0x44FFFFFF);
    highlightBox.visible = false;
    add(highlightBox);

    mauser = new FlxSprite();
    mauser.frames = Paths.getSparrowAtlas("mauser");
    mauser.animation.addByPrefix("idle", "idle", 12, true);
    mauser.animation.addByPrefix("click", "click", 24, false);
    mauser.animation.play("idle");
    mauser.scale.set(0.7, 0.7);
    mauser.updateHitbox();
    add(mauser);

    if (FlxG.sound.music == null || FlxG.sound.music._soundName != "menumu")
        FlxG.sound.playMusic(Paths.music("menumu"), 1, true);
}

function createApp(name:String, x:Float, y:Float, scale:Float):FlxSprite
{
    var app = new FlxSprite(x, y);
    app.loadGraphic(Paths.image("MENUSCREEN/" + name));
    app.scale.set(scale, scale);
    app.updateHitbox();
    add(app);
    return app;
}

// added to make sure it keeps size kinda forgot if it does anything
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

function update(elapsed:Float)
{
    mauser.x = FlxG.mouse.x - 10;
    mauser.y = FlxG.mouse.y - 5;

    if (FlxG.mouse.justPressed)
    {
        mauser.animation.play("click", true);
        mauser.animation.finishCallback = (_) -> mauser.animation.play("idle");
        checkAppClick();
    }

    if (FlxG.keys.justPressed.Y)
        FlxG.switchState(new FreeplayState());

    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new TitleState());
}

function checkAppClick()
{
    var apps:Array<FlxSprite> = [exeApp, setApp, noApp];

    for (app in apps)
    {
        if (FlxG.mouse.overlaps(app))
        {
            highlightBox.setPosition(app.x - 15, app.y - 15);
            highlightBox.setGraphicSize(Std.int(app.width + 30), Std.int(app.height + 30));
            highlightBox.updateHitbox();
            highlightBox.visible = true;

            if (selectedApp == app)
            {
                openApp(app);
                selectedApp = null;
                highlightBox.visible = false;
            }
            else
            {
                selectedApp = app;
                new FlxTimer().start(0.35, (_) -> if (selectedApp == app) selectedApp = null);
            }
            return;
        }
    }
}

function openApp(app:FlxSprite)
{
    if (app == exeApp)
        FlxG.switchState(new StoryMenuState());
    else if (app == setApp)
        FlxG.switchState(new OptionsMenu());
    else if (app == noApp) {
        var modspath:String = StringTools.replace(Paths.getAssetsRoot(), ".", "");
        var creditsPath:String = Sys.getCwd() + (modspath.substr(1, modspath.length-1)) + '/data/credits.txt'; //this sould work hopefully for everybody.
        Sys.command('notepad.exe "' + creditsPath + '"');
    }
}

function onDestroy()
{
    Lib.application.window.resize(originalWidth, originalHeight);
}