package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * BAWGoal class ported from ActionScript 3 to HaxeFlixel.
 * This represents the Black and White goal object in the game. 
 */
class BAWGoal extends FlxSprite
{
    // Porting the original variables from the AS3 version 
    public var xSpeed:Int = 200;
    public var ySpeed:Int = 200;

    /**
     * Constructor for the BAWGoal.
     * @param x Initial X position
     * @param y Initial Y position
     */
    public function new(x:Float = 0, y:Float = 0) 
    {
        super(x, y);

        // Uses the bridge from Sources.hx to point to the asset path 
        // loadGraphic(Asset, Animated, Width, Height)
        loadGraphic(Sources.ImgBAWGoal, true, 64, 64);
    }
    
    /**
     * Standard update loop for the goal.
     * @param elapsed Time since the last frame.
     */
    override public function update(elapsed:Float):Void
    {
        // Add any specific goal logic here if needed (e.g., rotation or scaling)
        super.update(elapsed);
    }
}