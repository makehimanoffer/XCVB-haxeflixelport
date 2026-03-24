package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

using FlxGExt;
// Required for the custom FlxG extension shortcuts

class Level2BAW extends FlxState
{
    private var map:FlxTilemap;
    private var player:Player;
    private var rainbowGoal:BAWGoal;
    private var blankGoal:FlxSprite;
    private var background:FlxSprite;
    private var trail:FlxTrail;
    
    public var pause:PauseScreen;

    override public function create():Void
{
    // 1. Initialize the Pause Screen instance
    pause = new PauseScreen();
    
    // 2. Link it to the Proxy immediately
    FlxGProxy.paused = pause;

    // 3. Set the color directly via the Proxy
    FlxGProxy.paused.colorVal = 0xffffff;

    // 4. Setup Background
    background = new FlxSprite(0, 0);
    background.loadGraphic(Sources.ImgBGAnim, true, 640, 480);
    background.animation.add("bla", [0, 1], 2, true);
    add(background);

    // 5. Setup Tilemap (Using Level 2 specific asset from source)
    map = new FlxTilemap();
    // The original source uses Sources.L2BAW for the map image 
    map.loadMapFromCSV(Sources.Level2BAWImg, Sources.MapBAW, 32, 32);
    add(map);

    // 6. Setup Player
    player = Rules.getInstancePlayer();
    player.x = 50; // 
    player.y = 100; // 
    add(player);
    
    // 7. Setup Trail
    trail = new FlxTrail(player, Sources.nothing, 5, 10, 0.6, 0.02);
    add(trail);

    // 8. Setup Goals (Corrected Level 2 Coordinates from Source)
    // The rainbowGoal is at x: 96, y: 192 
    rainbowGoal = new BAWGoal();
    rainbowGoal.x = 96;
    rainbowGoal.y = 192;
    add(rainbowGoal);
    
    // The blankGoal (Exit) is at x: 40, y: 192 
    blankGoal = new FlxSprite(40, 192, Sources.ImgBlankGoal);
		// add(blankGoal);

    // 9. Add Pause UI elements last
    add(pause);
    add(pause.textBlock);

    // 10. Camera and World Bounds setup 
    FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);
    FlxG.worldBounds.set(0, 0, map.width, map.width);
    FlxG.camera.follow(player);

    super.create();
}

    override public function update(elapsed:Float):Void
    {
        // Handle Pause Toggle
        if (FlxG.keys.justPressed.P) 
        {
            FlxGProxy.setPaused(!FlxGProxy.isPaused);
        }

        // Gate logic for paused state
        if (FlxGProxy.isPaused) 
        {
            pause.update(elapsed);
            return; 
        }

        background.animation.play("bla");
        
        FlxG.collide(player, map);

        // Use bitmask 0x1111 for 'ANY' side collision safety
        if (player.isTouching(0x1111)) 
        {
            FlxG.sound.play(Sources.Hitwall);
            player.x = 50;
            player.y = 100;
        }

        // Check for level completion
        if (FlxG.overlap(player, blankGoal)) 
        {
            LevelsCompleted.levels += 1;
            // Pointing back to Menu instead of Level 3
            FlxG.switchState(new Menu()); 
        }

        super.update(elapsed);
    }
}