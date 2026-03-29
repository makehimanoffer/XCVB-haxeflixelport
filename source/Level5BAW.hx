package;

import flixel.FlxG;
import flixel.FlxSprite;

class Level5BAW extends BaseLevel
{
    override public function create():Void
    {
        // 1. Define the unique coordinates and map for Level 5
        mapData = Sources.L5BAW;
        tileMapToUse = Sources.MapBAW;
        
        // In the AS3 file, it used a custom RainbowGoal object. 
        // We pass the sprite here to match BaseLevel's setup.
        GoalToUse = Sources.ImgRainbowGoal; 
        
        _colorWheel = false;
        emitterColors = [0xFFFFFFFF, 0xFF888888, 0xFF444444, 0xFF000000];
        
        playerStartX = 50;
        playerStartY = 50;
        
        // Coordinates extracted from your original AS3 file
        rainbowX = 128;
        rainbowY = 288;
        
        blankX = 32;
        blankY = 288;
        
        // AS3 version pointed to Level1 (presumably starting the main game)
        nextLevel = Level1;

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
        
        // Custom trail logic like previous levels
        if (player.velocity.x != 0 || player.velocity.y != 0) {
            trail.loadGraphic(Sources.trailBAW);
        } else {
            trail.loadGraphic(Sources.nothing);
        }
    }
}