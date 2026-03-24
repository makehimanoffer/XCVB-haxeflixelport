package;

import flixel.FlxG;

/**
 * FlxGProxy.hx
 * This class mimics the "modded" fields from your original FlxG.as template.
 * Since your Haxe FlxG.hx is missing the 'paused' field, we store it here.
 */
class FlxGProxy 
{
    /**
     * Stores the instance of the PauseScreen. 
     * This allows Level1BAW to call FlxG.paused.colorVal (via the Extension).
     */
    public static var paused:PauseScreen;

    /**
     * Replaces the missing global boolean for game pause state.
     */
    public static var isPaused:Bool = false;

    /**
     * Replaces the missing showHud field from the original template.
     */
    public static var showHud:Bool = false;

    /**
     * Handles the actual pausing logic.
     * Call this instead of setting FlxG.paused directly.
     */
    public static function setPaused(value:Bool):Void 
    {
        isPaused = value;
        
        // Since your FlxG.hx doesn't have a built-in pause toggle,
        // we stop time to freeze the player, map animations, and physics.
        FlxG.timeScale = value ? 0 : 1;

        // Toggle visibility of the Pause UI elements automatically
        if (paused != null) 
        {
            paused.visible = value;
            if (paused.textBlock != null) 
            {
                paused.textBlock.visible = value;
            }
        }
    }
}