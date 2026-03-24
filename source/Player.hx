package;

import flixel.FlxG;
import flixel.FlxSprite;

using FlxGExt;

class Player extends FlxSprite
{
    private var xSpeed:Int = 90;
    private var ySpeed:Int = 90;

    public function new(x:Float = 0, y:Float = 0) 
    {
        super(x, y);
        
        loadGraphic(Sources.ImgPlayer, true, 24, 23);
        
        animation.add("DownAndRight", [1]);
        animation.add("DownAndLeft", [0]);
        animation.add("UpAndRight", [3]);
        animation.add("UpAndLeft", [2]);
    }

    override public function update(elapsed:Float):Void
    {
        if (!FlxGProxy.isPaused)
        {
            updatePlayerAnimation(); // Renamed to avoid override conflict
            handleInput();
        }
        else 
        {
            velocity.set(0, 0);
        }
        
        super.update(elapsed);
    }

    // Renamed from updateAnimation to updatePlayerAnimation
    private function updatePlayerAnimation():Void
    {
        if (xSpeed > 0 && ySpeed > 0) {
            animation.play("DownAndRight");
        }
        else if (xSpeed < 0 && ySpeed > 0) {
            animation.play("DownAndLeft");
        }
        else if (xSpeed < 0 && ySpeed < 0) {
            animation.play("UpAndLeft");
        }
        else if (xSpeed > 0 && ySpeed < 0) {
            animation.play("UpAndRight");
        }
    }

    private function handleInput():Void
    {
        if (FlxG.keys.justPressed.B) 
        {
            velocity.x = xSpeed;
            velocity.y = 0;
            FlxG.sound.play(Sources.Switch);
        }
        
        if (FlxG.keys.justPressed.V) 
        {
            velocity.y = ySpeed;
            velocity.x = 0;
            FlxG.sound.play(Sources.Switch);
        }

        if (FlxG.keys.justPressed.C) 
        {
            xSpeed *= -1;
            FlxG.sound.play(Sources.Switch);
        }

        if (FlxG.keys.justPressed.X) 
        {
            ySpeed *= -1;
            FlxG.sound.play(Sources.Switch);
        }
    }
}