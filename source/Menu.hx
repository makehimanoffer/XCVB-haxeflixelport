package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Menu extends FlxState
{
    private var rules:Rules;
    private var creditsButton:FlxButton;
    private var howToButton:FlxButton;
    private var background:FlxSprite;
    
    // Color wheel variables
    private var _colours:Array<FlxColor> = [];
    private var _colourNum:Int = 0;
    private var colorVal:Int = 0xff000000; // [cite: 16]

    override public function create():Void
    {
        // This hides the entire top-right debugger bar and bounding boxes
        FlxG.debugger.visible = false;
        FlxG.debugger.drawDebug = false;
        // DEBUG: Force the game to think we've beaten at least 20 levels
        LevelsCompleted.levels = 20;
        // Initialize Rules and reset pause state [cite: 16, 27]
        Rules.resetPause();
        rules = Rules.getInstanceRules();

        // 1. Setup Background [cite: 18]
        background = new FlxSprite(0, 0, Sources.ImgBackgroundBAndW);
        add(background);

        // 2. Mouse visibility [cite: 18]
        FlxG.mouse.visible = true;

        // 3. Title Text [cite: 19]
        var title:FlxText = new FlxText(0, 16, FlxG.width, "XCVB: Next Generation");
        title.setFormat(null, 30, 0xFFFFFFFF, "center");
        add(title);

        // 4. Instructions Text [cite: 20]
        var instructions:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width, "Space To Start\n");
        instructions.setFormat(null, 30, 0xFFFFFFFF, "center");
        add(instructions);

        // 5. Buttons 
        creditsButton = new FlxButton(20, 20, "Credits", goToCredits);
        // Positioned at 465 to match original AS3 source 
        howToButton = new FlxButton(20, 465, "How To", goToHowTo); 
        
        add(creditsButton);
        add(howToButton);

        // 6. Generate Color Wheel
        // Replaces the old photonstorm FlxColor.getHSVColorWheel() 
        for (i in 0...360) {
            _colours.push(FlxColor.fromHSB(i, 1, 1));
        }

        // 7. Start Menu Music [cite: 23]
        if (FlxG.sound.music == null || !FlxG.sound.music.active) {
            FlxG.sound.playMusic(Sources.MenuMusic, 1, true);
        }

        super.create();
    }

    public function goToCredits():Void {
        FlxG.switchState(new Credits()); // [cite: 23]
    }

    public function goToHowTo():Void {
        FlxG.switchState(new HowTo()); // [cite: 23]
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        rules.update(); // [cite: 25]

        // 8. Background Color Cycling 
        if (_colours.length > 0) {
            background.color = _colours[_colourNum];
            _colourNum++;
            
            if (_colourNum >= _colours.length) {
                _colourNum = 0;
            }
        }

        // 9. Start Game Input [cite: 26]
        if (FlxG.keys.justPressed.SPACE) {
            FlxG.switchState(new LevelSelectScreen());
        }
    }
}