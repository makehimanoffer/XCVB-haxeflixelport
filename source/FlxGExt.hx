package;

import flixel.FlxG;

class FlxGExt 
{
    // Explicitly tell Haxe this returns a PauseScreen object
    public static var paused(get, never):PauseScreen;
    
    private static inline function get_paused():PauseScreen 
    {
        return FlxGProxy.paused;
    }

    public static var showHud(get, set):Bool;
    private static inline function get_showHud():Bool return FlxGProxy.showHud;
    private static inline function set_showHud(v:Bool):Bool return FlxGProxy.showHud = v;
}