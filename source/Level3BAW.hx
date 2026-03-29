package;

import flixel.FlxG;
import flixel.FlxSprite;

class Level3BAW extends BaseLevel
{
    override public function create():Void
    {
        // 1. Define the unique coordinates and map for Level 3
        mapData = Sources.L3BAW;
        tileMapToUse = Sources.MapBAW;
        GoalToUse = Sources.ImgBAWGoal;
        
        _colorWheel = false;
        emitterColors = [0xFFFFFFFF, 0xFF888888, 0xFF444444, 0xFF000000];
        
        playerStartX = 50;
        playerStartY = 100;
        
        // Coordinates extracted from your original Level 3 file
        rainbowX = 128;
        rainbowY = 256;
        
        blankX = 128;
        blankY = 306;
        
        nextLevel = Level4BAW;

        // 2. Initialize the Base Engine
        super.create();
        
        // 3. Override BAW-specific assets
        background.loadGraphic(Sources.ImgBGAnim, true, 640, 480);
        background.animation.add("bla", [0, 1], 2, true);
        
        trail.loadGraphic(Sources.nothing);
        
        // Keep the blank exit hidden until rainbow goal is hit
        blankGoal.visible = false;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        // Custom trail logic like Levels 1 and 2
        if (player.velocity.x != 0 || player.velocity.y != 0) {
            trail.loadGraphic(Sources.trailBAW);
        } else {
            trail.loadGraphic(Sources.nothing);
        }
    }
}