package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class HowTo extends FlxState {
    private var returnButton:FlxButton;

    override public function create():Void {
        var background = new FlxSprite(0, 0, Sources.ImgBackgroundHowTo);
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