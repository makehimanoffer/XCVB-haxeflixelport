package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class BaseLevel extends FlxState
{
	// Variables must be declared here for the class to "know" them
	public var map:FlxTilemap;
	public var player:Player;
	public var rainbowGoal:FlxSprite;
	public var blankGoal:FlxSprite;
	public var background:FlxSprite;
	public var trail:FlxTrail;
	public var emitterColors:Array<Int> = [0xFFFF0000, 0xFFFF6A00, 0xFFFFD800, 0xFF007F0E, 0xFF0026FF];

	// These are the classes causing the "not understood" error
	public var pause:PauseScreen;
	public var rules:Rules;

	// Configuration properties
	public var mapData:String;
	public var tileMapToUse:String;
	public var GoalToUse:String;
	public var playerStartX:Float = 50;
	public var playerStartY:Float = 100;
	public var playerSpeed:Float = 120;
	public var rainbowX:Float = 0;
	public var rainbowY:Float = 0;
	public var blankX:Float = 0;
	public var blankY:Float = 0;
	public var nextLevel:Class<FlxState>;

	// Logic Flags
	public var _colorWheel:Bool = false;

	private var _colorVal:Int = 0xFF000000;
	private var _playSound:Bool = true;
	private var _levelComplete:Bool = false;
	private var _isRotating:Bool = false;
	private var _rotateRight:Bool = true;
	private var _cameraMaxAngle:Float = 30;

	override public function create():Void
	{
		// Initialize the Rules singleton and PauseScreen instance
		rules = Rules.getInstanceRules();
		pause = new PauseScreen();

		// 1. Background setup
		background = new FlxSprite(0, 0);
		background.loadGraphic(Sources.ImgBGAnimRainbow, true, 640, 480);
		background.scrollFactor.set(0, 0);
		background.animation.add("bla", [0, 1], 2, true);
		background.animation.play("bla");
		add(background);

		// 2. Map setup
		map = new FlxTilemap();
		map.loadMapFromCSV(mapData, tileMapToUse, 32, 32);
		add(map);

		// 3. Player setup
		player = new Player(playerStartX, playerStartY);
		// player.Xspeed = playerSpeed;
		// player.Yspeed = playerSpeed;

		// 4. Trail setup (Using flixel-addons)
		trail = new FlxTrail(player, Sources.nothing, 5, 10, 0.6, 0.02);
		add(trail);
		add(player);

		// 5. Goal setup
		rainbowGoal = new FlxSprite(rainbowX, rainbowY, GoalToUse);
		add(rainbowGoal);

		blankGoal = new FlxSprite(blankX, blankY, Sources.ImgBlankGoal);
		// add(blankGoal);

		// 6. UI setup - Pause is added LAST so it stays on top
		add(pause);

		FlxG.camera.follow(player);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Now BaseLevel knows exactly what these are
		rules.update();
		pause.update(elapsed);
		if (_colorWheel)
		{
			// Cycle the color
			_colorVal += 0x00000001;
			if (_colorVal >= 0xFFFFFFFF)
				_colorVal = 0xFF000000;

			// Apply the cycling tint
			background.color = _colorVal;
		}
		else
		{
			// No tint (shows the original graphic colors)
			background.color = 0xFFFFFFFF;
		}
		// Collision & Trail Logic
		FlxG.collide(player, map);

		if (player.velocity.x != 0 || player.velocity.y != 0)
		{
			trail.loadGraphic(Sources.trailRainbow);
		}

		if (player.isTouching(0x1111))
		{
			FlxG.sound.play(Sources.Hitwall);
			player.setPosition(playerStartX, playerStartY);
			trail.loadGraphic(Sources.nothing);
		}

		// Camera Rotation (for Level 10+)
		if (_isRotating)
		{
			if (_rotateRight)
			{
				FlxG.camera.angle += 0.1;
				if (FlxG.camera.angle >= _cameraMaxAngle)
					_rotateRight = false;
			}
			else
			{
				FlxG.camera.angle -= 0.1;
				if (FlxG.camera.angle <= 0)
					_rotateRight = true;
			}
		}

		// Win Condition logic
		if (FlxG.overlap(player, rainbowGoal) && !_levelComplete)
		{
			_levelComplete = true;
			spawnRainbowBurst(rainbowGoal.x + 16, rainbowGoal.y + 16);
			if (_playSound)
			{
				FlxG.sound.play(Sources.Mp3PowerUp);
				_playSound = false;
			}
		}

		if (FlxG.overlap(player, blankGoal) && _levelComplete)
		{
			LevelsCompleted.levels += 1;
			FlxG.switchState(Type.createInstance(nextLevel, []));
		}
	}

	private function spawnRainbowBurst(X:Float, Y:Float):Void
	{
		// Force the compiler to see this as an Array of Integers
		var colors:Array<Int> = cast emitterColors;

		for (c in colors)
		{
			var emitter = new FlxEmitter(X, Y);
			for (i in 0...3)
			{
				var p = new FlxParticle();
				p.makeGraphic(2, 2, c);
				emitter.add(p);
			}
			add(emitter);
			emitter.start(true, 0.1, 0);
		}
	}
}
