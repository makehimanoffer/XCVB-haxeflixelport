package;

import flixel.FlxG;

/**
 * Rules.hx
 * Handles the singleton Player instance and global game state.
 */
class Rules 
{
    private static var _instanceRules:Rules;
    private static var _player:Player;

    // These link to the Proxy for the Pause logic
    public static var pause:PauseScreen;
    public static var showHud:Bool = false;

    public function new() {}

    /**
     * Singleton for the Rules class itself
     */
    public static function getInstanceRules():Rules 
    {
        if (_instanceRules == null) {
            _instanceRules = new Rules();
        }
        return _instanceRules;
    }

    /**
     * Singleton for the Player. 
     * This is what Level1BAW calls.
     */
    public static function getInstancePlayer():Player 
    {
        if (_player == null) {
            _player = new Player();
        }
        return _player;
    }

    /**
     * Global update logic (called from Level states)
     */
    public function update():Void 
    {
        // Toggle Pause logic using the Proxy
        if (FlxG.keys.justPressed.P) 
        {
            FlxGProxy.setPaused(!FlxGProxy.isPaused);
        }

        // Handle Fullscreen
        if (FlxG.keys.justPressed.F) 
        {
            FlxG.fullscreen = !FlxG.fullscreen;
        }
    }
    // Inside Rules.hx
public static function resetPause():Void
{
    // Access your global pause variable/proxy and set it to false
    FlxGProxy.isPaused = false; 
}
}