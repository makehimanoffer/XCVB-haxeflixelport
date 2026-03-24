package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		LevelsCompleted.load();
		// We strip all extra arguments.
		// In modded Flixel, Zoom and Framerate are usually handled
		// internally by the engine or the Project.xml settings.
		var gameWidth:Int = 640;
		var gameHeight:Int = 480;

		// Try with just the 3 core arguments
		addChild(new FlxGame(gameWidth, gameHeight, Menu));
	}
}