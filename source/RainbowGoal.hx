package;

import flixel.FlxSprite;

class RainbowGoal extends FlxSprite
{
    public function new(X:Float = 0, Y:Float = 0) 
    {
        // Call parent constructor with position
        super(X, Y);

        // Load graphic. Dimensions are 64x64 based on the AS3 source.
        // We set animated to true and unique to true.
        loadGraphic(Sources.ImgRainbowGoal, true, 64, 64);
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}