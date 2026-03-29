package;

import flixel.FlxG;
import flixel.FlxSprite;

class Level1 extends BaseLevel
{
    override public function create():Void
    {
        // 1. Define the unique coordinates and map for Level 1
        mapData = Sources.Level1Red;
        tileMapToUse = Sources.Map;
        GoalToUse = Sources.ImgRainbowGoal; 
        
        _colorWheel = false;
        
        // Use the original rainbow colors listed in the AS3 file's Emitters
        emitterColors = [0xFFFF0000, 0xFFFF6A00, 0xFFFFD800, 0xFF007F0E, 0xFF0026FF];
        
        playerStartX = 50;
        playerStartY = 100;
        playerSpeed = 120;
        
        // Coordinates extracted from your original AS3 file
        rainbowX = 215;
        rainbowY = 448;
        
        blankX = 128;
        blankY = 448;
        
        // Modified per request to point to Credits instead of Level2
        nextLevel = Credits;

        // 2. Initialize the Base Engine
        super.create();
        
        // 3. Override standard assets specifically for the base game look
        background.loadGraphic(Sources.ImgBGAnimRainbow, true, 640, 480);
        background.animation.add("bla", [0, 1, 2, 3], 10, true);
        
        trail.loadGraphic(Sources.nothing);
        
        // Keep the blank exit hidden until rainbow goal is hit
        blankGoal.visible = false;
        
        // Medals can be unlocked here using the Haxe Newgrounds API if desired:
        // ng.NG.core.medals.unlock("COLORS!");
        // ng.NG.core.medals.unlock("Trippy Stuff");
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        // Custom trail logic to switch between standard rainbow trail and invisible
        if (player.velocity.x != 0 || player.velocity.y != 0) {
            trail.loadGraphic(Sources.trailRainbow);
        } else {
            trail.loadGraphic(Sources.nothing);
        }
    }
}