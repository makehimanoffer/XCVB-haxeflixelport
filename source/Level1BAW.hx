package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.math.FlxRect;
import flixel.tile.FlxTilemap;

class Level1BAW extends FlxState
{
    private var map:FlxTilemap;
    private var playSound:Bool = true;
    private var player:Player;
    private var rainbowGoal:BAWGoal;
    private var blankGoal:FlxSprite;
    public var pause:PauseScreen;
    private var background:FlxSprite;
    private var rules:Rules;
    private var trail:FlxTrail;

    override public function create():Void
    {
        // Setup Rules singleton [cite: 2]
        rules = Rules.getInstanceRules();

        // 1. Background Setup 
        background = new FlxSprite(0, 0);
        background.loadGraphic(Sources.ImgBGAnim, true, 640, 480);
        background.scrollFactor.set(0, 0); // Replaces scrollFactor.x/y = 0 
        background.animation.add("bla", [0, 1], 2, true);
        add(background);

        // 2. Tilemap Setup [cite: 5]
        map = new FlxTilemap();
        map.loadMapFromCSV(Sources.Level1BAWImg, Sources.MapBAW, 32, 32);
        add(map);

        // 3. Player & Trail [cite: 5, 7]
        player = new Player();
        player.x = 50;
        player.y = 100;
        
        trail = new FlxTrail(player, Sources.nothing, 5, 10, 0.6, 0.02);
        add(trail);
        add(player);

        // 4. Goals [cite: 6, 7]
        rainbowGoal = new BAWGoal(288, 160);
        add(rainbowGoal);
        
        blankGoal = new FlxSprite(288, 224, Sources.ImgBlankGoal);
        add(blankGoal);

        // 5. Camera & World 
        FlxG.worldBounds.set(0, 0, map.width, map.height);
        FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);
        FlxG.camera.follow(player);

        // 6. Pause UI 
        pause = new PauseScreen();
        FlxGProxy.paused = pause;
        FlxGProxy.paused.colorVal = 0xffffff;
        add(pause);
        add(pause.textBlock);

        super.create();
    }

    /**
     * Recreates the Emitter function from the original AS3 [cite: 8, 9, 10]
     */
    public function emitter(xOf:Float, yOf:Float, color:Int):Void
    {
        var emitter:FlxEmitter = new FlxEmitter(xOf, yOf);
        var particles:Int = 5;
        for (i in 0...particles)
        {
            var particle:FlxParticle = new FlxParticle();
            particle.makeGraphic(2, 2, color);
            particle.exists = false;
            emitter.add(particle);
        }
        add(emitter);
        emitter.start(true, 0.1, 5); // Explode mode
    }

    override public function update(elapsed:Float):Void
    {
        background.animation.play("bla");
        rules.update();
        
        if (FlxGProxy.isPaused) {
            pause.update(elapsed);
            return;
        }

        FlxG.collide(player, map);

        // Trail Logic 
        if (player.velocity.x != 0 || player.velocity.y != 0) {
            trail.changeGraphic(Sources.trailBAW);
        }

        // Wall Collision [cite: 11, 12]
        if (player.isTouching(0x1111)) {
            FlxG.sound.play(Sources.Hitwall);
            player.x = 50;
            player.y = 100;
            trail.changeGraphic(Sources.nothing);
        }

        // Rainbow Goal Interaction (Effect only) 
        if (FlxG.overlap(player, rainbowGoal)) {
            emitter(rainbowGoal.x, rainbowGoal.y, 0xffffffff);
            emitter(rainbowGoal.x + 5, rainbowGoal.y, 0xff000000);
            if (playSound) {
                FlxG.sound.play(Sources.Mp3PowerUp);
                playSound = false;
            }
        }

        // Blank Goal Interaction (Level Transition) [cite: 14]
        if (FlxG.overlap(player, blankGoal)) {
            LevelsCompleted.levels += 1;
            FlxG.switchState(new Level2BAW());
        }

        super.update(elapsed);
    }
}