static var redirectStates:Map<FlxState, String> = [
    MainMenuState => 'men/MainMenuState'
];

function preStateSwitch()
{
    for(redirectState in redirectStates.keys())
        if(Std.isOfType(FlxG.game._requestedState, redirectState))
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
    
}
