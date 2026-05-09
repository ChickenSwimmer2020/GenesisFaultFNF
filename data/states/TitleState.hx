import flixel.util.FlxTimer;

function create()
{
    // === TITLE SCREEN MUSIC (different from menu) ===
    // Change "titlemusic" to whatever your title song filename is (without .ogg)
    var titleMusicName:String = "title";   // ←←← CHANGE THIS TO YOUR SONG NAME

    if (FlxG.sound.music == null || FlxG.sound.music._soundName != titleMusicName)
    {
        FlxG.sound.playMusic(Paths.music(titleMusicName), 1, true);
    }
    else
    {
        // Music is already the correct title music → just resume and make sure it loops
        FlxG.sound.music.looped = true;
        FlxG.sound.music.play();
    }
  
    trace("Custom TitleState loaded with its own music: " + titleMusicName);
}
