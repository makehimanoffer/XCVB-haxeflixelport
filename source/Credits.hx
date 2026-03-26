package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class Credits extends FlxState {
    var returnButton:FlxButton;

    override public function create():Void {
		// 1. Load the sprite
		var background = new FlxSprite(0, 0, Sources.ImgCredits);
		// 2. Scale it to the current game width and height
		background.setGraphicSize(FlxG.width, FlxG.height);

		// 3. Update the internal "hitbox" so the center and offsets align
		background.updateHitbox();

		// 4. Ensure it is pinned to the top-left (0,0)
		background.antialiasing = true; // Optional: makes the scaling smoother
        
        add(background);

        returnButton = new FlxButton(FlxG.width / 2 - 150, FlxG.height - 160, "Menu", ret);
        add(returnButton);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        if (FlxG.keys.justPressed.SPACE) {
            FlxG.switchState(new Menu());
        }
        super.update(elapsed);
    }

    function ret():Void {
        FlxG.switchState(new Menu());
    }
}