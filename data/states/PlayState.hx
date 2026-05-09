import flixel.util.FlxTimer;
import flixel.math.FlxRect; 
var barBack:FlxSprite;   // bottom layer
var barFill:FlxSprite;   // middle layer
var barBase:FlxSprite;   // top frame layer

function postCreate()
{
    new FlxTimer().start(0.02, function(_) {

        // bey bye og hp bar
        if (healthBarBG != null) remove(healthBarBG);
        if (healthBar != null) remove(healthBar);

        // Icons: hide player, keep opponent
        if (iconP1 != null) iconP1.visible = false;
        if (iconP2 != null) iconP2.visible = true;

        // the backpart
        barBack = new FlxSprite();
        barBack.cameras = [camHUD];
        barBack.antialiasing = true;
        barBack.loadGraphic(Paths.image("hpbar/back"));
        barBack.setPosition(180, 595);        // pos
        barBack.scale.set(0.60, 0.60);           // size
        barBack.updateHitbox();
        add(barBack);

        // middle fill thingy
        barFill = new FlxSprite();
        barFill.cameras = [camHUD];
        barFill.antialiasing = true;
        barFill.loadGraphic(Paths.image("hpbar/fill"));
        barFill.setPosition(205, 595);  
        barFill.scale.set(0.60, 0.60);               
        barFill.updateHitbox();
        add(barFill);

        // the base (top)
        barBase = new FlxSprite();
        barBase.cameras = [camHUD];
        barBase.antialiasing = true;
        barBase.loadGraphic(Paths.image("hpbar/base"));
        barBase.setPosition(15, 500);   
        barBase.scale.set(0.6, 0.6);                 
        barBase.updateHitbox();
        add(barBase);

        trace("gotta add a fucking trace ppls work");
    });
}

function update(elapsed:Float)
{
    super.update(elapsed);
    if (barFill != null) updateHPBar();
}

function updateHPBar()
{
    
    var percent:Float = health / maxHealth;

   
    if (barFill.clipRect == null) {
        barFill.clipRect = new FlxRect(0, 0, barFill.frameWidth, barFill.frameHeight);
    }

    barFill.clipRect.width = barFill.frameWidth * percent;
    barFill.clipRect.height = barFill.frameHeight;

   
    barFill.clipRect = barFill.clipRect;
}



