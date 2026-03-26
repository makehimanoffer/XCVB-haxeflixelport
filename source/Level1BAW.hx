package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Level1BAW extends BaseLevel
{
    override public function create():Void
    {
		// 1. Define the unique coordinates and map for Level 1
		mapData = Sources.Level1BAWImg;
		tileMapToUse = Sources.MapBAW;
		GoalToUse = Sources.ImgBAWGoal;
		_colorWheel = false;
		// Set the Grayscale colors here
		emitterColors = [0xFFFFFFFF, 0xFF888888, 0xFF444444, 0xFF000000];
		playerStartX = 50;
		playerStartY = 100;
		playerSpeed = 120;
        
		rainbowX = 288;
		rainbowY = 160;
        
		blankX = 288;
		blankY = 224;
        
		nextLevel = Level2BAW;

		// 2. Initialize the Base Engine
		super.create();

		// 3. Override BAW-specific assets
		// BaseLevel defaults to Rainbow; we swap them here for the BAW look
		background.loadGraphic(Sources.ImgBackgroundBAndW, true, 640, 480);
		background.animation.add("bla", [0, 1], 2, true);
        
		// Ensure the trail uses the BAW graphic instead of the Rainbow one
		trail.loadGraphic(Sources.trailBAW);
        
		// Hide the blank goal graphic if it's meant to be an invisible exit
		blankGoal.visible = false;
    }

    override public function update(elapsed:Float):Void
    {
		// We override update to handle the unique BAW trail logic
		super.update(elapsed);

		// If player is moving, use BAW trail; if not, use nothing
        if (player.velocity.x != 0 || player.velocity.y != 0) {
			trail.loadGraphic(Sources.trailBAW);
		}
		else
		{
			trail.loadGraphic(Sources.nothing);
        }

		// Note: BaseLevel already handles:
		// - FlxG.collide(player, map)
		// - Wall hit respawn at (50, 100)
		// - RainbowGoal particle burst
		// - BlankGoal level transition
		// - Pause menu updates
    }
}