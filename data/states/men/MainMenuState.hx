import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;
import states.StoryMenuState;
import flixel.util.FlxTimer;

var tvButton:FlxSprite;
var creditsButton:FlxSprite;
var settingsButton:FlxSprite;
var freeplayButton:FlxSprite;
var backBG:FlxSprite;
var tableBG:FlxSprite;
var midBG:FlxSprite;
var shadeFG:FlxSprite;

var buttons:Array<FlxSprite> = [];
var lastIndex:Int = -1;
var mauser:FlxSprite;
var curIndex:Int = 0;

// New button positions
var TV_X:Float = 360;
var TV_Y:Float = 0;

var CREDITS_X:Float = 100;
var CREDITS_Y:Float = 0;


 var SETTINGS_X:Float = 0;
 var SETTINGS_Y:Float = 390;

 var FREEPLAY_X:Float = 925;
 var FREEPLAY_Y:Float = 230;


function create()
{
    trace("Custom Main Menu Loaded.");
    FlxG.mouse.visible = true;

    if (FlxG.sound.music == null || FlxG.sound.music._soundName != "menumu")
        FlxG.sound.playMusic(Paths.music("menumu"), 1);
// BACK LAYER (very back)
backBG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/back"));
backBG.scrollFactor.set(0, 0); // no parallax unless you want
// MOVE IT HERE
backBG.setPosition(0, 0); // ← change these numbers
// SCALE IT (optional)
backBG.scale.set(1, 1);
backBG.updateHitbox();
add(backBG);

// BG LAYER ABOVE TABLE
midBG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/bg"));
midBG.scrollFactor.set(0, 0);
midBG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/bg"));
midBG.scrollFactor.set(0, 400);
midBG.setPosition(0, 0);
midBG.scale.set(1, 1);
midBG.updateHitbox();
add(midBG);

// TABLE LAYER (middle)
tableBG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/table"));
tableBG.scrollFactor.set(0, 0);
tableBG.setPosition(0, 350);
tableBG.scale.set(1, 1);
tableBG.updateHitbox();
add(tableBG);

    // -------------------------
    // TV BUTTON  (replaces START)
    // -------------------------
    tvButton = new FlxSprite(450, 70);
    tvButton.frames = Paths.getSparrowAtlas("MENUSCREEN/TVplaybut");
    tvButton.animation.addByPrefix("idle", "idle", 24);
    tvButton.animation.addByPrefix("hover", "hover_idle", 24);
    tvButton.animation.addByPrefix("selected", "selected", 24, false);
    tvButton.animation.play("hover"); // default selected
    tvButton.scale.set(1, 1);
    tvButton.updateHitbox();
    tvButton.ID = 0;
    add(tvButton);

    // -------------------------
    // CREDITS BUTTON (replaces CREDIT BUTTON)
    // -------------------------
    creditsButton = new FlxSprite(CREDITS_X, CREDITS_Y);
    creditsButton.frames = Paths.getSparrowAtlas("MENUSCREEN/creditsbu");
    creditsButton.animation.addByPrefix("idle", "idle", 24);
    creditsButton.animation.addByPrefix("hover", "hover", 24);
    creditsButton.animation.play("idle");
    creditsButton.scale.set(1, 1);
    creditsButton.updateHitbox();
    creditsButton.ID = 1;
    add(creditsButton);

 // -------------------------
// SETTINGS BUTTON
// -------------------------
settingsButton = new FlxSprite(SETTINGS_X, SETTINGS_Y);
settingsButton.frames = Paths.getSparrowAtlas("MENUSCREEN/setttingsbut");
settingsButton.animation.addByPrefix("idle", "idle", 24);
settingsButton.animation.addByPrefix("hover", "hover", 24);
settingsButton.animation.play("idle");
settingsButton.scale.set(1, 1);
settingsButton.updateHitbox();
settingsButton.ID = 2;
add(settingsButton);

// -------------------------
// FREEPLAY BUTTON
// -------------------------
freeplayButton = new FlxSprite(FREEPLAY_X, FREEPLAY_Y);
freeplayButton.frames = Paths.getSparrowAtlas("MENUSCREEN/freeplaybu");
freeplayButton.animation.addByPrefix("idle", "idle", 24);
freeplayButton.animation.addByPrefix("hover", "hover", 24);
freeplayButton.animation.play("idle");
freeplayButton.scale.set(1, 1);
freeplayButton.updateHitbox();
freeplayButton.ID = 3;
add(freeplayButton);


    // ADD TO ARRAY
    buttons = [tvButton, creditsButton, settingsButton, freeplayButton];


    // ---------------------------------
    // CUSTOM CURSOR (unchanged, old working)
    // ---------------------------------
    mauser = new FlxSprite();
    mauser.frames = Paths.getSparrowAtlas("mauser");
    mauser.animation.addByPrefix("idle", "idle", 12, true);
    mauser.animation.addByPrefix("click", "click", 24, false);
    mauser.animation.play("idle");
    mauser.scale.set(0.7, 0.7);
    mauser.updateHitbox();
    add(mauser);

    FlxG.mouse.visible = false;
    
    // SHADE (very front)
shadeFG = new FlxSprite().loadGraphic(Paths.image("MENUSCREEN/shade"));
shadeFG.scrollFactor.set(0, 0);
shadeFG.setPosition(-25,0);
shadeFG.scale.set(1, 1);
shadeFG.updateHitbox();
add(shadeFG);

}

function update(elapsed:Float)
{
    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new TitleState());

    // KEYBOARD SELECTION
    if (FlxG.keys.justPressed.RIGHT)
    {
        curIndex++;
        if (curIndex > buttons.length - 1) curIndex = buttons.length - 1;
        updateSelection();
    }
    if (FlxG.keys.justPressed.LEFT)
    {
        curIndex--;
        if (curIndex < 0) curIndex = 0;
        updateSelection();
    }

    // MOUSE SUPPORT (OLD WORKING)
    for (b in buttons)
    {
        if (FlxG.mouse.overlaps(b))
        {
            if (curIndex != b.ID)
            {
                curIndex = b.ID;
                updateSelection();
            }
            if (FlxG.mouse.justPressed)
                confirmSelection();
        }
    }

    if (FlxG.keys.justPressed.ENTER)
        confirmSelection();

    if (controls.SWITCHMOD)
    {
        persistentUpdate = !(persistentDraw = true);
        openSubState(new ModSwitchMenu());
    }

    if (FlxG.keys.justPressed.SEVEN)
    {
        persistentUpdate = !(persistentDraw = true);
        openSubState(new EditorPicker());
    }

    // CUSTOM CURSOR FOLLOW
    mauser.x = FlxG.mouse.x;
    mauser.y = FlxG.mouse.y;

    if (FlxG.mouse.justPressed)
    {
        mauser.animation.play("click", true);
        mauser.animation.finishCallback = (_) -> mauser.animation.play("idle");
    }
}

function updateSelection()
{
    if (curIndex != lastIndex)
    {
        FlxG.sound.play(Paths.sound("scroll"));
        lastIndex = curIndex;
    }

    for (b in buttons)
    {
        if (b.ID == curIndex)
        {
            b.animation.play("hover");
            FlxTween.tween(b.scale, {x: 1.05, y: 1.05}, 0.12, {
                onComplete: (_) -> FlxTween.tween(b.scale, {x: 1, y: 1}, 0.12)
            });
        }
        else
        {
            b.animation.play("idle");
            b.scale.set(1, 1);
        }
    }
}

import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

function confirmSelection()
{
    FlxG.sound.play(Paths.sound("confirm"));

    switch (curIndex)
    {
        case 0:  // TV Button → Story Mode with zoom out → zoom in transition
            // Hide and lock mouse immediately when TV is clicked
            FlxG.mouse.visible = false;

            tvButton.animation.play("selected");

            var anim = tvButton.animation.curAnim;
            var frameRate = anim.frameRate > 0 ? anim.frameRate : 24;
            var animDuration = anim.frames.length / frameRate;

            new FlxTimer().start(animDuration + 0.03, function(_) {
                startCameraZoomSequence();
            });

        case 1:
            FlxG.switchState(new CreditsMain());
        case 2:
            FlxG.switchState(new OptionsMenu());
        case 3:
            FlxG.switchState(new FreeplayState());
    }
}

function startCameraZoomSequence()
{
    FlxG.camera.follow(tvButton, null, 0.08);
    FlxG.camera.snapToTarget();

    // Phase 1: Slow zoom OUT
    FlxTween.tween(FlxG.camera, {zoom: 0.75}, 1.2, {  // zoom out to 0.75x
        ease: FlxEase.quadOut,   // smooth slow zoom out
        onComplete: function(_) {
            // Phase 2: Fast zoom IN with acceleration
            FlxTween.tween(FlxG.camera, {zoom: 2.8}, 0.36, {  // fast zoom in
                ease: FlxEase.cubeIn,     // starts somewhat normal then gets FAST
                onUpdate: function(_) {
                    FlxG.camera.follow(tvButton, null, 0.15);
                },
                onComplete: function(_) {
                    FlxG.switchState(new StoryMenuState());
                }
            });
        }
    });
}