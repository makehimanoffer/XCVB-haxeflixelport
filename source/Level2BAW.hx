package;

import flixel.FlxG;
import flixel.FlxSprite;

class Level2BAW extends BaseLevel
{
    override public function create():Void
    {
        // 1. Define the unique coordinates and map for Level 2
        mapData = Sources.Level2BAWImg;
        tileMapToUse = Sources.MapBAW;
        GoalToUse = Sources.ImgBAWGoal;
        
        _colorWheel = false;
        emitterColors = [0xFFFFFFFF, 0xFF888888, 0xFF444444, 0xFF000000];
        
        playerStartX = 50;
        playerStartY = 100;
        
        rainbowX = 96;
        rainbowY = 192;
        
        blankX = 40;
        blankY = 192;
        
        nextLevel = Level3BAW;

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
        
        // Custom trail logic like Level 1
        if (player.velocity.x != 0 || player.velocity.y != 0) {
            trail.loadGraphic(Sources.trailBAW);
        } else {
            trail.loadGraphic(Sources.nothing);
        }
    }
}