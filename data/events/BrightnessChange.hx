import funkin.play.components.StrumLine;
import funkin.play.character.Character;

function onEvent(name:String, target:String, value:Float)
{
    if (name != "BrightnessChange") return;

    var char:Character = null;

    switch (target.toLowerCase())
    {
        case "dad":  char = game.dad;
        case "bf":   char = game.boyfriend;
        case "gf":   char = game.gf;
        default:
            // custom character name? attempt lookup
            char = Reflect.field(game, target);
    }

    if (char != null)
    {
        // brightness = multiply the sprite color
        // 1.0 = normal
        // 0.5 = darker
        // 2.0 = brighter
        char.color = FlxColor.fromRGBFloat(value, value, value);
    }
}
