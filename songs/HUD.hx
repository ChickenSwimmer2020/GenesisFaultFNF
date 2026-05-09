import Int;
import flixel.math.FlxRect; 
var barBack:FlxSprite;   // bottom layer
var barFill:FlxSprite;   // middle layer
var barBase:FlxSprite;   // top frame layer
var fakeIconP2:HealthIcon;

var betterCam:FlxCamera;
function destroy() {
    FlxG.cameras.remove(betterCam);
}
function postCreate() {
    betterCam = new FlxCamera(0, 0, camHUD.width, camHUD.height, camHUD.zoom);
    betterCam.bgColor=0x00FFFFFF;
    FlxG.cameras.add(betterCam, false);

    healthBarBG.visible=healthBar.visible=iconP1.visible=iconP2.visible=false;

    barBack = new FlxSprite(180, 595).loadGraphic(Paths.image('hpbar/back'));
    barBack.scale.set(0.6, 0.6);
    barBack.updateHitbox();
    barBack.camera=betterCam;
    insert(members.indexOf(scoreTxt)-5, barBack); //ON-TOP OF DA STRUMS!!

    barFill = new FlxSprite(200, 595).loadGraphic(Paths.image("hpbar/fill"));
    barFill.scale.set(0.6, 0.6);
    barFill.updateHitbox();
    barFill.camera = betterCam;
    insert(members.indexOf(barBack)+1, barFill);

    barBase = new FlxSprite(15, 500).loadGraphic(Paths.image('hpbar/base'));
    barBase.scale.set(0.6, 0.6);
    barBase.updateHitbox();
    barBase.camera = betterCam;
    insert(members.indexOf(barFill)+1, barBase);

    scoreTxt.x-=180;
    scoreTxt.alignment="LEFT";

    scoreTxt.camera=accuracyTxt.camera=missesTxt.camera=betterCam;

    accuracyTxt.angle=15;
    accuracyTxt.x -= 135;
    accuracyTxt.y-=29;

    missesTxt.x-=150;

    fakeIconP2 = FunkinSprite.copyFrom(iconP2);
    insert(members.indexOf(barBase)+1, fakeIconP2);
    fakeIconP2.visible=true;
    fakeIconP2.camera = betterCam;
    fakeIconP2.setPosition(70, fakeIconP2.y-20);
    //fakeIconP2.sprTracker = null;
}

function beatHit(curBeat:Int) {
    var iconScale = Flags.BOP_ICON_SCALE/1.1;
    fakeIconP2.scale.set((Flags.ICON_DEFAULT_SCALE/1.4) * iconScale, (Flags.ICON_DEFAULT_SCALE/1.4) * iconScale);
    fakeIconP2.updateHitbox();
}

function update(elapsed:Float){
    betterCam.zoom = camHUD.zoom;
    var iconLerp = Flags.ICON_LERP;
    fakeIconP2.scale.set(CoolUtil.fpsLerp(fakeIconP2.scale.x, (Flags.ICON_DEFAULT_SCALE/1.4), iconLerp), CoolUtil.fpsLerp(fakeIconP2.scale.y, (Flags.ICON_DEFAULT_SCALE/1.4), iconLerp));
    fakeIconP2.updateHitbox();
    barFill!=null?updateHPBar():null;
}

function updateHPBar() {
    var percent:Float = health / maxHealth;   
    if (barFill.clipRect == null) {
        barFill.clipRect = new FlxRect(0, 0, barFill.frameWidth, barFill.frameHeight);
    }
    barFill.clipRect.width = barFill.frameWidth * percent;
    barFill.clipRect.height = barFill.frameHeight;
    barFill.clipRect = barFill.clipRect;
}