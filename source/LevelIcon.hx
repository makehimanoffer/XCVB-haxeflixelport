package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class LevelIcon extends FlxSprite
{
    private var _id:Int;
    private var _offsetPos:Float;
    private var _parent:LevelSelectScreen;

    public function new(Parent:LevelSelectScreen, Position:FlxPoint, Graphic:String, ID:Int)
    {
        // Position.x is the initial 'spacing' (0, 500, 1000, etc.)
        super(Position.x, Position.y);
        
        _parent = Parent;
        _id = ID;
        _offsetPos = Position.x;

        loadGraphic(Graphic);
    }

    override public function update(elapsed:Float):Void
    {
        // This is the "Magic": every icon moves based on the global _pos
        // plus its own unique offset in the array.
        this.x = LevelSelectScreen._pos + _offsetPos;

        // Visual feedback: Fade out icons that aren't the current selection
        // (Optional, but makes the slider look much more professional)
        var screenMid:Float = FlxG.width / 2 - (this.width / 2);
        var dist:Float = Math.abs(this.x - screenMid);
        
        if (dist < 100) {
            this.alpha = 1.0;
        } else {
            this.alpha = 0.4;
        }

        super.update(elapsed);
    }
}